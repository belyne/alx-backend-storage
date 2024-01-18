-- 13. Average weighted score for all

-- Create the stored procedure ComputeAverageWeightedScoreForUsers
DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE user_id_param INT;
    
    -- Declare cursor to loop through users
    DECLARE user_cursor CURSOR FOR SELECT id FROM users;
    
    -- Variable to store the user id
    DECLARE done BOOLEAN DEFAULT FALSE;

    -- Declare exit handler for the cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN user_cursor;

    -- Loop through users
    user_loop: LOOP
        -- Fetch the next user id
        FETCH user_cursor INTO user_id_param;

        -- Exit the loop if no more users
        IF done THEN
            LEAVE user_loop;
        END IF;

        -- Calculate and update average weighted score for the current user
        CALL ComputeAverageWeightedScoreForUser(user_id_param);
    END LOOP;

    -- Close the cursor
    CLOSE user_cursor;
END //
DELIMITER ;
