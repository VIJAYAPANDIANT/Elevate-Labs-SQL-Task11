CREATE DATABASE task11;

USE task11;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    department VARCHAR(50),
    salary INT,
    joining_date DATE
);


Insert large data :

INSERT INTO employees (name, email, department, salary, joining_date)
SELECT 
    CONCAT('Emp', n),
    CONCAT('emp', n, '@company.com'),
    IF(n % 5 = 0, 'HR', IF(n % 5 = 1, 'IT', IF(n % 5 = 2, 'Sales', IF(n % 5 = 3, 'Finance', 'Admin')))),
    FLOOR(RAND() * 50000 + 30000),
    DATE_ADD('2015-01-01', INTERVAL FLOOR(RAND()*3000) DAY)
FROM (
    SELECT @row := @row + 1 AS n
    FROM information_schema.tables, (SELECT @row := 0) r
    LIMIT 100000
) t;


--- right-Now you have 100k rows → perfect for testing.

--Slow Query (Before Index)
SELECT * 
FROM employees 
WHERE department = 'IT';


--Measure execution time in MySQL Workbench:

--Enable Query Execution Time

--Run query multiple times

Explain without index
EXPLAIN SELECT * FROM employees WHERE department = 'IT';


--Output observation:

type: ALL

rows: 100000

Full table scan

--Create Index (Performance Optimization)
CREATE INDEX idx_department ON employees(department);

--Same Query (After Index)
SELECT * 
FROM employees 
WHERE department = 'IT';

--Explain with index
EXPLAIN SELECT * FROM employees WHERE department = 'IT';


--Output observation:

type: ref

key: idx_department

rows: ~20000

Index lookup instead of full scan

--Multi-Column Index Example
SELECT * 
FROM employees
WHERE department = 'IT' AND salary > 70000;


Create composite index:

CREATE INDEX idx_dept_salary ON employees(department, salary);


--Run query again

EXPLAIN SELECT * 
FROM employees
WHERE department = 'IT' AND salary > 70000;

--Demonstrates index order matters

--When Indexes HURT Performance ❌
Example 1: Small table

Indexes are useless for very small tables.

Example 2: Too many indexes
INSERT INTO employees (name, email, department, salary, joining_date)
VALUES ('Test', 'test@x.com', 'IT', 50000, '2023-01-01');


--Insert is slower because:

Every index must be updated

Example 3: Low-cardinality column
CREATE INDEX idx_gender ON employees(department);


If most rows have same value → index not effective.

--Clustered vs Non-Clustered Index
MySQL (InnoDB)

Clustered Index → Primary Key

Table data stored with primary key order

Only ONE clustered index

Non-Clustered Index

Secondary index

Stores index + pointer to primary key

Multiple allowed

Example:

PRIMARY KEY (emp_id)   -- Clustered
INDEX (department)    -- Non-clustered