-- =========================================================
-- 💼 EMP TABLE CREATION AND QUERIES
-- =========================================================

-- 1️⃣ Create EMP table
CREATE TABLE EMP (
    EMPNO NUMBER(6),
    ENAME VARCHAR2(20),
    JOB VARCHAR2(10),
    DEPTNO NUMBER(3),
    SAL NUMBER(7,2)
);

-- 2️⃣ Insert sample data
INSERT INTO EMP VALUES (1001, 'ALICE', 'MANAGER', 10, 25000);
INSERT INTO EMP VALUES (1002, 'BOB', 'CLERK', 20, 18000);
INSERT INTO EMP VALUES (1003, 'ANNA', 'ENGINEER', 10, 32000);
INSERT INTO EMP VALUES (1004, 'DAVID', 'SALESMAN', 30, 15000);
INSERT INTO EMP VALUES (1005, 'CAROL', 'CLERK', 20, 27000);
COMMIT;

-- =========================================================
-- Problem 1: Display all the details of records whose employee name starts with 'A'
-- =========================================================
SELECT * FROM EMP
WHERE ENAME LIKE 'A%';

-- =========================================================
-- Problem 2: Display all the details of records whose employee name does NOT start with 'A'
-- =========================================================
SELECT * FROM EMP
WHERE ENAME NOT LIKE 'A%';

-- =========================================================
-- Problem 3: Display the rows whose salary ranges from 15000 to 30000
-- =========================================================
SELECT * FROM EMP
WHERE SAL BETWEEN 15000 AND 30000;

-- =========================================================
-- Problem 4: Calculate the total and average salary of employees
-- =========================================================
SELECT 
    SUM(SAL) AS TOTAL_SALARY,
    AVG(SAL) AS AVERAGE_SALARY
FROM EMP;

-- =========================================================
-- Problem 5: Count the total number of records in the EMP table
-- =========================================================
SELECT COUNT(*) AS TOTAL_EMPLOYEES
FROM EMP;

-- =========================================================
-- Problem 6: Determine the max and min salary and rename columns as max_salary and min_salary
-- =========================================================
SELECT 
    MAX(SAL) AS MAX_SALARY,
    MIN(SAL) AS MIN_SALARY
FROM EMP;

-- =========================================================
-- Problem 7: Display the months between 1-JUN-10 and 1-AUG-10 in full
-- =========================================================
SELECT TO_CHAR(ADD_MONTHS(TO_DATE('01-JUN-10','DD-MON-YY'), LEVEL-1), 'MONTH') AS MONTH_NAME
FROM DUAL
CONNECT BY LEVEL <= MONTHS_BETWEEN(TO_DATE('01-AUG-10','DD-MON-YY'), TO_DATE('01-JUN-10','DD-MON-YY')) + 1;

-- =========================================================
-- Problem 8: Display the last day of the month for date 05-OCT-09
-- =========================================================
SELECT LAST_DAY(TO_DATE('05-OCT-09', 'DD-MON-YY')) AS LAST_DAY_OF_MONTH
FROM DUAL;

-- =========================================================
-- Problem 9: Find how many job titles are available in the employee table
-- =========================================================
SELECT COUNT(DISTINCT JOB) AS TOTAL_JOB_TITLES
FROM EMP;

-- =========================================================
-- Problem 10: Find the difference between the maximum and minimum salaries
-- =========================================================
SELECT (MAX(SAL) - MIN(SAL)) AS SALARY_DIFFERENCE
FROM EMP;

-- =========================================================
-- ✅ End of Script
-- =========================================================


-- =========================================================
-- 💼 EMPLOYEE & DEPARTMENT & STUDENT TABLE EXAMPLES
-- =========================================================

-- 1️⃣ Drop existing tables (ignore errors if they don't exist)
DROP TABLE EMP CASCADE CONSTRAINTS;
DROP TABLE DEPT CASCADE CONSTRAINTS;
DROP TABLE STUDENT CASCADE CONSTRAINTS;

-- 2️⃣ Create EMP table
CREATE TABLE EMP (
    EMPNO NUMBER(6),
    ENAME VARCHAR2(20),
    JOB VARCHAR2(15),
    DEPTNO NUMBER(3),
    SAL NUMBER(7,2)
);

-- 3️⃣ Create DEPT table
CREATE TABLE DEPT (
    DEPTNO NUMBER(3) PRIMARY KEY,
    DNAME VARCHAR2(20)
);

-- 4️⃣ Create STUDENT table
CREATE TABLE STUDENT (
    REG_NO NUMBER(6),
    SNAME VARCHAR2(20),
    GRADE VARCHAR2(5),
    RESULT VARCHAR2(10)
);

-- 5️⃣ Insert sample data into DEPT
INSERT INTO DEPT VALUES (1, 'HR');
INSERT INTO DEPT VALUES (2, 'IT');
INSERT INTO DEPT VALUES (3, 'SALES');
INSERT INTO DEPT VALUES (4, 'ACCOUNTS');

-- 6️⃣ Insert sample data into EMP
INSERT INTO EMP VALUES (1001, 'ARJUN', 'MANAGER', 2, 30000);
INSERT INTO EMP VALUES (1002, 'ALICE', 'MARKETING', 3, 28000);
INSERT INTO EMP VALUES (1003, 'BOB', 'CLERK', 1, 15000);
INSERT INTO EMP VALUES (1004, 'DAVID', 'MANAGER', 2, 35000);
INSERT INTO EMP VALUES (1005, 'CAROL', 'SALESMAN', 3, 20000);
INSERT INTO EMP VALUES (1006, 'RAHUL', 'ACCOUNTANT', 4, 18000);
COMMIT;

-- 7️⃣ Insert sample data into STUDENT
INSERT INTO STUDENT VALUES (201, 'John', 'A', 'PASS');
INSERT INTO STUDENT VALUES (202, 'Mary', 'B', 'PASS');
INSERT INTO STUDENT VALUES (203, 'Ravi', NULL, 'FAIL');
COMMIT;

-- =========================================================
-- Problem 1: Display employee names and salary whose salary is greater than
-- the minimum salary of the company and job title starts with 'M'
-- =========================================================
SELECT ENAME, SAL
FROM EMP
WHERE SAL > (SELECT MIN(SAL) FROM EMP)
AND JOB LIKE 'M%';

-- =========================================================
-- Problem 2: Find all employees who work in the same job as 'ARJUN'
-- =========================================================
SELECT ENAME, JOB
FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE ENAME = 'ARJUN');

-- =========================================================
-- Problem 3: Display employees who earn more than any employee in dept 1
-- =========================================================
SELECT *
FROM EMP
WHERE SAL > ANY (SELECT SAL FROM EMP WHERE DEPTNO = 1);

-- =========================================================
-- Problem 4: Display employee details where departments are same in both EMP and DEPT
-- (Inner Join)
-- =========================================================
SELECT E.ENAME, E.JOB, D.DNAME
FROM EMP E
INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

-- =========================================================
-- Problem 5: Display employee details where departments are NOT same in EMP and DEPT
-- (Non-matching departments)
-- =========================================================
SELECT E.ENAME, E.JOB, E.DEPTNO
FROM EMP E
WHERE E.DEPTNO NOT IN (SELECT DEPTNO FROM DEPT);

-- =========================================================
-- Problem 6: Display Student name and grade using LEFT OUTER JOIN
-- =========================================================
-- Suppose we join with EMP (random example for demonstration)
SELECT S.SNAME, S.GRADE
FROM STUDENT S
LEFT OUTER JOIN EMP E
ON S.REG_NO = E.EMPNO;

-- =========================================================
-- Problem 7: Display Student name, register no, and result using RIGHT OUTER JOIN
-- =========================================================
SELECT S.SNAME, S.REG_NO, S.RESULT
FROM STUDENT S
RIGHT OUTER JOIN EMP E
ON S.REG_NO = E.EMPNO;

-- =========================================================
-- Problem 8: Display Student name and register no using FULL OUTER JOIN
-- =========================================================
SELECT S.SNAME, S.REG_NO
FROM STUDENT S
FULL OUTER JOIN EMP E
ON S.REG_NO = E.EMPNO;

-- =========================================================
-- Problem 9: Display all employee names
-- =========================================================
SELECT ENAME FROM EMP;

-- =========================================================
-- ✅ End of Script
-- =========================================================
-- =========================================================
-- 🧱 TABLE CREATION
-- =========================================================

-- Drop tables first (ignore errors if not exist)
DROP TABLE EMP CASCADE CONSTRAINTS;
DROP TABLE DEPT CASCADE CONSTRAINTS;

-- Create EMP table
CREATE TABLE EMP (
    EMPNO NUMBER(6),
    ENAME VARCHAR2(20),
    JOB VARCHAR2(10),
    DEPTNO NUMBER(3),
    SAL NUMBER(7,2)
);

-- Create DEPT table
CREATE TABLE DEPT (
    DEPTNO NUMBER(2) PRIMARY KEY,
    DNAME VARCHAR2(10),
    LOC VARCHAR2(10)
);

-- =========================================================
-- 🧩 INSERT SAMPLE DATA
-- =========================================================

INSERT INTO DEPT VALUES (10, 'HR', 'DELHI');
INSERT INTO DEPT VALUES (20, 'IT', 'MUMBAI');
INSERT INTO DEPT VALUES (30, 'SALES', 'CHENNAI');

INSERT INTO EMP VALUES (1001, 'ARJUN', 'CLERK', 10, 25000);
INSERT INTO EMP VALUES (1002, 'RAVI', 'MANAGER', 20, 40000);
INSERT INTO EMP VALUES (1003, 'VICKY', 'SALESMAN', 40, 20000);
INSERT INTO EMP VALUES (1004, 'ROHAN', 'CLERK', 50, 18000);

COMMIT;

-- =========================================================
-- Problem 1: Display all the dept numbers available with both
-- the DEPT and EMP tables, avoiding duplicates.
-- (Use UNION to avoid duplicates)
-- =========================================================
SELECT DEPTNO FROM EMP
UNION
SELECT DEPTNO FROM DEPT;

-- =========================================================
-- Problem 2: Display all the dept numbers available with both
-- the DEPT and EMP tables (including duplicates)
-- (Use UNION ALL to include duplicates)
-- =========================================================
SELECT DEPTNO FROM EMP
UNION ALL
SELECT DEPTNO FROM DEPT;

-- =========================================================
-- Problem 3: Display all the dept numbers available in EMP but not in DEPT
-- and vice versa (i.e., mismatched departments)
-- (Use MINUS or combination of two queries)
-- =========================================================

-- Dept numbers in EMP but not in DEPT
SELECT DEPTNO FROM EMP
MINUS
SELECT DEPTNO FROM DEPT;

-- Dept numbers in DEPT but not in EMP
SELECT DEPTNO FROM DEPT
MINUS
SELECT DEPTNO FROM EMP;

-- ✅ Optional: Combined view (both sides)
SELECT DEPTNO FROM EMP
MINUS
SELECT DEPTNO FROM DEPT
UNION
SELECT DEPTNO FROM DEPT
MINUS
SELECT DEPTNO FROM EMP;

-- =========================================================
-- ✅ End of Script
-- =========================================================

-- =========================================================
-- 🧱 CREATE EMP TABLE
-- =========================================================
DROP TABLE EMP CASCADE CONSTRAINTS;

CREATE TABLE EMP (
    EMPNO NUMBER(6),
    ENAME VARCHAR2(20),
    JOB VARCHAR2(10),
    DEPTNO NUMBER(3),
    DEPTNAME VARCHAR2(20),
    SAL NUMBER(7,2)
);

-- =========================================================
-- 🧩 INSERT SAMPLE DATA
-- =========================================================
INSERT INTO EMP VALUES (1001, 'ARJUN', 'ASP', 10, 'IT', 30000);
INSERT INTO EMP VALUES (1002, 'ALICE', 'MANAGER', 20, 'HR', 40000);
INSERT INTO EMP VALUES (1003, 'BOB', 'ASP', 10, 'IT', 25000);
INSERT INTO EMP VALUES (1004, 'DAVID', 'CLERK', 30, 'SALES', 18000);
INSERT INTO EMP VALUES (1005, 'CAROL', 'ASP', 20, 'HR', 35000);
COMMIT;

-- =========================================================
-- Q1: Horizontal Partitioning
-- Display details of employees whose JOB = 'ASP'
-- Create a view for horizontal partitioning
-- =========================================================
CREATE OR REPLACE VIEW EMP_ASP_VIEW AS
SELECT *
FROM EMP
WHERE JOB = 'ASP';

-- Test the view
SELECT * FROM EMP_ASP_VIEW;

-- =========================================================
-- Q2: Vertical Partitioning
-- Display only empno, empname, deptno, deptname
-- Create a view for vertical partitioning
-- =========================================================
CREATE OR REPLACE VIEW EMP_VERTICAL_VIEW AS
SELECT EMPNO, ENAME, DEPTNO, DEPTNAME
FROM EMP;

-- Test the view
SELECT * FROM EMP_VERTICAL_VIEW;

-- =========================================================
-- Q3: Display all the views created
-- =========================================================
SELECT VIEW_NAME
FROM USER_VIEWS;

-- =========================================================
-- Q4: Execute DML commands on the view created
-- Example: Insert into horizontal view (EMP_ASP_VIEW)
-- Note: Only allowed if view is simple and updatable
-- =========================================================
-- Insert a new ASP employee
INSERT INTO EMP_ASP_VIEW (EMPNO, ENAME, JOB, DEPTNO, DEPTNAME, SAL)
VALUES (1006, 'RAHUL', 'ASP', 10, 'IT', 28000);

-- Update salary of an employee in the view
UPDATE EMP_ASP_VIEW
SET SAL = 29000
WHERE EMPNO = 1001;

-- Delete an employee from the view
DELETE FROM EMP_ASP_VIEW
WHERE EMPNO = 1003;

-- Check updated view
SELECT * FROM EMP_ASP_VIEW;

-- =========================================================
-- Q5: Drop a view
-- =========================================================
DROP VIEW EMP_ASP_VIEW;

-- Check views remaining
SELECT VIEW_NAME FROM USER_VIEWS;

-- =========================================================
-- ✅ End of Script
-- =========================================================

