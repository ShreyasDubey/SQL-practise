use practice;
drop table products_1;
drop table customer_budget_1;
create table products_1
(
product_id varchar(20) ,
cost int
);
insert into products_1 values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget_1
(
customer_id int,
budget int
);

insert into customer_budget_1 values (100,400),(200,800),(300,1500);

select * from products_1;
select * from customer_budget_1;

with cte_1 as(
select product_id,cost,sum(cost) over(rows between unbounded preceding and current row) as cum_sum
from products_1),cte_2 as (select b.customer_id,b.budget,a.product_id,a.cost,a.cum_sum
 from cte_1 a right join customer_budget_1 b on a.cum_sum < b.budget)
 select customer_id,group_concat(product_id) as products
 from cte_2
 group by customer_id;