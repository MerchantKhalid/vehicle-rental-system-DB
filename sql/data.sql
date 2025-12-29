-- SAMPLE DATA

-- Insert Users
INSERT INTO Users (role, name, email, password, phone_number) VALUES
('Customer', 'John Smith', 'john.smith@email.com', 'password123', '+1-555-0101'),
('Customer', 'Sarah Johnson', 'sarah.j@email.com', 'password456', '+1-555-0102'),
('Admin', 'Mike Admin', 'admin@rental.com', 'admin123', '+1-555-0100'),
('Customer', 'Emma Wilson', 'emma.w@email.com', 'password789', '+1-555-0103'),
('Customer', 'David Brown', 'david.b@email.com', 'password321', '+1-555-0104');

-- Insert Vehicles
INSERT INTO Vehicles (vehicle_name, vehicle_type, model, registration_number, rental_price_per_day, availability_status) VALUES
('Toyota Camry', 'car', 'Camry 2023', 'ABC-1234', 45.00, 'available'),
('Honda Civic', 'car', 'Civic Sport', 'XYZ-5678', 40.00, 'available'),
('Yamaha R15', 'bike', 'R15 V4', 'BIKE-001', 20.00, 'available'),
('Ford F-150', 'truck', 'F-150 XLT', 'TRK-9999', 75.00, 'rented'),
('Tesla Model 3', 'car', 'Model 3', 'TESLA-01', 85.00, 'available'),
('Honda CBR', 'bike', 'CBR 500R', 'BIKE-002', 25.00, 'maintenance'),
('BMW 3 Series', 'car', '330i', 'BMW-3301', 95.00, 'rented'),
('Nissan Altima', 'car', 'Altima 2021', 'NIS-1122', 38.00, 'available');

-- Insert Bookings
INSERT INTO Bookings (user_id, vehicle_id, start_date, end_date, booking_status, total_cost) VALUES
(1, 1, '2025-01-15', '2025-01-20', 'completed', 225.00),
(2, 3, '2025-01-10', '2025-01-12', 'completed', 40.00),
(1, 2, '2025-01-25', '2025-01-30', 'confirmed', 200.00),
(4, 5, '2025-02-01', '2025-02-05', 'confirmed', 340.00),
(1, 1, '2025-02-10', '2025-02-12', 'pending', 90.00),
(2, 1, '2025-02-15', '2025-02-18', 'confirmed', 135.00),
(4, 7, '2025-01-20', '2025-01-25', 'completed', 475.00),
(5, 2, '2025-01-28', '2025-02-02', 'confirmed', 200.00);