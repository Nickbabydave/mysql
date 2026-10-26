USE crownfield_eye_hospital;

DELIMITER $$

CREATE PROCEDURE GetPatientAppointments(
    IN p_patient_id VARCHAR(10)
)
BEGIN
    SELECT
        appointment_id,
        patient_id,
        appointment_date,
        appointment_time,
        status
    FROM appointment
    WHERE patient_id = p_patient_id
    ORDER BY appointment_date;
END$$

DELIMITER ;

CREATE TRIGGER crownfield_eye_hospital.trg_check_appointment_status
BEFORE INSERT ON crownfield_eye_hospital.appointment
FOR EACH ROW
SET NEW.status = CASE
    WHEN NEW.status IN ('Scheduled', 'Completed', 'Cancelled', 'Did not Attend')
    THEN NEW.status
    ELSE NULL
END;