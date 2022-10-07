-- Write a query to display: 
-- 1. the first name, last name, salary, and job grade for all employees.
SELECT first_name, last_name, salary, job_title
FROM EMPLOYEES
         LEFT JOIN JOBS USING (job_id);

-- 2. the first and last name, department, city, and state province for each employee.
SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM EMPLOYEES e
         JOIN DEPARTMENTS d ON e.department_id = d.department_id
         JOIN LOCATIONS l ON d.location_id = l.location_id;

-- 3. the first name, last name, department number and department name, for all employees for departments 80 or 40.
SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM EMPLOYEES e
         JOIN DEPARTMENTS d ON e.department_id = d.department_id
WHERE e.department_id IN (40, 80);

-- 4. those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM EMPLOYEES e
         JOIN DEPARTMENTS d ON e.department_id = d.department_id
         JOIN LOCATIONS l ON d.location_id = l.location_id
WHERE e.first_name LIKE '%z%';

-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
SELECT e1.first_name, e1.last_name, e1.salary
FROM EMPLOYEES e1
         JOIN EMPLOYEES e2 ON e2.employee_id = 182 AND e1.salary < e2.salary;

-- 6. the first name of all employees including the first name of their manager.
SELECT e1.first_name AS employee_name, e2.first_name AS manager_name
FROM EMPLOYEES e1
         JOIN EMPLOYEES e2 ON e1.manager_id = e2.employee_id;

-- 7. the first name of all employees and the first name of their manager including those who does not working under any manager.
SELECT e1.first_name AS employee_name, e2.first_name AS manager_name
FROM EMPLOYEES e1
         LEFT JOIN EMPLOYEES e2 ON e1.manager_id = e2.employee_id;

-- 8. the details of employees who manage a department.
SELECT e.*
FROM EMPLOYEES e
         LEFT JOIN DEPARTMENTS d ON e.employee_id = d.manager_id;

-- 9. the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
SELECT e1.first_name, e1.last_name, e1.department_id
FROM EMPLOYEES e1
         JOIN EMPLOYEES e2 ON e1.department_id = e2.department_id AND e2.last_name = 'Taylor';

--10. the department name and number of employees in each of the department.
SELECT d.department_name, COUNT(e.employee_id) AS number_of_employees
FROM DEPARTMENTS d
         JOIN EMPLOYEES e ON e.department_id = d.department_id
GROUP BY d.department_name;

--11. the name of the department, average salary and number of employees working in that department who got commission.
SELECT d.department_name, COUNT(e.employee_id) AS number_of_employees, AVG(e.salary) AS avg_salary
FROM DEPARTMENTS d
         JOIN EMPLOYEES e ON e.department_id = d.department_id
WHERE e.commission_pct IS NOT NULL
GROUP BY d.department_name;

--12. job title and average salary of employees.
SELECT j.job_title, AVG(e.salary) AS avg_salary
FROM EMPLOYEES e
         JOIN JOBS j ON e.job_id = j.job_id
group by j.job_title;

--13. the country name, city, and number of those departments where at least 2 employees are working.
SELECT ct.country_name, l.city, COUNT(d.department_id) AS number_of_departments
FROM EMPLOYEES e
         JOIN DEPARTMENTS d ON e.department_id = d.department_id
         JOIN LOCATIONS l ON d.location_id = l.location_id
         JOIN COUNTRIES ct on l.country_id = ct.country_id
HAVING COUNT(d.department_id) >= 2
group by ct.country_name, l.city;

--14. the employee ID, job name, number of days worked in for all those jobs in department 80.
SELECT e.employee_id, j.job_title, jh.end_date - jh.start_date AS number_of_days
FROM EMPLOYEES e
         JOIN JOBS j on e.job_id = j.job_id
         JOIN JOB_HISTORY jh on jh.employee_id = e.employee_id
WHERE jh.department_id = 80;

--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
SELECT e1.first_name || ' ' || e1.last_name AS name
FROM EMPLOYEES e1
         JOIN EMPLOYEES e2 ON e2.employee_id = 163 AND e1.salary > e2.salary;

--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
SELECT employee_id, first_name || ' ' || last_name AS name
FROM EMPLOYEES
WHERE salary > (SELECT AVG(salary) FROM EMPLOYEES);

--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
SELECT e1.first_name || ' ' || e1.last_name AS name, e1.employee_id, e1.salary
FROM EMPLOYEES e1
         JOIN EMPLOYEES e2 on e1.manager_id = e2.employee_id AND e2.first_name = 'Payam';

--18. the department number, name ( first name and last name ), job and department name for all employees in the Finance department.
SELECT d.department_id, e.first_name || ' ' || e.last_name AS name, j.job_title, d.department_name
FROM EMPLOYEES e
         JOIN JOBS j ON e.job_id = e.job_id
         JOIN DEPARTMENTS d on e.department_id = d.department_id AND d.department_name = 'Finance';

--19. all the information of an employee whose id is any of the number 134, 159 and 183.
SELECT *
FROM EMPLOYEES
WHERE employee_id IN (134, 159, 183);

--20. all the information of the employees whose salary is within the range of smallest salary and 2500.
SELECT *
FROM EMPLOYEES
WHERE salary BETWEEN (SELECT MIN(salary) FROM EMPLOYEES) AND 2500;

--21. all the information of the employees who does not work in those departments where some employees works whose id within the range 100 and 200.
SELECT *
FROM EMPLOYEES
WHERE department_id NOT IN (SELECT DISTINCT department_id
                            FROM EMPLOYEES
                            WHERE employee_id BETWEEN 100 AND 200
                              AND department_id IS NOT NULL);

--22. all the information for those employees whose id is any id who earn the second highest salary.
SELECT *
FROM EMPLOYEES
WHERE salary = (SELECT MAX(salary)
                FROM EMPLOYEES
                WHERE salary NOT IN (SELECT MAX(salary) FROM EMPLOYEES));

--23. the employee name( first name and last name ) and hireDate for all employees in the same department as Clara. Exclude Clara.
SELECT e1.first_name || ' ' || e1.last_name AS NAME, e1.hire_date
FROM EMPLOYEES e1
         JOIN EMPLOYEES e2
              ON e1.department_id = e2.department_id AND e2.first_name = 'Clara' AND e1.first_name <> 'Clara';

--24. the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.
SELECT DISTINCT e1.employee_id, e1.first_name || ' ' || e1.last_name AS name
FROM EMPLOYEES e1
         JOIN EMPLOYEES e2
              ON e1.department_id = e2.department_id AND (e2.first_name LIKE '%T%' OR e2.last_name LIKE '%T%');

--25. full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
SELECT e.first_name || ' ' || e.last_name AS name, j.job_title, jh.start_date, jh.end_date
FROM EMPLOYEES e
         JOIN JOBS j ON e.job_id = j.job_id
         JOIN JOB_HISTORY jh ON e.employee_id = jh.employee_id
WHERE e.commission_pct IS NULL;

--26. the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.
SELECT DISTINCT e.employee_id, e.first_name || ' ' || e.last_name AS name, e.salary, e.department_id
FROM EMPLOYEES e
         JOIN EMPLOYEES e2
              ON e.department_id = e2.department_id AND (e2.first_name LIKE '%J%' or e2.last_name LIKE '%J%')
WHERE e.salary > (SELECT AVG(salary) FROM EMPLOYEES);

--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS name, j.job_title
FROM EMPLOYEES e
         JOIN JOBS j ON e.job_id = j.job_id
WHERE e.salary < (SELECT salary
                  FROM EMPLOYEES
                  WHERE job_id = 'MK_MAN');

--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS name, j.job_title
FROM EMPLOYEES e
         JOIN JOBS j ON e.job_id = j.job_id
WHERE e.job_id != 'MK_MAN'
  AND e.salary < (SELECT salary
                  FROM EMPLOYEES
                  WHERE job_id = 'MK_MAN');

--29. all the information of those employees who did not have any job in the past.
SELECT *
FROM EMPLOYEES e
WHERE e.employee_id NOT IN (SELECT employee_id FROM JOB_HISTORY);

--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS name, j.job_title
FROM EMPLOYEES e
         JOIN JOBS j ON e.job_id = j.job_id
WHERE e.salary > ALL (SELECT AVG(salary)
                      FROM EMPLOYEES
                      WHERE department_id IS NOT NULL
                      GROUP BY department_id);

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
