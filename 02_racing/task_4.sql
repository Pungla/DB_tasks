-- Задача 4
-- Найти автомобили, у которых средняя позиция лучше (меньше) средней позиции
-- всех автомобилей своего класса. В классе должно быть минимум два автомобиля.
-- Вывести: имя, класс, среднюю позицию, количество гонок, страну класса.
-- Отсортировать по классу, затем по средней позиции по возрастанию.

WITH car_stats AS (
    SELECT c.name  AS car_name,
           c.class AS car_class,
           AVG(r.position) AS average_position,
           COUNT(r.race)   AS race_count
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
class_avg AS (
    SELECT car_class,
           AVG(average_position) AS class_average,
           COUNT(*)              AS cars_in_class
    FROM car_stats
    GROUP BY car_class
)
SELECT cs.car_name,
       cs.car_class,
       ROUND(cs.average_position, 4) AS average_position,
       cs.race_count,
       cl.country AS car_country
FROM car_stats cs
JOIN class_avg ca ON cs.car_class = ca.car_class
JOIN Classes cl   ON cs.car_class = cl.class
WHERE ca.cars_in_class >= 2
  AND cs.average_position < ca.class_average
ORDER BY cs.car_class, cs.average_position;
