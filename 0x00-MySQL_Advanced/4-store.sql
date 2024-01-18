-- 4. Buy buy buy

-- Create the 'decrease_quantity_trigger' trigger
CREATE TRIGGER decrease_quantity_trigger
AFTER INSERT
ON orders
FOR EACH ROW

-- Update the quantity in the 'items' table
UPDATE items
SET quantity = quantity - NEW.number
WHERE name = NEW.item_name;
