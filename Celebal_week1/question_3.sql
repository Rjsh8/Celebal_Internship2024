SELECT 
    c.CustomerID,
    p.FirstName,
    p.LastName,
    a.City,
    a.AddressLine1,
    a.AddressLine2
FROM 
    Sales.Customer c
JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN 
    Person.BusinessEntityAddress bea ON p.BusinessEntityID = bea.BusinessEntityID
JOIN 
    Person.Address a ON bea.AddressID = a.AddressID
WHERE 
    a.City IN ('Berlin', 'London');
