select 
    membership,
    count(*)                                                      as total_sessions,
    count(*) filter (where status = 'refunded')                   as refund_cnt,
    sum(base_price - discount + ad_revenue) filter (where status = 'completed') as delivered_revenue
from views
group by membership
having 
    count(*) filter (where status = 'refunded')::numeric / count(*) > 0.08
    or 
    sum(base_price - discount + ad_revenue) filter (where status = 'completed') > 12;