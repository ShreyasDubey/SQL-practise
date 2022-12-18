create table movie_1(
seat varchar(50),occupancy int
);
truncate table movie_1;
insert into movie_1 values('a1',1),('a2',1),('a3',0),('a4',0),('a5',0),('a6',0),('a7',1),('a8',1),('a9',0),('a10',0),
('b1',0),('b2',0),('b3',0),('b4',1),('b5',1),('b6',1),('b7',1),('b8',0),('b9',0),('b10',0),
('c1',0),('c2',1),('c3',0),('c4',1),('c5',1),('c6',0),('c7',1),('c8',0),('c9',0),('c10',1);
select * from movie_1;

show errors;

with cte_1 as(
select *,left(seat,1) as row_st, cast(mid(seat,2,3)-cast(row_number() over (partition by left(seat,1) order by cast(mid(seat,2,3) as signed)) as signed) as signed) as gr_st
from movie_1
where occupancy=0)
select seat from cte_1 a join
(select row_st,gr_st
from cte_1
group by row_st,gr_st
having count(*) = 4) b on a.row_st=b.row_st and a.gr_st = b.gr_st;

select mid(seat,2,3)
from movie_1;