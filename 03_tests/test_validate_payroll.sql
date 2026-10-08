SET SERVEROUTPUT ON
SET LINESIZE 200

SELECT emp_id, first_name, fn_validate_payroll(emp_id) AS payroll_status
FROM   employees
ORDER  BY emp_id;

SELECT fn_validate_payroll(9999) AS payroll_status FROM dual;
