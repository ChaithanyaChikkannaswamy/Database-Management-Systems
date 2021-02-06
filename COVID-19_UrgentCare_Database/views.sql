USE MDUrgentCare;
GO
CREATE VIEW PatientInsuranceVerification
AS
SELECT a.PatientId as ID, a.PatientName as Name, a.Address as address, b.InsuranceNo as InsuranceNo, b.InsuranceCompany as Company, b.PhoneNo as InsurancePhone
FROM PatientInfo a JOIN PatientInsuranceInfo b ON
a.PatientId = b.PatientId;

SELECT * from PatientInsuranceVerification;

USE MDUrgentCare;
GO
CREATE VIEW RegionStaffing
AS
SELECT a.RegionName, sum(c.NoOfPhysicians) as TotalPhysicians, sum(c.NoOfStaff) as TotalStaff
FROM Region a JOIN CenterInfo b on a.RegionId = b.RegionId JOIN CenterFacilities c on b.CenterId = c.CenterId
GROUP BY a.RegionName

SELECT * from RegionStaffing;

USE MDUrgentCare;
GO
CREATE VIEW StaffTempReport
AS
SELECT a.CenterName, count(CASE WHEN b.temp < 100 THEN 1 END) as normalscans, count(CASE WHEN b.temp > 100 THEN 1 END) as NeedForConcern
FROM CenterInfo a JOIN StaffInfo c on a.CenterId = c.CenterId JOIN StaffTempCheck b on b.StaffId = c.StaffId 
GROUP BY a.CenterName

SELECT * from StaffTempReport;

USE MDUrgentCare;
GO
CREATE VIEW CovidTestingData
AS
SELECT a.RegionName, count(*) as NumberOfTests, sum(CASE WHEN c.Result = 'Positive' THEN 1 END) as PeopleCovidPositive, sum(CASE WHEN c.Result != 'Positive' THEN 1 END) as PeopleCovidNegative
FROM Region a JOIN CenterInfo b on a.RegionId = b.RegionId JOIN CovidTestingInfo c on b.CenterId = c.CenterId
GROUP BY a.RegionName

SELECT * from CovidTestingData;
