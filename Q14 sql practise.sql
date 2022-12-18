use practice;
create table users_1
(
user_id integer,
name varchar(20),
join_date date
);
insert into users_1
values (1, 'Jon', STR_TO_DATE('2-14-20' ,'%m-%d-%y')), 
(2, 'Jane', STR_TO_DATE('2-14-20' ,'%m-%d-%y')), 
(3, 'Jill', STR_TO_DATE('2-15-20' ,'%m-%d-%y')), 
(4, 'Josh', STR_TO_DATE('2-15-20' ,'%m-%d-%y')), 
(5, 'Jean', STR_TO_DATE('2-16-20' ,'%m-%d-%y')), 
(6, 'Justin', STR_TO_DATE('2-17-20' ,'%m-%d-%y')),
(7, 'Jeremy', STR_TO_DATE('2-18-20' ,'%m-%d-%y'));

select * from users_1;

create table events_1
(
user_id integer,
type varchar(10),
access_date date
);

insert into events_1 values
(1, 'Pay', STR_TO_DATE('3-1-20' ,'%m-%d-%y')), 
(2, 'Music', STR_TO_DATE('3-2-20' ,'%m-%d-%y')), 
(2, 'P', STR_TO_DATE('3-12-20' ,'%m-%d-%y')),
(3, 'Music', STR_TO_DATE('3-15-20' ,'%m-%d-%y')), 
(4, 'Music', STR_TO_DATE('3-15-20' ,'%m-%d-%y')), 
(1, 'P', STR_TO_DATE('3-16-20' ,'%m-%d-%y')), 
(3, 'P', STR_TO_DATE('3-22-20' ,'%m-%d-%y'));

select * from events_1;

with cte_1 as(select count(distinct c.user_id) as c1
from events_1 d join
(select b.user_id,a.join_date
from users_1 a right join events_1 b
on a.user_id=b.user_id
where b.type='Music') c on c.user_id=d.user_id
where d.type='P' and datediff(d.access_date,c.join_date)<30), 
cte_2 as (
select count(distinct c.user_id) as c2
from events_1 d join
(select b.user_id,a.join_date
from users_1 a right join events_1 b
on a.user_id=b.user_id
where b.type='Music') c on c.user_id=d.user_id
) select round((b.c1/a.c2)*100,2) as premium_convert_perc from cte_2 a, cte_1 b;


