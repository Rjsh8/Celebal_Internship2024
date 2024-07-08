CREATE PROCEDURE InsertOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice DECIMAL(10, 2) = NULL,
    @Quantity INT,
    @Discount DECIMAL(4, 2) = 0
AS
BEGIN
    DECLARE @StockQuantity INT;
    DECLARE @ReorderLevel INT;
    DECLARE @DefaultUnitPrice DECIMAL(10, 2);

   
    SELECT @StockQuantity = p.UnitsInStock, 
           @ReorderLevel = p.ReorderLevel, 
           @DefaultUnitPrice = p.ListPrice
    FROM Production.Product AS p  
    WHERE p.ProductID = @ProductID;

  
    IF @UnitPrice IS NULL
    BEGIN
        SET @UnitPrice = @DefaultUnitPrice;
    END

  
    IF @StockQuantity < @Quantity
    BEGIN
        PRINT 'Failed to place the order. Not enough stock available.';
        RETURN;
    END


    INSERT INTO Sales.SalesOrderDetail (SalesOrderID, ProductID, UnitPrice, OrderQty, UnitPriceDiscount)
    VALUES (@OrderID, @ProductID, @UnitPrice, @Quantity, @Discount);

   
    IF @@ROWCOUNT = 0
    BEGIN
        PRINT 'Failed to place the order. Please try again.';
        RETURN;
    END


    UPDATE Production.Product
    SET UnitsInStock = UnitsInStock - @Quantity
    WHERE ProductID = @ProductID;

  
    IF @StockQuantity - @Quantity < @ReorderLevel
    BEGIN
        PRINT 'Warning: Stock quantity has dropped below reorder level.';
    END
END;
