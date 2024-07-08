SELECT 
    soh.SalesOrderID, 
    soh.OrderDate, 
    soh.ShipDate, 
    soh.TotalDue, 
    a.AddressLine1, 
    a.City, 
    sp.Name AS StateProvince, 
    cr.Name AS Country
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
WHERE 
    cr.Name = 'Canada';
