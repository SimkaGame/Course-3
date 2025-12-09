-- Все музеи + экспонаты
select 
    m.name          museum_name,
    a.title         artwork_title,
    ma.display_count
from museum_artwork ma
right join museum m on ma.museum_id = m.id
left join artwork a on ma.artwork_id = a.id;

-- Количество уникальных экспонатов в каждом музее
select 
    m.name          museum_name,
    count(ma.artwork_id)  artworks_count
from museum m
left join museum_artwork ma on m.id = ma.museum_id
group by m.id, m.name
order by artworks_count desc, m.name;