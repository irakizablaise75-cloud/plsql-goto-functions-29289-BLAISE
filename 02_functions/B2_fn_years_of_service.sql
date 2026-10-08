CREATE OR REPLACE FUNCTION fn_years_of_service (p_hire_date IN DATE)
RETURN NUMBER
IS
BEGIN
  IF p_hire_date IS NULL THEN
    RETURN NULL;
  END IF;
  IF p_hire_date > SYSDATE THEN
    RAISE_APPLICATION_ERROR(-20002, 'Hire date cannot be in the future');
  END IF;
  RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, p_hire_date) / 12);
END fn_years_of_service;
/
SHOW ERRORS
