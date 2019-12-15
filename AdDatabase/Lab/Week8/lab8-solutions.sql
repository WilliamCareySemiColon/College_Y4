--Golf DB 1 and DB 2
drop table results1;
drop table results2;
drop table players1;
drop table players2;
drop table team1;
drop table team2;
drop table tournament1;
drop table tournament2;

Create Table Team1 (
    Team_id integer primary key,
    Team_name varchar(100)
);

Create Table Team2 (
    Team_id integer primary key,
    Team_name varchar(100)
);

Create Table Players1 (
    p_id integer primary key,
    p_name varchar(50),
    p_sname varchar(50),
    team_id integer,
    constraint fk_team_1 foreign key (team_id) 
    references team1
);

Create Table Players2 (
    p_id integer primary key,
    p_name varchar(50),
    p_sname varchar(50),
    team_id integer,
    constraint fk_team_2 foreign key (team_id) 
    references team2
);

Create Table Tournament1 (
    T_id integer primary key,
    t_descriprion varchar(100),
    t_date date,
    Total_price float
);

Create Table Tournament2 (
    T_id integer primary key,
    t_descriprion varchar(100),
    t_date date,
    Total_price float
);

Create Table Results1 (
    t_id integer,
    p_id integer,
    rank integer,
    price float,
    CONSTRAINT FK_player1 FOREIGN KEY (p_id) 
    REFERENCES players1,
    CONSTRAINT FK_tournament1 FOREIGN KEY (t_id) 
    REFERENCES tournament1,
    CONSTRAINT PK_Results1 PRIMARY KEY (t_id,p_id)
);

Create Table Results2 (
    t_id integer,
    p_id integer,
    rank integer,
    price float,
    CONSTRAINT  FK_player2 FOREIGN KEY (p_id) 
    REFERENCES players2,
    CONSTRAINT  FK_tournament2 FOREIGN KEY (t_id) 
    REFERENCES tournament2,
    CONSTRAINT PK_Results2 PRIMARY KEY (t_id,p_id)
);
--end er diagram

--data insertion into er model, starting with team 1
INSERT INTO TEAM1 (TEAM_ID, TEAM_NAME) VALUES (1, 'USA');
INSERT INTO TEAM1 (TEAM_ID, TEAM_NAME) VALUES (2, 'AUSTRALIA');
INSERT INTO TEAM1 (TEAM_ID, TEAM_NAME) VALUES (3, 'UK');
INSERT INTO TEAM1 (TEAM_ID, TEAM_NAME) VALUES (4, 'IRELAND');
--team 2
INSERT INTO TEAM2 (TEAM_ID, TEAM_NAME) VALUES (1, 'UK');
INSERT INTO TEAM2 (TEAM_ID, TEAM_NAME) VALUES (2, 'IRELAND');
INSERT INTO TEAM2 (TEAM_ID, TEAM_NAME) VALUES (3, 'USA');
INSERT INTO TEAM2 (TEAM_ID, TEAM_NAME) VALUES (4, 'ITALY');
--players 1
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (1, 'Tiger', 'Woods', 1);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (2, 'Mary', 'Smith', 2);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (3, 'Mark', 'Deegan', 2);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (4, 'James', 'Bryan', 3);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (5, 'John', 'McDonald', 1);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (6, 'Mario', 'Baggio', 1);
--players 2
INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (2, 'Tiger', 'Woods', 3);
INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (1, 'John', 'McDonald', 3);
INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (3, 'Jim', 'Burke', 3);
INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (4, 'Paul', 'Bin', 3);
INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (5, 'Peter', 'Flynn', 3);
INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (6, 'Martha', 'Ross', 4);
--tournament 1
INSERT INTO TOURNAMENT1 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (1, 'US open', 1700000,'01-jan-2014');
INSERT INTO TOURNAMENT1 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (2, 'British Open', 7000000,'01-apr-2014');
INSERT INTO TOURNAMENT1 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (3, 'Italian Open', 2000000,'11-mar-2014');
INSERT INTO TOURNAMENT1 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (4, 'Irish Open', 300000,'21-jul-2014');
--tournamanet 2
INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (1, 'Dutch open', 1700000,'22-nov-2014');
INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (2, 'French Open', 7000000,'17-dec-2014');
INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (3, 'Spanish Open', 2000000,'03-mar-2014');
INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (4, 'Chiinese Open', 300000,'15-jul-2014');
INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (5, 'Dubai Open', 600000,'10-aug-2014');
INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (6, 'US Master', 1000000,'10-jul-2014');
--results 1
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (1, 1, 1, 10000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (1, 2, 2, 20000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (2, 2, 4, 1000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (3, 2, 3, 10000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (3, 1, 2, 1100);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (4, 6, 3, 6000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (4, 2, 2, 9000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (4, 1, 1, 10000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (3, 5, 2, 9500);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (4, 5, 4, 10000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (2, 5, 7, 100);
--players 2
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (1, 1, 1, 1000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (1, 2, 3, 2000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (2, 2, 1, 6000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (3, 2, 3, 17000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (3, 1, 12, 1100);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (4, 6, 10, 8000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (4, 2, 2, 12000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (4, 1, 3, 10000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (3, 5, 1, 9000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (4, 5, 5, 1000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (2, 5, 3, 1000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (5, 5, 3, 8000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (5, 2, 2, 16000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (5, 1, 1, 20000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (6, 1, 3, 2000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (6, 5, 2, 9400);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (6, 4, 1, 12000);

--The stage of creating the datawarehouse
drop table Fact_Results;
drop table DimDate;
drop table DimTournament;
drop table DimTeam;
drop table DimPlayer;

--Dimensional Model Schema
CREATE TABLE DimPlayer (
    Player_SK INTEGER PRIMARY KEY,
    Player_name VARCHAR(50)
);

CREATE TABLE DimTeam (
    Team_SK INTEGER PRIMARY KEY,
    Team_name VARCHAR(50)
);

CREATE TABLE DimTournament (
    Tournament_SK INTEGER PRIMARY KEY,
    Tournament_Desc VARCHAR(100),
    Total_Price FLOAT
);

CREATE TABLE DimDate (
    Date_SK INTEGER PRIMARY KEY,
    Day_Value INTEGER,
    Month_Value VARCHAR(5),
    Year_Value INTEGER,
    Week_Value INTEGER,
    Quarter_Value INTEGER,
    DayOfWeek INTEGER
);

CREATE TABLE Fact_Results (
    Player_SK INTEGER,
    Team_SK INTEGER,
    Tournament_SK INTEGER,
    Date_SK INTEGER,
    Rank_ INTEGER,
    PRICE INTEGER,
    CONSTRAINT FK_DimPlayer FOREIGN KEY (Player_SK) 
    REFERENCES DimPlayer,
    CONSTRAINT FK_DimTeam FOREIGN KEY (Team_SK) 
    REFERENCES DimTeam,
    CONSTRAINT FK_DimTournament FOREIGN KEY (Tournament_SK) 
    REFERENCES DimTournament,
    CONSTRAINT FK_DimDate FOREIGN KEY (Date_SK) 
    REFERENCES DimDate
);

drop table Player_Stage;
drop table Team_Stage;
drop table Tournament_Stage;
drop table Fact_Stage;
drop table Date_Stage;

--Staging process for loading from database into data warehouse
CREATE TABLE Player_Stage (
    Player_SK INTEGER PRIMARY KEY,
    Player_name VARCHAR(50),
    P_ID INTEGER,
    SourceDB INTEGER
);

--Loop to add players from Players1 and Players 2 into DimPlayers
DROP SEQUENCE p_stage_seq;

CREATE SEQUENCE p_stage_seq 
START WITH 1
INCREMENT BY 1
nomaxvalue;

--DROP TRIGGER p_stage_trigger;
CREATE OR REPLACE TRIGGER p_stage_trigger
AFTER INSERT ON Player_Stage FOR EACH ROW
BEGIN
    SELECT p_stage_seq.nextval into :new.Player_SK FROM dual;
END;

--load players into staging area
INSERT INTO Player_Stage (Player_name, P_ID, SourceDB) SELECT P_name, P_ID, 1 FROM Players1;
INSERT INTO Player_Stage (Player_name, P_ID, SourceDB) SELECT P_name, P_ID, 2 FROM Players2;

--Checking if the staging for the players has succeeded
SELECT * FROM Player_Stage;

--passing the players to dim model
INSERT INTO DimPlayer SELECT DISTINCT Player_SK, Player_Name From Player_Stage;

--Check the player passed successfully 
SELECT * FROM DimPlayer;

--creating the team stage
CREATE TABLE Team_Stage (
    Team_SK INTEGER PRIMARY KEY,
    Team_name VARCHAR(50),
    T_ID INTEGER, 
    SourceDB INTEGER
);

--Loop to add teams from Team1 and Team2 into the team staging area
DROP SEQUENCE t_stage_seq;
CREATE SEQUENCE t_stage_seq
START WITH 1
INCREMENT BY 1
nomaxvalue;

--DROP TRIGGER t_stage_trigger;
CREATE TRIGGER t_stage_trigger
AFTER INSERT ON Team_Stage FOR EACH ROW
BEGIN
    SELECT t_stage_seq.nextval into :new.Team_SK FROM dual;
END;

--loading teams into stage area
INSERT INTO Team_Stage (Team_name, T_ID, SourceDB) SELECT Team_name, Team_ID, 1 FROM Team1;
INSERT INTO Team_Stage (Team_name, T_ID, SourceDB) SELECT Team_name, Team_ID, 2 FROM Team2;

--Testing to see if the stage of the teams worked
SELECT * FROM Team_Stage;

--pass the team into the dim model
INSERT INTO DimTeam SELECT DISTINCT Team_SK, Team_Name From Team_Stage;

--Check the dimension table for the team
SELECT * FROM DimTeam;

--create the tournament stage process
CREATE TABLE Tournament_Stage (
    Tournament_SK INTEGER PRIMARY KEY,
    Tournament_Desc VARCHAR(100),
    Total_Price INTEGER,
    Tourn_ID INTEGER,
    Tourn_Date DATE, 
    SourceDB INTEGER
);

--Loop to add teams from Team1 and Team2 into the team staging area 
DROP SEQUENCE trn_stage_seq
CREATE SEQUENCE trn_stage_seq
START WITH 1
INCREMENT BY 1
nomaxvalue;

--DROP TRIGGER trn_stage_trigger;
CREATE TRIGGER trn_stage_trigger
After INSERT ON Tournament_Stage FOR EACH ROW
BEGIN
    SELECT trn_stage_seq.nextval into :new.Tournament_SK FROM dual;
END;

INSERT INTO Tournament_Stage (Tournament_Desc, Total_Price, Tourn_ID, Tourn_Date, SourceDB) 
SELECT T_Descriprion, Total_Price, T_ID, T_Date, 1 FROM Tournament1;
--Conversion from dollars to euro
INSERT INTO Tournament_Stage (Tournament_Desc, Total_Price, Tourn_ID, Tourn_Date, SourceDB) 
SELECT T_Descriprion, (Total_Price/1.3), T_ID, T_Date, 2 FROM Tournament2; 

--INSERTS NOW DONE, TEST SELECT TO SEE THEY ARE INSERTED
SELECT * FROM Tournament_Stage;

--Load Dimension Tournament
INSERT INTO DimTournament SELECT DISTINCT Tournament_SK, Tournament_Desc, Total_Price From Tournament_Stage;

--Check the dimension table
SELECT * FROM DimTournament;

--Load Dimension Date

CREATE TABLE Date_Stage (
    Date_SK INTEGER PRIMARY KEY,
    Day_Value INTEGER,
    Month_Value VARCHAR(5),
    Year_Value INTEGER,
    Week_Value INTEGER,
    Quarter_Value INTEGER,
    DayOfWeek INTEGER,
    Tour_Date DATE, 
    SourceDB INTEGER
);

--Loop to add dates from Tournament1 and Tournament2 into the date staging area 
DROP SEQUENCE d_stage_seq;

CREATE SEQUENCE d_stage_seq
START WITH 1
INCREMENT BY 1
nomaxvalue;

--DROP TRIGGER d_stage_trigger;
CREATE OR REPLACE TRIGGER d_stage_trigger
AFTER INSERT ON Date_Stage FOR EACH ROW
BEGIN
    SELECT d_stage_seq.nextval into :new.Date_SK FROM dual;
END;

INSERT INTO DATE_STAGE (Day_Value, Month_Value, Year_Value, Week_Value, Quarter_Value, DayOfWeek, TOUR_DATE, SourceDB)
    SELECT DISTINCT cast(to_char(t_date,'DD') AS INTEGER), cast(to_char(t_date,'MM') AS INTEGER), 
    cast(to_char(t_date,'YYYY') AS INTEGER),cast(to_char(t_date,'WW') AS INTEGER),
    cast(to_char(t_date,'Q') AS INTEGER), cast(to_char(t_date,'D') AS INTEGER), T_Date, 1 FROM Tournament1;

INSERT INTO DATE_STAGE (Day_Value, Month_Value, Year_Value, Week_Value, Quarter_Value, DayOfWeek, TOUR_DATE, SourceDB)
    SELECT DISTINCT cast(to_char(t_date,'DD') AS INTEGER), cast(to_char(t_date,'MM') AS INTEGER), 
    cast(to_char(t_date,'YYYY') AS INTEGER),cast(to_char(t_date,'WW') AS INTEGER),
    cast(to_char(t_date,'Q') AS INTEGER), cast(to_char(t_date,'D') AS INTEGER), T_Date, 2 FROM Tournament2;

--INSERTS NOW DONE, TEST SELECT TO SEE THEY ARE INSERTED
SELECT * FROM Date_Stage;

--Load Dimension Date
INSERT INTO DimDate SELECT DISTINCT Date_SK, Day_Value, Month_Value, Year_Value, Week_Value, Quarter_Value, DayOfWeek From Date_Stage;

--Check the dimension table
SELECT * FROM DimDate;

--Staging fact table
CREATE TABLE Fact_Stage (
    Player_SK INTEGER,
    Team_SK INTEGER,
    Tournament_SK INTEGER,
    Date_SK INTEGER,
    P_ID INTEGER,
    Tourn_ID INTEGER,
    T_ID INTEGER,
    T_DATE DATE,
    Rank_ INTEGER,
    PRICE INTEGER,
    SourceDB INTEGER
);

INSERT INTO Fact_Stage(P_ID, Tourn_ID, T_ID, T_Date, Rank_, PRICE, SourceDB) 
SELECT R1.P_ID, Tourn1.T_ID, R1.T_ID, Tourn1.T_Date, R1.Rank, R1.PRICE, 1 FROM Results1 R1
JOIN Players1 P1 on P1.P_ID = R1.P_ID
JOIN Team1 T1 on T1.TEAM_ID = P1.TEAM_ID
JOIN Tournament1 Tourn1 on Tourn1.T_ID = R1.T_ID; 

INSERT INTO Fact_Stage(P_ID, Tourn_ID, T_ID, T_Date, Rank_, PRICE, SourceDB) 
SELECT R2.P_ID, Tourn2.T_ID, R2.T_ID, Tourn2.T_Date, R2.Rank, R2.PRICE, 2 FROM Results2 R2
JOIN Players2 P2 on P2.P_ID = R2.P_ID
JOIN Team1 T2 on T2.TEAM_ID = P2.TEAM_ID
JOIN Tournament1 Tourn2 on Tourn2.T_ID = R2.T_ID; 

--Check the staging area, note! At this stage all SK will be null!
SELECT * FROM Fact_Stage;

--Assigning the surrogate keys
--Player_SK
UPDATE Fact_Stage
SET Player_SK =
    (SELECT Player_Stage.Player_SK FROM Player_Stage
        WHERE (Player_Stage.sourceDB = Fact_Stage.sourceDB AND
        Player_Stage.P_ID = Fact_Stage.P_ID)
    );
-- Normalize data
UPDATE Fact_Stage 
SET Player_SK = 1 
WHERE P_ID = 2
AND SourceDB = 2;

UPDATE Fact_Stage
SET Player_SK = 5 
WHERE P_ID = 1
AND SourceDB = 2;

--Team_SK
UPDATE Fact_Stage
SET Team_SK =
    (SELECT Team_Stage.Team_SK FROM Team_Stage 
        WHERE (Team_Stage.sourceDB = Fact_Stage.sourceDB AND
        Team_Stage.T_ID = Fact_Stage.Tourn_ID)
    );

-- Normalize data
UPDATE Fact_Stage 
SET Team_SK = 1 
WHERE T_ID = 3
AND SourceDB = 2;

--Tournament_SK
UPDATE Fact_Stage
SET Tournament_SK =
    (SELECT Tournament_Stage.Tournament_SK FROM Tournament_Stage 
        WHERE (Tournament_Stage.sourceDB = Fact_Stage.sourceDB AND
        TOURNAMENT_STAGE.TOURN_ID = FACT_STAGE.TOURN_ID)
    );   

--Date_SK
UPDATE Fact_Stage
SET Date_SK =
    (SELECT Date_Stage.Date_SK FROM Date_Stage 
        WHERE (Date_Stage.sourceDB = Fact_Stage.sourceDB
        AND Date_Stage.Tour_Date = Fact_Stage.T_Date)
    );

--Loading into Fact_Results
INSERT INTO Fact_Results SELECT Player_SK, Team_SK, Tournament_SK, Date_SK, Rank_, Price FROM Fact_Stage;

--Testing the Fact_Results
SELECT * FROM Fact_Results;

--Gathering new results from old databases
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (7, 'Alan', 'Parker', 1);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (8, 'Martha', 'Bag', 2);

INSERT INTO TOURNAMENT1 (T_ID, T_DESCRIPRION, TOTAL_PRICE) VALUES (5, 'Saudi Open', 500000);

INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (5, 1, 1, 60000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (5, 7, 5, 20000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (2, 8, 3, 1000);

INSERT INTO Player_Stage (Player_Name, P_ID, SourceDB)
SELECT P_Name, P_ID, 1 FROM Players1 WHERE NOT EXISTS (
    SELECT * FROM Player_Stage PS 
    WHERE PS.P_ID = Players1.P_ID
    AND PS.SourceDB = 1
);

INSERT INTO DimPlayer (Player_SK, Player_Name)
SELECT PS.Player_SK, PS.Player_Name FROM Player_Stage PS
WHERE NOT EXISTS (
    SELECT * FROM DimPlayer DP
    WHERE PS.Player_SK = DP.Player_SK
    OR DP.Player_Name = PS.Player_Name
);

--Insert tournament data
INSERT INTO Tournament_Stage (Tournament_Desc, Total_Price, Tourn_ID, Tourn_Date, SourceDB)
SELECT T_Descriprion, Total_Price, T_ID, T_Date, 1 FROM Tournament1 WHERE NOT EXISTS (
    SELECT * FROM Tournament_Stage TS 
    WHERE TS.Tourn_ID = Tournament1.T_ID
    AND TS.SourceDB = 1
);

INSERT INTO DimTournament (Tournament_SK, Tournament_Desc, Total_Price)
SELECT Tournament_SK, Tournament_Desc, Total_Price FROM Tournament_Stage TS
WHERE NOT EXISTS (
    SELECT * FROM DimTournament DT WHERE TS.Tournament_SK = DT.Tournament_SK
);

--Insert date data
INSERT INTO DATE_STAGE (Day_Value, Month_Value, Year_Value, Week_Value, Quarter_Value, DayOfWeek, TOUR_DATE, SourceDB)
SELECT DISTINCT cast(to_char(t_date,'DD') AS INTEGER), cast(to_char(t_date,'MM') AS INTEGER), 
    cast(to_char(t_date,'YYYY') AS INTEGER),cast(to_char(t_date,'WW') AS INTEGER),
    cast(to_char(t_date,'Q') AS INTEGER), cast(to_char(t_date,'D') AS INTEGER), T_Date, 1 
FROM Tournament1 WHERE NOT EXISTS ( 
    SELECT * FROM DATE_STAGE DS
    WHERE DS.Tour_Date = Tournament1.T_Date
    AND DS.SourceDB = 1
);

INSERT INTO DimDate (Date_SK, Day_Value, Month_Value, Year_Value, Week_Value, Quarter_Value, DayOfWeek)
SELECT Date_SK, Day_Value, Month_Value, Year_Value, Week_Value, Quarter_Value, DayOfWeek FROM Date_Stage DS
WHERE NOT EXISTS ( 
    SELECT * FROM DimDate DD WHERE DD.Date_SK = DS.Date_SK 
);

--Insert result data
INSERT INTO Fact_Stage(P_ID, Tourn_ID, T_ID, T_Date, Rank_, PRICE, SourceDB) 
SELECT R1.P_ID, Tourn1.T_ID, R1.T_ID, Tourn1.T_Date, R1.Rank, R1.PRICE, 1 FROM Results1 R1
JOIN Players1 P1 on P1.P_ID = R1.P_ID
JOIN Team1 T1 on T1.TEAM_ID = P1.TEAM_ID
JOIN Tournament1 Tourn1 on Tourn1.T_ID = R1.T_ID WHERE NOT EXISTS (
    SELECT * FROM Fact_Stage FS
    WHERE FS.P_ID = R1.P_ID
    AND FS.Tourn_ID = R1.T_ID
    AND FS.T_ID = T1.TEAM_ID
);

--Phase 2 of Assigning surrogate keys

UPDATE Fact_Stage
SET Player_SK =
    (SELECT Player_Stage.Player_SK FROM 
    Player_Stage WHERE (Player_Stage.sourceDB = Fact_Stage.sourceDB AND
    Player_Stage.P_ID = Fact_Stage.P_ID)
);

-- Normalize data
UPDATE Fact_Stage 
SET Player_SK = 1 
WHERE P_ID = 2
AND SourceDB = 2;

UPDATE Fact_Stage
SET Player_SK = 5 
WHERE P_ID = 1
AND SourceDB = 2;

--Tournament_SK
UPDATE Fact_Stage
SET Tournament_SK =
    (SELECT Tournament_Stage.Tournament_SK FROM Tournament_Stage WHERE (
    Tournament_Stage.sourceDB = Fact_Stage.sourceDB 
    AND TOURNAMENT_STAGE.TOURN_ID = FACT_STAGE.TOURN_ID)
);   

--Team_SK
UPDATE Fact_Stage
SET Team_SK =
    (SELECT Team_Stage.Team_SK FROM 
    Team_Stage WHERE (Team_Stage.sourceDB = Fact_Stage.sourceDB AND
    Team_Stage.T_ID = Fact_Stage.Tourn_ID)
);

-- Normalize data
UPDATE Fact_Stage 
SET Team_SK = 1 
WHERE T_ID = 3
AND SourceDB = 2;

--Date_SK

UPDATE Fact_Stage
SET Date_SK =
    (SELECT Date_Stage.Date_SK FROM 
    Date_Stage WHERE (Date_Stage.sourceDB = Fact_Stage.sourceDB
    AND Date_Stage.Tour_Date = Fact_Stage.T_Date)
);

--Insert into Fact_Results
INSERT INTO Fact_Results SELECT Player_SK, Team_SK, Tournament_SK, Date_SK, Rank_, Price 
FROM Fact_Stage FS WHERE NOT EXISTS (
    SELECT * FROM Fact_Results 
    WHERE Fact_Results.Player_SK = FS.Player_SK
    AND Fact_Results.Tournament_SK = FS.Tournament_SK
    AND Fact_Results.Team_SK = FS.Team_SK
    AND Fact_Results.Date_SK = FS.Date_SK
);

--Ensure the warehouase is updated successfully
SELECT * FROM Fact_Results;