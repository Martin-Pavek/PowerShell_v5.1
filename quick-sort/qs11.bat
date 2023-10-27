@echo off

echo "zadej pocet cisel ?"
set /p pocet=""
REM echo "pocet cisel = %pocet%"

echo "zadej rozsah ?"
set /p rozsah=""
echo pocet "cisel = %pocet%, rozsah = od -%rozsah% do %rozsah%"
pause

REM powershell -File ./qs11.ps1 %pocet% %rozsah%> R:\qs11-out.txt
powershell -File ./qs11.ps1 %pocet% %rozsah%> R:\qs11_pocet-%pocet%_rozsah-%rozsah%.txt
type R:\qs11_pocet-%pocet%_rozsah-%rozsah%.txt
echo vysledek ulozen R:\qs11_pocet-%pocet%_rozsah-%rozsah%.txt
pause
@echo on

