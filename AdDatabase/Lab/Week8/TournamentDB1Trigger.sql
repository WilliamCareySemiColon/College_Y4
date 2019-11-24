CREATE OR REPLACE TRIGGER TOURNAMENTDBONETRIGGER
BEFORE INSERT ON Tournament1
FOR EACH ROW
DECLARE 
DATACOUNT INTEGER;
DATAEXISTCOUNT INTEGER;
SKEY INTEGER;
DATEDATACOUNT INTEGER;
DATEDATAEXISTCOUNT INTEGER; 
--variables to store the date variables into the datadim
DATESK INTEGER;
day INTEGER;
month INTEGER;
year INTEGER;
week INTEGER;
quarter INTEGER;
dayofweek INTEGER;
BEGIN
    --dealing with the tournament statement
    SELECT COUNT(*) INTO DATACOUNT FROM TOURNAMENTSTAGE;
    IF(DATACOUNT != 0)THEN 
        --testing if the data insertion already exist inside the table
        SELECT COUNT(*) INTO DATAEXISTCOUNT FROM TOURNAMENTSTAGE
        WHERE t_id = :NEW.t_id AND t_descriprion LIKE :NEW.t_descriprion;
        IF(DATAEXISTCOUNT != 0)THEN
            --get the skey and assign it to the new insertion
            SELECT t_skey INTO SKEY FROM TOURNAMENTSTAGE
            WHERE t_id = :NEW.t_id AND t_descriprion LIKE :NEW.t_descriprion;
        ELSE
            --some data exists, so we get the max, add 1, and add it to the new data
            SELECT MAX(t_skey) + 1 INTO SKEY FROM TOURNAMENTSTAGE;
        END IF;
    ELSE
        --this is the first data inserted into the staging process
        SKEY := 1;
    END IF;
    --insert the data into the table
    INSERT INTO TOURNAMENTSTAGE 
    VALUES (:NEW.t_id,:NEW.t_descriprion,:NEW.Total_price,1,SKEY);
    --now dealing with the date fields
    SELECT COUNT(*) INTO DATEDATACOUNT FROM DATESTAGE;
     IF(DATEDATACOUNT != 0)THEN 
        SELECT COUNT(*) INTO DATEDATAEXISTCOUNT FROM DATESTAGE
        WHERE tournament_id = :NEW.t_id 
        AND day = cast(to_char(:NEW.t_date,'DD') as integer)
        AND month = cast(to_char(:NEW.t_date,'MM') as integer) 
        AND year = cast(to_char(:NEW.t_date,'YYYY') as integer);
        IF(DATEDATAEXISTCOUNT != 0)THEN
            SELECT date_sk INTO DATESK FROM DATESTAGE
            WHERE tournament_id = :NEW.t_id 
            AND day = cast(to_char(:NEW.t_date,'DD') as integer)
            AND month = cast(to_char(:NEW.t_date,'MM') as integer) 
            AND year = cast(to_char(:NEW.t_date,'YYYY') as integer);
        ELSE
            SELECT MAX(date_sk) + 1 INTO DATESK FROM DATESTAGE;
        END IF;
    ELSE
        DATESK := 1;
    END IF;
    INSERT INTO DATESTAGE VALUES (:NEW.t_id, DATESK, cast(to_char(:NEW.t_date,'DD') as integer),
        cast(to_char(:NEW.t_date,'MM') as integer), cast(to_char(:NEW.t_date,'YYYY') as integer),
        cast(to_char(:NEW.t_date,'ww') as integer), cast(to_char(:NEW.t_date,'q') as integer),
        cast(to_char(:NEW.t_date,'d') as integer),1);
END;

/*
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
*/