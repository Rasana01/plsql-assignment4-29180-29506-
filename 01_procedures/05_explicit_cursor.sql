SET SERVEROUTPUT ON;

DECLARE
    CURSOR student_cursor IS
        SELECT student_id, first_name, last_name, email
        FROM students
        ORDER BY student_id;

    v_id students.student_id%TYPE;
    v_first_name students.first_name%TYPE;
    v_last_name students.last_name%TYPE;
    v_email students.email%TYPE;

BEGIN
    OPEN student_cursor;

    LOOP
        FETCH student_cursor
        INTO v_id, v_first_name, v_last_name, v_email;

        EXIT WHEN student_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            v_id || ' - ' || v_first_name || ' ' ||
            v_last_name || ' - ' || v_email
        );
    END LOOP;

    CLOSE student_cursor;
END;
/