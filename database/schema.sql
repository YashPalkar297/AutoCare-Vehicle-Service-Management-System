-- ========================================================
-- AutoCare - Vehicle Service Management System
-- Database Schema Script (MySQL 8.x)
-- ========================================================

CREATE DATABASE IF NOT EXISTS autocare_db;
USE autocare_db;

-- 1. Users Table (Supports Customer, Staff/Technician, and Admin)
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role ENUM('CUSTOMER', 'STAFF', 'ADMIN') NOT NULL DEFAULT 'CUSTOMER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 2. Vehicles Table (Linked to registered customers)
CREATE TABLE IF NOT EXISTS vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    license_plate VARCHAR(20) NOT NULL UNIQUE,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    manufacture_year INT,
    vin VARCHAR(50),
    fuel_type VARCHAR(20) DEFAULT 'PETROL',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 3. Service Catalog Table (Available maintenance & repair services)
CREATE TABLE IF NOT EXISTS service_types (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    description TEXT,
    base_price DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    estimated_duration_hours DECIMAL(4, 2) DEFAULT 1.0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Appointments / Service Bookings Table
CREATE TABLE IF NOT EXISTS appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    service_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    time_slot VARCHAR(20) NOT NULL,
    customer_notes TEXT,
    status ENUM('PENDING', 'CONFIRMED', 'CANCELLED', 'COMPLETED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES service_types(service_id) ON DELETE RESTRICT
);

-- 5. Service Records / Job Cards Table
CREATE TABLE IF NOT EXISTS service_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE,
    technician_id INT NULL,
    service_status ENUM('WAITING', 'INSPECTION', 'IN_PROGRESS', 'QUALITY_CHECK', 'READY_FOR_PICKUP', 'DELIVERED') DEFAULT 'WAITING',
    technician_notes TEXT,
    parts_replaced TEXT,
    labor_cost DECIMAL(10, 2) DEFAULT 0.00,
    parts_cost DECIMAL(10, 2) DEFAULT 0.00,
    total_cost DECIMAL(10, 2) GENERATED ALWAYS AS (labor_cost + parts_cost) STORED,
    started_at DATETIME NULL,
    completed_at DATETIME NULL,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE CASCADE,
    FOREIGN KEY (technician_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- 6. Invoices Table
CREATE TABLE IF NOT EXISTS invoices (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    record_id INT NOT NULL UNIQUE,
    tax_amount DECIMAL(10, 2) DEFAULT 0.00,
    discount_amount DECIMAL(10, 2) DEFAULT 0.00,
    final_amount DECIMAL(10, 2) NOT NULL,
    payment_status ENUM('UNPAID', 'PAID', 'REFUNDED') DEFAULT 'UNPAID',
    payment_method VARCHAR(30) DEFAULT 'CASH',
    issued_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    paid_at DATETIME NULL,
    FOREIGN KEY (record_id) REFERENCES service_records(record_id) ON DELETE CASCADE
);

-- 7. Feedback & Reviews Table
CREATE TABLE IF NOT EXISTS feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE CASCADE
);

-- Seed Initial Default Services
INSERT INTO service_types (service_name, description, base_price, estimated_duration_hours) VALUES
('General Service & Oil Change', 'Complete oil and filter replacement, 40-point vehicle safety inspection, and fluid top-up.', 1499.00, 2.0),
('Brake Inspection & Pad Replacement', 'Comprehensive brake disc and pad inspection, rotor cleaning, and pad replacement.', 1899.00, 2.5),
('Periodic Wheel Alignment & Balancing', 'Laser alignment check, computer-guided wheel balancing, and tire pressure adjustment.', 799.00, 1.0),
('Air Conditioning & Climate Service', 'AC gas refill, compressor inspection, cabin filter replacement, and vent sanitization.', 2199.00, 3.0),
('Engine Diagnostics & Tune-up', 'OBD-II computer diagnostics, spark plug inspection, battery health check, and system scan.', 1299.00, 1.5)
ON DUPLICATE KEY UPDATE service_name = service_name;
