CREATE TABLE simulation_data (
    job_family VARCHAR(50),
    country VARCHAR(50),
    cost DECIMAL(10, 2)
);

INSERT INTO simulation_data (job_family, country, cost) VALUES
('Engineering', 'India', 10000.00),
('Engineering', 'USA', 5000.00),
('Marketing', 'India', 8000.00),
('Marketing', 'UK', 7000.00),
('Sales', 'India', 6000.00),
('Sales', 'Germany', 9000.00),
('Engineering', 'India', 7000.00),
('Engineering', 'Canada', 4000.00),
('Marketing', 'India', 3000.00),
('Marketing', 'Australia', 2000.00),
('Sales', 'India', 1000.00),
('Sales', 'Japan', 5000.00);

SELECT 
    job_family,
    ROUND(SUM(CASE WHEN country = 'India' THEN cost ELSE 0 END) * 100.0 / SUM(cost), 2) AS india_cost_percentage,
    ROUND(SUM(CASE WHEN country != 'India' THEN cost ELSE 0 END) * 100.0 / SUM(cost), 2) AS international_cost_percentage
FROM 
    simulation_data
GROUP BY 
    job_family;
