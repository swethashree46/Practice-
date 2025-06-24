use techm;
create table departments(
dept_id int primary key,
dept_name varchar(45),
location varchar(50)
);

select * from departments;
commit;

create table employees(
emp_id int primary key,
emp_name varchar(50),
dept_id int,
salary int, 
hiredate date,
foreign key (dept_id) references departments(dept_id));

insert into employees values (1,'Alice',10,60000,'2020-01-15'),(2,'Bob',20,75000,'2019-03-10'),(3,'Charlie',10,55000,'2021-06-20'),(4,'Dave',20,80000,'2018-09-05'),(5,'Eve',30,50000,'2022-02-10');
commit;

select * from employees;

create table projects(
project_id int primary key,
emp_id int,
project_name varchar(50),
start_data date,
foreign key (emp_id) references employees(emp_id));

insert into projects values (101,1,'Project A','2023-01-01'),(102,2,'Project B','2023-02-15'),(103,1,'Project C','2023-03-10'),(104,3,'Project D','2023-04-01');

commit;
select * from projects;

-- Question 1: Find Employees Earning More Than Their Department’s Average Salary

select * from employees where salary > (select Avg(e.salary) from employees e join departments d on e.dept_id=d.dept_id);
-- Question 2: Find Employees Who Worked on All Projects in Their Department
 
 select e.emp_name from employees e inner join departments d on e.dept_id=d.dept_id inner join projects p on e.emp_id=p.emp_id group by e.emp_id;
 
-- Question 3: Find the Highest-Paid Employee in Each Department Who Started After 2020
 select max(salary) 'maximum salary',dept_id from employees where hiredate>'2020-12-31' group by dept_id;
-- Question 4: Find Departments Where All Employees Earn Above a Certain Threshold
 select d.dept_name from departments d inner join employees e on e.dept_id=d.dept_id group by d.dept_id having min(e.salary)>50000;