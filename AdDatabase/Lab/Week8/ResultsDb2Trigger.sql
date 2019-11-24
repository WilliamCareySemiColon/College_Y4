CREATE OR REPLACE TRIGGER RESULTDBTWOVERSION
BEFORE INSERT ON RESULTS2
FOR EACH ROW
DECLARE
DATACOUNT INTEGER;
DATAEXISTCOUNT INTEGER;
SKEY INTEGER;
BEGIN
    --testing if data is existed inside the table
    SELECT COUNT(*) INTO DATACOUNT FROM RESULTSSTAGE;
    IF(DATACOUNT != 0)THEN 
        --testing if the data insertion already exist inside the table
        SELECT COUNT(*) INTO DATAEXISTCOUNT FROM RESULTSSTAGE
        WHERE t_id = :NEW.t_id AND p_id = :NEW.p_id;
        IF(DATAEXISTCOUNT != 0)THEN
            --get the skey and assign it to the new insertion
            SELECT r_skey INTO SKEY FROM RESULTSSTAGE
            WHERE t_id = :NEW.t_id AND p_id = :NEW.p_id;
        ELSE
            --some data exists, so we get the max, add 1, and add it to the new data
            SELECT MAX(r_skey) + 1 INTO SKEY FROM RESULTSSTAGE;
        END IF;
    ELSE
        --this is the first data inserted into the staging process
        SKEY := 1;
    END IF;
    --insert the data into the table
    --Adding the conversion rate from $ to euro
    INSERT INTO RESULTSSTAGE 
    VALUES (:NEW.t_id,:NEW.p_id,:NEW.rank, ROUND(:NEW.price / 1.3,2),2,SKEY);
END;