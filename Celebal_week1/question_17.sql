SELECT 
    SalesOrderID, 
    OrderDate, 
    CustomerID, 
    TotalDue
FROM 
    Sales.SalesOrderHeader
WHERE 
    OrderDate >= '1996-12-31';
