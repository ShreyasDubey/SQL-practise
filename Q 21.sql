use practice;

CREATE TABLE STORES (
Store varchar(10),
Quarter varchar(10),
Amount int);

INSERT INTO STORES (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);

select * from stores a right join
(select distinct Quarter,store from stores) as b on a.quarter=b.quarter and a.store=b.store;
 
-- using logic
select concat('Q',10-sum(right(Quarter,1))) as missing_quarter ,store
from stores
group by store;

-- using cross join
(select distinct a.store,b.store
from stores a, stores b
order by a.store,b.quarter);

-- using recursive cte
with recursive cte_1 as (
select distinct store, 1 as q from stores
union all
select store,q+1
from cte_1
where q<4
) ,cte_2 as (select store,concat('Q',q) as quarter from cte_1
order by store)
select a.store,a.quarter from cte_2 a left join stores b on a.store = b.store and a.quarter=b.quarter
where b.store is null;