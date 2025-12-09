-- Самая многочисленная работа в каждом музее
select 
    m.name          museum_name,
    t.title         top_artwork,
    t.cnt           max_display_count
from museum m
left join lateral (
    select a.title, ma.display_count cnt
    from museum_artwork ma
    join artwork a on ma.artwork_id = a.id
    where ma.museum_id = m.id
    order by ma.display_count desc
    limit 1
) t on true;

-- Последняя выдача для каждого посетителя
select 
    v.name          visitor_name,
    l.loaned_at,
    a.title         artwork_title,
    m.name          museum_name
from visitor v
join lateral (
    select l.*
    from loan l
    join visitor_museum vm 
      on l.museum_id = vm.museum_id and l.card_number = vm.card_number
    where vm.visitor_id = v.id
    order by l.loaned_at desc
    limit 1
) l on true
left join artwork a on l.artwork_id = a.id
left join museum m  on l.museum_id = m.id;