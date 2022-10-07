CREATE
OR REPLACE PROCEDURE INSERT_LOG(first_name EMPLOYMENT_LOGS.first_name% type,
                                    last_name EMPLOYMENT_LOGS.last_name% type,
                                    employment_action EMPLOYMENT_LOGS.employment_action% type)
    IS
BEGIN
INSERT INTO EMPLOYMENT_LOGS(first_name, last_name, employment_action, employment_status_updtd_tmstmp)
VALUES (first_name, last_name, employment_action, CURRENT_TIMESTAMP);
END;