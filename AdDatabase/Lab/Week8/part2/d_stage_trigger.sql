--DROP TRIGGER d_stage_trigger;
CREATE OR REPLACE TRIGGER d_stage_trigger
BEFORE INSERT ON Date_Stage FOR EACH ROW
BEGIN
    SELECT d_stage_seq.nextval into :new.Date_SK FROM dual;
END;