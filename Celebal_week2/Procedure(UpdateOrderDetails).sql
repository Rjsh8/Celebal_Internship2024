CREATE PROCEDURE UpdateOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice DECIMAL(10, 2) = NULL,
    @Quantity INT = NULL,
    @Discount DECIMAL(4, 2) = NULL
AS
BEGIN
    DECLARE @CurrentUnitPrice DECIMAL(10, 2);
    DECLARE @CurrentQuantity INT;
    DECLARE @CurrentDiscount DECIMAL(4, 2);
    DECLARE @StockQuantity INT;
    DECLARE @NewQuantity INT;

   
    SELECT @CurrentUnitPrice = UnitPrice, 
           @CurrentQuantity = OrderQty, 
           @CurrentDiscount = UnitPriceDiscount
    FROM Sales.SalesOrderDetail
    WHERE SalesOrderID = @OrderID AND ProductID = @ProductID;

 
    SELECT @StockQuantity = UnitsInStock
    FROM Production.Product
    WHERE ProductID = @ProductID;

 
    SET @NewQuantity = ISNULL(@Quantity, @CurrentQuantity);

 
    IF @StockQuantity + @CurrentQuantity < @NewQuantity
    BEGIN
        PRINT 'Failed to update the order. Not enough stock available.';
        RETURN;
    END

    
    UPDATE Sales.SalesOrderDetail
    SET UnitPrice = ISNULL(@UnitPrice, @CurrentUnitPrice),
        OrderQty = @NewQuantity,
        UnitPriceDiscount = ISNULL(@Discount, @CurrentDiscount)
    WHERE SalesOrderID = @OrderID AND ProductID = @ProductID;

   
    UPDATE Production.Product
    SET UnitsInStock = UnitsInStock + @CurrentQuantity - @NewQuantity
    WHERE ProductID = @ProductID;
END;
