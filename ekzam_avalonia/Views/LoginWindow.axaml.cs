using System;
using Avalonia;
using Avalonia.Controls;
using Avalonia.Controls.ApplicationLifetimes;
using Avalonia.Input;
using Avalonia.Interactivity;
using ekzam_avalonia.Services;

namespace ekzam_avalonia.Views;

public partial class LoginWindow : Window
{
    private readonly AuthService authService;

    public LoginWindow()
    {
        InitializeComponent();
        authService = new AuthService();
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

    private void LoginClick(object? sender, RoutedEventArgs e)
    {
        var login = loginTextBox.Text?.Trim() ?? string.Empty;
        var password = passwordTextBox.Text ?? string.Empty;

        if (string.IsNullOrWhiteSpace(login) || string.IsNullOrWhiteSpace(password))
        {
            messageTextBlock.Text = "Введите логин и пароль.";
            return;
        }

        try
        {
            var isSuccess = authService.TryLogin(login, password, out var displayName);
            if (!isSuccess)
            {
                messageTextBlock.Text = "Неверный логин или пароль.";
                return;
            }

            var mainWindow = new MainWindow(displayName);
            if (Application.Current?.ApplicationLifetime is IClassicDesktopStyleApplicationLifetime desktop)
            {
                desktop.MainWindow = mainWindow;
            }

            mainWindow.Show();
            Close();
        }
        catch (Exception ex)
        {
            messageTextBlock.Text = DbErrorMapper.ToUserMessage(ex);
        }
    }
}
