CREATE TABLE genre (
  genre_id SERIAL PRIMARY KEY,
  genre    TEXT NOT NULL UNIQUE
);
-- Creating new genre table with 2 columns. genre_id is generated and genre is all the genres from the staging_movies

INSERT INTO genre (genre)
SELECT DISTINCT initcap(trim(g_piece)) AS genre --initcap makes it capital case, trim removes any spaces
FROM (
  SELECT regexp_split_to_table(genre, '\s*,\s*') AS g_piece --regexp_split_to_table makes the attributes with more genres into more lines with only 1 genre per line. '\s*,\s*' makes it split on ,
  FROM staging_movies
) s
WHERE nullif(trim(g_piece), '') IS NOT NULL
ON CONFLICT (genre) DO NOTHING;