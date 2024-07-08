SELECT DISTINCT
    a.PostalCode AS ShipPostalCode
FROM 
    Sales.SalesOrderHeader soh
JOIN 
    Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN 
    Production.Product p ON sod.ProductID = p.ProductID
JOIN 
    Person.Address a ON soh.ShipToAddressID = a.AddressID
WHERE 
    p.Name = 'Tofu';