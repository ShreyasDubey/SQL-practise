use practice;
create table emp_2020
(
emp_id int,
designation varchar(20)
);

create table emp_2021
(
emp_id int,
designation varchar(20)
);

insert into emp_2020 values (1,'Trainee'), (2,'Developer'),(3,'Senior Developer'),(4,'Manager');
insert into emp_2021 values (1,'Developer'), (2,'Developer'),(3,'Manager'),(5,'Trainee');

with cte_1 as(
select a.emp_id,a.designation as pre,b.designation as post from emp_2020 a left join emp_2021 b on a.emp_id=b.emp_id
union
select b.emp_id,a.designation as pre,b.designation as post from emp_2020 a right join emp_2021 b on a.emp_id=b.emp_id)
,cte_2 as (select emp_id, case when pre is null and post is not null then 'new' 
when pre=post then null
when pre is not null and post is not null then 'promotion'
else 'retired' end as st from cte_1) select * from cte_2 where st is not null;