
SET SERVEROUTPUT ON;

DECLARE
    TYPE student_id_table IS TABLE OF students.student_id%TYPE;

    v_student_ids student_id_table;

    e_bulk_errors EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_bulk_errors, -24381);

BEGIN
    -- Retrieve multiple student IDs
    SELECT student_id
    BULK COLLECT INTO v_student_ids
    FROM students;

    DBMS_OUTPUT.PUT_LINE(
        'Students retrieved: ' || v_student_ids.COUNT
    );

    -- Perform bulk update
    FORALL i IN 1..v_student_ids.COUNT
        UPDATE students
        SET phone = phone
        WHERE student_id = v_student_ids(i);

    DBMS_OUTPUT.PUT_LINE(
        'Bulk update completed.'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Rows updated: ' || SQL%ROWCOUNT
    );

    -- Demonstrate bulk exception handling
    FORALL i IN 1..v_student_ids.COUNT SAVE EXCEPTIONS
        UPDATE students
        SET email = 'john@gmail.com'
        WHERE student_id = v_student_ids(i);

    DBMS_OUTPUT.PUT_LINE('Bulk operation completed.');

EXCEPTION
    WHEN e_bulk_errors THEN
        DBMS_OUTPUT.PUT_LINE(
            'Bulk operation encountered errors.'
        );

        DBMS_OUTPUT.PUT_LINE(
            'Successful rows: ' || SQL%ROWCOUNT
        );

        DBMS_OUTPUT.PUT_LINE(
            'Failed operations: ' || SQL%BULK_EXCEPTIONS.COUNT
        );

        FOR i IN 1..SQL%BULK_EXCEPTIONS.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(
                'Error code: ' ||
                SQL%BULK_EXCEPTIONS(i).ERROR_CODE
            );
        END LOOP;
END;
/
