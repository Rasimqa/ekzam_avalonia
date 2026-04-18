namespace ekzam_avalonia.Services;

public static class DbSettings
{
    // Первый connection string - основной.
    // Второй - запасной, если у вас другая учебная БД.
    public static readonly string[] connectionStrings =
    [
        "Host=localhost;Port=5432;Database=exam_db;Username=postgres;Password=123",
        "Host=localhost;Port=5432;Database=mathe_shop;Username=postgres;Password=postgres"
    ];
}
