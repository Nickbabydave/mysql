TablesTablesTablesTablesCREATE DATABASE IF NOT EXISTS crownfield_eye_hospital;
use crownfield_eye_hospital;
SELECT DATABASE();
create table Speciality (
specialty_id INT AUTO_INCREMENT PRIMARY KEY,
specialty_name VARCHAR(60) NOT NULL UNIQUE);
SELECT *FROM Speciality;
SHOW TABLES;
CREATE TABLE patient(
patient_id VARCHAR(10) PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
postcode VARCHAR(10) NOT NULL,
date_of_birth DATE,
phone VARCHAR(20),
email VARCHAR(100) UNIQUE, 
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
SELECT * FROM patient;
CREATE TABLE clinician(
clinician_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
specialty_id INT NOT NULL,
email VARCHAR(100) UNIQUE,

CONSTRAINT fk_clinician_specialty
FOREIGN KEY (specialty_id)
REFERENCES speciality(specialty_id)
);
SHOW TABLES;
CREATE TABLE clinic(
clinic_id INT AUTO_INCREMENT PRIMARY KEY,
clinic_name VARCHAR(80) NOT NULL UNIQUE,
address VARCHAR(150)
);
SHOW TABLES;
CREATE TABLE appointment (
appointment_id INT AUTO_INCREMENT PRIMARY KEY,
appointment_time TIME NOT NULL,
notes VARCHAR(255),
status VARCHAR(20) not null default "Scheduled",

CONSTRAINT chk_appoinment_status
CHECK (status IN (
"Scheduled",
"Completed",
"Cancelled",
"Did not Attend"
)));
SHOW TABLES;

DESCRIBE appointment;
ALTER TABLE appointment
ADD COLUMN patient_id VARCHAR(10),
ADD COLUMN clinician_id INT,
ADD COLUMN clinic_id INT;

DESCRIBE appointment;

ALTER TABLE appointment
ADD CONSTRAINT fk_appointment_patient
FOREIGN KEY (patient_id)
REFERENCES patient(patient_id);

ALTER TABLE appointment
ADD CONSTRAINT fk_appointment_clinician
FOREIGN KEY (clinician_id)
REFERENCES clinician(clinician_id);

DESCRIBE appointment;

ALTER TABLE appointment
ADD COLUMN appointment_date DATE NOT NULL
AFTER appointment_id;

DESCRIBE appointment;

ALTER TABLE appointment
ADD CONSTRAINT fk_appointment_clinic
FOREIGN KEY (clinic_id)
REFERENCES clinic(clinic_id);

CREATE TABLE diagnosis (
    diagnosis_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    diagnosis_name VARCHAR(100) NOT NULL,
    diagnosis_notes VARCHAR(255),

    CONSTRAINT fk_diagnosis_appointment
    FOREIGN KEY (appointment_id)
    REFERENCES appointment(appointment_id)
    ON DELETE CASCADE
);
DESCRIBE diagnosis;

CREATE TABLE medicine (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_name VARCHAR(100) NOT NULL UNIQUE
);
DESCRIBE medicine;

CREATE TABLE prescription (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    prescription_date DATE NOT NULL,

    CONSTRAINT fk_prescription_appointment
    FOREIGN KEY (appointment_id)
    REFERENCES appointment(appointment_id)
    ON DELETE CASCADE
);
DESCRIBE prescription;

CREATE TABLE prescription_item (
    prescription_item_id INT AUTO_INCREMENT PRIMARY KEY,
    prescription_id INT NOT NULL,
    medicine_id INT NOT NULL,
    dosage VARCHAR(100) NOT NULL,
    frequency VARCHAR(100) NOT NULL,
    duration_days INT NOT NULL,

    CONSTRAINT fk_item_prescription
    FOREIGN KEY (prescription_id)
    REFERENCES prescription(prescription_id)
    ON DELETE CASCADE,

    CONSTRAINT fk_item_medicine
    FOREIGN KEY (medicine_id)
    REFERENCES medicine(medicine_id)
);
DESCRIBE prescription_item;

CREATE TABLE follow_up (
    follow_up_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    follow_up_date DATE NOT NULL,
    priority VARCHAR(20) NOT NULL DEFAULT 'Pending',
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',

    CONSTRAINT fk_follow_up_appointment
    FOREIGN KEY (appointment_id)
    REFERENCES appointment(appointment_id)
    ON DELETE CASCADE
);
DESCRIBE follow_up;

SHOW TABLES;

SELECT * FROM 	PATIENT;

SHOW CREATE TABLE appointment;

SHOW TABLES;

SHOW TABLES;
SELECT * FROM patient;


INSERT INTO Speciality (specialty_name)
VALUES
('Glaucoma'),
('Retina'),
('Cornea'),
('Cataract'),
('Paediatric Ophthalmology'),
('Neuro-Ophthalmology'),
('Oculoplastics'),
('General Ophthalmology'),
('Uveitis'),
('Medical Retina');

SELECT * FROM Speciality;

SELECT * FROM clinician;

DESCRIBE clinician;


INSERT INTO clinician
(first_name, last_name, specialty_id, email)
VALUES
('Maya', 'Shah', 1, 'maya.shah@crownfield.test'),
('Leo', 'Grant', 2, 'leo.grant@crownfield.test'),
('Priya', 'Nair', 3, 'priya.nair@crownfield.test'),
('James', 'Collins', 4, 'james.collins@crownfield.test'),
('Sarah', 'Ahmed', 5, 'sarah.ahmed@crownfield.test'),
('Peter', 'Wong', 6, 'peter.wong@crownfield.test'),
('Helen', 'Brooks', 7, 'helen.brooks@crownfield.test'),
('David', 'Okafor', 8, 'david.okafor@crownfield.test'),
('Nina', 'Patel', 9, 'nina.patel@crownfield.test'),
('Grace', 'Morgan', 10, 'grace.morgan@crownfield.test');



INSERT INTO clinic (clinic_name, address)
VALUES
('City Road', '12 City Road'),
('Bedford', '5 Bedford Street'),
('Croydon', '18 High Street'),
('North Wing', 'Crownfield Hospital North Wing'),
('South Wing', 'Crownfield Hospital South Wing'),
('Retina Centre', '22 Medical Avenue'),
('Glaucoma Suite', '14 Vision Lane'),
('Cornea Unit', '7 Eye Care Road'),
('Paediatric Clinic', '10 Children Way'),
('Urgent Eye Clinic', '1 Emergency Road');


INSERT INTO patient
(patient_id, first_name, last_name, postcode, date_of_birth, phone, email)
VALUES
('OP001','Amina','Yusuf','NE1 4AB','1981-03-15','07000000001','amina.yusuf@example.test'),
('OP002','Daniel','Reed','N16 7QP','1975-09-21','07000000002','daniel.reed@example.test'),
('OP003','Sofia','Bennett','E8 2LD','1990-06-12','07000000003','sofia.bennett@example.test'),
('OP004','Michael','Okoro','SE6 3RT','1986-11-02','07000000004','michael.okoro@example.test'),
('OP005','Grace','Taylor','B1 2AA','1968-01-28','07000000005','grace.taylor@example.test'),
('OP006','Ahmed','Khan','M1 4QT','1959-05-13','07000000006','ahmed.khan@example.test'),
('OP007','Lucy','Brown','LS1 3AF','2001-08-19','07000000007','lucy.brown@example.test'),
('OP008','Samuel','Green','S2 4BB','1984-04-08','07000000008','samuel.green@example.test'),
('OP009','Chloe','Wilson','CV1 5RT','1994-12-11','07000000009','chloe.wilson@example.test'),
('OP010','David','Mensah','NG1 1AB','1979-07-30','07000000010','david.mensah@example.test');



INSERT INTO appointment
(patient_id, clinician_id, clinic_id, appointment_date, appointment_time, notes, status)
VALUES
('OP001',2,1,'2026-10-05','09:00:00','Review IOP','Completed'),
('OP002',3,1,'2026-10-05','09:30:00','OCT before review','Completed'),
('OP001',2,2,'2026-11-16','10:15:00','Visual field test','Scheduled'),
('OP003',2,1,'2026-10-06','11:00:00','Monitor','Completed'),
('OP004',4,3,'2026-10-07','14:00:00','Corneal topography','Completed'),
('OP005',5,4,'2026-10-08','09:00:00','Cataract assessment','Completed'),
('OP006',9,5,'2026-10-09','11:30:00','General eye review','Completed'),
('OP007',6,9,'2026-10-10','10:00:00','Paediatric review','Completed'),
('OP008',3,6,'2026-10-11','13:00:00','Retina review','Completed'),
('OP009',10,4,'2026-10-12','15:30:00','Inflammation review','Completed'),
('OP010',7,1,'2026-10-13','10:30:00','Neurological visual assessment','Scheduled');



SELECT clinician_id, first_name, last_name
FROM clinician
ORDER BY clinician_id;

SELECT appointment_id, patient_id, clinician_id
FROM appointment
ORDER BY appointment_id;

SELECT * FROM diagnosis;


INSERT INTO diagnosis
(appointment_id, diagnosis_name, diagnosis_notes)
VALUES
(12,'Ocular hypertension','Raised intraocular pressure'),
(13,'Diabetic macular oedema','OCT changes noted'),
(15,'Glaucoma suspect','Observation required'),
(16,'Keratoconus','Corneal thinning confirmed'),
(17,'Cataract','Reduced lens clarity'),
(18,'Dry eye syndrome','Moderate symptoms'),
(19,'Amblyopia','Reduced visual acuity'),
(20,'Retinal vein occlusion','Retinal swelling'),
(21,'Anterior uveitis','Inflammation present'),
(22,'Optic neuritis','Further investigation required');


INSERT INTO medicine (medicine_name)
VALUES
('Latanoprost'),
('Timolol'),
('Aflibercept'),
('Sodium chloride drops'),
('Prednisolone eye drops'),
('Artificial tears'),
('Cyclopentolate'),
('Dorzolamide'),
('Moxifloxacin'),
('Acetazolamide');


INSERT INTO prescription
(appointment_id, prescription_date)
VALUES
(12,'2026-10-05'),
(13,'2026-10-05'),
(15,'2026-10-06'),
(16,'2026-10-07'),
(17,'2026-10-08'),
(18,'2026-10-09'),
(19,'2026-10-10'),
(20,'2026-10-11'),
(21,'2026-10-12'),
(22,'2026-10-13');

SELECT prescription_id, appointment_id
FROM prescription
ORDER BY prescription_id;


INSERT INTO prescription_item
(prescription_id, medicine_id, dosage, frequency, duration_days)
VALUES
(1,1,'1 drop - Ocular','Once daily',30),
(1,2,'1 drop - Ocular','Twice daily',30),
(2,3,'2 mg - Intravitreal','Single dose',1),
(3,8,'1 drop - Ocular','Twice daily',30),
(4,4,'1 drop - Ocular','Four times daily',14),
(5,9,'1 drop - Ocular','Four times daily',7),
(6,6,'1 drop - Ocular','As required',30),
(7,7,'1 drop - Ocular','Twice daily',7),
(8,3,'2 mg - Intravitreal','Single dose',1),
(9,5,'1 drop - Ocular','Four times daily',14),
(10,10,'250 mg - Oral','Twice daily',5);


INSERT INTO follow_up
(appointment_id, follow_up_date, priority, status)
VALUES
(12,'2026-11-16','High','Booked'),
(13,'2026-11-02','Urgent','Booked'),
(15,'2027-04-06','Routine','Pending'),
(16,'2026-12-02','Routine','Pending'),
(17,'2026-12-03','Routine','Pending'),
(18,'2026-11-20','Routine','Pending'),
(19,'2026-12-01','High','Pending'),
(20,'2026-11-08','Urgent','Pending'),
(21,'2026-10-26','High','Pending'),
(22,'2026-11-10','High','Pending');


SELECT 'speciality' AS table_name, COUNT(*) AS total FROM speciality
UNION ALL
SELECT 'clinician', COUNT(*) FROM clinician
UNION ALL
SELECT 'clinic', COUNT(*) FROM clinic
UNION ALL
SELECT 'patient', COUNT(*) FROM patient
UNION ALL
SELECT 'appointment', COUNT(*) FROM appointment
UNION ALL
SELECT 'diagnosis', COUNT(*) FROM diagnosis
UNION ALL
SELECT 'medicine', COUNT(*) FROM medicine
UNION ALL
SELECT 'prescription', COUNT(*) FROM prescription
UNION ALL
SELECT 'prescription_item', COUNT(*) FROM prescription_item
UNION ALL
SELECT 'follow_up', COUNT(*) FROM follow_up;


SELECT *
FROM follow_up
WHERE follow_up_id = 1;


UPDATE follow_up
SET status = 'Completed'
WHERE follow_up_id = 1;


SELECT *
FROM follow_up
WHERE follow_up_id = 1;


INSERT INTO patient
(patient_id, first_name, last_name, postcode)
VALUES
('TEST01', 'Test', 'Patient', 'ZZ1 1ZZ');


SELECT *
FROM patient
WHERE patient_id = 'TEST01';


DELETE FROM patient
WHERE patient_id = 'TEST01';

SELECT *
FROM patient
WHERE patient_id = 'TEST01';