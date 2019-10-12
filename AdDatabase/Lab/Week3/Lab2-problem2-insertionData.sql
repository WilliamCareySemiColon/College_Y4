/*Implementation of the normalised data table*/
----------------------------Student Id 1 - Mark--------------------------------
--First Row Data Normalised
INSERT INTO ADDRESS VALUES ('NY234','Grafton Street','New York');
INSERT INTO STUDENT VALUES (1,'Mark','NY234');
INSERT INTO PRIORSCHOOL VALUES (1,'Castleknock');
INSERT INTO StudentPriorSchool VALUES (1,1,65);
INSERT INTO REFERENCESPEC VALUES ('Dr. Jones','Trinity College');
INSERT INTO StudentReference VALUES (1,'Dr. Jones','Trinity College','Good Guy');
INSERT INTO ApplicationSpec VALUES (1,2003);
INSERT INTO StudentApp VALUES (1,1,2003);
--Second Row
INSERT INTO ApplicationSpec VALUES (1,2004);
INSERT INTO StudentApp VALUES (1,1,2004);
--Third Row
INSERT INTO ADDRESS VALUES ('Flo435','White Street','Florida');
UPDATE STUDENT SET Zipcode = 'Flo435' WHERE StudentID = 1;
INSERT INTO ApplicationSpec VALUES (2,2007);
INSERT INTO StudentApp VALUES (1,2,2007);
--fourth row
INSERT INTO PRIORSCHOOL VALUES (2,'Loreto College');
INSERT INTO StudentPriorSchool VALUES (1,2,87);
--fifth row
INSERT INTO REFERENCESPEC VALUES ('Dr. Jones','U Limerick');
INSERT INTO StudentReference VALUES (1,'Dr. Jones','U Limerick','Very Good Guy');
INSERT INTO ApplicationSpec VALUES (3,2012);
INSERT INTO StudentApp VALUES (1,3,2012);
--no need to implement anything from the sixth row
------------------------------------Student Id 2 - Sarah------------------------
--1st row
INSERT INTO ADDRESS VALUES ('Cal123','Green Road','California');
INSERT INTO STUDENT VALUES (2,'Sarah','Cal123');
--INSERT INTO PRIORSCHOOL VALUES (1,'Castleknock');
INSERT INTO StudentPriorSchool VALUES (2,1,90);
INSERT INTO REFERENCESPEC VALUES ('Dr. Byrne','DIT');
INSERT INTO StudentReference VALUES (2,'Dr. Byrne','DIT','Perfect');
INSERT INTO ApplicationSpec VALUES (2,2010);
INSERT INTO StudentApp VALUES (2,2,2010);
--second row
INSERT INTO PRIORSCHOOL VALUES (3,'St. Patrick');
INSERT INTO StudentPriorSchool VALUES (2,3,76);
--third row
INSERT INTO ApplicationSpec VALUES (2,2011);
INSERT INTO StudentApp VALUES (2,2,2011);
--fourth row --nothing new
--fifth row
INSERT INTO REFERENCESPEC VALUES ('Dr. Byrne','UCD');
INSERT INTO StudentReference VALUES (2,'Dr. Byrne','UCD','Average');
INSERT INTO ApplicationSpec VALUES (2,2012);
INSERT INTO StudentApp VALUES (2,2,2012);
--sixth row -- nothing new
--seventh row
INSERT INTO PRIORSCHOOL VALUES (4,'DBS');
INSERT INTO StudentPriorSchool VALUES (2,4,66);
--eight row
INSERT INTO PRIORSCHOOL VALUES (5,'Harvard');
INSERT INTO StudentPriorSchool VALUES (2,5,45);
---------------------------------------Student Id 3 - Paul---------------
--first row inserted
INSERT INTO ADDRESS VALUES ('Ca455','Red Crescent','Carolina');
INSERT INTO STUDENT VALUES (3,'Paul','NY234');
INSERT INTO StudentPriorSchool VALUES (3,1,45);
INSERT INTO StudentReference VALUES (3,'Dr. Jones','Trinity College','Poor');
INSERT INTO ApplicationSpec VALUES (1,2012);
INSERT INTO StudentApp VALUES (3,1,2012);
--row 2
INSERT INTO StudentPriorSchool VALUES (3,3,67);
--row three
INSERT INTO StudentPriorSchool VALUES (3,4,23);
--row four
INSERT INTO StudentPriorSchool VALUES (3,5,67);
--row five
INSERT INTO ADDRESS VALUES ('Mex1','Yellow Park','Mexico');
UPDATE STUDENT SET ZipCode = 'Mex1' WHERE StudentID = 3;
INSERT INTO REFERENCESPEC VALUES ('Prof. Cahill','UCC');
INSERT INTO StudentReference VALUES (3,'Prof. Cahill','UCC','Excellent');
INSERT INTO ApplicationSpec VALUES (3,2008);
INSERT INTO StudentApp VALUES (3,3,2008);
--row 6,7 and 8 do not need to be implemented
---------------------------------------Student Id 4 - Jack---------------
--row 1
INSERT INTO ADDRESS VALUES ('Oh34','Dartry Road','Ohio');
INSERT INTO STUDENT VALUES (4,'Jack','Oh34');
INSERT INTO StudentPriorSchool VALUES (4,3,29);
INSERT INTO REFERENCESPEC VALUES ('Prof. Lillis','DIT');
INSERT INTO StudentReference VALUES (4,'Prof. Lillis','DIT','Fair');
INSERT INTO ApplicationSpec VALUES (1,2009);
INSERT INTO StudentApp VALUES (4,1,2009);
--row 2
INSERT INTO StudentPriorSchool VALUES (4,4,88);
--row three
INSERT INTO StudentPriorSchool VALUES (4,5,66);
---------------------------------------Student Id 5 - Mary---------------
--row 1
INSERT INTO ADDRESS VALUES ('IRE','Malahide Road','Ireland');
INSERT INTO STUDENT VALUES (5,'Mary','IRE');
INSERT INTO StudentPriorSchool VALUES (5,3,44);
INSERT INTO StudentReference VALUES (5,'Prof. Lillis','DIT','Good girl');
INSERT INTO ApplicationSpec VALUES (2,2009);
INSERT INTO StudentApp VALUES (5,2,2009);
--row 2
INSERT INTO StudentPriorSchool VALUES (5,4,55);
--row three
INSERT INTO StudentPriorSchool VALUES (5,5,66);
--row 4
INSERT INTO StudentPriorSchool VALUES (5,1,74);
--row 5
INSERT INTO ADDRESS VALUES ('Kan45','Black Bay','Kansas');
UPDATE STUDENT SET ZipCode = 'Kan45' WHERE StudentID = 5;
INSERT INTO StudentReference VALUES (5,'Dr. Byrne','DIT','Perfect');
INSERT INTO ApplicationSpec VALUES (1,2005);
INSERT INTO StudentApp VALUES (5,1,2005);
--row 6 & 7 are unnessary to executed
---------------------------------------Student Id 6 - Susan---------------
--row 1
INSERT INTO ADDRESS VALUES ('Kan45-1','River Road','Kansas');
INSERT INTO STUDENT VALUES (6,'Susan','Kan45-1');
INSERT INTO StudentPriorSchool VALUES (6,1,88);
INSERT INTO StudentReference VALUES (6,'Prof. Cahill','UCC','Messy');
INSERT INTO ApplicationSpec VALUES (3,2011);
INSERT INTO StudentApp VALUES (6,3,2011);
--row 2
INSERT INTO StudentPriorSchool VALUES (6,3,77);
--row 3
INSERT INTO StudentPriorSchool VALUES (6,4,56);
INSERT INTO StudentPriorSchool VALUES (6,2,45);

COMMIT;