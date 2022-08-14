-- Created By:
-- Gunjan Dhanuka
-- Roll - 200101038
-- Date: 21/02/2022

SET
    GLOBAL local_infile = 1;

-- Task 01
CREATE DATABASE assignment07;

USE assignment07;

-- Task 02
-- I have returned the program code and department code in 2.2 and 2.3 respectively
-- As discussed with Anuj Khare sir during the lab session.
-- 2.1
DELIMITER //
CREATE FUNCTION year_of_joining(roll_number VARCHAR(9))
RETURNS VARCHAR(4)
DETERMINISTIC
BEGIN
    DECLARE first_two VARCHAR(4);
    DECLARE result VARCHAR(4);
    SET first_two = SUBSTRING(roll_number, 1, 2);

    -- if length of year is less than 2, it will give null value
    if(length(first_two)<2)
    then
    return null;
    end if;

    SET result = CONCAT("20", first_two);
    RETURN (result);
END;//
DELIMITER ;

-- 2.2
DELIMITER //
CREATE FUNCTION program_code(roll_number VARCHAR(9))
RETURNS VARCHAR(2)
DETERMINISTIC
BEGIN
    DECLARE prog_code VARCHAR(2);
    DECLARE prog VARCHAR(10);
    SET prog_code = SUBSTRING(roll_number, 3, 2);
    RETURN (prog_code);
END;//
DELIMITER ;

-- 2.3
DELIMITER //
CREATE FUNCTION department_code(roll_number VARCHAR(9))
RETURNS VARCHAR(2)
DETERMINISTIC
BEGIN
    DECLARE dept_code VARCHAR(2);
    DECLARE dept VARCHAR(10);
    SET dept_code = SUBSTRING(roll_number, 5, 2);
    RETURN (dept_code);
END;//
DELIMITER ;


-- Task 03
CREATE TABLE hss_electives(
    roll_number VARCHAR(9),
    sname CHAR(100) NOT NULL,
    cid CHAR(100) NOT NULL,
    cname CHAR(100) NOT NULL,
    PRIMARY KEY (roll_number)
);

-- Task 04
CREATE TABLE student_details(
    roll_number VARCHAR(9),
    sname CHAR(100) NOT NULL,
    joined_year VARCHAR(100) NOT NULL,
    joined_program VARCHAR(100) NOT NULL,
    joined_dept VARCHAR(100) NOT NULL,
    PRIMARY KEY(roll_number)
);

-- Task 05
DELIMITER //
CREATE TRIGGER insert_details
AFTER INSERT ON hss_electives
FOR EACH ROW
BEGIN
    DECLARE jyear VARCHAR(100);
    DECLARE prog VARCHAR(100);
    DECLARE dept VARCHAR(100);
    DECLARE prog_code VARCHAR(2);
    DECLARE dept_code VARCHAR(2);
    DECLARE numeric_year INT;
    SET jyear = year_of_joining(NEW.roll_number);
    SET prog_code = program_code(NEW.roll_number);
    SET dept_code = department_code(NEW.roll_number);

    if (dept_code = "01")
    then
		set dept = "CSE";
	elseif (dept_code = "02")
    then
		set dept = "ECE";
	elseif (dept_code = "03")
    then
		set dept = "ME";
	elseif (dept_code = "04")
    then
		set dept = "CE";
	elseif (dept_code = "05")
    then
		set dept = "DD";
	elseif (dept_code = "06")
    then
		set dept = "BSBE";
	elseif (dept_code = "07")
    then
		set dept = "CL";
	elseif (dept_code = "08")
    then
		set dept = "EEE";
	elseif (dept_code = "21")
    then
		set dept = "EPH";
	elseif (dept_code = "22")
    then
		set dept = "CST";
	elseif (dept_code = "23")
    then
		set dept = "M & C";
    else
        set dept = NULL;
	end if;

    IF (prog_code = "01")
    THEN
        SET prog = "B.Tech";
    ELSEIF (prog_code = "02")
    THEN
        SET prog = "B.Des";
    ELSE
        SET prog = NULL;
    END IF;

    INSERT INTO student_details(roll_number, sname, joined_year, joined_program, joined_dept)
        VALUES (NEW.roll_number, NEW.sname, jyear, prog, dept);
END; //
DELIMITER ;

-- Task 06
LOAD DATA LOCAL INFILE 'HSS_ELECTIVE_ALLOCATION_2018_BATCH.csv' INTO TABLE hss_electives FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n' IGNORE 4 LINES;

-- Task 07
-- task 7.1
-- ERROR 1048 (23000): Column 'joined_year' cannot be null

insert into hss_electives values(180,'Gunjan Dhanuka','HS 236','Sociological Perspectives on Modernity');
insert into hss_electives values(234,'','H','Sociology');

 -- task 7.2
-- ERROR 1048 (23000): Column 'joined_program' cannot be null

insert into hss_electives values(200308078,'Gunjan Dhanuka','HS 236','Sociological Perspectives on Modernity');
insert into hss_electives values(200608098,'Gunjan Dhanuka','HS 236','Sociological Perspectives on Modernity');

-- task 7.3
-- ERROR 1048 (23000): Column 'joined_dept' cannot be null
insert into hss_electives values(200198098,'Gunjan Dhanuka','HS 236','Sociological Perspectives on Modernity');
insert into hss_electives values(200187056,'Gunjan Dhanuka','HS 236','Sociological Perspectives on Modernity');

-- task 7.4
-- ERROR 1062 (23000): Duplicate entry '180101015' for key 'hss_electives.PRIMARY'
insert into hss_electives values(180101015,'Bhasker Goel','HS 236','Sociological Perspectives on Modernity');
insert into hss_electives values(180101015,'Bhasker Goel',null,'Sociological Perspectives on Modernity');

-- Task 08
-- Here I have used the codes obtained above to get the dept names and prog names
DELIMITER //
CREATE TRIGGER update_details
AFTER UPDATE ON hss_electives
FOR EACH ROW
BEGIN
    DECLARE jyear VARCHAR(100);
    DECLARE prog VARCHAR(100);
    DECLARE dept VARCHAR(100);
    DECLARE prog_code VARCHAR(2);
    DECLARE dept_code VARCHAR(2);
    DECLARE numeric_year INT;
    SET jyear = year_of_joining(NEW.roll_number);
    SET prog_code = program_code(NEW.roll_number);
    SET dept_code = department_code(NEW.roll_number);

    if (dept_code = "01")
    then
		set dept = "CSE";
	elseif (dept_code = "02")
    then
		set dept = "ECE";
	elseif (dept_code = "03")
    then
		set dept = "ME";
	elseif (dept_code = "04")
    then
		set dept = "CE";
	elseif (dept_code = "05")
    then
		set dept = "DD";
	elseif (dept_code = "06")
    then
		set dept = "BSBE";
	elseif (dept_code = "07")
    then
		set dept = "CL";
	elseif (dept_code = "08")
    then
		set dept = "EEE";
	elseif (dept_code = "21")
    then
		set dept = "EPH";
	elseif (dept_code = "22")
    then
		set dept = "CST";
	elseif (dept_code = "23")
    then
		set dept = "M & C";
    else
        set dept = NULL;
	end if;

    IF (prog_code = "01")
    THEN
        SET prog = "B.Tech";
    ELSEIF (prog_code = "02")
    THEN
        SET prog = "B.Des";
    ELSE
        SET prog = NULL;
    END IF;

    UPDATE student_details SET roll_number = NEW.roll_number, sname = NEW.sname, joined_year = jyear, joined_program = prog, joined_dept = dept WHERE roll_number = OLD.roll_number;
END; //
DELIMITER ;

-- Task 09
DELIMITER //
CREATE TRIGGER delete_details
AFTER DELETE ON hss_electives
FOR EACH ROW
BEGIN
    DELETE FROM student_details where student_details.roll_number = OLD.roll_number;
END; //
DELIMITER ;