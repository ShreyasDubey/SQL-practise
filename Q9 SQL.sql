use practice;

create table spending
(
user_id int,
spend_date date,
platform varchar(255),
amount int
);

insert into spending values (1,'2019-07-01','mobile',100),
(1,'2019-07-01','desktop',100),
(2,'2019-07-01','mobile',100),
(2,'2019-07-02','mobile',100),
(3,'2019-07-01','desktop',100),
(3,'2019-07-02','desktop',100);

select * from spending;

-- drop table spending;

with cte_1 as (
select spend_date,platform,count(user_id) as no_of_customer, sum(amount) as total_amount
from spending
group by spend_date, platform
), cte_2 as (select user_id,spend_date,group_concat(platform) as platform_used,'both' as plat,sum(amount) as amount_sum
from spending
group by user_id,spend_date
having group_concat(platform)='mobile,desktop'
), cte_3 as (select distinct(spend_date) as spend_date
from spending), cte_4 as (
select b.spend_date,plat as platform,count(user_id) as no_of_customer,sum(amount_sum) as total_amount
from cte_2 a right join cte_3 b using (spend_date)
group by b.spend_date), cte_5 as (select * from spending where user_id not in (select user_id from cte_2))
(select spend_date,platform,count(user_id) as no_of_customer, sum(amount) as total_amount
from cte_5
group by spend_date, platform) union (select  spend_date, IFNULL(platform,'both') AS platform,no_of_customer,ifnull(total_amount,0) from cte_4) order by spend_date;

-- cumulative sum problem using window fn
select user_id,spend_date,sum(amount) over (order by user_id,spend_date rows unbounded preceding)
from spending
order by user_id,spend_date;

select * from spending;

-- self join cumsum
with cte_1 as
(
select user_id,spend_date,amount,row_number() over (order by user_id,spend_date) as no
from spending)
select a.user_id,a.spend_date,sum(a.amount) cum_sum
from cte_1 a inner join cte_1 b on a.no<=b.no
group by b.no;




