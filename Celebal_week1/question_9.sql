SELECT 
    c.CustomerID,
    p.FirstName,
    p.LastName,
    c.AccountNumber
FROM 
    Sales.Customer c
LEFT JOIN 
    Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
LEFT JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
WHERE 
    soh.CustomerID IS NULL
ORDER BY 
    p.LastName, p.FirstName;
