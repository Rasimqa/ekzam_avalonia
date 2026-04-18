using System;
using Npgsql;

namespace ekzam_avalonia.Services;

public static class DbConnectionFactory
{
    public static NpgsqlConnection CreateOpenConnection()
    {
        Exception? lastException = null;

        foreach (var connectionString in DbSettings.connectionStrings)
        {
            try
            {
                var connection = new NpgsqlConnection(connectionString);
                connection.Open();
                return connection;
            }
            catch (Exception ex)
            {
                lastException = ex;
            }
        }

        throw new InvalidOperationException("Не удалось подключиться к PostgreSQL.", lastException);
    }
}
