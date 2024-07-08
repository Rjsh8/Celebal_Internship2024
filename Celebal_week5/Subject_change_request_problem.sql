CREATE DATABASE Celebal_week5;


use Celebal_week5;

CREATE TABLE SubjectAllotments (
    StudentId VARCHAR(50),
    SubjectId VARCHAR(50),
    Is_valid BIT
);
GO

CREATE TABLE SubjectRequest (
    StudentId VARCHAR(50),
    SubjectId VARCHAR(50)
);
GO

CREATE PROCEDURE ProcessSubjectChangeRequests
AS
BEGIN

    DECLARE @StudentId VARCHAR(50);
    DECLARE @RequestedSubjectId VARCHAR(50);
    DECLARE @CurrentSubjectId VARCHAR(50);

   
    DECLARE cur CURSOR FOR
    SELECT StudentId, SubjectId FROM SubjectRequest;

    OPEN cur;

   
    FETCH NEXT FROM cur INTO @StudentId, @RequestedSubjectId;

   
    WHILE @@FETCH_STATUS = 0
    BEGIN
       
        SELECT @CurrentSubjectId = SubjectId
        FROM SubjectAllotments
        WHERE StudentId = @StudentId AND Is_valid = 1;

     
        IF (@CurrentSubjectId IS NOT NULL AND @CurrentSubjectId != @RequestedSubjectId)
        BEGIN
        
            UPDATE SubjectAllotments
            SET Is_valid = 0
            WHERE StudentId = @StudentId AND Is_valid = 1;

         
            INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_valid)
            VALUES (@StudentId, @RequestedSubjectId, 1);
        END
      
        ELSE IF (@CurrentSubjectId IS NULL)
        BEGIN
            INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_valid)
            VALUES (@StudentId, @RequestedSubjectId, 1);
        END

     
        FETCH NEXT FROM cur INTO @StudentId, @RequestedSubjectId;
    END

  
    CLOSE cur;
    DEALLOCATE cur;


    TRUNCATE TABLE SubjectRequest;
END;
GO

INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_valid)
VALUES ('159103036', 'PO1491', 1),
       ('159103036', 'PO1492', 0),
       ('159103036', 'PO1493', 0),
       ('159103036', 'PO1494', 0),
       ('159103036', 'PO1495', 0);
GO

INSERT INTO SubjectRequest (StudentId, SubjectId)
VALUES ('159103036', 'PO1496');
GO

EXEC ProcessSubjectChangeRequests;
GO

SELECT * FROM SubjectAllotments;
GO

