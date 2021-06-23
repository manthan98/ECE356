DELIMITER @@

CREATE PROCEDURE sp_pay_raise (
    @inEmpID INT,
    @inPercentageRaise INT,
    @Result INT
)
AS
BEGIN

IF NOT EXISTS (SELECT empID FROM Employee WHERE empID = inEmpID) AND (inPercentageRaise < 0 OR inPercentageRaise > 10)
    SELECT @Result = -3
ELSE IF NOT EXISTS (SELECT empID FROM Employee WHERE empID = inEmpID) AND (inPercentageRaise >= 0 AND inPercentageRaise <= 10)
    SELECT @Result = -2
ELSE IF EXISTS (SELECT empID FROM Employee WHERE empID = inEmpID) AND (inPercentageRaise < 0 OR inPercentageRaise > 10)
    SELECT @Result = -1
ELSE
    BEGIN
    UPDATE Employee SET salary = salary * inPercentageRaise WHERE empID = inEmpID;
    SELECT @Result = 0
    END

END @@
DELIMITER ;

DECLARE @TestResult INT
EXECUTE @TestResult = sp_pay_raise 23, 5
PRINT @TestResult