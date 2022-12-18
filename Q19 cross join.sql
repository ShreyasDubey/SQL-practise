use practice;

CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
delete from activity;
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

select * from activity;
-- , in from statement gives cross join

with cte_1 as(
select case when country = 'India' then 'India'
when country = 'USA' then 'USA'
else 'Others' end as country_1,count(distinct user_id) count_req
from activity
where event_name='app-purchase'
group by country_1), cte_2 as (
select sum(count_req) as total from cte_1)
select * from cte_1,cte_2;


select * from activity;

select coalesce(a.cust_count,0)as count_bought_next_day,b.event_date from
(select b.event_date, count(a.user_id ) as cust_count
from activity a join activity b
on a.user_id=b.user_id and b.event_date-interval 1 day=a.event_date and b.event_name='app-purchase'
group by 1) a  right join (select distinct event_date from activity) b on a.event_date=b.event_date;

select *, lag(event_name,1,'no_event') over (partition by user_id order by event_date),lag(event_date,1,'no_event') over (partition by user_id order by event_date)
from activity;
