use practice;


create table transactions(
order_id int,
cust_id int,
order_date date,
amount int
);
delete from transactions;
insert into transactions values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150)
;
select * from transactions;

select b.month_of_retain, ifnull(a.count_cust,0) as cust_retain_count
 from 
(select count(a.cust_id) as count_cust, month(b.order_date) month_of_retain
from transactions a join transactions b
on a.cust_id=b.cust_id  and a.order_id < b.order_id and TIMESTAMPDIFF(MONTH, b.order_date, a.order_date)<=1
group by 2) a right join (select distinct(month(order_date)) as  month_of_retain from transactions) b
on a.month_of_retain=b.month_of_retain;


select distinct(month(order_date)) from transactions;



SELECT TIMESTAMPDIFF(MONTH, '2012-05-05', '2012-06-04')