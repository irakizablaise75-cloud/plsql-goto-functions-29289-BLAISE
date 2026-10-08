SET SERVEROUTPUT ON
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- B1 fn_annual_salary ---');
  DBMS_OUTPUT.PUT_LINE('250000' || fn_annual_salary(250000) || ' (expected 3000000)');
  DBMS_OUTPUT.PUT_LINE('NULL' || NVL(TO_CHAR(fn_annual_salary(NULL)), 'NULL') || ' (expected NULL)');
  BEGIN
    DBMS_OUTPUT.PUT_LINE(fn_annual_salary(-1));
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('-1   error caught: ' || SQLERRM);
  END;

  DBMS_OUTPUT.PUT_LINE('--- B2 fn_years_of_service ---');
  DBMS_OUTPUT.PUT_LINE('2012-01-20' || fn_years_of_service(DATE '2012-01-20'));
  BEGIN
    DBMS_OUTPUT.PUT_LINE(fn_years_of_service(DATE '2099-01-01'));
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('future date -> error caught: ' || SQLERRM);
  END;

  DBMS_OUTPUT.PUT_LINE('--- B3 fn_calculate_tax ---');
  DBMS_OUTPUT.PUT_LINE('50000' || fn_calculate_tax(50000)  || ' (expected 0)');
  DBMS_OUTPUT.PUT_LINE('80000' || fn_calculate_tax(80000)  || ' (expected 4000)');
  DBMS_OUTPUT.PUT_LINE('250000' || fn_calculate_tax(250000) || ' (expected 53000)');

  DBMS_OUTPUT.PUT_LINE('--- B4 fn_dept_name ---');
  DBMS_OUTPUT.PUT_LINE('10' || fn_dept_name(10));
  DBMS_OUTPUT.PUT_LINE('999' || fn_dept_name(999));
  DBMS_OUTPUT.PUT_LINE('NULL' || fn_dept_name(NULL));
END;
/
