select date_format('2022-09-10','%Y') < 2019;

select date('2022-09-10')+interval 5 year;
select extract(year from '2022-09-10')	< 2019;
 
 select datediff('2022-11-10','2022-09-15');
 
 SELECT DATEDIFF(DAY, '2013-09-01', '2013-11-15') / 30.436875E;
 
 select STR_TO_DATE('2-14-20','%m-%d-%y') as new_date;
 
 select TIMESTAMPDIFF(MONTH, b.order_date, a.order_date)<=1;
 
  select TIMESTAMPDIFF(day, '2022-09-19','2022-09-10');
  
  select str_to_date('01-JAN-1990','%d-%M-%Y');
  
  show errors;
  
  -- cast(days_rank as signed); if getting error bigint out of range
  
  select left('HII',2), right("shreyas",2),mid("shreyas",2,5);-- 5 in mid is no of elements
  
  -- get week of the month 
  select week("2022-09-11")-week("2022-09-01");
  
SET @todays_date := "2022-09-29";
SET @n :=2;
select Adddate(ADDDATE(@todays_date, INTERVAL (6-weekday(@todays_date)) DAY),INTERVAL @n-1 week) as next_weekend;
  
  -- group_concat
  
  -- ctrl + / for multiline comment
  -- 2consecutive then self join
-- more than 2 consecutive then subtract row num method
-- increase data in a pattern then recursive cte
-- have aggregation with row level data then windows fn
-- groupby and having with distinct count
-- see date fns
-- cross join if you want all combination of 2 rows or multiple rows with multiple table cross join
-- outer join for getting all the rows from 2 tables and we do left join union right join for that
-- make ctes if there are many multiparts in data
-- case for pivot table creation