-- gdy nie dziala wyswietlanie
SET SERVEROUTPUT ON;
--formula poprawna
begin
insertEmployee('Marcin', 'Testowy', 'MTESTOWY', '17-SEP-18', 'AD_VP', 6000, 100, 50);
end;
--formula ze zlym departamentem
BEGIN
insertEmployee('Marcin', 'Testowy', 'MTESTOWY', '17-SEP-18', 'AD_VP', 6000, 100, 1);
END;
--formula ze zlym managerem
BEGIN
insertEmployee('Marcin', 'Testowy', 'MTESTOWY', '17-SEP-18', 'AD_VP', 6000, 1, 50);
END;
--formula ze zlym kodem stanowiska
BEGIN
insertEmployee('Marcin', 'Testowy', 'MTESTOWY', '17-SEP-18', 'NIIIIC', 6000, 100, 50);
END;
