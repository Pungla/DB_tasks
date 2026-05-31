-- Задача 3
-- Найти класс(ы) с наименьшей средней позицией в гонках и вывести каждый автомобиль
-- из этих классов: имя, класс, среднюю позицию, количество гонок, страну класса,
-- а также общее количество гонок автомобилей данного класса.
-- Если несколько классов имеют одинаковую минимальную среднюю позицию, выбрать все.

WITH car_stats AS (
    SELECT c.name  AS car_name,
           c.class AS car_class,
           AVG(r.position) AS average_position,
           COUNT(r.race)   AS race_count
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
class_stats AS (
    SELECT c.class AS car_class,
           AVG(r.position) AS class_avg_position,
           COUNT(r.race)   AS total_races
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.class
),
min_classes AS (
    SELECT car_class, total_races
    FROM class_stats
    WHERE class_avg_position = (SELECT MIN(class_avg_position) FROM class_stats)
)
SELECT cs.car_name,
       cs.car_class,
       ROUND(cs.average_position, 4) AS average_position,
       cs.race_count,
       cl.country AS car_country,
       mc.total_races
FROM car_stats cs
JOIN min_classes mc ON cs.car_class = mc.car_class
JOIN Classes cl     ON cs.car_class = cl.class
ORDER BY cs.car_name;
