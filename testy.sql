-- gdy nie dziala wyswietlanie
SET SERVEROUTPUT ON;
--formula poprawna
begin
insertEmployee('Marcin', 'Testowy', 'MTESTOWY', '17-SEP-11', 'AD_VP', 20000, 100, 50);
end;
--formula ze zlym departamentem
BEGIN
insertEmployee('Marcin', 'Testowy', 'MTESTOWY', '17-SEP-11', 'AD_VP', 20000, 100, 1);
END;
--formula ze zlym managerem
BEGIN
insertEmployee('Marcin', 'Testowy', 'MTESTOWY', '17-SEP-11', 'AD_VP', 20000, 1, 50);
END;
--formula ze zlym kodem stanowiska
BEGIN
insertEmployee('Marcin', 'Testowy', 'MTESTOWY', '17-SEP-11', 'NIIIIC', 20000, 100, 50);
END;
--formula ze zbyt dużą pensją
BEGIN
insertEmployee('Marcin', 'Testowy', 'MTESTOWY', '17-SEP-11', 'AD_VP', 1000000, 100, 50);
END;
--formula ze zbyt małą pensją
BEGIN
insertEmployee('Marcin', 'Testowy', 'MTESTOWY', '17-SEP-11', 'AD_VP', 7, 100, 50);
END;
--formula ze złą data zatrudnienia
BEGIN
insertEmployee('Marcin', 'Testowy', 'MTESTOWY', '17-SEP-33', 'AD_VP', 20000, 100, 50);
END;
