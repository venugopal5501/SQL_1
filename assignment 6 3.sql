use VenuGopal;

create table boats (bid int primary key, banme varchar(60), color varchar(60));

insert into boats (bid, banme, color)
values(101,'interlake','blue'),
(102,'interlake','red'),
(103,'clipper','green'),
(104,'marine','red');

create table sailors (sid int primary key, sname varchar(60), rating int, age int);
truncate table sailors;
insert into sailors(sid  , sname , rating , age ) values

(22,'dustin',7,45),
(29,'Brutus',1,33),
(31,'lubber',8,55),
(32,'andy',8,25),
(58,'rusty',10,35),
(64,'horatio',7,35),
(71,'zorba',10,16),
(74,'horatio',9,35),
(85,'art',3,25.5),
(95,'bob',3,63.5);
drop table boats;
drop table sailors;
drop table reserves;
create table reserves(sid int,bid int, day date, primary key(sid,bid));

alter table reserves add foreign key (bid) references boats(bid);

alter table reserves add foreign key (sid) references sailors(sid);

truncate table boat;

select *from sailors;
select *from boats;
select *from reserves;

insert into reserves(sid,bid,day)
values (22,101,'2021-10-10'),
(22,102,'2021-10-10'),
(22,103,'2021-10-08'),
(22,104,'2021-10-07'),
(31,102,'2021-11-10'),
(31,103,'2021-11-06'),
(31,104,'2021-11-12'),
(64,101,'2021-09-05'),
(64,102,'2021-09-08'),
(74,103,'2021-09-08');

-----Find the names of sailors who have reserved boat 103. 

select s.sid,s.sname from sailors s join  reserves r on s.sid=r.sid where bid=103   

----Find the names of sailors who have reserved a red boat. 

select distinct s.sid,s.sname,b.color from sailors s join  reserves r on s.sid=r.sid join boats b on r.bid=b.bid where b.color='red';

-----Find the colors of boats reserved by Lubber. 

select b.color from boats b join reserves r on r.bid=b.bid join Sailors s  on s.sid=r.sid where s.sname='lubber';

----Find the sailor name, boat id, and reservation date for each reservation. 

select s.sname, r.bid, r.day from sailors s join reserves r on r.sid=s.sid join boats b on b.bid=r.bid;

----Find the sids of sailors who have reserved a red boat. 

select r.sid from reserves r join boats b on b.bid=r.bid group by r.sid where color='red';

select distinct r.sid from reserves r where r.bid in 
(select b.bid from boats b where color='red');

----Find the sailors with the highest rating. 

select *from sailors order by rating desc;

----Find the name and age of the oldest sailor. 

select sname, age from sailors order by age desc;

select avg(age) as  averages from sailors;

select s.sname from sailors s join reserves r on s.sid=r.sid group by s.sname having count(r.bid)=1; 

----4.	Find the names of sailors who have reserved at least one boat.

select s.sname from sailors s join (select r.sid from reserves r group by r.sid having count(r.sid)=1) as exact on s.sid=exact.sid;

select distinct s.sid, s.sname from sailors s join reserves r on s.sid=r.sid;

-----

-----5.	Find the names of sailors who have reserved a red or a green boat.

select distinct s.sname, s.sid from sailors s join reserves r on r.sid=s.sid 
join boats b on b.bid=r.bid where b.color='red' or b.color='green' 

---6.	Find the names of sailors who have reserved a red and a green boat.

select s.sname, s.sid from sailors s join reserves r on r.sid=s.sid 
join boats b on b.bid=r.bid where b.color='red' intersect 
select s.sname, s.sid from sailors s join reserves r on r.sid=s.sid 
join boats b on b.bid=r.bid where b.color='green'

----29.	Find the names of sailors who have reserved all boats whose name starts with “Interlake”.

select distinct s.sname,s.sid from sailors s join reserves r on r.sid=s.sid join boats b on b.bid=r.bid where b.banme='interlake'; 

---23.	For each red boat, find the number of reservations for this boat.

select b.bid,count(r.bid) as count from reserves r join boats b on b.bid=r.bid where b.color='red' group by b.bid;

select s.sname from sailors s where rating having >= 'Horatio';

-----16.	Find sailors whose rating is better than some sailor called Horatio.

select s.sname,s.rating from sailors s where s.rating >(select max(rating) from sailors where sname='horatio');

-----15.	Find all sids of sailors who have a rating of 10 or have reserved boat 104.

select s.sid, s.sname, s.rating from sailors s where rating=10 union all
select s.sid, s.sname,s.rating  from sailors s join reserves r on r.sid=s.sid join boats b 
on b.bid=r.bid where r.bid=103;

----21.	Find the age of the youngest sailor for each rating level.

select age,rating from sailors order by age asc, rating desc;


----20.	Find the names of sailors who are older than the oldest sailor with a rating of 10.

select s.sname, s.age, s.rating from sailors s where s.age >
(select max(age) from sailors where rating=10)

--select  s.sid,s.sname from sailors s join reserves r on r.sid=s.sid 
--join boats b on b.bid=r.bid where b.color='red' union 
--select s.sid,s.sname from sailors s join reserves r on r.sid=s.sid 
--join boats b on b.bid=r.bid where b.color!='green'

--Find the names of sailors who have reserved at least two boats.

select s.sname from sailors s where s.sid in(select r.sid from reserves r group by r.sid having count(r.sid)>=2 );

--8.	Find the sids of sailors with age over 20 who have not reserved a red boat.

select s.sid, s.sname from sailors s where s.age>20 and s.sid in
(select r.sid from reserves r where r.sid not in
(select r.sid from reserves r where r.bid in
(select r.bid from reserves r where r.bid in 
(select b.bid from boats b where b.color='red'))));

--9.	Find the names of sailors who have reserved all boats. The use of the word all (or every) is a good indication that the division operation might be applicable: Division returns all sids such that there is a tuple ⟨sid,bid⟩ in the first relation for each bid in the second.

select s.sname from sailors s where sid in
(select r.sid from reserves r group by r.sid having count(distinct r.bid) in
(select distinct count(b.bid) from boats b));

select *from sailors;
select *from reserves;

--22.	Find the age of the youngest sailor who is eligible to vote (i.e., is at least 18 years old) for each rating level with at least two such sailors.

select min(age), rating from sailors s where age>=18
group by rating having count(distinct sid)>=2;


--24.	Find the average age of sailors for each rating level that has at least two sailors

select avg(age) as average, rating from sailors group by rating 
having count(distinct sid)>=2

--25.	Find those ratings for which the average age of sailors is the minimum overall ratings.

select rating, sname from sailors where age in
(select min(age) from sailors where age in
(select avg(age) from sailors group by rating))

--26.	Find all sailor id’s of sailors who have a rating of at least 8 or reserved boat 103.

select  s.sid from sailors s where s.rating >=8 union
select  sid  from reserves where bid=103

--30.	Find the sailor id’s of sailors whose rating is better than some sailor called Bob.

select sid, sname, rating from sailors where rating >  any
(select s.rating from sailors s where sname='bob')

--31.	Find the sailor id’s of sailors whose rating is better than every sailor called Bob.

select sid, sname, rating from sailors where rating >  any
(select s.rating from sailors s where sname='bob')

--33.	For each rating, find the average age of sailors at that level of rating.

select avg(age) as avg, rating from sailors group by rating;

--14.	Find the sids of all sailors who have reserved red boats but not green boats. (set-difference)

select s.sid,s.sname from sailors s where s.sid in 
(select r.sid from reserves r where r.bid in
(select b.bid from boats b where b.color='red' and b.bid in
(select b.bid from boats b where b.color<>'green')))

go

select b.bid, avg(s.age) avasge from sailors s,boats b where 
s.age>=40 group by s.rating and s.sid in
(select r.sid from reserves r where r.bid in
(select r.bid from reserves r having count(r.bid)>=2))

--35.	For each boat which was reserved by at least 2 sailors with age >= 40, find the boat id and the average age of such sailors.

select b.bid, avg(age) as average from sailors s 
join reserves r on r.sid=s.sid join 
boats b on b.bid=r.bid where s.age>=40 group by b.bid having count(r.bid)>=2


--1.	For each boat which was reserved by at least 3 distinct sailors, find the boat id and the average age of sailors who reserved it.

select b.bid,avg(s.age) from sailors s join reserves r on r.sid=s.sid
join boats b on b.bid=r.bid where r.bid in
(select r.bid from reserves r group by r.bid having  count(distinct r.sid)>=3)GROUP BY b.bid; 


--28.	Find the sailor id’s of sailors with age over 20 who have not reserved a boat whose name includes the string “Clipper”.

select s.sid from sailors s where s.age>20 and s.sid in
(select r.sid from reserves r where r.sid not in
(select r.sid from reserves r where r.bid in
(select b.bid from boats b where b.banme='clipper')))

select s.sname from sailors s 




















