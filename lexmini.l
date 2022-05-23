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
ESPACIO         ["  "]
INI_COMENTARIO  ["/*"]
FIN_COMENTARIO  ["*/"]
FIN_SENTENCIA   [";"]
GUIONES         [-_]
CHAR_PUNTO      ["."]
CHAR_COMA       [","]

ID	            {LETRA}({LETRA}|{DIGITO})*
CONST_INTEGER   (-?[1-9][0-9]{0,4})|0
CONST_FLOAT     {DIGITO}{0,8}{CHAR_DOT}{DIGITO}{1,8}

/*Operadores lógicos y operadores aritméticos básicos*/
OP_SUMA          ["+"]
OP_RESTA         ["-"]
OP_MULTIP        ["*"]
OP_DIVISION      ["/"]
OP_IGUAL         ["="]
OP_MAYOR         [">"]
OP_MENOR         ["<"]
OP_GOE           ">="
OP_LOE           "<="
OP_NOT           "!"
OP_NE            "!="

/*PALABRAS CLAVE*/
WHERE 	        [W|w][H|h][E|e][R|r][E|e]
FROM	        [F|f][R|r][O|o][M|n]
SELECT	        [S|s][E|e][L|l][E|e][C|c][T|t]

/*SECCIÓN DE REGLAS Y ACCIÓN SEMÁNTICA*/
%%
{FIN_SENTENCIA}  { printf("\nFIN_SENTENCIA (%s)", yytext);}
{CONST_INTEGER} { fn_checkran(yytext), printf("\nCONST_INTEGER (%s)", yytext);}
{CHAR_PUNTO}   { printf("\nCHAR_PUNTO (%s)", yytext);}

{OP_SUMA}        { printf("\nOP_SUMA (%s)", yytext);}
{OP_RESTA}       { printf("\nOP_RESTA (%s)", yytext);}
{OP_MULTIP}      { printf("\nOP_MULTIP (%s)", yytext);}
{OP_DIVISION}    { printf("\nOP_DIVISION (%s)", yytext);}
{OP_IGUAL}       { printf("\nOP_EQ (%s)", yytext);}
{OP_MAYOR}       { printf("\nOP_MAYOR (%s)", yytext);}
{OP_MENOR}       { printf("\nOP_MENOR (%s)", yytext);}
{OP_GOE}         { printf("\nOP_GOE (%s)", yytext);}
{OP_LOE}         { printf("\nOP_LOE (%s)", yytext);}
{OP_NOT}         { printf("\nOP_NOT (%s)", yytext);}
{OP_NE}          { printf("\nOP_NE (%s)", yytext);}

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
/*Esta función nos ayudará a saber si el valor está dentro del rango*/
int fn_checkran(char *ptr)
{
    int valor = atoi(ptr);
    if( valor < -32768 || valor > 32768 )
    {
        printf("Error: variable fuera de rango");
        return yyerror();
    }    
}

/*Esta función devolverá el error.*/
int yyerror(void){
    printf("\n Error léxico: carácter no válido: %s \n", yytext);
    exit(1);
}