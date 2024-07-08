
CREATE DATABASE celebal_week3;
USE celebal_week3;


CREATE TABLE Projects (
    Task_ID INT,
    Start_Date DATE,
    End_Date DATE
);


INSERT INTO Projects (Task_ID, Start_Date, End_Date) VALUES
(1, '2015-10-01', '2015-10-02'),
(2, '2015-10-02', '2015-10-03'),
(3, '2015-10-03', '2015-10-04'),
(4, '2015-10-13', '2015-10-14'),
(5, '2015-10-14', '2015-10-15'),
(6, '2015-10-28', '2015-10-29'),
(7, '2015-10-30', '2015-10-31');


SELECT 
    s.Proj_Start_Date, 
    MIN(e.Proj_End_Date) AS Real_Proj_End_Date 
FROM 
    (SELECT Start_Date AS Proj_Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) s
CROSS JOIN 
    (SELECT End_Date AS Proj_End_Date FROM Projects WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) e
WHERE 
    s.Proj_Start_Date < e.Proj_End_Date
GROUP BY 
    s.Proj_Start_Date
ORDER BY 
    DATEDIFF(day, s.Proj_Start_Date, MIN(e.Proj_End_Date)) ASC, 
    s.Proj_Start_Date ASC;
