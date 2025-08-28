#include <iostream>
#include <sstream>

#include "Frontend/Lexer.h"
#include "Frontend/Parser.h"

int main()
{
	int result;

	Frontend::Lexer lexer;
	Frontend::Parser parser(lexer, result);

	std::string userInput;
	std::getline(std::cin, userInput);
	std::istringstream iss(userInput);

	lexer.switch_streams(&iss, nullptr);
	
	parser.parse();

	std::cout << result << std::endl;
}
