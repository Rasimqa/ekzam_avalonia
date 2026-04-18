using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Avalonia;
using Avalonia.Controls;
using Avalonia.Controls.ApplicationLifetimes;
using Avalonia.Input;
using Avalonia.Interactivity;
using Avalonia.Media.Imaging;
using Avalonia.Platform;
using ekzam_avalonia.Models;
using ekzam_avalonia.Services;

namespace ekzam_avalonia.Views;

public partial class MainWindow : Window
{
    private static readonly string[] customImagePool =
    [
        "Assets/Images/pr1.png", "Assets/Images/pr2.png", "Assets/Images/pr3.png", "Assets/Images/pr4.png",
        "Assets/Images/pr5.png", "Assets/Images/pr6.png", "Assets/Images/pr7.png", "Assets/Images/pr8.png",
        "Assets/Images/pr9.png", "Assets/Images/pr10.png", "Assets/Images/pr11.png", "Assets/Images/pr12.png"
    ];

    private static readonly string[] cosplayImagePool =
    [
        "Assets/Images/kl1.png", "Assets/Images/kl2.png", "Assets/Images/kl3.png", "Assets/Images/kl4.png",
        "Assets/Images/kl5.png", "Assets/Images/kl6.png", "Assets/Images/kl7.png"
    ];

    private readonly IServiceRepository serviceRepository;
    private readonly ServiceManager serviceManager;
    private readonly List<ServiceItem> allServicesByDb;
    private List<ServiceItem> filteredServices;
    private readonly int pageSize;
    private int currentPage;
    private bool sortByName;
    private string activeCategory;
    private bool allowRealClose;
    private bool isUpdatingCollectionFilter;

    public MainWindow()
        : this("Пользователь")
    {
    }

    public MainWindow(string userName)
    {
        InitializeComponent();

        serviceRepository = new ServiceRepository();
        serviceManager = new ServiceManager(serviceRepository);
        allServicesByDb = [];
        filteredServices = [];
        pageSize = 3;
        currentPage = 1;
        sortByName = false;
        activeCategory = "all";

        titleTextBlock.Text = $"Лавка «Матье» - {userName}";
        Icon = LoadWindowIcon();
        Closing += OnClosing;
        InitCollectionFilter();
        LoadServices();
    }

    private WindowIcon? LoadWindowIcon()
    {
        const string iconPath = "avares://ekzam_avalonia/Assets/Images/logo.png";
        if (!AssetLoader.Exists(new Uri(iconPath)))
        {
            return null;
        }

        using var stream = AssetLoader.Open(new Uri(iconPath));
        using var memoryStream = new MemoryStream();
        stream.CopyTo(memoryStream);
        memoryStream.Position = 0;
        return new WindowIcon(memoryStream);
    }

    private void LoadServices()
    {
        try
        {
            allServicesByDb.Clear();
            allServicesByDb.AddRange(serviceRepository.GetServices(sortByName));
            NormalizeServiceImages(allServicesByDb);
            currentPage = 1;
            RefreshCollectionFilter();
            ApplyFilters();
            statusTextBlock.Text = $"Загружено услуг: {allServicesByDb.Count}";
        }
        catch (Exception ex)
        {
            statusTextBlock.Text = DbErrorMapper.ToUserMessage(ex);
            servicesListBox.ItemsSource = new List<ServiceItem>();
            pageTextBlock.Text = "0 из 0";
        }
    }

    private void InitCollectionFilter()
    {
        collectionFilterComboBox.ItemsSource = new List<string> { "Все" };
        collectionFilterComboBox.SelectedIndex = 0;
    }

    private void RefreshCollectionFilter()
    {
        var selectedBefore = collectionFilterComboBox.SelectedItem as string ?? "Все";
        var items = new List<string> { "Все" };
        items.AddRange(allServicesByDb
            .Select(x => x.CollectionName)
            .Distinct(StringComparer.OrdinalIgnoreCase)
            .OrderBy(x => x));

        isUpdatingCollectionFilter = true;
        collectionFilterComboBox.ItemsSource = items;
        if (items.Contains(selectedBefore))
        {
            collectionFilterComboBox.SelectedItem = selectedBefore;
        }
        else
        {
            collectionFilterComboBox.SelectedIndex = 0;
        }
        isUpdatingCollectionFilter = false;
    }

    private void ApplyFilters()
    {
        var searchText = searchTextBox.Text?.Trim() ?? string.Empty;
        var selectedCollection = collectionFilterComboBox.SelectedItem as string ?? "Все";

        var query = allServicesByDb.AsEnumerable();

        if (activeCategory == "custom")
        {
            query = query.Where(x => !IsCosplayByName(x.Name));
        }
        else if (activeCategory == "cosplay")
        {
            query = query.Where(x => IsCosplayByName(x.Name));
        }

        if (!string.IsNullOrWhiteSpace(searchText))
        {
            query = query.Where(x => x.Name.Contains(searchText, StringComparison.OrdinalIgnoreCase));
        }

        if (!string.Equals(selectedCollection, "Все", StringComparison.OrdinalIgnoreCase))
        {
            query = query.Where(x => string.Equals(x.CollectionName, selectedCollection, StringComparison.OrdinalIgnoreCase));
        }

        filteredServices = query.ToList();
        ApplyPagination();
    }

    private void ApplyPagination()
    {
        if (filteredServices.Count == 0)
        {
            servicesListBox.ItemsSource = new List<ServiceItem>();
            pageTextBlock.Text = "0 из 0";
            prevButton.IsEnabled = false;
            nextButton.IsEnabled = false;
            return;
        }

        var totalPages = (int)Math.Ceiling(filteredServices.Count / (double)pageSize);
        if (currentPage > totalPages)
        {
            currentPage = totalPages;
        }

        var pageItems = filteredServices
            .Skip((currentPage - 1) * pageSize)
            .Take(pageSize)
            .ToList();

        // Конвертируем относительный путь картинки в avares-ссылку для карточек.
        foreach (var pageItem in pageItems)
        {
            if (!string.IsNullOrWhiteSpace(pageItem.ImagePath) &&
                !pageItem.ImagePath.StartsWith("avares://", StringComparison.OrdinalIgnoreCase))
            {
                var normalizedPath = pageItem.ImagePath.Replace("\\", "/").TrimStart('/');
                pageItem.ImagePath = $"avares://ekzam_avalonia/{normalizedPath}";
            }
        }

        servicesListBox.ItemsSource = pageItems;
        pageTextBlock.Text = $"{currentPage} из {totalPages}";
        prevButton.IsEnabled = currentPage > 1;
        nextButton.IsEnabled = currentPage < totalPages;
    }

    private async void AddClick(object? sender, RoutedEventArgs e)
    {
        try
        {
            var dialog = new ServiceEditWindow(serviceRepository.GetCollections(), null);
            var isSaved = await dialog.ShowDialog<bool>(this);
            if (!isSaved)
            {
                return;
            }

            serviceManager.AddService(dialog.ServiceItem);
            LoadServices();
        }
        catch (Exception ex)
        {
            statusTextBlock.Text = DbErrorMapper.ToUserMessage(ex);
        }
    }

    private async void EditClick(object? sender, RoutedEventArgs e)
    {
        if (servicesListBox.SelectedItem is not ServiceItem selectedItem)
        {
            statusTextBlock.Text = "Сначала выберите услугу.";
            return;
        }

        var editableItem = new ServiceItem
        {
            Id = selectedItem.Id,
            Name = selectedItem.Name,
            Description = selectedItem.Description,
            Price = selectedItem.Price,
            CollectionId = selectedItem.CollectionId,
            CollectionName = selectedItem.CollectionName,
            LastModifiedDate = selectedItem.LastModifiedDate,
            ImagePath = selectedItem.ImagePath.Replace("avares://ekzam_avalonia/", string.Empty).TrimStart('/')
        };

        try
        {
            var dialog = new ServiceEditWindow(serviceRepository.GetCollections(), editableItem);
            var isSaved = await dialog.ShowDialog<bool>(this);
            if (!isSaved)
            {
                return;
            }

            serviceManager.UpdateService(dialog.ServiceItem);
            LoadServices();
        }
        catch (Exception ex)
        {
            statusTextBlock.Text = DbErrorMapper.ToUserMessage(ex);
        }
    }

    private async void DeleteClick(object? sender, RoutedEventArgs e)
    {
        if (servicesListBox.SelectedItem is not ServiceItem selectedItem)
        {
            statusTextBlock.Text = "Сначала выберите услугу для удаления.";
            return;
        }

        var confirmResult = await ShowDeleteConfirmDialog(selectedItem.Name);
        if (!confirmResult)
        {
            return;
        }

        try
        {
            serviceManager.DeleteService(selectedItem.Id);
            LoadServices();
            statusTextBlock.Text = "Услуга удалена.";
        }
        catch (Exception ex)
        {
            statusTextBlock.Text = DbErrorMapper.ToUserMessage(ex);
        }
    }

    private void SortClick(object? sender, RoutedEventArgs e)
    {
        try
        {
            sortByName = !sortByName;
            currentPage = 1;
            LoadServices();
        }
        catch (Exception ex)
        {
            statusTextBlock.Text = DbErrorMapper.ToUserMessage(ex);
        }
    }

    private void PrevPageClick(object? sender, RoutedEventArgs e)
    {
        if (currentPage <= 1)
        {
            return;
        }

        currentPage--;
        ApplyPagination();
    }

    private void NextPageClick(object? sender, RoutedEventArgs e)
    {
        var totalPages = (int)Math.Ceiling(filteredServices.Count / (double)pageSize);
        if (currentPage >= totalPages)
        {
            return;
        }

        currentPage++;
        ApplyPagination();
    }

    private void SearchTextChanged(object? sender, Avalonia.Controls.TextChangedEventArgs e)
    {
        currentPage = 1;
        ApplyFilters();
    }

    private void CollectionFilterChanged(object? sender, SelectionChangedEventArgs e)
    {
        if (isUpdatingCollectionFilter)
        {
            return;
        }

        currentPage = 1;
        ApplyFilters();
    }

    private void CustomFilterClick(object? sender, RoutedEventArgs e)
    {
        activeCategory = "custom";
        currentPage = 1;
        ApplyFilters();
    }

    private void CosplayFilterClick(object? sender, RoutedEventArgs e)
    {
        activeCategory = "cosplay";
        currentPage = 1;
        ApplyFilters();
    }

    private void AllFilterClick(object? sender, RoutedEventArgs e)
    {
        activeCategory = "all";
        currentPage = 1;
        ApplyFilters();
    }

    private static bool IsCosplayByName(string serviceName)
    {
        return serviceName.Contains("косплей", StringComparison.OrdinalIgnoreCase);
    }

    private static void NormalizeServiceImages(List<ServiceItem> services)
    {
        for (var index = 0; index < services.Count; index++)
        {
            var service = services[index];
            if (!string.IsNullOrWhiteSpace(service.ImagePath) &&
                service.ImagePath.StartsWith("avares://", StringComparison.OrdinalIgnoreCase))
            {
                continue;
            }

            if (!string.IsNullOrWhiteSpace(service.ImagePath))
            {
                var normalizedPath = service.ImagePath.Replace("\\", "/").TrimStart('/');
                var normalized = $"avares://ekzam_avalonia/{normalizedPath}";
                if (AssetLoader.Exists(new Uri(normalized)))
                {
                    service.ImagePath = normalized;
                    service.ImageBitmap = LoadBitmap(normalized);
                    continue;
                }

                // Поддержка случаев, когда в БД хранится абсолютный путь до файла.
                if (File.Exists(service.ImagePath))
                {
                    service.ImageBitmap = LoadBitmap(service.ImagePath);
                    continue;
                }
            }

            var pool = IsCosplayByName(service.Name) ? cosplayImagePool : customImagePool;
            var fallback = pool[index % pool.Length];
            service.ImagePath = $"avares://ekzam_avalonia/{fallback}";
            service.ImageBitmap = LoadBitmap(service.ImagePath);
        }
    }

    private static Bitmap? LoadBitmap(string path)
    {
        try
        {
            if (path.StartsWith("avares://", StringComparison.OrdinalIgnoreCase))
            {
                var uri = new Uri(path);
                if (!AssetLoader.Exists(uri))
                {
                    return null;
                }

                using var stream = AssetLoader.Open(uri);
                return new Bitmap(stream);
            }

            if (File.Exists(path))
            {
                using var fileStream = File.OpenRead(path);
                return new Bitmap(fileStream);
            }
        }
        catch
        {
            // Фоновая загрузка изображения не должна ломать вывод списка.
        }

        return null;
    }

    private void LogoutClick(object? sender, RoutedEventArgs e)
    {
        allowRealClose = true;
        var loginWindow = new LoginWindow();
        if (Application.Current?.ApplicationLifetime is IClassicDesktopStyleApplicationLifetime desktop)
        {
            desktop.MainWindow = loginWindow;
        }

        loginWindow.Show();
        Close();
    }

    private void MinimizeClick(object? sender, RoutedEventArgs e)
    {
        WindowState = WindowState.Minimized;
    }

    private void CloseClick(object? sender, RoutedEventArgs e)
    {
        Close();
    }

    private void TitleBarPointerPressed(object? sender, PointerPressedEventArgs e)
    {
        BeginMoveDrag(e);
    }

    private async void OnClosing(object? sender, WindowClosingEventArgs e)
    {
        if (allowRealClose)
        {
            return;
        }

        e.Cancel = true;
        var result = await ShowCloseDialog();
        if (result == true)
        {
            allowRealClose = true;
            Close();
        }
    }

    private async System.Threading.Tasks.Task<bool?> ShowCloseDialog()
    {
        var dialog = new Window
        {
            Width = 340,
            Height = 160,
            WindowStartupLocation = WindowStartupLocation.CenterOwner,
            CanResize = false,
            Title = "Подтверждение"
        };

        var textBlock = new TextBlock
        {
            Text = "Вы уверены, что хотите закрыть приложение?",
            Margin = new Avalonia.Thickness(12)
        };

        var yesButton = new Button { Content = "Да", Width = 90 };
        var noButton = new Button { Content = "Нет", Width = 90, Margin = new Avalonia.Thickness(8, 0, 0, 0) };
        bool? result = null;

        yesButton.Click += (_, _) =>
        {
            result = true;
            dialog.Close();
        };

        noButton.Click += (_, _) =>
        {
            result = false;
            dialog.Close();
        };

        dialog.Content = new StackPanel
        {
            Margin = new Avalonia.Thickness(8),
            Children =
            {
                textBlock,
                new StackPanel
                {
                    Orientation = Avalonia.Layout.Orientation.Horizontal,
                    HorizontalAlignment = Avalonia.Layout.HorizontalAlignment.Right,
                    Children = { yesButton, noButton }
                }
            }
        };

        await dialog.ShowDialog(this);
        return result;
    }

    private async System.Threading.Tasks.Task<bool> ShowDeleteConfirmDialog(string serviceName)
    {
        var dialog = new Window
        {
            Width = 420,
            Height = 170,
            WindowStartupLocation = WindowStartupLocation.CenterOwner,
            CanResize = false,
            Title = "Удаление"
        };

        var message = new TextBlock
        {
            Text = $"Удалить услугу \"{serviceName}\"?",
            Margin = new Thickness(12),
            TextWrapping = Avalonia.Media.TextWrapping.Wrap
        };

        var deleteButton = new Button { Content = "Удалить", Width = 100 };
        var cancelButton = new Button { Content = "Отмена", Width = 100, Margin = new Thickness(8, 0, 0, 0) };
        var result = false;

        deleteButton.Click += (_, _) =>
        {
            result = true;
            dialog.Close();
        };
        cancelButton.Click += (_, _) => dialog.Close();

        dialog.Content = new StackPanel
        {
            Margin = new Thickness(8),
            Children =
            {
                message,
                new StackPanel
                {
                    Orientation = Avalonia.Layout.Orientation.Horizontal,
                    HorizontalAlignment = Avalonia.Layout.HorizontalAlignment.Right,
                    Children = { deleteButton, cancelButton }
                }
            }
        };

        await dialog.ShowDialog(this);
        return result;
    }
}
