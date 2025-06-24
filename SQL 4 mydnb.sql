CREATE TABLE STUDENT
(
ID NUMBER(3) NOT NULL,
NAME CHAR(25) NOT NULL
);
drop table STUDENT;

CREATE TABLE DEPT
(
DEPTNO NUMBER(2,0),
DNAME VARCHAR2(14),
LOC VARCHAR2(13),
CONSTRAINT PK_DEPTNO PRIMARY KEY(DEPTNO)
);

CREATE TABLE EMP
(
EMPNO NUMBER(4,0),
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
MGR NUMBER(4,0),
HIREDATE DATE,
SAL NUMBER(7,2),
COMM NUMBER(7,2),
DEPTNO NUMBER(2,0),
CONSTRAINT PK_EMPNO PRIMARY KEY(EMPNO),
CONSTRAINT FK_DEPTNO FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO)
);

CREATE TABLE STUDENT
(
    STUDENTID NUMBER(4),
    STUDENT_NAME VARCHAR(20) NOT NULL,
    MARKS VARCHAR(20) NOT NULL,
    MOBILE_NO NUMBER(10) NOT NULL,
    CONSTRAINT PK_STUDENTID PRIMARY KEY (STUDENTID),
    CONSTRAINT CHECK_MARKS CHECK (MARKS = 'ABSENT' OR (CAST(MARKS AS NUMBER) BETWEEN 0 AND 100)),
    CONSTRAINT CHECK_MOBILE_NO CHECK (LENGTH(MOBILE_NO) = 10 AND MOBILE_NO > 0)
);

CREATE TABLE COURSE
(
COURSE_ID NUMBER(10),
COURSE_NAME VARCHAR(20) NOT NULL,
COURSE_1 VARCHAR(20) NOT NULL,
COURSE_2 VARCHAR(20) NOT NULL,
COURSE_3 VARCHAR(20) NOT NULL,
COURSE_4 VARCHAR(20) NOT NULL, 
COURSE_5 VARCHAR(20) NOT NULL,
CONSTRAINT PK_COURSE_ID PRIMARY KEY (COURSE_ID)
);

INSERT INTO DEPT(DEPTNO,DNAME,LOC) VALUES (11,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT(DEPTNO,DNAME,LOC) VALUES (22,'RESEARCH','DALLAS');
INSERT INTO DEPT(DEPTNO,DNAME,LOC) VALUES (33,'SALES','CHICAGO');
INSERT INTO DEPT(DEPTNO,DNAME,LOC) VALUES (44,'OPERATIONS','BOSTON');

DESC DEPT;

INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,TO_DATE('17-11-1981','DD-MM-YYYY'),5000,NULL,11);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,TO_DATE('1-05-1981','DD-MM-YYYY'),2850,NULL,33);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,TO_DATE('09-06-1981','DD-MM-YYYY'),2975,NULL,22);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,TO_DATE('02-04-1981','DD-MM-YYYY'),2975,NULL,22);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,TO_DATE('03-12-1981','DD-MM-YYYY'),3000,NULL,22);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,TO_DATE('13-JUL-87','DD-MM-RR'),3000,NULL,22);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,TO_DATE('17-12-1980','DD-MM-YYYY'),800,NULL,22);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,TO_DATE('20-02-1981','DD-MM-YYYY'),1600,300,33);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,TO_DATE('22-02-1981','DD-MM-YYYY'),1250,500,33);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,TO_DATE('28-09-1981','DD-MM-YYYY'),1250,1400,33);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,TO_DATE('08-09-1981','DD-MM-YYYY'),1500,0,33);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,TO_DATE('13-JUL-87','DD-MM-RR')-51,1100,NULL,22);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,TO_DATE('03-12-1981','DD-MM-YYYY'),950,NULL,33);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,TO_DATE('23-09-1982','DD-MM-YYYY'),1300,NULL,11);


COMMIT;

CREATE TABLE regions
    ( region_id      NUMBER 
       CONSTRAINT  region_id_nn NOT NULL 
    , region_name    VARCHAR2(25) 
    );

CREATE UNIQUE INDEX reg_id_pk
ON regions (region_id);

ALTER TABLE regions
ADD ( CONSTRAINT reg_id_pk
       		 PRIMARY KEY (region_id)
    ) ;
    
CREATE TABLE countries 
    ( country_id      CHAR(2) 
       CONSTRAINT  country_id_nn NOT NULL 
    , country_name    VARCHAR2(60) 
    , region_id       NUMBER 
    , CONSTRAINT     country_c_id_pk 
        	     PRIMARY KEY (country_id) 
    ) 
    ORGANIZATION INDEX; 

ALTER TABLE countries
ADD ( CONSTRAINT countr_reg_fk
        	 FOREIGN KEY (region_id)
          	  REFERENCES regions(region_id) 
    ) ;

CREATE TABLE locations
    ( location_id    NUMBER(4)
    , street_address VARCHAR2(40)
    , postal_code    VARCHAR2(12)
    , city       VARCHAR2(30)
	CONSTRAINT     loc_city_nn  NOT NULL
    , state_province VARCHAR2(25)
    , country_id     CHAR(2)
    ) ;

CREATE UNIQUE INDEX loc_id_pk
ON locations (location_id) ;

ALTER TABLE locations
ADD ( CONSTRAINT loc_id_pk
       		 PRIMARY KEY (location_id)
    , CONSTRAINT loc_c_id_fk
       		 FOREIGN KEY (country_id)
        	  REFERENCES countries(country_id) 
    ) ;
    
CREATE SEQUENCE locations_seq
 START WITH     3300
 INCREMENT BY   100
 MAXVALUE       9900
 NOCACHE
 NOCYCLE;
 
 CREATE TABLE departments
    ( department_id    NUMBER(4)
    , department_name  VARCHAR2(30)
	CONSTRAINT  dept_name_nn  NOT NULL
    , manager_id       NUMBER(6)
    , location_id      NUMBER(4)
    ) ;

CREATE UNIQUE INDEX dept_id_pk
ON departments (department_id) ;

ALTER TABLE departments
ADD ( CONSTRAINT dept_id_pk
       		 PRIMARY KEY (department_id)
    , CONSTRAINT dept_loc_fk
       		 FOREIGN KEY (location_id)
        	  REFERENCES locations (location_id)
     ) ;

CREATE SEQUENCE departments_seq
 START WITH     280
 INCREMENT BY   10
 MAXVALUE       9990
 NOCACHE
 NOCYCLE;
 
 CREATE TABLE jobs
    ( job_id         VARCHAR2(10)
    , job_title      VARCHAR2(35)
	CONSTRAINT     job_title_nn  NOT NULL
    , min_salary     NUMBER(6)
    , max_salary     NUMBER(6)
    ) ;

CREATE UNIQUE INDEX job_id_pk 
ON jobs (job_id) ;

ALTER TABLE jobs
ADD ( CONSTRAINT job_id_pk
      		 PRIMARY KEY(job_id)
    ) ;
    
CREATE TABLE employees
    ( employee_id    NUMBER(6)
    , first_name     VARCHAR2(20)
    , last_name      VARCHAR2(25)
	 CONSTRAINT     emp_last_name_nn  NOT NULL
    , email          VARCHAR2(25)
	CONSTRAINT     emp_email_nn  NOT NULL
    , phone_number   VARCHAR2(20)
    , hire_date      DATE
	CONSTRAINT     emp_hire_date_nn  NOT NULL
    , job_id         VARCHAR2(10)
	CONSTRAINT     emp_job_nn  NOT NULL
    , salary         NUMBER(8,2)
    , commission_pct NUMBER(2,2)
    , manager_id     NUMBER(6)
    , department_id  NUMBER(4)
    , CONSTRAINT     emp_salary_min
                     CHECK (salary > 0) 
    , CONSTRAINT     emp_email_uk
                     UNIQUE (email)
    ) ;

CREATE UNIQUE INDEX emp_emp_id_pk
ON employees (employee_id) ;


ALTER TABLE employees
ADD ( CONSTRAINT     emp_emp_id_pk
                     PRIMARY KEY (employee_id)
    , CONSTRAINT     emp_dept_fk
                     FOREIGN KEY (department_id)
                      REFERENCES departments
    , CONSTRAINT     emp_job_fk
                     FOREIGN KEY (job_id)
                      REFERENCES jobs (job_id)
    , CONSTRAINT     emp_manager_fk
                     FOREIGN KEY (manager_id)
                      REFERENCES employees
    ) ;

ALTER TABLE departments
ADD ( CONSTRAINT dept_mgr_fk
      		 FOREIGN KEY (manager_id)
      		  REFERENCES employees (employee_id)
    ) ;

CREATE SEQUENCE employees_seq
 START WITH     207
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 CREATE TABLE job_history
    ( employee_id   NUMBER(6)
	 CONSTRAINT    jhist_employee_nn  NOT NULL
    , start_date    DATE
	CONSTRAINT    jhist_start_date_nn  NOT NULL
    , end_date      DATE
	CONSTRAINT    jhist_end_date_nn  NOT NULL
    , job_id        VARCHAR2(10)
	CONSTRAINT    jhist_job_nn  NOT NULL
    , department_id NUMBER(4)
    , CONSTRAINT    jhist_date_interval
                    CHECK (end_date > start_date)
    ) ;

CREATE UNIQUE INDEX jhist_emp_id_st_date_pk 
ON job_history (employee_id, start_date) ;

ALTER TABLE job_history
ADD ( CONSTRAINT jhist_emp_id_st_date_pk
      PRIMARY KEY (employee_id, start_date)
    , CONSTRAINT     jhist_job_fk
                     FOREIGN KEY (job_id)
                     REFERENCES jobs
    , CONSTRAINT     jhist_emp_fk
                     FOREIGN KEY (employee_id)
                     REFERENCES employees
    , CONSTRAINT     jhist_dept_fk
                     FOREIGN KEY (department_id)
                     REFERENCES departments
    ) ;

CREATE OR REPLACE VIEW emp_details_view
  (employee_id,
   job_id,
   manager_id,
   department_id,
   location_id,
   country_id,
   first_name,
   last_name,
   salary,
   commission_pct,
   department_name,
   job_title,
   city,
   state_province,
   country_name,
   region_name)
AS SELECT
  e.employee_id, 
  e.job_id, 
  e.manager_id, 
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  employees e,
  departments d,
  jobs j,
  locations l,
  countries c,
  regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id 
WITH READ ONLY;

CREATE INDEX emp_department_ix
       ON employees (department_id);

CREATE INDEX emp_job_ix
       ON employees (job_id);

CREATE INDEX emp_manager_ix
       ON employees (manager_id);

CREATE INDEX emp_name_ix
       ON employees (last_name, first_name);

CREATE INDEX dept_location_ix
       ON departments (location_id);

CREATE INDEX jhist_job_ix
       ON job_history (job_id);

CREATE INDEX jhist_employee_ix
       ON job_history (employee_id);

CREATE INDEX jhist_department_ix
       ON job_history (department_id);

CREATE INDEX loc_city_ix
       ON locations (city);

CREATE INDEX loc_state_province_ix	
       ON locations (state_province);

CREATE INDEX loc_country_ix
       ON locations (country_id);
       
COMMENT ON TABLE regions 
IS 'Regions table that contains region numbers and names. references with the Countries table.';

COMMENT ON COLUMN regions.region_id
IS 'Primary key of regions table.';

COMMENT ON COLUMN regions.region_name
IS 'Names of regions. Locations are in the countries of these regions.';

COMMENT ON TABLE locations
IS 'Locations table that contains specific address of a specific office,
warehouse, and/or production site of a company. Does not store addresses /
locations of customers. references with the departments and countries tables. ';

COMMENT ON COLUMN locations.location_id
IS 'Primary key of locations table';

COMMENT ON COLUMN locations.street_address
IS 'Street address of an office, warehouse, or production site of a company.
Contains building number and street name';

COMMENT ON COLUMN locations.postal_code
IS 'Postal code of the location of an office, warehouse, or production site 
of a company. ';

COMMENT ON COLUMN locations.city
IS 'A not null column that shows city where an office, warehouse, or 
production site of a company is located. ';

COMMENT ON COLUMN locations.state_province
IS 'State or Province where an office, warehouse, or production site of a 
company is located.';

COMMENT ON COLUMN locations.country_id
IS 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.';

COMMENT ON TABLE departments
IS 'Departments table that shows details of departments where employees 
work. references with locations, employees, and job_history tables.';

COMMENT ON COLUMN departments.department_id
IS 'Primary key column of departments table.';

COMMENT ON COLUMN departments.department_name
IS 'A not null column that shows name of a department. Administration, 
Marketing, Purchasing, Human Resources, Shipping, IT, Executive, Public 
Relations, Sales, Finance, and Accounting. ';

COMMENT ON COLUMN departments.manager_id
IS 'Manager_id of a department. Foreign key to employee_id column of employees table. The manager_id column of the employee table references this column.';

COMMENT ON COLUMN departments.location_id
IS 'Location id where a department is located. Foreign key to location_id column of locations table.';

COMMENT ON TABLE job_history
IS 'Table that stores job history of the employees. If an employee 
changes departments within the job or changes jobs within the department, 
new rows get inserted into this table with old job information of the 
employee. Contains a complex primary key: employee_id+start_date.
References with jobs, employees, and departments tables.';

COMMENT ON COLUMN job_history.employee_id
  IS 'A not null column in the complex primary key employee_id+start_date. 
Foreign key to employee_id column of the employee table';

COMMENT ON COLUMN job_history.start_date
  IS 'A not null column in the complex primary key employee_id+start_date. 
Must be less than the end_date of the job_history table. (enforced by 
constraint jhist_date_interval)';

COMMENT ON COLUMN job_history.end_date
  IS 'Last day of the employee in this job role. A not null column. Must be 
greater than the start_date of the job_history table. 
(enforced by constraint jhist_date_interval)';

COMMENT ON COLUMN job_history.job_id
  IS 'Job role in which the employee worked in the past; foreign key to 
job_id column in the jobs table. A not null column.';

COMMENT ON COLUMN job_history.department_id
  IS 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table';

COMMENT ON TABLE countries
  IS 'country table. References with locations table.';

COMMENT ON COLUMN countries.country_id
  IS 'Primary key of countries table.';

COMMENT ON COLUMN countries.country_name
  IS 'Country name';

COMMENT ON COLUMN countries.region_id
  IS 'Region ID for the country. Foreign key to region_id column in the departments table.';

COMMENT ON TABLE jobs
  IS 'jobs table with job titles and salary ranges.
References with employees and job_history table.';

COMMENT ON COLUMN jobs.job_id
  IS 'Primary key of jobs table.';

COMMENT ON COLUMN jobs.job_title
  IS 'A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT';

COMMENT ON COLUMN jobs.min_salary
  IS 'Minimum salary for a job title.';

COMMENT ON COLUMN jobs.max_salary
  IS 'Maximum salary for a job title';

COMMENT ON TABLE employees
  IS 'employees table. References with departments,
jobs, job_history tables. Contains a self reference.';

COMMENT ON COLUMN employees.employee_id
  IS 'Primary key of employees table.';

COMMENT ON COLUMN employees.first_name
  IS 'First name of the employee. A not null column.';

COMMENT ON COLUMN employees.last_name
  IS 'Last name of the employee. A not null column.';

COMMENT ON COLUMN employees.email
  IS 'Email id of the employee';

COMMENT ON COLUMN employees.phone_number
  IS 'Phone number of the employee; includes country code and area code';

COMMENT ON COLUMN employees.hire_date
  IS 'Date when the employee started on this job. A not null column.';

COMMENT ON COLUMN employees.job_id
  IS 'Current job of the employee; foreign key to job_id column of the 
jobs table. A not null column.';

COMMENT ON COLUMN employees.salary
  IS 'Monthly salary of the employee. Must be greater 
than zero (enforced by constraint emp_salary_min)';

COMMENT ON COLUMN employees.commission_pct
  IS 'Commission percentage of the employee; Only employees in sales 
department elgible for commission percentage';

COMMENT ON COLUMN employees.manager_id
  IS 'Manager id of the employee; has same domain as manager_id in 
departments table. Foreign key to employee_id column of employees table. 
(useful for reflexive joins and CONNECT BY query)';

COMMENT ON COLUMN employees.department_id
  IS 'Department id where employee works; foreign key to department_id 
column of the departments table';





SELECT sys_context('USERENV', 'SERVICE_NAME') AS service_name FROM dual;












