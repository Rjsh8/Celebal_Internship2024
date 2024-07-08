SELECT TOP 10 
    c.CustomerID, 
    SUM(soh.TotalDue) AS TotalBusiness
FROM 
    Sales.SalesOrderHeader AS soh
JOIN 
    Sales.Customer AS c ON soh.CustomerID = c.CustomerID
GROUP BY 
    c.CustomerID
ORDER BY 
    TotalBusiness DESC;
