create database emp_detailss;
use emp_detailss;


CREATE TABLE Departments (
    id INT AUTO_INCREMENT PRIMARY KEY,         
    D_name VARCHAR(100) NOT NULL,                
    location VARCHAR(100)                      
);
CREATE TABLE Employees (
    id INT AUTO_INCREMENT PRIMARY KEY,         
    first_name VARCHAR(50) NOT NULL,           
    last_name VARCHAR(50) NOT NULL,            
    email VARCHAR(100) NOT NULL UNIQUE,        
    phone_number VARCHAR(20),                  
    hire_date DATE NOT NULL,                   
    job_title VARCHAR(50) NOT NULL,            
    department_id INT,                         
    FOREIGN KEY (department_id) REFERENCES Departments(id)
);
CREATE TABLE Projects (
    id INT AUTO_INCREMENT PRIMARY KEY,         
    P_name VARCHAR(100) NOT NULL,                
    P_Description TEXT,                          
    start_date DATE,                           
    end_date DATE,                             
    department_id INT,                        
    FOREIGN KEY (department_id) REFERENCES Departments(id) 
);

CREATE TABLE Timesheets (
    id INT AUTO_INCREMENT PRIMARY KEY,         
    employee_id INT,                           
    project_id INT,                            
    date_ts DATE NOT NULL,                        
    hours DECIMAL(5, 2) NOT NULL,              
    FOREIGN KEY (employee_id) REFERENCES Employees(id),   
    FOREIGN KEY (project_id) REFERENCES Projects(id)      
);

INSERT INTO Departments (D_name, location) VALUES
('HR', 'New York'),           
('Finance', 'Chicago'),       
('Engineering', 'San Francisco'), 
('Marketing', 'Los Angeles'), 
('Sales', 'Boston'),
('IT Support', 'San Diego'), 
('Legal', 'Seattle'),        
('Operations', 'Houston'),   
('Customer Service','Miami');

INSERT INTO Employees (first_name, last_name, email, phone_number, hire_date, job_title, department_id) VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', '2022-01-15', 'Manager',1),
('Jane', 'Smith', 'jane.smith@example.com', '555-2345', '2021-06-22', 'Developer',3),
('Tom', 'Brown', 'tom.brown@example.com', '555-3456', '2020-09-12', 'Manager',2),
('Lucy', 'Davis', 'lucy.davis@example.com', '555-4567', '2019-11-02', 'Developer',4),
('Mark', 'Taylor', 'mark.taylor@example.com', '555-5678', '2018-08-30', 'Sales Rep',5),
('Emma', 'Watson', 'emma.watson@example.com', '555-8765', '2020-05-14', 'Manager',6),
('David', 'Miller', 'david.miller@example.com', '555-7654', '2019-04-20', 'Developer',6),
('Sophia', 'Wilson', 'sophia.wilson@example.com', '555-6543', '2018-12-01', 'Manager',7),
('Liam', 'Johnson', 'liam.johnson@example.com', '555-5432', '2021-07-17', 'Developer',7),
('Olivia', 'Martinez', 'olivia.martinez@example.com', '555-4321', '2022-09-09', 'HR Specialist',1),
('Lucas', 'Garcia', 'lucas.garcia@example.com', '555-3210', '2023-02-22', 'Marketing Analyst',4),
('Mia', 'Davis', 'mia.davis@example.com', '555-2109', '2023-03-15', 'Sales Rep',5),
('James', 'Brown', 'james.brown@example.com', '555-1098', '2021-10-11', 'Operations Manager',8),
('Isabella', 'Rodriguez', 'isabella.rodriguez@example.com', '555-0987', '2017-08-06', 'Customer Service Rep',9);

INSERT INTO Projects (P_name, P_Description, start_date, end_date, department_id) VALUES
('Project A', 'HR system overhaul', '2023-01-01', '2023-12-31',1),
('Project B', 'Financial Audit', '2023-03-01', '2023-12-01',2),
('Project C', 'New App Development', '2023-05-01', '2024-01-31',3),
('Project D', 'Marketing Campaign', '2023-07-01', '2023-11-30',4),
('Project E', 'Sales Platform Upgrade', '2023-09-01', '2024-06-30',5),
('Project F', 'IT Infrastructure Upgrade', '2023-04-01', '2023-12-31',6),
('Project G', 'Legal Compliance Audit', '2023-07-01', '2023-12-01',7),
('Project H', 'Operations Workflow Optimization', '2023-05-15', '2023-12-31',8),
('Project I', 'Customer Feedback System', '2023-06-01', '2024-03-31',9),
('Project J', 'Cloud Migration', '2023-09-01', '2024-05-31',6);

INSERT INTO Timesheets (employee_id, project_id, date_ts, hours) VALUES
(1, 1, '2023-02-15',8.0),
(2, 3, '2023-05-10',6.5),
(2, 3, '2023-05-11',7.0),
(3, 2, '2023-03-20',8.0),
(4, 4, '2023-08-10',5.5),
(4, 4, '2023-08-11',7.5),
(5, 5, '2023-10-15',6.0),
(6, 6, '2023-06-15',7.5), 
(7, 6, '2023-06-16',8.0), 
(7, 6, '2023-06-17',6.5),
(8, 7, '2023-08-01',8.0), 
(9, 7, '2023-08-02',7.0), 
(9, 7, '2023-08-03',8.5),
(10, 1, '2023-04-01',8.0), 
(11, 4, '2023-05-22',6.0), 
(11, 4, '2023-05-23',5.5),
(12, 5, '2023-09-15',7.0), 
(13, 8, '2023-07-05',6.5), 
(13, 8, '2023-07-06',8.0),
(14, 9, '2023-07-10',6.0), 
(14, 9, '2023-07-11',6.5),
(1, 3, '2023-06-12',7.5), 
(1, 3, '2023-06-13',8.0),
(2, 3, '2023-06-14',7.0);

# [1] Find out the working location of each employee
SELECT 
    e.first_name,
    e.last_name,
    d.D_name,
    d.location
FROM Employees e
JOIN Departments d
ON e.department_id = d.id;

#[2] Create Salary column & update the salaries for each department as below
#D1 → 40K ,D2 → 30K ,D3 → 55K ,D4 → 60K ,D5 → 75K ,D6 → 100K ,D7 → 125K ,D8 → 130K ,D9 → 150000
ALTER TABLE Employees
ADD salary DECIMAL(10,2);
UPDATE Employees
SET salary = CASE department_id
    WHEN 1 THEN 40000
    WHEN 2 THEN 30000
    WHEN 3 THEN 55000
    WHEN 4 THEN 60000
    WHEN 5 THEN 75000
    WHEN 6 THEN 100000
    WHEN 7 THEN 125000
    WHEN 8 THEN 130000
    WHEN 9 THEN 150000
END
WHERE department_id IS NOT NULL;
SELECT id, first_name, last_name, department_id, salary
FROM Employees;

#[3] Find which project the employee is working on
SELECT 
Employees.first_name,
Employees.last_name,
Projects.P_name
FROM Employees
JOIN Timesheets
ON Employees.id = Timesheets.employee_id
JOIN Projects
ON Timesheets.project_id = Projects.id;

#[4] Total hours worked on each project by each employee
SELECT 
Employees.first_name,
Employees.last_name,
Projects.P_name,
SUM(Timesheets.hours) AS total_hours
FROM Employees
JOIN Timesheets
ON Employees.id = Timesheets.employee_id
JOIN Projects
ON Timesheets.project_id = Projects.id
GROUP BY Employees.id, Projects.id;

#[5] Employees who have not worked on any project
SELECT 
Employees.first_name,
Employees.last_name
FROM Employees
LEFT JOIN Timesheets
ON Employees.id = Timesheets.employee_id
WHERE Timesheets.employee_id IS NULL;

#[6] Find the maximum hours worked on which project.
SELECT P.P_name, T.hours
FROM Timesheets T
JOIN Projects P
ON T.project_id = P.id
WHERE T.hours = (
    SELECT MAX(hours)
    FROM Timesheets
);

#[7] Create a view which stores employees' department names & their respective salaries.
CREATE VIEW Department_Salary AS
SELECT 
    D.D_name,
    E.salary
FROM Employees E
JOIN Departments D
ON E.department_id = D.id;
SELECT * FROM Department_Salary;

#[8] Create a view which stores the projects allocated to each employee
create view employee_projects as
select e.first_name,
e.last_name,
p.P_name
from employees e
join timesheets t
on e.id = t.employee_id
join projects p
on p.id = t.project_id;
select * from employee_projects;

#[9] Find the employees who have worked more than 20 hours on a single project.
select e.first_name,
e.last_name,
p.P_name,
sum(t.hours) as total_hours
from employees e
join timesheets t
on e.id = t.employee_id
join projects p
on p.id = t.project_id
group by e.id,p.id
having sum(t.hours) > 20;

#[10] Create a query that classifies employees based on their job titles as 'Manager','Developer', or 'Other'.
select first_name,
last_name,
job_title,
case
when job_title like '%Manager%' then 'Manager'
when job_title like '%Developer%' then 'Developer'
else 'Other'
end as employee_category
from employees;

#[11] Retreive a list of employee who worked on multiple projects 
SELECT 
    e.id,
    e.first_name,
    e.last_name,
    COUNT(DISTINCT t.project_id) AS total_projects
FROM Employees e
JOIN Timesheets t
ON e.id = t.employee_id
GROUP BY e.id, e.first_name, e.last_name
HAVING COUNT(DISTINCT t.project_id) > 1;

#[12] Retrieve each employee’s total hours worked on projects, and show the rank of each employee based on total hours worked.
SELECT 
    e.id,
    e.first_name,
    e.last_name,
    SUM(t.hours) AS total_hours,
    RANK() OVER (ORDER BY SUM(t.hours) DESC) AS emp_rank
FROM Employees e
JOIN Timesheets t
ON e.id = t.employee_id
GROUP BY e.id, e.first_name, e.last_name;

#[13] List all employees whose total hours worked are above the overall average using subquery.
SELECT employee_id, SUM(hours) AS total_hours
FROM Timesheets
GROUP BY employee_id
HAVING SUM(hours) >
(
    SELECT AVG(total_hours)
    FROM
    (
        SELECT SUM(hours) AS total_hours
        FROM Timesheets
        GROUP BY employee_id
    ) AS avg_table
);

#[14] Update the Employees table by changing the job_title of all employees working in the 'Engineering' department to 'Senior Developer', except for those who are 'Manager' or 'HR Specialist'.
UPDATE Employees
SET job_title = 'Senior Developer'
WHERE department_id = (
    SELECT id
    FROM Departments
    WHERE D_name = 'Engineering'
)
AND job_title NOT IN ('Manager', 'HR Specialist');

#[15] Find out which department has the highest average employee salary.
SELECT d.D_name,
       AVG(e.salary) AS avg_salary
FROM Employees e
JOIN Departments d
ON e.department_id = d.id
GROUP BY d.D_name
ORDER BY avg_salary DESC
LIMIT 1;