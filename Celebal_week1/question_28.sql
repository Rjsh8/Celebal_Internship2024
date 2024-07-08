SELECT 
    soh.SalesOrderID,
    p.Name AS ProductName
FROM 
    Sales.SalesOrderDetail sod
JOIN 
    Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
JOIN 
    Production.Product p ON sod.ProductID = p.ProductID;