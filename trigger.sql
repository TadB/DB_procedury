create or replace TRIGGER PositiveSalary
    BEFORE INSERT OR UPDATE ON EMPLOYEES
    FOR EACH ROW
    WHEN(NEW.SALARY < 0)
BEGIN
   raise_application_error(-20000 , 'zarobki mniejsze od zera');
END;


-- BEGIN
-- IF (:new.salary < 0) THEN
-- 	raise_application_error(-20000, 'zarobki mniejsze od zera ');
-- END IF;
-- END;
