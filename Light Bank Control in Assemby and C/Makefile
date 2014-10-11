#
# Makefile template for CSE 30 -- PA2
#

#
# You need to change these next lines for each assignment
#

HEADERS		= pa2.h

C_SRCS		= main.c checkCmd.c

ASM_SRCS	= strToULong.s printChar.s displayLights.s set.s clear.s \
		  toggle.s shift.s rotate.s ripple.s

C_OBJS		= main.o checkCmd.o

ASM_OBJS	= strToULong.o printChar.o displayLights.o set.o clear.o \
		  toggle.o shift.o rotate.o ripple.o

OBJS		= ${C_OBJS} ${ASM_OBJS}

EXE		= pa2

#
# You should not need to change anything below this line
#

#
# Relevant man pages:
#
# man -M /software/common/gnu/man gcc
# man -M /software/common/gnu/man as
# man -M /opt/SUNWspro/man lint
#

GCC		= /software/common/gnu/bin/gcc
ASM		= $(GCC)
LINT		= lint

GCC_FLAGS	= -c -g -Wall -Wall -D__EXTENSIONS__
LINT_FLAGS1	= -c -err=warn
LINT_FLAGS2	= -u -err=warn
ASM_FLAGS	= -c -g
LD_FLAGS	= -g -Wall

#
# Standard rules
#

.s.o:
	@echo "Assembling each assembly source file separately ..."
	$(ASM) $(ASM_FLAGS) $<
	@echo ""

.c.o:
	@echo "Linting each C source file separately ..."
	$(LINT) $(LINT_FLAGS1) $<
	@echo ""
	@echo "Compiling each C source file separately ..."
	$(GCC) $(GCC_FLAGS) $<
	@echo ""

#
# Simply have our project target be a single default $(EXE) executable.
#

$(EXE):	$(OBJS)
	@echo "2nd phase lint on all C source files ..."
	$(LINT) $(LINT_FLAGS2) *.ln
	@echo ""
	@echo "Linking all object modules ..."
	$(GCC) -o $(EXE) $(LD_FLAGS) $(OBJS)
	@echo ""
	@echo "Done."

${C_OBJS}:      ${HEADERS}


clean:
	@echo "Cleaning up project directory ..."
	/usr/bin/rm -f *.o $(EXE) *.ln core a.out
	@echo ""
	@echo "Clean."

new:
	make clean
	make

teststrToULong: test.h pa2.h strToULong.s teststrToULong.c
	@echo "Compiling teststrToULong.c"
	gcc -g -o teststrToULong teststrToULong.c strToULong.s
	@echo "Done."

runteststrToULong: teststrToULong
	@echo "Running teststrToULong"
	@./teststrToULong

testcheckCmd: test.h pa2.h checkCmd.c testcheckCmd.c
	@echo "Compiling testcheckCmd.c"
	gcc -g -o testcheckCmd testcheckCmd.c checkCmd.c
	@echo "Done."

runtestcheckCmd: testcheckCmd
	@echo "Running testcheckCmd"
	@./testcheckCmd

testset: test.h pa2.h set.s testset.c
	@echo "Compiling testset.c"
	gcc -g -o testset testset.c set.s
	@echo "Done."

runtestset: testset
	@echo "Running testset"
	@./testset

testclear: test.h pa2.h clear.s testclear.c
	@echo "Compiling testclear.c"
	gcc -g -o testclear testclear.c clear.s
	@echo "Done."

runtestclear: testclear
	@echo "Running testclear"
	@./testclear

testtoggle: test.h pa2.h toggle.s testtoggle.c
	@echo "Compiling testtoggle.c"
	gcc -g -o testtoggle testtoggle.c toggle.s
	@echo "Done."

runtesttoggle: testtoggle
	@echo "Running testtoggle"
	@./testtoggle

testshift: test.h pa2.h shift.s testshift.c
	@echo "Compiling testshift.c"
	gcc -g -o testshift testshift.c shift.s
	@echo "Done."

runtestshift: testshift
	@echo "Running testshift"
	@./testshift

testrotate: test.h pa2.h rotate.s testrotate.c
	@echo "Compiling testrotate.c"
	gcc -g -o testrotate testrotate.c rotate.s
	@echo "Done."

runtestrotate: testrotate
	@echo "Running testrotate"
	@./testrotate

testripple: test.h pa2.h ripple.s testripple.c rotate.s displayLights.s \
	printChar.s
	@echo "Compiling testripple.c ripple.s rotate.s displayLights.s printChar.s"
	gcc -g -o testripple testripple.c ripple.s rotate.s displayLights.s printChar.s
	@echo "Done."

runtestripple: testripple
	@echo "Running testripple"
	@./testripple

