-- Пары художников(Ровесники)
select 
    a1.name         artist1,
    a2.name         artist2,
    a1.birth_year
from artist a1
join artist a2 
  on a1.birth_year = a2.birth_year 
 and a1.id < a2.id
where a1.birth_year is not null
order by a1.birth_year, a1.name;

-- Пары произведений одного года
select 
    a1.title        artwork1,
    art1.name       author1,
    a2.title        artwork2,
    art2.name       author2,
    a1.year_created
from artwork a1
left join artist art1 on a1.artist_id = art1.id
join artwork a2 
  on a1.year_created = a2.year_created 
 and a1.id < a2.id
left join artist art2 on a2.artist_id = art2.id
where a1.year_created is not null
order by a1.year_created, a1.title;