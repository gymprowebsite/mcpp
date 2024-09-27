; write_binary.asm
        .ORIG x3000

        LD R0, NUMBER_TO_CONVERT ; Load the number to convert into R0
        TRAP x29                 ; GETP - Get player position (x, y, z stored in R0, R1, R2)

        ; Initialize starting position for writing bits (playerPos.x + 1)
        ADD R3, R0, #1           ; Start at (playerPos.x + 1)
        ADD R4, R1, #0           ; y-position
        ADD R5, R2, #0           ; z-position

        ; Iterate through each bit of the number
        AND R6, R6, #0           ; Clear R6 (bit counter)
LOOP:   ADD R7, R0, #0           ; Copy number to R7
        AND R7, R7, #1           ; Mask the LSB (check if it's 1 or 0)

        ; Set the block based on the bit value
        BRz WRITE_ZERO           ; If zero, branch to WRITE_ZERO
        ; Otherwise, write stone (block ID #1)
        LD R8, STONE
        TRAP x2C                 ; SETB - Set block at (R3, R4, R5) to stone
        BR NEXT_BIT

WRITE_ZERO:
        LD R8, AIR
        TRAP x2C                 ; SETB - Set block at (R3, R4, R5) to air

NEXT_BIT:
        ADD R3, R3, #1           ; Move to next x position
        ADD R0, R0, R0           ; Shift number to the right by 1 bit
        ADD R6, R6, #1           ; Increment bit counter
        ADD R7, R6, #-16         ; Check if all 16 bits have been processed
        BRn LOOP                 ; Repeat if not done

        HALT

NUMBER_TO_CONVERT .FILL #237     ; Example number to convert
STONE             .FILL #1       ; Block ID for stone
AIR               .FILL #0       ; Block ID for air

        .END
