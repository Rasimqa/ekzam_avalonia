# Табель данных по всем таблицам программы

| Таблица | PK | Ключевые поля | Связь |
|---|---|---|---|
| `roles` | `id` | `name` | 1:M с `users` |
| `users` | `id` | `login`, `password`, `full_name`, `role_id`, `balance` | M:1 с `roles`; 1:M с отзывами/записями |
| `collections` | `id` | `name` | 1:M с `services` |
| `services` | `id` | `name`, `price`, `collection_id`, `last_modified_date` | M:1 с `collections` |
| `masters` | `id` | `user_id`, `qualification`, `hire_date` | 1:1 с `users` |
| `master_services` | `id` | `master_id`, `service_id` | M:1 с `masters`, M:1 с `services` |
| `appointments` | `id` | `user_id`, `service_id`, `master_id`, `appointment_date`, `status` | M:1 к `users/services/masters` |
| `balance_transactions` | `id` | `user_id`, `amount`, `description`, `transaction_date` | M:1 с `users` |
| `service_reviews` | `id` | `user_id`, `service_id`, `rating`, `comment` | M:1 с `users`, M:1 с `services` |
| `master_reviews` | `id` | `user_id`, `master_id`, `rating`, `comment` | M:1 с `users`, M:1 с `masters` |
| `qualification_requests` | `id` | `master_id`, `processed_by_moderator_id`, `status`, `request_date` | M:1 с `masters`, M:1 с `users` (модератор) |

## Минимальный набор записей

В файле `Docs/data-sheet.csv` подготовлены примерные записи по **всем таблицам**, достаточные для демонстрации связей и проверки функционала приложения.

