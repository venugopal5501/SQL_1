use VenuGopal

---Create a table with the Student_id, Student_Name, Subject, Mark, and Name_of_the_staff who handled the subject. --

CREATE TABLE StudentDetails (Student_id INT,Student_Name VARCHAR(50),Subject VARCHAR(50),Mark INT,Name_of_the_staff VARCHAR(50));

-----Insert the details to the table for 3 subjects and for 10 students. (Total of 30 records) 

INSERT INTO StudentDetails (Student_id, Student_Name, Subject, Mark, Name_of_the_staff) VALUES
(1, 'Alice Johnson', 'Math', 85, 'Smith'),
(2, 'Bob Brown', 'Math', 90, 'Mr. Smith'),
(3, 'Charlie Davis', 'Math', 78, 'Mr. Smith'),
(4, 'David Evans', 'Math', 92, 'Mr. Smith'),
(5, 'Eva Green', 'Math', 88, 'Mr. Smith'),
(6, 'Frank Harris', 'Math', 80, 'Mr. Smith'),
(7, 'Grace Jones', 'Math', 31, 'Mr. Smith'),
(8, 'Hannah King', 'Math', 76, 'Mr. Smith'),
(9, 'Ian Lee', 'Math', 89, 'Mr. Smith'),
(10, 'Jack Miller', 'Math', 84, 'Mr. Smith');

select *from StudentDetails

INSERT INTO StudentDetails (Student_id, Student_Name, Subject, Mark, Name_of_the_staff) VALUES
(1, 'Alice Johnson', 'Science', 32, 'Smith'),
(2, 'Bob Brown', 'Science', 85, 'Ms. Johnson'),
(3, 'Charlie Davis', 'Science', 88, 'Ms. Johnson'),
(4, 'David Evans', 'Science', 82, 'Ms. Johnson'),
(5, 'Eva Green', 'Science', 90, 'raj'),
(6, 'Frank Harris', 'Science', 33, 'Ms. Johnson'),
(7, 'Grace Jones', 'Science', 93, 'Ms. Johnson'),
(8, 'Hannah King', 'Science', 79, 'Ms. Johnson'),
(9, 'Ian Lee', 'Science', 92, 'Ms. Johnson'),
(10, 'Jack Miller', 'Science', 86, 'Ms. Johnson'),

(1, 'Alice Johnson', 'English', 89, 'Mr. Brown'),
(2, 'Bob Brown', 'English', 83, 'Mr. Brown'),
(3, 'Charlie Davis', 'English', 91, 'Mr. Brown'),
(4, 'David Evans', 'English', 84, 'Mr. Brown'),
(5, 'Eva Green', 'English', 86, 'Mr. Brown'),
(6, 'Frank Harris', 'English', 82, 'Mr. Brown'),
(7, 'Grace Jones', 'English', 90, 'Mr. Brown'),
(8, 'Hannah King', 'English', 78, 'Mr. Brown'),
(9, 'Ian Lee', 'English', 85, 'Mr. Brown'),
(10, 'Jack Miller', 'English', 88, 'Mr. Brown');

-------List the names of those students who have obtained above 80 Marks in all subjects and sorted by NAME. 

select Student_Name from StudentDetails Where Mark>=80 and Subject in ('Science','English','Math')Group by Student_Name order by Student_Name asc;

-----List the name of staff who has handled exactly 2 subjects

select Name_of_the_staff from StudentDetails group by Name_of_the_staff having count(distinct subject)=2;

----Provide a bonus of 10 marks to students who have got below 40 marks. 

update StudentDetails set mark=mark+10 where mark<=40;

------Add an extra column to the table, give a remark, and fill the cell with a remark based on the mark. 

alter table StudentDetails add remark varchar(50);

update StudentDetails
set remark=case
when mark>90 then 'Excellent'
when mark>=80 and mark<=90 then 'Good'
when mark>=70 then 'Average'
when mark>=50 then 'Pass'
else 'fail'
end;

----select Name_of_the_staff f, Subject f from StudentDetails f group by Name_of_the_staff,Subject select Name_of_the_staff from StudentDetails where Name_of_the_staff in (select Name_of_the_staff from StudentDetails group by Name_of_the_staff having count(distinct Subject)=2); 

-----Update the staff name to Sam who handles exactly one subject. 

update StudentDetails set Name_of_the_staff='sam' where Name_of_the_staff in(select Name_of_the_staff from StudentDetails group by Name_of_the_staff having count(distinct Subject)=2);

-----Number of students in class. 

select count(distinct Student_Name)as NOS from StudentDetails;

------Number of Staff handling the class. 

Select count(distinct Name_of_the_Staff) from StudentDetails;

----Name of the students who failed. 

select Mark,Student_Name,Subject from StudentDetails where mark<=50;

-------Name of the student who got the first mark. 

select max(Mark) as First_Mark from StudentDetails where Subject='Math';

--------Find the average mark of each student in all 3 subjects. 

select Student_Name, avg(Mark) as Average from StudentDetails group by Student_Name;

select Student_Name, COALESCE(Subject,'TOTAL') , Sum(Mark) As Total from StudentDetails s5 group by rollup(Student_Name,Subject);

----Add a column internal mark and give 10 marks to all the students. 

alter table StudentDetails add Internal_Mark int;

update StudentDetails set Internal_Mark=10;


---select Student_Name, Subject, avg(Mark) as Average from StudentDetails group by rollup(Student_Name, Subject);

---Create a table for DSI_EMP with empid, name, project_name, Team_lead_name, Manager_name, experience, shift_time, 

CREATE TABLE DSI_EMP (EMP_ID INT, NAME varchar(50), PROJECT_NAME VARCHAR(50), TEAM_LEAD_NAME VARCHAR(50),MANAGER_NAME VARCHAR(50), EXPERIENCE INT, SHIFT_TIME VARCHAR(50));

INSERT INTO DSI_EMP (EMP_ID , NAME, PROJECT_NAME, TEAM_LEAD_NAME,MANAGER_NAME, EXPERIENCE, SHIFT_TIME)
VALUES (30201,'SAM','COOPER','RAJ','RAVI',4,'NIGHT'),
(30202,'RAM','COOPER','RAJ','RAVI',2,'NOON'), 
(30203,'SAM','BENCH','RAJ','RAVI',4,'NIGHT'),
(30204,'SAM','COOPER','RAJ','RAVI',1,'NIGHT'),
(30201,'SAM','COOPER','RAJ','RAVI',4,'NIGHT');

INSERT INTO DSI_EMP (EMP_ID , NAME, PROJECT_NAME, TEAM_LEAD_NAME,MANAGER_NAME, EXPERIENCE, SHIFT_TIME)
VALUES (3029,'SAM','COOPER','RAJ','RAVI',6,'NIGHT'),
(3027,'RAM','COOPER','RAJ','RAVI',7,'NOON'), 
(3026,'SAM','BENCH','RAJ','RAVI',8,'NIGHT'),
(30203,'SAM','COOPER','RAJ','RAVI',1,'NIGHT'),
(301,'SAM','COOPER','RAJ','RAVI',4,'NIGHT');

SELECT *FROM DSI_EMP;

-----Create	a	table	for	DSI_Intern	with	internid,	name,	project_name,	Team_lead_name, Manager_name, experience, shift_time, 

CREATE TABLE DSI_INTERN (INTERN_ID INT, NAME varchar(50), PROJECT_NAME VARCHAR(50), TEAM_LEAD_NAME VARCHAR(50),MANAGER_NAME VARCHAR(50), EXPERIENCE INT, SHIFT_TIME VARCHAR(50));


DROP TABLE DSI_INTERN;

-----Use a single statement to load all the values from DSI_EMP to DSI_Intern. 

INSERT INTO DSI_INTERN SELECT *FROM DSI_EMP;

SELECT *FROM DSI_INTERN;

------Delete the name of the DSI_EMP who is in project name ‘Bench’. 

DELETE FROM DSI_EMP WHERE PROJECT_NAME='bENCH';

-----Select a record from the DSI_EMP with 6 to 10 years of experience. 

select *from DSI_EMP where EXPERIENCE between 6 and 10;

-----Add a column salary in DSI_Intern. 

ALTER TABLE DSI_INTERN ADD SALARY INT;

------Add 30000 for employees who work on the night shift and with experience of 3 years to DSI_Intern. 

UPDATE DSI_INTERN SET SALARY=30000 WHERE EXPERIENCE = 4 AND SHIFT_TIME='NIGHT';

----Create a table for supermarkets with customer id, name, phone no, email, address, number of times visited in last 3 months, premium member or not, Bill Amount, Discount, and Net Amount. 

CREATE TABLE SUPRERMARKET(CUSTOMER_ID INT, NAME VARCHAR(50), PHONE BIGINT, EMAIL VARCHAR(100), NTVLT INT, PREMIUM VARCHAR(50), BILL_AMOUNT INT, DISCOUNT INT, NET_AMOUNT INT);

INSERT INTO SUPRERMARKET (CUSTOMER_ID , NAME , PHONE , EMAIL , NTVLT , PREMIUM , BILL_AMOUNT , DISCOUNT , NET_AMOUNT )
VALUES(1,'DANIEL',1234567890,'DAN@GMAIL.COM',2,'NO','1000','2','980'),
(2,'SAM',1234567890,'DAN@GMAIL.COM',2,'YES','1000','2','980'),
(3,'SAM',1234567890,'DAN@GMAIL.COM',11,'YES','1000','2','980'),
(4,'SAM',1234567890,'DAN@GMAIL.COM',4,'YES','1000','2','200000'),
(4,'DEEPAK',1234567890,'DAN@GMAIL.COM',12,'YES','1000','0','200000');

SELECT *FROM SUPRERMARKET;

----Provide a discount of 10% for the customer whose name has started with the letter d or D. 

UPDATE SUPRERMARKET SET DISCOUNT=10 WHERE NAME LIKE 'D%';

------Provide a discount of 15% for the customer who has a premium membership. 

UPDATE SUPRERMARKET SET DISCOUNT=15 WHERE PREMIUM='YES';

-----If the number of times visited is more than 10 provide 50 % off. 

UPDATE SUPRERMARKET SET DISCOUNT=50 WHERE NTVLT>=10;

-----The total of the particular customer bill is more than 100000 in the last 3 months provide 70 % off. 

update SUPRERMARKET set DISCOUNT=70 where NET_AMOUNT>=100000 and NTVLT >=3;

-----If any of them falls on all the category give 90% off. 

UPDATE SUPRERMARKET SET DISCOUNT=90 WHERE NTVLT>=10 AND PREMIUM='YES' AND NAME LIKE 'D%';











