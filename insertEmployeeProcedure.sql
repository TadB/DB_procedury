create or replace PROCEDURE InsertEmployee (
    P_FIRST_NAME IN VARCHAR2,
    P_LAST_NAME IN VARCHAR2,
    P_EMAIL IN VARCHAR2,
    P_HIRE_DATE IN DATE,
    P_JOB_ID IN VARCHAR2,
    P_SALARY IN NUMBER,
    P_MANAGER_ID IN NUMBER,
    P_DEPARTMENT_ID IN NUMBER) IS

    not_nullable EXCEPTION;
    incorrect_salary EXCEPTION;
    further_hire_date EXCEPTION;
    v_manager_id DEPARTMENTS.MANAGER_ID%TYPE;
    v_department_id DEPARTMENTS.DEPARTMENT_ID%TYPE;
    v_max_salary JOBS.MAX_SALARY%TYPE;
    v_min_salary JOBS.MIN_SALARY%TYPE;
    v_job_id JOBS.JOB_ID%TYPE;
    v_current_date EMPLOYEES.HIRE_DATE%TYPE;
    flag NUMBER(3);
BEGIN
    flag := 1;
    SELECT DISTINCT MANAGER_ID INTO v_manager_id FROM EMPLOYEES WHERE MANAGER_ID=P_MANAGER_ID;
    flag := 2;
    SELECT  DEPARTMENT_ID INTO v_department_id FROM DEPARTMENTS WHERE DEPARTMENT_ID=P_DEPARTMENT_ID;
    flag := 3;
    SELECT  JOB_ID INTO v_job_id FROM JOBS WHERE JOB_ID=P_JOB_ID;

    SELECT MAX_SALARY INTO v_max_salary FROM JOBS WHERE JOB_ID = P_JOB_ID;
    SELECT MIN_SALARY INTO v_min_salary FROM JOBS WHERE JOB_ID = P_JOB_ID;

    SELECT CURRENT_DATE INTO v_current_date FROM DUAL;
    IF (P_HIRE_DATE IS NULL OR P_JOB_ID IS NULL OR P_EMAIL IS NULL OR P_LAST_NAME IS NULL) THEN
        RAISE not_nullable;
    ELSIF (v_max_salary<P_SALARY OR v_min_salary>P_SALARY) THEN
       RAISE incorrect_salary;
    ELSIF P_HIRE_DATE > v_current_date THEN
        RAISE further_hire_date;
    END IF;
    INSERT INTO EMPLOYEES(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, SALARY, DEPARTMENT_ID, MANAGER_ID)
    VALUES (SEQ_EMP_ID.NEXTVAL, P_FIRST_NAME, P_LAST_NAME, P_EMAIL, P_HIRE_DATE, P_JOB_ID, P_SALARY, P_DEPARTMENT_ID, P_MANAGER_ID);
EXCEPTION
    WHEN not_nullable THEN
        dbms_output.put_line('wartość NULL dla pola z warunkiem NOT NULL');
    WHEN NO_DATA_FOUND THEN
        IF flag = 1 THEN
            DBMS_OUTPUT.PUT_LINE('niewłaściwy lub nieistniejący kod przełożonego');
        ELSIF flag = 2 THEN
            dbms_output.put_line('niewłaściwy lub nieistniejący kod departamentu');
        ELSIF flag = 3 THEN
            dbms_output.put_line('niewłaściwy lub nieistniejący kod stanowiska');
        END IF;
    WHEN incorrect_salary THEN
        dbms_output.put_line('pensja spoza zakresu przysługującego wynagrodzenia dla zajmowanego stanowiska');
    WHEN further_hire_date THEN
        dbms_output.put_line('data zatrudnienia jest wcześniejsza niż data dzisiejsza');
END InsertEmployee;
