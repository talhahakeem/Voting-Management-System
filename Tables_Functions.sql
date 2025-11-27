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