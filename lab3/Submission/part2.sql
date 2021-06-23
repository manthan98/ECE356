#
# ECE356 - Lab 3
# Fall 2020

# Modify this file to achieve the requirements listed in Part 2 of the Lab 3
# specifications.

DROP PROCEDURE IF EXISTS sp_pay_raise_kitchener;

DELIMITER //
CREATE PROCEDURE sp_pay_raise_kitchener()
BEGIN

DECLARE result_set INT;

START TRANSACTION;

UPDATE Employee SET salary = salary * 1.03 WHERE deptID IN (SELECT deptID FROM Location NATURAL JOIN Department WHERE cityName = 'Kitchener');

IF (SELECT count(empID) FROM Employee WHERE salary > 50000 AND deptID IN (SELECT deptID FROM Location NATURAL JOIN Department WHERE cityName = 'Kitchener')) > 0 THEN
    ROLLBACK;
    SELECT 0 "Result";
ELSE
    COMMIT;
    SELECT 1 "Result";
END IF;

END //
DELIMITER ;
