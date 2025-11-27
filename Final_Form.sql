-- Create the database
CREATE DATABASE Voting_Management_System;
GO

USE Voting_Management_System;
GO

-- Create tables
CREATE TABLE Address (
  DistrictID INTEGER NOT NULL PRIMARY KEY,
  Locality VARCHAR(30) NOT NULL,
  City VARCHAR(30) NOT NULL,
  State VARCHAR(30) NOT NULL,
  Zip VARCHAR(10) NOT NULL
);

CREATE TABLE Voter (
  CNIC CHAR(15) NOT NULL PRIMARY KEY,
  FirstName VARCHAR(30) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  MotherName VARCHAR(30),
  FatherName VARCHAR(30),
  Sex CHAR(7) NOT NULL,
  Birthday DATE NOT NULL,
  Phone NUMERIC NOT NULL,
  DistrictID INTEGER NOT NULL REFERENCES Address(DistrictID)
);

CREATE TABLE Candidate_Type (
  CandidateTypeID INT NOT NULL PRIMARY KEY,
  CandidateType VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Election (
  ElectionID INT NOT NULL PRIMARY KEY,
  ElectionType VARCHAR(20) NOT NULL
);

CREATE TABLE Party (
  PartyID INT NOT NULL PRIMARY KEY,
  PartyName VARCHAR(20) NOT NULL UNIQUE,
  Symbol VARCHAR(20) NOT NULL UNIQUE,
  PartyLeader VARCHAR(50) NOT NULL
);

CREATE TABLE User_Type (
  UserTypeID INT NOT NULL PRIMARY KEY,
  UserType VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Candidate (
  CandidateID INT NOT NULL PRIMARY KEY,
  CNIC CHAR(15) NOT NULL REFERENCES Voter(CNIC),
  CandidateTypeID INT NOT NULL REFERENCES Candidate_Type(CandidateTypeID),
  PartyID INT NOT NULL REFERENCES Party(PartyID),
  ElectionID INT NOT NULL REFERENCES Election(ElectionID),
  DistrictID INT NOT NULL REFERENCES Address(DistrictID)
);

CREATE TABLE UserAccount (
  VoterID VARCHAR(10) NOT NULL PRIMARY KEY,
  Def_Password VARCHAR(50) NOT NULL,
  IsActive BIT NOT NULL,
  CNIC CHAR(15) NOT NULL REFERENCES Voter(CNIC),
  UserTypeID INT NOT NULL REFERENCES User_Type(UserTypeID)
);

CREATE TABLE Vote (
  VoteID VARCHAR(7) NOT NULL PRIMARY KEY,
  VoterID VARCHAR(10) NOT NULL UNIQUE REFERENCES UserAccount(VoterID),
  PartyID INT NOT NULL REFERENCES Party(PartyID),
  CandidateID INT NOT NULL REFERENCES Candidate(CandidateID),
  DistrictID INT NOT NULL REFERENCES Address(DistrictID),
  Def_Password VARCHAR(50) NOT NULL,
  PasswordEntered VARCHAR(50) NOT NULL,
  CHECK (Def_Password = PasswordEntered)
);

CREATE TABLE Result (
  ResultID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  CandidateID INT NOT NULL REFERENCES Candidate(CandidateID),
  PartyID INT NOT NULL REFERENCES Party(PartyID),
  DistrictID INT NOT NULL REFERENCES Address(DistrictID),
  Vote_Count INT NOT NULL
);

-- Insertion in Tables:
-- User Types
INSERT INTO User_Type (UserTypeID, UserType) VALUES 
(1, 'Voter'),
(2, 'Admin');

-- Candidate Types
INSERT INTO Candidate_Type (CandidateTypeID, CandidateType) VALUES 
(100, 'National'),
(101, 'Provincial');

-- Election Types
INSERT INTO Election (ElectionID, ElectionType) VALUES 
(200, 'General'),
(201, 'By-Election');

-- Political Parties
INSERT INTO Party (PartyID, PartyName, Symbol, PartyLeader) VALUES 
(11, 'PTI', 'Bat', 'Imran Khan'),
(12, 'PMLN', 'Lion', 'Nawaz Sharif'),
(13, 'PPP', 'Arrow', 'Bilawal Bhutto'),
(14, 'MQM', 'Kite', 'Altaf Hussain'),
(15, 'JUI', 'Book', 'Fazlur Rehman');

-- Insert Address data
INSERT INTO Address (DistrictID, Locality, City, State, Zip) VALUES
(234, 'Model Town', 'Lahore', 'Punjab', '54000'),
(235, 'Clifton', 'Karachi', 'Sindh', '75600'),
(261, 'Zamzama', 'Karachi', 'Sindh', '75000'),
(262, 'F-8', 'Islamabad', 'Capital Territory', '44010'),
(263, 'E-11', 'Islamabad', 'Capital Territory', '44020'),
(264, 'Gulshan-e-Iqbal', 'Karachi', 'Sindh', '75300'),
(265, 'H-9', 'Islamabad', 'Capital Territory', '44030'),
(266, 'Khalid Market', 'Lahore', 'Punjab', '54010'),
(267, 'Iqbal Town', 'Lahore', 'Punjab', '54050'),
(268, 'Bahria Town', 'Islamabad', 'Capital Territory', '44060'),
(269, 'Bakeri Road', 'Karachi', 'Sindh', '74600'),
(270, 'Defence Road', 'Lahore', 'Punjab', '54320'),
(271, 'Rawat', 'Rawalpindi', 'Punjab', '47010'),
(272, 'Park Road', 'Islamabad', 'Capital Territory', '44070'),
(273, 'Saddar Bazar', 'Peshawar', 'Khyber Pakhtunkhwa', '25110'),
(274, 'Sargodha Road', 'Faisalabad', 'Punjab', '38060'),
(275, 'Shahrah-e-Faisal', 'Karachi', 'Sindh', '74800'),
(276, 'Cantt. Rawalpindi', 'Rawalpindi', 'Punjab', '46050'),
(277, 'Azizabad', 'Karachi', 'Sindh', '74500'),
(278, 'Zia Colony', 'Faisalabad', 'Punjab', '38070'),
(279, 'Gulberg', 'Lahore', 'Punjab', '54060'),
(280, 'North Nazimabad', 'Karachi', 'Sindh', '74700'),
(281, 'Faisalabad Road', 'Lahore', 'Punjab', '54080'),
(282, 'G-10', 'Islamabad', 'Capital Territory', '44090'),
(283, 'Saddar', 'Karachi', 'Sindh', '74610'),
(284, 'Bahria Enclave', 'Islamabad', 'Capital Territory', '44100'),
(285, 'DHA Phase 5', 'Karachi', 'Sindh', '75610'),
(286, 'Gulshan-e-Jamal', 'Karachi', 'Sindh', '75310'),
(287, 'Wah Cantt', 'Wah', 'Punjab', '47020'),
(288, 'Mardan', 'Mardan', 'Khyber Pakhtunkhwa', '25120'),
(289, 'Sukkur', 'Sukkur', 'Sindh', '65200'),
(290, 'Multan', 'Multan', 'Punjab', '60000');

-- Insert Voter data 
INSERT INTO Voter (CNIC, FirstName, LastName, MotherName, FatherName, Sex, Birthday, Phone, DistrictID) VALUES
('3520-1345-9877', 'Hassan', 'Ali', 'Amna', 'Shahzad', 'Male', '1986-02-14', '03212223456', 234),
('4210-7895-2346', 'Muneeb', 'Iqbal', 'Ayesha', 'Khan', 'Male', '1991-11-30', '03317654322', 235),
('3310-8855-6678', 'Sara', 'Mujtaba', 'Rubina', 'Akram', 'Female', '1988-05-12', '03412345679', 234),
('4310-5555-3345', 'Tariq', 'Mehmood', 'Sadia', 'Jamil', 'Male', '1992-03-08', '03215678902', 235),
('3120-9087-1123', 'Kamran', 'Raza', 'Nadia', 'Ilyas', 'Male', '1984-07-24', '03461231235', 234),
('4200-5674-3342', 'Sana', 'Iftikhar', 'Amina', 'Shah', 'Female', '1990-09-10', '03124561279', 235),
('3321-5445-9989', 'Usman', 'Nashit', 'Asma', 'Shahid', 'Male', '1995-08-02', '03161238946', 234),
('3412-6754-9989', 'Raza', 'Gulzar', 'Shehla', 'Ali', 'Male', '1993-06-14', '03331554790', 235),
('3564-8392-1291', 'Madiha', 'Ali', 'Sarah', 'Khan', 'Female', '1991-12-11', '03471239877', 234),
('4219-9874-6453', 'Sami', 'Rehman', 'Kiran', 'Akram', 'Male', '1987-04-18', '03151230099',  235),
('4532-7654-1235', 'Zahra', 'Bukhari', 'Sumaira', 'Hussain', 'Female', '1990-11-06', '03215879236', 234),
('5678-3211-8766', 'Adeel', 'Zafar', 'Saba', 'Ishaq', 'Male', '1986-01-30', '03321234568', 235),
('6789-2345-1123', 'Raheel', 'Nawaz', 'Jameela', 'Shahzad', 'Male', '1988-08-13', '03434567891', 234),
('7890-5678-9013', 'Mariam', 'Saeed', 'Nida', 'Tariq', 'Female', '1994-05-23', '03134567891', 235),
('8901-2345-6790', 'Asim', 'Raza', 'Lubna', 'Shahzad', 'Male', '1987-02-14', '03256789013', 234),
('9012-3456-7891', 'Nazia', 'Shah', 'Anusha', 'Ahmed', 'Female', '1991-09-03', '03341234568', 235),
('1122-2334-4456', 'Bilal', 'Khan', 'Rashida', 'Anwar', 'Male', '1993-12-21', '03412345680', 234),
('2233-4455-6678', 'Faisal', 'Shah', 'Saba', 'Amir', 'Male', '1986-06-25', '03234567891', 235),
('3321-5445-9990', 'Nida', 'Iqbal', 'Hira', 'Khan', 'Female', '1990-10-11', '03161238947', 234),
('4422-5566-7788', 'Ahmed', 'Raza', 'Farida', 'Kamal', 'Male', '1989-07-19', '03331234567', 235),
('1234-5678-9012', 'Ali', 'Khan', 'Fatima', 'Hussain', 'Male', '1995-01-01', '03234567892', 234),
('2345-6789-0123', 'Zain', 'Ali', 'Nadia', 'Shah', 'Male', '1992-02-02', '03345678901', 235),
('3456-7890-1234', 'Hira', 'Khan', 'Sadia', 'Ali', 'Female', '1994-03-03', '03456789012', 234),
('4567-8901-2345', 'Omer', 'Raza', 'Ayesha', 'Khan', 'Male', '1988-04-04', '03123456789', 235),
('5678-9012-3456', 'Sadia', 'Ali', 'Nida', 'Shah', 'Female', '1990-05-05', '03467890123', 234),
('6789-0123-4567', 'Tariq', 'Mehmood', 'Sana', 'Khan', 'Male', '1985-06-06', '03234567890', 235),
('7890-1234-5678', 'Ayesha', 'Khan', 'Fatima', 'Ali', 'Female', '1993-07-07', '03345678902', 234),
('8901-2345-6789', 'Bilal', 'Khan', 'Nadia', 'Shah', 'Male', '1991-08-08', '03123456788', 235),
('9012-3456-7890', 'Nida', 'Iqbal', 'Hira', 'Khan', 'Female', '1992-09-09', '03456789011', 234);

-- Insert User data - Fixed to only use CNICs that exist in the Voter table
INSERT INTO UserAccount (VoterID, Def_Password, IsActive, CNIC, UserTypeID) VALUES
('V119', 'password000', 1, '3520-1345-9877', 1),
('V120', 'password111', 1, '4210-7895-2346', 1),
('V121', 'password222', 1, '3310-8855-6678', 1),
('V122', 'password333', 1, '4310-5555-3345', 1),
('V123', 'password444', 1, '3120-9087-1123', 1),
('V124', 'password555', 1, '4200-5674-3342', 1),
('V125', 'password666', 1, '3321-5445-9989', 1),
('V126', 'password777', 1, '3412-6754-9989', 1),
('V127', 'password888', 1, '3564-8392-1291', 1),
('V128', 'password999', 1, '4219-9874-6453', 1),
('V129', 'password0001', 1, '4532-7654-1235', 1),
('V130', 'password1111', 1, '5678-3211-8766', 1),
('V131', 'password2222', 1, '6789-2345-1123', 1),
('V132', 'password3333', 1, '7890-5678-9013', 1),
('V133', 'password4444', 1, '8901-2345-6790', 1),
('V134', 'password5555', 1, '9012-3456-7891', 1),
('V135', 'password6666', 1, '1122-2334-4456', 1),
('V136', 'password7777', 1, '2233-4455-6678', 1),
('V137', 'password8888', 1, '3321-5445-9990', 1),
('A100', 'admin123', 1, '4422-5566-7788', 2),
('V138', 'password9999', 1, '1234-5678-9012', 1),
('V139', 'password1010', 1, '2345-6789-0123', 1),
('V140', 'password2020', 1, '3456-7890-1234', 1),
('V141', 'password3030', 1, '4567-8901-2345', 1),
('V142', 'password4040', 1, '5678-9012-3456', 1),
('V143', 'password5050', 1, '6789-0123-4567', 1),
('V144', 'password6060', 1, '7890-1234-5678', 1),
('V145', 'password7070', 1, '8901-2345-6789', 1),
('V146', 'password8080', 1, '9012-3456-7890', 1);

-- Insert Candidate data - Fixed to only use CNICs that exist in the Voter table
INSERT INTO Candidate (CandidateID, CNIC, CandidateTypeID, PartyID, ElectionID, DistrictID) VALUES
(1005, '3520-1345-9877', 100, 11, 200, 234),
(1006, '4210-7895-2346', 101, 12, 200, 235),
(1007, '3310-8855-6678', 100, 13, 200, 234),
(1008, '4310-5555-3345', 101, 14, 200, 235),
(1009, '3120-9087-1123', 100, 11, 200, 234),
(1010, '4200-5674-3342', 101, 12, 200, 235),
(1011, '3321-5445-9989', 100, 13, 200, 234),
(1012, '3412-6754-9989', 101, 14, 200, 235),
(1013, '3564-8392-1291', 100, 11, 200, 234),
(1014, '4219-9874-6453', 101, 12, 200, 235),
(1015, '4532-7654-1235', 100, 13, 200, 234),
(1016, '5678-3211-8766', 101, 14, 200, 235),
(1017, '6789-2345-1123', 100, 11, 200, 234),
(1018, '7890-5678-9013', 101, 12, 200, 235),
(1019, '8901-2345-6790', 100, 13, 200, 234),
(1020, '9012-3456-7891', 101, 14, 200, 235),
(1021, '1122-2334-4456', 100, 11, 200, 234),
(1022, '2233-4455-6678', 101, 15, 200, 235),
(1023, '3321-5445-9990', 100, 13, 200, 234),
(1024, '4422-5566-7788', 101, 12, 200, 235),
(1025, '1234-5678-9012', 100, 11, 200, 234),
(1026, '2345-6789-0123', 101, 12, 200, 235),
(1027, '3456-7890-1234', 100, 13, 200, 234),
(1028, '4567-8901-2345', 101, 14, 200, 235),
(1029, '5678-9012-3456', 100, 11, 200, 234),
(1030, '6789-0123-4567', 101, 12, 200, 235);

-- Insert Vote data - Fixed to only use VoterIDs that exist in the UserAccount table
INSERT INTO Vote (VoteID, VoterID, PartyID, CandidateID, DistrictID, Def_Password, PasswordEntered) VALUES
('A5', 'V119', 11, 1005, 234, 'password000', 'password000'),
('A6', 'V120', 12, 1006, 235, 'password111', 'password111'),
('A7', 'V121', 13, 1007, 234, 'password222', 'password222'),
('A8', 'V122', 14, 1008, 235, 'password333', 'password333'),
('A9', 'V123', 11, 1009, 234, 'password444', 'password444'),
('A10', 'V124', 12, 1010, 235, 'password555', 'password555'),
('A11', 'V125', 13, 1011, 234, 'password666', 'password666'),
('A12', 'V126', 14, 1012, 235, 'password777', 'password777'),
('A13', 'V127', 11, 1013, 234, 'password888', 'password888'),
('A14', 'V128', 12, 1014, 235, 'password999', 'password999'),
('A15', 'V129', 13, 1015, 234, 'password0001', 'password0001'),
('A16', 'V130', 14, 1016, 235, 'password1111', 'password1111'),
('A17', 'V131', 11, 1017, 234, 'password2222', 'password2222'),
('A18', 'V132', 12, 1018, 235, 'password3333', 'password3333'),
('A19', 'V133', 13, 1019, 234, 'password4444', 'password4444'),
('A20', 'V134', 14, 1020, 235, 'password5555', 'password5555'),
('A21', 'V135', 11, 1021, 234, 'password6666', 'password6666'),
('A22', 'V136', 15, 1022, 235, 'password7777', 'password7777'),
('A23', 'V137', 13, 1023, 234, 'password8888', 'password8888'),
('A24', 'A100', 12, 1024, 235, 'admin123', 'admin123'),
('A25', 'V138', 11, 1025, 234, 'password9999', 'password9999'),
('A26', 'V139', 12, 1026, 235, 'password1010', 'password1010'),
('A27', 'V140', 13, 1027, 234, 'password2020', 'password2020'),
('A28', 'V141', 14, 1028, 235, 'password3030', 'password3030'),
('A29', 'V142', 11, 1029, 234, 'password4040', 'password4040'),
('A30', 'V143', 12, 1030, 235, 'password5050', 'password5050');

-- Insert Result data
INSERT INTO Result (CandidateID, PartyID, DistrictID, Vote_Count) VALUES
(1005, 11, 234, 450),
(1006, 12, 235, 350),
(1007, 13, 234, 400),
(1008, 14, 235, 250),
(1009, 11, 234, 470),
(1010, 12, 235, 340),
(1011, 13, 234, 390),
(1012, 14, 235, 280),
(1013, 11, 234, 460),
(1014, 12, 235, 330),
(1015, 13, 234, 380),
(1016, 14, 235, 270),
(1017, 11, 234, 450),
(1018, 12, 235, 320),
(1019, 13, 234, 370),
(1020, 14, 235, 260),
(1021, 11, 234, 440),
(1022, 15, 235, 310),
(1023, 13, 234, 360),
(1024, 12, 235, 300),
(1025, 11, 234, 480),
(1026, 12, 235, 290),
(1027, 13, 234, 410),
(1028, 14, 235, 230),
(1029, 11, 234, 490),
(1030, 12, 235, 280);

--VIEWS:

-- 1. View for active voters only
CREATE VIEW ActiveVoters AS
SELECT VoterID, CNIC, IsActive
FROM UserAccount
WHERE IsActive = 1;
GO

-- 2. View for national candidates only
CREATE VIEW NationalCandidates AS
SELECT CandidateID, CNIC, PartyID, ElectionID, DistrictID
FROM Candidate
WHERE CandidateTypeID = 100;
GO

-- 3. View for provincial candidates only
CREATE VIEW ProvincialCandidates AS
SELECT CandidateID, CNIC, PartyID, ElectionID, DistrictID
FROM Candidate
WHERE CandidateTypeID = 101;
GO

-- 4. View for general election information
CREATE VIEW GeneralElections AS
SELECT ElectionID, ElectionType
FROM Election
WHERE ElectionType = 'General';
GO

-- 5. View for party symbols and leaders
CREATE VIEW PartySymbols AS
SELECT PartyID, PartyName, Symbol, PartyLeader
FROM Party;
GO

-- 6. View combining voter with their address
CREATE VIEW VoterWithAddress AS
SELECT v.CNIC, v.FirstName, v.LastName, v.Sex, v.Birthday, v.Phone,
       a.Locality, a.City, a.State, a.Zip
FROM Voter v
JOIN Address a ON v.DistrictID = a.DistrictID;
GO

-- 7. View showing user accounts with their types
CREATE VIEW UserAccountsWithTypes AS
SELECT u.VoterID, u.CNIC, u.IsActive, t.UserType
FROM UserAccount u
JOIN User_Type t ON u.UserTypeID = t.UserTypeID;
GO

-- 8. View showing candidates with their types
CREATE VIEW CandidatesWithTypes AS
SELECT c.CandidateID, c.CNIC, ct.CandidateType
FROM Candidate c
JOIN Candidate_Type ct ON c.CandidateTypeID = ct.CandidateTypeID;
GO

-- 9. View showing votes with party information
CREATE VIEW VotesWithParties AS
SELECT v.VoteID, v.VoterID, p.PartyName, p.Symbol, v.CandidateID
FROM Vote v
JOIN Party p ON v.PartyID = p.PartyID;
GO

-- 10. View showing results with party names
CREATE VIEW ResultsWithParties AS
SELECT r.ResultID, p.PartyName, r.CandidateID, r.Vote_Count
FROM Result r
JOIN Party p ON r.PartyID = p.PartyID;
GO

-- 11. View showing complete voter information with address and user account status
CREATE VIEW CompleteVoterInfo AS
SELECT v.CNIC, v.FirstName, v.LastName, v.Sex, v.Birthday, v.Phone,
       a.Locality, a.City, a.State, a.Zip,
       u.VoterID, u.IsActive
FROM Voter v
JOIN Address a ON v.DistrictID = a.DistrictID
JOIN UserAccount u ON v.CNIC = u.CNIC;
GO

-- 12. View showing candidates with their party and type information
CREATE VIEW CompleteCandidateInfo AS
SELECT c.CandidateID, c.CNIC, 
       p.PartyName, p.Symbol, p.PartyLeader,
       ct.CandidateType,
       e.ElectionType
FROM Candidate c
JOIN Party p ON c.PartyID = p.PartyID
JOIN Candidate_Type ct ON c.CandidateTypeID = ct.CandidateTypeID
JOIN Election e ON c.ElectionID = e.ElectionID;
GO

-- 13. View showing votes with voter and party information
CREATE VIEW VotesWithVoterAndParty AS
SELECT v.VoteID, 
       u.VoterID, vr.FirstName + ' ' + vr.LastName AS VoterName,
       p.PartyName, p.Symbol,
       v.CandidateID
FROM Vote v
JOIN UserAccount u ON v.VoterID = u.VoterID
JOIN Voter vr ON u.CNIC = vr.CNIC
JOIN Party p ON v.PartyID = p.PartyID;
GO

-- 14. View showing results with candidate and party information
CREATE VIEW ResultsWithCandidateAndParty AS
SELECT r.ResultID, 
       p.PartyName, p.Symbol,
       c.CandidateID, v.FirstName + ' ' + v.LastName AS CandidateName,
       r.Vote_Count
FROM Result r
JOIN Candidate c ON r.CandidateID = c.CandidateID
JOIN Voter v ON c.CNIC = v.CNIC
JOIN Party p ON r.PartyID = p.PartyID;
GO

-- 15. View showing election results by district with party and address info
CREATE VIEW DistrictResults AS
SELECT r.ResultID, 
       a.DistrictID, a.City, a.State,
       p.PartyName, p.Symbol,
       r.Vote_Count
FROM Result r
JOIN Address a ON r.DistrictID = a.DistrictID
JOIN Party p ON r.PartyID = p.PartyID;
GO

--PROCEDURES:

--1. Procedure to get all voters
CREATE PROCEDURE sp_GetAllVoters
AS
BEGIN
    SELECT * FROM Voter;
END;
GO

--2.Procedure to get all candidates
CREATE PROCEDURE sp_GetAllCandidates
AS
BEGIN
    SELECT * FROM Candidate;
END;
GO

--3. Procedure to get national candidates only
CREATE PROCEDURE sp_GetNationalCandidates
AS
BEGIN
    SELECT * FROM Candidate WHERE CandidateTypeID = 100;
END;
GO

--4. Procedure to get all parties
CREATE PROCEDURE sp_GetAllParties
AS
BEGIN
    SELECT * FROM Party;
END;
GO

--5. Procedure to get party leaders
CREATE PROCEDURE sp_GetPartyLeaders
AS
BEGIN
    SELECT PartyName, PartyLeader FROM Party;
END;
GO

--6. Procedure to get active users only
CREATE PROCEDURE sp_GetActiveUsers
AS
BEGIN
    SELECT * FROM UserAccount WHERE IsActive = 1;
END;
GO

--7. Procedure to add a new voter
CREATE PROCEDURE sp_AddVoter
    @CNIC CHAR(15),
    @FirstName VARCHAR(30),
    @LastName VARCHAR(50),
    @MotherName VARCHAR(30) = NULL,
    @FatherName VARCHAR(30) = NULL,
    @Sex CHAR(7),
    @Birthday DATE,
    @Phone NUMERIC,
    @DistrictID INT
AS
BEGIN
    INSERT INTO Voter (CNIC, FirstName, LastName, MotherName, FatherName, Sex, Birthday, Phone, DistrictID)
    VALUES (@CNIC, @FirstName, @LastName, @MotherName, @FatherName, @Sex, @Birthday, @Phone, @DistrictID);
END;
GO

--8. Procedure to update voter information
CREATE PROCEDURE sp_UpdateVoter
    @CNIC CHAR(15),
    @FirstName VARCHAR(30) = NULL,
    @LastName VARCHAR(50) = NULL,
    @MotherName VARCHAR(30) = NULL,
    @FatherName VARCHAR(30) = NULL,
    @Sex CHAR(7) = NULL,
    @Phone NUMERIC = NULL,
    @DistrictID INT = NULL
AS
BEGIN
    UPDATE Voter
    SET 
        FirstName = ISNULL(@FirstName, FirstName),
        LastName = ISNULL(@LastName, LastName),
        MotherName = ISNULL(@MotherName, MotherName),
        FatherName = ISNULL(@FatherName, FatherName),
        Sex = ISNULL(@Sex, Sex),
        Phone = ISNULL(@Phone, Phone),
        DistrictID = ISNULL(@DistrictID, DistrictID)
    WHERE CNIC = @CNIC;
END;
GO

--9. Procedure to add a new political party
CREATE PROCEDURE sp_AddParty
    @PartyID INT,
    @PartyName VARCHAR(20),
    @Symbol VARCHAR(20),
    @PartyLeader VARCHAR(50)
AS
BEGIN
    INSERT INTO Party (PartyID, PartyName, Symbol, PartyLeader)
    VALUES (@PartyID, @PartyName, @Symbol, @PartyLeader);
END;
GO

--10. Procedure to update party information
CREATE PROCEDURE sp_UpdateParty
    @PartyID INT,
    @PartyName VARCHAR(20) = NULL,
    @Symbol VARCHAR(20) = NULL,
    @PartyLeader VARCHAR(50) = NULL
AS
BEGIN
    UPDATE Party
    SET 
        PartyName = ISNULL(@PartyName, PartyName),
        Symbol = ISNULL(@Symbol, Symbol),
        PartyLeader = ISNULL(@PartyLeader, PartyLeader)
    WHERE PartyID = @PartyID;
END;
GO

--11. Procedure to get candidates by party
CREATE PROCEDURE sp_GetCandidatesByParty
    @PartyID INT
AS
BEGIN
    SELECT c.CandidateID, v.FirstName, v.LastName, ct.CandidateType, p.PartyName
    FROM Candidate c
    JOIN Voter v ON c.CNIC = v.CNIC
    JOIN Candidate_Type ct ON c.CandidateTypeID = ct.CandidateTypeID
    JOIN Party p ON c.PartyID = p.PartyID
    WHERE c.PartyID = @PartyID;
END;
GO

--12. Procedure to get overall election results
CREATE PROCEDURE sp_GetOverallResults
AS
BEGIN
    SELECT p.PartyName, p.Symbol, 
           SUM(r.Vote_Count) AS TotalVotes,
           COUNT(DISTINCT r.CandidateID) AS Candidates,
           COUNT(DISTINCT r.DistrictID) AS Districts
    FROM Result r
    JOIN Party p ON r.PartyID = p.PartyID
    GROUP BY p.PartyName, p.Symbol
    ORDER BY SUM(r.Vote_Count) DESC;
END;
GO

--FUNCTIONS:

-- 1. Function to count total voters
CREATE FUNCTION fn_TotalVoters()
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(*) FROM Voter;
    RETURN @Count;
END;
GO

--2. Function to Get Winning Party Name
CREATE FUNCTION fn_GetWinningParty()
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @PartyName VARCHAR(50);
    SELECT TOP 1 @PartyName = p.PartyName
    FROM Result r
    JOIN Party p ON r.PartyID = p.PartyID
    ORDER BY r.Vote_Count DESC;
    RETURN @PartyName;
END;
GO

--3. Function to Get Total Number of Parties
CREATE FUNCTION fn_TotalParties()
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(*) FROM Party;
    RETURN @Count;
END;
GO

--4. Function to Get Total Votes Cast
CREATE FUNCTION fn_TotalVotesCast()
RETURNS INT
AS
BEGIN
    DECLARE @TotalVotes INT;
    SELECT @TotalVotes = SUM(Vote_Count) FROM Result;
    RETURN @TotalVotes;
END;
GO

-- 5. Function to check if voter exists by CNIC
CREATE FUNCTION fn_VoterExists(@CNIC CHAR(15))
RETURNS BIT
AS
BEGIN
    DECLARE @Exists BIT = 0;
    IF EXISTS (SELECT 1 FROM Voter WHERE CNIC = @CNIC)
        SET @Exists = 1;
    RETURN @Exists;
END;
GO

-- 6. Function to get voter age by CNIC
CREATE FUNCTION fn_GetVoterAge(@CNIC CHAR(15))
RETURNS INT
AS
BEGIN
    DECLARE @Age INT;
    SELECT @Age = DATEDIFF(YEAR, Birthday, GETDATE()) 
    FROM Voter WHERE CNIC = @CNIC;
    RETURN @Age;
END;
GO

-- 7. Function to count votes by party
CREATE FUNCTION fn_CountVotesByParty(@PartyID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(*) FROM Vote WHERE PartyID = @PartyID;
    RETURN @Count;
END;
GO

-- 8. Function to check if candidate is registered
CREATE FUNCTION fn_IsCandidateRegistered(@CNIC CHAR(15), @ElectionID INT)
RETURNS BIT
AS
BEGIN
    DECLARE @Registered BIT = 0;
    IF EXISTS (SELECT 1 FROM Candidate WHERE CNIC = @CNIC AND ElectionID = @ElectionID)
        SET @Registered = 1;
    RETURN @Registered;
END;
GO

-- 9. Function to get candidate's party
CREATE FUNCTION fn_GetCandidateParty(@CandidateID INT)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @PartyName VARCHAR(50);
    SELECT @PartyName = p.PartyName
    FROM Candidate c
    JOIN Party p ON c.PartyID = p.PartyID
    WHERE c.CandidateID = @CandidateID;
    RETURN @PartyName;
END;
GO

-- 10. Function to count candidates by district
CREATE FUNCTION fn_CountCandidatesByDistrict(@DistrictID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(*) FROM Candidate WHERE DistrictID = @DistrictID;
    RETURN @Count;
END;
GO

-- 11. Function to get voter details by CNIC
CREATE FUNCTION fn_GetVoterDetails(@CNIC CHAR(15))
RETURNS TABLE
AS
RETURN
    SELECT 
        v.FirstName + ' ' + v.LastName AS FullName,
        v.Sex,
        v.Birthday,
        a.City,
        a.State
    FROM Voter v
    JOIN Address a ON v.DistrictID = a.DistrictID
    WHERE v.CNIC = @CNIC;
GO

-- 12. Function to check if user has voted
CREATE FUNCTION fn_HasUserVoted(@VoterID VARCHAR(10))
RETURNS BIT
AS
BEGIN
    DECLARE @Voted BIT = 0;
    IF EXISTS (SELECT 1 FROM Vote WHERE VoterID = @VoterID)
        SET @Voted = 1;
    RETURN @Voted;
END;
GO


--QUERIES TO CALL FUNCTIONS:
SELECT dbo.fn_TotalVoters() AS TotalVoters;
SELECT dbo.fn_GetWinningParty() AS WinningParty;
SELECT dbo.fn_TotalParties() AS TotalParties;
SELECT dbo.fn_TotalVotesCast() AS TotalVotes;
SELECT dbo.fn_VoterExists('3520-1345-9877') AS VoterExists; -- Replace with actual CNIC
SELECT dbo.fn_VoterExists('1234-5678-9012') AS VoterExists; -- Example with non-existent CNIC
SELECT dbo.fn_GetVoterAge('3520-1345-9877') AS VoterAge; -- Replace with actual CNIC
SELECT dbo.fn_CountVotesByParty(11) AS PTIVotes;
SELECT dbo.fn_CountVotesByParty(12) AS PMLNVotes;
SELECT dbo.fn_IsCandidateRegistered('3520-1345-9877', 200) AS IsRegistered; -- General Election
SELECT dbo.fn_IsCandidateRegistered('3520-1345-9877', 201) AS IsRegistered; -- By-Election
SELECT dbo.fn_GetCandidateParty(1005) AS CandidateParty; -- Replace with actual CandidateID
SELECT dbo.fn_CountCandidatesByDistrict(234) AS CandidatesInLahore;
SELECT dbo.fn_CountCandidatesByDistrict(235) AS CandidatesInKarachi;
SELECT * FROM dbo.fn_GetVoterDetails('3520-1345-9877'); -- Replace with actual CNIC
SELECT dbo.fn_HasUserVoted('V119') AS HasVoted; -- Replace with actual VoterID
SELECT dbo.fn_HasUserVoted('V120') AS HasVoted;

-- Triggers for Address table

-- INSERT trigger for Address
CREATE TRIGGER tr_Address_Insert
ON Address
AFTER INSERT
AS
BEGIN
    DECLARE @Locality VARCHAR(30)
    SELECT @Locality = Locality FROM inserted
    PRINT 'New address locality added: ' + @Locality
END;
GO

-- UPDATE trigger for Address
CREATE TRIGGER tr_Address_Update
ON Address
AFTER UPDATE
AS
BEGIN
    IF UPDATE(City)
    BEGIN
        DECLARE @OldCity VARCHAR(30), @NewCity VARCHAR(30), @DistrictID INT
        SELECT @OldCity = City FROM deleted
        SELECT @NewCity = City, @DistrictID = DistrictID FROM inserted
        PRINT 'Address city updated for DistrictID ' + CAST(@DistrictID AS VARCHAR) + 
              ' from ' + @OldCity + ' to ' + @NewCity
    END
END;
GO

-- DELETE trigger for Address
CREATE TRIGGER tr_Address_Delete
ON Address
AFTER DELETE
AS
BEGIN
    DECLARE @State VARCHAR(30), @DistrictID INT
    SELECT @State = State, @DistrictID = DistrictID FROM deleted
    PRINT 'Address record deleted for DistrictID ' + CAST(@DistrictID AS VARCHAR) + 
          ' in state ' + @State
END;
GO


-- Triggers for Voter table

-- INSERT trigger for Voter
CREATE TRIGGER tr_Voter_Insert
ON Voter
AFTER INSERT
AS
BEGIN
    DECLARE @FirstName VARCHAR(30), @CNIC CHAR(15)
    SELECT @FirstName = FirstName, @CNIC = CNIC FROM inserted
    PRINT 'New voter registered: ' + @FirstName + ' (CNIC: ' + @CNIC + ')'
END;
GO

-- UPDATE trigger for Voter
CREATE TRIGGER tr_Voter_Update
ON Voter
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Phone)
    BEGIN
        DECLARE @OldPhone NUMERIC, @NewPhone NUMERIC, @CNIC CHAR(15)
        SELECT @OldPhone = Phone, @CNIC = CNIC FROM deleted
        SELECT @NewPhone = Phone FROM inserted
        PRINT 'Phone number updated for voter ' + @CNIC + 
              ' from ' + CAST(@OldPhone AS VARCHAR) + ' to ' + CAST(@NewPhone AS VARCHAR)
    END
END;
GO

-- DELETE trigger for Voter
CREATE TRIGGER tr_Voter_Delete
ON Voter
AFTER DELETE
AS
BEGIN
    DECLARE @CNIC CHAR(15), @FirstName VARCHAR(30), @LastName VARCHAR(50)
    SELECT @CNIC = CNIC, @FirstName = FirstName, @LastName = LastName FROM deleted
    PRINT 'Voter record deleted: ' + @FirstName + ' ' + @LastName + ' (CNIC: ' + @CNIC + ')'
END;
GO


-- Triggers for Candidate_Type table

-- INSERT trigger for Candidate_Type 
CREATE TRIGGER tr_CandidateType_Insert
ON Candidate_Type
AFTER INSERT
AS
BEGIN
    DECLARE @CandidateType VARCHAR(20), @ID INT
    SELECT @CandidateType = CandidateType, @ID = CandidateTypeID FROM inserted
    PRINT 'New candidate type added: ' + @CandidateType + ' (ID: ' + CAST(@ID AS VARCHAR) + ')'
END;
GO

-- UPDATE trigger for Candidate_Type 
CREATE TRIGGER tr_CandidateType_Update
ON Candidate_Type
AFTER UPDATE
AS
BEGIN
    IF UPDATE(CandidateTypeID)
    BEGIN
        DECLARE @OldID INT, @NewID INT    
        SELECT @OldID = CandidateTypeID FROM deleted
        SELECT @NewID = CandidateTypeID FROM inserted  
        PRINT 'CandidateTypeID changed from ' + CAST(@OldID AS VARCHAR) + 
              ' to ' + CAST(@NewID AS VARCHAR)
    END
END;
GO

-- DELETE trigger for Candidate_Type
CREATE TRIGGER tr_CandidateType_Delete
ON Candidate_Type
AFTER DELETE
AS
BEGIN
    DECLARE @CandidateType VARCHAR(20), @ID INT   
    SELECT @CandidateType = CandidateType, @ID = CandidateTypeID FROM deleted   
    PRINT 'Candidate type deleted: ' + @CandidateType + ' (ID: ' + CAST(@ID AS VARCHAR) + ')'
END;
GO

-- Triggers for Election table


-- INSERT trigger for Election
CREATE TRIGGER tr_Election_Insert
ON Election
AFTER INSERT
AS
BEGIN
    DECLARE @ElectionType VARCHAR(20), @ID INT
    SELECT @ElectionType = ElectionType, @ID = ElectionID FROM inserted  
    PRINT 'New election type added: ' + @ElectionType + ' (ID: ' + CAST(@ID AS VARCHAR) + ')'
END;
GO

-- UPDATE trigger for Election
CREATE TRIGGER tr_Election_Update
ON Election
AFTER UPDATE
AS
BEGIN
    IF UPDATE(ElectionID)
    BEGIN
        DECLARE @OldID INT, @NewID INT      
        SELECT @OldID = ElectionID FROM deleted
        SELECT @NewID = ElectionID FROM inserted     
        PRINT 'ElectionID changed from ' + CAST(@OldID AS VARCHAR) + 
              ' to ' + CAST(@NewID AS VARCHAR)
    END
END;
GO

-- DELETE trigger for Election 
CREATE TRIGGER tr_Election_Delete
ON Election
AFTER DELETE
AS
BEGIN
    DECLARE @ElectionType VARCHAR(20), @ID INT   
    SELECT @ElectionType = ElectionType, @ID = ElectionID FROM deleted   
    PRINT 'Election type deleted: ' + @ElectionType + ' (ID: ' + CAST(@ID AS VARCHAR) + ')'
END;
GO

-- Triggers for Party table

-- INSERT trigger for Party 
CREATE TRIGGER tr_Party_Insert
ON Party
AFTER INSERT
AS
BEGIN
    DECLARE @PartyName VARCHAR(20), @ID INT 
    SELECT @PartyName = PartyName, @ID = PartyID FROM inserted 
    PRINT 'New political party registered: ' + @PartyName + ' (ID: ' + CAST(@ID AS VARCHAR) + ')'
END;
GO

-- UPDATE trigger for Party 
CREATE TRIGGER tr_Party_Update
ON Party
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Symbol)
    BEGIN
        DECLARE @OldSymbol VARCHAR(20), @NewSymbol VARCHAR(20), @PartyName VARCHAR(20)      
        SELECT @OldSymbol = Symbol, @PartyName = PartyName FROM deleted
        SELECT @NewSymbol = Symbol FROM inserted     
        PRINT 'Party symbol updated for ' + @PartyName + 
              ' from ' + @OldSymbol + ' to ' + @NewSymbol
    END
END;
GO

-- DELETE trigger for Party 
CREATE TRIGGER tr_Party_Delete
ON Party
AFTER DELETE
AS
BEGIN
    DECLARE @PartyName VARCHAR(20), @Leader VARCHAR(50)   
    SELECT @PartyName = PartyName, @Leader = PartyLeader FROM deleted  
    PRINT 'Political party deleted: ' + @PartyName + ' (Leader: ' + @Leader + ')'
END;
GO

-- Triggers for User_Type table

-- INSERT trigger for User_Type 
CREATE TRIGGER tr_UserType_Insert
ON User_Type
AFTER INSERT
AS
BEGIN
    DECLARE @UserType VARCHAR(20), @ID INT   
    SELECT @UserType = UserType, @ID = UserTypeID FROM inserted   
    PRINT 'New user type added: ' + @UserType + ' (ID: ' + CAST(@ID AS VARCHAR) + ')'
END;
GO

-- UPDATE trigger for User_Type 
CREATE TRIGGER tr_UserType_Update
ON User_Type
AFTER UPDATE
AS
BEGIN
    IF UPDATE(UserTypeID)
    BEGIN
        DECLARE @OldID INT, @NewID INT      
        SELECT @OldID = UserTypeID FROM deleted
        SELECT @NewID = UserTypeID FROM inserted      
        PRINT 'UserTypeID changed from ' + CAST(@OldID AS VARCHAR) + 
              ' to ' + CAST(@NewID AS VARCHAR)
    END
END;
GO

-- DELETE trigger for User_Type 
CREATE TRIGGER tr_UserType_Delete
ON User_Type
AFTER DELETE
AS
BEGIN
    DECLARE @UserType VARCHAR(20), @ID INT  
    SELECT @UserType = UserType, @ID = UserTypeID FROM deleted  
    PRINT 'User type deleted: ' + @UserType + ' (ID: ' + CAST(@ID AS VARCHAR) + ')'
END;
GO

-- Triggers for Candidate table

-- INSERT trigger for Candidate
CREATE TRIGGER tr_Candidate_Insert
ON Candidate
AFTER INSERT
AS
BEGIN
    DECLARE @CNIC CHAR(15), @CandidateID INT   
    SELECT @CNIC = CNIC, @CandidateID = CandidateID FROM inserted   
    PRINT 'New candidate registered with CNIC: ' + @CNIC + ' (CandidateID: ' + CAST(@CandidateID AS VARCHAR) + ')'
END;
GO

-- UPDATE trigger for Candidate
CREATE TRIGGER tr_Candidate_Update
ON Candidate
AFTER UPDATE
AS
BEGIN
    IF UPDATE(PartyID)
    BEGIN
        DECLARE @OldPartyID INT, @NewPartyID INT, @CandidateID INT     
        SELECT @OldPartyID = PartyID, @CandidateID = CandidateID FROM deleted
        SELECT @NewPartyID = PartyID FROM inserted      
        PRINT 'Party affiliation changed for candidate ' + CAST(@CandidateID AS VARCHAR) + 
              ' from ' + CAST(@OldPartyID AS VARCHAR) + ' to ' + CAST(@NewPartyID AS VARCHAR)
    END
END;
GO

-- DELETE trigger for Candidate
CREATE TRIGGER tr_Candidate_Delete
ON Candidate
AFTER DELETE
AS
BEGIN
    DECLARE @CandidateID INT, @TypeID INT  
    SELECT @CandidateID = CandidateID, @TypeID = CandidateTypeID FROM deleted  
    PRINT 'Candidate record deleted: ID ' + CAST(@CandidateID AS VARCHAR) + 
          ' (Type: ' + CAST(@TypeID AS VARCHAR) + ')'
END;
GO

-- Triggers for UserAccount table

-- INSERT trigger for UserAccount 
CREATE TRIGGER tr_UserAccount_Insert
ON UserAccount
AFTER INSERT
AS
BEGIN
    DECLARE @VoterID VARCHAR(10), @CNIC CHAR(15)  
    SELECT @VoterID = VoterID, @CNIC = CNIC FROM inserted  
    PRINT 'New user account created: ' + @VoterID + ' (CNIC: ' + @CNIC + ')'
END;
GO

-- UPDATE trigger for UserAccount
CREATE TRIGGER tr_UserAccount_Update
ON UserAccount
AFTER UPDATE
AS
BEGIN
    IF UPDATE(IsActive)
    BEGIN
        DECLARE @OldStatus BIT, @NewStatus BIT, @VoterID VARCHAR(10)     
        SELECT @OldStatus = IsActive, @VoterID = VoterID FROM deleted
        SELECT @NewStatus = IsActive FROM inserted       
        PRINT 'Account status changed for ' + @VoterID + 
              ' from ' + CASE @OldStatus WHEN 1 THEN 'Active' ELSE 'Inactive' END +
              ' to ' + CASE @NewStatus WHEN 1 THEN 'Active' ELSE 'Inactive' END
    END
END;
GO

-- DELETE trigger for UserAccount 
CREATE TRIGGER tr_UserAccount_Delete
ON UserAccount
AFTER DELETE
AS
BEGIN
    DECLARE @VoterID VARCHAR(10), @UserTypeID INT   
    SELECT @VoterID = VoterID, @UserTypeID = UserTypeID FROM deleted   
    PRINT 'User account deleted: ' + @VoterID + ' (UserType: ' + CAST(@UserTypeID AS VARCHAR) + ')'
END;
GO

-- Triggers for Vote table

-- INSERT trigger for Vote
CREATE TRIGGER tr_Vote_Insert
ON Vote
AFTER INSERT
AS
BEGIN
    DECLARE @VoterID VARCHAR(10), @VoteID VARCHAR(7)   
    SELECT @VoterID = VoterID, @VoteID = VoteID FROM inserted   
    PRINT 'New vote recorded: ' + @VoteID + ' by voter ' + @VoterID
END;
GO

-- UPDATE trigger for Vote
CREATE TRIGGER tr_Vote_Update
ON Vote
AFTER UPDATE
AS
BEGIN
    IF UPDATE(PartyID)
    BEGIN
        DECLARE @OldPartyID INT, @NewPartyID INT, @VoteID VARCHAR(7)       
        SELECT @OldPartyID = PartyID, @VoteID = VoteID FROM deleted
        SELECT @NewPartyID = PartyID FROM inserted       
        PRINT 'Vote party changed for ' + @VoteID + 
              ' from ' + CAST(@OldPartyID AS VARCHAR) + ' to ' + CAST(@NewPartyID AS VARCHAR)
    END
END;
GO

-- DELETE trigger for Vote
CREATE TRIGGER tr_Vote_Delete
ON Vote
AFTER DELETE
AS
BEGIN
    DECLARE @VoteID VARCHAR(7), @CandidateID INT  
    SELECT @VoteID = VoteID, @CandidateID = CandidateID FROM deleted  
    PRINT 'Vote record deleted: ' + @VoteID + ' for candidate ' + CAST(@CandidateID AS VARCHAR)
END;
GO

-- Triggers for Result table

-- INSERT trigger for Result
CREATE TRIGGER tr_Result_Insert
ON Result
AFTER INSERT
AS
BEGIN
    DECLARE @VoteCount INT, @CandidateID INT, @PartyID INT 
    SELECT @VoteCount = Vote_Count, @CandidateID = CandidateID, @PartyID = PartyID FROM inserted  
    PRINT 'New result recorded: Candidate ' + CAST(@CandidateID AS VARCHAR) + 
          ' (Party ' + CAST(@PartyID AS VARCHAR) + ') received ' + CAST(@VoteCount AS VARCHAR) + ' votes'
END;
GO

-- UPDATE trigger for Result
CREATE TRIGGER tr_Result_Update
ON Result
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Vote_Count)
    BEGIN
        DECLARE @OldCount INT, @NewCount INT, @CandidateID INT       
        SELECT @OldCount = Vote_Count, @CandidateID = CandidateID FROM deleted
        SELECT @NewCount = Vote_Count FROM inserted      
        PRINT 'Vote count updated for candidate ' + CAST(@CandidateID AS VARCHAR) + 
              ' from ' + CAST(@OldCount AS VARCHAR) + ' to ' + CAST(@NewCount AS VARCHAR)
    END
END;
GO

-- DELETE trigger for Result
CREATE TRIGGER tr_Result_Delete
ON Result
AFTER DELETE
AS
BEGIN
    DECLARE @CandidateID INT, @PartyID INT
    SELECT @CandidateID = CandidateID, @PartyID = PartyID FROM deleted
    PRINT 'Result record deleted: Candidate ' + CAST(@CandidateID AS VARCHAR) + 
          ' (Party ' + CAST(@PartyID AS VARCHAR) + ')'
END;
GO

-- Test Address insert trigger
INSERT INTO Address (DistrictID, Locality, City, State, Zip)
VALUES (291, 'New Colony', 'Lahore', 'Punjab', '54001');

-- Test Voter insert trigger
INSERT INTO Voter (CNIC, FirstName, LastName, MotherName, FatherName, Sex, Birthday, Phone, DistrictID)
VALUES ('9999-8888-7777', 'Test', 'User', 'TestMother', 'TestFather', 'Male', '1990-01-01', 3001234567, 234);

-- Test Candidate insert trigger
INSERT INTO Candidate (CandidateID, CNIC, CandidateTypeID, PartyID, ElectionID, DistrictID)
VALUES (1031, '9999-8888-7777', 100, 11, 200, 234);


-- Test Address update trigger (city change)
UPDATE Address 
SET City = 'Islamabad' 
WHERE DistrictID = 234;

-- Test Voter update trigger (phone change)
UPDATE Voter 
SET Phone = 3119876543 
WHERE CNIC = '3520-1345-9877';

-- Test Candidate update trigger (party change)
UPDATE Candidate 
SET PartyID = 12 
WHERE CandidateID = 1005;

-- Test Address delete trigger
DELETE FROM Address 
WHERE DistrictID = 291;

-- Test Voter delete trigger
DELETE FROM Voter 
WHERE CNIC = '9999-8888-7777';

-- Test Candidate delete trigger
DELETE FROM Candidate 
WHERE CandidateID = 1031;