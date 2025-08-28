%header "src/Frontend/Parser.h"
%require "3.8"

// C++ specific options
%skeleton "lalr1.cc"

%define api.token.constructor
%define api.value.type variant
%define api.parser.class { Parser }
%define api.namespace { Frontend }

%code requires
{
	#include <iostream>
	#include <string>

	namespace Frontend
	{
		class Lexer;
	}
}

// Define the yylex function (the function that pops off the tokens).
// Bison needs our help to define it because the C++ structure is foreign to it.
%code top
{
	#include <iostream>

	#include "Lexer.h"
	#include "Parser.h"

    static Frontend::Parser::symbol_type yylex(Frontend::Lexer& lexer)
	{
        return lexer.get_next_token();
    }
}

// Lexer parameters
%lex-param { Frontend::Lexer& lexer }

// Parser parameters
%parse-param { Frontend::Lexer& lexer }
%parse-param { int& result }

// Error catching
%define parse.assert
%define parse.trace
%define parse.error verbose

// Define a prefix for the tokens
%define api.token.prefix {TOKEN_}

// Define the tokens
%token			EOF 0
%token<int>		LITERAL_INT
%token			PLUS MINUS STAR SLASH

// Define the non-terminals
%start			root

%type<int>		expr root

// Define associativity
%nonassoc		LITERAL_INT
%left			PLUS MINUS
%left			STAR SLASH
%right			LPAREN RPAREN

%%

root:
	expr EOF
	{
		result = $1;
	}

expr:
	LITERAL_INT
	{
		$$ = $1;
	}
|	expr PLUS expr
	{
		$$ = $1 + $3;
	}
|	expr MINUS expr
	{
		$$ = $1 - $3;
	}
|	expr STAR expr
	{
		$$ = $1 * $3;
	}
|	expr SLASH expr
	{
		$$ = ($3 == 0) ? 0 : $1 / $3;
	}
|	LPAREN expr RPAREN
	{
		$$ = $2;
	}
	;
%%

// TODO: Implement better error messages using a custom location class
void Frontend::Parser::error(const std::string& message)
{
	std::cout << message << std::endl;
}











