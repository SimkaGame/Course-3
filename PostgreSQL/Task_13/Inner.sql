-- Произведения с именем автора
select 
    a.title,
    art.name        artist_name,
    a.year_created
from artwork a
inner join artist art on a.artist_id = art.id;

-- Присутствующие экспонаты
select 
    m.name          museum_name,
    a.title         artwork_title,
    ma.display_count,
    ma.room
from museum_artwork ma
inner join museum m  on ma.museum_id = m.id
inner join artwork a on ma.artwork_id = a.id
where ma.display_count > 0
order by m.name, ma.display_count desc;