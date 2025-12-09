-- Строки с корректным email
select *
from iot_ingest_lines
where raw_line ~* '[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}';

-- Строки без корректного email
select *
from iot_ingest_lines
where raw_line !~* '\b[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}\b';

-- Извлечение первого email
select
    id,
    source_file,
    line_no,
    (regexp_match(raw_line, '([a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,})', 'i'))[1] as email
from iot_ingest_lines
where raw_line ~* '[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}';

-- Device id и извлечение
select
    id,
    source_file,
    line_no,
    raw_line,
    trim(regexp_replace(raw_line,
        '.*\y(?:dev_id|device|id|dev|serial)[:\s]+([a-z0-9_-]+).*$',
        '\1', 'i')) as device_id
from iot_ingest_lines
where raw_line ~* '\y(?:dev_id|device|id|dev|serial)[:\s]';

-- Версии прошивки
select
    id,
    source_file,
    line_no,
    regexp_matches(raw_line, '(v?\d+\.\d+(\.\d+)?)', 'gi') as fw_version
from iot_ingest_lines
where raw_line ~* '(fw|version)\s*:';

-- Убираем пробелы и запятые
select
    id,
    source_file,
    line_no,
    raw_line,
    regexp_replace(m[1], '[ ,]', '', 'g')::int as normalized_number
from (
    select id, source_file, line_no, raw_line,
           regexp_match(raw_line, '"(\d[\d ,]*\d)"') as m
    from iot_ingest_lines
) t
where m is not null;

-- Чистый массив тегов
select
    id,
    source_file,
    line_no,
    array_remove(array_agg(trim(t)) filter (where trim(t) <> ''), null) as clean_tags
from (
    select id, source_file, line_no,
           unnest(regexp_split_to_array(trim(regexp_replace(raw_line, '^tags:\s*', '')), '\s*,\s*')) as t
    from iot_ingest_lines
    where raw_line ~* '^tags:'
) sub
group by id, source_file, line_no;

-- Разбор грязных csv-полей
select
    i.id,
    i.source_file,
    i.line_no,
    f.field
from iot_ingest_lines i
cross join lateral regexp_matches(i.raw_line, '"([^""\\]*(?:\\.[^""\\]*)*)"', 'g') with ordinality as f(field, ord)
where i.source_file = 'installations_dirty.csv'
order by i.id, f.ord;

-- Логи со словом error
select *
from iot_ingest_lines
where source_file = 'ingest_log.txt'
  and raw_line ~* '\yerror\y';

-- Замена error на верхний регистр
select
    id,
    source_file,
    line_no,
    regexp_replace(raw_line, '\yerror\y', 'ERROR', 'gi') as fixed_line
from iot_ingest_lines
where source_file = 'ingest_log.txt';