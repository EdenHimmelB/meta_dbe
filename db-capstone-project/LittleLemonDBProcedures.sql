DELIMITER //

-- Create stored procedure GetMaxQuantity
CREATE PROCEDURE GetMaxQuantity() BEGIN
DECLARE max_quantity INT;
SELECT MAX(quantity) INTO max_quantity
FROM orders;
SELECT max_quantity;
END//

-- Create stored procedure UpdateBooking
CREATE PROCEDURE UpdateBooking(
    IN booking_id_to_update INT,
    IN new_booking_date DATE
) BEGIN
UPDATE bookings
SET booking_date = new_booking_date
WHERE booking_id = booking_id_to_update;
SELECT CONCAT('Booking ', booking_id_to_update, ' updated') AS 'Confirmation';
END//

-- Create stored procedure AddBooking

CREATE PROCEDURE AddBooking(
    IN new_booking_id INT,
    IN new_customer_id INT,
    IN new_booking_date DATE,
    IN new_table_number INT,
    IN new_staff_id INT
) 
BEGIN
    INSERT INTO bookings(
        booking_id,
        customer_id,
        booking_date,
        table_number,
        staff_id
    ) VALUES(
        new_booking_id,
        new_customer_id,
        new_booking_date,
        new_table_number,
        new_staff_id
    );
    
    SELECT CONCAT('Your booking id ', new_booking_id, ' for table ', new_table_number, ' on ', new_booking_date, ' is successful.') AS 'Confirmation';
END//



-- Create stored procedure CancelBooking
CREATE PROCEDURE CancelBooking(IN booking_id_to_cancel INT) BEGIN
DELETE FROM bookings
WHERE booking_id = booking_id_to_cancel;
SELECT CONCAT('Booking ', booking_id_to_cancel, ' was cancelled') AS 'Confirmation';
END//

DELIMITER ;