use practice;
create table stadium (
id int,
visit_date date,
no_of_people int
);

insert into stadium
values (1,'2017-07-01',10)
,(2,'2017-07-02',109)
,(3,'2017-07-03',150)
,(4,'2017-07-04',99)
,(5,'2017-07-05',145)
,(6,'2017-07-06',1455)
,(7,'2017-07-07',199)
,(8,'2017-07-08',188);

select * from stadium;

with cte_1 as(
select *, row_number() over (order by visit_date) as rn, id-row_number() over (order by visit_date) as gr_st
from stadium
where no_of_people>100) 
select id from cte_1 
where gr_st in (select gr_st from cte_1
group by gr_st
having count(1) >=3);
