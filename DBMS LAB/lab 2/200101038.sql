-- CS246 Assignment 2
-- Prepared by:
-- Gunjan Dhanuka
-- Roll - 200101038

-- The paths in this file are with respect to my PC. These will almost surely give an error that file doesn't exist on someone else's computer.
-- So please make the changes to the file locations everywhere incase you are running the SQL Code.

-- Task 01
CREATE DATABASE assignment04;

-- to load local files
SET GLOBAL local_infile=1;

USE assignment04;

-- Task 02
CREATE TABLE hss_electives(roll_number INT, sname CHAR(100) NOT NULL, cid CHAR(20) NOT NULL, cname CHAR(100) NOT NULL, PRIMARY KEY ( roll_number ));

-- Task 03
LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 2/database-31-jan-2022/HSS_ELECTIVE_ALLOCATION_2018_BATCH.csv' INTO TABLE hss_electives FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n' IGNORE 4 LINES;

-- Task 04: Insertion
INSERT INTO hss_electives VALUES (180101058, 'Pranav Gupta', 'HS 236','Sociological Perspectives on Modernity');
-- ERROR 1062 (23000): Duplicate entry '180101058' for key 'hss_electives.PRIMARY'

INSERT INTO hss_electives VALUES (NULL, 'Pranav Gupta', 'HS 236', 'Sociological Perspectives on Modernity');
-- ERROR 1048 (23000): Column 'roll_number' cannot be null

INSERT INTO hss_electives VALUES (180102058, NULL, 'HS 236', 'Economics of Uncertainity and Information');
-- ERROR 1048 (23000): Column 'sname' cannot be null

INSERT INTO hss_electives VALUES (180103058, 'Pranav Gupta', NULL, 'Economics of Uncertainity and Information');
-- ERROR 1048 (23000): Column 'cid' cannot be null

INSERT INTO hss_electives VALUES (180104058, 'Pranav Gupta', 'HS 424', NULL);
-- ERROR 1048 (23000): Column 'cname' cannot be null


-- Task 05 : Updation
UPDATE hss_electives SET roll_number=NULL WHERE roll_number=180123047;
-- ERROR 1048 (23000): Column 'roll_number' cannot be null

UPDATE hss_electives SET roll_number=180123045 WHERE roll_number=180123046;
-- ERROR 1062 (23000): Duplicate entry '180123045' for key 'hss_electives.PRIMARY'

UPDATE hss_electives SET sname=NULL;
-- ERROR 1048 (23000): Column 'sname' cannot be null

UPDATE hss_electives SET cid=NULL  WHERE cid='HS 211';
-- ERROR 1048 (23000): Column 'cid' cannot be null

UPDATE hss_electives SET cname=NULL WHERE cid='HS 245';
-- ERROR 1048 (23000): Column 'cname' cannot be null

-- Task 06 : Deletion
DELETE FROM hss_electives WHERE cid='HS 225';

DELETE FROM hss_electives WHERE sname LIKE '%Ajay%';


-- Task 07 - load file
LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 2/database-31-jan-2022/HS225.csv' INTO TABLE hss_electives FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 2/database-31-jan-2022/ajay.csv' INTO TABLE hss_electives FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

-- Task 08 - Show Warnings
show warnings;
-- Warning | 1062 | Duplicate entry '180107005' for key 'hss_electives.PRIMARY'
-- This warning is coming because one of the entries in the ajay.csv which is (180107005, Ajay Kumar Nishad, HS 225, Inventing the Truth: The Art and Craft of Autobiography) was also present in HS225.csv 
-- Since he was already added to the table, mySQL gave an error that it is a duplicate entry against Primary Key 180107005


-- Task 09 - alter table
ALTER TABLE hss_electives DROP PRIMARY KEY;

INSERT INTO hss_electives VALUES (180123001, 'Aditi Bihade', 'HS 225', 'Inventing the Truth: The Art and Craft of Autobiography');

ALTER TABLE hss_electives ADD PRIMARY KEY (roll_number);
-- ERROR 1062 (23000): Duplicate entry '180123001' for key 'hss_electives.PRIMARY'
-- This error arose because the table had two entries by this roll number 180123001 which is not permissible if we wish to make roll_number a Primary Key

INSERT INTO hss_electives VALUES (180123001, 'Aditi Bihade', 'HS 225', 'Inventing the Truth: The Art and Craft of Autobiography');


-- Task 10 - Load additional entries
LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 2/database-31-jan-2022/old-hss-electives-allotment.csv' INTO TABLE hss_electives FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;


-- Task 11 - Selection
SELECT cid FROM hss_electives;

SELECT * FROM hss_electives WHERE roll_number LIKE '____01___' OR roll_number LIKE '____23___';

SELECT * FROM hss_electives WHERE roll_number LIKE '____23___' AND cname='Sociological Perspectives on Modernity';

SELECT DISTINCT cid, cname FROM hss_electives;

SELECT cid, cname FROM hss_electives ORDER BY cname DESC;

SELECT sname FROM hss_electives WHERE cname="Human Resource Management" ORDER BY sname, roll_number;