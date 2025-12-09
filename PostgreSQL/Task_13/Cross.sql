-- Все комбинации музеев
select distinct
    m.name          museum_name,
    a.year_created
from museum m
cross join artwork a
where a.year_created is not null
order by museum_name, a.year_created;

-- Первые 100 строк
select 
    m.name          museum_name,
    a.title         artwork_title
from museum m
cross join artwork a
order by m.id, a.id
limit 100;