--course 21 
--select * from Departments
select *from Employees
select *from Customers

declare @department_id int;
declare @total_employees int;
declare @start_date date;
declare @end_date date;
declare @department_name nvarchar(50);

set @department_id=3;
select @department_name= Name from Departments 
where DepartmentID=@department_id;

set @start_date= '2023-1-1';
set @end_date ='2023-12-31';

select @total_employees =count(*) from Employees
where HireDate between @start_date and @end_date
print 'total employees is '+ cast( @total_employees as varchar);

---
select * from Sales
declare @year int;
declare @month int;
declare @total_sales decimal(10,2);
declare @total_number int;
declare @avg decimal(10,2);

set @year=2023;
set @month=6;

select @total_sales=sum(SaleAmount) from Sales
where  YEAR(SaleDate)=@year and MONTH(SaleDate)=@month;

select @total_number= count(*) from Sales
where  YEAR(SaleDate)=@year and MONTH(SaleDate)=@month;

set @avg =@total_sales/@total_number;

print 'average is'+ cast(@avg as varchar) + ' for total sales :'+cast(@total_sales as varchar) 
+' and count : '+cast(@total_number as varchar);


select * from Purchases

declare @customer_id int;
declare @earned_points int;
declare @total_spent decimal(10,2);


set @customer_id=1; 

select @total_spent=sum(Amount) from Purchases
where CustomerID=@customer_id;

set @earned_points= cast(@total_spent/10 as int);

update Customers 
set LoyaltyPoints=@earned_points+LoyaltyPoints
where CustomerID=@customer_id;

declare @x int;
declare @y int;
set @x=10;
set @y=20;

if @x>@y
	begin 
		print 'x is greater'
	end
else
	if @x=@y
		begin
			print 'equal'
		end
	else
		begin
			print 'y is greater'
		end
end;

select EmployeeID,
case DepartmentID
when 1 then 'good'
when 2 then 'well'
when 3 then 'perfect'
else 'd'
end as department1
from Employees

select * from Employees2

update Employees2
set Salary=
case
when PerformanceRating >90 then Salary*1.15
when PerformanceRating >75 and PerformanceRating<90 then Salary*1.10
when PerformanceRating between 50 and 75 then Salary*1.5
end

select count(*),level1 from(
select level1=
case
when PerformanceRating >85 then 'high'
when PerformanceRating between 75 and 85 then 'miduim'
else 'low'
end
from Employees2)R123
group by level1


declare @balance int;
declare @amount int;
set @balance=950;
set @amount=100;

while @balance >0
begin
set @balance=@balance-@amount
if(@balance<0)
	begin
	print 'error'
	end
else
begin
print 'done'
end
end

-- stored prosedures 
create procedure sp_add_new
@name nvarchar(100),
@salary int,
@id_p int output
as 
begin 
insert into People (name,salary)
values(@name,@salary)
set @id_p=SCOPE_IDENTITY()
end

-- execute procedure
declare @id int
exec sp_add_new
@name='amr',
@salary=456,
@id_p=@id output

--get all people
create procedure sp_get_all
as begin
select *from People
end

exec sp_get_all

-- get by id
create procedure sp_get_by_id
@id1 int
as begin
select * from People
where PersonID=@id1
end


exec sp_get_by_id
@id1=2

create procedure sp_update
@name nvarchar(100),
@salary int,
@id int 
as 
begin
update People
set name=@name , salary=@salary where PersonID=@id
end

exec sp_update
@id=2,
@name='Ali3',
@salary=4443

create procedure sp_delte
@id int
as begin
delete from People where PersonID=@id
end

exec sp_delte
@id=2

create procedure sp_return
@id int 
as begin
if exists (select * from People where PersonID=@id)
return 1
else 
return 0
end

declare @res int
exec @res= sp_return
@id=1
if(@res=1)
print('ok')
else
print('not ok')

--*****************
select * from Students

select Name,Subject ,Grade,
ROW_NUMBER() over(order by Grade desc) as row_num
from Students order by Grade desc

select Name,Subject ,Grade,
dense_rank() over(order by Grade desc) as row_num
from Students order by Grade desc

select Name,Subject ,Grade,
rank() over(partition by Subject order by Grade) as row_num
from Students 


create function dbo.get_avg(@subject nvarchar(100))
returns int

as begin
declare @average int 
select @average=avg(Grade) from Students 
where Subject =@subject
return @average
end;

select name, dbo.get_avg(subject) as avg_sub from Teachers

--inline function (returns table , uses only one select statment)
create function dbo.get_student_bysubject(@subject nvarchar(50))
returns table 
as return
(
select * from Students 
where Subject =@subject
)

select *from dbo.get_student_bysubject('math')

-- multi statment table
create function dbo.get_high1()
returns @result table(
id int ,
name nvarchar(50),
subject nvarchar(50),
grade int )
as begin
insert into @result( id,name, subject,grade )
select top 3  StudentID,name, Subject,Grade from Students
order by grade desc
return 
end;

select * from dbo.get_high1()

--create table of log
create table insert_student_log(
logid int identity primary key,
studentid int ,
name nvarchar(50),
subject nvarchar(50),
grade int ,
insert_date DATETIME DEFAULT GETDATE()
)

--create trigger of insert
create trigger trg_insert_2 on Students 
after insert 
as begin
insert into insert_student_log (studentid,name,subject,grade)
select StudentID,Name,Subject,Grade from inserted
end;

insert into Students(Name,Subject,Grade)
values('amr1','math',44)

select * from insert_student_log

--trigger for update 
create table update_log(
updateID int identity primary key ,
id int,
oldgrade int,
newgrade int,
update_date  DATETIME DEFAULT GETDATE()
)

create trigger trg_update on Students
after update 
as begin 
if update (Grade)
begin
insert into update_log(id,oldgrade,newgrade)
select i.StudentID, d.Grade as oldgrade, i.Grade as newgrade  
from inserted i
inner join deleted d on i.StudentID=d.StudentID
end
end

update Students
set Grade=89 where StudentID=1

select *from update_log

--create delete log
create table delete_log
(
logid int identity primary key ,
id int,
name nvarchar(50),
subject nvarchar(50),
grade int,
log_date DATETIME DEFAULT GETDATE()
)

create trigger trg_delete on Students
after delete
as begin
insert into delete_log(id,name,subject,grade)
select StudentID,Name,Subject,Grade 
from deleted
end

delete from Students where StudentID=14

select *from delete_log

-------------------------------------
-- instead of

alter table Students
add is_active bit not null default 1 


create trigger trg_instead_delete on Students
instead of delete 
as begin
update Students
set is_active =0
from Students inner join deleted
on Students.StudentID=deleted.StudentID
end

delete Students
where StudentID=9

select *from Students

---------------
create table PersonalInfo
(
StudentID int primary key,
name nvarchar(50),
Address nvarchar(255)
)

create table AcadmicInfo
(
StudentID int primary key,
Course nvarchar(50),
Grade int,
foreign key(StudentID) references PersonalInfo(StudentID)
)

insert into PersonalInfo (StudentID,name,Address) values
(1,'Ali','tokh'),
(2,'Amr','benha');

insert into AcadmicInfo(StudentID,Course,Grade) values
(1,'math',88),
(2,'science',98)

create view StudentView as
select p.StudentID as StudentID, p.name as Name,p.Address as Address, a.Course as Course ,a.Grade as Grade
from PersonalInfo p join
AcadmicInfo a on p.StudentID=a.StudentID

-- we can't update view table , so we create trigger to update veiw table and other tables which made view
create trigger trg_update_view on StudentView
instead of Update
as begin 

update PersonalInfo 
set name= i.name, Address = i.Address
from PersonalInfo 
inner join inserted i on i.StudentID=PersonalInfo.StudentID

update AcadmicInfo 
set Course =i.Course , Grade =i.Grade 
from AcadmicInfo  inner join 
inserted i on i.StudentID=AcadmicInfo.StudentID

end

update StudentView 
set name='alaa',Course ='mimi',grade=77
where StudentID=1

select * from StudentView
--------------------------------
create trigger trg_InsertView on StudentView
instead of insert
as begin 

insert into PersonalInfo(StudentID,name,Address)
select StudentID,Name,Address from inserted

insert into AcadmicInfo(StudentID,Course,grade)
select StudentID,Course,grade from inserted
end

insert into StudentView (StudentID,Name,Address,Course,Grade)
values(3,'bebo','tanta','CS',88) 

select * from StudentView

----
select * from Employees2

--CTE

with CTE_employees2 as
(
select *from Employees2 where Department='HR'
)select * from CTE_employees2

with numbers as
(
select 1 as number union all
select 1+number from numbers where number <10
)select * from numbers