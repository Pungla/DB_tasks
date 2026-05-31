-- База данных "Бронирование отелей"
-- Создание таблиц

-- Таблица Hotel: отели
CREATE TABLE Hotel (
    ID_hotel SERIAL PRIMARY KEY,  -- автоматическая генерация идентификаторов
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL
);

-- Таблица Room: номера в отелях
CREATE TABLE Room (
    ID_room SERIAL PRIMARY KEY,   -- автоматическая генерация идентификаторов
    ID_hotel INT,
    room_type VARCHAR(20) NOT NULL CHECK (room_type IN ('Single', 'Double', 'Suite')), -- тип номера
    price DECIMAL(10, 2) NOT NULL,
    capacity INT NOT NULL,
    FOREIGN KEY (ID_hotel) REFERENCES Hotel(ID_hotel)
);

-- Таблица Customer: клиенты
CREATE TABLE Customer (
    ID_customer SERIAL PRIMARY KEY,  -- автоматическая генерация идентификаторов
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL
);

-- Таблица Booking: бронирования
CREATE TABLE Booking (
    ID_booking SERIAL PRIMARY KEY,   -- автоматическая генерация идентификаторов
    ID_room INT,
    ID_customer INT,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    FOREIGN KEY (ID_room) REFERENCES Room(ID_room),
    FOREIGN KEY (ID_customer) REFERENCES Customer(ID_customer)
);
