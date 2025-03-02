CREATE TABLE EMPLOYMENT_LOGS
(
    employment_log_id              NUMBER(6) GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    first_name                     VARCHAR(255) NOT NULL,
    last_name                      VARCHAR(255) NOT NULL,
    employment_action              VARCHAR(5)   NOT NULL,
    employment_status_updtd_tmstmp TIMESTAMP,
    CONSTRAINT employment_action_check CHECK (employment_action = 'HIRED' OR employment_action = 'FIRED')
);