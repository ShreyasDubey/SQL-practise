use practice;
create table orders
(
order_id int,
customer_id int,
product_id int
);
insert into orders VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table products (
id int,
name varchar(10)
);

insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

select * from orders;
select * from products;

with cte_1 as (
select order_id,customer_id,product_id,name
from orders a join products b on a.product_id=b.id
)select concat(c.name," ",d.name) as pair, count(*) as count_pair from
cte_1 c inner join cte_1 d
on c.order_id=d.order_id and c.product_id < d.product_id
group by 1
order by 2 desc;
