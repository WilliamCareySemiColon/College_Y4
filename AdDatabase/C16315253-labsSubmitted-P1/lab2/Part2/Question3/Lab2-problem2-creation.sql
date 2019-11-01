--The creation of the normlised tables for the database

DROP TABLE StudentApp;
DROP TABLE ApplicationSpec;
DROP TABLE StudentReference;
DROP TABLE REFERENCESPEC;
DROP TABLE StudentPriorSchool;
DROP TABLE PRIORSCHOOL;
DROP TABLE STUDENT;
DROP TABLE ADDRESS;

CREATE TABLE ADDRESS
(
    ZipCode varchar(7),
  	Street varchar(100),
  	State varchar(30),
    CONSTRAINT ZipCode_PK PRIMARY KEY (ZipCode)
);

CREATE TABLE STUDENT
(
    StudentID integer, 
  	StudentName varchar(50),
	Zipcode varchar(7),
    CONSTRAINT StudentID_PK PRIMARY KEY (StudentID),
    CONSTRAINT ZipCode_FK FOREIGN KEY (ZipCode)
    REFERENCES ADDRESS (ZipCode)
);

CREATE TABLE PRIORSCHOOL
(
    PriorSchoolId integer, 
  	PriorSchoolAddr varchar(100),
    CONSTRAINT PriorSchoolId_PK PRIMARY KEY (PriorSchoolId)
);

CREATE TABLE StudentPriorSchool
(
	StudentID integer,
	PriorSchoolId integer,
  	GPA number(2),
    CONSTRAINT StudentID_SPS_FK FOREIGN KEY (StudentID)
    REFERENCES STUDENT (StudentID),
    CONSTRAINT PriorSchoolId_FK FOREIGN KEY (PriorSchoolId)
    REFERENCES PRIORSCHOOL (PriorSchoolId),
    CONSTRAINT StudentID_PriorSchoolId_PK PRIMARY KEY (StudentID, PriorSchoolId)
);    

CREATE TABLE REFERENCESPEC
(
    ReferenceName varchar(100),
    RefInstitution  varchar(100),
    CONSTRAINT ReferenceName_Instit_PK PRIMARY KEY (ReferenceName, RefInstitution)
);    

CREATE TABLE StudentReference
(
	StudentID integer,
	ReferenceName varchar(100),
	RefInstitution  varchar(100),
  	ReferenceStatement varchar(500),
    CONSTRAINT StudentID_SR_FK FOREIGN KEY (StudentID)
    REFERENCES STUDENT (StudentID),
    CONSTRAINT Reference_FK FOREIGN KEY (ReferenceName,RefInstitution)
    REFERENCES REFERENCESPEC (ReferenceName,RefInstitution),
    CONSTRAINT Student_Reference_PK PRIMARY KEY (StudentID,ReferenceName,RefInstitution)
);

CREATE TABLE ApplicationSpec
(
	App_No integer,
	App_Year integer,
    CONSTRAINT ApplicationSpec_PK PRIMARY KEY (App_No,App_Year)
);

CREATE TABLE StudentApp
(
	StudentID integer,
	App_No integer,
	App_Year integer,
    CONSTRAINT StudentID_SA_FK FOREIGN KEY (StudentID)
    REFERENCES STUDENT (StudentID),
    CONSTRAINT ApplicationSpec_FK FOREIGN KEY (App_No,App_Year)
    REFERENCES ApplicationSpec (App_No,App_Year),
    CONSTRAINT StudentApp_PK PRIMARY KEY (StudentID,App_No,App_Year)
); 

COMMIT;