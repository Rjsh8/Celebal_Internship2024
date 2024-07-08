WITH BestCustomer AS (
    SELECT TOP 1 
        c.CustomerID,
        SUM(soh.TotalDue) AS TotalPurchaseAmount
    FROM 
        Sales.Customer c
    JOIN 
        Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
    GROUP BY 
        c.CustomerID
    ORDER BY 
        TotalPurchaseAmount DESC
)
SELECT 
    soh.SalesOrderID,
    c.CustomerID,
    p.FirstName AS CustomerFirstName,
    p.LastName AS CustomerLastName
FROM 
    Sales.SalesOrderHeader soh
JOIN 
    BestCustomer bc ON soh.CustomerID = bc.CustomerID
JOIN 
    Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID;