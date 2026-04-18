using System;
using Avalonia.Media.Imaging;

namespace ekzam_avalonia.Models;

public class ServiceItem
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public int CollectionId { get; set; }
    public string CollectionName { get; set; } = string.Empty;
    public DateTime LastModifiedDate { get; set; }
    public string ImagePath { get; set; } = string.Empty;
    public Bitmap? ImageBitmap { get; set; }
    public string CardInfo => $"{Name}\nЦена: {Price:F2} руб.\nКоллекция: {CollectionName}\n{Description}";
}
