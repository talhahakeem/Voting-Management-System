USE Voting_Management_System;
GO

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