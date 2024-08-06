# Query 1

with
	rata_gaji as (select emp_no, avg(salary) gaji
	from salaries
	group by 1),

	full_name as (select emp_no, first_name, last_name
	from employees)
    
select f.first_name, f.last_name, r.gaji
from rata_gaji as r, full_name f
where r.emp_no = f.emp_no;

# Query 2: Slide 11
select d.dept_name as department, avg(s.salary) as gaji
from dept_emp
	join departments d on dept_emp.dept_no = d.dept_no
    join salaries s on dept_emp.emp_no = s.emp_no
group by 1
order by gaji desc
limit 3;

with 
	tabel_pertama as (select dept_no, emp_no 
	from dept_emp),
    
    tabel_kedua as (select dept_no, dept_name
    from departments),
    
    tabel_ketiga as (select emp_no, salary as gaji
    from salaries)
    
select dua.dept_name, avg(tiga.gaji) as gaji
from tabel_pertama as satu
	join tabel_kedua as dua on satu.dept_no = dua.dept_no
    join tabel_ketiga as tiga on satu.emp_no = tiga.emp_no
group by 1;


# ----------------------------------------------

# WINDOW FUNCTION

-- over()
select avg(salary) as rata_rata_gaji
from salaries;

select emp_no, salary, avg(salary) over() # dimunculkan pada setiap baris
from salaries;

-- over(partition by)
select emp_no, avg(salary) over(partition by emp_no)
from salaries; # jumlah baris tidak berubah

select emp_no, avg(salary)
from salaries
group by emp_no; # jumlah baris akan sejumlah count distinct (unique)


-- row_number() over () # nambah nomor
select row_number () over() as nomor, emp_no, first_name, last_name
from employees; 

-- rank() over(order by)
select emp_no,rank() over(order by avg(salary) desc) as ranking_gaji, avg(salary) as rata_rata_gaji
from salaries
group by 1;

-- ntile() over(partition by) = ntile() over(order by)
select emp_no, salary, ntile(4) over(partition by salary)
from salaries
order by 3 desc;












