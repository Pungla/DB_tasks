-- База данных "Структура организации"
-- Создание таблиц

-- Таблица Departments: отделы
CREATE TABLE Departments (
    DepartmentID SERIAL PRIMARY KEY,  -- автоматическая генерация идентификаторов
    DepartmentName VARCHAR(100) NOT NULL
);

-- Таблица Roles: роли сотрудников
CREATE TABLE Roles (
    RoleID SERIAL PRIMARY KEY,  -- автоматическая генерация идентификаторов
    RoleName VARCHAR(100) NOT NULL
);

-- Таблица Employees: сотрудники (ManagerID ссылается на эту же таблицу)
CREATE TABLE Employees (
    EmployeeID SERIAL PRIMARY KEY,  -- автоматическая генерация идентификаторов
    Name VARCHAR(100) NOT NULL,
    Position VARCHAR(100),
    ManagerID INT,
    DepartmentID INT,
    RoleID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID) ON DELETE SET NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE CASCADE,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID) ON DELETE SET NULL
);

-- Таблица Projects: проекты
CREATE TABLE Projects (
    ProjectID SERIAL PRIMARY KEY,  -- автоматическая генерация идентификаторов
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE CASCADE
);

-- Таблица Tasks: задачи
CREATE TABLE Tasks (
    TaskID SERIAL PRIMARY KEY,  -- автоматическая генерация идентификаторов
    TaskName VARCHAR(100) NOT NULL,
    AssignedTo INT,
    ProjectID INT,
    FOREIGN KEY (AssignedTo) REFERENCES Employees(EmployeeID) ON DELETE SET NULL,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID) ON DELETE CASCADE
);
