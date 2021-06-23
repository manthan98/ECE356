#
# ECE356 - Lab 3
# Fall 2020

# Modify this file to achieve the requirements listed in Part 1 of the Lab 3
# specifications.

DROP PROCEDURE IF EXISTS sp_pay_raise;

DELIMITER $$
CREATE PROCEDURE sp_pay_raise(IN inEmpID int, IN inPercentageRaise Double(4,2), OUT errorCode int)
BEGIN

IF (SELECT count(empID) FROM Employee WHERE empID = inEmpID) = 0 AND (inPercentageRaise < 0 OR inPercentageRaise > 10) THEN
    SET errorCode = -3;
ELSEIF (SELECT count(empID) FROM Employee WHERE empID = inEmpID) = 0 AND (inPercentageRaise >= 0 AND inPercentageRaise <= 10) THEN
    SET errorCode = -2;
ELSEIF (SELECT count(empID) FROM Employee WHERE empID = inEmpID) > 0 AND (inPercentageRaise < 0 OR inPercentageRaise > 10) THEN
    SET errorCode = -1;
ELSE
    SET errorCode = 0;
END IF;

IF errorCode = 0 THEN
    UPDATE Employee SET salary = salary * ((inPercentageRaise / 100) + 1) WHERE empID = inEmpID;
END IF;

END$$
DELIMITER ;
