# Reflection (C2)

## 1. What is GOTO and when is it legal/illegal?
GOTO transfers control to a label. The label must be in the same block as the GOTO or in an enclosing block. It is illegal to jump into an IF block, into a loop, between CASE branches, or out of a subprogram. In A3 I got PLS-00375 for jumping into an IF and PLS-00201 for jumping into a loop. The fix was moving the label to the same block level as the GOTO.

## 2. Was GOTO or the rewrite (A4) easier to read?
A4 was easier. The IF/ELSIF version reads top to bottom and the output appears next to the condition that produces it. In A2 I had four labels and jumps scattered through the block, so I had to follow each GOTO to understand the flow. Changing the raise rule in A4 means editing one condition; in A2 it also meant moving labels.

## 3. Where did GOTO actually help?
In `fn_validate_payroll`. There are six error checks, and each one jumps to the single `<<done>>` label before the RETURN. This avoids repeating `RETURN` after every check and gives one exit point, so the function always returns `v_result`.

## 4. Benefits of functions
- Reusable: `fn_calculate_tax` is used by B5, the tests and `fn_validate_payroll`.
- One place to change a rule: editing the tax brackets in B3 fixes every caller.
- Usable inside SELECT, WHERE and GROUP BY, as B5 shows.
- Easy to test alone with small inputs.

## 5. Exception handling lessons
`fn_annual_salary(-1)` raised ORA-20001 and `fn_years_of_service` on a future date raised ORA-20002; both were caught with `WHEN OTHERS` in the test block instead of crashing the session. `fn_dept_name` returns 'Unknown department' on NO_DATA_FOUND and 'Unassigned' on NULL. B5 filters future hire dates with `CASE` in the WHERE clause so an error in one row does not break the whole query. I also learned that invalid salary, future hire date and missing department must be checked before they reach a calculation.

## 6. Challenges and what I learned
ORA-06575 (function in invalid state) cost me the most time. Re-running `create_tables.sql` drops and recreates the tables, which invalidates `fn_dept_name` and `fn_validate_payroll`. Recreating the other functions does not fix it automatically; `ALTER FUNCTION ... COMPILE` is needed. Order matters: setup first, then functions, then tests. I also confirmed that a GOTO cannot enter a loop or an IF block, and that rewriting without GOTO produces cleaner code.

## Notes (AI usage)
I used an AI assistant to draft the first version of the code and this reflection. I ran every script in Oracle myself, fixed the invalid-function problem, and can explain each file.
