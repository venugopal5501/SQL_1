use venugopal;
create table Employee65(empid int primary key, empname varchar(60),department varchar(60), contactno bigint, emailid varchar(70), empheadid int);

create table country (cid varchar(20) primary key, cname varchar(50));
drop table client;
create table project (projectid varchar(20) primary key, duration int);

create table empsalary(empid int foreign key references employee65(empid), salary int, ispermanent varchar(5));

create table empdept(deptid varchar(20),deptname varchar(20), deptoff varchar(50),depthead int foreign key references employee65(empid));

create table client(clientid varchar(15) primary key, client_name varchar(50), cid varchar(20) foreign key references country(cid));

create table empproject (empid int foreign key references employee65(empid), projectid varchar(20) foreign key references project (projectid), clientid varchar(15) foreign key references client(clientid), startyear int, endyear int);
drop table empproject
INSERT INTO Employee65 (EmpId, EmpName, Department, ContactNo, EmailId, EmpHeadId) VALUES
(101, 'Isha', 'E-101', 1234567890, 'isha@gmail.com', 105),
(102, 'Priya', 'E-104', 1234567890, 'priya@yahoo.com', 103),
(103, 'Neha', 'E-101', 1234567890, 'neha@gmail.com', 101),
(104, 'Rahul', 'E-102', 1234567890, 'rahul@yahoo.com', 105),
(105, 'Abhishek', 'E-101', 1234567890, 'abhishek@gmail.com', 102);

INSERT INTO empdept (DeptId, DeptName, DeptOff, DeptHead) VALUES
('E-101', 'HR', 'Monday', 105),
('E-102', 'Development', 'Tuesday', 101),
('E-103', 'House Keeping', 'Saturday', 103),
('E-104', 'Sales', 'Sunday', 104),
('E-105', 'Purchase', 'Tuesday', 104);

INSERT INTO empsalary (EmpId, Salary, IsPermanent) VALUES
(101, 2000, 'Yes'),
(102, 10000, 'Yes'),
(103, 5000, 'No'),
(104, 1900, 'Yes'),
(105, 2300, 'Yes');

INSERT INTO project (ProjectId, Duration) VALUES
('p-1', 23),
('p-2', 15),
('p-3', 45),
('p-4', 2),
('p-5', 30);

INSERT INTO country (Cid, Cname) VALUES
('c-1', 'India'),
('c-2', 'USA'),
('c-3', 'China'),
('c-4', 'Pakistan'),
('c-5', 'Russia');

INSERT INTO client (ClientId, Client_Name, Cid) VALUES
('cl-1', 'ABC Group', 'c-1'),
('cl-2', 'PQR', 'c-1'),
('cl-3', 'XYZ', 'c-2'),
('cl-4', 'tech altum', 'c-3'),
('cl-5', 'mnp', 'c-5');

INSERT INTO empproject(EmpId, ProjectId, ClientId, StartYear, EndYear) VALUES
(101, 'p-1', 'cl-1', 2010, 2010),
(102, 'p-2', 'cl-2', 2010, 2012),
(103, 'p-1', 'cl-3', 2013, NULL),
(104, 'p-4', 'cl-1', 2014, 2015),
(105, 'p-4', 'cl-5', 2015, NULL);
select *from empproject;
select empname from Employee65 where empname like 'r%';

select empid, salary, ispermanent from empsalary where salary>=2000 and ispermanent='yes';

select emailid from Employee65 where emailid like '%gmail%';

select empid f, empname f, department f from employee65 f in (select deptid, deptname, deptoff from empdept where deptid=f.department);

select empid e, empname e, department e from Employee65 e inner join empdept d on e.department=d.deptid;   

select *from employee65 where department='e-104' or department='e-102';

select deptid, deptname from empdept where deptid='e-102'

select sum(salary) from empsalary where ispermanent='yes';

select empname from Employee65 where empname like '%a';

select empname from Employee65 where empname like '__h%';

select department,count(empname) from Employee65 group by department;

select count(department) from EmpProject, Employee65 group by ProjectId

select empid e,projectid e from empproject ; 

select *from empproject where startyear=2010;

select count(distinct projectid) from empproject where startyear=2010;


select *from empproject where startyear=endyear;

select count(distinct projectid) from empproject where startyear=endyear;

select count(distinct empid),deptname from Employee65, empdept group by deptname;
select count(distinct empid) from empproject;
select 

SELECT 
    p.projectid,
    COUNT(DISTINCT e.department) AS DepartmentCount
FROM 
    empproject p
INNER JOIN 
    Employee65 e ON p.empid = e.empid
GROUP BY 
    p.projectid;


	select p.projectid, count(distinct e.department) as counts
	from empproject p
	full join employee65 e
	on e.empid=p.empid
	group by p.projectid;

	select client_name c, empid e from client c 
	inner join empproject e on e.clientid = c.clientid
	where e.empid >=103;

	select deptname, empid from empdept, empproject where empid>=103
	
	
v	select empid e, empname e,department e, deptname f from Employee65 e
	inner join empdept f on e.department=f.deptid where e.empid>=103
	order by e.empid;

SELECT DeptName FROM Employee65  JOIN EmpDept ON  Department =DeptId AND Empid>103
select DeptName from EmpDept  where DeptHead in(select Empid from Employee65 where Empid >103)

select empname from Employee65 where empheadid=105

select empname from Employee65 where empheadid in(select empid from Employee65 where empname='abhishek');

----select empname,deptname from Employee65,empdept where depthead in (select empname from Employee65 where deptname='hr');

select empname from Employee65 where empid =(select depthead from empdept where deptname='hr');

select empid, empname from employee65 where department in (select deptname, deptoff from empdept where deptid='e-102' and deptid='e-104');

select empname from Employee65 where department in (select deptid from empdept where deptoff='monday');

select client_name from client where cid in(select cid from country where cname='india');

select EmpName from Employee65 where Empid in ( select DeptHead from EmpDept where Deptoff ='Monday')

select *from Employee65 where department in (select deptid from empdept where deptname='development' );



select empname, emailid from Employee65 where empid=(select empid from empsalary where ispermanent='no');