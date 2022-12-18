SELECT * FROM practice.megamart_sales;

with new_tab as (
select Sub_Category,sum(sales) as total_sales
from practice.megamart_sales
group by Sub_Category
order by 2 desc), new_tab_2 as (
select Sub_Category, total_sales,sum(total_sales) over (order by total_sales desc rows unbounded preceding) as cumulative_sales,
0.8*(sum(total_sales) over ()) as target_sales
from new_tab
group by 1)
select * from new_tab_2
where cumulative_sales<= target_sales;



