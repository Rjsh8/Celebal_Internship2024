SELECT 
    ProductID,
    Name,
    ProductNumber,
    Color,
    StandardCost,
    ListPrice,
    Size,
    Weight,
    ProductModelID
FROM 
    Production.Product
WHERE 
    Name LIKE 'A%'
ORDER BY 
    Name;
