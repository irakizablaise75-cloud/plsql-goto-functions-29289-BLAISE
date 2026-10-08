SET SERVEROUTPUT ON
DECLARE
  v_numbers SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(15, -4, 0, 8, -9);
  v_num     NUMBER;
BEGIN
  FOR i IN 1 .. v_numbers.COUNT LOOP
    v_num := v_numbers(i);

    IF v_num = 0 THEN GOTO is_zero;     END IF;
    IF v_num > 0 THEN GOTO is_positive; END IF;
    GOTO is_negative;

    <<is_zero>>
    DBMS_OUTPUT.PUT_LINE(v_num || ' is ZERO');
    GOTO next_number;

    <<is_positive>>
    IF MOD(v_num, 2) = 0 THEN
      DBMS_OUTPUT.PUT_LINE(v_num || ' is POSITIVE and EVEN');
    ELSE
      DBMS_OUTPUT.PUT_LINE(v_num || ' is POSITIVE and ODD');
    END IF;
    GOTO next_number;

    <<is_negative>>
    IF MOD(v_num, 2) = 0 THEN
      DBMS_OUTPUT.PUT_LINE(v_num || ' is NEGATIVE and EVEN');
    ELSE
      DBMS_OUTPUT.PUT_LINE(v_num || ' is NEGATIVE and ODD');
    END IF;

    <<next_number>>
    NULL;
  END LOOP;
END;
/
