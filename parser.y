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

%%

%%
