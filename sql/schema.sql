-- Drop existing tables if they exist
DROP DATABASE IF EXISTS vehicle_rental_system;
CREATE DATABASE vehicle_rental_system;
USE vehicle_rental_system;

-- TABLE 1: USERS


CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    role VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20)
);


-- TABLE 2: VEHICLES


CREATE TABLE Vehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_name VARCHAR(100) NOT NULL,
    vehicle_type VARCHAR(30) NOT NULL,
    model VARCHAR(50),
    registration_number VARCHAR(20) NOT NULL UNIQUE,
    rental_price_per_day DECIMAL(10,2) NOT NULL,
    availability_status VARCHAR(20) NOT NULL
);


-- TABLE 3: BOOKINGS

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    booking_status VARCHAR(20) NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);