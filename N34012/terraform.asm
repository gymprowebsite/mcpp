; terraform.asm
        .ORIG x3000

; Constants
FLAT_HEIGHT   .FILL #70            ; Desired flat height (y-coordinate)
AIR_BLOCK     .FILL #0             ; Block ID for air (to clear above flat height)
GRASS_BLOCK   .FILL #2             ; Block ID for grass block

; Program starts
START:  
        TRAP x29                   ; GETP - Get player position (x, y, z stored in R0, R1, R2)
        ADD R3, R0, #-5            ; Initialize start position for x (R3 = playerPos.x - 5)
        ADD R5, R2, #-5            ; Initialize start position for z (R5 = playerPos.z - 5)

        AND R4, R4, #0             ; Clear R4 (used to track x offset)
X_LOOP: 
        ADD R6, R1, #-1            ; Start checking blocks from y = playerPos.y - 1
        LD R7, FLAT_HEIGHT         ; Load the desired flat height into R7
        BR LOOP_Y

LOOP_Y: 
        ADD R8, R6, #0             ; Copy y position to R8
        TRAP x2B                   ; GETB - Get block at (R3, R8, R5) into R9
        BRzp CHECK_BELOW_HEIGHT    ; If block is non-empty (above height), branch to CHECK_BELOW_HEIGHT

CLEAR_ABOVE:
        LD R9, AIR_BLOCK           ; Load air block ID into R9
        TRAP x2C                   ; SETB - Set block at (R3, R8, R5) to air
        ADD R6, R6, #1             ; Increment y to move upward
        BR LOOP_Y

CHECK_BELOW_HEIGHT:
        ADD R6, R6, #-1            ; Move y down to fill if below flat height
        BRp FILL_BELOW

        ADD R4, R4, #1             ; Increment x offset
        ADD R3, R3, #1             ; Move to next x position
        ADD R4, R4, #-11           ; Check if we've processed all x (-5 to +5)
        BRn X_LOOP                 ; Continue to next column

        ADD R5, R5, #1             ; Move to next z position
        ADD R5, R5, #-11           ; Check if we've processed all z (-5 to +5)
        BRn X_LOOP                 ; Continue if not done

        HALT

FILL_BELOW:
        LD R9, GRASS_BLOCK         ; Load grass block ID
        TRAP x2C                   ; SETB - Set block at (R3, R6, R5) to grass
        ADD R6, R6, #-1            ; Move down to continue filling
        BRnzp CHECK_BELOW_HEIGHT   ; Continue filling below flat height

        .END
