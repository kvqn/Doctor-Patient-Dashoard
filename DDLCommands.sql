CREATE DATABASE HospitalManagement;
USE HospitalManagement;

CREATE TABLE Patient(
    email varchar(255) PRIMARY KEY,
    password varchar(255) NOT NULL,
    salt varchar(255) NOT NULL,
    name varchar(50) NOT NULL,
    address varchar(255) NOT NULL,
    gender VARCHAR(20) NOT NULL,
    phone_number varchar(15),
    birthdate DATE
);

CREATE INDEX idx_patient_name ON Patient(name); -- For searching patients by name

CREATE TABLE MedicalHistory(
    id int AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    conditions TEXT NOT NULL,
    surgeries TEXT NOT NULL,
    medication TEXT NOT NULL
);

CREATE TABLE Doctor(
    email varchar(255) PRIMARY KEY,
    gender varchar(20) NOT NULL,
    password varchar(255) NOT NULL,
    salt varchar(255) NOT NULL,
    name varchar(50) NOT NULL,
    phone_number varchar(15)
);

CREATE INDEX idx_doctor_name ON Doctor(name); -- For searching doctors by name

CREATE TABLE Appointment(
    id int AUTO_INCREMENT PRIMARY KEY,
    doctor_email varchar(255) NOT NULL,
    date DATE NOT NULL,
    starttime TIME NOT NULL,
    endtime TIME NOT NULL,
    status varchar(15) NOT NULL,
    FOREIGN KEY (doctor_email) REFERENCES Doctor(email) ON DELETE CASCADE
);

CREATE INDEX idx_appointment_date ON Appointment(date); -- For searching appointments by date

CREATE TABLE PatientsAttendAppointments(
    patient varchar(255) NOT NULL,
    appt int NOT NULL,
    concerns varchar(255) NOT NULL,
    symptoms varchar(255) NOT NULL,
    FOREIGN KEY (patient) REFERENCES Patient(email) ON DELETE CASCADE,
    FOREIGN KEY (appt) REFERENCES Appointment(id) ON DELETE CASCADE,
    PRIMARY KEY (patient, appt)
);

CREATE TABLE Schedule(
    id int AUTO_INCREMENT PRIMARY KEY,
    starttime TIME NOT NULL,
    endtime TIME NOT NULL,
    breaktime TIME NOT NULL,
    day varchar(20) NOT NULL
);

CREATE TABLE PatientMedicalHistory(
    patient_email varchar(255) NOT NULL,
    history int NOT NULL,
    FOREIGN KEY (patient_email) REFERENCES Patient(email) ON DELETE CASCADE,
    FOREIGN KEY (history) REFERENCES MedicalHistory(id) ON DELETE CASCADE,
    PRIMARY KEY (history)
);

CREATE TABLE Diagnoses(
    id int AUTO_INCREMENT PRIMARY KEY,
    appt int NOT NULL,
    doctor_email varchar(255) NOT NULL,
    diagnosis varchar(255) NOT NULL,
    prescription varchar(255) NOT NULL,
    FOREIGN KEY (appt) REFERENCES Appointment(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_email) REFERENCES Doctor(email) ON DELETE CASCADE
);

CREATE INDEX idx_diagnosis ON Diagnoses(diagnosis); -- For searching diagnoses

CREATE TABLE DocsHaveSchedules(
    sched int NOT NULL,
    doctor_email varchar(255) NOT NULL,
    FOREIGN KEY (sched) REFERENCES Schedule(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_email) REFERENCES Doctor(email) ON DELETE CASCADE,
    PRIMARY KEY (sched, doctor_email)
);

CREATE TABLE DoctorViewsHistory(
    history int NOT NULL,
    doctor_email varchar(255) NOT NULL,
    FOREIGN KEY (doctor_email) REFERENCES Doctor(email) ON DELETE CASCADE,
    FOREIGN KEY (history) REFERENCES MedicalHistory(id) ON DELETE CASCADE,
    PRIMARY KEY (history, doctor_email)
);
