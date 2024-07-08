SELECT 
    soh.SalesOrderID,
    MIN(sod.OrderQty) AS MinQuantity,
    MAX(sod.OrderQty) AS MaxQuantity
FROM 
    Sales.SalesOrderHeader soh
JOIN 
    Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY 
    soh.SalesOrderID;