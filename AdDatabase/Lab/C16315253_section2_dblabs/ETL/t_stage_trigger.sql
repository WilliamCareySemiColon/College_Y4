--DROP TRIGGER t_stage_trigger;
CREATE OR REPLACE TRIGGER t_stage_trigger
BEFORE INSERT ON Team_Stage FOR EACH ROW
BEGIN
    SELECT t_stage_seq.nextval into :new.Team_SK FROM dual;
END;