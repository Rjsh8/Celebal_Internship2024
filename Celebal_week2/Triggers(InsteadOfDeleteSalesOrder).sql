USE AdventureWorks2022;
GO


IF EXISTS (SELECT * FROM sys.triggers WHERE parent_id = OBJECT_ID('Sales.SalesOrderHeader') AND type = 'TR')
BEGIN
    DECLARE @TriggerName NVARCHAR(128);
    SELECT @TriggerName = name FROM sys.triggers WHERE parent_id = OBJECT_ID('Sales.SalesOrderHeader') AND type = 'TR';
    EXEC('DROP TRIGGER Sales.' + @TriggerName);
END;
GO


CREATE TRIGGER trgInsteadOfDeleteSalesOrder
ON Sales.SalesOrderHeader
INSTEAD OF DELETE
AS
BEGIN
  
    DELETE FROM Sales.SalesOrderDetail
    WHERE SalesOrderID IN (SELECT SalesOrderID FROM DELETED);


    DELETE FROM Sales.SalesOrderHeader
    WHERE SalesOrderID IN (SELECT SalesOrderID FROM DELETED);
END;
GO