-- ===============================
-- PharmaFast Database Schema
-- ===============================

CREATE DATABASE IF NOT EXISTS pharmafast;
USE pharmafast;

-- ===============================
-- Admin Table
-- ===============================
CREATE TABLE admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL
);

-- ===============================
-- Patients Table
-- ===============================
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL,
    password VARCHAR(100) NOT NULL
);

-- ===============================
-- Doctors Table
-- ===============================
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    specialization VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL
);

-- ===============================
-- Medicines Table
-- ===============================
CREATE TABLE medicines (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_name VARCHAR(100) NOT NULL,
    description VARCHAR(200),
    price DOUBLE NOT NULL,
    stock INT NOT NULL
);

-- ===============================
-- Orders Table
-- ===============================
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    medicine_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,

    CONSTRAINT fk_orders_patient
        FOREIGN KEY (patient_id) REFERENCES patients(patient_id),

    CONSTRAINT fk_orders_medicine
        FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- ===============================
-- Appointments Table
-- ===============================
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    problem_description VARCHAR(255),
    status VARCHAR(20) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_appointments_patient
        FOREIGN KEY (patient_id) REFERENCES patients(patient_id),

    CONSTRAINT fk_appointments_doctor
        FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);
