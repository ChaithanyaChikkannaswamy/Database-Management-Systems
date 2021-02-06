CREATE DATABASE UrgentCare;
--Table creation

CREATE TABLE Region (
RegionId int IDENTITY(1,1),
RegionName varchar(255)  NOT NULL,
RegionDescription varchar(255) NOT NULL,
PRIMARY KEY(RegionId)
);

CREATE TABLE CenterInfo (
CenterId int IDENTITY(1,1),
CenterName varchar(255)  NOT NULL,
RegionId  int FOREIGN KEY REFERENCES Region(RegionId),
Address varchar(255) NOT NULL,
City varchar(255) NOT NULL,
State varchar(255) NOT NULL,
ZipCode varchar(255) NOT NULL,
StartTime smalldatetime  NOT NULL,
EndTime smalldatetime NOT NULL,
PRIMARY KEY(CenterId)
);
--

CREATE TABLE CenterFacilities (
CenterId int FOREIGN KEY REFERENCES CenterInfo(CenterId),
Capacity int NOT NULL,
NoOfPhysicians int NOT NULL,
NoOfStaff int NOT NULL,
NoOfCovidTestsPerDay int NOT NULL
);

CREATE TABLE StaffInfo (
StaffId int IDENTITY(1,1) ,
CenterId int FOREIGN KEY REFERENCES CenterInfo(CenterId),
StaffName varchar(255) NOT NULL,
DOB date NOT NULL,
Address varchar(255) NOT Null,
PhoneNo varchar(14),
PRIMARY KEY(StaffId)
);
-

CREATE TABLE StaffConfidential (
StaffId int FOREIGN KEY REFERENCES StaffInfo(StaffId),
SSN varchar(10)  NOT NULL,
Salary int NOT NULL
);

CREATE TABLE StaffTempCheck (
StaffId int FOREIGN KEY REFERENCES StaffInfo(StaffId),
time datetime NOT NULL,
temp varchar(5) NOT NULL
);

CREATE TABLE PatientInfo (
PatientId int IDENTITY(1,1),
PatientName varchar(50) NOT NULL,
DOB date NOT NULL,
Address varchar(255) NOT NULL,
Email varchar(50) NOT NULL,
PhoneNo int,
PatientPrimaryDoctor int FOREIGN KEY REFERENCES StaffInfo(StaffId),
PRIMARY KEY(PatientId)
);

CREATE TABLE PatientInsuranceInfo (
PatientId int FOREIGN KEY REFERENCES PatientInfo(PatientId) ,
InsuranceNo varchar(15) NOT NULL,
InsuranceCompany varchar(100) NOT NULL,
PhoneNo int,
ContactInformation varchar(255) NOT NULL,
InsuranceCoverage varchar(255) NOT NULL
);

CREATE TABLE PatientHistory (
PatientId int FOREIGN KEY REFERENCES PatientInfo(PatientId),
WeightInLb int  NOT NULL,
heightInCm int NOT NULL,
PreExistingConditions varchar(255)
);



CREATE TABLE PatientAtCenter (
PatientId int FOREIGN KEY REFERENCES PatientInfo(PatientId),
CheckIn datetime NOT NULL,
CheckOut datetime,
Symptoms varchar(250) NOT NULL,
Diagnosis varchar(250),
PhysicianAttendingId int FOREIGN KEY REFERENCES StaffInfo(StaffId)
);


CREATE TABLE TestingInfo (
TestId int IDENTITY(1,1),
TestDescription varchar(255) NOT NULL,
Cost money NOT NULL,
PRIMARY KEY(TestId)
);



CREATE TABLE TestsAdministered (
CenterId int FOREIGN KEY REFERENCES CenterInfo(CenterId),
testId int FOREIGN KEY REFERENCES TestingInfo(TestId),
PatientId int FOREIGN KEY REFERENCES PatientInfo(PatientId),
Date date NOT NULL
);



CREATE TABLE MedicationInfo (
MedId int IDENTITY(1,1),
Name varchar(255)  NOT NULL,
Cost money NOT NULL,
PRIMARY KEY(MedId)
);


CREATE TABLE MedicationInventory (
CenterId int FOREIGN KEY REFERENCES CenterInfo(CenterId),
MedId int FOREIGN KEY REFERENCES MedicationInfo(MedId),
InStockQuantity int NOT NULL,
OrderedQuantity int
PRIMARY KEY(CenterId,MedId)
);


CREATE TABLE PatientBillingInfo (
CenterId int FOREIGN KEY REFERENCES CenterInfo(CenterId),
PatientId int FOREIGN KEY REFERENCES PatientInfo(PatientId),
ConsultationCost money NOT NULL,
TestingCosts money,
MedicationCosts money,
AmountPaid money,
TotalAmountDue money NOT NULL,
Payor varchar(50),
);

CREATE TABLE CovidTestingInfo (
CenterId int FOREIGN KEY REFERENCES CenterInfo(CenterId),
PatientId int FOREIGN KEY REFERENCES PatientInfo(PatientId),
Date date NOT NULL,
Symptoms varchar(50),
Result varchar(50)
);
GO;