USE crownfield_eye_hospital;

SELECT patient_id, first_name, last_name
FROM patient
WHERE patient_id IN (
    SELECT patient_id
    FROM appointment
    GROUP BY patient_id
    HAVING COUNT(*) > 1
);