SELECT TOP 10
    sp.CountryRegionCode AS CountryCode,
    sp.Name AS CountryName,
    SUM(soh.TotalDue) AS TotalSales
FROM 
    Sales.SalesOrderHeader soh
JOIN 
    Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN 
    Person.Address a ON c.PersonID = a.AddressID
JOIN 
    Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
GROUP BY 
    sp.CountryRegionCode, sp.Name
ORDER BY 
    TotalSales DESC;