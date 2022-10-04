-- Write a query to display: 
-- 1. the first name, last name, salary, and job grade for all employees.
SELECT FIRST_NAME, LAST_NAME, SALARY, JOB_TITLE
FROM EMPLOYEES
         LEFT JOIN JOBS USING (JOB_ID);

-- 2. the first and last name, department, city, and state province for each employee.
SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME, l.CITY, l.STATE_PROVINCE
FROM EMPLOYEES e
         JOIN DEPARTMENTS d USING (DEPARTMENT_ID)
         JOIN LOCATIONS l USING (LOCATION_ID);

-- 3. the first name, last name, department number and department name, for all employees for departments 80 or 40.
SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_ID, d.DEPARTMENT_NAME
FROM EMPLOYEES e
         JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
WHERE e.DEPARTMENT_ID = 80
   OR e.DEPARTMENT_ID = 40;

-- 4. those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME, l.CITY, l.STATE_PROVINCE
FROM EMPLOYEES e
         JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
         JOIN LOCATIONS l on d.LOCATION_ID = l.LOCATION_ID
WHERE e.FIRST_NAME LIKE '%z%';

-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
SELECT e1.FIRST_NAME, e1.LAST_NAME, e1.SALARY
FROM EMPLOYEES e1
         JOIN EMPLOYEES e2 ON e2.EMPLOYEE_ID = 182 AND e1.SALARY < e2.SALARY;

-- 6. the first name of all employees including the first name of their manager.
SELECT e1.FIRST_NAME AS EMPLOYEE_NAME, e2.FIRST_NAME AS MANAGER_NAME
FROM EMPLOYEES e1
         JOIN EMPLOYEES e2 ON e1.MANAGER_ID = e2.EMPLOYEE_ID;

-- 7. the first name of all employees and the first name of their manager including those who does not working under any manager.
SELECT e1.FIRST_NAME AS EMPLOYEE_NAME, e2.FIRST_NAME AS MANAGER_NAME
FROM EMPLOYEES e1
         LEFT JOIN EMPLOYEES e2 ON e1.MANAGER_ID = e2.EMPLOYEE_ID;

-- 8. the details of employees who manage a department.
SELECT e.*
FROM EMPLOYEES e
         LEFT JOIN DEPARTMENTS d ON e.EMPLOYEE_ID = d.MANAGER_ID;

-- 9. the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
SELECT e1.FIRST_NAME, e1.LAST_NAME, e1.DEPARTMENT_ID
FROM EMPLOYEES e1
         JOIN EMPLOYEES e2 ON e1.DEPARTMENT_ID = e2.DEPARTMENT_ID AND e2.LAST_NAME = 'Taylor';

--10. the department name and number of employees in each of the department.
SELECT d.DEPARTMENT_NAME, COUNT(e.EMPLOYEE_ID) AS NUMBER_OF_EMPLOYEES
FROM DEPARTMENTS d
         JOIN EMPLOYEES e ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
GROUP BY d.DEPARTMENT_NAME;

--11. the name of the department, average salary and number of employees working in that department who got commission.
SELECT d.DEPARTMENT_NAME, COUNT(e.EMPLOYEE_ID) AS NUMBER_OF_EMPLOYEES, AVG(e.SALARY) AS AVG_SALARY
FROM DEPARTMENTS d
         JOIN EMPLOYEES e ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
WHERE e.COMMISSION_PCT IS NOT NULL
GROUP BY d.DEPARTMENT_NAME;

--12. job title and average salary of employees.
SELECT j.JOB_TITLE, AVG(e.SALARY) AS AVG_SALARY
FROM EMPLOYEES e
         JOIN JOBS j USING (JOB_ID)
group by j.JOB_TITLE;

--13. the country name, city, and number of those departments where at least 2 employees are working.
SELECT ct.COUNTRY_NAME, l.CITY, COUNT(d.DEPARTMENT_ID) AS NUMBER_OF_DEPARTMENTS
FROM EMPLOYEES e
         JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
         JOIN LOCATIONS l ON d.LOCATION_ID = l.LOCATION_ID
         JOIN COUNTRIES ct on l.COUNTRY_ID = ct.COUNTRY_ID
HAVING COUNT(d.DEPARTMENT_ID) >= 2
group by ct.COUNTRY_NAME, l.CITY;

--14. the employee ID, job name, number of days worked in for all those jobs in department 80.
SELECT e.EMPLOYEE_ID, j.JOB_TITLE, jh.END_DATE - jh.START_DATE AS NUMBER_OF_DAYS
FROM EMPLOYEES e
         JOIN JOBS j on e.JOB_ID = j.JOB_ID
         JOIN JOB_HISTORY jh on jh.EMPLOYEE_ID = e.EMPLOYEE_ID
WHERE jh.DEPARTMENT_ID = 80;

--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
SELECT e1.FIRST_NAME || ' ' || e1.LAST_NAME AS NAME
FROM EMPLOYEES e1
         JOIN EMPLOYEES e2 ON e2.EMPLOYEE_ID = 163 AND e1.SALARY > e2.SALARY;

--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME AS NAME
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
SELECT e1.FIRST_NAME || ' ' || e1.LAST_NAME AS NAME, e1.EMPLOYEE_ID, e1.SALARY
FROM EMPLOYEES e1
         JOIN EMPLOYEES e2 on e1.MANAGER_ID = e2.EMPLOYEE_ID AND e2.FIRST_NAME = 'Payam';

--18. the department number, name ( first name and last name ), job and department name for all employees in the Finance department.
SELECT d.DEPARTMENT_ID, e.FIRST_NAME || ' ' || e.LAST_NAME AS NAME, j.JOB_TITLE, d.DEPARTMENT_NAME
FROM EMPLOYEES e
         JOIN JOBS j USING (JOB_ID)
         JOIN DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID AND d.DEPARTMENT_NAME = 'Finance';

--19. all the information of an employee whose id is any of the number 134, 159 and 183.
SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (134, 159, 183);

--20. all the information of the employees whose salary is within the range of smallest salary and 2500.
SELECT *
FROM EMPLOYEES
WHERE SALARY BETWEEN (SELECT MIN(SALARY) FROM EMPLOYEES) AND 2500;

--21. all the information of the employees who does not work in those departments where some employees works whose id within the range 100 and 200.
SELECT e.*
FROM EMPLOYEES e
WHERE e.DEPARTMENT_ID NOT IN (SELECT DISTINCT DEPARTMENT_ID
                              FROM EMPLOYEES e2
                              WHERE e2.EMPLOYEE_ID BETWEEN 100 AND 200
                                AND e2.DEPARTMENT_ID IS NOT NULL);

--22. all the information for those employees whose id is any id who earn the second highest salary.
SELECT *
FROM EMPLOYEES
WHERE SALARY = (SELECT MAX(SALARY)
                FROM EMPLOYEES
                WHERE SALARY NOT IN (SELECT MAX(SALARY) FROM EMPLOYEES));

--23. the employee name( first name and last name ) and hireDate for all employees in the same department as Clara. Exclude Clara.
SELECT e1.FIRST_NAME || ' ' || e1.LAST_NAME AS NAME, e1.HIRE_DATE
FROM EMPLOYEES e1
         JOIN EMPLOYEES e2
              ON e1.DEPARTMENT_ID = e2.DEPARTMENT_ID AND e2.FIRST_NAME = 'Clara' AND e1.FIRST_NAME <> 'Clara';

--24. the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.
SELECT DISTINCT e1.EMPLOYEE_ID, e1.FIRST_NAME || ' ' || e1.LAST_NAME AS NAME
FROM EMPLOYEES e1
         JOIN EMPLOYEES e2
              ON e1.DEPARTMENT_ID = e2.DEPARTMENT_ID AND (e2.FIRST_NAME LIKE '%T%' OR e2.LAST_NAME LIKE '%T%');

--25. full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
SELECT e.FIRST_NAME || ' ' || e.LAST_NAME AS NAME, j.JOB_TITLE, jh.START_DATE, jh.END_DATE
FROM EMPLOYEES e
         JOIN JOBS j ON e.JOB_ID = j.JOB_ID
         JOIN JOB_HISTORY jh on e.EMPLOYEE_ID = jh.EMPLOYEE_ID
WHERE e.COMMISSION_PCT IS NULL;

--26. the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.
SELECT DISTINCT e.EMPLOYEE_ID, e.FIRST_NAME || ' ' || e.LAST_NAME AS NAME, e.SALARY, e.DEPARTMENT_ID
FROM EMPLOYEES e
         JOIN EMPLOYEES e2
              ON e.DEPARTMENT_ID = e2.DEPARTMENT_ID AND (e2.FIRST_NAME LIKE '%J%' or e2.LAST_NAME LIKE '%J%')
WHERE e.SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
SELECT e.EMPLOYEE_ID, e.FIRST_NAME || ' ' || e.LAST_NAME AS NAME, j.JOB_TITLE
FROM EMPLOYEES e
         JOIN JOBS j ON e.JOB_ID = j.JOB_ID
WHERE e.SALARY < (SELECT SALARY
                  FROM EMPLOYEES
                  WHERE JOB_ID = 'MK_MAN');

--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
SELECT e.EMPLOYEE_ID, e.FIRST_NAME || ' ' || e.LAST_NAME AS NAME, j.JOB_TITLE
FROM EMPLOYEES e
         JOIN JOBS j ON e.JOB_ID = j.JOB_ID
WHERE e.JOB_ID != 'MK_MAN'
  AND e.SALARY < (SELECT SALARY
                  FROM EMPLOYEES
                  WHERE JOB_ID = 'MK_MAN');

--29. all the information of those employees who did not have any job in the past.
SELECT *
FROM EMPLOYEES e
WHERE e.EMPLOYEE_ID NOT IN (SELECT EMPLOYEE_ID FROM JOB_HISTORY);

--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
SELECT e.EMPLOYEE_ID, e.FIRST_NAME || ' ' || e.LAST_NAME AS NAME, j.JOB_TITLE
FROM EMPLOYEES e
         JOIN JOBS j ON e.JOB_ID = j.JOB_ID
WHERE e.SALARY > ALL (SELECT AVG(SALARY)
                      FROM EMPLOYEES
                      WHERE DEPARTMENT_ID IS NOT NULL
                      GROUP BY DEPARTMENT_ID);

--31. the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
--32. the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
--33. the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees)
-- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than
-- the average salary of all employees.
--34. all the employees who earn more than the average and who work in any of the IT departments.
--35. who earns more than Mr. Ozer.
--36. which employees have a manager who works for a department based in the US.
--37. the names of all employees whose salary is greater than 50% of their department’s total salary bill.
--38. the employee id, name ( first name and last name ), salary, department name and city for all
--the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.  
--39. the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary.
--40. the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
--41. the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.
--42. the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201.
--43. the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.
--44. the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
--45. the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
--46. the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.
--47. the full name (first and last name) of manager who is supervising 4 or more employees.
--48. the details of the current job for those employees who worked as a Sales Representative in the past.
--49. all the infromation about those employees who earn second lowest salary of all the employees.
--50. the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.
