--1.Count employees in each department (GROUP BY).
SELECT department, COUNT(*) AS employee_count
FROM employees 
GROUP BY department;
--2.Show departments with an average salary above 60000 (HAVING).
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary)>60000;
-- 3. Employee with manager name (self-join)
SELECT e.name, m.name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id=m.id;
--4.Show employees earning more than the company average salary (a subquery in WHERE).
SELECT name, salary FROM employees
WHERE salary>
(
    SELECT AVG(salary) FROM employees
);
-- 5. UNION vs UNION ALL
SELECT city FROM employees
WHERE department='Sales'
UNION
SELECT city FROM employees
WHERE department='HR';
SELECT city FROM employees
WHERE department='Sales'
UNION ALL
SELECT city FROM employees
WHERE department='HR';