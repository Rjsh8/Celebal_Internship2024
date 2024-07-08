SELECT TOP 1 OrderDate, TotalDue
FROM Sales.SalesOrderHeader
ORDER BY TotalDue DESC;
SELECT TOP 1 h.OrderDate, h.TotalDue, c.CustomerID, c.AccountNumber
FROM Sales.SalesOrderHeader AS h
JOIN Sales.Customer AS c ON h.CustomerID = c.CustomerID
ORDER BY h.TotalDue DESC;
