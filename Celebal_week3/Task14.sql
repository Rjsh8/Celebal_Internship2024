
CREATE TABLE headcount_data (
    sub_band VARCHAR(50),
    headcount INT
);

INSERT INTO headcount_data (sub_band, headcount) VALUES
('Band A', 100),
('Band B', 150),
('Band C', 200),
('Band D', 50),
('Band E', 100);

SELECT 
    sub_band,
    headcount,
    ROUND(headcount * 100.0 / (SELECT SUM(headcount) FROM headcount_data), 2) AS percentage_headcount
FROM 
    headcount_data;
