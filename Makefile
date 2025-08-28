all:
	flex -o Frontend/Lexer.cpp Frontend/Lexer.l
	bison -o Frontend/Parser.cpp Frontend/Parser.y
	g++ -g Main.cpp Frontend/Lexer.cpp Frontend/Parser.cpp -o a.out

clean:
	rm -rf Frontend/Lexer.cpp
	rm -rf Frontend/Parser.cpp Frontend/Parser.h
	rm -rf a.out
