CREATE TABLE BU_Table (
    BU VARCHAR(50),
    month DATE,
    cost DECIMAL(10, 2),
    revenue DECIMAL(10, 2)
);

INSERT INTO BU_Table (BU, month, cost, revenue) VALUES
('BU1', '2024-01-01', 10000.00, 20000.00),
('BU1', '2024-02-01', 15000.00, 25000.00),
('BU1', '2024-03-01', 20000.00, 30000.00),
('BU2', '2024-01-01', 5000.00, 10000.00),
('BU2', '2024-02-01', 7000.00, 12000.00),
('BU2', '2024-03-01', 9000.00, 15000.00),
('BU3', '2024-01-01', 8000.00, 16000.00),
('BU3', '2024-02-01', 6000.00, 14000.00),
('BU3', '2024-03-01', 7000.00, 13000.00);

SELECT 
    BU,
    DATEPART(YEAR, month) AS Year,
    DATEPART(MONTH, month) AS Month,
    ROUND(SUM(cost) * 1.0 / SUM(revenue), 2) AS cost_revenue_ratio
FROM 
    BU_Table
GROUP BY 
    BU, DATEPART(YEAR, month), DATEPART(MONTH, month)
ORDER BY 
    BU, Year, Month;
