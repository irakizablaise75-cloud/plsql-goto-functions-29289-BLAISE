SET SERVEROUTPUT ON
SET DEFINE OFF

BEGIN EXECUTE IMMEDIATE 'DROP TABLE employees PURGE';   EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE departments PURGE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

CREATE TABLE departments (
  dept_id   NUMBER(4)     PRIMARY KEY,
  dept_name VARCHAR2(50)  NOT NULL
);

CREATE TABLE employees (
  emp_id         NUMBER(6)     PRIMARY KEY,
  first_name     VARCHAR2(30)  NOT NULL,
  last_name      VARCHAR2(30)  NOT NULL,
  monthly_salary NUMBER(12,2),
  hire_date      DATE          NOT NULL,
  dept_id        NUMBER(4) REFERENCES departments(dept_id)
);

INSERT INTO departments VALUES (10, 'Finance');
INSERT INTO departments VALUES (20, 'IT');
INSERT INTO departments VALUES (30, 'Human Resources');
INSERT INTO departments VALUES (40, 'Marketing');

INSERT INTO employees VALUES (101, 'Alice',   'Uwase',      150000, DATE '2018-03-12', 10);
INSERT INTO employees VALUES (102, 'Jean',    'Mugisha',    250000, DATE '2020-06-01', 20);
INSERT INTO employees VALUES (103, 'Aline',   'Mukamana',   450000, DATE '2015-09-15', 10);
INSERT INTO employees VALUES (104, 'Patrick', 'Habimana',   800000, DATE '2012-01-20', 30);
INSERT INTO employees VALUES (105, 'Grace',   'Ingabire',    55000, DATE '2023-11-05', 20);
INSERT INTO employees VALUES (106, 'Samuel',  'Niyonzima',    NULL, DATE '2022-02-02', 10);
INSERT INTO employees VALUES (107, 'David',   'Kamanzi',    300000, DATE '2027-01-15', 20);
INSERT INTO employees VALUES (108, 'Claire',  'Uwimana',    280000, DATE '2019-07-07', NULL);
COMMIT;

SELECT * FROM employees ORDER BY emp_id;
