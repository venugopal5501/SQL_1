Use dreamhome;

--1. List all staff with a salary between $20,000 and $30,000.

select staffno,fname,lname,salary from staff where salary between 20000 and 30000

--select staffno,fname,lname from staff where salary between 20000 and 30000;

--2. Write a SQL query to list the unique branchno that branch has at least two female staff. 

select branchNo, count(*) as [female count] from staff where sex='f' group by branchNo having count(staffNo)>=2 

--select branchno from staff where sex='f' and having count(staffno)>2 group by branchno;

--3. Write a SQL query to display the staffno and working branch city for the staff who has the lowest salary.

select s.staffNo, b.city from staff s join branch b on s.branchNo=b.branchNo where s.salary in (select min(salary) from staff)

--select staffno,city from staff, branch where salary in (select min(salary) from staff)

--4. List the staff who work in the branch at ‘163 Main St’.

select s.staffno,s.fName,s.lName from staff s join branch b on s.branchNo=b.branchNo where b.street='163 Main St'

--select staffno,fname,lname from staff where branchno in (select branchno from branch where street ='163 Main st')

--5. Write the SQL query to show the branchno and the maximum salary for each branch in the Staff table.  
--   The output should be sorted from high to low based on the max salary of each branch; 

select s.branchno, max(s.salary) as maximum from staff s group by s.branchNo order by maximum desc;

--select branchno,max(salary) as highest from staff group by branchno order by highest desc;

--6. Write the SQL query to find how many properties cost more than $550 per month to rent?

select count(*) as [number of property] from propertyForRent where rent>=550

--select count(propertyno) from propertyforrent where rent > 550; 

--7. How many different properties were viewed in May 2015?

select count(distinct propertyno) as [no of view] from viewing where MONTH(viewDate)=05 and year(viewDate)=2015

--select count(distinct propertyno) from viewing where month(viewdate)=05 and year(viewdate)=2015

--8. Write a SQL query to find the staff name (first name, last name) who has salary higher than the average salary of branchno =’B003’;

select fName,lName from staff where salary > (select AVG(salary) from staff where branchNo='b003')

--select fName,lName from staff where salary>(select avg(salary) from staff where branchno='b003')

--9. Find the number of staff working in each branch and the sum of their salaries.

select branchNo,count(staffno) as [number of staff], sum(salary) as [sum of salary] from staff group by branchNo 

--select count(staffno), sum(salary) from staff group by branchno;

--10. List the unique property numbers of all properties that have been viewed.

select distinct propertyNo as [number of views] from viewing

--select distinct propertyNo from viewing

--11. Produce an abbreviated list of properties arranged in order of property type.

select *from propertyForRent order by type

--select *from propertyforrent order by type;

--12. List all staff whose salary is greater than the average salary, and show by how much their salary is greater than the average.

select s.fname ,s.salary ,(s.salary - avg_salary) as SalaryDifference from 
(select fName, salary, (select avg(salary) from staff) as avg_salary from staff) as s where s.salary > s.avg_salary;

--select staffno, fname,lname,position, salary, salary=salary-avg(salary) as diference from staff where salary > (select avg(salary) from staff)

--13. Construct a list of all cities where there is either a branch office or a property.

select distinct city from branch union select distinct city from propertyForRent

--select p.city, b.city from propertyForRent p join branch b on p.branchno=b.branchno where p.city is not null or b.city is not null

--14. Construct a list of all cities where there is both a branch office and a property.

select distinct city from propertyForRent where city in (select distinct city from branch)

--select p.city,b.city from propertyforrent p join branch b on p.branchno=b.branchno where p.city is not null and b.city is not null;

--15. Find the total number of Managers and the sum of their salaries.

select count(*) as [counts], sum(salary) [sum of salary] from staff where position='manager'

--select count(position) as [count of managers], sum(salary) from staff where position ='manager'

--16. List all properties and any branch offices that are in the same city.

select p.*,b.* from propertyForRent p join branch b on p.city=b.city

--select *from propertyforrent p join branch b on p.branchno=b.branchno where p.city=b.city

--17. Find all staff whose salary is larger than the salary of every member of staff at branch B003.

select s.fName,s.lName from staff s where salary >(select min(salary) from staff where branchNo='b003')

--select staffno, fname, lname from staff where salary > any (select salary from staff where branchno='b003')

--18. For each branch office with more than one member of staff, find the number of staff working in each branch and the sum of their salaries.

select branchNo,count(staffNo) as [number of staff], sum(salary) as sum from staff group by branchNO having count(staffNo)>1 

--select branchno, count(staffno), sum(salary) from staff where branchno in (select branchno from staff having count(staffno)>1)

--19. Write a SQL query to show client names who didn’t give reviews (Viewing table).

select cn.fName,cn.lName from client cn join viewing v on cn.clientNo=v.clientNo where v.comment is null

--select clientno, fname, lname from client where clientno in (select clientno from viewing where comment is null)

--20. List the details of all viewings on property PG4 where a comment has not been supplied.

select * from viewing where propertyNo='pg4' and comment is null

--select *from viewing where propertyno='pg4' and comment is null;

use VenuGopal

create table employeesdetails(empno int primary key, name varchar(80), designation varchar(80), basic_pay int);

INSERT INTO employeesdetails (empno, name, designation, basic_pay) VALUES (1, 'John Doe', 'Software Engineer', 50000);
INSERT INTO employeesdetails (empno, name, designation, basic_pay) VALUES (2, 'Jane Smith', 'Data Analyst', 60000);
INSERT INTO employeesdetails (empno, name, designation, basic_pay) VALUES (3, 'Alice Johnson', 'Project Manager', 70000);
INSERT INTO employeesdetails (empno, name, designation, basic_pay) VALUES (4, 'Bob Brown', 'Senior Developer', 80000);
INSERT INTO employeesdetails (empno, name, designation, basic_pay) VALUES (5, 'Charlie White', 'Quality Assurance', 90000);

create function calculate_da (@basic_pay int)
 returns int
 as
 begin
 declare @da int
 set @da=@basic_pay * 0.31
 return @da;
 end

 create function calculate_pf (@basic_pay int, @da int)
 returns int
 as
 begin
 declare @pf int
 declare @calc int =@basic_pay + @da
 if (@calc)<=15000
 set @pf=0.083
 return @da;
 end

 create function calculate_hra (@basic_pay int)
 returns int
 as
 begin
 declare @hra int
 set @hra=@basic_pay * 0.10
 return @hra;
 end

 exec sp_help  calculate_hra

 create function calculate_ta (@basic_pay int)
 returns int
 as
 begin
 declare @ta int
 set @ta=@basic_pay * 0.5
 return @ta;
 end

  create or alter function calculate_fa (@basic_pay int)
 returns int
 as
 begin
 declare @fa int
 set @fa=@basic_pay * 0.3
 return @fa;
 end

  create or alter function calculate_gp (@basic_pay int)
 returns int
 as
 begin
  declare @gp int
  declare @da int=dbo.calculate_da(@basic_pay);
  declare @hra int=dbo.calculate_hra(@basic_pay);
  declare @fa int=dbo.calculate_fa(@basic_pay);
  declare @ta int=dbo.calculate_ta(@basic_pay);

 set @gp=@basic_pay + @da + @hra +@fa +@ta
 return @gp;
 end

 create or alter function calculate_pf (@basic_pay int)
 returns int
 as
 begin
 declare @fa int
 set @fa=@basic_pay * 0.3
 return @fa;
 end

 create or alter function calculate_pf (@basic_pay int, )
 returns int
 as
 begin
 declare @fa int
 set @fa=@basic_pay * 0.3
 return @fa;
 end

CREATE or alter PROCEDURE dbo.CalculateDAsForAllEmployees
AS
BEGIN
    SELECT 
        ed.empno,
        ed.name,
        ed.designation,
        ed.basic_pay,
        dbo.calculate_da(ed.basic_pay) AS DA,
		dbo.calculate_hra(ed.basic_pay) AS hra,
		dbo.calculate_ta(ed.basic_pay) AS ta,
		dbo.calculate_fa(ed.basic_pay) AS fa,
		dbo.calculate_gp(ed.basic_pay) AS gp,
		dbo.calculate_pf(ed.basic_pay) AS pf,
		dbo.calculate_insurance(ed.basic_pay) AS ins,
		dbo.calculate_deductions(ed.basic_pay) AS DA,



    FROM 
        employeesdetails ed;
END;

EXEC dbo.CalculateDAsForAllEmployees;

CREATE OR ALTER FUNCTION calculate_pf (@basic_pay INT, @da INT)
RETURNS INT
AS
BEGIN
    DECLARE @pf INT;
    DECLARE @total INT = @basic_pay + @da;

    IF @total <= 15000
        SET @pf = @total * 0.083; 
    ELSE
        SET @pf = @total * 0.12;  

    RETURN @pf;
END;

CREATE OR ALTER FUNCTION calculate_insurance (@basic_pay INT, @da INT)
RETURNS INT
AS
BEGIN
    DECLARE @in INT;
    DECLARE @total INT = @basic_pay + @da;

    IF @total <= 15000
        SET @pf = @total * 0.083; 
    ELSE
        SET @pf = @total * 0.12;  

    RETURN @pf;
END;


CREATE OR ALTER FUNCTION calculate_insurance (@basic_pay INT, @da INT)
RETURNS INT
AS
BEGIN
    DECLARE @insurance INT;
    DECLARE @total INT = @basic_pay + @da;

    IF @total <= 15000
        SET @insurance = @total * 0.03;     ELSE
        SET @insurance = @total * 0.05; 

    RETURN @insurance;
END;

CREATE OR ALTER FUNCTION calculate_deductions (@basic_pay INT, @da INT)
RETURNS INT
AS
BEGIN
    DECLARE @pf INT = dbo.calculate_pf(@basic_pay, @da);
    DECLARE @insurance INT = dbo.calculate_insurance(@basic_pay, @da);
    DECLARE @deductions INT;
    
    SET @deductions = @pf + @insurance;

    RETURN @deductions;
END;

CREATE OR ALTER FUNCTION calculate_net_pay (@basic_pay INT)
RETURNS INT
AS
BEGIN
    DECLARE @gp INT = dbo.calculate_gp(@basic_pay);       -- Calculate Gross Pay
    DECLARE @da INT = dbo.calculate_da(@basic_pay);       -- Calculate Dearness Allowance
    DECLARE @deductions INT = dbo.calculate_deductions(@basic_pay, @da); -- Calculate total Deductions (PF + Insurance)
    DECLARE @net_pay INT;
    
    SET @net_pay = @gp - @deductions; -- Net Pay = Gross Pay - Deductions

    RETURN @net_pay;
END;

CREATE OR ALTER PROCEDURE dbo.CalculateAllPayDetailsForEmployees
@empno int
AS
BEGIN
    SELECT 
        ed.empno,
        ed.name,
        ed.designation,
        ed.basic_pay,
        dbo.calculate_da(ed.basic_pay) AS DA,
        dbo.calculate_hra(ed.basic_pay) AS HRA,
        dbo.calculate_ta(ed.basic_pay) AS TA,
        dbo.calculate_fa(ed.basic_pay) AS FA,
        dbo.calculate_gp(ed.basic_pay) AS Gross_Pay,
        dbo.calculate_pf(ed.basic_pay, dbo.calculate_da(ed.basic_pay)) AS PF,
        dbo.calculate_insurance(ed.basic_pay, dbo.calculate_da(ed.basic_pay)) AS Insurance,
        dbo.calculate_deductions(ed.basic_pay, dbo.calculate_da(ed.basic_pay)) AS Deductions,
        dbo.calculate_net_pay(ed.basic_pay) AS Net_Pay
    FROM 
        employeesdetails ed
	where ed.empno=@empno;
END;

EXEC dbo.CalculateAllPayDetailsForEmployees @empno=1;
