USE AdventureWorks2022;
GO

CREATE VIEW MyProducts AS
SELECT 
    p.ProductID,
    p.Name AS ProductName,
    p.Color,
    p.ListPrice AS UnitPrice,
    s.Name AS CompanyName,
    c.Name AS CategoryName
FROM 
    Production.Product p
JOIN 
    Purchasing.ProductVendor pv ON p.ProductID = pv.ProductID
JOIN 
    Purchasing.Vendor s ON pv.BusinessEntityID = s.BusinessEntityID
JOIN 
    Production.ProductSubcategory sc ON p.ProductSubcategoryID = sc.ProductSubcategoryID
JOIN 
    Production.ProductCategory c ON sc.ProductCategoryID = c.ProductCategoryID
WHERE 
    p.DiscontinuedDate IS NULL;