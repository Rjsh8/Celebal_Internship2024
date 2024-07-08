SELECT 
    sod.SalesOrderID,
    SUM(sod.OrderQty) AS TotalQuantity
FROM 
    Sales.SalesOrderDetail sod
GROUP BY 
    sod.SalesOrderID
HAVING 
    SUM(sod.OrderQty) > 300;
