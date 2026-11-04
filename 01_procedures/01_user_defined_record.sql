SET SERVEROUTPUT ON;

DECLARE
    TYPE student_record_type IS RECORD (
        student_id students.student_id%TYPE,
        first_name students.first_name%TYPE,
        last_name  students.last_name%TYPE,
        email      students.email%TYPE
    );

    v_student student_record_type;
BEGIN
    SELECT student_id, first_name, last_name, email
    INTO v_student
    FROM students
    WHERE student_id = 1;

    DBMS_OUTPUT.PUT_LINE('Student ID: ' || v_student.student_id);
    DBMS_OUTPUT.PUT_LINE('First Name: ' || v_student.first_name);
    DBMS_OUTPUT.PUT_LINE('Last Name: ' || v_student.last_name);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_student.email);
END;
/