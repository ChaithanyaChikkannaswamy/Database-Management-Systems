USE MDUrgentCare;
GO
CREATE FUNCTION StaffTempFlags()
RETURNS TABLE
RETURN(SELECT a.StaffId, StaffName, CenterId, time, temp
FROM StaffTempCheck a JOIN StaffInfo b ON a.StaffId = b.StaffId
WHERE temp> 100
);

Select * from dbo.StaffTempFlags();


USE MDUrgentCare;
GO
CREATE FUNCTION CovidFlags()
RETURNS TABLE
RETURN(SELECT a.PatientId, PatientName, centerId, date
FROM PatientInfo a JOIN CovidTestingInfo b ON a.PatientId = b.PatientId
WHERE Result = 'Positive'
);

SELECT * from dbo.CovidFlags();
 