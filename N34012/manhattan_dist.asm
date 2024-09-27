; manhattan_dist.asm
        .ORIG x3000              ; Program starts at memory location x3000

        LEA R0, A_X              ; Load the address of A_X into R0
        LD R1, R0                ; Load the value at A_X into R1
        TRAP x29                 ; GETP - Get player position (R0, R1, R2 will store x, y, z)
        
        ; Calculate Manhattan distance for A
        LD R3, A_X               ; Load A_X into R3
        NOT R3, R3               ; R3 = -A_X
        ADD R3, R3, R0           ; R3 = playerPos.x - A_X
        BRzp POS_X_A             ; Branch if result is positive or zero (skip negation)
        NOT R3, R3               ; If negative, get absolute value
        ADD R3, R3, #1           ; Final absolute value for x distance
POS_X_A:
        LD R4, A_Y               ; Repeat similar operations for Y and Z
        NOT R4, R4
        ADD R4, R4, R1
        BRzp POS_Y_A
        NOT R4, R4
        ADD R4, R4, #1
POS_Y_A:
        LD R5, A_Z
        NOT R5, R5
        ADD R5, R5, R2
        BRzp POS_Z_A
        NOT R5, R5
        ADD R5, R5, #1
POS_Z_A:
        ADD R3, R3, R4           ; Sum up x and y distances
        ADD R3, R3, R5           ; Sum up z distance to get total Manhattan distance

        ; Similar calculation for point B (repeat process as above)
        LD R6, B_X
        NOT R6, R6
        ADD R6, R6, R0
        BRzp POS_X_B
        NOT R6, R6
        ADD R6, R6, #1
POS_X_B:
        LD R7, B_Y
        NOT R7, R7
        ADD R7, R7, R1
        BRzp POS_Y_B
        NOT R7, R7
        ADD R7, R7, #1
POS_Y_B:
        ; Continue similar pattern for B_Z
        ; Compare R3 (distance to A) and R7 (distance to B)
        ; Output to Minecraft chat whether A, B, or equal distance

        HALT

A_X     .FILL #3                 ; Define constants for point A
A_Y     .FILL #2
A_Z     .FILL #1
B_X     .FILL #6                 ; Define constants for point B
B_Y     .FILL #7
B_Z     .FILL #5

        .END
