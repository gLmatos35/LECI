CXX = g++
CXXFLAGS = -Wall -ggdb -pthread

TARGETS = bb-unsafe bb-safe question2 question3 question4

OBJS = thread.o utils.o

.PHONY:	all clean cleanall

all: $(TARGETS)

bb-unsafe: main.o fifo-unsafe.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)

bb-safe: main.o fifo-mon-safe.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)

question2: question2.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)

question3: question3.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)

question4: question4.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)

*.o:	*.h

clean:
	rm -f *.o

cleanall:	clean
	rm -f $(TARGETS) 
