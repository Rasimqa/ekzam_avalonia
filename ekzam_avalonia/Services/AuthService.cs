using Npgsql;

namespace ekzam_avalonia.Services;

public class AuthService
{
    public bool TryLogin(string login, string password, out string displayName)
    {
        displayName = string.Empty;

        try
        {
            using var connection = DbConnectionFactory.CreateOpenConnection();
            const string sql = @"
SELECT COALESCE(full_name, login)
FROM users
WHERE login = @login AND password = @password
LIMIT 1;";

            using var command = new NpgsqlCommand(sql, connection);
            command.Parameters.AddWithValue("login", login);
            command.Parameters.AddWithValue("password", password);

            var result = command.ExecuteScalar();
            if (result == null)
            {
                return false;
            }

            displayName = result.ToString() ?? login;
            return true;
        }
        catch (PostgresException ex) when (ex.SqlState == "42P01")
        {
            // Фолбэк для учебного запуска, если таблицы users нет.
            if (login == "admin" && password == "admin")
            {
                displayName = "Администратор";
                return true;
            }

            return false;
        }
    }
}
