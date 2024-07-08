SELECT 
    SalesOrderID, 
    OrderDate, 
    CustomerID, 
    TotalDue
FROM 
    Sales.SalesOrderHeader
WHERE 
    TotalDue > 200;
