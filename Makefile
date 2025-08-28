all:
	flex -o src/Frontend/Lexer.cpp src/Frontend/Lexer.l
	bison -o src/Frontend/Parser.cpp src/Frontend/Parser.y
	g++ -g src/Main.cpp src/Frontend/Lexer.cpp src/Frontend/Parser.cpp -o a.out

clean:
	rm -rf src/Frontend/Lexer.cpp
	rm -rf src/Frontend/Parser.cpp Frontend/Parser.h
	rm -rf a.out
