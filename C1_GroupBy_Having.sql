USE crownfield_eye_hospital;

SELECT
    patient_id,
    COUNT(*) AS total_appointments
FROM appointment
GROUP BY patient_id
HAVING COUNT(*) > 1;


