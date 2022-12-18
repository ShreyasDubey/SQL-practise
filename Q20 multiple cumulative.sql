use practice;
create table bms (seat_no int ,is_empty varchar(10));
insert into bms values
(1,'N')
,(2,'Y')
,(3,'N')
,(4,'Y')
,(5,'Y')
,(6,'Y')
,(7,'N')
,(8,'Y')
,(9,'Y')
,(10,'Y')
,(11,'Y')
,(12,'N')
,(13,'Y')
,(14,'Y');

select * from bms;

-- using row num and window fn
with cte_1 as(
select seat_no,is_empty,row_number() over(partition by is_empty order by seat_no) as row_num
from bms), cte_2 as ( select *,count(seat_no) over (partition by seat_no-row_num,is_empty) as cum_seat_count
from cte_1) select seat_no,is_empty
from cte_2
where cum_seat_count>2;

-- using lead lag fn
with cte_1 as(
select seat_no,is_empty,lead(seat_no) over (order by seat_no) next_seat_no,lead(is_empty) over (order by seat_no) next_empty
,lag(seat_no) over (order by seat_no) prev_seat_no,lag(is_empty) over (order by seat_no) prev_empty
from bms) select seat_no from cte_1 where is_empty='Y' and next_empty='Y' and prev_empty='Y' union 
select next_seat_no from cte_1 where is_empty='Y' and next_empty='Y' and prev_empty='Y' union
select prev_seat_no from cte_1 where is_empty='Y' and next_empty='Y' and prev_empty='Y' order by seat_no;

-- using advance aggregation
with cte_1 as(
select seat_no,sum(case when is_empty='Y' then 1 else 0 end) over (rows between 2 preceding and current row) as fil_1,
sum(case when is_empty='Y' then 1 else 0 end) over (rows between 1 preceding and 1 following) as fil_2,
sum(case when is_empty='Y' then 1 else 0 end) over (rows between current row and 2 following) as fil_3
from bms)
select a.seat_no,b.is_empty from cte_1 a join bms b on a.seat_no=b.seat_no
where fil_1=3 or fil_2=3 or fil_3=3;
