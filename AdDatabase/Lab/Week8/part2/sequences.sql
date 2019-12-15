--Loop to add players from Players1 and Players 2 into DimPlayers
DROP SEQUENCE p_stage_seq;

CREATE SEQUENCE p_stage_seq 
START WITH 1
INCREMENT BY 1
nomaxvalue;

--Loop to add teams from Team1 and Team2 into the team staging area
DROP SEQUENCE t_stage_seq;
CREATE SEQUENCE t_stage_seq
START WITH 1
INCREMENT BY 1
nomaxvalue;

DROP SEQUENCE trn_stage_seq;
CREATE SEQUENCE trn_stage_seq
START WITH 1
INCREMENT BY 1
nomaxvalue;

--Loop to add dates from Tournament1 and Tournament2 into the date staging area 
DROP SEQUENCE d_stage_seq;

CREATE SEQUENCE d_stage_seq
START WITH 1
INCREMENT BY 1
nomaxvalue;