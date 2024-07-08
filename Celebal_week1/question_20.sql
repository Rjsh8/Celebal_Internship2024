SELECT 
    cr.Name AS Country, 
    SUM(soh.TotalDue) AS TotalSales
FROM 
    Sales.SalesOrderHeader soh
INNER JOIN 
    Person.Address a 
ON 
    soh.ShipToAddressID = a.AddressID
INNER JOIN 
    Person.StateProvince sp 
ON 
    a.StateProvinceID = sp.StateProvinceID
INNER JOIN 
    Person.CountryRegion cr 
ON 
    sp.CountryRegionCode = cr.CountryRegionCode
GROUP BY 
    cr.Name
ORDER BY 
    TotalSales DESC;
