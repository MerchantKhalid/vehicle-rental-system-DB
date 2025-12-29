-- SQL QUERIES

-- QUERY 1: JOIN
-- Retrieve booking information along with customer name and vehicle name
-- Concepts: INNER JOIN


SELECT 
    b.booking_id,
    u.name AS customer_name,
    v.vehicle_name,
    b.start_date,
    b.end_date,
    b.booking_status,
    b.total_cost
FROM Bookings b
INNER JOIN Users u ON b.user_id = u.user_id
INNER JOIN Vehicles v ON b.vehicle_id = v.vehicle_id;


-- QUERY 2: EXISTS
-- Find all vehicles that have never been booked
-- Concepts: NOT EXISTS
-

SELECT 
    vehicle_id,
    vehicle_name,
    vehicle_type,
    model,
    rental_price_per_day,
    availability_status
FROM Vehicles v
WHERE NOT EXISTS (
    SELECT 1 
    FROM Bookings b 
    WHERE b.vehicle_id = v.vehicle_id
);


-- QUERY 3: WHERE
-- Retrieve all available vehicles of a specific type 
-- Concepts: SELECT, WHERE


SELECT 
    vehicle_id,
    vehicle_name,
    vehicle_type,
    model,
    registration_number,
    rental_price_per_day,
    availability_status
FROM Vehicles
WHERE vehicle_type = 'car' 
  AND availability_status = 'available';



-- QUERY 4: GROUP BY and HAVING
-- Find total number of bookings for each vehicle and display only those 
-- vehicles that have more than 2 bookings
-- Concepts: GROUP BY, HAVING, COUNT


SELECT 
    v.vehicle_id,
    v.vehicle_name,
    v.vehicle_type,
    COUNT(b.booking_id) AS total_bookings
FROM Vehicles v
INNER JOIN Bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.vehicle_name, v.vehicle_type
HAVING COUNT(b.booking_id) > 2;


-- VERIFICATION QUERIES 

-- Check total records in each table
SELECT 'Users' AS table_name, COUNT(*) AS total_records FROM Users
UNION ALL
SELECT 'Vehicles', COUNT(*) FROM Vehicles
UNION ALL
SELECT 'Bookings', COUNT(*) FROM Bookings;

-- View all tables
SELECT * FROM Users;
SELECT * FROM Vehicles;
SELECT * FROM Bookings;
