SET SERVEROUTPUT ON
DECLARE
  c_rate       CONSTANT NUMBER := 0.10;      -- 10% raise
  c_cap        CONSTANT NUMBER := 2000000;   -- at/above this: no raise
  v_name       VARCHAR2(60);
  v_new_salary NUMBER;
BEGIN
  FOR r IN (SELECT emp_id, first_name, last_name, monthly_salary
              FROM employees ORDER BY emp_id) LOOP

    v_name := RPAD(r.first_name || ' ' || r.last_name, 24);

    IF r.monthly_salary IS NULL OR r.monthly_salary <= 0 THEN
      DBMS_OUTPUT.PUT_LINE(v_name || ' | SKIPPED (missing or invalid salary)');
      CONTINUE;
    END IF;

    IF r.monthly_salary >= c_cap THEN
      DBMS_OUTPUT.PUT_LINE(v_name || ' | current=' || RPAD(r.monthly_salary, 7) ||
        ' | SKIPPED (at/above cap)');
    ELSE
      v_new_salary := ROUND(r.monthly_salary * (1 + c_rate));
      DBMS_OUTPUT.PUT_LINE(v_name || ' | current=' || RPAD(r.monthly_salary, 7) ||
        ' | new=' || v_new_salary);
    END IF;
  END LOOP;
END;
/
