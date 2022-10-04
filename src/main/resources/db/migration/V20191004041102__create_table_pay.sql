CREATE TABLE PAY
(
    cardNr      NUMBER(16) PRIMARY KEY,
    employee_id NUMBER(6) NOT NULL UNIQUE,
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEES (employee_id)
);