#
# CSE30 Makefile
#
# we declare the object we want to build in the variable EXE
# we list the objects we want to compile (from c) in OBJS
#
# we provide a phony target clean to rm all the .o files
#

EXE = swlife
# OBJS = main.o board.o sim.o graphics30.o doRow.o timefns.o
OBJS = main.o board.o sim.o
LOBJS = timefns.o cse30life_shapes.o  cse30life_board.o graphics30.o
LIBS = -lplot -lcse30life
CC = gcc 
# CFLAGS := -O3 
CFLAGS := -O3 -g 
CFLAGS +=  --std=gnu99

# special flags for ieng6
IENG6 := $(findstring ieng6, $(shell uname -n))
ifneq ($(IENG6),)
#CFLAGS += -I/home/linux/ieng6/cs30fa19/public/local/x86/include
CFLAGS += -L/home/linux/ieng6/cs30fa19/public/local/x86/lib
# CFLAGS += -L.
endif

PI := $(findstring pi-cluster, $(shell uname -n))
ifneq ($(PI),)
#CFLAGS += -I/home/linux/ieng6/cs30fa19/public/local/arm/include
CFLAGS += -L/home/linux/ieng6/cs30fa19/public/local/arm/lib
# CFLAGS += -L.
endif
.PHONY: clean

$(EXE) : $(OBJS) 
	gcc -o $@ $(CFLAGS) $(OBJS) $(LIBS)

main.o : main.c board.h sim.h graphics30.h timefns.h cse30life.h cse30life.h
board.o : board.c board.h cse30life.h
sim.o : sim.h board.h cse30life.h
graphics30.o : graphics30.c graphics30.h
timefns.o : timefns.c timefns.h
cse30life_shapes.o : cse30life.h cse30life_shapes.c
cse30life_board.o : cse30life.h cse30life_board.c

#libcse30life.a : $(LOBJS)
#	ar rcs libcse30life.a cse30life_board.o cse30life_shapes.o timefns.o graphics30.o
#doRow.o : doRow.S
#	gcc -c $(CFLAGS) -gstabs+ doRow.S

clean :
	rm -f $(LOBJS)
	rm -f $(OBJS)
	rm $(EXE)

