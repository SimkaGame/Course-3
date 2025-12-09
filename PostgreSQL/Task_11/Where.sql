select 
    view_id,
    content_type,
    minutes
from views
where minutes > case 
    when content_type = 'movie'  then 60
    when content_type = 'series' then 45
    else 30
end
order by minutes desc;