DELETE FROM sales
WHERE release_date !~ '[0-9]';

UPDATE sales
SET release_date =
  to_char(
    CASE
      -- e.g. "1st of january" or "15th january"
      WHEN release_date ~ '^[0-9]'
        THEN to_date(
               regexp_replace(lower(release_date), '\s+of\s+', ' '),  -- "1st of january" → "1st january"
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

UPDATE sales
SET full_rel_date = to_char(
    to_date(release_date || '-' || relyear::text, 'DD-MM-YYYY'),
    'YYYY-MM-DD'
);

ALTER TABLE sales
ADD COLUMN title_year TEXT;

UPDATE sales
SET title_year =
    lower(regexp_replace(title, '[^a-zA-Z0-9]', '', 'g'))
    || full_rel_date::text;