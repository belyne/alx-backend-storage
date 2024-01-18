-- 5. Email validation to sent

-- Create the 'reset_valid_email_trigger' trigger
DELIMITER //
CREATE TRIGGER reset_valid_email_trigger
BEFORE UPDATE
ON users
FOR EACH ROW
BEGIN
    -- Check if the email attribute has been changed
    IF NEW.email <> OLD.email THEN
        SET NEW.valid_email = 0;
    END IF;
END //
DELIMETER ;
