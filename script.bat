echo off
C:\GnuWin32\bin\flex lexmini.l
echo "FLEX compiló la especificación léxica del archivo lexmini.l (se creó un archivo lex.yy.c)"
pause
C:\MinGW\bin\gcc.exe lex.yy.c -o Compilado.exe
echo "Ha finalizado la ejecución del compilado de C en el archivo lex.yy.c (se creó un archivo Compilado.exe)"
pause
Compilado.exe Prueba.txt
echo "Se ejecutó el analizador léxico sobre el archivo Prueba.txt"
@REM del lex.yy.c
@REM del Compilado.exe
echo "Los archivos generados a lo largo de este proceso fueron eliminados, finalizando..."
pause