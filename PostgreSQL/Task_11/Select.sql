select 
    view_id,
    region,
    status,
    case 
        when status = 'completed' then base_price - discount + ad_revenue
        when status = 'refunded'   then 0
        else ad_revenue
    end as net_revenue,
    
    case 
        when minutes <= 30 then 'short'
        when minutes <= 60 then 'mid'
        else 'long'
    end as length_band
    
from views
order by view_date, view_id;