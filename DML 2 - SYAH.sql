# Sub Queries Method
use employees;
show tables;

select emp_no, avg(salary) as avg_salary
from salaries
group by emp_no
having avg_salary > avg(salary); # TIDAK BISA

select emp_no, avg(salary) as avg_salary
from salaries
where avg_salary >(select avg(salary) from salaries) # PAKE WHERE
group by emp_no; # TIDAK BISA 


select emp_no, avg(salary) as avg_salary
from salaries
group by emp_no
having avg_salary > (
					select avg(salary) 
                    from salaries); # BISA


# Subqueries Method in Different Tables
show tables;
select *
from titles;
select *
from employees;

select first_name, last_name
from employees
where emp_no in (
				select emp_no 
                from titles 
				where title = 'Senior Engineer');

# Query 1: Shows the name of the employee who has a salary above USD 60,000
# Query Code:

SELECT first_name, last_name
FROM employees
WHERE emp_no in (
					SELECT emp_no
                    FROM salaries
                    WHERE salary >= 60000
                    );

# Query 2: Average senior staff salary per employee
# Query Code:

select emp_no, avg(salary)
from salaries
group by emp_no
having emp_no in (
				select emp_no 
                from titles 
                where title = 'Senior Staff');


# ---------------------------------
# Implicit Join Methods

# Query 3: Show the full names of all staff in order of the letter A
select e.first_name, e.last_name, t.title
from employees as e, titles as t
where e.emp_no = t.emp_no
order by e.first_name, e.last_name;

select employees.first_name, employees.last_name, titles.title
from employees, titles
where employees.emp_no = titles.emp_no;

select e.first_name, e.last_name, t.title
from employees as e, titles as t
where e.emp_no = t.emp_no;

select employees.first_name, employees.last_name, titles.title
from employees, titles;

# Query 4
select e.first_name, e.last_name, t.title
from employees as e, titles as t
where e.emp_no = t.emp_no and t.title = 'staff'
order by e.first_name, e.last_name;

# Query 5
# Query Code
SELECT e.first_name, e.last_name, avg(s.salary) as gaji
FROM employees AS e, salaries AS s
WHERE e.emp_no = s.emp_no
GROUP BY s.emp_no
ORDER BY gaji DESC
LIMIT 5;

select e.first_name, e.last_name, avg(s.salary) as gaji
from employees as e, salaries as s
where e.emp_no = s.emp_no
group by e.emp_no
order by gaji desc
limit 5;

# ---------------------------------
# Inner Join Methods
# Query 7

select e.first_name, e.last_name, t.title
from employees as e, titles as t
where e.emp_no = t.emp_no; # format implicit join

select e.first_name, e.last_name, t.title
from employees as e join titles as t
on e.emp_no = t.emp_no; # format inner join

select e.first_name, e.last_name, t.title, avg(s.salary)
from employees as e 
					join titles as t on e.emp_no = t.emp_no
                    join salaries as s on e.emp_no = s.emp_no
group by e.first_name, e.last_name, t.title; # bisa 3 tabel

select e.first_name, e.last_name, t.title, avg(s.salary)
from employees as e 
					join titles as t on e.emp_no = t.emp_no
                    join salaries as s on e.emp_no = s.emp_no
group by 1,2,3; # cara singkat


select e.first_name, e.last_name, t.title, avg(s.salary)
from employees as e 
					join titles as t on e.emp_no = t.emp_no
                    join salaries as s on e.emp_no = s.emp_no
group by 1,2,3; # shortcut way


select e.first_name, e.last_name, t.title, avg(s.salary)
from employees as e
					join titles as t on e.emp_no = t.emp_no 
                    join salaries as s on e.emp_no = s.emp_no 
group by 1,2,3
limit 10; # shortcut way

show tables;

select *
from departments;

select *
from employees;

select *
from dept_emp;

select e.first_name, e.last_name, d.dept_name
from dept_emp
			join employees as e on dept_emp.emp_no = e.emp_no
            join departments as d on dept_emp.dept_no = d.dept_no;
            
            
# ---------------------------------           
# CTE Methods
# Query 8: Three departments that have the highest average salary?


select *
from dept_emp;

select *
from departments;

select *
from salaries;

SELECT d.dept_name as departement, AVG(s.salary) as gaji
FROM departments as d
		JOIN dept_emp as dept ON d.dept_no = dept.dept_no
		JOIN salaries as s ON dept.emp_no = s.emp_no
GROUP BY 1
ORDER BY gaji DESC
LIMIT 3;

# Query 9: Average age of employees in each department and sorted by youngest.

SELECT 
    d.dept_name,
    avg(DATE_FORMAT(CURRENT_DATE(), '%Y') - DATE_FORMAT(e.birth_date, '%Y') - 
    (DATE_FORMAT(CURRENT_DATE(), '00-%m-%d') < DATE_FORMAT(e.birth_date, '00-%m-%d'))) AS umur
FROM 
    dept_emp
JOIN 
    departments AS d ON dept_emp.dept_no = d.dept_no
JOIN 
    employees AS e ON dept_emp.emp_no = e.emp_no
group by d.dept_no
order by umur asc;

select 2024 - year(birth_date) as umur 
from employees;

select d.dept_name, avg(2024 - year(e.birth_date)) as umur
from dept_emp as de
			join departments as d on de.dept_no = d.dept_no
            join employees as e on de.emp_no = e.emp_no
group by d.dept_name
order by umur desc;

select d.dept_name, avg(2024 - year(e.birth_date)) as umur
from dept_emp as de
			join departments as d on de.dept_no = d.dept_no
            join employees as e on de.emp_no = e.emp_no
group by 1
order by umur desc	;

SELECT d.dept_name, avg(2024 - year(e.birth_date)) as umur
FROM dept_emp as de
			join departments as d on de.dept_no = d.dept_no
            join employees as e on de.emp_no = e.emp_no
GROUP BY 1
ORDER BY umur desc;

# Query 10: 5 highest-paid managers and their departments

select e.first_name, e.last_name, d.dept_name, avg(s.salary) as gaji
from dept_manager as dm
        join employees as e on e.emp_no = dm.emp_no
		join departments as d on d.dept_no = dm.dept_no
        join salaries as s on s.emp_no = dm.emp_no
group by 1,2,3
order by 4 desc
limit 5;



            








