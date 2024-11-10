use VenuGopal;

create table procedure3(code int primary key, name varchar(60), cost real);

create table blocks(blockfloor int, blockcode int, primary key(blockfloor, blockcode));

drop table department55;

create table nurse(employeeid int primary key, name varchar(60), position varchar(60), registered bit, ssn int);

create table physician(employeeid int primary key, name varchar(60), position varchar(60), ssn int);

create table medication (code int primary key, name varchar(60),brand varchar(50), description varchar(50));

drop table medication;
create table department55(departmentid int primary key, name varchar(60), head int constraint fk_dep foreign key references physician(employeeid));



create table prescrib(physician int , patient int, medication int, date timestamp, appointment int, dose text, primary key(physician,patient,medication,date) );

alter table appointment add foreign key(physician) references physician(employeeid);

alter table appointment add foreign key(patient) references patient(ssn);

alter table appointment add foreign key(prepnurse) references nurse(employeeid);

alter table patient add foreign key(pcp) references physician(employeeid);

exec sp_help prescribes

alter table undergoes add foreign key(patient) references patient (ssn);

alter table undergoes add foreign key(proceduress) references procedure3 (code);

alter table undergoes add foreign key(stay) references stay (stayid);

alter table undergoes add foreign key(assistingnurse) references nurse (employeeid);





alter table undergoes add foreign key(physician) references physician (employeeid);




alter table prescrib add foreign key(physician) references physician (employeeid);

alter table prescrib add foreign key(patient) references patient (ssn);

alter table prescrib add foreign key(appointment) references appointment (appointmentid);

alter table prescrib add foreign key(medication) references medication (code);


alter table prescribes add primary key(physician);

create table patient(ssn int primary key, name text, address text, phone text, insuranceid int, pcp int);

create table room(room_number int primary key, roomtype text, blockfloor int, blockcode int, unavailable bit);
drop table room;
create table stay(stayid int primary key, patient int, room int, start_time timestamp, end_time datetime);

create table trained_in(physician int, treatment int, certification date, certificationexpires date,primary key(physician, treatment));

create table affiliated_with(physician int, department int, primaryaffiliation bit, constraint pk_with primary key(physician, department));

create table on_call(nurse int, blockfloor int, blockcode int, oncallstart datetime, oncallend timestamp, primary key(nurse, blockfloor, blockcode, oncallstart, oncallend));

create table undergoes(patient int, proceduress int, stay int, date timestamp,physician int, assistingnurse int, primary key(patient, proceduress, stay, date, physician) );

create table appointment(appointmentid int primary key, patient int, prepnurse int, physician int, start_dt_time timestamp, end_dt_time datetime, examination text);

alter table trained_in add constraint fk_in foreign key(physician) references physician(employeeid),constraint fk_poc foreign key(treatment) references procedure3(code);

alter table room add foreign key(blockfloor, blockcode) references blocks (blockfloor,blockcode);

alter table stay add foreign key(patient) references patient(ssn); 

alter table stay add foreign key(room) references room(room_number); 

alter table affiliated_with add foreign key(department) references department55(departmentid);

alter table affiliated_with add foreign key(physician) references physician(employeeid);


alter table on_call add foreign key(blockfloor,blockcode) references blocks(blockfloor,blockcode);

alter table on_call add foreign key(nurse) references nurse(employeeid);


drop table block;