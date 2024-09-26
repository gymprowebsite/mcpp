.ORIG x3000                   ; Program starts at memory address x3000
LEA R0, HW                    ; Load the effective address of the string "Hello, Minecraft!" into register R0
TRAP 0x30                     ; Output the string stored at the address in R0 (TRAP x30 is used for outputting strings)
HALT                          ; Halt the program (stop execution)
HW .STRINGZ "Hello, Minecraft!" ; Define a null-terminated string in memory
.END   