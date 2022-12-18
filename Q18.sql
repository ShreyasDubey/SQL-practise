use practice;

create table billings_1 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);
delete from billings_1;
insert into billings_1 values
('Sachin',str_to_date('01-JAN-1990','%d-%M-%Y'),25)
,('Sehwag' ,str_to_date('01-JAN-1989','%d-%M-%Y'), 15)
,('Dhoni' ,str_to_date('01-JAN-1989','%d-%M-%Y'), 20)
,('Sachin' ,str_to_date('05-Feb-1991','%d-%M-%Y'), 30)
;

create table HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);
insert into HoursWorked values
('Sachin' ,str_to_date('01-JUL-1990','%d-%M-%Y'),3)
,('Sachin',str_to_date('01-AUG-1990','%d-%M-%Y'), 5)
,('Sehwag',str_to_date('01-JUL-1990','%d-%M-%Y'), 2)
,('Sachin',str_to_date('01-JUL-1991','%d-%M-%Y'), 4);
select * from billings_1;
select * from HoursWorked;

with cte_1 as(
select emp_name,bill_date,bill_rate,ifnull(lead(bill_date) over (partition by emp_name order by bill_date), '9999-01-01') as bill_date_end
from billings_1)
select a.emp_name,sum(a.bill_rate*b.bill_hrs) as total_amount 
from cte_1 a join hoursworked b on a.emp_name=b.emp_name and b.work_date between a.bill_date and a.bill_date_end
group by a.emp_name;
