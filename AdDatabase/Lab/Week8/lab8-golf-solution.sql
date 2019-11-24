--The drop tables statement for the star schema
DROP TABLE FACT_RESULTS;
DROP TABLE PLAYERDIM;
DROP TABLE TEAMDIM;
DROP TABLE TOURNAMENTDIM;
DROP TABLE DATEDIMENSION;

--create the tables for the star schema
--the dimensional tables for the fact table
CREATE TABLE DATEDIMENSION 
(
    date_sk INTEGER NOT NULL,
    day INTEGER NOT NULL,
    month INTEGER NOT NULL,
    year INTEGER NOT NULL,
    week INTEGER NOT NULL,
    quarter INTEGER NOT NULL,
    dayofweek INTEGER NOT NULL,
    --constraints
    CONSTRAINT date_pk PRIMARY KEY (date_sk)
);

CREATE TABLE TOURNAMENTDIM
(
    tournament_sk INTEGER NOT NULL,
    tournament_desc VARCHAR2(50) NOT NULL,
    totalprice float NOT NULL,
    CONSTRAINT tournament_pk PRIMARY KEY (tournament_sk)
);

CREATE TABLE TEAMDIM
(
    team_sk INTEGER NOT NULL,
    team_name VARCHAR2(50) NOT NULL,
    CONSTRAINT team_pk PRIMARY KEY (team_sk)
);

CREATE TABLE PLAYERDIM
(
    player_sk INTEGER NOT NULL,
    player_name VARCHAR2(50) NOT NULL,
    CONSTRAINT player_pk PRIMARY KEY (player_sk)
);

--the fact table itself
CREATE TABLE FACT_RESULTS
(
    date_sk INTEGER NOT NULL,
    tournament_sk INTEGER NOT NULL,
    team_sk INTEGER NOT NULL,
    player_sk INTEGER NOT NULL,
    rank INTEGER NOT NULL,
    price float NOT NULL,
    --setting the foreign keys
    CONSTRAINT date_fk FOREIGN KEY (date_sk)
    REFERENCES DATEDIMENSION (date_sk),
    CONSTRAINT tournamanet_fk FOREIGN KEY (tournament_sk)
    REFERENCES TOURNAMENTDIM (tournament_sk),
    CONSTRAINT team_fk FOREIGN KEY (team_sk)
    REFERENCES TEAMDIM (team_sk),
    CONSTRAINT player_fk FOREIGN KEY (player_sk)
    REFERENCES PLAYERDIM (player_sk),

    CONSTRAINT FACT_TABLE_PK PRIMARY KEY 
    (date_sk,tournament_sk,team_sk,player_sk)
);

COMMIT;