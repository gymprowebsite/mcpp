.ORIG x3000                     ; Program starts at memory address x3000
LEA R0, HW                      ; Load the effective address of the string "Hello, World!" into register R0
PUTS                            ; Output the null-terminated string pointed to by R0
HALT                            ; Halt the program (end execution)
HW .STRINGZ "Hello, World!"     ; Define the null-terminated string "Hello, World!" in memory
.END                            ; End of the program
