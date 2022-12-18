
SET @todays_date := "2022-09-29";
SET @n :=2;
select Adddate(ADDDATE(@todays_date, INTERVAL (6-weekday(@todays_date)) DAY),INTERVAL @n-1 week) as next_weekend;
