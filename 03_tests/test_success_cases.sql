
SET SERVEROUTPUT ON;

PROMPT =====================================
PROMPT STUDENT REGISTRATION SYSTEM - SUCCESS TESTS
PROMPT =====================================

-- Test 1: User-defined record
DECLARE
    TYPE student_record_type IS RECORD (
        student_id NUMBER,
        first_name VARCHAR2(50),
        last_name VARCHAR2(50)
    );

    v_student student_record_type;
BEGIN
    SELECT student_id, first_name, last_name
    INTO v_student
    FROM students
    WHERE student_id = 1;

    DBMS_OUTPUT.PUT_LINE(
        'Record test: ' || v_student.first_name || ' ' ||
        v_student.last_name
    );
END;
/

-- Test 2: Student average function
SELECT get_student_average(1) AS student_average
FROM dual;

-- Test 3: Registration count function
SELECT get_registration_count(1) AS total_registrations
FROM dual;

-- Test 4: Explicit cursor
DECLARE
    CURSOR student_cursor IS
        SELECT student_id, first_name, last_name
        FROM students
        ORDER BY student_id;
BEGIN
    FOR student_row IN student_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(
            student_row.student_id || ' - ' ||
            student_row.first_name || ' ' ||
            student_row.last_name
        );
    END LOOP;
END;
/

PROMPT =====================================
PROMPT SUCCESS TESTS COMPLETED
PROMPT =====================================
