%{
/*LIBRERIAS*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
FILE *yyin;
%}
/*SECCION DE OPCIONES*/
/* Esto le dice a Flex que lea un solo archivo de entrada*/
%option noyywrap
/*Esto nos permitirá obtener el número de línea*/
%option yylineno

/*SECCION DE TOKENS*/
LETRA           [a-zA-Z]
DIGITO          [0-9]

ID	            {LETRA}({LETRA}|{DIGITO})*

/*PALABRAS CLAVE*/
WHERE 	        [W|w][H|h][E|e][R|r][E|e]
FROM	        [F|f][R|r][O|o][M|n]
SELECT	        [S|s][E|e][L|l][E|e][C|c][T|t]

/*SECCIÓN DE REGLAS Y ACCIÓN SEMÁNTICA*/
%%

{WHERE} 	    { printf("\nKEYWORD: (%s)", yytext); }
{FROM} 		    { printf("\nKEYWORD:(%s)", yytext); }
{SELECT}	    { printf("\nKEYWORD: (%s)", yytext);}
{ID}		    { printf("\nID: (%s)", yytext);}

"\n"
"\t"
" "
%%

int main(int argc, char *argv[])
{
    if( (yyin = fopen(argv[1], "rt")) == NULL){
        printf("\nNo se pudo abrir el archivo: %s\n", argv[1]);
        return 1;
    }
    else{
        printf("\nAbrir archivo con éxito", argv[1]);
        yylex();
    }
    printf("\nFLEX ha terminado de leer el archivo");
    fclose(yyin);
    return 0;
}