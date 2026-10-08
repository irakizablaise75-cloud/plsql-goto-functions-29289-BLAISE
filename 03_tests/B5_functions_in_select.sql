SET LINESIZE 200
COL full_name FORMAT A22
COL department FORMAT A18

SELECT e.emp_id,
       e.first_name || ' ' || e.last_name AS full_name,
       fn_dept_name(e.dept_id)            AS department,
       e.monthly_salary,
       fn_annual_salary(e.monthly_salary) AS annual_salary,
       fn_years_of_service(e.hire_date)   AS years_service,
       fn_calculate_tax(e.monthly_salary) AS monthly_tax
FROM   employees e
WHERE  e.hire_date <= SYSDATE
ORDER  BY e.emp_id;

SELECT emp_id, first_name, last_name, hire_date
FROM   employees
WHERE  CASE WHEN hire_date <= SYSDATE THEN fn_years_of_service(hire_date) END >= 5;

SELECT fn_dept_name(dept_id) AS department, COUNT(*) AS headcount
FROM   employees
GROUP  BY fn_dept_name(dept_id)
ORDER  BY headcount DESC;
