
create table business_city (
business_date date,
city_id int
);
delete from business_city;
insert into business_city
values(cast('2020-01-02' as date),3),(cast('2020-07-01' as date),7),(cast('2021-01-01' as date),3),(cast('2021-02-03' as date),19)
,(cast('2022-12-01' as date),3),(cast('2022-12-15' as date),3),(cast('2022-02-28' as date),12);


with cte_1 as(
select city_id,date_format(business_date,'%Y') as yr from business_city),cte_2 as(
select distinct a.yr,a.city_id
from cte_1 a join cte_1 b on a.yr>b.yr and a.city_id=b.city_id)select a.yr,count(a.city_id) new_city_count
 from cte_1 a left join cte_2 b on a.yr=b.yr and a.city_id=b.city_id
 where b.yr is null
 group by yr;