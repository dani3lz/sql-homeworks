ALTER TABLE LOCATIONS
    ADD department_amount NUMBER(6);

COMMENT
ON COLUMN LOCATIONS.department_amount IS 'Contains the amount of departments in the location';

CREATE
OR REPLACE TRIGGER trg_count_nr_of_departments
    AFTER INSERT OR DELETE
ON DEPARTMENTS
DECLARE
BEGIN
MERGE INTO LOCATIONS l
    USING (SELECT COUNT(department_id) as nr_of_departments, location_id
           FROM DEPARTMENTS b
           GROUP BY location_id) res
    ON (l.location_id = res.location_id)
    WHEN MATCHED THEN
        UPDATE SET l.department_amount = res.nr_of_departments;
END;