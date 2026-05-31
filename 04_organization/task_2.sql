-- Задача 2
-- То же дерево подчинения Ивана Иванова (EmployeeID = 1), что и в задаче 1, но дополнительно:
--   TotalTasks        - количество задач, назначенных сотруднику;
--   TotalSubordinates - количество прямых подчиненных (без подчиненных их подчиненных).
-- Если проектов или задач нет - NULL. Отсортировать по имени сотрудника.

WITH RECURSIVE subordinates AS (
    SELECT EmployeeID, Name, ManagerID, DepartmentID, RoleID
    FROM Employees
    WHERE EmployeeID = 1

    UNION ALL

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
        WHERE t.AssignedTo = s.EmployeeID) AS TaskNames,
       (SELECT COUNT(*)
        FROM Tasks t
        WHERE t.AssignedTo = s.EmployeeID) AS TotalTasks,
       (SELECT COUNT(*)
        FROM Employees e2
        WHERE e2.ManagerID = s.EmployeeID) AS TotalSubordinates
FROM subordinates s
LEFT JOIN Departments d ON s.DepartmentID = d.DepartmentID
LEFT JOIN Roles r       ON s.RoleID = r.RoleID
ORDER BY s.Name;
