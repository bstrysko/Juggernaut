#Project: Lenrek 
#Author: Brent Strysko
#All Rights Reserved

#Prevents a file named clean to prevent the clean process
.PHONY: clean

#The project's name
PROJECTNAME = lenrek

#AUXFILES is a list of non-compiled files such as readme.txt that will go into a tarball
AUXFILES :=

#Directories where the executable is stored and the .img file that is created for bochs
BINDIR :=../bin/
BOCHSDIR :=../bochs/

#PROJDIRS is all the subdirectories than contain code.  It will generally only be src unless a test branch is created.
PROJDIRS := ./

#Finds all the assembly, header, and D files in the project
ASMFILES := $(shell find $(PROJDIRS) -mindepth 1 -maxdepth 30 -name "*.s")
HDRFILES := $(shell find $(PROJDIRS) -mindepth 1 -maxdepth 30 -name "*.h")
CPPFILES := $(shell find $(PROJDIRS) -mindepth 1 -maxdepth 30 -name "*.cpp")

#The files that are used for source code aka .s and .d
SRCFILES :=$(ASMFILES)$(CPPFILES)

#Finds all the object files
OBJFILES := $(patsubst %.s,%.o,$(ASMFILES)) $(patsubst %.cpp,%.o,$(CPPFILES)) 

#Creates dependency files
DEPFILES := $(patsubst %.cpp,%.dep,$(SRCFILES))

#Used to make a tarball
ALLFILES := $(AUXFILES)$(HDRFILES)$(SRCFILES) 

-include $(DEPFILES)

#Make Rules

all: $(PROJECTNAME).bin

#Makes only the basic binary of the kernel
$(PROJECTNAME).bin: $(OBJFILES)
	 @g++ -T linker.ld -o $(BINDIR)$(PROJECTNAME).bin $(OBJFILES)

#Creates dependency files
#depend:
#	$(RM) depend.depend
#	makedepend -f- -- -nostdlib -nodefaultlibs -g -c -- $(SRCFILES) > depend.depend

#Takes the .bin file adds some grub stuff and makes a .img
test: $(PROJECTNAME).bin
	@cat $(BOCHSDIR)stage1 $(BOCHSDIR)stage2 $(BOCHSDIR)pad $(BINDIR)$(PROJECTNAME).bin > $(BINDIR)$(PROJECTNAME).img

#clean:
#	-@$(RM) $(wildcard $(OBJFILES) $(DEPFILES) $(BINDIR)congere.bin congere.tgz)

#Package Congere for Distribution
dist:
	@tar czf $(PROJECTNAME).tgz $(ALLFILES)

#Prints out TODo locations
todolist:
	-@for file in $(ALLFILES); do fgrep -H -e TODO -e FIXME $$file; done; true

#How to build assembly files
%.o: %.s Makefile
	nasm -f elf -o $@ $<
	echo $@
#How to build d source files
%.o: %.cpp Makefile
	@gcc -nostdlib -nodefaultlibs -fno-builtin -fno-omit-frame-pointer -fno-exceptions -I . -g -c -o $@ $<
