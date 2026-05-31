# Основы работы с базами данных (SQL)

Учебный проект по повторению основ SQL. В работе четыре независимые базы данных,
для каждой написан скрипт создания таблиц, скрипт наполнения тестовыми данными и
решения задач. Все запросы написаны и проверены на PostgreSQL 18.

## Цель работы

Повторить создание таблиц, наполнение данными и выборку данных средствами SQL:
соединения таблиц (JOIN), группировку и агрегатные функции, оконные функции,
подзапросы, объединение результатов (UNION), а также рекурсивные запросы (WITH RECURSIVE).

Всего 13 задач на 50 баллов.

## Структура репозитория

```
.
├── 01_transport/        - транспортные средства
│   ├── create_tables.sql
│   ├── insert_data.sql
│   ├── task_1.sql
│   └── task_2.sql
├── 02_racing/           - автомобильные гонки
│   ├── create_tables.sql
│   ├── insert_data.sql
│   └── task_1.sql ... task_5.sql
├── 03_hotel_booking/    - бронирование отелей
│   ├── create_tables.sql
│   ├── insert_data.sql
│   └── task_1.sql ... task_3.sql
├── 04_organization/     - структура организации
│   ├── create_tables.sql
│   ├── insert_data.sql
│   └── task_1.sql ... task_3.sql
└── README.md
```

Для каждой базы:
- `create_tables.sql` - создание таблиц со связями (REFERENCES);
- `insert_data.sql` - наполнение таблиц тестовыми данными;
- `task_N.sql` - решение задачи N (один SQL-запрос на задачу).

## Базы данных

### 01_transport (транспортные средства)
Таблицы: `Vehicle` (общая информация о модели), `Car`, `Motorcycle`, `Bicycle`.
Каждый тип транспорта ссылается на модель в таблице `Vehicle` через внешний ключ.

### 02_racing (автомобильные гонки)
Таблицы: `Classes` (классы автомобилей), `Cars` (автомобили), `Races` (гонки),
`Results` (результаты — место автомобиля в гонке). `Results` связана с `Cars` и `Races`.

### 03_hotel_booking (бронирование отелей)
Таблицы: `Hotel`, `Room` (номера отеля), `Customer` (клиенты), `Booking` (бронирования).
`Booking` ссылается на `Room` и `Customer`, `Room` ссылается на `Hotel`.

### 04_organization (структура организации)
Таблицы: `Departments`, `Roles`, `Employees`, `Projects`, `Tasks`.
В таблице `Employees` поле `ManagerID` ссылается на ту же таблицу — так задаётся
иерархия подчинения. Задачи этой базы решаются рекурсивными запросами (WITH RECURSIVE).

## Как запустить

Нужна установленная PostgreSQL и утилита `psql`.

1. Создать базу данных (на примере транспорта):

```
createdb -U postgres transport_db
```

2. Создать таблицы и загрузить данные:

```
psql -U postgres -d transport_db -f 01_transport/create_tables.sql
psql -U postgres -d transport_db -f 01_transport/insert_data.sql
```

3. Выполнить решение нужной задачи:

```
psql -U postgres -d transport_db -f 01_transport/task_1.sql
```

Для остальных баз порядок такой же: создаём отдельную базу, запускаем
`create_tables.sql`, затем `insert_data.sql`, после чего можно запускать `task_*.sql`.

