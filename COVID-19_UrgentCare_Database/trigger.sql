USE MDUrgentCare;
GO
CREATE TRIGGER new_patients ON PatientInfo
AFTER INSERT
AS
BEGIN 
PRINT 'A new Patient has been added to the database';
END;SET IDENTITY_INSERT PatientInfo ONINSERT PatientInfo (PatientId, PatientName, DOB, Address, PhoneNo, PatientPrimaryDoctorId) VALUES
(7111,'Jackie','02/17/2001','402 University Ave','4435353320',442)
SET IDENTITY_INSERT PatientInfo OFF
GO

USE MDUrgentCare;
GO
CREATE TRIGGER stock ON MedicationInventory
AFTER INSERT, UPDATE
AS
BEGIN 
PRINT 'Stock Updated';
END;

UPDATE MedicationInventory 
SET InStockQuantity = 500, OrderedQuantity = 1900
WHERE CenterId = 1 AND MedId = 4281;