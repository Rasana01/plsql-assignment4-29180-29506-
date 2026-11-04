-- Student Registration and Grading Management System
-- Run once in a fresh project schema.

CREATE TABLE students (
    student_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    phone VARCHAR2(20),
    date_of_birth DATE
);

CREATE TABLE courses (
    course_id NUMBER PRIMARY KEY,
    course_code VARCHAR2(20) UNIQUE NOT NULL,
    course_name VARCHAR2(100) NOT NULL,
    credits NUMBER NOT NULL,
    CONSTRAINT chk_course_credits CHECK (credits > 0)
);

CREATE TABLE registrations (
    registration_id NUMBER PRIMARY KEY,
    student_id NUMBER NOT NULL,
    course_id NUMBER NOT NULL,
    semester NUMBER NOT NULL,
    academic_year VARCHAR2(9) NOT NULL,
    registration_date DATE DEFAULT SYSDATE,
    grade NUMBER(5,2),
    status VARCHAR2(20) DEFAULT 'REGISTERED',
    CONSTRAINT fk_reg_student FOREIGN KEY (student_id)
        REFERENCES students(student_id),
    CONSTRAINT fk_reg_course FOREIGN KEY (course_id)
        REFERENCES courses(course_id),
    CONSTRAINT chk_registration_grade
        CHECK (grade BETWEEN 0 AND 100 OR grade IS NULL),
    CONSTRAINT chk_registration_status
        CHECK (status IN ('REGISTERED', 'COMPLETED', 'DROPPED')),
    CONSTRAINT uq_student_course
        UNIQUE (student_id, course_id, semester, academic_year)
);

-- Optional verification:
-- DESC students;
-- DESC courses;
-- DESC registrations;
