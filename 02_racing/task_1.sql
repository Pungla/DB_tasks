-- Задача 1
-- Для каждого класса найти автомобиль(и) с наименьшей средней позицией в гонках.
-- Вывести: имя автомобиля, класс, среднюю позицию и количество гонок.
-- Отсортировать по средней позиции.

WITH car_stats AS (
    SELECT c.name  AS car_name,
           c.class AS car_class,
           AVG(r.position) AS average_position,
           COUNT(r.race)   AS race_count
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
ranked AS (
    SELECT car_name, car_class, average_position, race_count,
           RANK() OVER (PARTITION BY car_class ORDER BY average_position) AS rnk
    FROM car_stats
)
SELECT car_name,
       car_class,
       ROUND(average_position, 4) AS average_position,
       race_count
FROM ranked
WHERE rnk = 1
ORDER BY average_position, car_name;
