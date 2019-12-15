--DROP TRIGGER trn_stage_trigger;
CREATE OR REPLACE TRIGGER trn_stage_trigger
BEFORE INSERT ON Tournament_Stage FOR EACH ROW
BEGIN
    SELECT trn_stage_seq.nextval into :new.Tournament_SK FROM dual;
END;