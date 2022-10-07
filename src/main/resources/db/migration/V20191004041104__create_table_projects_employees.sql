CREATE TABLE PROJECTS_EMPLOYEES
(
    project_employee_id NUMBER(6) PRIMARY KEY,
    project_id          NUMBER(6),
    employee_id         NUMBER(6),
    FOREIGN KEY (project_id) REFERENCES PROJECTS (project_id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEES (employee_id) ON DELETE CASCADE
);