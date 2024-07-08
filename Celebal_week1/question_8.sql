SELECT DISTINCT
    c.CustomerID,
    p.FirstName,
    p.LastName,
    a.City,
    prod.Name AS ProductName
FROM 
    Sales.Customer c
JOIN 
    Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN 
    Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN 
    Production.Product prod ON sod.ProductID = prod.ProductID
JOIN 
    Person.BusinessEntityAddress bea ON c.PersonID = bea.BusinessEntityID
JOIN 
    Person.Address a ON bea.AddressID = a.AddressID
LEFT JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
WHERE 
    a.City = 'London' 
    AND prod.Name = 'Chai'
ORDER BY 
    p.LastName, p.FirstName;
