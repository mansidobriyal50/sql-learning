import duckdb

con = duckdb.connect("data/practice.duckdb")
con.sql("""
create or replace table employees as
select id, name, department, city, salary, cast(hire_date as date) as hire_date, manager_id
from (values
 (1,'Aarav','Sales','Delhi',55000,'2022-03-15',NULL),
 (2,'Diya','Sales','Mumbai',48000,'2023-01-10',1),
 (3,'Rohan','Engineering','Bengaluru',90000,'2021-07-01',NULL),
 (4,'Isha','Engineering','Bengaluru',82000,'2022-09-12',3),
 (5,'Kabir','Engineering','Pune',76000,'2023-04-20',3),
 (6,'Meera','HR','Delhi',45000,'2020-11-05',NULL),
 (7,'Neel','HR','Mumbai',NULL,'2024-02-01',6),
 (8,'Anaya','Marketing','Delhi',52000,'2022-06-18',NULL),
 (9,'Vivaan','Marketing','Pune',47000,'2023-08-30',8),
 (10,'Sara','Sales','Bengaluru',51000,'2024-05-14',1),
 (11,'Arjun','Engineering','Delhi',95000,'2019-12-02',NULL),
 (12,'Tara','Finance','Mumbai',68000,'2021-03-22',NULL),
 (13,'Dev','Finance','Delhi',NULL,'2024-07-09',12),
 (14,'Pooja','Marketing','Mumbai',49000,'2022-10-11',8),
 (15,'Yash','Sales','Pune',46000,'2023-11-27',1)
) t(id, name, department, city, salary, hire_date, manager_id)
""")
print("employees table created")