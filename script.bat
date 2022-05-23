echo off
C:\GnuWin32\bin\flex Lex.l
echo "FLEX compiló la especificación léxica del archivo lexmini.l (se creó un archivo lex.yy.c)"
pause
C:\MinGW\bin\gcc.exe lex.yy.c -o Compilador.exe
echo "Ha finalizado la ejecución del compilador de C en el archivo lex.yy.c (se creó un archivo Compilador.exe)"
pause
Compilador.exe Prueba.txt
echo "Se ejecutó el analizador léxico sobre el archivo Prueba.txt"
@REM del lex.yy.c
@REM del Compilado.exe
echo "Los archivos generados a lo largo de este proceso fueron eliminados, finalizando..."
pause