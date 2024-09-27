; closest_structure.asm
        .ORIG x3000

        TRAP x29                   ; GETP - Get player position (x, y, z stored in R0, R1, R2)

        ; Call TRAP to get structure distances
        TRAP x2E                   ; GETSTRUCTDIST - Get distances to predefined structures
                                   ; Distances to structures stored in R0, R1, R2, etc.

        ; Compare distances and identify the closest
        ADD R3, R0, #0             ; R3 = Distance to structure 1
        LD R4, STRUCTURE_1
        BR COMPARE

COMPARE: 
        ; Compare R3 to R1 (distance to structure 2)
        ADD R5, R3, #-R1           ; Compare distance 1 to distance 2
        BRn UPDATE_1               ; If R1 is smaller, update closest structure
        LD R4, STRUCTURE_2         ; Otherwise, structure 2 is closer
UPDATE_1:
        ADD R3, R3, R5             ; R3 = minimum distance so far

        ; Compare with other structures similarly
        ; Output the name of the closest structure

        TRAP x28                   ; CHAT - Output the name of the closest structure
        HALT

STRUCTURE_1  .STRINGZ "Structure 1 is closest."
STRUCTURE_2  .STRINGZ "Structure 2 is closest."
STRUCTURE_3  .STRINGZ "Structure 3 is closest."

        .END
