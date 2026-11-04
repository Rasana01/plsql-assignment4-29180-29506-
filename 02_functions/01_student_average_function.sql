CREATE OR REPLACE FUNCTION get_student_average (
    p_student_id IN NUMBER
)
RETURN NUMBER
AS
    v_average NUMBER;
BEGIN
    SELECT AVG(grade)
    INTO v_average
    FROM registrations
    WHERE student_id = p_student_id
      AND status = 'COMPLETED';

    RETURN v_average;
END;
/