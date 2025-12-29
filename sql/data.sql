-- Sample Data for Vehicle Rental System

-- ============================================
-- Insert Users (Admins and Customers)
-- ============================================
INSERT INTO Users (name, email, password, phone_number, role) VALUES
-- Admins
('John Admin', 'john.admin@rental.com', 'hashed_password_1', '1234567890', 'Admin'),
('Sarah Manager', 'sarah.manager@rental.com', 'hashed_password_2', '1234567891', 'Admin'),

-- Customers
('Alice Johnson', 'alice.j@email.com', 'hashed_password_3', '9876543210', 'Customer'),
('Bob Smith', 'bob.smith@email.com', 'hashed_password_4', '9876543211', 'Customer'),
('Charlie Brown', 'charlie.b@email.com', 'hashed_password_5', '9876543212', 'Customer'),
('Diana Prince', 'diana.p@email.com', 'hashed_password_6', '9876543213', 'Customer'),
('Eve Wilson', 'eve.w@email.com', 'hashed_password_7', '9876543214', 'Customer'),
('Frank Miller', 'frank.m@email.com', 'hashed_password_8', '9876543215', 'Customer');

-- ============================================
-- Insert Vehicles (Cars, Bikes, Trucks)
-- ============================================
INSERT INTO Vehicles (vehicle_name, vehicle_type, model, registration_number, rental_price_per_day, availability_status) VALUES
-- Cars
('Toyota Camry', 'car', '2023', 'CAR-1001', 50.00, 'available'),
('Honda Civic', 'car', '2022', 'CAR-1002', 45.00, 'rented'),
('Tesla Model 3', 'car', '2024', 'CAR-1003', 120.00, 'available'),
('BMW 3 Series', 'car', '2023', 'CAR-1004', 100.00, 'rented'),
('Mercedes C-Class', 'car', '2023', 'CAR-1005', 110.00, 'maintenance'),
('Audi A4', 'car', '2022', 'CAR-1006', 95.00, 'available'),

-- Bikes
('Yamaha R15', 'bike', 'V3', 'BIKE-2001', 15.00, 'available'),
('Honda CBR', 'bike', '650R', 'BIKE-2002', 25.00, 'rented'),
('Kawasaki Ninja', 'bike', '400', 'BIKE-2003', 30.00, 'available'),
('Royal Enfield', 'bike', 'Classic 350', 'BIKE-2004', 20.00, 'available'),
('Suzuki GSX', 'bike', 'R1000', 'BIKE-2005', 35.00, 'maintenance'),

-- Trucks
('Ford F-150', 'truck', '2023', 'TRUCK-3001', 80.00, 'available'),
('Chevrolet Silverado', 'truck', '2022', 'TRUCK-3002', 75.00, 'rented'),
('Ram 1500', 'truck', '2023', 'TRUCK-3003', 85.00, 'available'),
('Toyota Tundra', 'truck', '2024', 'TRUCK-3004', 90.00, 'available');

-- ============================================
-- Insert Bookings
-- ============================================
INSERT INTO Bookings (user_id, vehicle_id, start_date, end_date, booking_status, total_cost) VALUES
-- Alice's bookings (user_id: 3)
(3, 2, '2025-01-10', '2025-01-15', 'confirmed', 225.00),  -- Honda Civic (5 days * 45)
(3, 7, '2025-02-01', '2025-02-03', 'completed', 30.00),   -- Yamaha R15 (2 days * 15)
(3, 4, '2025-03-15', '2025-03-20', 'completed', 500.00),  -- BMW 3 Series (5 days * 100)

-- Bob's bookings (user_id: 4)
(4, 8, '2025-01-20', '2025-01-25', 'confirmed', 125.00),  -- Honda CBR (5 days * 25)
(4, 13, '2025-02-10', '2025-02-12', 'completed', 150.00), -- Chevrolet Silverado (2 days * 75)

-- Charlie's bookings (user_id: 5)
(5, 1, '2025-01-05', '2025-01-07', 'completed', 100.00),  -- Toyota Camry (2 days * 50)
(5, 3, '2025-02-15', '2025-02-18', 'pending', 360.00),    -- Tesla Model 3 (3 days * 120)

-- Diana's bookings (user_id: 6)
(6, 6, '2025-01-12', '2025-01-14', 'completed', 190.00),  -- Audi A4 (2 days * 95)
(6, 9, '2025-02-20', '2025-02-22', 'confirmed', 60.00),   -- Kawasaki Ninja (2 days * 30)

-- Eve's bookings (user_id: 7)
(7, 12, '2025-01-08', '2025-01-10', 'completed', 160.00), -- Ford F-150 (2 days * 80)
(7, 14, '2025-03-01', '2025-03-05', 'confirmed', 360.00), -- Ram 1500 (4 days * 90)

-- Frank's bookings (user_id: 8)
(8, 10, '2025-02-05', '2025-02-07', 'cancelled', 40.00),  -- Royal Enfield (2 days * 20)

-- Additional bookings for vehicles with multiple bookings (for Query 4)
(4, 2, '2025-03-10', '2025-03-12', 'pending', 90.00),     -- Honda Civic again
(5, 2, '2025-04-01', '2025-04-03', 'pending', 90.00);     -- Honda Civic third booking

-- ============================================
-- Verify Data
-- ============================================
SELECT 'Users Table' AS 'Table Name', COUNT(*) AS 'Record Count' FROM Users
UNION ALL
SELECT 'Vehicles Table', COUNT(*) FROM Vehicles
UNION ALL
SELECT 'Bookings Table', COUNT(*) FROM Bookings;

-- Display summary
SELECT 
    'Summary' AS Info,
    (SELECT COUNT(*) FROM Users WHERE role = 'Admin') AS Admins,
    (SELECT COUNT(*) FROM Users WHERE role = 'Customer') AS Customers,
    (SELECT COUNT(*) FROM Vehicles WHERE availability_status = 'available') AS Available_Vehicles,
    (SELECT COUNT(*) FROM Vehicles WHERE availability_status = 'rented') AS Rented_Vehicles,
    (SELECT COUNT(*) FROM Bookings WHERE booking_status = 'confirmed') AS Active_Bookings;