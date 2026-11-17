-- 1. Rank employees by salary within each department using ROW_NUMBER, RANK, and DENSE_RANK side by side.
SELECT name, department, salary,
ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS rnk,
DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dense_rnk
FROM employees;
-- 2. Top earner in each department (rank in a subquery, filter = 1).
SELECT * FROM(
    SELECT name, department, salary,
    RANK() OVER(
        PARTITION BY department
        ORDER BY salary DESC
    ) AS rnk
    FROM employees
    WHERE salary IS NOT NULL
) t
WHERE rnk=1;
--3. Top 2 earners in each department.
SELECT * FROM(
    SELECT name, department, salary,
    DENSE_RANK() OVER(
        PARTITION BY department
        ORDER BY salary DESC
    ) AS rnk
    FROM employees
    WHERE salary IS NOT NULL
) t
WHERE rnk<=2;
--4. Each employee’s salary minus their department average.
SELECT name, department, salary,
salary - AVG(salary) OVER(PARTITION BY department) AS diff_from_avg
FROM employees;
--5. Running total of salary ordered by hire date.
SELECT name, hire_date, salary, SUM(salary) OVER(
    ORDER BY hire_date
) AS running_total
FROM employees;
--6. Each employee’s previous and next hire’s salary (LAG and LEAD by hire_date).
SELECT name, salary, LAG(salary) OVER(
    ORDER BY hire_date
) AS previous_salary
FROM employees;
SELECT name, salary, LEAD(salary) OVER(
    ORDER BY hire_date
) AS next_salary
FROM employees;
--7. Ties test: temporarily run this and compare the three rank columns:
SELECT name, salary,
RANK() OVER(ORDER BY salary DESC) AS rnk,
DENSE_RANK() OVER(ORDER BY salary DESC) AS dense_rnk
FROM (SELECT 'A' AS name, 100 AS salary UNION ALL
SELECT 'B', 100 UNION ALL
SELECT 'C', 90 UNION ALL
SELECT 'D', 80);
--8. Moving average over current and previous 2 rows
SELECT name, salary, hire_date, AVG(salary) OVER(
    ORDER BY hire_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS moving_avg
FROM employees;