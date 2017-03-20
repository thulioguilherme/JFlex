import java.util.ArrayList;

%%

%standalone
%class lexicalAnalyzer

%{
	int line = 1;
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
		System.out.println("Falha na análise do arquivo");
		for(int i = 0; i < error_log.size(); i++){
			System.out.println(error_log.get(i));
		}
	}
%eof}

/* Definições */
digito = [0-9]
caractere = [A-Za-z]
inteiro = {digito}*
real = {inteiro}\.{inteiro}
underline = [_]
identificador = {caractere}({underline}|{caractere}|{digito})*
colchete_esq = \{
colchete_dir = \}
not_colchete_dir = [^}]
comentario = {colchete_esq}({not_colchete_dir}*){colchete_dir}
	
%%

program				{ output.add(yytext() + " | Palavra reservada | Linha "+ line); }
var 				{ output.add(yytext() + " | Palavra reservada | Linha "+ line); }
integer 			{ output.add(yytext() + " | Palavra reservada | Linha "+ line); } 				
real				{ output.add(yytext() + " | Palavra reservada | Linha "+ line); }
boolean				{ output.add(yytext() + " | Palavra reservada | Linha "+ line); }
procedure			{ output.add(yytext() + " | Palavra reservada | Linha "+ line); }
begin				{ output.add(yytext() + " | Palavra reservada | Linha "+ line); }
end					{ output.add(yytext() + " | Palavra reservada | Linha "+ line); }
if 					{ output.add(yytext() + " | Palavra reservada | Linha "+ line); }
else				{ output.add(yytext() + " | Palavra reservada | Linha "+ line); }
then				{ output.add(yytext() + " | Palavra reservada | Linha "+ line); }
while				{ output.add(yytext() + " | Palavra reservada | Linha "+ line); }
do 					{ output.add(yytext() + " | Palavra reservada | Linha "+ line); }
not 				{ output.add(yytext() + " | Palavra reservada | Linha "+ line); }
";"             	{ output.add(yytext() + " | Delimitador | Linha "+ line); }
":"             	{ output.add(yytext() + " | Delimitador | Linha "+ line); }
","             	{ output.add(yytext() + " | Delimitador | Linha "+ line); }
"("             	{ output.add(yytext() + " | Delimitador | Linha "+ line); }
")"             	{ output.add(yytext() + " | Delimitador | Linha "+ line); }
"."             	{ output.add(yytext() + " | Delimitador | Linha "+ line); }
"="             	{ output.add(yytext() + " | Operador relacional | Linha "+ line); }
"<"             	{ output.add(yytext() + " | Operador relacional | Linha "+ line); }
">"             	{ output.add(yytext() + " | Operador relacional | Linha "+ line); }
"<="            	{ output.add(yytext() + " | Operador relacional | Linha "+ line); }
">="            	{ output.add(yytext() + " | Operador relacional | Linha "+ line); }
"<>"            	{ output.add(yytext() + " | Operador relacional | Linha "+ line); }
"+"					{ output.add(yytext() + " | Operador aditivo | Linha "+ line); }
"-"					{ output.add(yytext() + " | Operador aditivo | Linha "+ line); }
or					{ output.add(yytext() + " | Operador aditivo | Linha "+ line); }
"/"					{ output.add(yytext() + " | Operador multiplicativo | Linha "+ line); }
"*"					{ output.add(yytext() + " | Operador multiplicativo | Linha "+ line); }
and					{ output.add(yytext() + " | Operador multiplicativo | Linha "+ line); }
":="            	{ output.add(yytext() + " | Comando de atribuição | Linha "+ line); }
{inteiro}			{ output.add(yytext() + " | Número inteiro | Linha "+ line); }
{real}				{ output.add(yytext() + " | Número real | Linha "+ line); }
{identificador}		{ output.add(yytext() + " | Identificador | Linha "+ line); } 
{comentario}		{  }
[\n]				{ line++; }
[ \r\t]				{ }
.					{ isOK = false; error_log.add("Erro na linha "+ line +" - "+ yytext()); }