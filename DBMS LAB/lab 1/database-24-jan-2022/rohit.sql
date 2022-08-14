-- Task 01: Creation of course table
CREATE TABLE course(
    CourseNo CHAR(8) PRIMARY KEY,
    CourseTitle CHAR(100) NOT NULL,
    L INT NOT NULL,
    T INT NOT NULL,
    P INT NOT NULL,
    C INT NOT NULL,
    TypeOfCourse CHAR(50) NOT NULL
);

-- Task 02: Loading data from courses.csv file
LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/courses.csv' INTO TABLE course
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Task 03: Creation of course_offered_to table
CREATE TABLE course_offered_to(
    CourseNo CHAR(8) PRIMARY KEY,
    TypeOfCourse CHAR(100) NOT NULL,
    OfferedTo VARCHAR(300) NOT NULL,
    FOREIGN KEY (CourseNo) REFERENCES course(CourseNo) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Task 04 - load data 02 Load the data from the file courses-offered-to.csv into the created table courses offered to.

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/courses-offered-to.csv' INTO TABLE course_offered_to
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
-- Task 05 - table 03 - course exam slot Refer to the file: courses-exam-slots.csv containing three columns as specified
CREATE TABLE course_exam_slots(
    CourseNo CHAR(8) PRIMARY KEY,
    ExamSlot CHAR(35) ,
    ExamDateandTime CHAR(35) ,
    FOREIGN KEY (CourseNo) REFERENCES course(CourseNo) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Task 06 - load data 03 Load the data from the file courses-exam-slots.csv into the created table courses exam slots.

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/courses-exam-slots.csv' INTO TABLE course_exam_slots
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Task 07 - table 04 - faculty Refer to the directory: faculty containing 20 files. Each file is of identical format consisting of three columns

CREATE TABLE faculty(
    FacultyID int PRIMARY KEY,
    DepartmentName CHAR(5) NOT NULL,
    FacultyName VARCHAR(150) NOT NULL,
    FOREIGN KEY (CourseNo) REFERENCES course(CourseNo) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Task 08 - load data 04 Load the data from all the files in the directory faculty into the created table faculty.

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/bt.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/ce.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/ch.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/cl.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/cs.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/da.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/dd.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/dm.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/ee.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/en.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/hs.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/ifst.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/ls.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/ma.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/me.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/nt.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/ph.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/ra.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty/rt.csv' INTO TABLE faculty
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

--Task 09 - table 05 - faculty course allotment Refer to the file: faculty-course-allotment.csv containing three columns as specified

CREATE TABLE faculty_course_allotment(
    CourseNo CHAR(8) PRIMARY KEY,
    DepartmentName CHAR(5) NOT NULL,
    FacultyID int PRIMARY KEY,
    FacultyName VARCHAR(150) NOT NULL,
    FOREIGN KEY (CourseNo) REFERENCES course(CourseNo) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (FacultyID) REFERENCES faculty(FacultyID) ON DELETE CASCADE ON UPDATE CASCADE
);

--Task 10 - load data 05 Load the data from the file faculty-course-allotment.csv into the created table faculty course allotment.

LOAD DATA LOCAL INFILE 'C:/Users/RKG/Downloads/database-24-jan-2022/database-24-jan-2022/faculty-course-allotment.csv' INTO TABLE faculty_course_allotment
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
