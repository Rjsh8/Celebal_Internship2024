WITH EmployeeHierarchy AS (
    SELECT 
        e.BusinessEntityID,
        p.FirstName,
        p.LastName,
        e.OrganizationNode
    FROM 
        HumanResources.Employee e
    JOIN 
        Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
    WHERE 
        e.OrganizationNode IS NOT NULL
),
ManagerReports AS (
    SELECT 
        e.BusinessEntityID AS ManagerID,
        COUNT(sub.BusinessEntityID) AS NumberOfReports
    FROM 
        EmployeeHierarchy e
    JOIN 
        EmployeeHierarchy sub ON e.OrganizationNode.IsDescendantOf(sub.OrganizationNode) = 1
    GROUP BY 
        e.BusinessEntityID
    HAVING 
        COUNT(sub.BusinessEntityID) > 4
)
SELECT 
    e.BusinessEntityID AS ManagerID,
    e.FirstName,
    e.LastName,
    mr.NumberOfReports
FROM 
    ManagerReports mr
JOIN 
    EmployeeHierarchy e ON mr.ManagerID = e.BusinessEntityID
ORDER BY 
    mr.NumberOfReports DESC;
