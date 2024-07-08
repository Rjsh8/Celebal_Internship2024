SELECT 
    p.ProductID,
    p.Name,
    pi.Quantity AS UnitsInStock,
    pi.Quantity AS UnitsOnOrder
FROM 
    Production.Product p
JOIN 
    Production.ProductInventory pi ON p.ProductID = pi.ProductID
WHERE 
    pi.Quantity < 10
    AND pi.Quantity = 0;
SELECT 
    p.ProductID,
    p.Name,
    SUM(pi.Quantity) AS UnitsInStock,
    ISNULL(SUM(sod.OrderQty), 0) AS UnitsOnOrder
FROM 
    Production.Product p
JOIN 
    Production.ProductInventory pi ON p.ProductID = pi.ProductID
LEFT JOIN 
    Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY 
    p.ProductID, 
    p.Name
HAVING 
    SUM(pi.Quantity) < 10
    AND ISNULL(SUM(sod.OrderQty), 0) = 0;
