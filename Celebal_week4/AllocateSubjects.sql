use celebal_week4;

CREATE TABLE SubjectDetails (
    SubjectId NVARCHAR(50) PRIMARY KEY,
    SubjectName NVARCHAR(50),
    MaxSeats INT,
    RemainingSeats INT
);

INSERT INTO SubjectDetails (SubjectId, SubjectName, MaxSeats, RemainingSeats) VALUES
('PO1491', 'Basics of Political Science', 60, 2),
('PO1492', 'Basics of Accounting', 120, 119),
('PO1493', 'Basics of Financial Markets', 90, 90),
('PO1494', 'Eco philosophy', 60, 50),
('PO1495', 'Automotive Trends', 60, 60);

CREATE TABLE StudentDetails (
    StudentId NVARCHAR(50) PRIMARY KEY,
    StudentName NVARCHAR(50),
    GPA DECIMAL(3, 1),
    Branch NVARCHAR(10),
    Section CHAR(1)
);

INSERT INTO StudentDetails (StudentId, StudentName, GPA, Branch, Section) VALUES
('159103036', 'Mohit Agarwal', 8.9, 'CCE', 'A'),
('159103037', 'Rohit Agarwal', 5.2, 'CCE', 'A'),
('159103038', 'Shohit Garg', 7.1, 'CCE', 'B'),
('159103039', 'Mrinal Malhotra', 7.9, 'CCE', 'A'),
('159103040', 'Mehreet Singh', 5.6, 'CCE', 'A'),
('159103041', 'Arjun Tehlan', 9.2, 'CCE', 'B');

CREATE TABLE StudentPreference (
    StudentId NVARCHAR(50),
    SubjectId NVARCHAR(50),
    Preference INT,
    CONSTRAINT FK_Student FOREIGN KEY (StudentId) REFERENCES StudentDetails(StudentId),
    CONSTRAINT FK_Subject FOREIGN KEY (SubjectId) REFERENCES SubjectDetails(SubjectId),
    CONSTRAINT UC_StudentSubject UNIQUE (StudentId, SubjectId)
);

INSERT INTO StudentPreference (StudentId, SubjectId, Preference) VALUES
('159103036', 'PO1491', 1),
('159103036', 'PO1492', 2),
('159103036', 'PO1493', 3),
('159103036', 'PO1494', 4),
('159103036', 'PO1495', 5);

-- Step 1: Ensure the necessary tables are in place
USE celebal_week4;

IF OBJECT_ID('Allotments', 'U') IS NOT NULL
    DROP TABLE Allotments;

IF OBJECT_ID('UnallotedStudents', 'U') IS NOT NULL
    DROP TABLE UnallotedStudents;

CREATE TABLE Allotments (
    SubjectId NVARCHAR(50),
    StudentId NVARCHAR(50)
);

CREATE TABLE UnallotedStudents (
    StudentId NVARCHAR(50)
);

-- Step 2: Create the stored procedure
IF OBJECT_ID('AllocateSubjects', 'P') IS NOT NULL
    DROP PROCEDURE AllocateSubjects;

GO

CREATE PROCEDURE AllocateSubjects
AS
BEGIN
    DECLARE @StudentId NVARCHAR(50), @GPA DECIMAL(3, 1), @Preference INT, @SubjectId NVARCHAR(50);

    DECLARE StudentCursor CURSOR FOR
    SELECT StudentId, GPA FROM StudentDetails ORDER BY GPA DESC;

    OPEN StudentCursor;

    FETCH NEXT FROM StudentCursor INTO @StudentId, @GPA;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @Preference = 1;

        WHILE @Preference <= 5
        BEGIN
            SELECT @SubjectId = SubjectId
            FROM StudentPreference
            WHERE StudentId = @StudentId AND Preference = @Preference;

            IF EXISTS (
                SELECT 1 
                FROM SubjectDetails 
                WHERE SubjectId = @SubjectId AND RemainingSeats > 0
            )
            BEGIN
                UPDATE SubjectDetails
                SET RemainingSeats = RemainingSeats - 1
                WHERE SubjectId = @SubjectId;

                INSERT INTO Allotments (SubjectId, StudentId)
                VALUES (@SubjectId, @StudentId);

                BREAK;
            END

            SET @Preference = @Preference + 1;
        END

        IF @Preference > 5
        BEGIN
            INSERT INTO UnallotedStudents (StudentId)
            VALUES (@StudentId);
        END

        FETCH NEXT FROM StudentCursor INTO @StudentId, @GPA;
    END

    CLOSE StudentCursor;
    DEALLOCATE StudentCursor;

    SELECT * FROM Allotments;
    SELECT * FROM UnallotedStudents;
END;


EXEC AllocateSubjects;


SELECT * FROM Allotments;
SELECT * FROM UnallotedStudents;
