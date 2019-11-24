DROP TABLE TEAMSTAGE;
DROP TABLE PLAYERSTAGE;
DROP TABLE TOURNAMENTSTAGE;
DROP TABLE RESULTSSTAGE;
DROP TABLE DATESTAGE;

CREATE TABLE TEAMSTAGE 
(
    Team_id integer not null,
    Team_name varchar(100) not null, 
    dbsourceid integer not null,
    Team_skey integer not null
);

CREATE TABLE PLAYERSTAGE
(
    p_id integer ,
    p_name varchar(50),
    p_sname varchar(50),
    team_id integer,
    dbsourceid INTEGER,
    p_skey INTEGER
);

CREATE TABLE TOURNAMENTSTAGE
(
    t_id integer,
    t_descriprion varchar(100),
    Total_price float,
    dbsourceid INTEGER,
    t_skey INTEGER
);

CREATE TABLE RESULTSSTAGE
(
    t_id integer,
    p_id integer,
    rank integer,
    price float,
    dbsourceid INTEGER,
    r_skey INTEGER
);

CREATE TABLE DATESTAGE
(
    tournament_id INTEGER NOT NULL,
    date_sk INTEGER NOT NULL,
    day INTEGER NOT NULL,
    month INTEGER NOT NULL,
    year INTEGER NOT NULL,
    week INTEGER NOT NULL,
    quarter INTEGER NOT NULL,
    dayofweek INTEGER NOT NULL,
    dbsourceid INTEGER
);

COMMIT;
/*
SELECT * FROM TEAMSTAGE;
SELECT * FROM PLAYERSTAGE;
SELECT * FROM TOURNAMENTSTAGE;
SELECT * FROM RESULTSSTAGE;
SELECT * FROM DATESTAGE;*/