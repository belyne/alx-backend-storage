-- 3. Old school band

-- Import the table dump
-- You can replace 'metal_bands.sql.zip' with the correct file path or URL
-- Ensure the file is accessible to the MySQL server
-- The command may vary based on the source of the dump (local file, URL, etc.)
-- Example command for a local file:
-- mysql -uroot -p holberton < metal_bands.sql

-- Query to list bands with Glam rock as their main style, ranked by longevity
SELECT band_name,
       IFNULL(SUBSTRING_INDEX(lifespan, '-', -1) - SUBSTRING_INDEX(lifespan, '-', 1), 0) AS lifespan
FROM metal_bands
WHERE FIND_IN_SET('Glam rock', styles) > 0
ORDER BY lifespan DESC, band_name;
