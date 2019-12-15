--load players into staging area
INSERT INTO Player_Stage (Player_name, P_ID, SourceDB) SELECT P_name, P_ID, 1 FROM Players1;
INSERT INTO Player_Stage (Player_name, P_ID, SourceDB) SELECT P_name, P_ID, 2 FROM Players2;

--Checking if the staging for the players has succeeded
SELECT * FROM Player_Stage;

--passing the players to dim model
INSERT INTO DimPlayer SELECT DISTINCT Player_SK, Player_Name From Player_Stage;

--Check the player passed successfully 
SELECT * FROM DimPlayer;

--loading teams into stage area
INSERT INTO Team_Stage (Team_name, T_ID, SourceDB) SELECT Team_name, Team_ID, 1 FROM Team1;
INSERT INTO Team_Stage (Team_name, T_ID, SourceDB) SELECT Team_name, Team_ID, 2 FROM Team2;

--Testing to see if the stage of the teams worked
SELECT * FROM Team_Stage;

--pass the team into the dim model
INSERT INTO DimTeam SELECT DISTINCT Team_SK, Team_Name From Team_Stage;

--Check the dimension table for the team
SELECT * FROM DimTeam;

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

COMMIT;