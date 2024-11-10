CREATE DATABASE VenuGopal;

use VenuGopal;

create table Employee(EmpNo int PRIMARY KEY,Name varchar(30), Job varchar(20), Mgr_ID float, Hiredate date, Sal float, Deptno int);
drop table Employee;
select *from Employee;

exec sp_help Employee;
CREATE table Department(Deptno int PRIMARY KEY, Deptname varchar(20));
Alter table Employee add foreign key(Deptno) references Department (Deptno);
insert into Department values(55, 'testing');
insert into Department values(56, 'noc');
insert into Department values(57, 'Development');
insert into Department values(58, 'support');
insert into Department values(20, 'bpo');

select EmpNo, Name, job, Mgr_ID, Hiredate, Sal, Deptno, DATEDIFF(year, Hiredate, GETDATE()) AS YOE from Employee;

insert into Employee values(16,'sam','tester',3.14,'2024-07-25',1000,20);

insert into Employee values(1,'sam','tester',3.14,'2024-07-25',10000,55);

insert into Employee values(17,'rohit','manager',3.14,'2024-07-25',10000,55);
insert into Employee values(18,'s','manager',3.14,'2024-07-25',10000,55);
insert into Employee values(19,'MILLER','Manager',7698,'1998-02-25',4300,20);
create table TotalSalary(total)

INSERT INTO Employee (EmpNo, Name, Job, Mgr_ID, Hiredate, Sal, Deptno)
VALUES
    (2, 'Alex', 'noc', 4, '2024-08-01', 12000.00, 56),
    (3, 'Laura', 'tester', 5, '2024-09-15', 15000.00, 55);

INSERT INTO Employee (EmpNo, Name, Job, Mgr_ID, Hiredate, Sal, Deptno)
VALUES
(4, 'ram', 'noc', 4, '2024-08-01', 1000.00, 56),
(5, 'vins', 'tester', 5, '2024-09-15', 15000.00, 55),
(6, 'Alex', 'noc', 4, '2024-08-01', 2000.00, 56),
(7, 'Laura', 'tester', 5, '2024-09-15', 1500.00, 55),
(8, 'Alex', 'noc', 4, '2024-08-01', 12000.00, 56),
(9, 'Laura', 'tester', 5, '2024-09-15', 1500.00, 55),
(10, 'Alex', 'noc', 4, '2024-08-01', 2000.00, 56),
(11, 'Laura', 'tester', 5, '2024-09-15', 1500.00, 55),
(12, 'Alex', 'clerk', 4, '2024-08-01', 12000.00, 56),
(13, 'Laura', 'tester', 5, '2024-09-15', 1500.00, 55),
(14, 'Alex', 'noc', 4, '2024-08-01', 12000.00, 56),
(15, 'Laura', 'clerk', 5, '2024-09-15', 15000.00, 55);

select *from employee where Sal>=1000 and sal<=5000 order by Hiredate;

select Name, Sal, Deptno from Employee where job='manager';

select *from employee where sal<=3000;

select *from employee where Name like 'A%';

select *from Employee where Deptno=20;
select *from Employee where Job='clerk' or Sal>=1000 and sal<=2000;
select *from Employee where sal<=1000 and sal>=15000;
select *from Department;
select *from Employee order by sal asc;
exec sp_help Department;
exec sp_help Customer;
select *from employee where Name like 'A%';
select *from employee where Sal>=1000 and sal<=5000 order by Hiredate asc;
select sum(Sal),job from Employee group by Job order by job Asc;
SELECT Deptno, SUM(Sal) AS Sal
FROM Employee
GROUP BY Deptno;


----------exercise 2--------------------------------

create table Customer(No int PRIMARY KEY, Fname varchar(20),Lname varchar(20),Phone bigint, Address varchar(20));
select *from Customer;
INSERT INTO Customer(No, Fname,Lname,Phone,Address)
values
(1,'Ajay','Batra',27111333,'Rohini');

INSERT INTO Customer(No, Fname,Lname,Phone,Address)
values

(2,'Deepak ','Chopra',25656891,'Ashok Vihar'),
(3,'Rajesh','Mehta',23455511,'Ashok Vihar'),
(4,'Priya','Kumar',23456334,'Rohini'),
(5,'Ramit ','Arya',24567565,'Model Town'),
(6,'Arpit','Jain',23222334,'Shailmar Bagh'),
(7,'Rahul','Kundra',24567856,'Model Town'),
(8,'Kisan','Kumar',27898981,'Rohini');
select *from Customer where Fname in ('Arpit','Rahul', 'Kisan');
select *from Customer;
SELECT COUNT(*) AS No FROM Customer;
drop table Customer;
delete from Customer where Address='Rohini';
update Customer set Phone=27111343 where phone=27111333;
select *from Customer where Address='Rohini';
update Customer set Phone=27111343 where phone=27111333;
select *from Customer where Fname in ('Arpit','Rahul', 'Kisan');
select count(*) from Employee where sal<3000; 
select fname from customer;
delete from Customer where Address='Rohini';
select *from Customer where Address='Rohini';
SELECT COUNT(*) AS No FROM Customer;

-----------------exercise 3--------------------

create table Sale(No int, Itemcode int Primary key, Quantity int, Rate real);
Alter table Sale add foreign key(No) references Customer (No);

exec sp_help Sale;

drop table Sale;

insert into Sale(No,Itemcode,Quantity,Rate)
values
(1,1001,20,34.56);

insert into Sale(No,Itemcode,Quantity,Rate)
values
(3,1003,20,34.56),
(4,1009,13,359.23),
(5,1010,15,699.99),
(3,1008,16,345.34);
Select  Count(*) from Customer C, Sale S where C.No=S.No;
select *from Sale;
Select * from Customer where Fname like 'A%' order by Address;
Select Fname, Quantity, Rate from Customer C, Sale S where C.No=S.No;
Select No, Sum(quantity) from Sale group by No;
Select No,Lname,sum(quantity) from customer C and Sale S group by No having C.no=S.No 
Select No,count(*) from customer C, Sale S where C.No=S.No;
Select Fname, Quantity,Rate from Customer C, Sale S where C.No=S.No;
Select No, Sum(quantity) from Sale group by No;
Select * from customer where Fname like 'A%' order by Address