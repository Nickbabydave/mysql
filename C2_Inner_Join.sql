USE crownfield_eye_hospital;

SELECT
    a.appointment_id,
    p.first_name,
    p.last_name,
    a.appointment_date,
    a.status
FROM appointment AS a
INNER JOIN patient AS p
    ON a.patient_id = p.patient_id
INNER JOIN clinician AS c
    ON a.clinician_id = c.clinician_id;