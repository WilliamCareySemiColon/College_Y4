CREATE OR REPLACE TRIGGER INSERTDBTWOVERSION
BEFORE INSERT ON Team2
FOR EACH ROW
DECLARE
DATACOUNT INTEGER;
DATAEXISTCOUNT INTEGER;
SKEY INTEGER;
BEGIN
    --testing if data is existed inside the table
    SELECT COUNT(*) INTO DATACOUNT FROM TEAMSTAGE;
    IF(DATACOUNT != 0)THEN 
        --testing if the data insertion already exist inside the table
        SELECT COUNT(*) INTO DATAEXISTCOUNT FROM TEAMSTAGE
        WHERE Team_name LIKE :NEW.Team_name;
        IF(DATAEXISTCOUNT != 0)THEN
            --get the skey and assign it to the new insertion
            SELECT Team_skey INTO SKEY FROM TEAMSTAGE
            WHERE Team_name = :NEW.Team_name;
        ELSE
            --some data exists, so we get the max, add 1, and add it to the new data
            SELECT MAX(Team_skey) + 1 INTO SKEY FROM TEAMSTAGE;
        END IF;
    ELSE
        --this is the first data inserted into the staging process
        SKEY := 1;
    END IF;
    --insert the data into the table
    INSERT INTO TEAMSTAGE 
    VALUES (:NEW.Team_id,:NEW.Team_name,2,SKEY);
END;