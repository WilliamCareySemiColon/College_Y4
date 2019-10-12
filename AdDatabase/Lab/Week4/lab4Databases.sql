--sequence for the schema
DROP SEQUENCE Matches_id;

CREATE SEQUENCE Matches_id
START WITH 1
INCREMENT BY 1
NOCACHE 
NOCYCLE; 

--Dropping the tables
DROP TABLE LOGTEAM;
DROP TABLE EUROLEAGUE;
DROP TABLE MATCHES;
DROP TABLE TEAM;

--Creating the tables
CREATE TABLE TEAM
(
    TeamName VARCHAR(50) NOT NULL,
    country VARCHAR(50),
    --constraints
    CONSTRAINT name_pk PRIMARY KEY (TeamName),
    CONSTRAINT country_ck CHECK
    (country LIKE 'England' OR country LIKE 'Spain')
);

CREATE TABLE MATCHES
(
    ID INTEGER NOT NULL, 
    TeamAName VARCHAR(50), 
    TeamBName VARCHAR(50),
    GoalA INTEGER,
    GoalB INTEGER,
    Competition VARCHAR(50),
    --constraints on the team
    CONSTRAINT ID_PK PRIMARY KEY (ID),
    CONSTRAINT TeamAName_FK FOREIGN KEY (TeamAName)
    REFERENCES TEAM(TeamName),
    CONSTRAINT TeamBName_FK FOREIGN KEY (TeamBName)
    REFERENCES TEAM(TeamName),
    CONSTRAINT Competition_CK CHECK
    (
        Competition LIKE 'Champions League' OR 
        Competition LIKE 'Europa League' OR 
        Competition LIKE 'Premier League' OR 
        Competition LIKE 'La Liga' 
    ),
    CONSTRAINT GOALS_CK CHECK ( 
    GoalA > -1 AND GoalB > -1 )
);

CREATE TABLE EUROLEAGUE
(
    TeamName VARCHAR(50),
    points INTEGER, 
    GoalsScored INTEGER,
    GoalsConceed INTEGER,
    Difference INTEGER,
    --constraints
    CONSTRAINT GOALS_CK2 CHECK ( 
    GoalsScored > -1 AND GoalsConceed > -1 ),
    CONSTRAINT TeamName_PK PRIMARY KEY (TeamName),
    CONSTRAINT TeamName_FK FOREIGN KEY (TeamName)
    REFERENCES TEAM(TeamName)
);

--table to store all time stamps
CREATE TABLE LOGTEAM 
(
    TeamName VARCHAR(50),
    TimeInserted TIMESTAMP,
    CONSTRAINT TeamName_PK2 PRIMARY KEY (TeamName),
    CONSTRAINT TeamName_FK2 FOREIGN KEY (TeamName)
    REFERENCES TEAM(TeamName)
);

--Create the triggers
CREATE OR REPLACE TRIGGER TEAMINSERTION
AFTER INSERT ON TEAM
FOR EACH ROW
DECLARE
LeagueCount INTEGER;
BEGIN
    INSERT INTO LOGTEAM VALUES(:NEW.TeamName,CURRENT_TIMESTAMP);
    SELECT COUNT(*) INTO LeagueCount FROM EUROLEAGUE
    WHERE teamname LIKE :NEW.TeamName;
    
    IF LeagueCount = 0 THEN
    INSERT INTO EUROLEAGUE VALUES (:NEW.TeamName,0,0,0,0);
    END IF;
END; 