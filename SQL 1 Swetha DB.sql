USE SWETHALYTICS;
CREATE TABLE PERSON
(
PERSON_ID INT,
LASTNAME VARCHAR(255),
FIRSTNAME VARCHAR(255),
ADDRESS  VARCHAR(255),
CITY VARCHAR(255)
);

insert into person values(1,"rishmitha","vankadaru","1-55 near to union bank","nuzvid");

insert into person values(2,"rithu","varma","1-22 apartment","vijayawada"),(23,"giri","kanigolla","455 gokul theatre","eluru");

select * from person;
delete from person where person_id=23;
update person set firstname="junnu" where personid=1;
select * from person;

create table user(
userid int auto_increment ,
username varchar(255) unique not null,
email varchar(255)unique not null,
passwordHash varchar(255) not null,
firstname varchar(50),
lastname varchar(50),
dateOfBirth date,
createdAt datetime default current_timestamp, 
lastLogin datetime,
status enum('active','inactive','suspended') default 'active',
index(email),
primary key (userid)
); -- it is used to speed up searches using index
INSERT INTO user (username, email, passwordHash, firstname, lastname, dateOfBirth, createdAt, lastLogin, status)
VALUES ('anu', 'anu@gmail.com', 'anu@123', 'anu', 'radha', '2002-12-17', NOW(), NOW(), 'inactive');
select * from users;

create table student (
student_id int primary key,
name varchar(100),
age int,
check(age>18)
);
insert into student values(46,'Swetha',21);
create table enrollments(
enrollment_id int primary key,
student_id int,
course_id int,
foreign key (student_id) references student (student_id)
);
insert into enrollments values(546,46,005);

create table orderdetails (
order_id int,
product_id int,
quantity int,
primary key (order_id)
);

create table products (
product_id int,
product_name varchar(20),
price int
);

insert into products values(05,'diary',250),(46,'notes',300);
insert into products values(05,'pen',25),(46,'pencil',30);

desc products;
select * from products;

select min(price)
from products;

select max(price)
from products;

select sum(price) as total, product_id
from products
group by product_id;

select count(distinct product_id) as no_of_products
from products;

select avg(price) as average_price, product_id
from products
group by product_id
having avg(price)>140;

create table customers(
cust_id int primary key,
name varchar(100)
);

create table orders(
order_id int primary key,
cust_id int,
product_name varchar(100),
foreign key (cust_id) references customers(cust_id)
on delete cascade
);

insert into customers values(5,'swetha'),(46,'aravindh');
insert into orders values (111,5,'Heart'),(222,46,'Brain');

delete from customers where cust_id = 5;

select * from customers;

update customers 
set cust_id = 5
where name = 'aravindh';

create table emp(
emp_id int primary key,
emp_name varchar(20),
designation varchar(20),
salary int
);

insert into emp values(11,'swetha','analyst',1000000),(22,'shree','scientist',1200000),(33,'aravindh','developer',1500000);

select * from emp;

select *
from emp
order by salary desc;

select salary*12 as annual_salary, salary, emp_name, designation
from emp;

CREATE TABLE Customerstable (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ContactName VARCHAR(100),
    Country VARCHAR(50)
);
 
CREATE TABLE Orderstable (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customerstable(CustomerID)
);
 
INSERT INTO Customerstable (CustomerID, CustomerName, ContactName, Country) VALUES
(1, 'John Doe', 'John D.', 'USA'),
(2, 'Jane Smith', 'Jane S.', 'UK'),
(3, 'Alice Brown', 'Alice B.', 'Canada'),
(4, 'Bob Johnson', 'Bob J.', 'Australia');
 
INSERT INTO Orderstable (OrderID, OrderDate, CustomerID, Amount) VALUES
(101, '2024-09-01', 1, 250.00),
(102, '2024-09-05', 2, 300.00),
(103, '2024-09-07', 1, 150.00),
(104, '2024-09-10', 3, 450.00);
 truncate  table Customerstable;
 drop table Orderstable;
select 
Customertable.CustomerID,
Customertable.CustomerName,
Orderstable.Orderstable.CustommerID,
Orderstable.OrderDate,
Orderstable.Amount
from custommerstable
right join
Orderstable on Custommerstable.CustomerID = Orderstable.CustomerId;

CREATE TABLE Customersystem (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ContactName VARCHAR(100),
    Country VARCHAR(50)
);
 
CREATE TABLE Ordersystem(
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customerstable(CustomerID)
);

INSERT INTO Customersystem (CustomerID, CustomerName, ContactName, Country) VALUES
(1, 'John Doe', 'John D.', 'USA'),
(2, 'Jane Smith', 'Jane S.', 'UK'),
(3, 'Alice Brown', 'Alice B.', 'Canada'),
(4, 'Bob Johnson', 'Bob J.', 'Australia');
 
INSERT INTO Ordersystem (OrderID, OrderDate, CustomerID, Amount) VALUES
(101, '2024-09-01', 1, 250.00),
(102, '2024-09-05', 2, 300.00),
(103, '2024-09-07', 1, 150.00),
(104, '2024-09-10', 3, 450.00);

select 
Customersystem.CustomerID,
Customersystem.CustomerName,
Ordersystem.CustomerID,
Ordersystem.OrderDate,
Ordersystem.Amount
from Customersystem
right join
Ordersystem on Customersystem.CustomerID = Ordersystem.CustomerId;

select 
Customersystem.CustomerID,
Customersystem.CustomerName,
Ordersystem.CustomerID,
Ordersystem.OrderDate,
Ordersystem.Amount
from Customersystem
left join
Ordersystem on Customersystem.CustomerID = Ordersystem.CustomerId;

select 
Customersystem.CustomerID,
Customersystem.CustomerName,
Ordersystem.CustomerID,
Ordersystem.OrderDate,
Ordersystem.Amount
from Customersystem
cross join
Ordersystem on Customersystem.CustomerID = Ordersystem.CustomerId;

select 
Customersystem.CustomerID,
Customersystem.CustomerName,
Ordersystem.CustomerID,
Ordersystem.OrderDate,
Ordersystem.Amount
from Customersystem
inner join
Ordersystem on Customersystem.CustomerID = Ordersystem.CustomerId;

CREATE TABLE EMPLOYEE(
EMP_ID INT PRIMARY KEY,
ENAME VARCHAR(20),
JOB_DESC VARCHAR(25),
SALARY INT,
HIRE_DATE DATE
); 

INSERT INTO EMPLOYEE VALUES(111,'SWETHA','LEAD ANALYST',240000,date '2024-12-23');
INSERT INTO EMPLOYEE VALUES(222,'ARAVINDH','DEVELOPER',250000,date '2024-12-28');
INSERT INTO EMPLOYEE VALUES(333,'SUNDAR','MANAGER',320000,date '2015-11-12');
INSERT INTO EMPLOYEE VALUES(444,'SWETHA','JR ANALYST',240000,date '2024-10-21');
SELECT * FROM EMPLOYEE;
SELECT * FROM EMPLOYEE ORDER BY JOB_DESC;
SELECT JOB_DESC, AVG(SALARY) FROM EMPLOYEE GROUP BY JOB_DESC;

SELECT JOB_DESC, COUNT(EMP_ID)
FROM EMPLOYEE
GROUP BY JOB_DESC
HAVING COUNT(EMP_ID)>1
ORDER BY JOB_DESC;

SELECT JOB_DESC, COUNT(ENAME)
FROM EMPLOYEE WHERE SALARY>100000
GROUP BY JOB_DESC
HAVING COUNT(ENAME)>1
ORDER BY JOB_DESC;

SELECT ENAME 
FROM EMPLOYEE
WHERE SALARY <  (SELECT AVG(SALARY) 
FROM EMPLOYEE);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'Sales'),
(2, 'Marketing'),
(3, 'HR');
INSERT INTO departments (department_id, department_name) VALUES (4,'Training');

INSERT INTO employees (employee_id, employee_name, department_id) VALUES
(101, 'Alice', 1),
(102, 'Bob', 1),
(103, 'Charlie', 2),
(104, 'Diana', 3);

SELECT employee_name
from employees
where department_id = (select department_id
from departments 
where department_name = 'Sales');

select employee_name,
(select department_name
from departments
where departments.department_id = employees.department_id) as department_name
from employees;

select employee_name, (select department_name from departments where departments.department_id = employees.department_id) as department_name 
from employees
where department_id in (select department_id
from employees
group by department_id
having count(*) > 1);

select department_name, department_id
from departments d
where exists (select 1
from employees e
where e.department_id = d.department_id);

select department_name
from departments d
where not exists (select 1
from employees e
where e.department_id = d.department_id);

select department_id
from employees 
group by department_id
having avg(employee_id) > 102;

select department_id
from departments
where department_id  in (select department_id from employees where employee_id >102);

select ucase ("RCB won") as uppercase_string;
select lcase ("RCB won") as lowercase_string;
select mid ('RCB won', 4) as substring;
SELECT MID('RCB won', 4) AS substring;
SELECT SUBSTRING('RCB won', 4) AS substring;

select product_name, price, round(price) as Rounded
from products;

CREATE TABLE USERRS (
USER_ID INT auto_increment,
NAME VARCHAR(100),
PRIMARY KEY(USER_ID)
);

ALTER TABLE USERRS auto_increment=1001;

INSERT INTO PRODUCTS VALUES(18,NULL,0);

SELECT * , COALESCE(product_name,"Chocolate") as product
from products;

delete from products;
select * from products;

start transaction;
savepoint point;

insert into products values(8,'candle',50);
insert into products values(7,'cap',120);

rollback to point;
commit;

DELIMITER //
CREATE PROCEDURE GETUSERDETAILS(IN userid INT)
BEGIN
     SELECT CUSTOMERID, CUSTOMERNAME, COUNTRY
     FROM CUSTOMERSYSTEM
     WHERE CUSTOMERID = userid;
END
//
DELIMITER ;
CALL GETUSERDETAILS(2);

CALL GETALLUSERS()

DELIMITER //
CREATE PROCEDURE GETUSERNAME(IN userid INT, OUT name VARCHAR(100))
BEGIN
     SELECT username INTO name
	 FROM users
     WHERE userid = userid;
END //

DELIMITER ;

SET @name = '';
CALL GETUSERNAME(1,@name);
SELECT @name;

SELECT * FROM users WHERE userid = 1;

create view sales_employees as
select *
from employees
where department_id = ( select department_id 
from departments 
where department_name = "Sales");

select * from  sales_employees;

-- updating the existing view
create or replace view sales_employee as
select employee_name
from employees
where department_id = (select department_id 
from departments
where department_name = "Sales");

drop view sales_employees;

update sales_employees
set employee_name = "Aravindh"
where employee_id = 101;

CREATE TABLE items (
    id INT PRIMARY KEY, -- clustered index
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);
 
INSERT INTO items(id, name, price) 
VALUES (1, 'Item', 50.00);

CREATE TABLE item_changes (
    change_id INT PRIMARY KEY AUTO_INCREMENT,
    item_id INT,
    change_type VARCHAR(10),
    change_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES items(id)
);

DELIMITER //
create trigger update_items_trigger
after update
on items
for each row
begin
     insert into item_changes(item_id, change_type)
     values (new.id,"update");
end;
//

update items set name = 'Laptop' where id = 1;
select * from items;
select * from item_changes;

update items set price = 46.05 
where id = 1;

CREATE TABLE emptable (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);
 
INSERT INTO emptable (employee_id, name, department, salary) VALUES
(7, 'Aravi',   'IT', 75000),
(2, 'Bob',     'Sales', 60000),
(3, 'Charlie', 'Sales', 45000),
(4, 'David',   'IT',    70000),
(5, 'Eva',     'IT',    80000),
(6, 'Frank',   'IT',    75000);

select employee_id, name, department, salary, 
row_number() over (partition by department order by salary desc) as rank_in_dept
from emptable;

select employee_id, name, salary, 
sum(salary) over (order by salary ) as running_total
from emptable;

select employee_id, name, salary,
lag(salary) over (order by salary) as previous_salary,
lead(salary) over (order by salary) as next_salary
from emptable;

select employee_id, name, department, salary,
rank() over (order by salary desc) as rank_in_dept
from emptable;

select employee_id, name, salary,
ntile(3) over (order by salary desc) as salary_4tile
from emptable;

DELIMITER //
create function CalculateRectangleArea(length float, width float)
returns float 
deterministic
begin
     return length*width;
end //
DELIMITER ;


select CalculateRectangleArea(5.5, 2.3) as area;

select employee_id, salary, 
   case
       when salary > 100000 then 'high'
       when salary between 50000 and 100000 then 'medium'
       else 'low'
    end as salary_grade
from emptable;

select * from ordersystem
where 
     Amount = case
                  when Amount > 300 then 'costly'
                  else 'affordable'
			  end ;
select * from ordersystem;

create table students(
roll_no int primary key,
name varchar(20),
marks int);

insert into students values (05,'Aravindh',98),
(18,'Shree',74),
(46,'Swetha', 60);

explain select * from employees where department_id = 5;

create table users(
id int,
profile JSON
);

insert into users values(1, '{"name" : "Aravi", "skills" : ["SQL", "Python"]}');

select JSON_EXTRACT (profile, '$.skills[1]') 
from users;

CREATE TABLE employeesNew (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT
);
 
INSERT INTO employeesNew (id, name, manager_id) VALUES
(1, 'Alice (CEO)', NULL),
(2, 'Bob (CTO)', 1),
(3, 'Charlie (CFO)', 1),
(4, 'David (Dev Manager)', 2),
(5, 'Eve (Developer)', 4),
(6, 'Frank (Intern)', 5);

select * from employeesNew;

with recursive employee_hierarchy as(
      select  id,
        name,
        manager_id,
        1 as level,
        cast(name as char(1000)) as path
	  from employeesNew
      where manager_id is null 
      
	  union all
      select e.id, e.name, e.manager_id, eh.level + 1,
      concat(eh.path, '->' , e.name)
      from employeesNew e
      join employee_hierarchy eh on e.manager_id = eh.id
)
select * from employee_hierarchy;
    
      
