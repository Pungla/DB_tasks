-- Задача 3
-- Категоризировать отели по средней стоимости номера:
--   Дешевый  - средняя стоимость менее 175;
--   Средний  - от 175 до 300 включительно;
--   Дорогой  - более 300.
-- Для каждого клиента определить предпочитаемый тип отеля:
--   есть хотя бы один дорогой -> Дорогой; иначе средний -> Средний; иначе Дешевый.
-- Вывести: ID_customer, имя, предпочитаемый тип, список посещенных отелей.
-- Сортировка: сначала дешевые, затем средние, затем дорогие.

WITH hotel_category AS (
    SELECT h.ID_hotel,
           h.name AS hotel_name,
           CASE
               WHEN AVG(r.price) < 175 THEN 'Дешевый'
               WHEN AVG(r.price) <= 300 THEN 'Средний'
               ELSE 'Дорогой'
           END AS category
    FROM Hotel h
    JOIN Room r ON h.ID_hotel = r.ID_hotel
    GROUP BY h.ID_hotel, h.name
),
customer_hotels AS (
    SELECT DISTINCT c.ID_customer,
           c.name AS customer_name,
           hc.hotel_name,
           hc.category
    FROM Customer c
    JOIN Booking b ON c.ID_customer = b.ID_customer
    JOIN Room rm   ON b.ID_room = rm.ID_room
    JOIN hotel_category hc ON rm.ID_hotel = hc.ID_hotel
),
preferences AS (
    SELECT ID_customer,
           customer_name AS name,
           CASE
               WHEN bool_or(category = 'Дорогой') THEN 'Дорогой'
               WHEN bool_or(category = 'Средний') THEN 'Средний'
               ELSE 'Дешевый'
           END AS preferred_hotel_type,
           STRING_AGG(DISTINCT hotel_name, ',' ORDER BY hotel_name) AS visited_hotels
    FROM customer_hotels
    GROUP BY ID_customer, customer_name
)
SELECT ID_customer,
       name,
       preferred_hotel_type,
       visited_hotels
FROM preferences
ORDER BY CASE preferred_hotel_type
             WHEN 'Дешевый' THEN 1
             WHEN 'Средний' THEN 2
             WHEN 'Дорогой' THEN 3
         END,
         ID_customer;
