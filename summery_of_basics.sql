-- ============================================================================
-- FUNCTIONAL BLOCK 1: DATABASE ADMINISTRATION (RESTORE OPERATIONS)
-- ============================================================================

-- Function: System Backup Restoration
-- Description: Overwrites or instantiates physical schemas from external disk archives (.bak).
--RESTORE DATABASE shop_database
--FROM DISK = 'C:\shop_db.bak';

RESTORE DATABASE ContactsDB
FROM DISK = 'C:\ContactsDB.bak'

--RESTORE DATABASE EmployeesDB
--FROM DISK = 'C:\EmployeesDB.bak'


-- ============================================================================
-- FUNCTIONAL BLOCK 2: BASIC DATA SCANNING & DISCOVERY (SELECT ALL)
-- ============================================================================

-- Function: Full Table Probing
-- Description: Pulls all recorded data vectors across structural base attributes.
select *from Countries;
select *from Departments;
select *from Employees;
select *from Customers;
select *from Orders;
select *from MakeModels;
select *from VehicleDetails;
select *from mastervehicle;


-- ============================================================================
-- FUNCTIONAL BLOCK 3: COLUMN FORMULAS & STRING CONCATENATIONS
-- ============================================================================

-- Function: Inline Scalar Math & String Building
-- Description: Builds custom column headings while concatenating separate text strings and scaling numeric variables.
select ID, fullname=FirstName+' '+LastName, yearsalary=MonthlySalary*12
from Employees;


-- ============================================================================
-- FUNCTIONAL BLOCK 4: ROW LIMITATION & SAMPLING STRATEGIES
-- ============================================================================

-- Function: Percentage Selection Filters (TOP PERCENT)
-- Description: Isolates a dynamic percentage size out of the overall table payload.
select top 10 percent* from Employees;


-- Function: Top-N Value Boundary Restrictions (TOP + ORDER BY)
-- Description: Restricts row output pipelines while combining sorted criteria.
select top 10* from	Employees
order by MonthlySalary asc;

select top 10* from Employees
where MonthlySalary >200 and MonthlySalary<9000;

select top 10* from Employees --the same as ^
where MonthlySalary between 200 and 9000;


-- ============================================================================
-- FUNCTIONAL BLOCK 5: RANDOMIZED ROW EVALUATIONS
-- ============================================================================

-- Function: Dynamic Pseudo-Random Record Generation
-- Description: Sorts records via unique system-generated GUID keys to scramble results on every run.
select FuelTypes.FuelTypeName from FuelTypes
order by newid()


-- ============================================================================
-- FUNCTIONAL BLOCK 6: DATA SELECTION DE-DUPLICATION (DISTINCT)
-- ============================================================================

-- Function: Distinct Unique Array Compilations
-- Description: Clears duplicate data entries out of a targeted dataset row block.
select distinct DepartmentID from Employees;


-- ============================================================================
-- FUNCTIONAL BLOCK 7: VALUE RECORD FILTRATION (WHERE CONDITIONALS)
-- ============================================================================

-- Function: Composite Multi-Variable Overlaps (AND Filters)
-- Description: Eliminates row items unless they pass every specified condition.
select *from Employees
where MonthlySalary <500 and Gendor='M';

select * from VehicleDetails
where Engine_Liter_Display>3 and NumDoors=2


-- Function: Array Membership Qualification (IN Lists)
-- Description: Matches fields against short static lists (functions identically to a shorthand OR evaluation).
select *from Employees
where BonusPerc in( 0) and Gendor='M'; --in is same os OR


-- Function: Inclusive Range Boundary Matching (BETWEEN Operations)
-- Description: Targets fields whose numeric or chronological markers sit within low and high caps.
select  year from mastervehicle
where Year between 1950 and 2000

select count(year) from mastervehicle 
where Year between 1950 and 2000


-- Function: Null Value Identification (IS NULL Audits)
-- Description: Finds fields completely missing an assigned item.
select *from VehicleDetails
where NumDoors is NULL


-- ============================================================================
-- FUNCTIONAL BLOCK 8: ADVANCED ALPHANUMERIC STRUCTURAL SEARCH (LIKE WILD CARDS)
-- ============================================================================

-- Function: Wildcard Character Array Searching
-- Description: Employs specific string matching wildcards (%, _, []) to find pattern fragments.
-- Syntax Cheat Sheet:
-- 'a%'           -> Matches elements starting with the letter "a"
-- '%a'           -> Matches elements ending with the letter "a"
-- '%tell%'       -> Matches elements containing the word "tell" at any position
-- 'a%a'          -> Matches elements starting with "a" and ending with "a"
-- '_a%'          -> Matches elements where "a" sits exactly in the second slot
-- '__a%'         -> Matches elements where "a" sits exactly in the third slot
-- 'a__%'         -> Matches elements starting with "a" that span at least 3 spots long
-- 'a___%'        -> Matches elements starting with "a" that span at least 4 spots long
-- 'a%' OR 'b%'   -> Matches elements starting with either "a" OR "b"
-- 'Mohamm[ae]d'  -> Regex brackets: Matches "Mohammed" or "Mohammad"
-- '[abc]%'       -> Matches elements starting with either 'a', 'b', or 'c'
-- '[a-l]%'       -> Matches elements starting with characters spanning from 'a' to 'l'
--select ID, FirstName from Employees 
--where FirstName like 'a%';
--where FirstName like '%a';
--where FirstName like '%tell%'; 
--where FirstName like 'a%a'; 
--where FirstName like '_a%'; 
--where FirstName like '__a%'; 
--where FirstName like 'a__%'; 
--where FirstName like 'a___%'; 
--where FirstName like 'a%' or FirstName like 'b%' ; 
--Where firstName like 'Mohamm[ae]d'; 
--Where firstName like '[abc]%'; 
--Where firstName like '[a-l]%'; 

select Make from Makes 
where Make like 'B%'

select Make from Makes 
where Make like '%W'


-- ============================================================================
-- FUNCTIONAL BLOCK 9: SINGLE & MULTI-KEY ROW RE-ORDERING (SORTING)
-- ============================================================================

-- Function: Uni-Directional Scale Sorting
-- Description: Alphabetizes record returns sequentially based on a single target property.
select name from Departments
order by name ASC;


-- Function: Layered Priority Ordering Matrices
-- Description: Controls output structures across multiple target columns, balancing low-to-high and high-to-low fields.
select distinct( Make),numberOfVehicles=count(Make) from mastervehicle
where Year between 1950 and 2000
group by Make 
order by numberOfVehicles desc

select Make,NumberOfVehicles=count(Make),(select total=count(*) from mastervehicle) from mastervehicle
where year between 1950 and 2000
group by Make
order by NumberOfVehicles desc


-- ============================================================================
-- FUNCTIONAL BLOCK 10: METRIC AGGREGATIONS & CONDITIONAL HAVING GROUPS
-- ============================================================================

-- Function: Full Statistical Rollups (GROUP BY)
-- Description: Groups row records to return collective volume, financial summation, averages, and limits.
select DepartmentID, totalcount=count(monthlysalary),
totalsum=sum(monthlysalary),
totalavg=avg(monthlysalary),
maxsalary=max(monthlysalary),
minsalary=min(monthlysalary)
from Employees
group by DepartmentID;

select Make,FuelTypeName,number=count(FuelTypeName) from mastervehicle --first solution
group by FuelTypeName,Make


-- Function: Post-Aggregation Conditional Filters (HAVING Clauses)
-- Description: Evaluates group calculations to drop summary sections.
-- Reference Rule: WHERE filters individual rows; HAVING filters aggregated groups.
select DepartmentID, totalcount=count(monthlysalary),
totalsum=sum(monthlysalary),
totalavg=avg(monthlysalary),
maxsalary=max(monthlysalary),
minsalary=min(monthlysalary)
from Employees
group by DepartmentID
having count(monthlysalary)>100; --having is same as where

select  Make,numberOfVehicles=count(Make) from mastervehicle
where Year between 1950 and 2000
group by Make 
having count(Make)>12000   --having is on results , but where is on each row
order by numberOfVehicles desc


-- Function: Standalone Aggregate Baselines
-- Description: Extracts global minimum, maximum, and average indicators without requiring structural grouping.
select min(Engine_CC) as minimum , max(Engine_CC) as maximum, avg(Engine_CC) as average from VehicleDetails


-- ============================================================================
-- FUNCTIONAL BLOCK 11: RELATIONAL CROSS-TABLE LINKS (INNER & LEFT JOINS)
-- ============================================================================

-- Function: Standard Foreign Key Intersection (INNER JOIN)
-- Description: Combines related records between tables, hiding entries that don't find a partner.
select Customers.CustomerID, Customers.Name, Orders.Amount
from Customers inner join Orders 
on Customers.CustomerID=Orders.CustomerID;

select Makes.Make ,FuelTypes.FuelTypeName ,count(*)as count from VehicleDetails
inner join 
Makes on Makes.MakeID=VehicleDetails.MakeID  -- (on) means base on next condition
inner join 
FuelTypes on FuelTypes.FuelTypeID=VehicleDetails.FuelTypeID
group by Makes.Make,FuelTypes.FuelTypeName


-- Function: Multi-Table Deep Structural Joining
-- Description: Chains consecutive INNER JOIN paths together to combine normalized entities across an entire schema tree.
SELECT     VehicleDetails.ID, VehicleDetails.MakeID, Makes.Make, VehicleDetails.ModelID, MakeModels.ModelName, VehicleDetails.SubModelID, SubModels.SubModelName, VehicleDetails.BodyID, Bodies.BodyName, VehicleDetails.Vehicle_Display_Name, VehicleDetails.Year, 
                  VehicleDetails.DriveTypeID, VehicleDetails.Engine, VehicleDetails.Engine_CC, VehicleDetails.Engine_Cylinders, VehicleDetails.Engine_Liter_Display, VehicleDetails.FuelTypeID, FuelTypes.FuelTypeName, VehicleDetails.NumDoors
FROM        FuelTypes INNER JOIN
                  Bodies INNER JOIN
                  Makes INNER JOIN
                  MakeModels ON Makes.MakeID = MakeModels.MakeID INNER JOIN
                  SubModels ON MakeModels.ModelID = SubModels.ModelID INNER JOIN
                  VehicleDetails ON Makes.MakeID = VehicleDetails.MakeID AND MakeModels.ModelID = VehicleDetails.ModelID AND SubModels.SubModelID = VehicleDetails.SubModelID ON Bodies.BodyID = VehicleDetails.BodyID INNER JOIN
                  DriveTypes ON VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID ON FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID


-- ============================================================================
-- FUNCTIONAL BLOCK 12: SUBQUERIES (CORRELATED, INLINE & SCALAR NESTING)
-- ============================================================================

-- Function: Correlated Subquery Existential Filters (WHERE EXISTS)
-- Description: Tests cross-table conditions, returning matching rows as soon as it confirms a true evaluation.
select *from Customers
where exists
(
select top 1 r='x' from Orders
where  CustomerID=Customers.CustomerID and Amount<600
)


-- Function: Aggregate Workarounds via Inline Derived Tables
-- Description: Packages aggregations inside a subquery view block, skipping the need for a HAVING clause.
select *from (
select distinct( Make),numberOfVehicles=count(Make) from mastervehicle
group by Make 
)R1
where numberOfVehicles>12000


-- Function: Uncorrelated Cross-Join Scalar Indicators
-- Description: Integrates global total calculations as standalone, row-by-row reference pillars.
select Make,NumberOfVehicles=count(Make),(select total=count(*) from mastervehicle) from mastervehicle
where year between 1950 and 2000
group by Make
order by NumberOfVehicles desc


-- Function: Dynamic Criteria Feeds via Global Scalar Subqueries
-- Description: Feeds dynamically calculated mathematical results back into raw row filter blocks.
select *from VehicleDetails
where Engine_CC= (select min(Engine_CC) from VehicleDetails)

select * from VehicleDetails
where Engine_CC <(select avg(Engine_CC) from VehicleDetails)


-- Function: Multi-Value Array Generators (Nested List IN Subqueries)
-- Description: Generates a temporary list on the fly to drive external row selection filters.
select *from VehicleDetails
where Engine_CC in (select distinct top 3 Engine_CC from VehicleDetails
order by Engine_CC desc)


-- Function: Multi-Tiered Matrix Aggregations
-- Description: Nests aggregations within outer subquery envelopes to extract top-level mathematical values.
select max(numberofmodels)as maxnumofmodels from(
select Makes.Make,count(*) as numberofmodels from MakeModels
inner join Makes on Makes.MakeID=MakeModels.MakeID
group by Makes.Make
)R5

select Makes.Make,count(*) as numberofmodels from MakeModels
inner join Makes on Makes.MakeID=MakeModels.MakeID
group by Makes.Make
having count(*)=(select max(numberofmodels)as maxnumofmodels from(
select Makes.Make,count(*) as numberofmodels from MakeModels
inner join Makes on Makes.MakeID=MakeModels.MakeID
group by Makes.Make
)R5)


-- ============================================================================
-- FUNCTIONAL BLOCK 13: DATA TYPE CASTING & FLOATING RATIOS
-- ============================================================================

-- Function: Floor Truncation Defenses (Decimal Conversions)
-- Description: Casts working integer fields into floating-point structures to avoid zero-rounding division errors.
select *,(cast(NumberOfVehicles as float)/cast(totalcount as float))as percentage from 
(select Make,NumberOfVehicles=count(Make),(select count(*) from mastervehicle )as totalcount
from mastervehicle
where year between 1950 and 2000
group by Make
)R2
order by NumberOfVehicles desc

select (
cast((select count(*) as numberofdoors from VehicleDetails where NumDoors is NULL) as float)
/
cast ((select count(*) as totalnum from VehicleDetails) as float) )
from VehicleDetails


-- ============================================================================
-- FUNCTIONAL BLOCK 14: INTERSECTION SET COMBINATIONS (UNION OPERATORS)
-- ============================================================================

-- Function: Distinct Row Set Harmonization
-- Description: Combines multi-query result fields, filtering out identical row matches to clean the output.
select *from Customers
union 
select *from Customers


-- ============================================================================
-- FUNCTIONAL BLOCK 15: INLINE CONDITIONAL WORKFLOWS (CASE STATEMENTS)
-- ============================================================================

-- Function: Enumerated Value Translation Engine
-- Description: Evaluates field variants on the fly to substitute abbreviations with clean text labels.
select 
ID,
Gendor=
case
when Gendor='M' then 'male'
when Gendor='F' then 'Female'
end
,
status=
case
when ExitDate is null then 'active'
when ExitDate is not null then 'resigned'
end
from Employees


-- Function: Null Value Error-Handling Interceptions
-- Description: Protects presentation displays by overwriting unassigned data fields with fallback text strings.
select Vehicle_Display_Name,NumDoors,
case 
when NumDoors=0 then 'zero doors'
when NumDoors=1 then 'one door'
when NumDoors=2 then 'two doors'
when NumDoors=4 then 'four doors'
when NumDoors is null then 'not defined'
end as doordesription
from VehicleDetails


-- ============================================================================
-- FUNCTIONAL BLOCK 16: SYSTEM CLOCK METRICS (DATE MATH)
-- ============================================================================

-- Function: Live Chronological Age Tracking
-- Description: Queries live system clocks to compute real-time product or personnel life spans.
select Vehicle_Display_Name,Year,age=YEAR(GETDATE())-Year from VehicleDetails
order by age desc

select Vehicle_Display_Name,Year,age=(YEAR(GETDATE())-year) from VehicleDetails
where (YEAR(GETDATE())-year) between 15 and 25
order by age desc


-- ============================================================================
-- FUNCTIONAL BLOCK 17: SYSTEM FLAG EXISTENTIAL CHECK VALUATIONS
-- ============================================================================

-- Function: Standalone Boolean Status Output
-- Description: Spits out a constant indicator row ('found = 1') if a nested validation test clears.
select found =1 
where exists(
select top 1* from VehicleDetails where year =1950)


-- ============================================================================
-- FUNCTIONAL BLOCK 18: RECURSIVE PARENT-CHILD STRUCTURES (SELF-JOINS)
-- ============================================================================

-- Function: Hierarchical Corporate Tree Auditing (Inner Self-Joins)
-- Description: Intersects a single table against itself using matching keys to map staff directly to supervisors.
select distinct Employees.Name,Employees.Salary,Employees.ManagerID,managers.Name as managername from Employees
inner join Employees as managers on Employees.ManagerID=managers.EmployeeID 


-- Function: Permissive Hierarchical Reporting Auditing (Left Self-Joins)
-- Description: Maps staff to supervisors while preserving independent top-level entries by generating NULL manager values.
select Employees.Name,Employees.Salary,Employees.ManagerID,managers.Name as managername from Employees
left join Employees as managers on Employees.ManagerID=managers.EmployeeID 


-- Function: Recursive Structural Fallback Loops
-- Description: Evaluates hierarchical entries, automatically rerouting independent elements to act as their own manager.
select Employees.Name, Employees.ManagerID, Employees.Salary,
case 
when Employees.ManagerID is null then Employees.Name
else managers.Name
end as managername
from Employees
left join Employees as managers on Employees.ManagerID=managers.EmployeeID


-- ============================================================================
-- FUNCTIONAL BLOCK 19: ARCHITECTURAL DATA VIEWS
-- ============================================================================

-- Function: Virtual Data Frame Abstraction Layers
-- Description: Saves complex query statements directly inside system metadata for clean, ongoing usage.
CREATE VIEW ShortDetailsOfEmployees AS
select ID,FirstName,LastName
from Employees;

select *from ShortDetailsOfEmployees


-- ============================================================================
-- FUNCTIONAL BLOCK 20: PERFORMANCE TUNING (INDEX CREATION & DROPS)
-- ============================================================================

-- Function: Non-Clustered Search Optimization Maps
-- Description: Pins highly-searched columns onto structural B-Tree maps to accelerate lookup execution speeds.
create index idx_name
on Employees(FirstName);


-- Function: Structural Index Drop Tasks
-- Description: Cleans up obsolete lookup indices to optimize background database writes and bulk loads.
drop index Employees.idx_name;