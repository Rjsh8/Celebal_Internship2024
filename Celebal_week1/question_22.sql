SELECT 
    p.FirstName + ' ' + p.LastName AS ContactName, 
    COUNT(soh.SalesOrderID) AS NumberOfOrders
FROM 
    Sales.SalesOrderHeader soh
INNER JOIN 
    Sales.Customer c 
ON 
    soh.CustomerID = c.CustomerID
INNER JOIN 
    Person.Person p 
ON 
    c.PersonID = p.BusinessEntityID
GROUP BY 
    p.FirstName, 
    p.LastName
HAVING 
    COUNT(soh.SalesOrderID) > 3
ORDER BY 
    NumberOfOrders DESC;
