using System.Collections.Generic;
using ekzam_avalonia.Models;

namespace ekzam_avalonia.Services;

public interface IServiceRepository
{
    List<CollectionItem> GetCollections();
    List<ServiceItem> GetServices(bool sortByName);
    void AddService(ServiceItem serviceItem);
    void UpdateService(ServiceItem serviceItem);
    void DeleteService(int serviceId);
}
