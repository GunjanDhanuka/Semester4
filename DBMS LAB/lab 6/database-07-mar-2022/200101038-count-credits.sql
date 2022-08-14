DELIMITER //
CREATE PROCEDURE count_credits()
BEGIN
CREATE TABLE temp(
    SELECT roll_number, MIN(name) name, SUM(cc.credits) total_credits
    FROM cwsl NATURAL JOIN cc
    GROUP BY roll_number
);

SELECT * FROM temp
WHERE total_credits > 40;

END //
DELIMITER ;