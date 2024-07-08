SELECT pv.BusinessEntityID AS SupplierID, COUNT(pv.ProductID) AS NumberOfProducts
FROM Purchasing.ProductVendor AS pv
GROUP BY pv.BusinessEntityID
ORDER BY NumberOfProducts DESC;
