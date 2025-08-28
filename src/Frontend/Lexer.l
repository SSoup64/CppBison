%{
	#include <iostream>
	#include <string>
	#include <cstdio>
	#include "Lexer.h"
	#include "Parser.h"

	#define yyterminate() Frontend::Parser::make_EOF();
%}

%option nodefault
%option c++
%option noyywrap
%option yyclass="Lexer"
%option prefix="Frontend_"

%%

[0-9]+ {
	return Frontend::Parser::make_LITERAL_INT(std::stoi(yytext));
}

"+" {
	return Frontend::Parser::make_PLUS();
}

"-" {
	return Frontend::Parser::make_MINUS();
}

"*" {
	return Frontend::Parser::make_STAR();
}

"/" {
	return Frontend::Parser::make_SLASH();
}

"(" {
	return Frontend::Parser::make_LPAREN();
}

")" {
	return Frontend::Parser::make_RPAREN();
}

[\t\n] ;
" " ;
. {
	std::cout << "Unexpected character " << yytext << std::endl;
}

<<EOF>> {
	return yyterminate();
}

%%


