using System.Collections.Generic;
using System.Globalization;
using Avalonia.Controls;
using Avalonia.Interactivity;
using ekzam_avalonia.Models;

namespace ekzam_avalonia.Views;

public partial class ServiceEditWindow : Window
{
    private readonly List<CollectionItem> collections;
    public ServiceItem ServiceItem { get; }

    public ServiceEditWindow()
        : this([], null)
    {
    }

    public ServiceEditWindow(List<CollectionItem> collections, ServiceItem? serviceItem)
    {
        InitializeComponent();

        this.collections = collections;
        ServiceItem = serviceItem ?? new ServiceItem();

        collectionComboBox.ItemsSource = this.collections;
        imageComboBox.ItemsSource = BuildImageList();

        if (serviceItem != null)
        {
            nameTextBox.Text = serviceItem.Name;
            priceTextBox.Text = serviceItem.Price.ToString("F2", CultureInfo.InvariantCulture);
            collectionComboBox.SelectedItem = this.collections.Find(x => x.Id == serviceItem.CollectionId);
            imageComboBox.SelectedItem = serviceItem.ImagePath;
            Title = "Редактирование услуги";
        }
        else
        {
            if (this.collections.Count > 0)
            {
                collectionComboBox.SelectedIndex = 0;
            }

            imageComboBox.SelectedIndex = 0;
            Title = "Добавление услуги";
        }
    }

    private List<string> BuildImageList()
    {
        return
        [
            "Assets/Images/pr1.png", "Assets/Images/pr2.png", "Assets/Images/pr3.png",
            "Assets/Images/pr4.png", "Assets/Images/pr5.png", "Assets/Images/pr6.png",
            "Assets/Images/pr7.png", "Assets/Images/pr8.png", "Assets/Images/pr9.png",
            "Assets/Images/pr10.png", "Assets/Images/pr11.png", "Assets/Images/pr12.png",
            "Assets/Images/kl1.png", "Assets/Images/kl2.png", "Assets/Images/kl3.png",
            "Assets/Images/kl4.png", "Assets/Images/kl5.png", "Assets/Images/kl6.png", "Assets/Images/kl7.png"
        ];
    }

    private void SaveClick(object? sender, RoutedEventArgs e)
    {
        if (string.IsNullOrWhiteSpace(nameTextBox.Text))
        {
            ShowValidationError("Введите название услуги.");
            return;
        }

        if (!decimal.TryParse(priceTextBox.Text, CultureInfo.InvariantCulture, out var parsedPrice) &&
            !decimal.TryParse(priceTextBox.Text, out parsedPrice))
        {
            ShowValidationError("Введите корректную цену.");
            return;
        }

        if (collectionComboBox.SelectedItem is not CollectionItem selectedCollection)
        {
            ShowValidationError("Выберите коллекцию.");
            return;
        }

        if (imageComboBox.SelectedItem is not string selectedImagePath)
        {
            ShowValidationError("Выберите изображение.");
            return;
        }

        ServiceItem.Name = nameTextBox.Text.Trim();
        ServiceItem.Price = parsedPrice;
        ServiceItem.CollectionId = selectedCollection.Id;
        ServiceItem.CollectionName = selectedCollection.Name;
        ServiceItem.ImagePath = selectedImagePath;

        Close(true);
    }

    private void CancelClick(object? sender, RoutedEventArgs e)
    {
        Close(false);
    }

    private async void ShowValidationError(string message)
    {
        var dialog = new Window
        {
            Width = 320,
            Height = 140,
            WindowStartupLocation = WindowStartupLocation.CenterOwner,
            CanResize = false,
            Title = "Ошибка"
        };

        var okButton = new Button { Content = "Ок", Width = 90 };
        okButton.Click += (_, _) => dialog.Close();
        dialog.Content = new StackPanel
        {
            Margin = new Avalonia.Thickness(12),
            Children =
            {
                new TextBlock { Text = message },
                new StackPanel
                {
                    Margin = new Avalonia.Thickness(0, 16, 0, 0),
                    HorizontalAlignment = Avalonia.Layout.HorizontalAlignment.Right,
                    Children = { okButton }
                }
            }
        };

        await dialog.ShowDialog(this);
    }
}
