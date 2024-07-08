CREATE TABLE employee_data (
    employee_id INT,
    employee_name VARCHAR(50),
    salary DECIMAL(10, 2)
);

INSERT INTO employee_data (employee_id, employee_name, salary) VALUES
(1, 'Alice', 90000.00),
(2, 'Bob', 120000.00),
(3, 'Charlie', 110000.00),
(4, 'David', 95000.00),
(5, 'Eve', 115000.00),
(6, 'Frank', 105000.00),
(7, 'Grace', 95000.00),
(8, 'Heidi', 80000.00),
(9, 'Ivan', 125000.00),
(10, 'Judy', 85000.00);

SELECT employee_id, employee_name, salary
FROM employee_data e1
WHERE 5 > (
    SELECT COUNT(DISTINCT salary)
    FROM employee_data e2
    WHERE e2.salary > e1.salary
);
