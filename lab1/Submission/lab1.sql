---- 1b
SELECT job, count(empID) count FROM Employee GROUP BY job ORDER BY job asc;

---- 1e
SELECT D.deptID FROM Department D INNER JOIN Employee E ON D.deptID = E.deptID AND E.job = "engineer" GROUP BY deptID HAVING count(empID) = (SELECT max(EMP_COUNT) MAX_COUNT FROM (SELECT deptID, count(empID) EMP_COUNT FROM Department NATURAL JOIN Employee WHERE job = "engineer" GROUP BY deptID)A);


---- 1g
SELECT empID FROM Employee WHERE salary = (SELECT max(salary) FROM Employee WHERE salary < (SELECT max(distinct salary) FROM Employee ORDER BY salary desc));


---- 2a
SELECT empName, empID FROM Employee WHERE empID NOT IN (SELECT empID FROM Employee NATURAL JOIN Assigned);


---- 2e
(SELECT sum(salary) projectSalary, projID FROM Employee NATURAL JOIN Assigned GROUP BY projID) UNION (SELECT sum(salary) projectSalary, Null FROM Employee WHERE empID NOT IN (SELECT empID FROM Employee NATURAL JOIN Assigned));


---- 3a
UPDATE Employee SET salary = salary * 1.1 WHERE empID IN (SELECT empID FROM (SELECT empID FROM Employee NATURAL JOIN Assigned NATURAL JOIN Project WHERE title = "compiler")A);


---- 3b
UPDATE Employee SET salary = salary * (CASE WHEN empID in (SELECT empID FROM (SELECT empID, job, location FROM Employee NATURAL JOIN Department)A WHERE A.job = 'janitor' AND A.location = 'Waterloo') THEN 1.08 WHEN empID in (SELECT empID FROM (SELECT empID, job FROM Employee NATURAL JOIN Department)A WHERE A.job = 'janitor') THEN 1.05 WHEN empID in (SELECT empID FROM (SELECT empID, location FROM Employee NATURAL JOIN Department)B WHERE B.location = 'Waterloo') THEN 1.08 ELSE 1.0 END);


---- 3c
ALTER TABLE Employee ADD shift VARCHAR(5);


---- 3d
UPDATE Employee SET shift = (CASE WHEN empID in (SELECT empID FROM (SELECT empID FROM Employee NATURAL JOIN Assigned)A WHERE empID % 2 = 0) THEN "DAY" WHEN empID in (SELECT empID FROM (SELECT empID FROM Employee NATURAL JOIN Assigned)B WHERE empID % 2 = 1) THEN "Night" ELSE "N.A." END);
