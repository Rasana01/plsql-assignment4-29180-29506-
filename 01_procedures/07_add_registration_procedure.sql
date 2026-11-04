
CREATE OR REPLACE PROCEDURE add_registration (
    p_registration_id IN NUMBER,
    p_student_id      IN NUMBER,
    p_course_id       IN NUMBER,
    p_semester        IN NUMBER,
    p_academic_year   IN VARCHAR2
)
AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM students
    WHERE student_id = p_student_id;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Student does not exist.');
    END IF;

    SELECT COUNT(*)
    INTO v_count
    FROM courses
    WHERE course_id = p_course_id;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Course does not exist.');
    END IF;

    INSERT INTO registrations (
        registration_id,
        student_id,
        course_id,
        semester,
        academic_year,
        registration_date,
        status
    )
    VALUES (
        p_registration_id,
        p_student_id,
        p_course_id,
        p_semester,
        p_academic_year,
        SYSDATE,
        'REGISTERED'
    );

    DBMS_OUTPUT.PUT_LINE('Registration created successfully.');

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(
            -20003,
            'Registration ID or enrollment already exists.'
        );
    WHEN OTHERS THEN
        RAISE;
END;
/
