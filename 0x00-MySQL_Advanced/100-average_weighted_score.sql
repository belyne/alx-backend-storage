-- 12. Average weighted score

-- Create the stored procedure ComputeAverageWeightedScoreForUser
DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id_param INT)
BEGIN
    DECLARE total_score FLOAT DEFAULT 0;
    DECLARE total_weight INT DEFAULT 0;
    DECLARE weighted_average FLOAT DEFAULT 0;

    -- Calculate total_score and total_weight
    SELECT SUM(corrections.score * projects.weight), SUM(projects.weight)
    INTO total_score, total_weight
    FROM corrections
    JOIN projects ON corrections.project_id = projects.id
    WHERE corrections.user_id = user_id_param;

    -- Calculate weighted average if total_weight is not 0
    IF total_weight > 0 THEN
        SET weighted_average = total_score / total_weight;
    END IF;

    -- Update the average_score in the users table
    UPDATE users
    SET average_score = weighted_average
    WHERE id = user_id_param;
END //
DELIMITER ;
