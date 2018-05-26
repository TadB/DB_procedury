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
    incorrect_job_id EXCEPTION;
    incorrect_salary EXCEPTION;
    v_manager_id DEPARTMENTS.MANAGER_ID%TYPE;
    v_department_id DEPARTMENTS.DEPARTMENT_ID%TYPE;
    flag NUMBER(3);
BEGIN
    flag := 1;
    SELECT DISTINCT MANAGER_ID INTO v_manager_id FROM EMPLOYEES WHERE MANAGER_ID=P_MANAGER_ID;
    flag := 2;
    SELECT DISTINCT DEPARTMENT_ID INTO v_department_id FROM EMPLOYEES WHERE DEPARTMENT_ID=P_DEPARTMENT_ID;

    IF (P_HIRE_DATE IS NULL OR P_JOB_ID IS NULL OR P_EMAIL IS NULL OR P_LAST_NAME IS NULL) THEN
        RAISE not_nullable;
--    ELSIF v_manager_id IS NULL THEN
--        RAISE incorrect_manager_id;
--    ELSIF (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID=P_DEPARTMENT_ID) IS NOT NULL THEN
--        RAISE incorrect_department_id_exception;
--    ELSIF (SELECT JOB_ID FROM JOBS WHERE JOB_ID=P_JOB_ID) IS NOT NULL THEN
--        RAISE incorrect_job_id_exception;
--    ELSIF ((SELECT MAX_SALARY FROM JOBS WHERE JOB_ID = P_JOB_ID)<P_SALARY OR (SELECT MIN_SALARY FROM JOBS WHERE JOB_ID = P_JOB_ID)>P_SALARY) THEN
--        RAISE incorrect_salary_exception;
    -- ELSIF ()
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
        END IF;
--    WHEN incorrect_department_id THEN
--        dbms_output.put_line('niewłaściwy lub nieistniejący kod departamentu');
--    WHEN incorrect_job_id THEN
--        dbms_output.put_line('niewłaściwy lub nieistniejący kod stanowiska');
--    WHEN incorrect_salary THEN
--        dbms_output.put_line('pensja spoza zakresu przysługującego wynagrodzenia dla zajmowanego stanowiska');
END InsertEmployee;
