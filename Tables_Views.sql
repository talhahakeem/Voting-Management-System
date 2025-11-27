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

