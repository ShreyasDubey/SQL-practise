use practice;
create table covid(city varchar(50),days date,cases int);
truncate table covid;
insert into covid values('DELHI','2022-01-01',100);
insert into covid values('DELHI','2022-01-02',200);
insert into covid values('DELHI','2022-01-03',300);

insert into covid values('MUMBAI','2022-01-01',100);
insert into covid values('MUMBAI','2022-01-02',100);
insert into covid values('MUMBAI','2022-01-03',300);

insert into covid values('CHENNAI','2022-01-01',100);
insert into covid values('CHENNAI','2022-01-02',200);
insert into covid values('CHENNAI','2022-01-03',150);

insert into covid values('BANGALORE','2022-01-01',100);
insert into covid values('BANGALORE','2022-01-02',300);
insert into covid values('BANGALORE','2022-01-03',200);
insert into covid values('BANGALORE','2022-01-04',400);

select * from covid;

with cte_1 as(
select city,days,rank() over (partition by city order by days) as days_rank,rank() over (partition by city order by cases) as case_rank
from covid
order by city,days), cte_2 as( select city,days,cast(days_rank as signed) - cast(case_rank as signed) as rank_group
from cte_1)
select city
from cte_2
group by city
having count(distinct rank_group)=1;

-- show errors;

-- getting cases with increasing cases or same
with cte_1 as(
select city,days,rank() over (partition by city order by days) as days_rank,rank() over (partition by city order by cases) as case_rank
from covid
order by city,days), cte_2 as( select city,days,cast(days_rank as signed) - cast(case_rank as signed) as rank_group
from cte_1)
select city,rank_group
from cte_2
group by city
having min(rank_group) >= 0;
