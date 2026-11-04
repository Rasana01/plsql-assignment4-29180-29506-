# Implementation Notes
## Student Registration and Grading Management System

## 1. Purpose

This document explains the database design, implementation choices, PL/SQL features, testing approach, and performance considerations used in the Student Registration and Grading Management System.

The application was developed with Oracle Database XE 21c and Oracle PL/SQL. It manages students, courses, registrations, and grades.

## 2. Database Structure

The application uses three related tables:

### 2.1 STUDENTS

The `STUDENTS` table stores student details, including the student ID, first name, last name, email, phone number, and date of birth.

### 2.2 COURSES

The `COURSES` table stores course details, including the course ID, course code, course name, and credit value.

### 2.3 REGISTRATIONS

The `REGISTRATIONS` table connects students to courses and stores registration details such as registration ID, student ID, course ID, semester, academic year, registration date, grade, and status.

### 2.4 Integrity and Relationships

The registration table references the student and course tables through foreign keys. Primary keys identify each record. The schema also uses constraints to protect data integrity, including uniqueness and valid-value checks where defined in the schema scripts.

A student may have multiple registrations, and a course may appear in multiple registrations. Each registration refers to one student and one course.

## 3. Implementation of Required PL/SQL Features

### 3.1 User-Defined Record

The user-defined record demonstration declares a record type with fields for student ID, first name, last name, and email. The fields use `%TYPE` so their data types follow the corresponding columns in the `STUDENTS` table.

The demonstration selects one student into the record variable and displays the selected fields.

### 3.2 Table-Based Record with %ROWTYPE

The `%ROWTYPE` demonstration declares a record based on the complete row structure of the `STUDENTS` table. It retrieves a student row and displays selected fields.

This approach is useful when a PL/SQL variable needs to represent a table row without declaring each field individually.

### 3.3 Collections

Three collection types are demonstrated:

- **Associative array:** Stores student names using integer indexes.
- **Nested table:** Stores a list of course names.
- **VARRAY:** Stores course codes and demonstrates a maximum capacity of five elements.

These examples show different ways to store and process multiple values in PL/SQL.

### 3.4 Implicit Cursors

The implicit cursor demonstration performs INSERT, DELETE, and UPDATE operations and checks implicit cursor attributes.

- `SQL%ROWCOUNT` reports how many rows were affected by the most recent DML statement.
- `SQL%FOUND` is true when the most recent SQL statement affected or returned one or more rows.
- `SQL%NOTFOUND` is true when the most recent SQL statement affected or returned no rows.

The attributes must be checked immediately after the relevant SQL statement because a subsequent SQL statement replaces the implicit cursor information.

### 3.5 Explicit Cursor

The explicit cursor demonstration selects student IDs, names, and email addresses from the `STUDENTS` table. It uses `OPEN`, `FETCH`, and `CLOSE` to process the returned rows one at a time. The cursor's `%NOTFOUND` attribute determines when fetching is complete.

### 3.6 Bulk Processing: BULK COLLECT and FORALL

The bulk processing demonstration uses `BULK COLLECT` to retrieve multiple student IDs into a PL/SQL collection. It then uses `FORALL` to apply DML operations to the collection elements.

Bulk processing can improve efficiency by reducing the number of context switches between the PL/SQL engine and SQL engine compared with processing each row through an individual SQL statement inside a loop.

The extended demonstration uses `SAVE EXCEPTIONS`. This allows the remaining iterations of a bulk DML operation to be attempted even if some iterations fail. The exception is identified with `PRAGMA EXCEPTION_INIT` for Oracle error `-24381`, and the failed iterations are examined through `SQL%BULK_EXCEPTIONS`.

### 3.7 Stored Procedure: ADD_REGISTRATION

The `ADD_REGISTRATION` procedure accepts a registration ID, student ID, course ID, semester, and academic year.

Before inserting the registration, it checks whether the supplied student and course exist. It raises application errors when either referenced record is missing. It also handles duplicate-key errors with a custom application error message.

### 3.8 Stored Procedure: UPDATE_GRADE

The `UPDATE_GRADE` procedure accepts a registration ID and a grade. It checks that the grade is within the permitted range of 0 to 100, updates the registration's grade, and sets its status to `COMPLETED`.

The procedure raises an application error for an invalid grade and for a registration ID that does not match an existing registration.

### 3.9 Stored Function: GET_STUDENT_AVERAGE

The `GET_STUDENT_AVERAGE` function accepts a student ID and returns the average grade for that student's registrations whose status is `COMPLETED`.

If a student has no completed grades, Oracle's `AVG` aggregate returns `NULL`.

### 3.10 Stored Function: GET_REGISTRATION_COUNT

The `GET_REGISTRATION_COUNT` function accepts a student ID and returns the number of registration rows associated with that student.

### 3.11 Exception Handling

The demonstrations cover:

- `NO_DATA_FOUND`, raised when a `SELECT ... INTO` statement returns no rows.
- `TOO_MANY_ROWS`, raised when a `SELECT ... INTO` statement returns more than one row.
- A user-defined exception, raised when a sample credit value is below the accepted minimum.
- `RAISE_APPLICATION_ERROR`, used to return a custom application error to the calling environment.
- Bulk DML exception handling using `SAVE EXCEPTIONS` and `SQL%BULK_EXCEPTIONS`.

## 4. Testing Approach

Testing is divided into successful operations and error scenarios.

### 4.1 Successful Operations

The successful tests and demonstrations include:

1. Retrieving student information with a user-defined record.
2. Retrieving a student row using `%ROWTYPE`.
3. Displaying the three collection types.
4. Performing INSERT, DELETE, and UPDATE operations and checking implicit cursor attributes.
5. Fetching student rows using an explicit cursor.
6. Retrieving student IDs with `BULK COLLECT` and performing DML with `FORALL`.
7. Adding a valid registration using `ADD_REGISTRATION`.
8. Updating a valid registration grade using `UPDATE_GRADE`.
9. Calling `GET_STUDENT_AVERAGE`.
10. Calling `GET_REGISTRATION_COUNT`.

### 4.2 Error Scenarios

The error demonstrations include:

1. Selecting a student ID that does not exist to demonstrate `NO_DATA_FOUND`.
2. Selecting multiple student rows into a scalar variable to demonstrate `TOO_MANY_ROWS`.
3. Raising a user-defined exception for an invalid credit value.
4. Calling `ADD_REGISTRATION` with a student ID that does not exist.
5. Calling `UPDATE_GRADE` with a grade outside the permitted range.
6. Raising a custom application error.
7. Demonstrating bulk DML errors with `SAVE EXCEPTIONS`.

### 4.3 Evidence

Execution screenshots are stored in the `screenshots/` directory. The README provides an image gallery that references the screenshots by their filenames.

Before submission, confirm that every image referenced by the README exists in the directory and that the filename and letter case match exactly.

## 5. Performance Considerations

The project illustrates why bulk processing is useful for operations involving multiple rows.

- `BULK COLLECT` retrieves multiple rows in a single fetch operation.
- `FORALL` submits DML operations for collection elements in bulk.
- `SAVE EXCEPTIONS` permits the bulk operation to continue attempting other iterations when individual iterations fail, then exposes the collected errors for inspection.

These features can reduce PL/SQL-to-SQL context switching. For very large result sets, fetching all rows at once can consume substantial memory; a production implementation may use limited-size bulk fetches.

## 6. Execution Order

For a fresh database, the recommended setup order is:

1. Execute `00_schema/01_create_tables.sql`.
2. Execute `00_schema/02_insert_sample_data.sql`.
3. Execute the demonstration scripts in `01_procedures`.
4. Compile `01_procedures/07_add_registration_procedure.sql`.
5. Compile `01_procedures/08_update_grade_procedure.sql`.
6. Compile the function scripts in `02_functions`.
7. Execute `03_tests/test_success_cases.sql`.
8. Execute `03_tests/test_error_cases.sql`.

Enable output in SQL*Plus before running PL/SQL blocks:

```sql
SET SERVEROUTPUT ON;
```

**Existing database warning:** If the schema and sample records have already been created, do not rerun the two schema setup scripts unless the database has first been reset or the scripts have been adapted for an existing schema. Re-running them may cause object-name or duplicate-key errors.

## 7. Known Scope and Limitations

- This is an academic demonstration project using sample student and course records.
- The collection demonstrations use sample values to illustrate the collection types.
- The bulk processing demonstration is intended to show the syntax and behavior of bulk operations; it is not a benchmark of production-scale performance.
- The project does not include a graphical user interface or user authentication layer.
- The functions and procedures assume that the database schema and required tables have already been created.

## 8. Group Members

| Student Name | Student ID |
|---|---:|
| NYIRINKINDI David | 29180 |
| NDAGIJIMANA RASANA Bonte | 29506 |

## 9. AI Usage Disclosure

AI tools were used as learning and development assistance to help explain PL/SQL concepts, prepare and review example code, troubleshoot implementation issues, and organize project documentation. The group reviewed and executed the scripts in Oracle SQL*Plus. Both members should be able to explain the submitted implementation and its test results.
