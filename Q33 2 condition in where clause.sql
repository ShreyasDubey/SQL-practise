CREATE TABLE emp(
 emp_id int NULL,
 emp_name varchar(50) NULL,
 salary int NULL,
 manager_id int NULL,
 emp_age int NULL,
 dep_id int NULL,
 dep_name varchar(20) NULL,
 gender varchar(10) NULL
) ;
insert into emp values(1,'Ankit',14300,4,39,100,'Analytics','Female');
insert into emp values(2,'Mohit',14000,5,48,200,'IT','Male');
insert into emp values(3,'Vikas',12100,4,37,100,'Analytics','Female');
insert into emp values(4,'Rohit',7260,2,16,100,'Analytics','Female');
insert into emp values(5,'Mudit',15000,6,55,200,'IT','Male');
insert into emp values(6,'Agam',15600,2,14,200,'IT','Male');
insert into emp values(7,'Sanjay',12000,2,13,200,'IT','Male');
insert into emp values(8,'Ashish',7200,2,12,200,'IT','Male');
insert into emp values(9,'Mukesh',7000,6,51,300,'HR','Male');
insert into emp values(10,'Rakesh',8000,6,50,300,'HR','Male');
insert into emp values(11,'Akhil',4000,1,31,500,'Ops','Male');

select emp_id,emp_name,salary,dep_name from emp;

-- using union
select emp_id,emp_name,salary,dep_name,rn  from(
select *, dense_rank() over (partition by dep_name order by salary desc) as rn
from emp 
where dep_name in (select dep_name
from emp 
group by dep_name
having count(distinct emp_id)>2)) as a
where rn=3
union all
select emp_id,emp_name,salary,dep_name,rn  from(
select *, dense_rank() over (partition by dep_name order by salary) as rn
from emp 
where dep_name in (select dep_name
from emp 
group by dep_name
having count(distinct emp_id)<=2)) as a
where rn=1;

-- double filter in where clause
with cte_1 as(
select *,dense_rank() over (partition by dep_name order by salary desc) as rn , count(emp_id) over (partition by dep_name) as count_emp
from emp)
select emp_id,emp_name,salary,dep_name
from cte_1
where rn=3 or (count_emp<3 and rn=count_emp);


select emp_id,emp_name,salary,dep_name from emp;
