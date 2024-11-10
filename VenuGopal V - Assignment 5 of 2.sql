use Venugopal



create table graduate(s_no int, name varchar(60),stipend int, subject varchar(50), average int, div int);

insert into graduate(s_no , name,stipend , subject , average , div )
values(1, 'karan',400,'physics',68,1),
(2, 'divakar',450,'computer sc',68,1),
(3, 'divya',300,'chemistry',62,2),
(4, 'arun',350,'physics',63,1),
(5, 'sabina',500,'maths',70,1),
(6, 'john',400,'chemistry',55,2),
(7, 'robert',250,'physics',64,1),
(8, 'rubina',450,'maths',68,1),
(9, 'vikas',500,'computer sc',62,1),
(10, 'mohan',300,'maths',57,2);

select name,div from graduate where div=1 order by name;

select name,stipend*12 as total_stipend,subject from graduate ;

select subject,count(name) as total from graduate where subject in ('physics', 'computer sc') group by subject;

insert into graduate values(11,'kajol',300,'computer sc',75,1)

Select MIN(AVERAGE) from GRADUATE where SUBJECT= 'PHYSICS'; 

Select SUM(STIPEND) from GRADUATE where DIV=2; 

Select AVG(STIPEND) from GRADUATE where AVERAGE>=65;

Select COUNT(distinct SUBJECT) from GRADUATE; 

create table guide (mainarea varchar(50),advisor varchar(50));

insert into guide (mainarea ,advisor)
values('physics','vinod'),
('computer sc','alok'),
('chemistry','rajan'),
('maths','mahesh');

SELECT	NAME, ADVISOR 

FROM	GRADUATE, GUIDE 

WHERE	SUBJECT = MAINAREA 

create table club (coach_id int, coach_name varchar(60), age int, sports varchar(40), dateofapp date, pay int, sex varchar(1));

truncate table club;
insert into club(coach_id , coach_name , age , sports , dateofapp , pay , sex)
values(1,'kukreja',35,'karate','1997-03-27',1000,'m')

INSERT INTO Club (COACH_ID, COACH_NAME, AGE, SPORTS, DATEOFAPP, PAY, SEX) VALUES
(1, 'KUKREJA', 35, 'KARATE', '1997-03-27', 1000, 'M'),
(2, 'RAVINA', 34, 'KARATE', '1998-01-20', 1200, 'F'),
(3, 'KARAN', 34, 'SQUASH', '1998-02-19', 2000, 'M'),
(4, 'TARUN', 33, 'BASKETBALL', '1998-01-01', 1500, 'M'),
(5, 'ZUBIN', 36, 'SWIMMING', '1998-01-12', 750, 'M'),
(6, 'KETAKI', 36, 'SWIMMING', '1998-02-24', 800, 'F'),
(7, 'ANKITA', 39, 'SQUASH', '1998-02-20', 2200, 'F'),
(8, 'ZAREEN', 37, 'KARATE', '1998-02-20', 1100, 'F'),
(9, 'KUSH', 41, 'SWIMMING', '1998-01-13', 900, 'M'),
(10, 'SHAILYA', 37, 'BASKETBALL', '1998-02-19', 1700, 'M');


select *from club where sports='swimming';

select coach_name, pay, age, pay*15/100+pay as bonus from club;

Select COUNT(distinct SPORTS) from CLUB; 

Select MIN(AGE) from CLUB where SEX = 'F';

Select AVG(PAY) from CLUB where SPORTS = 'KARATE';

Select SUM(PAY) from CLUB where dateofapp > {31/01/98}; 

select coach_name, dateofapp from club order by dateofapp desc;

create table coaches(sportsperson varchar(50), sex varchar(2), coach_no int);

insert into coaches(sportsperson , sex , coach_no )
values('ajay','m',1),
('seema','f',2),
('vinod','m',1),
('taneja','f',3);

SELECT SPORTSPERSON, COACH_NAME FROM CLUB, COACHES WHERE COACH_ID = COACH_NO 

CREATE TABLE SPORTS (
    StudentNo INT PRIMARY KEY,
    Class INT,
    Name VARCHAR(50),
    Game1 VARCHAR(50),
    Grade1 CHAR(1),
    Game2 VARCHAR(50),
    Grade2 VARCHAR(1)
);

INSERT INTO SPORTS (StudentNo, Class, Name, Game1, Grade1, Game2, Grade2) VALUES
(10, 7, 'Sammer', 'Cricket', 'B', 'Swimming', 'A'),
(11, 8, 'Sujit', 'Tennis', 'A', 'Skating', 'C'),
(12, 7, 'Kamal', 'Swimming', 'B', 'Football', 'B'),
(13, 7, 'Venna', 'Tennis', 'C', 'Tennis', 'A'),
(14, 9, 'Archana', 'Basketball', 'A', 'Athletic', 'C');

select name,Game1,Grade1,Game2,Grade2 from sports where Grade1='c' or grade2='c' ;

select count(name) as count_in_cricket from sports where game1='Cricket' and grade1='a';

select name from sports where Game1=Game2; 

select name, game1, game2 from sports where name like 'a%';

alter table sports add Marks int;

update SPORTS set marks = 300 where grade1='b' or grade1='a' and grade2='a' or grade2='b';

select *from SPORTS order by name;

CREATE TABLE FURNITURE (
    No INT PRIMARY KEY,
    ItemName VARCHAR(50),
    Type VARCHAR(50),
    DateOfStock DATE,
    Price INT,
    Discount INT
);

INSERT INTO FURNITURE (No, ItemName, Type, DateOfStock, Price, Discount) VALUES
(1, 'White lotus', 'Double Bed', '2002-02-23', 30000, 25),
(2, 'Pink feather', 'Baby cot', '2002-01-20', 7000, 20),
(3, 'Dolphin', 'Baby cot', '2002-02-19', 9500, 20),
(4, 'Decent', 'Office Table', '2002-01-01', 25000, 30),
(5, 'Comfort zone', 'Double Bed', '2002-01-12', 25000, 25),
(6, 'Donald', 'Baby cot', '2002-02-24', 6500, 15),
(7, 'Royal Finish', 'Office Table', '2002-02-20', 18000, 30),
(8, 'Royal tiger', 'Sofa', '2002-02-22', 31000, 30),
(9, 'Econo sitting', 'Sofa', '2001-12-13', 9500, 25),
(10, 'Eating paradise', 'Dining Table', '2002-02-19', 11500, 25);

-- Create the ARRIVAL table
CREATE TABLE ARRIVAL (
    No INT PRIMARY KEY,
    ItemName VARCHAR(50),
    Type VARCHAR(50),
    DateOfStock DATE,
    Price INT,
    Discount INT
);

-- Insert data into the ARRIVAL table
INSERT INTO ARRIVAL (No, ItemName, Type, DateOfStock, Price, Discount) VALUES
(11, 'Wood Comfort', 'Double Bed', '2003-03-23', 25000, 25),
(12, 'Old Fox', 'Sofa', '2003-02-20', 17000, 20),
(13, 'Micky', 'Baby cot', '2002-02-21', 7500, 15);


select *from FURNITURE where type='Baby cot';

select itemname, price from FURNITURE where price >=15000;

select itemname,type,dateofstock from furniture where DateOfStock < '2002-01-22' order by ItemName desc;

select itemname, dateofstock, discount from FURNITURE where discount>=25; 

select count(type) as total from FURNITURE where type='sofa';

select *from FURNITURE;

insert into ARRIVAL values(14,'velvet touch','double bed','2003-03-25',25000,30);

Select COUNT(distinct TYPE) from FURNITURE; 

Select MAX(DISCOUNT) from FURNITURE,ARRIVAL; 

Select AVG(DISCOUNT) from FURNITURE where TYPE = 'Baby cot'; 

Select SUM(PRICE) from FURNITURE where DATEOFSTOCK < {12/02/02}

Select SUM(PRICE) from FURNITURE where DATEOFSTOCK < '2002/02/12'