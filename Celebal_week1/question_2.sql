SELECT 
    c.CustomerID,
    s.Name AS CompanyName,
    c.AccountNumber
FROM 
    Sales.Customer c
JOIN 
    Sales.Store s ON c.StoreID = s.BusinessEntityID
WHERE 
    s.Name LIKE '%n';
