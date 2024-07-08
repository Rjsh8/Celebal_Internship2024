SELECT 
    soh.OrderDate,
    soh.SalesOrderID,
    soh.DueDate,
    soh.ShipDate,
    soh.Status,
    soh.SubTotal,
    soh.TaxAmt,
    soh.Freight,
    soh.TotalDue,
    sod.SalesOrderDetailID,
    sod.ProductID,
    sod.OrderQty,
    sod.UnitPrice,
    sod.UnitPriceDiscount,
    sod.LineTotal
FROM 
    Sales.SalesOrderHeader soh
JOIN 
    Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
WHERE 
    soh.TotalDue = (
        SELECT MAX(TotalDue) 
        FROM Sales.SalesOrderHeader
    )
ORDER BY 
    soh.OrderDate;