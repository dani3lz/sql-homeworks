INSERT INTO REGIONS
VALUES (1, 'Europa');

INSERT INTO COUNTRIES
VALUES ('MD', 'Moldova', 1);

INSERT INTO LOCATIONS
VALUES (1, NULL, NULL, NULL, NULL, 'MD');

INSERT INTO DEPARTMENTS
VALUES (10, 'Administration', NULL, 1);

INSERT INTO JOBS
VALUES ('AD_PRES', 'President', 20000, 40000);

INSERT INTO EMPLOYEES
VALUES ( 101
       , 'Neena'
       , 'Kochhar'
       , 'NKOCHHAR'
       , '515.123.4568'
       , TO_DATE('21-09-2005', 'dd-MM-yyyy')
       , 'AD_PRES'
       , 21000
       , NULL
       , NULL
       , 10);

INSERT INTO JOB_HISTORY
VALUES ( 101
       , TO_DATE('13-FEB-2000', 'dd-MM-yyyy')
       , TO_DATE('19-JUL-2001', 'dd-MM-yyyy')
       , 'AD_PRES'
       , 10);