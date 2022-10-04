CREATE TABLE PROJECTS
(
    project_id          NUMBER(6) PRIMARY KEY,
    project_description VARCHAR(25) NOT NULL,
    project_investments NUMBER(6, -3) NOT NULL,
    project_revenue     NUMBER(6, 2) NOT NULL,
    number_of_hours     NUMBER(3) NOT NULL,
    CONSTRAINT project_description_len CHECK (LENGTH(project_description) > 10),
    CONSTRAINT project_investments_val CHECK (project_investments > 0)
);

CREATE TABLE PROJECTS_EMPLOYEES
(
    project_employee_id NUMBER(6) PRIMARY KEY,
    project_id          NUMBER(6),
    employee_id         NUMBER(6),
    FOREIGN KEY (project_id) REFERENCES PROJECTS (project_id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEES (employee_id) ON DELETE CASCADE
);