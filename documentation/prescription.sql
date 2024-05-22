START TRANSACTION;

-- Insertion de la prescription
INSERT INTO prescriptions (patient_id, doctor_id, start_date, end_date)
VALUES (1, 2, '2023-05-22', '2023-06-22');

-- Récupération de l'ID de la prescription insérée
SET @prescription_id = LAST_INSERT_ID();

-- Insertion des médicaments liés à la prescription
INSERT INTO prescription_drugs (prescription_id, drug, dosage)
VALUES 
(@prescription_id, 'Aspirin', '100mg'),
(@prescription_id, 'Ibuprofen', '200mg');

-- Validation de la transaction
COMMIT;
