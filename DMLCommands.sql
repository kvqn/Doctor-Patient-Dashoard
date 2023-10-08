-- Inserting Patient Data
INSERT INTO Patient(email, password, salt, name, address, gender)
VALUES
('ram123@gmail.com','admin123', '', 'Ram', 'Tamil Nadu', 'male'),
('sham234@gmail.com','admin123', '', 'Sham', 'Karnataka', 'male'),
('rakesh@gmail.com','admin123', '', 'Rakesh', 'Gujarat', 'male');

-- Inserting Medical History Data
INSERT INTO MedicalHistory(date, conditions, surgeries, medication)
VALUES
('2018-03-23','Pain in abdomen','Heart Surgery','Crocin'),
('2019-03-23','Frequent Indigestion','none','none'),
('2020-04-23','Body Pain','none','Iodex');

-- Inserting Doctor Data
INSERT INTO Doctor(email, gender, password, salt, name)
VALUES
('sandip.doctor@gmail.com', 'male', 'admin123', '', 'Sandip Kaushik'),
('gagan.doctor@gmail.com', 'male', 'admin123', '', 'Gagan Singh');

-- Inserting Appointment Data
INSERT INTO Appointment(doctorEmail, date, starttime, endtime, status)
VALUES
('sandip.doctor@gmail.com', '2021-03-23', '2021-03-23 09:00:00', '2021-03-23 10:00:00', 'Done'),
('gagan.doctor@gmail.com', '2022-03-23', '2022-03-23 10:00:00', '2022-03-23 11:00:00', 'Done'),
('gagan.doctor@gmail.com', '2023-03-23', '2023-03-23 14:00:00', '2023-03-23 15:00:00', 'Done');

-- Inserting Patient-Appointment Data
INSERT INTO PatientsAttendAppointments(patient, appointmentId, concerns, symptoms)
VALUES
('ram123@gmail.com', 1, 'none', 'itchy throat'),
('sham234@gmail.com', 2, 'infection', 'fever'),
('rakesh@gmail.com', 3, 'nausea', 'fever');

-- Inserting Schedule Data
INSERT INTO Schedule(starttime, endtime, breaktime, day)
VALUES
('2021-03-23 09:00:00','2021-03-23 17:00:00','2021-03-23 12:00:00','Tuesday'),
('2021-03-23 09:00:00','2021-03-23 17:00:00','2021-03-23 12:00:00','Friday'),
('2021-03-23 09:00:00','2021-03-23 17:00:00','2021-03-23 12:00:00','Saturday'),
('2021-03-23 09:00:00','2021-03-23 17:00:00','2021-03-23 12:00:00','Sunday'),
('2021-03-23 09:00:00','2021-03-23 17:00:00','2021-03-23 12:00:00','Wednesday'),
('2021-03-23 09:00:00','2021-03-23 17:00:00','2021-03-23 12:00:00','Friday');

-- Associating Patients with their Medical Histories
INSERT INTO PatientMedicalHistory(patientEmail, historyId)
VALUES
('ram123@gmail.com', 4),
('sham234@gmail.com', 5),
('rakesh@gmail.com', 6);

-- Inserting Diagnoses Data
INSERT INTO Diagnoses(appointmentId, doctorEmail, diagnosis, prescription)
VALUES
(1, 'sandip.doctor@gmail.com', 'Bloating', 'Ibuprofen as needed'),
(2, 'gagan.doctor@gmail.com', 'Muscle soreness', 'Stretch morning/night'),
(3, 'gagan.doctor@gmail.com', 'Vitamin Deficiency', 'Good Diet');

-- Associating Doctors with their Schedules
INSERT INTO DocsHaveSchedules(scheduleId, doctorEmail)
VALUES
(1, 'sandip.doctor@gmail.com'),
(2, 'gagan.doctor@gmail.com');

-- Doctors viewing patients' histories
INSERT INTO DoctorViewsHistory(historyId, doctorEmail)
VALUES
(4, 'sandip.doctor@gmail.com'),
(5, 'gagan.doctor@gmail.com'),
(6, 'gagan.doctor@gmail.com');
