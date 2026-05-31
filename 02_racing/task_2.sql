-- Задача 2
-- Найти автомобиль с наименьшей средней позицией среди всех автомобилей.
-- Вывести: имя, класс, среднюю позицию, количество гонок, страну класса.
-- При равенстве средней позиции выбрать один автомобиль по алфавиту (по имени).

SELECT c.name  AS car_name,
       c.class AS car_class,
       ROUND(AVG(r.position), 4) AS average_position,
       COUNT(r.race)   AS race_count,
       cl.country      AS car_country
FROM Cars c
JOIN Results r ON c.name = r.car
JOIN Classes cl ON c.class = cl.class
GROUP BY c.name, c.class, cl.country
ORDER BY average_position ASC, car_name ASC
LIMIT 1;
