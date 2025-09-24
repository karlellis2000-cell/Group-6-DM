
ALTER TABLE staging_sales ADD COLUMN title_year_key text;
UPDATE staging_sales
SET title_year_key = regexp_replace(lower(title), '[^a-z0-9]', '', 'g')
                     || '_' || relyear::text; 


ALTER TABLE staging_movies ADD COLUMN rel_year int;
UPDATE staging_movies
SET rel_year = EXTRACT(YEAR FROM RelDate)::int;

ALTER TABLE staging_movies ADD COLUMN title_year_key text;
UPDATE staging_movies
SET title_year_key = regexp_replace(lower(title), '[^a-z0-9]', '', 'g')
                     || '_' || rel_year::text;
