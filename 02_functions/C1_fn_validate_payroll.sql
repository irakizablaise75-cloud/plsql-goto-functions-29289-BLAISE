CREATE OR REPLACE FUNCTION fn_validate_payroll (p_emp_id IN NUMBER)
RETURN VARCHAR2
IS
  v_emp    employees%ROWTYPE;
  v_count  NUMBER;
  v_result VARCHAR2(200) := 'VALID';
BEGIN
  SELECT COUNT(*) INTO v_count FROM employees WHERE emp_id = p_emp_id;
  IF v_count = 0 THEN
    v_result := 'INVALID: employee not found';
    GOTO done;
  END IF;

  SELECT * INTO v_emp FROM employees WHERE emp_id = p_emp_id;

  IF v_emp.monthly_salary IS NULL OR v_emp.monthly_salary <= 0 THEN
    v_result := 'INVALID: salary missing or not positive';
    GOTO done;
  END IF;

  IF v_emp.hire_date > SYSDATE THEN
    v_result := 'INVALID: hire date is in the future';
    GOTO done;
  END IF;

  IF v_emp.dept_id IS NULL THEN
    v_result := 'INVALID: no department assigned';
    GOTO done;
  END IF;
  SELECT COUNT(*) INTO v_count FROM departments WHERE dept_id = v_emp.dept_id;
  IF v_count = 0 THEN
    v_result := 'INVALID: department does not exist';
    GOTO done;
  END IF;

  IF fn_calculate_tax(v_emp.monthly_salary) >= v_emp.monthly_salary THEN
    v_result := 'INVALID: tax is not less than salary';
    GOTO done;
  END IF;

  <<done>>
  RETURN v_result;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 'INVALID: unexpected error - ' || SUBSTR(SQLERRM, 1, 120);
END fn_validate_payroll;
/
SHOW ERRORS
