CREATE OR REPLACE TRIGGER VALIDCOUNTRYCOMPETETION
BEFORE INSERT ON MATCHES
FOR EACH ROW
DECLARE
--static variables to be used
PremierLeague VARCHAR(14) := 'Premier League';
LaLiga VARCHAR(7) := 'La Liga';
--variables to be inserted into
HomeTeamOrgin VARCHAR(50);
AwayTeamOrigin VARCHAR(50);
BEGIN
    IF :NEW.Competition LIKE PremierLeague THEN
        SELECT country INTO HomeTeamOrgin FROM TEAM WHERE TeamName LIKE :NEW.TeamAName;
        SELECT country INTO AwayTeamOrigin FROM TEAM WHERE TeamName LIKE :NEW.TeamBName;
        IF HomeTeamOrgin NOT LIKE 'England' OR AwayTeamOrigin NOT LIKE 'England' THEN
            RAISE_APPLICATION_ERROR(-20000,'trigger violated');
        END IF;
    END IF;
    IF :NEW.Competition LIKE LaLiga THEN
        SELECT country INTO HomeTeamOrgin FROM TEAM WHERE TeamName LIKE :NEW.TeamAName;
        SELECT country INTO AwayTeamOrigin FROM TEAM WHERE TeamName LIKE :NEW.TeamBName;
        IF HomeTeamOrgin NOT LIKE 'Spain' OR AwayTeamOrigin NOT LIKE 'Spain' THEN
            RAISE_APPLICATION_ERROR(-20000,'trigger violated');
        END IF;
    END IF;
END;