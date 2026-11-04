
SET SERVEROUTPUT ON;

BEGIN
    -- INSERT demonstration
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
        9003, 3, 103, 3, '2026-2027', SYSDATE, 'REGISTERED'
    );

    DBMS_OUTPUT.PUT_LINE(
        'INSERT rows affected: ' || SQL%ROWCOUNT
    );

    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('INSERT SQL%FOUND: TRUE');
    END IF;

    -- DELETE demonstration
    DELETE FROM registrations
    WHERE registration_id = 9003;

    DBMS_OUTPUT.PUT_LINE(
        'DELETE rows affected: ' || SQL%ROWCOUNT
    );

    -- UPDATE demonstration
    UPDATE students
    SET phone = phone
    WHERE student_id = 1;

    DBMS_OUTPUT.PUT_LINE(
        'UPDATE rows affected: ' || SQL%ROWCOUNT
    );

    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('UPDATE SQL%FOUND: TRUE');
    END IF;

    UPDATE students
    SET phone = phone
    WHERE student_id = 999;

    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('UPDATE SQL%NOTFOUND: TRUE');
    END IF;
END;
/
