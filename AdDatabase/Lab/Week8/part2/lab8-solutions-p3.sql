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

COMMIT;