DECLARE @CustomerIDStart INT = 1; 
DECLARE @CustomerIDEnd INT = 30118;

SELECT 
    e.BusinessEntityID AS EmployeeID,
    p.FirstName,
    p.LastName,
    COUNT(soh.SalesOrderID) AS OrderCount
FROM 
    Sales.SalesOrderHeader soh
JOIN 
    Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN 
    HumanResources.Employee e ON soh.SalesPersonID = e.BusinessEntityID
JOIN 
    Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
WHERE 
    c.CustomerID BETWEEN @CustomerIDStart AND @CustomerIDEnd
GROUP BY 
    e.BusinessEntityID,
    p.FirstName,
    p.LastName
ORDER BY 
    OrderCount DESC;
