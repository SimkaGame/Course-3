select 
    region,
    sum(base_price - discount + ad_revenue) filter (where status = 'completed') as delivered_revenue,
    count(*) filter (where status = 'refunded')                                  as refund_cnt,
    count(*) filter (where status = 'refunded')::numeric / count(*)             as refund_rate
from views
group by region
order by refund_rate desc;