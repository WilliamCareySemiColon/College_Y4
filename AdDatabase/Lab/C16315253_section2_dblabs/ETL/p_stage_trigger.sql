DROP TRIGGER p_stage_trigger;
CREATE TRIGGER p_stage_trigger
BEFORE INSERT ON Player_Stage FOR EACH ROW
BEGIN
    SELECT p_stage_seq.nextval INTO :NEW.Player_SK FROM dual;
END;