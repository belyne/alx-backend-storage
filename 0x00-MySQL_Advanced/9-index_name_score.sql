-- 9. Optimize search and score

-- Create the 'idx_name_first_score' index
CREATE INDEX idx_name_first_score ON names(name(1), score);
