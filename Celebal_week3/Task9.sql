use celebal_week3

CREATE TABLE SampleTable (
    N INT,
    P INT
);

INSERT INTO SampleTable (N, P) VALUES
(1, 2),
(3, 2),
(6, 8),
(9, 8),
(2, 5),
(8, 5),
(5, NULL);

SELECT N,
       CASE
           WHEN P IS NULL THEN 'Root'
           WHEN N NOT IN (SELECT P FROM SampleTable WHERE P IS NOT NULL) THEN 'Leaf'
           ELSE 'Inner'
       END AS NodeType
FROM SampleTable
ORDER BY N;

