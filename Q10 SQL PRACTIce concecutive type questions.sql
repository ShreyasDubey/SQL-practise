use practice;

create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success');

select * from tasks;
-- catch cumulative sucess and fail
with cte_1 as (
select date_value,state,row_number() over (partition by state order by date_value) as rn,
 date_value - interval (row_number() over (partition by state order by date_value)) day as group_date
from tasks)
select state, min(date_value) as start_date, max(date_value) as end_date
from cte_1
group by group_date
order by start_date;