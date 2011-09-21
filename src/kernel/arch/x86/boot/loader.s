;Written by Brent Strysko
;
;This file is loaded by the bootloader, GRUB, and then calls the main kernel function

global load	;tells the linker script where to start the binary
extern main	;tells the linker our main method is elsewhere

MODULEALIGN equ  1<<0	;tells bootloader modules that are loaded must be aligned on page boundaries
MEMINFO     equ  1<<1	;tells bootloader to provide memory map
FLAGS       equ  MODULEALIGN | MEMINFO
MAGIC       equ    0x1BADB002           ;needed by bootloader to find header
CHECKSUM    equ -(MAGIC + FLAGS)	;also needed by bootloader	

section .text
align 4

MultiBootHeader:
   	dd MAGIC
   	dd FLAGS
   	dd CHECKSUM

STACKSIZE equ 0x4000	;16K stacksize 

load:
   	cli  				;disables interupts
	mov esp, stack + STACKSIZE	;sets up the stack
	push eax			;push magic number
	push ebx			;push info structure

   	call  main			;calls the main method in a *.cpp file
	cli
hang:					;should never happen because thats pretty bad
   	hlt
   	jmp hang

section .bss
align 4
stack:
  	resb STACKSIZE			;reserve stackspace on doubleword boundary
