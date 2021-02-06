USE MDUrgentCare;
GO
CREATE Procedure StaffRegionwise @RegionName VARCHAR(50) = NULL
AS
IF @RegionName != 'NorthEast' AND @RegionName != 'South' AND @RegionName != 'Midwest' AND @RegionName != 'West'
PRINT 'Enter the correct region (NorthEast, South, Midwest, West)'ELSE
SELECT StaffId,StaffName,CenterName, PhoneNo
FROM StaffInfo a JOIN CenterInfo b on a.CenterId = b.CenterId
WHERE RegionId = (Select RegionId from Region WHERE RegionName = @RegionName);

EXEC StaffRegionwise @RegionName='South';

USE MDUrgentCare;
GO
CREATE Procedure RegionCovidTestingResults @RegionName VARCHAR(50) = NULL
AS
IF @RegionName != 'NorthEast' AND @RegionName != 'South' AND @RegionName != 'Midwest' AND @RegionName != 'West'
PRINT 'Enter the correct region (NorthEast, South, Midwest, West)'ELSE
SELECT count(*) as NumberOfTests, sum(CASE WHEN c.Result = 'Positive' THEN 1 END) as PeopleCovidPositive, sum(CASE WHEN c.Result != 'Positive' THEN 1 END) as PeopleCovidNegative
FROM Region a JOIN CenterInfo b on a.RegionId = b.RegionId JOIN CovidTestingInfo c on b.CenterId = c.CenterId
WHERE RegionName = @RegionName;

EXEC RegionCovidTestingResults @RegionName = 'South';