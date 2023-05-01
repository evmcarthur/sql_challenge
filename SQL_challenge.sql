DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

--create departments table 
CREATE TABLE departments (
  dept_no varchar(45) NOT NULL Primary Key,
  dept_name varchar(45) NOT NULL);

--create department employee table
CREATE TABLE dept_emp (
  emp_no integer NOT NULL,
  dept_no character varying(45) NOT NULL);

--create department manager table
CREATE TABLE dept_manager (
    dept_no character varying(45) NOT NULL,
    emp_no integer NOT NULL
);
--create employees table
CREATE TABLE employees (
  emp_no integer NOT NULL,
  emp_title_id character varying(45) NOT NULL,
  birth_date date NOT NULL,
first_name character varying(45) NOT NULL,
  last_name character varying(45) NOT NULL,
  sex character varying(50) NOT null,
  hire_date date NOT NULL
);

--create salaries table
CREATE TABLE salaries(
  emp_no integer NOT NULL,
  salary integer NOT null
	);

--create title table 
CREATE TABLE titles(
	title_id character varying(45) NOT NULL, 
	title character varying(45) NOT NULL
);

--check that data is loaded 
select *
From employees;

--List the following details of each employee: employee number, last name, first name, sex, and salary
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no= s.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
LIMIT 5;

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager dm
INNER JOIN employees e ON dm.emp_no = e.emp_no
INNER JOIN departments d ON dm.dept_no = d.dept_no
INNER JOIN titles t ON e.emp_title_id = t.title_id
WHERE t.title = 'Manager';

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no;

--List the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(*) as frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;


