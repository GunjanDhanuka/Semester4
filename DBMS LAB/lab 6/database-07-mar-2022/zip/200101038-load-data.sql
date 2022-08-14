-- Created By:
-- Gunjan Dhanuka
-- Roll - 200101038
-- Date: 07/03/2022

SET
    GLOBAL local_infile = 1;

-- Task 01
CREATE DATABASE assignment08;

USE assignment08;

CREATE TABLE ett (
    cid CHAR(20),
    exam_date DATE,
    start_time TIME,
    end_time TIME
);

LOAD DATA LOCAL INFILE 'exam-time-table.csv' INTO TABLE ett FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';

CREATE TABLE cc (
   cid CHAR(20),
   credits INT,
   PRIMARY KEY (cid)
);

LOAD DATA LOCAL INFILE 'course-credits.csv' INTO TABLE cc FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';

CREATE TABLE cwsl (
    serial_number INT,
    cid CHAR(20),
    roll_number CHAR(20),
    name CHAR(100),
    email CHAR(100),
    PRIMARY KEY (cid, roll_number)
);

LOAD DATA LOCAL INFILE 'merged_data.csv' INTO TABLE cwsl FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;