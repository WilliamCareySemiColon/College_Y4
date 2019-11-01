--expect to work
INSERT INTO MATCHES VALUES (MATCHES_ID.nextval, 'Arsenal','Chelsea',0,1,'Premier League');
--expect to work
INSERT INTO MATCHES VALUES (MATCHES_ID.nextval, 'Barcelona','Real Madrid',5,1,'La Liga');
--expect to fail
--INSERT INTO MATCHES VALUES (MATCHES_ID.nextval, 'Arsenal','Real Madrid',0,1,'Premier League');
--expect to succeed
INSERT INTO MATCHES VALUES (MATCHES_ID.nextval, 'Arsenal','Real Madrid',0,1,'Champions League');

INSERT INTO MATCHES VALUES (MATCHES_ID.nextval, 'Chelsea','Barcelona',3,2,'Champions League');

COMMIT;