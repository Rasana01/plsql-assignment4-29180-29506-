
SET SERVEROUTPUT ON;

PROMPT =====================================
PROMPT STUDENT REGISTRATION SYSTEM - ERROR TESTS
PROMPT =====================================

-- Test 1: NO_DATA_FOUND
DECLARE
    v_student_name VARCHAR2(100);
BEGIN
    SELECT first_name
    INTO v_student_name
    FROM students
    WHERE student_id = 999;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'NO_DATA_FOUND: Student does not exist.'
        );
END;
/

-- Test 2: TOO_MANY_ROWS
DECLARE
    v_student_name VARCHAR2(100);
BEGIN
    SELECT first_name
    INTO v_student_name
    FROM students;

EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE(
            'TOO_MANY_ROWS: Multiple students found.'
        );
END;
/

-- Test 3: User-defined exception
DECLARE
    e_invalid_credits EXCEPTION;
    v_credits NUMBER := -5;
BEGIN
    IF v_credits < 1 THEN
        RAISE e_invalid_credits;
    END IF;

EXCEPTION
    WHEN e_invalid_credits THEN
        DBMS_OUTPUT.PUT_LINE(
            'USER-DEFINED EXCEPTION: Invalid credits.'
        );
END;
/

PROMPT =====================================
PROMPT ERROR TESTS COMPLETED
PROMPT =====================================

SET SERVEROUTPUT ON;

PROMPT =====================================
PROMPT STUDENT REGISTRATION SYSTEM - ERROR TESTS
PROMPT =====================================

-- Test 1: NO_DATA_FOUND
DECLARE
    v_student_name VARCHAR2(100);
BEGIN
    SELECT first_name
    INTO v_student_name
    FROM students
    WHERE student_id = 999;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'NO_DATA_FOUND: Student does not exist.'
        );
END;
/

-- Test 2: TOO_MANY_ROWS
DECLARE
    v_student_name VARCHAR2(100);
BEGIN
    SELECT first_name
    INTO v_student_name
    FROM students;

EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE(
            'TOO_MANY_ROWS: Multiple students found.'
        );
END;
/

-- Test 3: User-defined exception
DECLARE
    e_invalid_credits EXCEPTION;
    v_credits NUMBER := -5;
BEGIN
    IF v_credits < 1 THEN
        RAISE e_invalid_credits;
    END IF;

EXCEPTION
    WHEN e_invalid_credits THEN
        DBMS_OUTPUT.PUT_LINE(
            'USER-DEFINED EXCEPTION: Invalid credits.'
        );
END;
/

PROMPT =====================================
PROMPT ERROR TESTS COMPLETED
PROMPT =====================================
