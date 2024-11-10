use hospital;

--1.	write a SQL query to find out which nurses have not yet been registered. Return all the fields of nurse table.

select *from nurse where Registered=0;

--2.	write a SQL query to identify the nurses in charge of each department. Return nurse name as “name”, Position as “Position”.

select name, position from nurse where Position='head nurse';

-- 3.	write a SQL query to identify the physicians who are the department heads. Return the Department name as “Department” and the Physician name as “Physician”.

select distinct p.EmployeeID,p.name,  d.name from Physician p  join Department d on
d.head=p.EmployeeID;

--4.	write a SQL query to count the number of patients who scheduled an appointment with at least one physician. Return count as "Number of patients taken at least one appointment".

select count(distinct a.patient) as [Number of patients]
from Appointment a having count(Physician)>1;

select patient, count(Physician) as counts  from Appointment group by patient;

--5. From the following table, write a SQL query to locate the floor and block where room number 212 is located. Return block floor as "Floor" and block code as "Block".

select blockfloor as floor, blockcode as code from room where RoomNumber=212;

--6. From the following table, write a SQL query to count the number available rooms. Return count as "Number of available rooms".

select count(roomnumber)as [Number of available rooms]  from Room where Unavailable=0;

--7. From the following table, write a SQL query to count the number of unavailable rooms. Return count as "Number of unavailable rooms".

select count(roomnumber)as [Number of available rooms]  from Room where Unavailable=1;

--8.	write a SQL query to identify the physician and the department with which he or she is affiliated. Return Physician name as "Physician", and department name as "Department".

select p.name as physician, d.name as department,a.PrimaryAffiliation  from Physician p join  Affiliated_With a on
a.Physician=p.EmployeeID join Department d on d.DepartmentID=a.Department where a.PrimaryAffiliation=1;

--9.	write a SQL query to find those physicians who have received special training. Return Physician name as “Physician”, treatment procedure name as "Treatment".

select p.name as Physician  ,pp.name as Treatment from Physician P join Trained_In T on p.EmployeeID=t.Physician join Procedures PP on t.Treatment=pp.Code
--select p.EmployeeID,p.name,pr.name from Physician p, Procedures pr where p.EmployeeID in
--(select t.physician from Trained_In t)

--10.	write a SQL query to find those physicians who are yet to be affiliated. Return Physician name as "Physician", Position, and department as "Department".

select p.name as Physician, p.position as Position, d.Name as deparment from Physician p join
Affiliated_With a on a.Physician=p.EmployeeID join Department d on d.DepartmentID=a.Department 
where a.PrimaryAffiliation=0

--11.	write a SQL query to identify physicians who are not specialists. Return Physician name as "Physician", position as "Designation".

select  p.EmployeeID, p.name, t.treatment from  Physician p left OUTER join
Trained_In t   on p.EmployeeID=t.Physician where t.treatment is  null order by EmployeeID;

select p.EmployeeID from Physician p where p.EmployeeID not in(select t.physician from Trained_In t )
--
--12.	write a SQL query to find the patients with their physicians by whom they received preliminary treatment. Return Patient name as "Patient", address as "Address" and Physician name as "Physician".

select p.name, a.physician, count(a.Physician) as counts from Appointment a join
Patient p on a.Patient= p.SSN join Physician ph on a.Physician=ph.EmployeeID
group by a.physician,p.name 

select Patient ,Physician, count(Physician)  as counts from Appointment group by rollup( Patient,Physician) order by Patient

select p.name, a.Physician from Appointment a join patient p on a.patient=p.SSN order by p.Name
----

select p.ssn,p.name,p.address,ph.name from Patient p join Appointment a
on a.Patient=p.SSN join Physician ph on ph.EmployeeID=a.Physician order by p.Name

--13.	write a SQL query to identify the patients and the number of physicians with whom they have scheduled appointments. Return Patient name as "Patient", number of Physicians as "Appointment for No. of Physicians".

select p.ssn,p.name,p.address,ph.name from Patient p join Physician ph on p.pcp=ph.EmployeeID

/*select p.name,b.examinationRoom from patient p,Appointment b where p.SSN in
(select a.Patient from Appointment a where a.ExaminationRoom in
(select c.ExaminationRoom from Appointment c))*/

----14. From the following tables, write a SQL query to count the number of unique patients who have been scheduled for examination room 'C'. Return unique patients as "No. of patients got appointment for room C".

select count(distinct Patient) as [No of patients]  from Appointment where ExaminationRoom like 'c%';

--15.	write a SQL query to find the names of the patients and the room number where they need to be treated. Return patient name as "Patient", examination room as "Room No.", and starting date time as Date "Date and Time of appointment".

select  p.name as Patient,a.examinationRoom as RoomNo,a.Startdate as [Date and Time of appointment] from Patient p join Appointment a
on p.SSN=a.Patient order by p.Name

--16.	write a SQL query to identify the nurses and the room in which they will assist the physicians. Return Nurse Name as "Name of the Nurse" and examination room as "Room No."

select n.name as [Name of the nurse],a.examinationroom as [room no] from Nurse n join Appointment a
on a.PrepNurse=n.EmployeeID

--17.	write a SQL query to locate the patients who attended the appointment on the 25th of April at 10 a.m. Return Name of the patient, Name of the Nurse assisting the physician, Physician Name as "Name of the physician", examination room as "Room No.", schedule date and approximate time to meet the physician.

select pat.name, nur.name ,phy.name,a.examinationroom, a.StartDate
from Patient pat join Appointment a on a.Patient=pat.SSN join
nurse nur on nur.EmployeeID=a.PrepNurse join Physician phy on
phy.EmployeeID=a.Physician where day(a.StartDate)=25 and MONTH(a.StartDate)=4

--18.	write a SQL query to identify those patients and their physicians who do not require any nursing assistance. Return Name of the patient as "Name of the patient", Name of the Physician as "Name of the physician" and examination room as "Room No.".

select pat.name as [Name of the patient],phy.name as [Name of the physician],a.examinationroom as [Room no] from Patient pat join Appointment a
on pat.ssn=a.Patient join Physician phy on phy.EmployeeID=a.Physician where a.PrepNurse is null;

--19.	write a SQL query to locate the patients' treating physicians and medications. Return Patient name as "Patient", Physician name as "Physician", Medication name as "Medication".

select pat.name as [Patient], phy.name [Physician], m.name [Medication] from Patient pat join Prescribes pre
on pre.Patient=pat.SSN join Physician phy on phy.EmployeeID=pre.Physician
join Medication m on m.Code=pre.Medication

--20.	write a SQL query to identify patients who have made an advanced appointment. Return Patient name as "Patient", Physician name as "Physician" and Medication name as "Medication".

select pat.name,phy.name,m.name from Patient pat join Prescribes pre on
pre.Patient=pat.SSN join Physician phy on phy.EmployeeID=pre.Physician
join Medication m on pre.Medication=m.Code where pre.Appointment is not null;

--21.	write a SQL query to find those patients who did not schedule an appointment. Return Patient name as "Patient", Physician name as "Physician" and Medication name as "Medication".

select pat.name,phy.name,m.name from Patient pat join Prescribes pre on
pre.Patient=pat.SSN join Physician phy on phy.EmployeeID=pre.Physician
join Medication m on pre.Medication=m.Code where pre.Appointment is null;

--22.	write a SQL query to count the number of available rooms in each block. Sort the result-set on ID of the block. Return ID of the block as "Block", count number of available rooms as "Number of available rooms".

select blockcode as Block, count(Unavailable) as [Number of rooms availabe]  from Room  where Unavailable=1 group by blockcode

--23.	write a SQL query to count the number of available rooms in each floor. Sort the result-set on block floor. Return floor ID as "Floor" and count the number of available rooms as "Number of available rooms".

select BlockFloor as Floors, count(Unavailable) as [Number of rooms availabe]  from Room  where Unavailable=1 group by BlockFloor

--24.	write a SQL query to count the number of available rooms for each floor in each block. Sort the result-set on floor ID, ID of the block. Return the floor ID as "Floor", ID of the block as "Block", and number of available rooms as "Number of available rooms".

select BlockFloor as floors, blockcode as block ,count(unavailable) as 
[Number of available rooms] from room where Unavailable=1 group by BlockFloor, BlockCode order by BlockFloor

--25.	write a SQL query to count the number of rooms that are unavailable in each block and on each floor. Sort the result-set on block floor, block code. Return the floor ID as "Floor", block ID as "Block", and number of unavailable as “Number of unavailable rooms".

select BlockFloor as floors, blockcode as block ,count(unavailable) as 
[Number of unavailable rooms] from room where Unavailable=0 group by BlockFloor, BlockCode order by BlockFloor


--26.	write a SQL query to get
/*a) name of the patient,
b) name of the physician who is treating him or her,
c) name of the nurse who is attending him or her,
d) which treatment is going on to the patient,
e) the date of release,
f) in which room the patient has been admitted and which floor and block the room belongs to respectively.*/


select pat.name, phy.name, nur.name, pro.name, under.dateundergoes, st.Room,ro.BlockCode,ro.BlockFloor
from Patient pat join Undergoes under on pat.SSN=under.Patient
join Physician phy on under.Physician=phy.EmployeeID  join
Nurse nur on under.AssistingNurse=nur.EmployeeID join Procedures pro
on under.Procedures=pro.Code join Stay st on under.Stay=st.StayID
join Room ro on ro.RoomNumber=st.Room 

--27.	write a SQL query to find out, which nurses have been on call for room 122 in the past. Return name of the nurses.

select name from Nurse where EmployeeID in
(select Nurse from On_Call where BlockCode in
(select BlockCode from room where RoomNumber=122))







