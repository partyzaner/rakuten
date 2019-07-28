-- FWrite a SQL statement to return the employee's name, supervisor's name and
-- bonus of everyone who got a bonus greater than 1000.
SELECT EMPLOYEES.NAME,
       EMPLOYEES.SUPERVISOR,
       BONUS.NBONUS FROM EMPLOYEES
    LEFT JOIN BONUS ON EMPLOYEES.EMPID = BONUS.EMPID
        WHERE BONUS.NBONUS > 1000;

-- Write a SQL statement to list the highest paid employee in each location.
-- Ranking should be based on salary plus bonus. Output should include employee
-- name, salary, bonus, and total pay (salary plus bonus).
SELECT E.LOCATION,
       E.NAME,
       E.SALARY,
       IFNULL(B.NBONUS,0) AS BONUS,
       (E.SALARY + IFNULL(B.NBONUS, 0)) AS TOTAL_PAY
FROM EMPLOYEES AS E
    LEFT JOIN BONUS AS B ON E.EMPID = B.EMPID
    INNER JOIN
     (SELECT E.LOCATION,
             MAX(E.SALARY + IFNULL(B.NBONUS, 0)) AS MAX_PAY
     FROM EMPLOYEES AS E
         JOIN BONUS AS B ON E.EMPID = B.EMPID
     GROUP BY E.LOCATION) AS S
     ON E.LOCATION = S.LOCATION AND S.MAX_PAY = (E.SALARY + IFNULL(B.NBONUS, 0));
-- Given a NEW_SUPERVISOR table (columns: EMPID, SUPERVISOR), write an update
-- statement that updates the supervisor of each employee with a new supervisor.
UPDATE EMPLOYEES SET EMPLOYEES.SUPERVISOR =
    (SELECT NEW_SUPERVISOR.SUPERVISOR FROM NEW_SUPERVISOR
    WHERE EMPLOYEES.EMPID = NEW_SUPERVISOR.EMPID);