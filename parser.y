%{
#include <iostream>
#include <map>

std::map<std::string, float> symbols;
void yyerror(const char* err);
extern int yylex();
%}

/* %define api.value.type { std::string* } */
%union {
  std::string* str;
  float val;
  int category;
}

%token <str> IDENTIFIER
%token <val> NUMBER
%token <category> EQUALS PLUS MINUS TIMES DIVIDEDBY
%token <category> LPAREN RPAREN SEMICOLON

%type <val> expression

%left PLUS MINUS
%left TIMES DIVIDEDBY
/* %right
%nonassoc
%precedence  */

%start program

%%

program
  : program statement
  | statement
  ;

statement
  : IDENTIFIER EQUALS expression SEMICOLON
  ;

expression
  : LPAREN expression RPAREN { $$ = $2; }
  | expression PLUS expression { $$ = $1 + $3; }
  | expression MINUS expression { $$ = $1 - $3; }
  | expression TIMES expression { $$ = $1 * $3; }
  | expression DIVIDEDBY expression { $$ = $1 / $3; }
  | NUMBER { $$ = $1; }
  | IDENTIFIER { $$ = symbols[*$1]; delete $1; }
  ;

%%
