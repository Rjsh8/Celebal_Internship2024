SELECT 
    SalesPersonID AS EmployeeID,
    SUM(TotalDue) AS TotalSales
FROM 
    Sales.SalesOrderHeader
WHERE 
    SalesPersonID IS NOT NULL
GROUP BY 
    SalesPersonID;