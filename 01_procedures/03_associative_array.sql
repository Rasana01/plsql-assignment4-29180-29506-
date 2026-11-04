
SET SERVEROUTPUT ON;

DECLARE
    -- 1. Associative array
    TYPE student_names_type IS TABLE OF VARCHAR2(100)
        INDEX BY PLS_INTEGER;

    v_student_names student_names_type;

    -- 2. Nested table
    TYPE course_names_type IS TABLE OF VARCHAR2(100);

    v_courses course_names_type :=
        course_names_type(
            'Database Management Systems',
            'Software Engineering',
            'Mathematics'
        );

    -- 3. VARRAY
    TYPE course_codes_type IS VARRAY(5) OF VARCHAR2(20);

    v_course_codes course_codes_type :=
        course_codes_type(
            'INSY8311',
            'SENG8201',
            'MATH8214'
        );

BEGIN
    -- Associative array demonstration
    v_student_names(1) := 'John Mugisha';
    v_student_names(2) := 'Alice Uwase';
    v_student_names(3) := 'David Niyonsenga';

    DBMS_OUTPUT.PUT_LINE('ASSOCIATIVE ARRAY');

    FOR i IN 1..v_student_names.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_student_names(i));
    END LOOP;

    -- Nested table demonstration
    DBMS_OUTPUT.PUT_LINE('NESTED TABLE');

    FOR i IN 1..v_courses.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_courses(i));
    END LOOP;

    -- VARRAY demonstration
    DBMS_OUTPUT.PUT_LINE('VARRAY');

    FOR i IN 1..v_course_codes.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_course_codes(i));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(
        'VARRAY maximum capacity: ' || v_course_codes.LIMIT
    );
END;
/
