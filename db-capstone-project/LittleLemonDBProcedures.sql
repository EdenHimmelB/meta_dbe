DELIMITER //

-- Create stored procedure GetMaxQuantity
CREATE PROCEDURE GetMaxQuantity() BEGIN
DECLARE max_quantity INT;
SELECT MAX(quantity) INTO max_quantity
FROM orders;
SELECT max_quantity;
END//

-- Create stored procedure AddBooking
CREATE PROCEDURE AddBooking(
    IN new_booking_id INT,
    IN new_customer_id INT,
    IN new_booking_date DATE,
    IN new_table_number INT
) 
BEGIN
    INSERT INTO customers(
        id
    ) VALUES(
        new_customer_id
    );

    INSERT INTO bookings(
        id,
        customer_id,
        booking_date,
        table_number
    ) VALUES(
        new_booking_id,
        new_customer_id,
        new_booking_date,
        new_table_number
    );
    
    SELECT CONCAT('Your booking id ', new_booking_id, ' for table ', new_table_number, ' on ', new_booking_date, ' is successful.') AS 'Confirmation';
END//

-- Create stored procedure UpdateBooking
CREATE PROCEDURE UpdateBooking(
    IN booking_id_to_update INT,
    IN new_booking_date DATE
) BEGIN
UPDATE bookings
SET booking_date = new_booking_date
WHERE id = booking_id_to_update;
SELECT CONCAT('Booking ', booking_id_to_update, ' updated') AS 'Confirmation';
END//


-- Create stored procedure CancelBooking
CREATE PROCEDURE CancelBooking(IN booking_id_to_cancel INT) BEGIN
DELETE FROM bookings
WHERE id = booking_id_to_cancel;
SELECT CONCAT('Booking ', booking_id_to_cancel, ' was cancelled') AS 'Confirmation';
END//

DELIMITER ;

SET FOREIGN_KEY_CHECKS = 0;

-- Mock data insertion
INSERT INTO `LittleLemonDB`.`customers` (
`id`, `customer_name`, `contact_number`
) VALUES
(1, 'Buttler Jihad', 1113334444),
(2, 'Desert Mouse', 7776669999),
(3, 'Desert Spring', 2224567777);

INSERT INTO `LittleLemonDB`.`orders` (
`id`, `customer_id`, `order_date`, `quantity`, `sales`
) VALUES
(1, 1, '2024-05-01', 5, 49.48),
(2, 2, '2024-05-02 ', 3, 21.00),
(3, 3, '2024-05-03', 1, 12.99);

-- Checking procedures funtionality
CALL GetMaxQuantity();
CALL AddBooking(99, 99, '2022-12-10', 99);
CALL UpdateBooking(99, '2022-1-10');
CALL Cancel(99);