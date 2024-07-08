SELECT 
    p.Name AS ProductName
FROM 
    Production.Product p
LEFT JOIN 
    Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
WHERE 
    sod.SalesOrderID IS NULL;