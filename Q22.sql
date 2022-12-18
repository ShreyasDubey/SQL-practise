use practice;
create table exams (student_id int, subject varchar(20), marks int);
delete from exams;
insert into exams values (1,'Chemistry',91),(1,'Physics',91)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80)
,(4,'Chemistry',71),(4,'Physics',54);

with cte_1 as (
select student_id,subject,marks,lead(subject) over(partition by student_id) as next_subject, lead(marks) over(partition by student_id) next_mark
from exams) select student_id from cte_1 
where subject in ('a','b') and next_subject in ('a','b')

-- 2consecutive then self join
-- more than 2 consecutive then subtract row num method
-- increase data in a pattern then recursive cte
-- have aggregation with row level data then windows fn
-- groupby and having
-- see date fns
-- cross join if you want all combination of 2 rows or multiple rows with multiple table cross join
-- outer join for getting all the rows from 2 tables and we do left join union right join for that
-- make ctes if there are many multiparts in data
 