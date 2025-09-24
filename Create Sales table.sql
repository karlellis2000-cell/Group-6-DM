ALTER TABLE sales RENAME TO sales_staging

CREATE TABLE sales(
   title_year_key TEXT PRIMARY KEY,
   title TEXT,
   total_box_office BIGINT,
   genre_name TEXT
);

SELECT m.title_year_key, COUNT (*) AS duplicates
FROM sales_staging s
JOIN movies m ON m.title_year_key = s.title_year_key
GROUP BY m.title_year_key 
HAVING COUNT (*) >1
/* finds duplicates between the sales_staging and movies table based on combining the movies title + release year*/


DELETE FROM sales_staging s
USING (
    SELECT ctid, ROW_NUMBER() OVER (PARTITION BY title_year_key ORDER BY title_year_key) AS rn
    FROM sales_staging
) dup
WHERE s.ctid = dup.ctid
AND dup.rn > 1;
/* deletes all dulpicates in the sales_staging table except for one*/

DELETE FROM sales_staging
WHERE title_year_key IS NULL;
/* deletes null values*/

INSERT INTO sales (
    title_year_key,
    title,
    total_box_office,
    genre_name
)
SELECT 
    title_year_key,
    title,
    total_box_office,
    genre_name
FROM sales_staging;
/*imports data from sales_staging into sales*/
