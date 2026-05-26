CREATE DATABASE sql_practice;
USE sql_practice;

-- =========================
-- DEPARTMENTS TABLE
-- =========================

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO departments VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Sales'),
(105, 'Marketing');

-- =========================
-- EMPLOYEES TABLE
-- =========================

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10,2),
    experience INT,
    hire_date DATE
);

INSERT INTO employees VALUES
(1, 'Ravi', 'Kumar', 101, 65000, 5, '2022-03-15'),
(2, 'Sneha', 'Reddy', 102, 48000, 3, '2024-01-10'),
(3, 'Arjun', 'Mehta', 101, 72000, 7, '2021-06-20'),
(4, 'Suresh', 'Naidu', 103, 85000, 10, '2020-09-05'),
(5, 'Priya', 'Sharma', 104, 45000, 2, '2024-02-18'),
(6, 'Sunil', 'Patel', 101, 65000, 6, '2023-05-11'),
(7, 'Divya', 'Rao', 105, 52000, 4, '2022-12-01'),
(8, 'Sanjay', 'Verma', 104, 39000, 1, '2024-04-14'),
(9, 'Keerthi', 'Iyer', 102, 58000, 5, '2023-08-19'),
(10, 'Manoj', 'Singh', 103, 91000, 12, '2019-07-25'),
(11, 'Sathvik', 'Roy', 105, 47000, 2, '2024-03-12'),
(12, 'Lakshmi', 'Devi', 101, 78000, 8, '2021-11-30');

-- =========================
-- PRODUCTS TABLE
-- =========================

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 75000),
(2, 'Mouse', 'Electronics', 800),
(3, 'Keyboard', 'Electronics', 1500),
(4, 'Table', 'Furniture', 5000),
(5, 'Chair', 'Furniture', 2500),
(6, 'Mobile', 'Electronics', 30000),
(7, 'Sofa', 'Furniture', 18000),
(8, 'Monitor', 'Electronics', 12000),
(9, 'Bottle', 'Accessories', 500),
(10, 'Bag', 'Accessories', 2200);

-- =========================
-- STUDENTS TABLE
-- =========================

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    marks INT
);

INSERT INTO students VALUES
(1, 'Akhil', 88),
(2, 'Bhavana', 72),
(3, 'Charan', 91),
(4, 'Deepika', 65),
(5, 'Eswar', 79),
(6, 'Farah', 95),
(7, 'Gokul', 68),
(8, 'Harini', 84),
(9, 'Irfan', 59),
(10, 'Jyothi', 76);

-- =========================
-- CUSTOMERS TABLE
-- =========================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO customers VALUES
(1, ' Ramesh ', 'ramesh@gmail.com'),
(2, 'Sita', 'sita@gmail.com'),
(3, 'Aravind', 'aravind@gmail.com'),
(4, 'Nikhil', 'nikhil@gmail.com'),
(5, 'Pooja', 'pooja@gmail.com'),
(6, 'Meghana', 'meghana@gmail.com');

-- =========================
-- ORDERS TABLE
-- =========================

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    delivery_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO orders VALUES
(1001, 1, '2026-01-10', '2026-01-15', 5000),
(1002, 2, '2026-02-05', '2026-02-10', 12000),
(1003, 1, '2026-02-20', '2026-02-25', 3000),
(1004, 3, '2026-03-01', '2026-03-06', 7500),
(1005, 4, '2026-03-15', '2026-03-19', 4200),
(1006, 5, '2026-04-10', '2026-04-14', 9800),
(1007, 2, '2026-04-22', '2026-04-28', 6100),
(1008, 6, '2026-05-05', '2026-05-11', 15000);

-- =========================
-- SALES TABLE
-- =========================

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE,
    sales_amount DECIMAL(10,2)
);

INSERT INTO sales VALUES
(1, '2026-01-01', 5000),
(2, '2026-01-03', 7000),
(3, '2026-01-05', 4000),
(4, '2026-01-07', 6500),
(5, '2026-01-10', 9000),
(6, '2026-01-12', 3000),
(7, '2026-01-15', 8500),
(8, '2026-01-18', 10000);

SELECT * FROM departments;
SELECT * FROM employees; 
SELECT * FROM products;
SELECT * FROM students;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM sales;

-- 1. Display employees whose salary is greater than the average salary of all employees.
SELECT * FROM employees
WHERE salary >  (SELECT AVG(salary) 
				FROM employees);
			
-- 2. Find employees who work in the same department as employee 'Ravi'.            
SELECT * FROM employees
WHERE department_id in (SELECT department_id
						FROM employees
						WHERE emp_id = 1);

-- 3. Display products whose price is higher than the minimum product price
SELECT * FROM products
WHERE price > (SELECT MIN(price) FROM products);
					
-- 4. Find students who scored more than the average marks.
SELECT * FROM students
WHERE marks > (SELECT AVG(marks) FROM students);

-- 5. Display employees whose salary is equal to the highest salary.
SELECT first_name,last_name,salary FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

-- 6. Find customers who placed at least one order.
SELECT DISTINCT c.customer_id, c.customer_name 
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

-- 7. Display employees who are not working in department 101.
SELECT emp_id FROM employees e 
JOIN departments d
ON e.department_id = d.dept_id
WHERE department_id NOT IN (SELECT department_id 
							FROM employees 
							WHERE department_id = 101);
                            
                            
-- 8. Find products that belong to the same category as product 'Laptop'.
SELECT * FROM products 
WHERE category = (SELECT category FROM products 
				  WHERE product_name = 'Laptop');
                  

-- 9. Display employees whose experience is greater than the minimum experience.
SELECT * FROM employees
WHERE experience > (SELECT MIN(experience) FROM employees);


-- 10. Find departments where the average salary is greater than 50000.
SELECT d.dept_name,
       a.avg_salary
FROM (SELECT department_id,
		AVG(salary) AS avg_salary
        FROM employees
        GROUP BY department_id
        HAVING AVG(salary) > 50000) a
JOIN departments d
ON a.department_id = d.dept_id;


-- 11. Display employee names in uppercase using a string function.
SELECT UPPER(first_name),UPPER(last_name) FROM employees;

-- 12. Display the first 3 characters of each product name.
SELECT product_name, LEFT(product_name, 3) AS first_3_characters
FROM products;

-- 13. Find the length of each customer name. 
SELECT length(customer_name) AS length_of_customers FROM customers ;

-- 14. Replace 'gmail.com' with 'yahoo.com' in customer emails.
SET SQL_SAFE_UPDATES = 0;
UPDATE customers
SET email = REPLACE(email, 'gmail.com', 'yahoo.com');

-- 15. Display employee names after removing leading and trailing spaces.
SELECT customer_name,TRIM(customer_name) AS cleaned_name
FROM customers;

-- 16. Concatenate first name and last name as full name.
SELECT first_name, last_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;

-- 17. Display product names in lowercase.
SELECT product_name, LOWER(product_name) FROM products;

SELECT * FROM departments;
SELECT * FROM employees; 
SELECT * FROM products;
SELECT * FROM students;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM sales;

-- 18. Find employees whose names start with letter 'S'.
SELECT * FROM employees
WHERE first_name LIKE 'S%';

-- 19. Display current system date.
SELECT current_date();

-- 20. Find employees hired in the year 2024.
SELECT * FROM employees
WHERE YEAR(hire_date) = 2024;

-- 21. Display the month from each order date.
SELECT MONTHNAME(order_date) AS Order_Date
FROM orders;

-- 22. Find the difference in days between order date and delivery date.
SELECT order_id, DATEDIFF(delivery_date, order_date) AS days_difference
FROM orders;

-- 23. Display current date and current time separately.
SELECT current_date() AS 'Todays Date';
SELECT current_time() AS 'Current Time';

-- 24. Find employees who joined in the current month.
SELECT * FROM employees
WHERE MONTH(hire_date) = MONTH(current_date());

-- 25. Assign row numbers to employees based on salary in descending order.
SELECT emp_id,first_name,salary, ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;

-- 26. Assign ranks to students based on marks.
SELECT student_id,student_name,marks, rank() OVER(ORDER BY marks DESC) AS Ranks
FROM students;

-- 27. Assign dense ranks to employees based on salary.
SELECT first_name, salary, dense_rank() OVER(order by salary DESC) AS Dense_Ranks
FROM employees;

-- 28. Display the total salary of all employees beside each employee record using a window function
SELECT emp_id,first_name,salary,SUM(salary) OVER() AS total_salary
FROM employees;

-- 29. Display department-wise average salary beside each employee.
SELECT emp_id,
       first_name,
       department_id,
       salary,
       AVG(salary) OVER(PARTITION BY department_id) AS dept_avg_salary
FROM employees;

-- 30. Find cumulative sales total ordered by sale date.
SELECT sale_id,
       sale_date,
       sales_amount,
       SUM(sales_amount) OVER(ORDER BY sale_date) AS cumulative_sales
FROM sales;