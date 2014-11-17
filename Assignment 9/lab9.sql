CREATE TABLE Players (
	PlayerID serial NOT NULL, 
	PersonID interger NOT NULL,
	TeamID integer NOT NULL,
	Age integer NOT NULL,
PRIMARY KEY(PlayerID)
);

CREATE TABLE Person (
	PersonID serial NOT NULL,
	Name text NOT NULL,
	Address text NOT NULL,
	PhoneNumber text NOT NULL,
PRIMARY KEY(PersonID)
);

CREATE TABLE Coaches (
	CoachID serial NOT NULL, 
	PersonID interger NOT NULL,
	YearsCoached integer NOT NULL,
PRIMARY KEY(CoachID)
);

CREATE TABLE AssistantCoach (
	acID serial NOT NULL, 
	CoachID interger NOT NULL,
PRIMARY KEY(acID)
);

CREATE TABLE HeadCoach (
	hcID serial NOT NULL, 
	CoachID interger NOT NULL,
PRIMARY KEY(hcID)
);

CREATE TABLE TeamsCoached (
	tcID serial NOT NULL, 
	CoachID interger NOT NULL,
	TeamID integer NOT NULL,
PRIMARY KEY(tcID)
);

CREATE TABLE Teams (
	TeamID serial NOT NULL, 
	ageID interger NOT NULL,
	name text NOT NULL,
PRIMARY KEY(TeamID)
);

CREATE TABLE AgeGroup (
	AgeID serial NOT NULL, 
	Ages interger NOT NULL,
PRIMARY KEY(AgeID)
);