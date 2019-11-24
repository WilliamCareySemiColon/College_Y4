CREATE OR REPLACE TRIGGER RESULTSTAGETRIGGER
AFTER INSERT ON RESULTSSTAGE FOR EACH ROW
DECLARE 
FACTSCOUNT INTEGER;
--VARIABLES TO WORK WITH FOR THE APPLIVSTION
DATESK INTEGER;
TOURNAMENTSK INTEGER;
TEAMSK INTEGER;
PLAYERSK INTEGER;
BEGIN
    --getting the date sk
    SELECT date_sk INTO DATESK FROM DATESTAGE
    WHERE tournament_id =(
        SELECT t_id FROM TOURNAMENTSTAGE
        WHERE t_id = :NEW.t_id
    );
    --getting the team sk
    SELECT Team_skey INTO TEAMSK FROM TEAMSTAGE
    WHERE Team_id = (
        SELECT team_id FROM PLAYERSTAGE
        WHERE p_id = :NEW.p_id
    );
    --getting the TOURNAMENT sk
    SELECT t_skey INTO TOURNAMENTSK FROM TOURNAMENTSTAGE
    WHERE t_id = :NEW.t_id;
    
    --getting the PLAYER sk
    SELECT p_skey INTO PLAYERSK FROM PLAYERSTAGE 
    WHERE p_id = :NEW.p_id;
    
    ---checking if the data already exist inside the table
    SELECT COUNT(*) INTO FACTSCOUNT FROM FACT_RESULTS
    WHERE team_sk = TEAMSK 
    AND date_sk = DATESK
    AND tournament_sk = TOURNAMENTSK
    AND player_sk = PLAYERSK;
    
    --since the data does not exist already, We insert it in
    IF(FACTSCOUNT = 0)THEN
        INSERT INTO FACT_RESULTS 
        VALUES(DATESK,TOURNAMENTSK,TEAMSK,PLAYERSK,
        :NEW.rank,:NEW.price);
        --COMMIT;
    END IF;    
END;


/*CREATE TABLE RESULTSSTAGE
(
    t_id integer,
    p_id integer,
    rank integer,
    price float,
    dbsourceid INTEGER,
    r_skey INTEGER
);

REATE TABLE FACT_RESULTS
(
    date_sk INTEGER NOT NULL,
    tournament_sk INTEGER NOT NULL,
    team_sk INTEGER NOT NULL,
    player_sk INTEGER NOT NULL,
    rank INTEGER NOT NULL,
    price NUMBER(4,2) NOT NULL,
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
*/