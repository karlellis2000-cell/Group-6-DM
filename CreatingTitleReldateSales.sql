DELETE FROM sales
WHERE release_date !~ '[0-9]';

DELETE FROM sales
WHERE release_date ~ '\(.*\)';

--Deletes all lines where there is no date. E.g. 'Spring' 'Summer'

UPDATE sales
SET release_date =
  to_char(
    CASE
      -- e.g. "1st of january" or "15th january"
      WHEN release_date ~ '^[0-9]'
        THEN to_date(
               regexp_replace(lower(release_date), '\s+of\s+', ' '),  -- "1st of january" → "1st january" removes 'of'
               'DDth Month'
             )
      -- e.g. "January 15th"
      ELSE to_date(
             lower(release_date),
             'Month DDth'
           )
    END,
    'DD-MM'
  );

ALTER TABLE sales
ADD COLUMN full_rel_date text;

--Year and date are seperate. Creating new column with full date

UPDATE sales
SET full_rel_date = to_char(
    to_date(release_date || '-' || relyear::text, 'DD-MM-YYYY'),
    'YYYY-MM-DD'
);

-- Adding year to date and making it in the form YYYY-MM-DD because it's also like this in Metaclean

ALTER TABLE sales
ADD COLUMN title_year TEXT;

UPDATE sales
SET title_year =
    lower(regexp_replace(title, '[^a-zA-Z0-9]', '', 'g'))
    || full_rel_date::text;

--Making Title_Year to make a key to link with movies table