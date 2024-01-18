-- 2. Best band ever!

-- Import the table dump
-- You can replace 'metal_bands.sql.zip' with the correct file path or URL
-- Ensure the file is accessible to the MySQL server
-- The command may vary based on the source of the dump (local file, URL, etc.)
-- Example command for a local file:
-- mysql -uroot -p holberton < metal_bands.sql

-- Query to rank country origins of bands by the number of (non-unique) fans
SELECT origin, COUNT(*) as nb_fans
FROM metal_bands
GROUP BY origin
ORDER BY nb_fans DESC;
