
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


--creating the team stage
CREATE TABLE Team_Stage (
    Team_SK INTEGER PRIMARY KEY,
    Team_name VARCHAR(50),
    T_ID INTEGER, 
    SourceDB INTEGER
);

--create the tournament stage process
CREATE TABLE Tournament_Stage (
    Tournament_SK INTEGER PRIMARY KEY,
    Tournament_Desc VARCHAR(100),
    Total_Price INTEGER,
    Tourn_ID INTEGER,
    Tourn_Date DATE, 
    SourceDB INTEGER
);

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

COMMIT;