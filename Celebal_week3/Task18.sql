CREATE TABLE employee_cost (
    BU VARCHAR(50),
    month DATE,
    employee_id INT,
    cost DECIMAL(10, 2),
    hours_worked INT
);

INSERT INTO employee_cost (BU, month, employee_id, cost, hours_worked) VALUES
('BU1', '2024-01-01', 1, 5000.00, 160),
('BU1', '2024-01-01', 2, 6000.00, 170),
('BU1', '2024-02-01', 1, 5500.00, 150),
('BU1', '2024-02-01', 3, 7000.00, 180),
('BU2', '2024-01-01', 4, 8000.00, 160),
('BU2', '2024-01-01', 5, 7500.00, 170),
('BU2', '2024-02-01', 4, 8200.00, 150),
('BU2', '2024-02-01', 6, 7300.00, 180);

SELECT 
    BU,
    DATEPART(YEAR, month) AS Year,
    DATEPART(MONTH, month) AS Month,
    ROUND(SUM(cost * hours_worked) * 1.0 / SUM(hours_worked), 2) AS weighted_avg_cost
FROM 
    employee_cost
GROUP BY 
    BU, DATEPART(YEAR, month), DATEPART(MONTH, month)
ORDER BY 
    BU, Year, Month;
