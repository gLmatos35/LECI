CXX = g++
CXXFLAGS = -Wall -ggdb -pthread

TARGETS = question3 q3Rafa

OBJS = thread.o utils.o

.PHONY:	all clean cleanall

all: $(TARGETS)

question3: question3.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)

q3: q3.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)

qq3: qq3.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)

*.o:	*.h

clean:
	rm -f *.o

cleanall:	clean
	rm -f $(TARGETS) 
