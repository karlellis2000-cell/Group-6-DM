ALTER TABLE movies
ADD COLUMN title_year TEXT;
-- Creating a new column for title+year

UPDATE movies
SET title_year =
    lower(regexp_replace(title, '[^a-zA-Z0-9]', '', 'g'))
    || reldate::text;

-- lower lowercases title, regexp_replace removes everything except numbers and letters
-- then add release date behind the title