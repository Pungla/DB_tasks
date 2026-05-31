-- Задача 2
-- Шаг 1: клиенты, сделавшие более двух бронирований в более чем одном отеле.
-- Шаг 2: клиенты, потратившие более 500 долларов на бронирования.
-- Шаг 3: пересечение этих двух групп.
-- Вывести: ID_customer, имя, общее количество бронирований, общую сумму, число уникальных отелей.
-- Отсортировать по общей сумме по возрастанию.
-- Сумма считается как сумма цен забронированных номеров.

WITH customer_stats AS (
    SELECT c.ID_customer,
           c.name,
           COUNT(b.ID_booking)        AS total_bookings,
           COUNT(DISTINCT r.ID_hotel) AS unique_hotels,
           SUM(r.price)               AS total_spent
    FROM Customer c
    JOIN Booking b ON c.ID_customer = b.ID_customer
    JOIN Room r    ON b.ID_room = r.ID_room
    GROUP BY c.ID_customer, c.name
),
multi_hotel AS (                 -- более двух бронирований в разных отелях
    SELECT ID_customer, name, total_bookings, unique_hotels, total_spent
    FROM customer_stats
    WHERE total_bookings > 2
      AND unique_hotels > 1
),
big_spenders AS (                -- потратили более 500 долларов
    SELECT ID_customer, name, total_spent, total_bookings
    FROM customer_stats
    WHERE total_spent > 500
)
SELECT m.ID_customer,
       m.name,
       m.total_bookings,
       m.total_spent,
       m.unique_hotels
FROM multi_hotel m
JOIN big_spenders s ON m.ID_customer = s.ID_customer
ORDER BY m.total_spent ASC;
