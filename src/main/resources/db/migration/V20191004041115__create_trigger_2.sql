CREATE OR replace TRIGGER trg_insert_log
    AFTER DELETE
        OR INSERT
    ON EMPLOYEES
    FOR EACH ROW
DECLARE

    first_name        EMPLOYMENT_LOGS.first_name%type;
    last_name         EMPLOYMENT_LOGS.last_name%type;
    employment_action EMPLOYMENT_LOGS.employment_action%type;
BEGIN
    IF INSERTING
    THEN
        first_name := :new.first_name;
        last_name := :new.last_name;
        employment_action := 'HIRED';
        INSERT_LOG(first_name, last_name, employment_action);
    ELSE
        first_name := :old.first_name;
        last_name := :old.last_name;
        employment_action := 'FIRED';
        INSERT_LOG(first_name, last_name, employment_action);
    END IF;
END;