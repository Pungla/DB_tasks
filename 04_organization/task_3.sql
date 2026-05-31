-- Задача 3
-- Найти сотрудников с ролью "Менеджер", у которых есть подчиненные.
-- Для каждого вывести: EmployeeID, имя, ManagerID, название отдела, название роли,
-- проекты отдела, задачи сотрудника и общее количество подчиненных
-- (включая подчиненных их подчиненных).
-- Если проектов или задач нет - NULL.

WITH RECURSIVE subordinate_tree AS (
    -- стартовые пары "руководитель -> прямой подчиненный"
    SELECT e.ManagerID AS root_id, e.EmployeeID AS sub_id
    FROM Employees e
    WHERE e.ManagerID IS NOT NULL

    UNION ALL

    -- расширяем дерево вниз: подчиненные подчиненных
    SELECT st.root_id, e.EmployeeID
    FROM subordinate_tree st
    JOIN Employees e ON e.ManagerID = st.sub_id
),
subordinate_count AS (
    SELECT root_id, COUNT(*) AS total_subordinates
    FROM subordinate_tree
    GROUP BY root_id
)
SELECT m.EmployeeID,
       m.Name AS EmployeeName,
       m.ManagerID,
       d.DepartmentName,
       r.RoleName,
       (SELECT STRING_AGG(p.ProjectName, ', ' ORDER BY p.ProjectName)
        FROM Projects p
        WHERE p.DepartmentID = m.DepartmentID) AS ProjectNames,
       (SELECT STRING_AGG(t.TaskName, ', ' ORDER BY t.TaskName COLLATE "C")
        FROM Tasks t
        WHERE t.AssignedTo = m.EmployeeID) AS TaskNames,
       sc.total_subordinates AS TotalSubordinates
FROM Employees m
JOIN Roles r            ON m.RoleID = r.RoleID
LEFT JOIN Departments d ON m.DepartmentID = d.DepartmentID
JOIN subordinate_count sc ON sc.root_id = m.EmployeeID
WHERE r.RoleName = 'Менеджер'
  AND sc.total_subordinates > 0
ORDER BY m.Name;
