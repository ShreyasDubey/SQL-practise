use practice;

create table players_location
(
name varchar(20),
city varchar(20)
);
delete from players_location;
insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');

select * from players_location;

-- making pivot for categorical columns
with cte_1 as(
select *,row_number() over (partition by city order by name) gr_st
from players_location order by gr_st) select max(case when city = 'Bangalore' then name end) as Bangalore,
max(case when city = 'Delhi' then name end) as Delhi, max(case when city = 'Mumbai' then name end) as Mumbai from cte_1 
group by gr_st;
