--建立Course表
CREATE TABLE COURSE.COURSE (
ID INT IDENTITY PRIMARY KEY NOT NULL,
PRICE MONEY DEFAULT 0.00 NOT NULL,
RATE INT DEFAULT 0,
TITLE VARCHAR(50) NOT NULL,
INTRO TEXT DEFAULT 'NOT SET YET',
TEACHER INT NOT NULL,
CATEGORY INT NOT NULL
)
--建立Course_Lesson表
create table COURSE_LESSON (
COURSE_ID INT NOT NULL,
LESSON_ID INT NOT NULL,
)
--lESSON
create TABLE LESSON (
COURSE_ID INT NOT NULL,
ID INT identity(1,1) NOT NULL PRIMARY KEY,
CONTENT TEXT DEFAULT 'NOT SET YET',
TITLE VARCHAR(50) NOT NULL
)
--alter table lesson add constraint PK_LESSON primary key (course_id, id)

CREATE TABLE COURSE.DOCUMENT(
ID INT IDENTITY NOT NULL PRIMARY KEY,
LESSON_ID INT NOT NULL FOREIGN KEY REFERENCES COURSE.LESSON(ID),
AUTHOR VARCHAR(50) NULL,
TITLE VARCHAR(50) NOT NULL,
CONTENT TEXT NULL
)

CREATE TABLE COURSE.RESOURCE (
ID INT IDENTITY NOT NULL PRIMARY KEY,
LESSON_ID INT NOT NULL FOREIGN KEY REFERENCES COURSE.LESSON(ID),
TITLE VARCHAR(50) NOT NULL,
INTRO TEXT NULL,
TYPE INT NOT NULL,
URL VARCHAR(100) NOT NULL
)

CREATE TABLE CUSTOMER.CUSTOMER (
ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
NAME VARCHAR(50) NOT NULL,
PASSWORD VARCHAR(50) NOT NULL,
BALANCE MONEY DEFAULT 0.00 NOT NULL
)

ALTER TABLE CUSTOMER.CUSTOMER ADD UNIQUE(name)

create table CUSTOMER.ATTEND (
CUSTOMER_ID INT NOT NULL,
COURSE_ID INT NOT NULL,
START_TIME TIMESTAMP NOT NULL,
CURRENT_LESSON INT NOT NULL
)
ALTER TABLE CUSTOMER.ATTEND ADD CONSTRAINT FK_ATTEND_COURSE FOREIGN KEY (COURSE_ID) REFERENCES COURSE.COURSE(ID)
ALTER TABLE CUSTOMER.ATTEND ADD CONSTRAINT FK_ATTEND_CUSTOMER FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER.CUSTOMER(ID)
ALTER TABLE CUSTOMER.ATTEND ADD CONSTRAINT FK_ATTEND_CURRENTLESSON FOREIGN KEY (CURRENT_LESSON) REFERENCES COURSE.LESSON(ID)



CREATE TABLE CUSTOMER.TEACH (
CUSTOMER_ID INT NOT NULL FOREIGN KEY REFERENCES CUSTOMER.CUSTOMER(ID),
COURSE_ID INT NOT NULL FOREIGN KEY REFERENCES COURSE.COURSE(ID),
START_TIME TIMESTAMP NOT NULL

)

CREATE table CUSTOMER.NOTE(
TITLE VARCHAR(50) NULL,
CONTENT TEXT NOT NULL,
LESSON_ID INT NOT NULL FOREIGN KEY REFERENCES COURSE.LESSON(ID)
)
ALTER TABLE CUSTOMER.NOTE ADD
ID INT IDENTITY NOT NULL PRIMARY KEY

ALTER TABLE CUSTOMER.NOTE ADD
DATE TIMESTAMP NOT NULL



CREATE TABLE CUSTOMER.TAKE_NOTE(
	NOTE_ID INT NOT NULL FOREIGN KEY REFERENCES CUSTOMER.NOTE(ID),
	CUSTOMER_ID INT NOT NULL FOREIGN KEY REFERENCES CUSTOMER.CUSTOMER(ID)
)

CREATE TABLE MANAGER.TYPE (
ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
DESCRIPTION VARCHAR(50) NOT NULL
)

CREATE TABLE MANAGER.MANAGER (
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	NAME VARCHAR(50) NOT NULL UNIQUE,
	PASSWORD VARCHAR(50) NOT NULL,
	MNGR_TYPE INT NOT NULL FOREIGN KEY REFERENCES MANAGER.TYPE(ID)
)

CREATE TABLE PERMISSION (
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	NAME NCHAR(20) NOT NULL UNIQUE,
	TYPE NCHAR(20) NOT NULL
)
ALTER SCHEMA MANAGER TRANSFER DBO.PERMISSION

CREATE TABLE MANAGER.GRANTED (
 MANAGER_ID INT NOT NULL FOREIGN KEY REFERENCES MANAGER.MANAGER(ID),
 PERMISSION INT NOT NULL FOREIGN KEY REFERENCES MANAGER.PERMISSION(ID)
)

CREATE SCHEMA TRSACTION

CREATE TABLE TRSACTION.SALEORDER
(
	BUYER INT NOT NULL FOREIGN KEY REFERENCES CUSTOMER.CUSTOMER(ID),
	SALER INT NOT NULL FOREIGN KEY REFERENCES CUSTOMER.CUSTOMER(ID),
	PRICE MONEY NOT NULL DEFAULT 0.00,
	COURSE INT NOT NULL FOREIGN KEY REFERENCES COURSE.COURSE(ID),
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	TIME TIMESTAMP NOT NULL
)
ALTER TABLE TRSACTION.SALEORDER ADD CONSTRAINT CK_SALESORDER_BUYERNOTSALER CHECK (BUYER <> SALER)

alter table course.document add constraint FK_DOCUMENT_LESSON foreign key (LESSON_ID) references course.lesson(id)

create table COURSE.RES_TYPE (
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	DESCRIPTION NCHAR(20) NOT NULL
)

ALTER TABLE COURSE.RESOURCE ADD CONSTRAINT FK_RESOURCE_LESSON FOREIGN KEY (LESSON_ID) REFERENCES COURSE.LESSON(ID)

ALTER TABLE COURSE.RESOURCE ADD CONSTRAINT FK_RESOURCE_TYPE FOREIGN KEY (TYPE) REFERENCES COURSE.RES_TYPE(ID)

alter table customer.customer add EMAIL varchar(50) null
alter table customer.customer add DEGREE varchar(30) null 

--学历只有下面这五个选项
alter table customer.customer add constraint CK_CUSTOMER_DEGREE check (customer.DEGREE in ('Primary School or Lower', 'Junior High', 'Senior High', 'Undergrad', 'Grad'));

alter table course.course add constraint FK_COURSE_TEACHER foreign key (teacher) references customer.customer(id)

alter table course.lesson add constraint FK_LESSON_COURSE foreign key (course_id) references course.course(id)

alter table customer.customer add TEACH_RATE int null
go
alter table customer.customer add LEARN_RATE int null
go

create table CUSTOMER.FAVORITE (
	CUSTOMER_ID INT NOT NULL FOREIGN KEY REFERENCES CUSTOMER.CUSTOMER(ID),
	COURSE_ID INT NOT NULL FOREIGN KEY REFERENCES COURSE.COURSE(ID),
)

CREATE TABLE COURSE.COMMENT (
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	CUSTOMER_ID INT NOT NULL FOREIGN KEY REFERENCES CUSTOMER.CUSTOMER(ID),
	COURSE_ID INT NOT NULL FOREIGN KEY REFERENCES COURSE.COURSE(ID),
	CONTENT TEXT not NULL,
	TITLE VARCHAR(100) NULL,
)

-- For example
create table OPR_LOG(
	ID int identity not null primary key,
	OPR nchar(50) not null,
	OPR_TIME TIMESTAMP not null,
	MSG XML
)

--同一门课不能既当老师又当学生
--用户只能选择OK的课程
create function COURSE_ELIG()
returns int
as begin 
	return (select count(*) from customer.attend, customer.teach 
				where (customer.attend.customer_id = customer.teach.customer_id 
					and customer.attend.course_id = customer.teach.course_id )
					or CUSTOMER.ATTEND.COURSE_ID not in (select id from course.course_ok))

end

--同一个学生不能两次注册同样的课程
ALTER TABLE CUSTOMER.ATTEND ADD UNIQUE(CUSTOMER_ID, COURSE_ID)

alter table customer.attend add constraint CK_ATTEND_COURSEELIG check (dbo.COURSE_ELIG() = 0)


-----------------------------------------

drop function attendnotteach

alter table customer.attend drop  CK_ATTEND_SHOLDNOTTEACH
alter table customer.attend drop CK_ATTEND_ONLYOKCOURSE

alter table customer.attend add constraint CK_ATTEND_ONLYOKCOURSE CHECK (CUSTOMER.ATTEND.COURSE_ID IN (SELECT ID FROM CUSTOMER.CUSTOMER WHERE CUSTOMER_ID='OK'))

--查询一个班内全部学生
create procedure COURSE.GetStudentsForCourseID @ID int
as
select * from CUSTOMER.CUSTOMER
where customer.customer.id in (select customer_id from customer.attend where customer.attend.course_id = @ID)
go

exec course.GetStudentsForCourseID 000

--查询一个用户参加的所有课程

create procedure CUSTOMER.GetAllCoursesAttendedForCustomerID @ID int
as
select * from course.course
where course.id in (select course_id from customer.attend where customer.attend.customer_id = @ID)
go

--查询一个用户教授的所有课程

create procedure CUSTOMER.GetAllCoursesTaughtForCustomerID @ID int
as
select * from course.course
where course.id in (select course_id from customer.teach where customer.teach.customer_id = @ID)
go

alter table course.course add COURSE_STATUS NCHAR(10) not null default 'PENDING'
ALTER TABLE COURSE.COURSE DROP DF__COURSE__COURSE_S__51300E55
ALTER TABLE COURSE.COURSE DROP COLUMN COURSE_STATUS

--课程状态为OK Pending Cancel三种
alter table course.course add constraint CK_COURSE_STATUS check (COURSE_STATUS IN ('OK','PENDING','CANCEL'))


--测试插入
insert into customer.customer(name, password, email) values('ddd','ddd','d@d.cc')
insert into course.CATEGORY(CATE_NAME) values('Maths')

--
alter table customer.favorite add unique(customer_id, course_id)

--用户余额大于零
alter table customer.customer add constraint CK_CUSTOMER_BALANCEGTZERO check (balance >= 0)

--课程售价不小于零
alter table course.course add constraint CK_COURSE_PRICEGTZERO check (price >= 0)

--笔记和客户应该为多对一的关系
alter table customer.note add CUSTOMER_ID int foreign key references customer.customer(id)
drop table CUSTOMER.TAKE_NOTE

--用户生日
use CloudEDU
alter table customer.customer add BIRTHDAY date not null default '2013-01-01'
alter table customer.customer drop column birthday
alter table customer.customer drop DF__CUSTOMER__BIRTYD__373B3228
alter table customer.customer alter column birthday default '2013-01-01'

select getdate()

--课程限制级
alter table COURSE.COURSE add PG int
ALTER TABLE CUSTOMER.CUSTOMER DROP COLUMN PG

--限制级类型
create table course.PARENT_GUIDE (
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	RESTRICT_AGE INT NOT NULL CHECK (RESTRICT_AGE >= 0),
	DESCRIPTION NVARCHAR(100)
)

ALTER TABLE COURSE.COURSE ADD CONSTRAINT FK_COURSE_PG FOREIGN KEY (PG) REFERENCES COURSE.PARENT_GUIDE(ID)

--课程图片
alter table course.course add ICON_URL nvarchar(100)

--推荐课程
create table course.RECOMMENDATION (
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	TITLE NVARCHAR(100) NOT NULL,
	DESCRIPTION TEXT NULL,
	ICON_URL NVARCHAR(100) NULL
)

CREATE TABLE COURSE.RECO_COURSE (
	COURSE_ID INT FOREIGN KEY REFERENCES COURSE.COURSE(ID),
	RECO_ID INT FOREIGN KEY REFERENCES COURSE.RECOMMENDATION(ID)
)

--NOTE分享
alter table customer.note add SHARE bit not null default 0

alter table course.reco_course add primary key (course_id, reco_id)

use CloudEDU

--创建关系表的联合主键
alter table manager.granted add constraint PK_GRANTED_UNIONPK primary key
(manager_id, permission)
go

alter table customer.attend add constraint PK_ATTEND_UPK primary key (customer_id, course_id)

alter table course.reco_course add constraint PK_RECOCOURSE_UPK primary key (course_id, reco_id)

alter table customer.favorite add constraint PK_FAVORITE_UPK primary key (customer_id, course_id)

--可分享笔记

create view customer.NOTE_SHARABLE
as
	SELECT * FROM CUSTOMER.NOTE WHERE SHARE = 1;
go

--

alter table course.lesson add NUMBER int not null check (NUMBER >= 0)

alter table course.comment add TIME datetime not null