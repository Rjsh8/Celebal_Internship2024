CREATE TRIGGER trg_CheckStockBeforeInsert
ON Sales.SalesOrderDetail
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @ProductID INT, @OrderQty INT, @UnitsInStock INT;

    
    DECLARE cur CURSOR FOR
    SELECT ProductID, OrderQty
    FROM inserted;

    OPEN cur;
    FETCH NEXT FROM cur INTO @ProductID, @OrderQty;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        
        SELECT @UnitsInStock = Quantity
        FROM Production.ProductInventory
        WHERE ProductID = @ProductID;

      
        IF @UnitsInStock >= @OrderQty
        BEGIN
            
            INSERT INTO Sales.SalesOrderDetail (SalesOrderID, ProductID, OrderQty, UnitPrice, UnitPriceDiscount)
            SELECT SalesOrderID, ProductID, OrderQty, UnitPrice, UnitPriceDiscount
            FROM inserted;

         
            UPDATE Production.ProductInventory
            SET Quantity = Quantity - @OrderQty
            WHERE ProductID = @ProductID;
        END
        ELSE
        BEGIN
           
            RAISERROR ('Order could not be filled because of insufficient stock for ProductID %d', 16, 1, @ProductID);
        END

        FETCH NEXT FROM cur INTO @ProductID, @OrderQty;
    END;

    CLOSE cur;
    DEALLOCATE cur;
END;
