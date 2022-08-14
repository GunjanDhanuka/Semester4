USE assignment08;

DELIMITER //
CREATE PROCEDURE tt_vio()
BEGIN

CREATE TABLE cwsl_ett(
    SELECT roll_number, cid AS c1_cid, name, exam_date AS c1_exam_date, start_time AS c1_start_time, end_time AS c1_end_time
    FROM cwsl NATURAL JOIN ett
);

CREATE TABLE course_pair(
    SELECT table1.roll_number, table1.c1_cid, table1.name, table1.c1_exam_date, table1.c1_start_time, table1.c1_end_time, table2.c1_cid AS c2_cid, table2.c1_exam_date AS c2_exam_date, table2.c1_start_time AS c2_start_time, table2.c1_end_time AS c2_end_time
    FROM cwsl_ett AS table1
    JOIN cwsl_ett AS table2
    ON (
        table1.roll_number = table2.roll_number AND
        table1.c1_cid < table2.c1_cid
    )
);

SELECT DISTINCT roll_number, name, c1_cid, c2_cid
FROM course_pair
WHERE (
    (c1_cid <> c2_cid) AND
    (c1_exam_date = c2_exam_date) AND
    (
        ((c1_start_time >= c2_start_time) AND (c1_start_time <= c2_end_time)) OR
        ((c2_start_time >= c1_start_time) AND (c2_start_time <= c1_end_time))
    )
);

END //
DELIMITER ;

CALL tt_vio();
