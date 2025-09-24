--Creating new column with total box office since there is no worldwide box office when there is only domestic box office.
ALTER TABLE staging_sales 
ADD COLUMN total_box_office BIGINT;

UPDATE staging_sales
SET total_box_office = 
    COALESCE(NULLIF(domestic_box_office, 'n/a')::BIGINT, 0)
    + COALESCE(international_box_office, 0);

SELECT * FROM staging_sales
