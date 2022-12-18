-- Complex SQL Query 1 | Derive Points table for ICC tournament
/*
create database practice;
*/

use practice;

drop table entries;

create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR');

select * from entries;

with most_visit as(
select name,floor,count(name) as no_of_visits,dense_rank() over(partition by name order by count(name) desc) as rn
from entries 
group by name,floor), total_visit as (select name,count(name) visits from entries group by name),
resources as (SELECT name, GROUP_CONCAT(distinct resources) res
FROM entries
GROUP BY name)
select mv.name,mv.floor as most_visited_floor,tv.visits as total_visits,r.res
from most_visit mv 
inner join total_visit tv on mv.name=tv.name
inner join resources r on tv.name=r.name where rn=1;
/*
with new_res as (
select name, resources from entries group by name,resources)
select name, STRIN(resources,',') as resources_used
from new_res group by name;


select * from total_visits;

select * from entries;

SELECT name, GROUP_CONCAT(distinct resources) res
FROM entries
GROUP BY name;
*/
