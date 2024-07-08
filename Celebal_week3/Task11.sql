USE celebal_week3;

DROP TABLE IF EXISTS Friends;
DROP TABLE IF EXISTS Packages;
DROP TABLE IF EXISTS Students;

CREATE TABLE Students (
  ID INT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL
);

CREATE TABLE Friends (
  ID INT PRIMARY KEY,
  Friend_ID INT NOT NULL,
  FOREIGN KEY (ID) REFERENCES Students(ID),
  FOREIGN KEY (Friend_ID) REFERENCES Students(ID)
);

CREATE TABLE Packages (
  ID INT PRIMARY KEY,
  Salary DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (ID) REFERENCES Students(ID)
);

INSERT INTO Students (ID, Name) VALUES 
(1, 'Ashley'), 
(2, 'Samantha'), 
(3, 'Julia'), 
(4, 'Scarlet');

INSERT INTO Friends (ID, Friend_ID) VALUES 
(1, 2), 
(2, 3), 
(3, 4), 
(4, 1);

INSERT INTO Packages (ID, Salary) VALUES 
(1, 15.20), 
(2, 10.06), 
(3, 11.55), 
(4, 12.12);

SELECT
  s.Name AS StudentName
FROM Students s
INNER JOIN Friends f ON s.ID = f.ID
INNER JOIN Packages p1 ON s.ID = p1.ID  -- Student's package
INNER JOIN Packages p2 ON f.Friend_ID = p2.ID -- Best friend's package
WHERE p1.Salary < p2.Salary
ORDER BY p2.Salary ASC;
