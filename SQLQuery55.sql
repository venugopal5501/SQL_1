use venugopal

create table Customer(No int primary key, Fname varchar(60), Lname varchar(60),
Phone bigint, Address varchar(90));

exec sp_help Customer