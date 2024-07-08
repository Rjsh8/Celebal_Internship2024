CREATE TABLE MyTable (
  ID INT PRIMARY KEY,
  Column1 VARCHAR(255),
  Column2 VARCHAR(255)
);

INSERT INTO MyTable (ID, Column1, Column2) VALUES
  (1, 'Value A', 'Value B'),
  (2, 'Value X', 'Value Y');
UPDATE MyTable
SET Column1 = Column2,
  Column2 = Column1;
