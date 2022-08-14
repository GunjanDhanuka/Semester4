-- CS246 Assignment
-- Prepared by:
-- Gunjan Dhanuka
-- Roll - 200101038

CREATE DATABASE lab1_gunjan;

USE lab1_gunjan;

-- The paths in this file are with respect to my PC. These will almost surely give an error that file doesn't exist on someone else's computer.
-- So please make the changes to the file locations everywhere incase you are running the SQL Code.

-- Task 01
CREATE TABLE courses(CourseNo CHAR(20), CourseTitle CHAR(100) NOT NULL, L INT NOT NULL, T INT NOT NULL, P INT NOT NULL, C INT NOT NULL, Type CHAR(100) NOT NULL, PRIMARY KEY ( CourseNo ));

-- Task 02
LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/courses.csv' INTO TABLE courses FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n' IGNORE 1 LINES;

-- Task 03
CREATE TABLE courses_offered_to(CourseNo CHAR(20), TypeOfCourse CHAR(100) NOT NULL, OfferedTo VARCHAR(100) NOT NULL, PRIMARY KEY (CourseNo), FOREIGN KEY (CourseNo) REFERENCES courses(CourseNo) ON UPDATE CASCADE ON DELETE CASCADE);

-- Task 04
LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/courses-offered-to.csv' INTO TABLE courses_offered_to FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n' IGNORE 1 LINES;

-- Task 05
CREATE TABLE courses_exam_slots(CourseNo CHAR(20), ExamSlot CHAR(100), ExamDateTime CHAR(100), PRIMARY KEY (CourseNo), FOREIGN KEY (CourseNo) REFERENCES courses(CourseNo) ON UPDATE CASCADE ON DELETE CASCADE);

-- Task 06
LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/courses-exam-slots.csv' INTO TABLE courses_exam_slots FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n' IGNORE 1 LINES;

-- Task 07
CREATE TABLE faculty(faculty_id INT, dept_name CHAR(100) NOT NULL, faculty_name CHAR(100) NOT NULL, PRIMARY KEY (faculty_id));

-- Task 08
LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/bt.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/ce.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/ch.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/cl.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/cs.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/da.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';
 
LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/dd.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/dm.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/ee.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/en.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/hs.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/ifst.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/ls.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/ma.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/me.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/nt.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/ph.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/ra.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty/rt.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

-- Task 09
CREATE TABLE faculty_course_allotment(CourseNo CHAR(20),dept_name CHAR(100) NOT NULL,  faculty_id INT, PRIMARY KEY (CourseNo, faculty_id), FOREIGN KEY (CourseNo) REFERENCES courses(CourseNo) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id) ON UPDATE CASCADE ON DELETE CASCADE); 

-- Task 10
LOAD DATA LOCAL INFILE '/home/gunjan/Desktop/Semester 4/DBMS LAB/lab 1/database-24-jan-2022/faculty-course-allotment.csv' INTO TABLE faculty_course_allotment FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';


-- Due to an error in the faculty_course_allotment.csv file, we get a warning which is show below:
-- | Warning | 1366 | Incorrect integer value: 'BD                                                ' for column 'faculty_id' at row 430                                                                                                                                           |
-- | Warning | 1452 | Cannot add or update a child row: a foreign key constraint fails (`lab1_test`.`faculty_course_allotment`, CONSTRAINT `faculty_course_allotment_ibfk_2` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`) ON DELETE CASCADE ON UPDATE CASCADE) |
-- Since there is no obvious way to fix the error which should have contained faculty_id instead of 'BD', we will simply skip that entry.

