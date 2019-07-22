create database PRJ_ChatRoom
go
use PRJ_ChatRoom
go

create table Account
(
email nvarchar(50) primary key,
[password] nvarchar(50) not null,
username nvarchar(50) unique not null,
fname nvarchar(50) not null,
lname nvarchar(50) not null,
gender bit not null,
createDate datetime default getdate() not null
);

create table [Message]
(
id int identity(1,1) primary key,
content nvarchar(1000) not null,
createDate datetime default getdate() not null,
sender nvarchar(50) foreign key references Account(username) not null
);

insert into Account (email, [password],username,fname,lname,gender)
values('pqhuy1999@gmail.com','123456','huy_zz','Quang Huy','Pham',1)

insert into [Message]
values('hello',GETDATE(),'huy_zz')

--select * from Account

--drop table [Message], Account

--delete from Message where content like '%%'

--select * from [Message] order by createDate desc