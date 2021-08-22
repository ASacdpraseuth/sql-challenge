DROP TABLE titles CASCADE;
DROP TABLE departments CASCADE;
DROP TABLE employees CASCADE;
DROP TABLE dept_emp;
DROP TABLE dept_manager;
DROP TABLE salaries;

CREATE TABLE titles (
	title_id VARCHAR NOT NULL,
	title VARCHAR NOT NULL,
	PRIMARY KEY (title_id)
);

COPY titles FROM 'D:\Users\alex\Documents\GitHub\sql-challenge\data\titles.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE departments (
	dept_no VARCHAR NOT NULL,
	dept_name VARCHAR NOT NULL,
	PRIMARY KEY (dept_no)
);

COPY departments FROM 'D:\Users\alex\Documents\GitHub\sql-challenge\data\departments.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE employees (
	emp_no INT NOT NULL,
	emp_title_id VARCHAR NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

COPY employees FROM 'D:\Users\alex\Documents\GitHub\sql-challenge\data\employees.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

COPY dept_emp FROM 'D:\Users\alex\Documents\GitHub\sql-challenge\data\dept_emp.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

COPY dept_manager FROM 'D:\Users\alex\Documents\GitHub\sql-challenge\data\dept_manager.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary int NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

COPY salaries FROM 'D:\Users\alex\Documents\GitHub\sql-challenge\data\salaries.csv' DELIMITER ',' CSV HEADER;

SELECT * FROM titles;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;

/*
Data Analysis
1. List the following details of each employee: employee number, last name, first name, sex, and salary.
*/

SELECT 
employees.emp_no, 
employees.last_name, 
employees.first_name, 
employees.sex, 
salaries.salary
FROM employees
INNER JOIN salaries 
ON employees.emp_no = salaries.emp_no;

/*
2. List first name, last name, and hire date for employees who were hired in 1986.
*/

SELECT 
emp_no, 
first_name, 
last_name, 
hire_date 
FROM employees
WHERE hire_date > '1985-12-31'
AND hire_date < '1987-01-01';

/*
3. List the manager of each department with the following information: 
department number, department name, the manager's employee number, last name, first name.
*/

SELECT 
dept_manager.dept_no,
departments.dept_name,
dept_manager.emp_no,
employees.last_name,
employees.first_name
FROM dept_manager
INNER JOIN departments
ON dept_manager.dept_no = departments.dept_no
INNER JOIN employees
ON dept_manager.emp_no = employees.emp_no;

/*
4. List the department of each employee with the following information: 
employee number, last name, first name, and department name.
*/

SELECT
employees.emp_no,
employees.last_name,
employees.first_name,
departments.dept_name
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no;

/*
5. List first name, last name, and sex 
for employees whose first name is "Hercules" and last names begin with "B."
*/

SELECT
first_name,
last_name,
sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

/*
6. List all employees in the Sales department, 
including their employee number, last name, first name, and department name.
*/

SELECT
employees.emp_no,
employees.last_name,
employees.first_name,
departments.dept_name
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE dept_name = 'Sales';

/*
7. List all employees in the Sales and Development departments,
including their employee number, last name, first name, and department name.
*/

SELECT
employees.emp_no,
employees.last_name,
employees.first_name,
departments.dept_name
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE dept_name = 'Sales'
OR dept_name = 'Development';

/*
8. In descending order, list the frequency count of employee last names, 
i.e., how many employees share each last name.
*/

SELECT
last_name,
COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;








