--All columns for every employee--
SELECT * FROM employees;
--Only name and salary--
SELECT name, salary FROM employees;
--Show employees in the Sales department--
SELECT name, salary FROM employees
WHERE department='Sales';
--Show employees with salary above 60000--
SELECT name, salary FROM employees
WHERE salary>60000;
--Show employees from Delhi or Pune (with OR, then with IN)--
SELECT name, salary FROM employees
WHERE city='Delhi' OR city='Pune';
SELECT name, salary FROM employees
WHERE city IN ('Delhi', 'Pune');
--Show employees hired during 2022 (USE BETWEEN)--
SELECT name, salary FROM employees
WHERE hire_date BETWEEN '2022-01-01' AND '2022-12-31';
--Show employees whose name starts with A (LIKE)--
SELECT name, salary FROM employees
WHERE name LIKE 'A%';
--Show the unique departments (DISTINCT)--
SELECT DISTINCT department 
FROM employees;
--Show employees with a missing salary (IS NULL, also try = NULL once to see why it fails)--
SELECT name FROM employees
WHERE salary IS NULL;
--Show the top 3 highest-paid employees (ORDER BY ... DESC, LIMIT)--
SELECT name, salary FROM employees
ORDER BY salary DESC
LIMIT 3;
-- Q9 experiment: the wrong way
SELECT name, salary FROM employees
WHERE salary = NULL;