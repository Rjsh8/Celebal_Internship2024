CREATE VIEW vwCustomerOrdersYesterday AS
SELECT 
    s.Name AS CompanyName,
    o.SalesOrderID AS OrderID,
    o.OrderDate,
    od.ProductID,
    p.Name AS ProductName,
    od.OrderQty AS Quantity,
    od.UnitPrice,
    od.OrderQty * od.UnitPrice AS TotalPrice
FROM 
    Sales.SalesOrderHeader o
JOIN 
    Sales.SalesOrderDetail od ON o.SalesOrderID = od.SalesOrderID
JOIN 
    Production.Product p ON od.ProductID = p.ProductID
JOIN 
    Sales.Customer c ON o.CustomerID = c.CustomerID
LEFT JOIN 
    Sales.Store s ON c.StoreID = s.BusinessEntityID
WHERE 
    o.OrderDate >= CONVERT(DATE, DATEADD(DAY, -1, GETDATE())) 
    AND o.OrderDate < CONVERT(DATE, GETDATE());
