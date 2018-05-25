CREATE PROCEDURE InsertEmployee (
    P_FIRST_NAME IN VARCHAR2,
    P_LAST_NAME IN VARCHAR2,
    P_EMAIL IN VARCHAR2,
    P_HIRE_DATE IN DATE,
    P_JOB_ID IN VARCHAR2,
    P_SALARY IN NUMBER,
    P_DEPARTMENT_ID IN NUMBER,
    P_MANAGER_ID IN NUMBER) IS
BEGIN
    IF (P_HIRE_DATE IS NULL OR P_JOB_ID IS NULL OR P_EMAIL IS NULL OR P_LAST_NAME IS NULL) THEN
        RAISE not_nullable_exception;
    ELSE IF (SELECT MANAGER_ID FROM DEPARTMENTS WHERE MANAGER_ID=P_MANAGER_ID) IS NOT NULL THEN
        RAISE incorrect_manager_id_exception;
    ELSE IF (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID=P_DEPARTMENT_ID) IS NOT NULL THEN
        RAISE incorrect_department_id_exception;
    ELSE IF (SELECT JOB_ID FROM JOBS WHERE JOB_ID=P_JOB_ID) IS NOT NULL THEN
        RAISE incorrect_job_id_exception;
    ELSE IF ((SELECT MAX_SALARY FROM JOBS WHERE JOB_ID = P_JOB_ID)<P_SALARY OR (SELECT MIN_SALARY FROM JOBS WHERE JOB_ID = P_JOB_ID)>P_SALARY) THEN
        RAISE incorrect_salary_exception;
    -- ELSE IF ()
    END IF;
    INSERT INTO EMPLOYEES(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, SALARY, DEPARTMENT_ID, MANAGER_ID)
    VALUES (SEQ_EMP_ID.NEXTVAL, P_FIRST_NAME, P_LAST_NAME, P_EMAIL, P_HIRE_DATE, P_JOB_ID, P_SALARY, P_DEPARTMENT_ID, P_MANAGER_ID);
EXCEPTION
    WHEN not_nullable_exception THEN
        dbms_output.put_line('wartość NULL dla pola z warunkiem NOT NULL');
    WHEN incorrect_manager_id_exception THEN
        dbms_output.put_line('niewłaściwy lub nieistniejący kod przełożonego');
    WHEN incorrect_department_id_exception THEN
        dbms_output.put_line('niewłaściwy lub nieistniejący kod departamentu');
    WHEN incorrect_job_id_exception THEN
        dbms_output.put_line('niewłaściwy lub nieistniejący kod stanowiska');
    WHEN incorrect_salary_exception THEN
        dbms_output.put_line('pensja spoza zakresu przysługującego wynagrodzenia dla zajmowanego stanowiska');
END InsertEmployee;
