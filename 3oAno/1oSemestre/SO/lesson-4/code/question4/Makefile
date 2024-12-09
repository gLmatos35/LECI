CXX = g++
CXXFLAGS = -Wall -ggdb -pthread

TARGETS = q4

OBJS = thread.o utils.o

.PHONY:	all clean cleanall

all: $(TARGETS)

q4: q4.o pfifo.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)

*.o:	*.h

clean:
	rm -f *.o

cleanall:	clean
	rm -f $(TARGETS) 
