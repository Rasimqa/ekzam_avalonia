using System;
using ekzam_avalonia.Models;

namespace ekzam_avalonia.Services;

public class ServiceManager
{
    private readonly IServiceRepository serviceRepository;

    public ServiceManager(IServiceRepository serviceRepository)
    {
        this.serviceRepository = serviceRepository;
    }

    public void AddService(ServiceItem serviceItem)
    {
        serviceItem.LastModifiedDate = DateTime.Now;
        serviceRepository.AddService(serviceItem);
    }

    public void UpdateService(ServiceItem serviceItem)
    {
        serviceItem.LastModifiedDate = DateTime.Now;
        serviceRepository.UpdateService(serviceItem);
    }

    public void DeleteService(int serviceId)
    {
        serviceRepository.DeleteService(serviceId);
    }
}
