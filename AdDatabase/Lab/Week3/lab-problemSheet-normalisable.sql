/****************************************************************************************************************
Problem Set: lab 2 problem 2
Author: Willam Carey
Date: 04-10-2019

Details we can assume for the problem set:
    Applications are submitted for each year 
    applications numbers are reset every year
    therefore they are unique only inside each year. 
 
Student ID is unique and constant for all the years after the first submission is sent  
 
· A student might move to another address 
    the database has to store all the students addresses  
 
An applicant can only apply once during each year.  
 
Reference-Name and RefInstitution together are unique (but are not unique as separate attributes).  

Prior-School-Id uniquely identifies a university or college.  
 
A student might have many prior-schools
    if she/he sends an applications in different years 
    it might have added a new prior school   
 
An applicant has only one GPA from any specific prior school.  
 
For each application there could be one or more referees  

Referees may write a reference statement for more than one applicants.  
 
However, the reference statement for different applicants is different.  
 
Reference statements are attached to an application. 
    If a student submit a second application 
    the reference statements (even from the same referee) could be different.  
****************************************************************************************************************/

--Part two of the laboratory (apps.sql needs to be executed before part three )

--Identify the first normalisation of the table

--Unique IDs for the tabe
    --StudentID , Prior-schoolID
    
--Identify the second normalisation of the table
    --StudentID
        --StudentName
        --ZipCode
        --Application-No
    --Prior-SchoolID
        --Prior-School-Addr
        
--Identify the third normalisation of the table
    --ApplicationNo
        --GPA
        --ApplicYear
        --ReferenceName + RefInstituation
            --Reference Statement
    --ZipCode
        --Street
        --State
        
--Part three of the application

--Drop the tables
DROP TABLE STUDENTAPP;
DROP TABLE APPLICATIONSPEC;
DROP TABLE STUDENT;
DROP TABLE ADDRESS_SPEC;
DROP TABLE PRIORSCHOOL;
DROP TABLE REFDETAILS;

--The reference details
CREATE TABLE REFDETAILS(
    --the primary keys
    ReferenceName VARCHAR2(50) NOT NULL,
    RefInstituation VARCHAR2(100) NOT NULL,
    --other fields
    ReferenceStatement VARCHAR2(100),
    --constriants
    CONSTRAINT RefID_PK PRIMARY KEY (ReferenceName, RefInstituation)
);
--the previous school details
CREATE TABLE PRIORSCHOOL(
    --the primary key
    PriorSchoolId INTEGER NOT NULL,
    --other field
    PriorSchoolAddr VARCHAR2(100),
    --constriants
    CONSTRAINT PriorSchoolId_PK PRIMARY KEY (PriorSchoolId)
);
--the home address details
CREATE TABLE ADDRESS_SPEC(
    --the primary key
    ZipCode VARCHAR2(7) NOT NULL,
    --other fields
    Street VARCHAR2(100) NOT NULL,
    StateNAme VARCHAR2(30) NOT NULL,
    --constriants
    CONSTRAINT ZipCode_PK PRIMARY KEY (ZipCode)
);
--the student details, references the home address

CREATE TABLE STUDENT(   
    --primary key
    StudentIDentifier INTEGER NOT NULL,
    --foriegn key(s)
    ZipCode VARCHAR(7) NOT NULL,
    --other fields
    StudentName VARCHAR(50) NOT NULL,
    --constriants
    CONSTRAINT StudentID PRIMARY KEY (StudentIDentifier),
    CONSTRAINT ZipCode_FK FOREIGN KEY (ZipCode)
    REFERENCES ADDRESS_SPEC (ZipCode)
);
--the application details
CREATE TABLE APPLICATIONSPEC(
    --primary key
    ApplicationNumber INTEGER NOT NULL,
    --other fields
    ApplicYear INTEGER NOT NULL,
    --constriants
    CONSTRAINT ApplicationNo_PK PRIMARY KEY (ApplicationNumber)
);
--the connection between the application and the student
CREATE TABLE STUDENTAPP(
    --foreign keys
    ApplicationNO INTEGER NOT NULL,
    ReferenceName VARCHAR2(100) NOT NULL,
    RefInstituation VARCHAR2(100) NOT NULL,
    StudentID INTEGER NOT NULL,
    PriorSchoolId INTEGER NOT NULL,
    --other fields
    GPA NUMBER(2) NOT NULL,
    --constraints
    CONSTRAINT ApplicationNo_FK FOREIGN KEY (ApplicationNO)
    REFERENCES APPLICATIONSPEC (ApplicationNumber),
    CONSTRAINT RefID_FK FOREIGN KEY (ReferenceName, RefInstituation)
    REFERENCES REFDETAILS (ReferenceName, RefInstituation),
    CONSTRAINT StudentID_FK FOREIGN KEY (StudentID)
    REFERENCES STUDENT (StudentIDentifier),
    CONSTRAINT PriorSchoolId_FK FOREIGN KEY (PriorSchoolId)
    REFERENCES PRIORSCHOOL (PriorSchoolId),
    --primary key
    CONSTRAINT STUDENTAPP_PK PRIMARY KEY (ApplicationNO,StudentID)
);

COMMIT;