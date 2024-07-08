SELECT 
    CustomerID,
    PersonID,
    StoreID,
    TerritoryID,
    AccountNumber
FROM 
    Sales.Customer;
SELECT 
    c.CustomerID,
    p.FirstName,
    p.LastName,
    e.EmailAddress,
    c.AccountNumber
FROM 
    Sales.Customer c
LEFT JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN 
    Person.EmailAddress e ON p.BusinessEntityID = e.BusinessEntityID;

	SELECT 
    c.CustomerID,
    s.Name AS StoreName,
    c.AccountNumber
FROM 
    Sales.Customer c
LEFT JOIN 
    Sales.Store s ON c.StoreID = s.BusinessEntityID;
