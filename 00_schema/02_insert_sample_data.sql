-- Run once after 01_create_tables.sql in a fresh schema.
-- Students
INSERT INTO students (student_id, first_name, last_name, email, phone, date_of_birth)
VALUES (1, 'John', 'Mugisha', 'john@gmail.com', '0788123456',
        TO_DATE('2003-05-12', 'YYYY-MM-DD'));

INSERT INTO students (student_id, first_name, last_name, email, phone, date_of_birth)
VALUES (2, 'Alice', 'Uwase', 'alice@gmail.com', '0788234567',
        TO_DATE('2004-08-20', 'YYYY-MM-DD'));

INSERT INTO students (student_id, first_name, last_name, email, phone, date_of_birth)
VALUES (3, 'David', 'Niyonsenga', 'david@gmail.com', '0788345678',
        TO_DATE('2002-11-15', 'YYYY-MM-DD'));

-- Courses
INSERT INTO courses (course_id, course_code, course_name, credits)
VALUES (101, 'INSY8311', 'Database Management Systems', 3);

INSERT INTO courses (course_id, course_code, course_name, credits)
VALUES (102, 'SENG8201', 'Software Engineering', 4);

INSERT INTO courses (course_id, course_code, course_name, credits)
VALUES (103, 'MATH8214', 'Mathematics', 3);

-- Registrations
INSERT INTO registrations
(registration_id, student_id, course_id, semester, academic_year, grade, status)
VALUES (1001, 1, 101, 1, '2026-2027', 85, 'COMPLETED');

INSERT INTO registrations
(registration_id, student_id, course_id, semester, academic_year, grade, status)
VALUES (1002, 1, 102, 1, '2026-2027', 90, 'COMPLETED');

INSERT INTO registrations
(registration_id, student_id, course_id, semester, academic_year, grade, status)
VALUES (1003, 2, 101, 1, '2026-2027', 78, 'COMPLETED');

INSERT INTO registrations
(registration_id, student_id, course_id, semester, academic_year, grade, status)
VALUES (1004, 2, 103, 1, '2026-2027', 88, 'COMPLETED');

INSERT INTO registrations
(registration_id, student_id, course_id, semester, academic_year, grade, status)
VALUES (1005, 3, 102, 1, '2026-2027', 92, 'COMPLETED');

COMMIT;

-- Verify joined data:
SELECT r.registration_id, s.first_name, s.last_name,
       c.course_code, c.course_name, r.grade, r.status
FROM registrations r
JOIN students s ON s.student_id = r.student_id
JOIN courses c ON c.course_id = r.course_id
ORDER BY r.registration_id;
