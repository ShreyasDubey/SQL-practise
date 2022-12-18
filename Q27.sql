use practice;
CREATE TABLE students_new_new(
 studentid int ,
 studentname nvarchar(255) ,
 subject nvarchar(255) ,
 marks int ,
 testid int ,
 testdate date 
);


insert into students_new values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
insert into students_new values (3,'Arnold','Subject1',95,1,'2022-01-02');
insert into students_new values (4,'Krish Star','Subject1',61,1,'2022-01-02');
insert into students_new values (5,'John Mike','Subject1',91,1,'2022-01-02');
insert into students_new values (4,'Krish Star','Subject2',71,1,'2022-01-02');
insert into students_new values (3,'Arnold','Subject2',32,1,'2022-01-02');
insert into students_new values (5,'John Mike','Subject2',61,2,'2022-11-02');
insert into students_new values (1,'John Deo','Subject2',60,1,'2022-01-02');
insert into students_new values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
insert into students_new values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
insert into students_new values (5,'John Mike','Subject3',98,2,'2022-11-02');

select * from students_new;

-- question one
select round((count(distinct case when marks>90 then studentid else null end)/count(distinct studentid))*100,2) as perc
from students_new;

-- question two
with cte_1 as(
select *, dense_rank() over(partition by subject order by marks) as opp_rank, dense_rank() over(partition by subject order by marks desc) as forward_rank
from students_new), cte_2 as(
select studentid,studentname,subject,marks
from cte_1
where opp_rank=2), cte_3 as (select studentid,studentname,subject,marks
from cte_1
where forward_rank=2)select a.subject,a.marks as second_lowest,b.marks as second_highest from cte_2 a inner join cte_3 b on a.subject=b.subject;


-- lead lag question
select * from students_new;

with cte_1 as(
select *, lag(marks) over(partition by studentid order by subject) as prev_marks
from students_new), cte_2 as(select studentid,studentname,subject,marks,prev_marks,case when marks>prev_marks then 'increase'
when marks<prev_marks then 'decrease' when prev_marks is null then 'no prev value' end as st
from cte_1) select * from cte_2 where st != 'no prev value';




