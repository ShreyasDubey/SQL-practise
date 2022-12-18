use practice;
create table customer_budget_2
(
customer_id int,
budget int
);
truncate table customer_budget_2;
truncate table customer_budget_3;
select * from customer_budget_2;
insert into customer_budget_2 values (1,4),(2,8),(3,15),(1,2);

create table customer_budget_3
(
customer_id int,
budget int
);

insert into customer_budget_3 values (1,4),(3,8),(3,15),(1,2),(4,6);


select a.customer_id, a.budget,b.budget
from customer_budget_2 a left join customer_budget_3 b on a.customer_id=b.customer_id
union 
select b.customer_id, a.budget,b.budget
from customer_budget_2 a right join customer_budget_3 b on a.customer_id=b.customer_id;




select null
union all
select null
union all
select null;
