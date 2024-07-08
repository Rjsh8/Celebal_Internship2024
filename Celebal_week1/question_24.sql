WITH EmployeeCTE AS (
    SELECT 
        e.BusinessEntityID, 
        e.JobTitle, 
        p.FirstName AS EmployeeFirstName, 
        p.LastName AS EmployeeLastName, 
        e.OrganizationNode
    FROM 
        HumanResources.Employee e
    JOIN 
        Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
),
-- CTE to map each employee to their manager
ManagerCTE AS (
    SELECT 
        e1.BusinessEntityID AS EmployeeID, 
        e1.EmployeeFirstName, 
        e1.EmployeeLastName, 
        e2.BusinessEntityID AS ManagerID, 
        p.FirstName AS SupervisorFirstName, 
        p.LastName AS SupervisorLastName
    FROM 
        EmployeeCTE e1
    LEFT JOIN 
        HumanResources.Employee e2 ON e1.OrganizationNode.GetAncestor(1) = e2.OrganizationNode
    LEFT JOIN 
        Person.Person p ON e2.BusinessEntityID = p.BusinessEntityID
)
SELECT 
    mc.EmployeeID,
    mc.EmployeeFirstName, 
    mc.EmployeeLastName, 
    mc.SupervisorFirstName, 
    mc.SupervisorLastName
FROM 
    ManagerCTE mc
ORDER BY 
    mc.EmployeeLastName, mc.EmployeeFirstName;
