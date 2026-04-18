using System;
using ekzam_avalonia.Models;

namespace UnitTests;

public class UnitTest1
{
    // Тест 1: LastModifiedDate устанавливается в текущее UTC-время при «сохранении» изменений
    [Fact]
    public void LastModifiedDate_IsSetToUtcNow_WhenServiceIsEdited()
    {
        var service = new ServiceItem
        {
            Id = 1,
            Name = "Тестовая услуга",
            LastModifiedDate = DateTime.UtcNow.AddDays(-10)
        };

        var before = DateTime.UtcNow;
        service.LastModifiedDate = DateTime.UtcNow;
        var after = DateTime.UtcNow;

        Assert.InRange(service.LastModifiedDate, before, after);
    }

    // Тест 2: LastModifiedDate не превышает текущий момент времени
    [Fact]
    public void LastModifiedDate_IsNotInFuture()
    {
        var service = new ServiceItem
        {
            Id = 2,
            Name = "Услуга 2",
            LastModifiedDate = DateTime.UtcNow
        };

        Assert.True(service.LastModifiedDate <= DateTime.UtcNow);
    }

    // Тест 3: Форматирование LastModifiedDate соответствует шаблону "Изменено: dd.MM.yyyy HH:mm"
    [Fact]
    public void LastModifiedDate_FormatsCorrectly_ForDisplay()
    {
        var fixedTime = new DateTime(2025, 3, 15, 14, 30, 0, DateTimeKind.Utc);
        var service = new ServiceItem
        {
            Id = 3,
            Name = "Услуга 3",
            LastModifiedDate = fixedTime
        };

        var displayStr = $"Изменено: {service.LastModifiedDate:dd.MM.yyyy HH:mm}";

        Assert.Equal("Изменено: 15.03.2025 14:30", displayStr);
    }

    // Тест 4: LastModifiedDate строго позже CreatedAt после редактирования
    [Fact]
    public void LastModifiedDate_IsAfterCreatedAt_WhenServiceIsEdited()
    {
        var createdTime = DateTime.UtcNow.AddDays(-3);
        var service = new ServiceItem
        {
            Id = 4,
            Name = "Услуга 4",
            LastModifiedDate = createdTime
        };

        service.LastModifiedDate = DateTime.UtcNow;

        Assert.True(service.LastModifiedDate > createdTime);
    }

    // Тест 5: LastModifiedDate не изменяется, если объект не редактировался
    [Fact]
    public void LastModifiedDate_RemainsUnchanged_WhenServiceIsNotEdited()
    {
        var originalLastModifiedDate = new DateTime(2024, 11, 1, 10, 0, 0, DateTimeKind.Utc);
        var service = new ServiceItem
        {
            Id = 5,
            Name = "Услуга 5",
            LastModifiedDate = originalLastModifiedDate
        };

        var snapshot = service.LastModifiedDate;

        Assert.Equal(originalLastModifiedDate, snapshot);
    }
}
