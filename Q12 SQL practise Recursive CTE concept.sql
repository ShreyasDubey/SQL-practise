use practice;

create table sales (
product_id int,
period_start date,
period_end date,
average_daily_sales int
);

insert into sales values(1,'2019-01-25','2019-02-28',100),(2,'2018-12-01','2020-01-01',10),(3,'2019-12-01','2020-01-31',1);

select * from sales;

select date_format(period_start,'%Y') as start_year,
date_format(period_end,'%Y') as end_year,concat(date_format(period_start,'%Y'),'-12-31') last_date,
 datediff(period_end,period_start) as no_of_days 
 from sales;

-- recurcive cte concept 
 with recursive cte_1 as(
 (select 1 as num)
 union all
 (select num+1
 from cte_1
 where num < 6)
 )select num from cte_1;
 
 -- problem soln
 -- ctrl + / to do multiple comments
 
 with recursive cte_2 as (
 select min(period_start) as start_date,max(period_end) as end_date
 from sales
 union all
 select start_date + interval 1 day,end_date
 from cte_2
 where start_date<end_date), cte_3 as(
 select * from cte_2 a join sales b on a.start_date between b.period_start and b.period_end 
 order by product_id,period_start)select product_id,date_format(start_date,'%Y') as 'year',sum(average_daily_sales) total_sales
 from cte_3
 group by 1,2
 order by 1,2;
 
 
 )
 
 select * from sales;
 
 
