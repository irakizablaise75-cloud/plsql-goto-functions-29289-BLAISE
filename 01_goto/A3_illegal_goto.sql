SET SERVEROUTPUT ON

-- Part 1 (ILLEGAL): jumping INTO an IF block
BEGIN
  GOTO inside_if;
  IF 1 = 1 THEN
    <<inside_if>>
    DBMS_OUTPUT.PUT_LINE('Inside IF');
  END IF;
END;
/

-- Part 2 (ILLEGAL): jumping INTO a loop
BEGIN
  GOTO inside_loop;
  FOR i IN 1 .. 3 LOOP
    <<inside_loop>>
    DBMS_OUTPUT.PUT_LINE('Inside loop ' || i);
  END LOOP;
END;
/

-- Part 3 (FIX): label in the same block as the GOTO
DECLARE
  v_flag BOOLEAN := TRUE;
BEGIN
  IF v_flag THEN
    GOTO show_message;
  END IF;
  DBMS_OUTPUT.PUT_LINE('This line is skipped');

  <<show_message>>
  DBMS_OUTPUT.PUT_LINE('Fixed: label is at the same block level as the GOTO');
END;
/
