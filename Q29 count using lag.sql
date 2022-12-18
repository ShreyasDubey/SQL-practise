use practice;

create table event_status
(
event_time varchar(10),
status varchar(10)
);
insert into event_status 
values
('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
,('10:11','on'),('10:12','off');

select * from event_status;

with cte_1 as(
select event_time,status,lag(status,1,status) over (order by event_time) as prev_status
from event_status) , cte_2 as (select *, sum(case when status='on' and prev_status='off' then 1 else 0 end) over (order by event_time) as group_st
from cte_1) select min(event_time) as start_time, max(event_time) as end_time,count(status)-1 as count_min
from cte_2
group by group_st;

