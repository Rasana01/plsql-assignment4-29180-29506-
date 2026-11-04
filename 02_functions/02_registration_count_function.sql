CREATE OR REPLACE FUNCTION get_registration_count (
    p_student_id IN NUMBER
)
RETURN NUMBER
AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM registrations
    WHERE student_id = p_student_id;

    RETURN v_count;
END;
/