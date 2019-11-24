CREATE OR REPLACE TRIGGER PLAYERDBTWOTRIGGER
BEFORE INSERT ON Players2
FOR EACH ROW
DECLARE 
DATACOUNT INTEGER;
DATAEXISTCOUNT INTEGER;
SKEY INTEGER;
BEGIN
    SELECT COUNT(*) INTO DATACOUNT FROM PLAYERSTAGE;
    IF(DATACOUNT != 0)THEN 
        --testing if the data insertion already exist inside the table
        SELECT COUNT(*) INTO DATAEXISTCOUNT FROM PLAYERSTAGE
        WHERE p_name LIKE :NEW.p_name AND p_sname LIKE :NEW.p_sname;
        IF(DATAEXISTCOUNT != 0)THEN
            --get the skey and assign it to the new insertion
            SELECT p_skey INTO SKEY FROM PLAYERSTAGE
            WHERE p_name LIKE :NEW.p_name AND p_sname LIKE :NEW.p_sname;
        ELSE
            --some data exists, so we get the max, add 1, and add it to the new data
            SELECT MAX(p_skey) + 1 INTO SKEY FROM PLAYERSTAGE;
        END IF;
    ELSE
        --this is the first data inserted into the staging process
        SKEY := 1;
    END IF;
    --insert the data into the table
    INSERT INTO PLAYERSTAGE 
    VALUES (:NEW.p_id,:NEW.p_name,:NEW.p_sname,:NEW.team_id,2,SKEY);
END;