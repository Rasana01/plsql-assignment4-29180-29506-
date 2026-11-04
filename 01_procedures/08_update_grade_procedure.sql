
CREATE OR REPLACE PROCEDURE update_grade (
    p_registration_id IN NUMBER,
    p_grade           IN NUMBER
)
AS
    e_invalid_grade EXCEPTION;
BEGIN
    IF p_grade < 0 OR p_grade > 100 THEN
        RAISE e_invalid_grade;
    END IF;

    UPDATE registrations
    SET grade = p_grade,
        status = 'COMPLETED'
    WHERE registration_id = p_registration_id;

    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(
            -20004,
            'Registration not found.'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE('Grade updated successfully.');

EXCEPTION
    WHEN e_invalid_grade THEN
        RAISE_APPLICATION_ERROR(
            -20005,
            'Grade must be between 0 and 100.'
        );
END;
/
