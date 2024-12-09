CXX = g++
CXXFLAGS = -Wall -ggdb -pthread

TARGETS = question2

OBJS = thread.o utils.o

.PHONY:	all clean cleanall

all: $(TARGETS)

question2: question2.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)

*.o:	*.h

clean:
	rm -f *.o

cleanall:	clean
	rm -f $(TARGETS) 
