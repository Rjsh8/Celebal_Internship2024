USE celebal_week3;

DROP TABLE IF EXISTS Coordinates;

CREATE TABLE Coordinates (
    X INT,
    Y INT
);


INSERT INTO Coordinates (X, Y) VALUES
(20, 20),
(20, 20),
(20, 21),
(23, 22),
(22, 23),
(21, 20);

USE celebal_week3;

SELECT DISTINCT
    LEAST(f1.X, f1.Y) AS X,
    GREATEST(f1.X, f1.Y) AS Y
FROM
    Coordinates f1
JOIN
    Coordinates f2 ON f1.X = f2.Y AND f1.Y = f2.X
ORDER BY
    X, Y;


