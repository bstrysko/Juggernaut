#Lenrek 
#Written Brent Strysko
#All Rights Reserved

#Prevents a file named clean to prevent the clean process
.PHONY: clean

#AUXFILES is a list of non-compiled files such as readme.txt
AUXFILES :=

#Directories where the executable is stored and the .img file that is created for bochs
BINDIR :=bin/
BOCHSDIR :=bin/bochs/

#PROJDIRS is all the subdirectories than contain code.  It will generally only be src unless a test branch is created.
PROJDIRS :=cogito/

#Finds all the assembly, header, and D files in the project
ASMFILES := $(shell find $(PROJDIRS) -mindepth 1 -maxdepth 30 -name "*.s")
HDRFILES := $(shell find $(PROJDIRS) -mindepth 1 -maxdepth 30 -name "*.h")
DFILES := $(shell find $(PROJDIRS) -mindepth 1 -maxdepth 30 -name "*.d")

#The files that are used for source code aka .s and .d
SRCFILES :=$(ASMFILES)$(DFILES)

#Finds all the object files
OBJFILES := $(patsubst %.s,%.o,$(ASMFILES)) $(patsubst %.d,%.o,$(DFILES)) 

#Creates dependency files
DEPFILES := $(patsubst %.d,%.dep,$(SRCFILES))

#Used to make a tarball
ALLFILES := $(AUXFILES)$(HDRFILES)$(SRCFILES) 

-include $(DEPFILES)

#Make Rules

all: congere.bin

#Makes only the basic binary of the kernel
congere.bin: $(OBJFILES)
	 @g++ -T linker.ld -o $(BINDIR)congere.bin $(OBJFILES)

#Creates dependency files
#depend:
#	$(RM) depend.depend
#	makedepend -f- -- -nostdlib -nodefaultlibs -g -c -- $(SRCFILES) > depend.depend

#Takes the .bin file adds some grub stuff and makes a .img
test: congere.bin
	@cat $(BOCHSDIR)stage1 $(BOCHSDIR)stage2 $(BOCHSDIR)pad $(BINDIR)congere.bin > $(BOCHSDIR)congere.img

#clean:
#	-@$(RM) $(wildcard $(OBJFILES) $(DEPFILES) $(BINDIR)congere.bin congere.tgz)

#Package Congere for Distribution
dist:
	@tar czf congere.tgz $(ALLFILES)

#Prints out TODo locations
todolist:
	-@for file in $(ALLFILES); do fgrep -H -e TODO -e FIXME $$file; done; true

#How to build assembly files
%.o: %.s Makefile
	@nasm -f elf -o $@ $<

#How to build d source files
%.o: %.d Makefile
	@gdc -nostdlib -nodefaultlibs -fno-builtin -fno-omit-frame-pointer -fno-exceptions -I . -g -c -o $@ $<

