SET SERVEROUTPUT ON;

DECLARE
    v_student students%ROWTYPE;
BEGIN
    SELECT *
    INTO v_student
    FROM students
    WHERE student_id = 1;

    DBMS_OUTPUT.PUT_LINE('Student ID: ' || v_student.student_id);
    DBMS_OUTPUT.PUT_LINE('First Name: ' || v_student.first_name);
    DBMS_OUTPUT.PUT_LINE('Last Name: ' || v_student.last_name);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_student.email);
END;
/