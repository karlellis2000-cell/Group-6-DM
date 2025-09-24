SELECT COUNT(*) AS row_matches_title_only
FROM staging_sales s
JOIN staging_movies m ON s.title_key = m.title_key;