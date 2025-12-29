-- Vehicle Rental System Database Schema

-- Drop existing tables if they exist (for clean setup)
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Vehicles;
DROP TABLE IF EXISTS Users;

-- ============================================
-- Table 1: Users
-- Purpose: Stores user accounts (Admin and Customer)
-- ============================================
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    role ENUM('Admin', 'Customer') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Table 2: Vehicles
-- Purpose: Stores vehicle inventory and availability
-- ============================================
CREATE TABLE Vehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_name VARCHAR(100) NOT NULL,
    vehicle_type ENUM('car', 'bike', 'truck') NOT NULL,
    model VARCHAR(50) NOT NULL,
    registration_number VARCHAR(20) UNIQUE NOT NULL,
    rental_price_per_day DECIMAL(10, 2) NOT NULL,
    availability_status ENUM('available', 'rented', 'maintenance') DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Table 3: Bookings
-- Purpose: Stores rental booking transactions
-- ============================================
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    booking_status ENUM('pending', 'confirmed', 'completed', 'cancelled') DEFAULT 'pending',
    total_cost DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_booking_user FOREIGN KEY (user_id) 
        REFERENCES Users(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_booking_vehicle FOREIGN KEY (vehicle_id) 
        REFERENCES Vehicles(vehicle_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- ============================================
-- Indexes for Performance
-- ============================================
-- Index on email for faster user lookup
CREATE INDEX idx_users_email ON Users(email);

-- Index on registration number for faster vehicle search
CREATE INDEX idx_vehicles_registration ON Vehicles(registration_number);

-- Index on vehicle type and availability for filtering
CREATE INDEX idx_vehicles_type_status ON Vehicles(vehicle_type, availability_status);

-- Index on user bookings for faster queries
CREATE INDEX idx_bookings_user ON Bookings(user_id);

-- Index on vehicle bookings for faster queries
CREATE INDEX idx_bookings_vehicle ON Bookings(vehicle_id);

-- Index on booking status for filtering
CREATE INDEX idx_bookings_status ON Bookings(booking_status);

-- ============================================
-- Display Schema Information
-- ============================================
SHOW TABLES;

DESCRIBE Users;
DESCRIBE Vehicles;
DESCRIBE Bookings;