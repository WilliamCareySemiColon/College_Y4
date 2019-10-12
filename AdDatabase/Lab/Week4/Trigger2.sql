CREATE OR REPLACE TRIGGER CHECKTEAMMATCHESSTATUS
BEFORE INSERT ON MATCHES 
FOR EACH ROW
DECLARE 
HOMETEAMCOUNT INTEGER;
AWAYTEAMCOUNT INTEGER;
BEGIN
    SELECT COUNT(*) INTO HOMETEAMCOUNT FROM MATCHES WHERE TeamAName LIKE :NEW.TeamAName;
    SELECT COUNT(*) INTO AWAYTEAMCOUNT FROM MATCHES WHERE TeamBName LIKE :NEW.TeamBName;
    
    IF HOMETEAMCOUNT = 4 OR AWAYTEAMCOUNT = 4 THEN
        RAISE_APPLICATION_ERROR(-20000,'trigger violated');
    END IF;
    --if Team A won
    IF :NEW.GoalA > :NEW.GoalB THEN
        UPDATE EUROLEAGUE 
        SET points = points + 3,
        GoalsScored = GoalsScored + :NEW.GoalA,
        GoalsConceed = GoalsConceed + :NEW.GoalB, 
        Difference = GoalsScored - GoalsConceed
        WHERE TeamName LIKE :NEW.TeamAName;
        
        UPDATE EUROLEAGUE 
        SET  GoalsScored = GoalsScored + :NEW.GoalB,
        GoalsConceed = GoalsConceed + :NEW.GoalA, 
        Difference = GoalsScored - GoalsConceed
        WHERE TeamName LIKE :NEW.TeamBName;
    END IF;
    --if team b won
     IF :NEW.GoalB > :NEW.GoalA THEN
        UPDATE EUROLEAGUE 
        SET points = points + 3,
        GoalsScored = GoalsScored + :NEW.GoalB,
        GoalsConceed = GoalsConceed + :NEW.GoalA, 
        Difference = GoalsScored - GoalsConceed
        WHERE TeamName LIKE :NEW.TeamBName;
        
        UPDATE EUROLEAGUE 
        SET  GoalsScored = GoalsScored + :NEW.GoalA,
        GoalsConceed = GoalsConceed + :NEW.GoalB, 
        Difference = GoalsScored - GoalsConceed
        WHERE TeamName LIKE :NEW.TeamAName;
    END IF;    
     IF :NEW.GoalB = :NEW.GoalA THEN
        --If it is a draw
        UPDATE EUROLEAGUE 
        SET points = points + 1,
        GoalsScored = GoalsScored + :NEW.GoalB,
        GoalsConceed = GoalsConceed + :NEW.GoalA 
        WHERE TeamName LIKE :NEW.TeamBName;
        
        UPDATE EUROLEAGUE 
        SET points = points + 1,
        GoalsScored = GoalsScored + :NEW.GoalA,
        GoalsConceed = GoalsConceed + :NEW.GoalB 
        WHERE TeamName LIKE :NEW.TeamAName;
     END IF;
     UPDATE EUROLEAGUE
     SET Difference = GoalsScored - GoalsConceed;
END;