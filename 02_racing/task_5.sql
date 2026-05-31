-- Задача 5
-- Вывести автомобили с низкой средней позицией (средняя позиция больше 3.0),
-- а для их классов посчитать: общее количество гонок класса и количество
-- автомобилей класса с низкой средней позицией (от 3.0 и выше).
-- Вывести: имя, класс, среднюю позицию, количество гонок, страну класса,
-- общее количество гонок класса, количество "низких" автомобилей класса.
-- Отсортировать по количеству "низких" автомобилей класса по убыванию.

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
    SELECT car_class,
           SUM(race_count) AS total_races,
           COUNT(*) FILTER (WHERE average_position >= 3.0) AS low_position_count
    FROM car_stats
    GROUP BY car_class
)
SELECT cs.car_name,
       cs.car_class,
       ROUND(cs.average_position, 4) AS average_position,
       cs.race_count,
       cl.country AS car_country,
       st.total_races,
       st.low_position_count
FROM car_stats cs
JOIN class_stats st ON cs.car_class = st.car_class
JOIN Classes cl     ON cs.car_class = cl.class
WHERE cs.average_position > 3.0
ORDER BY st.low_position_count DESC, cs.car_class;
