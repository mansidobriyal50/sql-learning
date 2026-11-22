--1.Top earner per department (rewrite your day 3 Q2 using a CTE).
WITH ranked AS(
    SELECT *,
    ROW_NUMBER() OVER(
        PARTITION BY department
        ORDER BY salary DESC
    ) rn
    FROM employees
    WHERE salary IS NOT NULL
)
SELECT * FROM ranked
WHERE rn=1;
--2.Top 2 earners per department.
WITH ranked AS(
    SELECT *,
    ROW_NUMBER() OVER(
        PARTITION BY department
        ORDER BY salary DESC
    ) rn
    FROM employees
    WHERE salary IS NOT NULL
)
SELECT * FROM ranked
WHERE rn<=2;
--3.Second highest salary overall. Try it with DENSE_RANK in a CTE.
WITH ranked AS(
    SELECT *,
    DENSE_RANK() OVER(
        ORDER BY salary DESC
    ) rnk
    FROM employees
)
SELECT * FROM ranked
WHERE rnk=2;
--4.Employees earning above their department average. 
WITH dept_avg AS(
    SELECT department, AVG(salary) AS avg_sal
    FROM employees
    GROUP BY department
)
SELECT e.*
FROM employees e
JOIN dept_avg d
ON e.department=d.department
WHERE e.salary>d.avg_sal;
--5.Chaining: CTE 1 computes average salary per department, CTE 2 keeps only departments above 60000, and the final query lists the employees in those departments.
WITH dept_avg AS(
    SELECT department, AVG(salary) AS avg_sal
    FROM employees
    GROUP BY department
),
high_depts AS(
    SELECT department
    FROM dept_avg
    WHERE avg_sal>60000
)
SELECT e.name, e.department, e.salary 
FROM employees e
JOIN high_depts h
ON e.department=h.department;
--6.Recursive CTE (just to see it run): the org chart. Print each employee with their level in the hierarchy, starting from people with no manager.
WITH RECURSIVE org AS(
    SELECT id, name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.id, e.name, e.manager_id, o.level + 1
    FROM employees e
    JOIN org o
    ON e.manager_id=o.id
)
SELECT name, level FROM org 
ORDER BY level, name;


