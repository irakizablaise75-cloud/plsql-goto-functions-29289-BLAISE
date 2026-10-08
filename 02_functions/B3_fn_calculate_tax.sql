CREATE OR REPLACE FUNCTION fn_calculate_tax (p_monthly_salary IN NUMBER)
RETURN NUMBER
IS
  v_tax NUMBER;
BEGIN
  IF p_monthly_salary IS NULL THEN
    RETURN NULL;
  END IF;
  IF p_monthly_salary < 0 THEN
    RAISE_APPLICATION_ERROR(-20003, 'Salary cannot be negative');
  END IF;

  IF p_monthly_salary <= 60000 THEN
    v_tax := 0;
  ELSIF p_monthly_salary <= 100000 THEN
    v_tax := (p_monthly_salary - 60000) * 0.20;
  ELSE
    v_tax := 8000 + (p_monthly_salary - 100000) * 0.30;
  END IF;
  RETURN ROUND(v_tax, 2);
END fn_calculate_tax;
/
SHOW ERRORS
