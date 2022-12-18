use practice;

create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');

select * from UserActivity;
with cte_1 as (
select username, activity ,dense_rank() over (partition by username order by endDate desc) as rn
from UserActivity) select username,activity from cte_1 where rn=1; 