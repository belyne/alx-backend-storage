-- 7. Average score

-- Create the 'ComputeAverageScoreForUser' stored procedure
DELIMITER //
CREATE PROCEDURE ComputeAverageScoreForUser(IN user_id_param INT)
BEGIN
    DECLARE total_score FLOAT;
    DECLARE project_count INT;

    -- Calculate the total score and the number of projects for the user
    SELECT SUM(score), COUNT(DISTINCT project_id)
    INTO total_score, project_count
    FROM corrections
    WHERE user_id = user_id_param;

    -- Update the average score for the user
    UPDATE users
    SET average_score = IFNULL(total_score / project_count, 0)
    WHERE id = user_id_param;
END //
DELIMITER ;
