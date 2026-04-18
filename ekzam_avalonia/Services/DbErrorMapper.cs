using System;
using Npgsql;

namespace ekzam_avalonia.Services;

public static class DbErrorMapper
{
    public static string ToUserMessage(Exception ex)
    {
        if (ex is InvalidOperationException invalidOperationException && invalidOperationException.InnerException != null)
        {
            return ToUserMessage(invalidOperationException.InnerException);
        }

        if (ex is PostgresException postgresException)
        {
            return postgresException.SqlState switch
            {
                "28P01" => "Ошибка авторизации PostgreSQL. Проверьте логин и пароль в DbSettings.",
                "3D000" => "База данных не найдена. Проверьте имя базы в DbSettings.",
                "42P01" => "Таблица не найдена. Выполните SQL-скрипты из папки Sql.",
                "42703" => "Ошибка структуры БД: отсутствует один из ожидаемых столбцов в таблице services.",
                _ => "Ошибка PostgreSQL: " + postgresException.SqlState
            };
        }

        if (ex is NpgsqlException)
        {
            return "Нет подключения к PostgreSQL. Проверьте, что сервер запущен.";
        }

        return "Ошибка: " + ex.Message;
    }
}
