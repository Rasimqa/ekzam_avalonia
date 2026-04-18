INSERT INTO collections (name)
VALUES ('Кастом'),
       ('Косплей')
ON CONFLICT (name) DO NOTHING;

INSERT INTO services (name, price, collection_id, last_modified_date, image_path)
VALUES
('Худи Наруто', 3500, 1, CURRENT_TIMESTAMP, 'Assets/Images/pr1.png'),
('Худи Goat', 4300, 1, CURRENT_TIMESTAMP, 'Assets/Images/pr2.png'),
('Лонгслив FNAF', 2200, 1, CURRENT_TIMESTAMP, 'Assets/Images/pr3.png'),
('Худи Love', 3900, 1, CURRENT_TIMESTAMP, 'Assets/Images/pr4.png'),
('Худи Dark Art', 4200, 1, CURRENT_TIMESTAMP, 'Assets/Images/pr5.png'),
('Футболка Chihiro', 1800, 1, CURRENT_TIMESTAMP, 'Assets/Images/pr6.png'),
('Футболка Neon Girl', 1900, 1, CURRENT_TIMESTAMP, 'Assets/Images/pr7.png'),
('Лонгслив Biker', 2300, 1, CURRENT_TIMESTAMP, 'Assets/Images/pr8.png'),
('Футболка Star Wars', 1750, 1, CURRENT_TIMESTAMP, 'Assets/Images/pr9.png'),
('Футболка Shelby', 2100, 1, CURRENT_TIMESTAMP, 'Assets/Images/pr10.png'),
('Футболка Anime Duo', 1900, 1, CURRENT_TIMESTAMP, 'Assets/Images/pr11.png'),
('Рашгард Spider', 2400, 2, CURRENT_TIMESTAMP, 'Assets/Images/pr12.png'),
('Худи Акацуки', 3800, 2, CURRENT_TIMESTAMP, 'Assets/Images/kl1.png'),
('Футболка Blood Rune', 1600, 2, CURRENT_TIMESTAMP, 'Assets/Images/kl2.png'),
('Худи Samurai', 4100, 2, CURRENT_TIMESTAMP, 'Assets/Images/kl3.png'),
('Футболка Pirate', 1700, 2, CURRENT_TIMESTAMP, 'Assets/Images/kl4.png'),
('Худи Yin Yang', 3950, 2, CURRENT_TIMESTAMP, 'Assets/Images/kl5.png'),
('Футболка Spider Classic', 2000, 2, CURRENT_TIMESTAMP, 'Assets/Images/kl6.png'),
('Косплей комплект Premium', 5200, 2, CURRENT_TIMESTAMP, 'Assets/Images/kl7.png');
