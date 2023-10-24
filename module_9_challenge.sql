-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE Salaries (
    "salary_id" SERIAL   NOT NULL,
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "salary_id"
     )
);

CREATE TABLE Employees (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(225)   NOT NULL,
    "birth_date" VARCHAR(225)   NOT NULL,
    "first_name" VARCHAR(225)   NOT NULL,
    "last_name" VARCHAR(225)   NOT NULL,
    "sex" VARCHAR(225)   NOT NULL,
    "hire_date" VARCHAR(225)   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE Department_Emp (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(225)   NOT NULL
);

CREATE TABLE Department_Manager (
    "dept_no" VARCHAR(225)   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE Titles (
    "title_id" VARCHAR(225)   NOT NULL,
    "title" VARCHAR(225)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE Department (
    "dept_no" VARCHAR(225)   NOT NULL,
    "dept_name" VARCHAR(225)   NOT NULL,
    CONSTRAINT "pk_Department" PRIMARY KEY (
        "dept_no"
     )
);

ALTER TABLE Salaries ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES Employees ("emp_no");

ALTER TABLE Employees ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES Titles ("title_id");

ALTER TABLE Department_Emp ADD CONSTRAINT "fk_Department_Emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES Employees ("emp_no");

ALTER TABLE Department_Emp ADD CONSTRAINT "fk_Department_Emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES Department ("dept_no");

ALTER TABLE Department_Manager ADD CONSTRAINT "fk_Department_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES Department ("dept_no");

ALTER TABLE Department_Manager ADD CONSTRAINT "fk_Department_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES Employees ("emp_no");

SELECT * FROM department
SELECT * FROM department_emp
SELECT * FROM employees
SELECT * FROM titles
SELECT * FROM department_manager
SELECT * FROM salaries


--List the employee number, last name, first name, sex, and salary of each employee

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries 
ON employees.emp_no = salaries.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986

SELECT first_name, last_name, hire_date
FROM employees
WHERE cast(hire_date as date) BETWEEN '1/1/1986' AND '12/31/1986'
ORDER BY hire_date;

-- List the manager of each department along with their department number, department name, employee number, last name, and first name

SELECT employees.first_name, employees.last_name, department.dept_name, department_manager.dept_no, department_manager.emp_no
FROM employees
JOIN department_manager 
ON employees.emp_no = department_manager.emp_no
JOIN department
ON department.dept_no = department_manager.dept_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name
SELECT employees.first_name, employees.last_name, department.dept_name, department_emp.dept_no, employees.emp_no
FROM department
JOIN department_emp
ON department.dept_no = department_emp.dept_no
JOIN employees
ON employees.emp_no = department_emp.emp_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B 
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name
SELECT department.dept_name, employees.last_name, employees.first_name
FROM department_emp
JOIN employees
ON department_emp.emp_no = employees.emp_no
JOIN department
ON department_emp.dept_no = department.dept_no
WHERE department.dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT department.dept_name, employees.last_name, employees.first_name, employees.emp_no
FROM department_emp
JOIN employees
ON department_emp.emp_no = employees.emp_no
JOIN department
ON department_emp.dept_no = department.dept_no
WHERE department.dept_name = 'Sales' OR department.dept_name = 'Development';

-- List the frequency counts, in descending order, of all the employee last names
SELECT last_name, count(last_name) AS "Last Name Frequency"
FROM employees
GROUP BY last_name
ORDER BY "Last Name Frequency" desc;