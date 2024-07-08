SELECT 
    soh.SalesOrderID,
    AVG(sod.OrderQty) AS AverageQuantity
FROM 
    Sales.SalesOrderHeader soh
JOIN 
    Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY 
    soh.SalesOrderID;