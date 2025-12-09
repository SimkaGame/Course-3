select 
    region,
    count(*)                  as sessions,
    sum(minutes)              as sum_minutes,
    avg(ad_revenue)           as avg_ads,
    max(base_price)           as max_price
from views
group by region
order by sum_minutes desc;