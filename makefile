TARGET = tests.out
LIBS = -lgtest -lgtest_main -pthread
CC = gcc
CXX = gcc
CPPFLAGS = -Wall -Werror -MMD -MP
CFLAGS = -g 
CXXFLAGS = -g -std=c++17
XUNIT_RESULTS = $(TARGET).xml
SOURCES := $(shell find $(SOURCEDIR) -name '*.cpp')
OBJECTS = $(patsubst %.cpp, %.o, $(SOURCES))
DEPS := $(OBJECTS:.o=.d)

vpath %.c $(dir $(MAKEFILE_LIST))


.PHONY: all default clean run build

default: run

all: run 

build: $(TARGET)

run: $(XUNIT_RESULTS)

$(XUNIT_RESULTS): $(TARGET)
	./$< --gtest_output="xml:$@"

$(TARGET): $(OBJECTS)
	g++ $(OBJECTS) $(CPPFLAGS) $(LIBS) -o $@ -no-pie

clean:
	$(RM) *.o
	$(RM) $(TARGET)
	$(RM) $(XUNIT_RESULTS)
	$(RM) $(DEPS)

-include $(DEPS)