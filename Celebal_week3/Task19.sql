CREATE TABLE EMPLOYEES (
    employee_id INT,
    salary DECIMAL(10, 2)
);

INSERT INTO EMPLOYEES (employee_id, salary) VALUES
(1, 5000.00),
(2, 6000.00),
(3, 7000.00),
(4, 8000.00),
(5, 9000.00),
(6, 10000.00);

WITH SalaryCalculations AS (
    SELECT 
        AVG(salary) AS actual_avg_salary,
        AVG(CAST(REPLACE(CAST(salary AS VARCHAR), '0', '') AS DECIMAL(10, 2))) AS miscalculated_avg_salary
    FROM EMPLOYEES
)
SELECT 
    CEILING(actual_avg_salary - miscalculated_avg_salary) AS error_amount
FROM 
    SalaryCalculations;
