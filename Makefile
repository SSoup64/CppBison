TARGET      := a.out

CXX         := g++
CXXFLAGS    := -Wall -Wextra -Isrc -std=c++23

BISON		:= bison
BISONFLAGS	:= -o src/Frontend/Parser.cpp

FLEX		:= flex
FLEXFLAGS	:= -o src/Frontend/Lexer.cpp

SRCS        := $(wildcard src/*.cpp) \
			   $(wildcard src/Frontend/*.cpp)
OBJS        := $(SRCS:.cpp=.o)
DEPS        := $(OBJS:.o=.d)

.PHONY: all

all: $(TARGET)

$(TARGET): $(OBJS) src/Frontend/Parser.o src/Frontend/Lexer.o
	$(CXX) $(LDFLAGS) -o $@ $^ $(LDLIBS)

src/Frontend/Parser.cpp src/Frontend/Parser.h: src/Frontend/Parser.y
	$(BISON) $(BISONFLAGS) $<

src/Frontend/Lexer.cpp: src/Frontend/Lexer.l src/Frontend/Parser.h
	$(FLEX) $(FLEXFLAGS) $<

%.o: %.cpp src/Frontend/Parser.cpp src/Frontend/Lexer.cpp
	$(CXX) $(CXXFLAGS) -I. -c $< -o $@

.PHONY: clean distclean run

run: $(TARGET)
	./$(TARGET)

clean:
	$(RM) $(OBJS) $(DEPS)

distclean: clean
	$(RM) $(TARGET) src/Frontend/Lexer.cpp src/Frontend/Parser.h src/Frontend/Parser.cpp

-include $(DEPS)
