#include <Types.h>

#include <iostream>
#include <fstream>

#include <Frontend/Lexer.h>
#include <Frontend/Parser.h>

IntSize main()
{
	Int32 result;

	Frontend::Lexer lexer;
	Frontend::Parser parser(lexer, result);

	std::fstream fs;
	fs.open("./test.code");

	std::string userInput;

	lexer.switch_streams(&fs, nullptr);
	
	parser.parse();

	std::cout << result << std::endl;
}
