-- Created By:
-- Gunjan Dhanuka
-- Roll - 200101038
-- Date: 07/02/2022

SET
    GLOBAL local_infile = 1;

-- Task 01
CREATE DATABASE assignment05;

USE assignment05;


-- Task 02

-- 2.1
CREATE TABLE course(
    cid CHAR(20),
    cname CHAR(100),
    l INT,
    t INT,
    p INT,
    c INT,
    PRIMARY KEY (cid)
);

-- 2.2
CREATE TABLE course_coordinator(
    cid CHAR(20),
    cstart CHAR(100),
    cend CHAR(100),
    gsubmission CHAR(100),
    coordinator CHAR(100),
    exam_date CHAR(100),
    PRIMARY KEY (cid)
);

-- 2.3
CREATE TABLE course_eligibility(
    cid CHAR(20) NOT NULL,
    program CHAR(100),
    batch_year CHAR(100),
    batch_month CHAR(100),
    eligibility CHAR(100)
);

-- 2.4
CREATE TABLE course_instructor(cid CHAR(20), instructor CHAR(100));

-- 2.5
CREATE TABLE faculty(
    dept CHAR(100),
    instructor CHAR(100),
    PRIMARY KEY (dept, instructor)
);


-- Task 03
LOAD DATA LOCAL INFILE 'course.csv' INTO TABLE course FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE 'course_coordinator.csv' INTO TABLE course_coordinator FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE 'course_eligibility.csv' INTO TABLE course_eligibility FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE 'course_instructor.csv' INTO TABLE course_instructor FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE 'faculty.csv' INTO TABLE faculty FIELDS TERMINATED BY '#' LINES TERMINATED BY '\n';


-- Task 04


-- 4.1
SELECT
    cname,
    count(course_eligibility.cid)
FROM
    course,
    course_eligibility
WHERE
    course.cid = course_eligibility.cid
GROUP BY
    course_eligibility.cid;

-- 4.2
CREATE TABLE table1 AS (
    SELECT
        course.cid,
        course.cname,
        course_instructor.instructor
    FROM
        course
        JOIN course_instructor ON course.cid = course_instructor.cid
);

CREATE TABLE faculty_count AS (
    SELECT
        cid,
        count(instructor) instructor_no
    FROM
        course_instructor
    GROUP BY
        cid
    ORDER BY
        count(instructor) DESC
);

CREATE TABLE max_only AS (
    SELECT
        cid,
        instructor_no
    FROM
        faculty_count
    WHERE
        instructor_no =(
            SELECT
                MAX(instructor_no)
            FROM
                faculty_count
        )
);

SELECT
    table1.cid,
    table1.cname,
    table1.instructor
FROM
    table1
    JOIN max_only ON table1.cid = max_only.cid;

-- 4.3
CREATE TABLE incorrect_courses AS (
    SELECT
        cid,
        cname
    FROM
        course
    WHERE
        (
            cid NOT LIKE "%H"
            AND c <> (2 * l + 2 * t + p)
        )
        OR (
            cid LIKE "%H"
            AND c <> (2 * l + 2 * t + p) / 2
        )
);

CREATE TABLE table5 AS (
    SELECT
        incorrect_courses.cid,
        incorrect_courses.cname,
        course_instructor.instructor
    FROM
        incorrect_courses
        JOIN course_instructor ON incorrect_courses.cid = course_instructor.cid
);

SELECT
    DISTINCT table5.cname,
    faculty.dept
FROM
    table5
    JOIN faculty ON table5.instructor = faculty.instructor;

-- 4.4
SELECT
    cname,
    coordinator
FROM
    course NATURAL
    JOIN course_coordinator
WHERE
    (
        (cid, coordinator) NOT IN (
            SELECT
                *
            FROM
                course_instructor
        )
    );

-- 4.5
SELECT
    course.cname,
    course_coordinator.gsubmission
FROM
    course
    JOIN course_coordinator ON course.cid = course_coordinator.cid;

-- 4.6
SELECT
    course.cname,
    course_coordinator.exam_date
FROM
    course
    JOIN course_coordinator ON course.cid = course_coordinator.cid
WHERE
    course.cid NOT LIKE '%H';

-- 4.7
CREATE TABLE q7_temp
SELECT
    cid,
    count(*) AS no_eligible_program
FROM
    course_eligibility
GROUP BY
    cid;

SELECT
    cid,    
    cname,
    instructor
FROM
    course_instructor NATURAL
    JOIN course
WHERE
    cid IN (
        SELECT
            cid
        FROM
            q7_temp
        WHERE
            no_eligible_program >= 10
    );

-- 4.8
SELECT
    instructor,
    dept,
    cid
FROM
    faculty NATURAL
    JOIN course_instructor;

-- 4.9
SELECT
    dept, instructor
FROM
    faculty
WHERE
    instructor NOT IN (
        SELECT
            instructor
        FROM
            course_instructor
    )
ORDER BY
    faculty.dept;