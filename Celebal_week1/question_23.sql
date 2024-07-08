SELECT DISTINCT
    p.ProductID,
    p.Name AS ProductName,
    p.SellEndDate
FROM 
    Sales.SalesOrderDetail sod
INNER JOIN 
    Sales.SalesOrderHeader soh 
ON 
    sod.SalesOrderID = soh.SalesOrderID
INNER JOIN 
    Production.Product p 
ON 
    sod.ProductID = p.ProductID
WHERE 
    soh.OrderDate BETWEEN '1997-01-01' AND '1998-01-01'
    AND p.SellEndDate IS NOT NULL
    AND p.SellEndDate < GETDATE()
ORDER BY 
    p.ProductID;
