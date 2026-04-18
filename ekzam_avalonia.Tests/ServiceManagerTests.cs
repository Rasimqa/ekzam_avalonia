using System;
using System.Collections.Generic;
using ekzam_avalonia.Models;
using ekzam_avalonia.Services;
using Xunit;

namespace ekzam_avalonia.Tests;

public class ServiceManagerTests
{
    [Fact]
    public void UpdateService_ChangesLastModifiedDate()
    {
        var fakeRepository = new FakeServiceRepository();
        var serviceManager = new ServiceManager(fakeRepository);
        var oldDate = new DateTime(2020, 1, 1, 10, 10, 10);
        var serviceItem = new ServiceItem
        {
            Id = 1,
            Name = "Тест",
            Price = 1000,
            CollectionId = 1,
            LastModifiedDate = oldDate,
            ImagePath = "Assets/Images/pr1.png"
        };

        serviceManager.UpdateService(serviceItem);

        Assert.NotEqual(oldDate, serviceItem.LastModifiedDate);
        Assert.True(serviceItem.LastModifiedDate > oldDate);
        Assert.Same(serviceItem, fakeRepository.LastUpdatedService);
    }

    private class FakeServiceRepository : IServiceRepository
    {
        public ServiceItem? LastUpdatedService { get; private set; }

        public List<CollectionItem> GetCollections() => [];
        public List<ServiceItem> GetServices(bool sortByName) => [];
        public void AddService(ServiceItem serviceItem) { }
        public void DeleteService(int serviceId) { }

        public void UpdateService(ServiceItem serviceItem)
        {
            LastUpdatedService = serviceItem;
        }
    }
}
