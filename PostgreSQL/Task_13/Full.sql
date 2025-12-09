-- Произведения и экспонирование
select 
    a.title,
    m.name          museum_name,
    ma.display_count
from artwork a
full join museum_artwork ma on a.id = ma.artwork_id
full join museum m          on ma.museum_id = m.id;

-- Художники и произведения
select 
    art.name        artist_name,
    a.title         artwork_title
from artist art
full  outer join artwork a on art.id = a.artist_id
order by artist_name, artwork_title;