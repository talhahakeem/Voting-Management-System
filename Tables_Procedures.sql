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


