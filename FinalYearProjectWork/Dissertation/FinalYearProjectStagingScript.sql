--SQL SCRIPT to gather the data from datasets for FYP usage

DROP TABLE FOODSTAGE;
DROP TABLE FOOD;
DROP TABLE FoodCategory;
DROP TABLE DIET;
DROP TABLE UserSpec;
DROP TABLE NutritionDiesease;
DROP TABLE NutritionDeficiency;
DROP TABLE LOGGEDDATA;
DROP TABLE USERLOGGEDDATA;

CREATE TABLE FoodCategory(
	name VARCHAR(20) PRIMARY KEY, 
	description VARCHAR(500),
	icon BLOB
);

CREATE TABLE FOOD (
	FoodID INTEGER PRIMARY KEY,
    --FoodStageShortNAME VARCHAR(50),
    FoodStageNAME VARCHAR(1000),
    ServingAmountInGrams INTEGER,
    Calories FLOAT,
    WaterInMLAndGrams FLOAT,
    CarbsINGrams FLOAT,
    SugarInGrams FLOAT,
    FiberInGrams FLOAT, 
    ProteinInGrams FLOAT,
    NonEssProteinInGrams FLOAT,
    FatInGrams FLOAT,
    SaturatedFatInGrams FLOAT,
    CholesterolInMicrograms FLOAT--,
	--FoodIGM BLOB,
	--FoodCategory VARCHAR(20)
);
CREATE TABLE FoodStage (
    FoodStageID INTEGER PRIMARY KEY,
    FoodStageSK INTEGER,
	--FoodStageShortNAME VARCHAR(50),
    FoodStageNAME VARCHAR(1000),
    ServingAmountInGrams INTEGER,
    Calories FLOAT,
    WaterInMLAndGrams FLOAT,
    CarbsINGrams FLOAT,
    SugarInGrams FLOAT,
    FiberInGrams FLOAT, 
    ProteinInGrams FLOAT,
    NonEssProteinInGrams FLOAT,
    FatInGrams FLOAT,
    SaturatedFatInGrams FLOAT,
    CholesterolInMicrograms FLOAT--,
	--FoodIGM BLOB,
	--FoodCategory VARCHAR(20)
);

SELECT * FROM  FOODSTAGE;
--The new tables within the database

CREATE TABLE DIET (
	id VARCHAR(14) PRIMARY KEY, 
	img BLOB,
	description VARCHAR(500)
);

CREATE TABLE UserSpec (
	name VARCHAR(50),
	username VARCHAR(50) PRIMARY KEY,
	password VARCHAR(20),
	email VARCHAR(50),
	SEXCategory VARCHAR(8),
	AGECategory INTEGER,
	diet VARCHAR(14),
	img BLOB,
	--the constraints within the application
	CONSTRAINT diet_fk FOREIGN KEY (diet)
	REFERENCES DIET(id)
);

CREATE TABLE NutritionDiesease (
	name VARCHAR(50) PRIMARY KEY,
	description VARCHAR(500),
	img BLOB
);

CREATE TABLE NutritionDeficiency (
	name VARCHAR(50) PRIMARY KEY,
	description VARCHAR(500),
	img BLOB ,
	nuteDisease VARCHAR(50),
	--constraints
	CONSTRAINT nuteDisease_fk FOREIGN KEY (nuteDisease)
	REFERENCES  NutritionDiesease (name)
);

CREATE TABLE LOGGEDDATA (
	loggedDataID INTEGER PRIMARY KEY,
	breakfast VARCHAR(1000),
	BFsnack VARCHAR(100),
	brunch VARCHAR(1000),
	BRsnack VARCHAR(100),
	lunch VARCHAR(1000),
	LHsnack VARCHAR(100),
	dunch VARCHAR(1000),
	DHsnack VARCHAR(100),
	dinner VARCHAR(1000),
	DRsnack VARCHAR(100),
	supper VARCHAR(1000),
	SRSnack VARCHAR(100)
);

CREATE TABLE USERLOGGEDDATA (
	username VARCHAR(50),
	loggedDataID INTEGER,
	--constraints
);