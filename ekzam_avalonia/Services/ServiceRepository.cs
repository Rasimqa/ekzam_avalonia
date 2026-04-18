using System.Collections.Generic;
using System.Linq;
using ekzam_avalonia.Models;
using Npgsql;

namespace ekzam_avalonia.Services;

public class ServiceRepository : IServiceRepository
{
    public ServiceRepository()
    {
    }

    public List<CollectionItem> GetCollections()
    {
        var result = new List<CollectionItem>();
        const string sql = "SELECT id, name FROM collections ORDER BY name;";

        using var connection = DbConnectionFactory.CreateOpenConnection();

        using var command = new NpgsqlCommand(sql, connection);
        using var reader = command.ExecuteReader();
        while (reader.Read())
        {
            result.Add(new CollectionItem
            {
                Id = reader.GetInt32(0),
                Name = reader.GetString(1)
            });
        }

        return result;
    }

    public List<ServiceItem> GetServices(bool sortByName)
    {
        var result = new List<ServiceItem>();
        using var connection = DbConnectionFactory.CreateOpenConnection();
        var availableColumns = GetServiceColumns(connection);

        var hasDescription = availableColumns.Contains("description");
        var hasImagePath = availableColumns.Contains("image_path");
        var hasLastModifiedDate = availableColumns.Contains("last_modified_date");
        var orderBy = sortByName ? "s.name ASC" : "s.id ASC";
        var sql = $@"
SELECT s.id,
       s.name,
       {(hasDescription ? "COALESCE(s.description, '')" : "''")} AS description,
       s.price,
       s.collection_id,
       COALESCE(c.name, '-') AS collection_name,
       {(hasLastModifiedDate ? "s.last_modified_date" : "CURRENT_TIMESTAMP")} AS last_modified_date,
       {(hasImagePath ? "COALESCE(s.image_path, '')" : "''")} AS image_path
FROM services s
LEFT JOIN collections c ON c.id = s.collection_id
ORDER BY {orderBy};";

        using var command = new NpgsqlCommand(sql, connection);
        using var reader = command.ExecuteReader();
        while (reader.Read())
        {
            result.Add(new ServiceItem
            {
                Id = reader.GetInt32(0),
                Name = reader.GetString(1),
                Description = reader.IsDBNull(2) ? string.Empty : reader.GetString(2),
                Price = reader.GetDecimal(3),
                CollectionId = reader.GetInt32(4),
                CollectionName = reader.GetString(5),
                LastModifiedDate = reader.GetDateTime(6),
                ImagePath = reader.IsDBNull(7) ? string.Empty : reader.GetString(7)
            });
        }

        return result;
    }

    public void AddService(ServiceItem serviceItem)
    {
        using var connection = DbConnectionFactory.CreateOpenConnection();
        var availableColumns = GetServiceColumns(connection);
        var columns = new List<string> { "name", "price", "collection_id" };
        var values = new List<string> { "@name", "@price", "@collectionId" };

        if (availableColumns.Contains("description"))
        {
            columns.Add("description");
            values.Add("@description");
        }

        if (availableColumns.Contains("last_modified_date"))
        {
            columns.Add("last_modified_date");
            values.Add("@lastModifiedDate");
        }

        if (availableColumns.Contains("image_path"))
        {
            columns.Add("image_path");
            values.Add("@imagePath");
        }

        var sql = $@"
INSERT INTO services ({string.Join(", ", columns)})
VALUES ({string.Join(", ", values)});";

        using var command = new NpgsqlCommand(sql, connection);
        command.Parameters.AddWithValue("name", serviceItem.Name);
        command.Parameters.AddWithValue("price", serviceItem.Price);
        command.Parameters.AddWithValue("collectionId", serviceItem.CollectionId);
        command.Parameters.AddWithValue("description", serviceItem.Description);
        command.Parameters.AddWithValue("lastModifiedDate", serviceItem.LastModifiedDate);
        command.Parameters.AddWithValue("imagePath", serviceItem.ImagePath);
        command.ExecuteNonQuery();
    }

    public void UpdateService(ServiceItem serviceItem)
    {
        using var connection = DbConnectionFactory.CreateOpenConnection();
        var availableColumns = GetServiceColumns(connection);
        var sets = new List<string>
        {
            "name = @name",
            "price = @price",
            "collection_id = @collectionId"
        };

        if (availableColumns.Contains("description"))
        {
            sets.Add("description = @description");
        }

        if (availableColumns.Contains("last_modified_date"))
        {
            sets.Add("last_modified_date = @lastModifiedDate");
        }

        if (availableColumns.Contains("image_path"))
        {
            sets.Add("image_path = @imagePath");
        }

        var sql = $@"
UPDATE services
SET {string.Join(", ", sets)}
WHERE id = @id;";

        using var command = new NpgsqlCommand(sql, connection);
        command.Parameters.AddWithValue("id", serviceItem.Id);
        command.Parameters.AddWithValue("name", serviceItem.Name);
        command.Parameters.AddWithValue("price", serviceItem.Price);
        command.Parameters.AddWithValue("collectionId", serviceItem.CollectionId);
        command.Parameters.AddWithValue("description", serviceItem.Description);
        command.Parameters.AddWithValue("lastModifiedDate", serviceItem.LastModifiedDate);
        command.Parameters.AddWithValue("imagePath", serviceItem.ImagePath);
        command.ExecuteNonQuery();
    }

    public void DeleteService(int serviceId)
    {
        const string sql = "DELETE FROM services WHERE id = @id;";
        using var connection = DbConnectionFactory.CreateOpenConnection();
        using var command = new NpgsqlCommand(sql, connection);
        command.Parameters.AddWithValue("id", serviceId);
        command.ExecuteNonQuery();
    }

    private HashSet<string> GetServiceColumns(NpgsqlConnection connection)
    {
        const string sql = @"
SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'services';";

        var result = new HashSet<string>();
        using var command = new NpgsqlCommand(sql, connection);
        using var reader = command.ExecuteReader();
        while (reader.Read())
        {
            result.Add(reader.GetString(0));
        }

        return result;
    }
}
