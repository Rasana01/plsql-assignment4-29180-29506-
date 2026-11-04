# Student Registration and Grading Management System

## 1. Project Overview

The **Student Registration and Grading Management System** is an Oracle PL/SQL database application developed to manage student information, course details, course registrations, and academic grades.

The project demonstrates advanced Oracle PL/SQL programming concepts through practical database operations, including records, collections, cursors, bulk processing, stored procedures, stored functions, and exception handling.

## 2. Group Members

**1. NYIRINKINDI David**
- Student ID: 29180
- Class Group: C

**2. NDAGIJIMANA RASANA Bonte**
- Student ID: 29506
- Class Group: D

## 3. Project Objectives

- Design a relational database for student registration and grading.
- Demonstrate user-defined records and table-based records using `%ROWTYPE`.
- Implement associative arrays, nested tables, and VARRAYs.
- Use implicit and explicit cursors to process database records.
- Demonstrate bulk processing with `BULK COLLECT` and `FORALL`.
- Develop stored procedures for registration and grade management.
- Create stored functions for calculating student averages and registration counts.
- Apply predefined and user-defined exception handling.

## 4. Technologies and Tools

| Technology | Purpose |
|---|---|
| Oracle Database XE 21c | Relational database |
| Oracle PL/SQL | Database programming |
| SQL*Plus | Executing and testing SQL/PLSQL scripts |
| Git | Version control |
| GitHub | Source-code hosting and collaboration |

## 5. Database Design

The application uses three main relational tables.

### 4.1 STUDENTS

Stores student ID, first name, last name, email, phone number, and date of birth.

### 4.2 COURSES

Stores course ID, course code, course name, and credits.

### 4.3 REGISTRATIONS

Stores registration ID, student ID, course ID, semester, academic year, registration date, grade, and registration status.

### 4.4 Relationships

- One student can have multiple registrations.
- One course can have multiple registrations.
- Each registration references one student and one course.
- Primary keys, foreign keys, unique constraints, and check constraints help maintain data integrity.

## 6. Implemented PL/SQL Concepts

### 5.1 Records

The project demonstrates a user-defined `RECORD` type and a table-based record using `STUDENTS%ROWTYPE` to retrieve and display student information.

### 5.2 Collections

Three PL/SQL collection types are demonstrated:

- **Associative array:** Stores student names using integer indexes.
- **Nested table:** Stores a collection of course names.
- **VARRAY:** Stores course codes with a maximum capacity of five elements.

### 5.3 Implicit Cursors

Implicit cursor attributes monitor DML operations:

- `SQL%ROWCOUNT` reports the number of rows affected.
- `SQL%FOUND` indicates whether an operation affected one or more rows.
- `SQL%NOTFOUND` indicates that an operation affected no rows.

The demonstration includes INSERT, UPDATE, and DELETE operations.

### 5.4 Explicit Cursors

An explicit cursor retrieves student records from the STUDENTS table. The implementation demonstrates declaring, opening, fetching from, and closing a cursor, and checking the cursor's `%NOTFOUND` attribute.

### 5.5 Bulk Processing

The project demonstrates:

- `BULK COLLECT` to retrieve multiple student IDs into a PL/SQL collection.
- `FORALL` to perform DML operations for collection elements.
- `SAVE EXCEPTIONS` to allow bulk DML processing to continue when individual iterations fail.
- `SQL%BULK_EXCEPTIONS` to inspect errors from failed iterations.

Bulk processing reduces repeated context switches between the PL/SQL and SQL engines when processing multiple records.

### 5.6 Stored Procedures

**ADD_REGISTRATION**

- Accepts registration details as input parameters.
- Checks whether the student and course exist.
- Inserts a new registration.
- Handles duplicate registration errors.

**UPDATE_GRADE**

- Accepts a registration ID and grade.
- Validates that the grade is between 0 and 100.
- Updates the registration grade and marks the registration as completed.
- Handles invalid grades and missing registrations.

### 5.7 Stored Functions

**GET_STUDENT_AVERAGE** calculates the average of completed grades for a specified student.

**GET_REGISTRATION_COUNT** returns the number of registrations belonging to a specified student.

Both functions can be called from SQL or PL/SQL statements.

### 5.8 Exception Handling

The project demonstrates `NO_DATA_FOUND`, `TOO_MANY_ROWS`, user-defined exceptions, `RAISE_APPLICATION_ERROR`, and bulk DML exception handling using `SAVE EXCEPTIONS`.

## 7. Project Folder Structure

```text
plsql-assignment4-29506-29180/
│
├── README.md
├── .gitignore
│
├── 00_schema/
│   ├── 01_create_tables.sql
│   └── 02_insert_sample_data.sql
│
├── 01_procedures/
│   ├── 01_user_defined_record.sql
│   ├── 02_rowtype_record.sql
│   ├── 03_associative_array.sql
│   ├── 04_implicit_cursor.sql
│   ├── 05_explicit_cursor.sql
│   ├── 06_bulk_collect_forall.sql
│   ├── 07_add_registration_procedure.sql
│   └── 08_update_grade_procedure.sql
│
├── 02_functions/
│   ├── 01_student_average_function.sql
│   └── 02_registration_count_function.sql
│
├── 03_tests/
│   ├── test_success_cases.sql
│   └── test_error_cases.sql
│
├── screenshots/
│
└── docs/
    └── IMPLEMENTATION_NOTES.md
```

## 8. Installation and Execution

### 7.1 Requirements

- Oracle Database XE 21c
- SQL*Plus or Oracle SQL Developer

Connect to the Oracle database before executing the scripts.

### 7.2 Create the Schema and Sample Data

For a fresh database, execute:

```sql
@00_schema/01_create_tables.sql
@00_schema/02_insert_sample_data.sql
```

**Important:** These scripts are for initial setup only. Do not execute them again if the tables and sample records already exist, because duplicate-object or duplicate-record errors may occur.

### 7.3 Compile Stored Procedures

Execute the procedure definition scripts:

```sql
@01_procedures/07_add_registration_procedure.sql
@01_procedures/08_update_grade_procedure.sql
```

The other files in `01_procedures` contain demonstrations of records, collections, cursors, and bulk processing.

### 7.4 Compile Stored Functions

```sql
@02_functions/01_student_average_function.sql
@02_functions/02_registration_count_function.sql
```

### 7.5 Run the Demonstrations and Tests

Enable PL/SQL output:

```sql
SET SERVEROUTPUT ON;
```

Run the demonstration scripts in `01_procedures`, followed by:

```sql
@03_tests/test_success_cases.sql
@03_tests/test_error_cases.sql
```

Run scripts from the project root directory, or provide the full path to each script.

## 9. Testing and Verification

### 8.1 Successful Test Cases

- Retrieving student information using a user-defined record.
- Retrieving student information using `%ROWTYPE`.
- Displaying associative arrays, nested tables, and VARRAYs.
- Performing INSERT, UPDATE, and DELETE operations using implicit cursors.
- Fetching student records using an explicit cursor.
- Retrieving multiple records and performing bulk DML.
- Adding a valid student registration.
- Updating a valid registration grade.
- Calculating a student's average grade.
- Counting a student's registrations.

### 8.2 Error Test Cases

- Handling a student lookup that returns no rows.
- Handling a query that returns multiple rows.
- Raising a user-defined exception for invalid credits.
- Rejecting a registration for a nonexistent student.
- Rejecting a grade outside the permitted range.
- Demonstrating a custom application error.
- Handling errors during bulk DML operations.

## 10. Screenshots and Execution Evidence

The screenshots below document the execution of the project's database setup, PL/SQL demonstrations, stored procedures, functions, and exception tests. They are stored in the repository's `screenshots/` directory.

> **Important:** Screenshot filenames must match exactly. If a screenshot in your folder has a different filename, update its image path below. GitHub will not display an image if its filename or capitalization differs.

### 9.1 Database Setup

![Database setup and initial table counts](screenshots/01_database_setup.png)

### 9.2 Records and Collections

**User-defined record**

![User-defined record output](screenshots/user_defined_record_output.png)

**Table-based record using %ROWTYPE**

![ROWTYPE record output](screenshots/02_rowtype_record.png)

**Associative array, nested table, and VARRAY**

![PLSQL collection demonstrations](screenshots/03_associative_array.png)

**Nested table demonstration**

![Nested table output](screenshots/18_nested_table.png)

**VARRAY demonstration**

![VARRAY output](screenshots/19_varray.png)

### 9.3 Cursor Operations

**Implicit cursor demonstration**

![Implicit cursor output](screenshots/04_implicit_cursor.png)

**Explicit cursor demonstration**

![Explicit cursor output](screenshots/05_explicit_cursor.png)

**Implicit cursor INSERT and DELETE code**

![Implicit cursor INSERT and DELETE code](screenshots/20a_implicit_cursor_insert_delete_code.png)

**Implicit cursor INSERT and DELETE output**

![Implicit cursor INSERT and DELETE output](screenshots/20b_implicit_cursor_insert_delete_output.png)

### 9.4 Bulk Processing

**BULK COLLECT and FORALL**

![Bulk processing output](screenshots/06_bulk_processing.png)

**Bulk exception handling**

![Bulk exception handling output](screenshots/07_bulk_exception_handling.png)

### 9.5 Stored Procedures

**Successful registration**

![Add registration success](screenshots/08_add_registration_success.png)

**Invalid student registration**

![Invalid student error](screenshots/09_invalid_student_error.png)

**Successful grade update**

![Update grade success](screenshots/10_update_grade_success.png)

**Invalid grade**

![Invalid grade error](screenshots/11_invalid_grade_error.png)

### 9.6 Stored Functions

**Student average function**

![Student average function output](screenshots/12_student_average_function.png)

**Registration count function**

![Registration count function output](screenshots/13_registration_count_function.png)

### 9.7 Exception Handling

**NO_DATA_FOUND**

![NO_DATA_FOUND exception](screenshots/14_no_data_found.png)

**TOO_MANY_ROWS**

![TOO_MANY_ROWS exception](screenshots/15_too_many_rows.png)

**User-defined exception**

![User-defined exception output](screenshots/16_user_defined_exception.png)

**RAISE_APPLICATION_ERROR**

![RAISE_APPLICATION_ERROR output](screenshots/17_raise_application_error.png)

### 9.8 Final Database Verification

![Final database verification](screenshots/21_final_database_verification.png)

## 11. Performance Considerations

`BULK COLLECT` retrieves multiple rows into a PL/SQL collection in a single fetch operation instead of fetching each row individually.

`FORALL` sends DML operations for multiple collection elements in a bulk operation, reducing context switches between the PL/SQL and SQL engines.

`SAVE EXCEPTIONS` allows the remaining bulk DML iterations to continue when individual operations fail. The errors can then be examined using `SQL%BULK_EXCEPTIONS`.

These techniques are useful when processing larger datasets.

## 13. AI Usage Disclosure

AI tools were used as learning and development assistance to help understand Oracle PL/SQL concepts, prepare and review example implementations, troubleshoot errors, and organize project documentation.

The group reviewed the implementation and executed the SQL and PL/SQL scripts in Oracle SQL*Plus to test the demonstrated functionality. Both group members are responsible for understanding the submitted work.

## 14. Conclusion

The Student Registration and Grading Management System demonstrates the practical application of advanced Oracle PL/SQL programming concepts.

Through records, collections, cursors, bulk processing, stored procedures, stored functions, and exception handling, the project provides practical experience in designing, implementing, and testing a relational database application.
