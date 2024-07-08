SELECT 
    soh.SalesOrderID,
    c.CustomerID,
    p.FirstName AS CustomerFirstName,
    p.LastName AS CustomerLastName
FROM 
    Sales.SalesOrderHeader soh
JOIN 
    Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN 
    Person.PersonPhone pp ON p.BusinessEntityID = pp.BusinessEntityID AND pp.PhoneNumberTypeID = 4 -- Assuming Fax has PhoneType ID of 4
WHERE 
    pp.PhoneNumber IS NULL OR pp.PhoneNumberTypeID IS NULL;