USE crownfield_eye_hospital;

SELECT
    a.appointment_id,
    a.patient_id,
    a.status,
    d.diagnosis_id
FROM appointment AS a
LEFT JOIN diagnosis AS d
    ON a.appointment_id = d.appointment_id
WHERE d.diagnosis_id IS NULL;