-- Created By:
-- Gunjan Dhanuka
-- Roll - 200101038
-- Date: 14/02/2022
SET
    GLOBAL local_infile = 1;

-- Task 01
CREATE DATABASE assignment06;

USE assignment06;

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
-- 4.1 Nested
SELECT
    cname,
    count(cname)
FROM
    (
        SELECT
            course.cid,
            course.cname,
            course_eligibility.program
        FROM
            course
            LEFT OUTER JOIN course_eligibility AS course_eligibility ON course.cid = course_eligibility.cid
    ) AS s
GROUP BY
    cid;

-- 4.1 Correlated
SELECT
    cname,
    (
        SELECT
            count(program)
        FROM
            course_eligibility
        WHERE
            course.cid = course_eligibility.cid
    )
FROM
    course
GROUP BY
    cid;

-- 4.2 Nested
-- Q2
-- Nested Query
CREATE TABLE instructor_with_cname AS (
    SELECT
        *
    FROM
        course_instructor
);

ALTER TABLE
    instructor_with_cname
ADD
    COLUMN cname CHAR(100);

UPDATE
    instructor_with_cname
SET
    cname = (
        SELECT
            cname
        FROM
            course
        WHERE
            course.cid = instructor_with_cname.cid
    );

CREATE TABLE faculty_count AS (
    SELECT
        cid,
        COUNT(instructor) instructor_no
    FROM
        course_instructor
    GROUP BY
        cid
    ORDER BY
        COUNT(instructor) DESC
);

CREATE TABLE max_only AS (
    SELECT
        cid,
        instructor_no
    FROM
        faculty_count
    WHERE
        instructor_no = (
            SELECT
                MAX(instructor_no)
            FROM
                faculty_count
        )
);

SELECT
    instructor_with_cname.cid,
    instructor_with_cname.cname,
    instructor_with_cname.instructor
FROM
    instructor_with_cname NATURAL
    JOIN max_only;

-- 4.2 Correlated
CREATE TABLE amount AS (
    SELECT
        cid,
        count(instructor) AS counter
    FROM
        course_instructor
    GROUP BY
        cid
);

SELECT
    *
FROM
    faculty;

SELECT
    course.cid,
    cname,
    instructor
FROM
    course,
    course_instructor
WHERE
    course.cid IN (
        SELECT
            cid
        FROM
            amount
        WHERE
            counter =(
                SELECT
                    max(counter)
                FROM
                    amount
            )
            AND course.cid = course_instructor.cid
    );

SELECT
    cid,
    cname,
    instructor
FROM
    (
        SELECT
            course.cid AS cid,
            cname,
            instructor
        FROM
            course NATURAL
            JOIN course_instructor
    ) AS counting
WHERE
    EXISTS(
        SELECT
            *
        FROM
            amount
        WHERE
            counter =(
                SELECT
                    max(counter)
                FROM
                    amount
            )
            AND counting.cid = amount.cid
    );

--4.3
-- 4.3 Nested
CREATE TABLE course_with_faculty AS (
    SELECT
        *
    FROM
        course
);

ALTER TABLE
    course_with_faculty
ADD
    COLUMN instructor CHAR(50);

UPDATE
    course_with_faculty
SET
    instructor = (
        SELECT
            coordinator
        FROM
            course_coordinator
        WHERE
            course_with_faculty.cid = course_coordinator.cid
    );

SELECT
    DISTINCT cname,
    dept
FROM
    (
        (
            SELECT
                *
            FROM
                course_with_faculty
            WHERE
                (
                    (
                        cid NOT LIKE "%H"
                        AND c <> (2 * l + 2 * t + p)
                    )
                    OR (
                        cid LIKE "%H"
                        AND c <> (2 * l + 2 * t + p) / 2
                    )
                )
        ) AS tmp
        JOIN faculty ON tmp.instructor = faculty.instructor
    );

-- 4.3 Correlated
SELECT
    DISTINCT table1.cname,
    faculty.dept
FROM
    course_with_faculty AS table1
    JOIN faculty ON table1.instructor = faculty.instructor
WHERE
    EXISTS (
        SELECT
            cname
        FROM
            course
        WHERE
            (
                (
                    c <> 2 * l + 2 * t + p
                    AND NOT cid LIKE '%H'
                )
                OR (
                    c <> (2 * l + 2 * t + p) / 2
                    AND cid LIKE '%H'
                )
            )
            AND course.cname = table1.cname
    );

-- 4.4
-- 4.4 Nested
SELECT
    cname,
    instructor
FROM
    (
        SELECT
            DISTINCT cid,
            cname,
            instructor
        FROM
            course_with_faculty
        WHERE
            (cid, instructor) NOT IN (
                SELECT
                    cid,
                    instructor
                FROM
                    course_instructor
            )
    ) AS result;

-- 4.4 Correlated
SELECT
    (
        SELECT
            table2.cname
        FROM
            course AS table2
        WHERE
            table2.cid = table1.cid
    ),
    table1.coordinator
FROM
    course_coordinator AS table1
WHERE
    (table1.cid, table1.coordinator) NOT IN (
        SELECT
            table3.cid,
            table3.instructor
        FROM
            course_instructor AS table3
    );

-- 4.5 nested
SELECT
    cname,
    gsubmission
FROM
    (
        SELECT
            course.cname,
            course_coordinator.gsubmission
        FROM
            course,
            course_coordinator
        WHERE
            course_coordinator.cid = course.cid
    ) AS dummy;

-- 4.5 correlated
SELECT
    s1.cname,
    s2.gsubmission
FROM
    course AS s1,
    course_coordinator AS s2
WHERE
    s1.cid = s2.cid
    AND EXISTS (
        SELECT
            *
        FROM
            course_coordinator AS s3
        WHERE
            s1.cid = s3.cid
    );

-- 4.6 nested
SELECT
    cname,
    exam_date
FROM
    (
        SELECT
            course.cid,
            course.cname,
            course_coordinator.exam_date
        FROM
            course,
            course_coordinator
        WHERE
            course.cid = course_coordinator.cid
            AND course.cid NOT LIKE '%H'
    ) AS s;

-- 4.6 correlated
SELECT
    cname,
    (
        SELECT
            exam_date
        FROM
            course_coordinator
        WHERE
            course.cid = course_coordinator.cid
    )
FROM
    course
WHERE
    cid NOT LIKE '%H';

-- 4.7 nested
SELECT
    s1.cid,
    s1.cname,
    s2.instructor
FROM
    course AS s1,
    course_instructor AS s2
WHERE
    s1.cid = s2.cid
    AND s1.cid IN (
        SELECT
            cid
        FROM
            (
                SELECT
                    cid,
                    count(*) AS no_eligible_program
                FROM
                    course_eligibility
                GROUP BY
                    cid
            ) AS s
        WHERE
            no_eligible_program >= 10
    );

-- 4.7 correlated
SELECT
    cid,
    (
        SELECT
            cname
        FROM
            course
        WHERE
            course.cid = course_instructor.cid
    ) AS cname,
    instructor
FROM
    course_instructor
WHERE
    cid IN (
        SELECT
            cid
        FROM
            (
                SELECT
                    cid,
                    count(*) AS no_eligible_program
                FROM
                    course_eligibility
                GROUP BY
                    cid
            ) AS tmp1
        WHERE
            no_eligible_program >= 10
    );

-- 4.8 nested
SELECT
    DISTINCT S1.instructor,
    R1.dept,
    S1.cid
FROM
    course_instructor AS S1,
    faculty AS R1
WHERE
    (S1.instructor, R1.dept) IN (
        SELECT
            Q1.instructor,
            Q1.dept
        FROM
            faculty AS Q1,
            course_instructor AS P1
        WHERE
            Q1.instructor = P1.instructor
    );

-- 4.8 correlated
SELECT
    S1.instructor,
    R1.dept,
    S1.cid
FROM
    course_instructor AS S1,
    faculty AS R1
WHERE
    EXISTS (
        SELECT
            *
        FROM
            faculty AS Q1
        WHERE
            (Q1.instructor = S1.instructor)
            AND (Q1.instructor = R1.instructor)
    );

-- 4.9
-- 4.9 Nested
SELECT
    instructor
FROM
    faculty
WHERE
    instructor NOT IN (
        SELECT
            instructor
        FROM
            course_instructor
    );

-- 4.9 Correlated
SELECT
    instructor
FROM
    faculty AS FACULTY
WHERE
    NOT EXISTS (
        SELECT
            instructor
        FROM
            course_instructor AS INSTRUCTOR
        WHERE
            INSTRUCTOR.instructor = FACULTY.instructor
    );

-- Task 05
-- Query 1
CREATE VIEW query1 AS
SELECT
    cname,
    count(cname)
FROM
    (
        SELECT
            course.cid,
            course.cname,
            course_eligibility.program
        FROM
            course
            LEFT OUTER JOIN course_eligibility AS course_eligibility ON course.cid = course_eligibility.cid
    ) AS s
GROUP BY
    cid;

-- Query 2
-- Intermediate tables for this task have been created above in Task 4.2

CREATE VIEW query2 AS
SELECT
    instructor_with_cname.cid,
    instructor_with_cname.cname,
    instructor_with_cname.instructor
FROM
    instructor_with_cname NATURAL
    JOIN max_only;

-- Query 3
-- Intermediate tables for this task have been created above in Task 4.3
CREATE VIEW query3 AS
SELECT
    DISTINCT cname,
    dept
FROM
    (
        (
            SELECT
                *
            FROM
                course_with_faculty
            WHERE
                (
                    (
                        cid NOT LIKE "%H"
                        AND c <> (2 * l + 2 * t + p)
                    )
                    OR (
                        cid LIKE "%H"
                        AND c <> (2 * l + 2 * t + p) / 2
                    )
                )
        ) AS tmp
        JOIN faculty ON tmp.instructor = faculty.instructor
    );

-- Query 4
CREATE VIEW query4 AS
SELECT
    cname,
    instructor
FROM
    (
        SELECT
            DISTINCT cid,
            cname,
            instructor
        FROM
            course_with_faculty
        WHERE
            (cid, instructor) NOT IN (
                SELECT
                    cid,
                    instructor
                FROM
                    course_instructor
            )
    ) AS result;

-- Query 5
CREATE VIEW query5 AS
SELECT
    cname,
    gsubmission
FROM
    (
        SELECT
            course.cname,
            course_coordinator.gsubmission
        FROM
            course,
            course_coordinator
        WHERE
            course_coordinator.cid = course.cid
    ) AS dummy;

-- Query 6
CREATE VIEW query6 AS
SELECT
    cname,
    exam_date
FROM
    (
        SELECT
            course.cid,
            course.cname,
            course_coordinator.exam_date
        FROM
            course,
            course_coordinator
        WHERE
            course.cid = course_coordinator.cid
            AND course.cid NOT LIKE '%H'
    ) AS s;

-- Query 7
CREATE VIEW query7 AS
SELECT
    s1.cid,
    s1.cname,
    s2.instructor
FROM
    course AS s1,
    course_instructor AS s2
WHERE
    s1.cid = s2.cid
    AND s1.cid IN (
        SELECT
            cid
        FROM
            (
                SELECT
                    cid,
                    count(*) AS no_eligible_program
                FROM
                    course_eligibility
                GROUP BY
                    cid
            ) AS s
        WHERE
            no_eligible_program >= 10
    );

-- Query 8
CREATE VIEW query8 AS
SELECT
    DISTINCT S1.instructor,
    R1.dept,
    S1.cid
FROM
    course_instructor AS S1,
    faculty AS R1
WHERE
    (S1.instructor, R1.dept) IN (
        SELECT
            Q1.instructor,
            Q1.dept
        FROM
            faculty AS Q1,
            course_instructor AS P1
        WHERE
            Q1.instructor = P1.instructor
    );

-- Query 9
CREATE VIEW query9 AS
SELECT
    instructor
FROM
    faculty
WHERE
    instructor NOT IN (
        SELECT
            instructor
        FROM
            course_instructor
    );