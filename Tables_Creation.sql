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
