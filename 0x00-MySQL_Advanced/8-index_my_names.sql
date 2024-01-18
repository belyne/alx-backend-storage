-- 8. Optimize simple search

-- Create the 'idx_name_first' index
CREATE INDEX idx_name_first ON names(name(1));
