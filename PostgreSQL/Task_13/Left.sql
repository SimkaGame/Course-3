-- Все произведения
select 
    a.title,
    m.name          museum_name,
    ma.display_count
from artwork a
left join museum_artwork ma on a.id = ma.artwork_id
left join museum m          on ma.museum_id = m.id;

-- Количество копий работ по художникам
select 
    art.name                    artist_name,
    coalesce(sum(ma.display_count), 0)  total_displayed
from artist art
left join artwork aw        on art.id = aw.artist_id
left join museum_artwork ma on aw.id = ma.artwork_id
group by art.id, art.name
order by total_displayed desc, art.name;