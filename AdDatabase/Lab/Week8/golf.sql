/* Golf DB 1 and DB 2*/
drop table results1;
drop table results2;
drop table players1;
drop table players2;
drop table team1;
drop table team2;
drop table tournament1;
drop table tournament2;

Create Table Team1(
Team_id integer primary key,
Team_name varchar(100)
);

Create Table Team2(
Team_id integer primary key,
Team_name varchar(100)
);

Create Table Players1(
p_id integer primary key,
p_name varchar(50),
p_sname varchar(50),
team_id integer,
constraint fk_team_1 foreign key (team_id) references team1
);

Create Table Players2(
p_id integer primary key,
p_name varchar(50),
p_sname varchar(50),
team_id integer,
constraint fk_team_2 foreign key (team_id) references team2
);

Create Table Tournament1(
T_id integer primary key,
t_descriprion varchar(100),
t_date date,
Total_price float
);

Create Table Tournament2(
T_id integer primary key,
t_descriprion varchar(100),
t_date date,
Total_price float
);

Create Table Results1(
t_id integer,
p_id integer,
rank integer,
price float,
CONSTRAINT  FK_player1 FOREIGN KEY (p_id) REFERENCES players1,
CONSTRAINT  FK_tournament1 FOREIGN KEY (t_id) REFERENCES tournament1,
CONSTRAINT PK_Results1 PRIMARY KEY (t_id,p_id)
);

Create Table Results2(
t_id integer,
p_id integer,
rank integer,
price float,
CONSTRAINT  FK_player2 FOREIGN KEY (p_id) REFERENCES players2,
CONSTRAINT  FK_tournament2 FOREIGN KEY (t_id) REFERENCES tournament2,
CONSTRAINT PK_Results2 PRIMARY KEY (t_id,p_id)
);

/* END ER DIAGRAM */

COMMIT;
--SELECT * FROM tournament2 WHERE t_id = 6;

/*Select statements for insertion of date dim staging process/
--get the year number
select cast(to_char(t_date,'YYYY') as integer) from tournament2 WHERE t_id = 6;
--get the month number
select cast(to_char(t_date,'MM') as integer) from tournament2 WHERE t_id = 6;
--get the day number
select cast(to_char(t_date,'DD') as integer) from tournament2 WHERE t_id = 6;
--get the week number from the tournament
select cast(to_char(t_date,'ww') as integer) from tournament2 WHERE t_id = 6;
--get the quarter number 
select cast(to_char(t_date,'q') as integer) from tournament2 WHERE t_id = 6;
--get the day (monday to sunday) number
select cast(to_char(t_date,'d') as integer) from tournament2 WHERE t_id = 6;

SELECT * FROM TEAM2;*/