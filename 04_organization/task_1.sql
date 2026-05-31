-- Задача 1
-- Рекурсивно найти всех сотрудников, подчиняющихся Ивану Иванову (EmployeeID = 1),
-- включая его самого, его подчиненных и подчиненных подчиненных.
-- Для каждого вывести: EmployeeID, имя, ManagerID, название отдела, название роли,
-- проекты отдела (через запятую) и задачи сотрудника (через запятую).
-- Если проектов или задач нет - NULL. Отсортировать по имени сотрудника.

WITH RECURSIVE subordinates AS (
    -- стартовая строка: сам Иван Иванов
    SELECT EmployeeID, Name, ManagerID, DepartmentID, RoleID
    FROM Employees
    WHERE EmployeeID = 1

    UNION ALL

    -- добавляем подчиненных найденных сотрудников
    SELECT e.EmployeeID, e.Name, e.ManagerID, e.DepartmentID, e.RoleID
    FROM Employees e
    JOIN subordinates s ON e.ManagerID = s.EmployeeID
)
SELECT s.EmployeeID,
       s.Name AS EmployeeName,
       s.ManagerID,
       d.DepartmentName,
       r.RoleName,
       (SELECT STRING_AGG(p.ProjectName, ', ' ORDER BY p.ProjectName)
        FROM Projects p
        WHERE p.DepartmentID = s.DepartmentID) AS ProjectNames,
       (SELECT STRING_AGG(t.TaskName, ', ' ORDER BY t.TaskName COLLATE "C")
        FROM Tasks t
        WHERE t.AssignedTo = s.EmployeeID) AS TaskNames
FROM subordinates s
LEFT JOIN Departments d ON s.DepartmentID = d.DepartmentID
LEFT JOIN Roles r       ON s.RoleID = r.RoleID
ORDER BY s.Name;
