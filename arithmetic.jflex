import java.util.ArrayList;

%%

%standalone
%class ArithmeticLexer

%{
	boolean isOK = true;
	ArrayList<String> output = new ArrayList<String>();
	ArrayList<String> error_log = new ArrayList<String>();
%}

%eof{
	if(isOK){
		for(int i = 0; i < output.size(); i++){
			System.out.println(output.get(i));
		}
	}else{
		System.out.println("Erro na análise do arquivo");
		for(int i = 0; i < error_log.size(); i++){
			System.out.println(error_log.get(i));
		}
	}
%eof}

/* Definições */
digit = [0-9]
integer = {digit}*
real = {integer}\.{integer}

%%

"*"             { output.add("* | Operador de multiplicação"); }
"+"             { output.add("+ | Operador de adição"); }
"-"             { output.add("- | Operador de subtração"); }
"/"             { output.add("/ | Operador de divisão"); }
{integer}		{ output.add(yytext() + " | Valor inteiro");}
{real}			{ output.add(yytext() + " | Valor real"); }
[ \n\r\t]		{ }
.				{ isOK = false; error_log.add("Entrada ilegal \""+ yytext() +"\" "); }