-- Задача 1
-- Найти производителей и модели всех мотоциклов с мощностью более 150 л.с.,
-- ценой менее 20 тысяч долларов и типом Sport.
-- Результат отсортировать по мощности по убыванию.

SELECT v.maker, m.model
FROM Motorcycle m
JOIN Vehicle v ON m.model = v.model
WHERE m.horsepower > 150
  AND m.price < 20000
  AND m.type = 'Sport'
ORDER BY m.horsepower DESC;
