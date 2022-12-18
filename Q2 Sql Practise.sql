-- Complex SQL Query 1 | Derive Points table for ICC tournament
/*
create database practice;
*/

use practice;
create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
select * from customer_orders;
insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;
select * from customer_orders;

with first_visit as (select customer_id, min(order_date) as first_visit
from customer_orders
group by customer_id), final_table as ( 
select a.customer_id,a.order_date,a.order_amount,b.first_visit
from customer_orders a left join first_visit b on a.customer_id=b.customer_id)
select order_date, sum(case when order_date=first_visit then 1 else 0 end) as new_customer_count,
sum(case when order_date!=first_visit then 1 else 0 end) as repeat_customer_count,
sum(case when order_date=first_visit then order_amount else 0 end) as new_customer_order_amount,
sum(case when order_date!=first_visit then order_amount else 0 end) as repeat_customer_order_amount
from final_table
group by order_date;

select * from customer_orders;