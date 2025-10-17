-- =========================================================
-- PL/SQL PROGRAMS: Q1 - Q8
-- =========================================================

-- Enable output
SET SERVEROUTPUT ON;

-- =========================================================
-- Q1: Swap Two Numbers
-- =========================================================
DECLARE
    a NUMBER := 10;
    b NUMBER := 20;
    temp NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Q1: Swap Two Numbers');
    DBMS_OUTPUT.PUT_LINE('Before Swap: a=' || a || ', b=' || b);
    temp := a;
    a := b;
    b := temp;
    DBMS_OUTPUT.PUT_LINE('After Swap: a=' || a || ', b=' || b);
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
END;
/

-- =========================================================
-- Q2: Largest of Three Numbers
-- =========================================================
DECLARE
    a NUMBER := 15;
    b NUMBER := 25;
    c NUMBER := 20;
    largest NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Q2: Largest of Three Numbers');
    IF a >= b AND a >= c THEN
        largest := a;
    ELSIF b >= a AND b >= c THEN
        largest := b;
    ELSE
        largest := c;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Largest number is: ' || largest);
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
END;
/

-- =========================================================
-- Q3: Total, Average, and Grade of 6 Subjects
-- =========================================================
DECLARE
    sub1 NUMBER := 80;
    sub2 NUMBER := 75;
    sub3 NUMBER := 90;
    sub4 NUMBER := 65;
    sub5 NUMBER := 85;
    sub6 NUMBER := 70;
    total NUMBER;
    avg NUMBER;
    grade CHAR(1);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Q3: Total, Average and Grade');
    total := sub1 + sub2 + sub3 + sub4 + sub5 + sub6;
    avg := total / 6;

    IF avg >= 90 THEN
        grade := 'A';
    ELSIF avg >= 75 THEN
        grade := 'B';
    ELSIF avg >= 60 THEN
        grade := 'C';
    ELSE
        grade := 'D';
    END IF;

    DBMS_OUTPUT.PUT_LINE('Total: ' || total);
    DBMS_OUTPUT.PUT_LINE('Average: ' || avg);
    DBMS_OUTPUT.PUT_LINE('Grade: ' || grade);
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
END;
/

-- =========================================================
-- Q4: Sum of Digits of a Number
-- =========================================================
DECLARE
    num NUMBER := 1234;
    sum_digits NUMBER := 0;
    temp NUMBER := num;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Q4: Sum of Digits');
    WHILE temp > 0 LOOP
        sum_digits := sum_digits + MOD(temp, 10);
        temp := temp / 10;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Sum of digits of ' || num || ' is ' || sum_digits);
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
END;
/

-- =========================================================
-- Q5: Reverse a Number
-- =========================================================
DECLARE
    num NUMBER := 12345;
    rev NUMBER := 0;
    temp NUMBER := num;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Q5: Reverse a Number');
    WHILE temp > 0 LOOP
        rev := rev * 10 + MOD(temp, 10);
        temp := temp / 10;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Reverse of ' || num || ' is ' || rev);
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
END;
/

-- =========================================================
-- Q6: Check Prime Number
-- =========================================================
DECLARE
    num NUMBER := 29;
    i NUMBER;
    flag BOOLEAN := TRUE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Q6: Prime Number Check');
    IF num <= 1 THEN
        flag := FALSE;
    ELSE
        FOR i IN 2..TRUNC(SQRT(num)) LOOP
            IF MOD(num, i) = 0 THEN
                flag := FALSE;
                EXIT;
            END IF;
        END LOOP;
    END IF;

    IF flag THEN
        DBMS_OUTPUT.PUT_LINE(num || ' is a prime number');
    ELSE
        DBMS_OUTPUT.PUT_LINE(num || ' is not a prime number');
    END IF;
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
END;
/

-- =========================================================
-- Q7: Factorial of a Number
-- =========================================================
DECLARE
    num NUMBER := 5;
    fact NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Q7: Factorial of a Number');
    FOR i IN 1..num LOOP
        fact := fact * i;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Factorial of ' || num || ' is ' || fact);
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
END;
/

-- =========================================================
-- Q8: Area of Circle for radius 3 to 7, store in table AREAS
-- =========================================================

-- Drop table if exists
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE AREAS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

-- Create table AREAS
CREATE TABLE AREAS (
    RADIUS NUMBER,
    AREA NUMBER
);

-- Insert area values using PL/SQL block
DECLARE
    r NUMBER;
    a NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Q8: Area of Circle for radius 3 to 7');
    FOR r IN 3..7 LOOP
        a := 3.1416 * r * r;
        INSERT INTO AREAS(RADIUS, AREA) VALUES (r, a);
        DBMS_OUTPUT.PUT_LINE('Radius: ' || r || ', Area: ' || a);
    END LOOP;
    COMMIT;
END;
/

-- Display inserted values
SELECT * FROM AREAS;


--

-- =========================================================
-- PL/SQL PROCEDURES & FUNCTIONS: Q1 - Q6
-- =========================================================

SET SERVEROUTPUT ON;

-- =========================================================
-- Q1: Procedure to calculate total for all students
-- =========================================================
-- Arguments: regno, mark1, mark2
CREATE OR REPLACE PROCEDURE calc_total(
    p_regno IN NUMBER,
    p_mark1 IN NUMBER,
    p_mark2 IN NUMBER
) IS
    total NUMBER;
BEGIN
    total := p_mark1 + p_mark2;
    DBMS_OUTPUT.PUT_LINE('Q1: Student RegNo ' || p_regno || ', Total Marks = ' || total);
END;
/

-- Test Q1
BEGIN
    calc_total(101, 85, 90);
    calc_total(102, 70, 75);
END;
/

-- =========================================================
-- Q2: Procedure MULTI_TABLE to display multiplication table
-- =========================================================
CREATE OR REPLACE PROCEDURE multi_table(
    num IN NUMBER,
    upto IN NUMBER
) IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Q2: Multiplication Table for ' || num || ' up to ' || upto);
    FOR i IN 1..upto LOOP
        DBMS_OUTPUT.PUT_LINE(num || ' * ' || i || ' = ' || num*i);
    END LOOP;
END;
/

-- Test Q2
BEGIN
    multi_table(5, 10);
END;
/

-- =========================================================
-- Q3: Procedure raise_sal to increase salary of an employee
-- =========================================================
-- Assuming EMPLOYEE table exists: EMPNO, ENAME, SALARY
-- Sample table creation (if not exists)
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE EMPLOYEE(EMPNO NUMBER, ENAME VARCHAR2(20), SALARY NUMBER)';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

-- Insert sample data
BEGIN
    INSERT INTO EMPLOYEE VALUES (1001, 'ARJUN', 25000);
    INSERT INTO EMPLOYEE VALUES (1002, 'ALICE', 30000);
    INSERT INTO EMPLOYEE VALUES (1003, 'BOB', 20000);
    COMMIT;
END;
/

-- Procedure to raise salary
CREATE OR REPLACE PROCEDURE raise_sal(
    p_empno IN NUMBER,
    p_increase IN NUMBER
) IS
BEGIN
    UPDATE EMPLOYEE
    SET SALARY = SALARY + p_increase
    WHERE EMPNO = p_empno;

    DBMS_OUTPUT.PUT_LINE('Q3: Updated salary of EMPNO ' || p_empno);
END;
/

-- Test Q3
BEGIN
    raise_sal(1001, 5000); -- ARJUN salary increase
    raise_sal(1002, 2000); -- ALICE salary increase
    COMMIT;
END;
/

-- Check updated salaries
SELECT * FROM EMPLOYEE;

-- =========================================================
-- Q4: Function CheckDiv
-- Returns 1 if first number divisible by second, else 0
-- =========================================================
CREATE OR REPLACE FUNCTION checkdiv(
    a IN NUMBER,
    b IN NUMBER
) RETURN NUMBER IS
BEGIN
    IF MOD(a, b) = 0 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END;
/

-- Test Q4
BEGIN
    DBMS_OUTPUT.PUT_LINE('Q4: 10 divisible by 2? ' || checkdiv(10,2));
    DBMS_OUTPUT.PUT_LINE('Q4: 10 divisible by 3? ' || checkdiv(10,3));
END;
/

-- =========================================================
-- Q5: Function POW
-- Returns first number raised to power of second number
-- =========================================================
CREATE OR REPLACE FUNCTION pow_func(
    base IN NUMBER,
    exp IN NUMBER
) RETURN NUMBER IS
    result NUMBER := 1;
BEGIN
    FOR i IN 1..exp LOOP
        result := result * base;
    END LOOP;
    RETURN result;
END;
/

-- Test Q5
BEGIN
    DBMS_OUTPUT.PUT_LINE('Q5: 2^5 = ' || pow_func(2,5));
    DBMS_OUTPUT.PUT_LINE('Q5: 3^3 = ' || pow_func(3,3));
END;
/

-- =========================================================
-- Q6: Function ODDEVEN
-- Returns TRUE if number is EVEN, FALSE otherwise
-- =========================================================
CREATE OR REPLACE FUNCTION oddeven(
    num IN NUMBER
) RETURN BOOLEAN IS
BEGIN
    IF MOD(num, 2) = 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/

-- Test Q6
DECLARE
    flag BOOLEAN;
BEGIN
    flag := oddeven(10);
    IF flag THEN
        DBMS_OUTPUT.PUT_LINE('Q6: 10 is EVEN');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Q6: 10 is ODD');
    END IF;

    flag := oddeven(7);
    IF flag THEN
        DBMS_OUTPUT.PUT_LINE('Q6: 7 is EVEN');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Q6: 7 is ODD');
    END IF;
END;
/
