SELECT DISTINCT
    c.CustomerID,
    p.FirstName,
    p.LastName,
    c.AccountNumber
FROM 
    Sales.Customer c
JOIN 
    Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
LEFT JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
ORDER BY 
    p.LastName, p.FirstName;
