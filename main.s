.include "p24Hxxxx.inc"
;.global __reset
.global _main
.bss

.data

.text
_main:
	MOV #__SP_init, W15
	MOV #0x0000, W1	    ;used for delay_inner loop counter
	MOV #0xFFFF, W2	    ;used for delay_inner loop max terminator
	MOV #0x0000, W3	    ;used for delay loop counter
	MOV #0x0001, W4	    ;used for delay loop max terminator
	MOV #0x0000, W5	    ;used for routine repeat loop counter
	
init_ports:
	BCLR TRISA, #2
	BCLR TRISA, #4
	BCLR TRISB, #1
	BCLR TRISA, #1
	
	BCLR TRISB, #15	    ;top row controller
	BCLR TRISB, #6	    ;bottom row controller
	
routine_helicopter:
	CALL turn_on_top_plane
	CALL turn_on_bottom_plane
	BSET LATA, #2
	CALL delay
	BCLR LATA, #2
	CALL delay
	
	BSET LATA, #4
	CALL delay
	BCLR LATA, #4
	CALL delay
	
	BSET LATB, #1
	CALL delay
	BCLR LATB, #1
	CALL delay
	
	BSET LATA, #1
	CALL delay
	BCLR LATA, #1
	CALL delay
	
	ADD #0x0001, W5
	CP W5, #0x000A
	BRA NZ, routine_helicopter
	MOV #0x0000, W5
	BRA routine_helicopter_top
		
routine_helicopter_top:
	CALL turn_on_top_plane
	CALL turn_off_bottom_plane
    
	BSET LATA, #2
	CALL delay
	BCLR LATA, #2
	CALL delay
	
	BSET LATA, #4
	CALL delay
	BCLR LATA, #4
	CALL delay
	
	BSET LATB, #1
	CALL delay
	BCLR LATB, #1
	CALL delay
	
	BSET LATA, #1
	CALL delay
	BCLR LATA, #1
	CALL delay
	
	ADD #0x0001, W5
	CP W5, #0x0005
	BRA NZ, routine_helicopter_top
	MOV #0x0000, W5
	BRA routine_helicopter_bottom
	
routine_helicopter_bottom:
	
	CALL turn_off_top_plane
	CALL turn_on_bottom_plane
	
	BSET LATA, #2
	CALL delay
	BCLR LATA, #2
	CALL delay
	
	BSET LATA, #4
	CALL delay
	BCLR LATA, #4
	CALL delay
	
	BSET LATB, #1
	CALL delay
	BCLR LATB, #1
	CALL delay
	
	BSET LATA, #1
	CALL delay
	BCLR LATA, #1
	CALL delay
	
	ADD #0x0001, W5
	CP W5, #0x0005
	BRA NZ, routine_helicopter_bottom
	MOV #0x0000, W5
	BRA routine_X_pattern
	
routine_X_pattern:
	CALL turn_on_top_plane
	CALL turn_off_bottom_plane
	BSET LATA, #2
	CALL delay
	BCLR LATA, #2
	CALL delay
	
	BSET LATA, #4
	CALL delay
	BCLR LATA, #4
	CALL delay
	
	CALL turn_off_top_plane
	call turn_on_bottom_plane
	BSET LATB, #1
	CALL delay
	BCLR LATB, #1
	CALL delay
	
	BSET LATA, #1
	CALL delay
	BCLR LATA, #1
	CALL delay
			    ;move to second part of X
	
	CALL turn_off_top_plane
	CALL turn_on_bottom_plane
	BSET LATA, #2
	CALL delay
	BCLR LATA, #2
	CALL delay
	
	BSET LATA, #4
	CALL delay
	BCLR LATA, #4
	CALL delay
	
	CALL turn_on_top_plane
	CALL turn_off_bottom_plane
	BSET LATB, #1
	CALL delay
	BCLR LATB, #1
	CALL delay
	
	BSET LATA, #1
	CALL delay
	BCLR LATA, #1
	CALL delay
	
	ADD #0x0001, W5
	CP W5, #0x0005
	BRA NZ, routine_X_pattern
	MOV #0x0000, W5
	BRA routine_turn_on_all_lights
		
routine_turn_on_all_lights:
	CALL turn_on_top_plane
	CALL turn_off_bottom_plane
	
	BSET LATA, #1
	CALL delay
	CALL delay
	CALL delay
	BSET LATB, #1
	CALL delay
	CALL delay
	CALL delay
	BSET LATA, #4
	CALL delay
	CALL delay
	CALL delay
	BSET LATA, #2
	CALL delay
	CALL delay
	CALL delay
	
	BCLR LATA, #1
	BCLR LATB, #1
	BCLR LATA, #4
	BCLR LATA, #2
	
	CALL turn_off_top_plane
	CALL turn_on_bottom_plane
	CALL delay
	CALL delay
	
	BSET LATA, #1
	CALL delay
	CALL delay
	CALL delay
	BSET LATB, #1
	CALL delay
	CALL delay
	CALL delay
	BSET LATA, #4
	CALL delay
	CALL delay
	CALL delay
	BSET LATA, #2
	CALL delay
	CALL delay
	CALL delay
	CALL turn_on_top_plane
	CALL delay
	CALL delay
	CALL delay
	CALL delay
	CALL delay
	CALL delay
	
	BRA routine_helicopter
		
turn_on_top_plane:
    BSET LATB, #6
    return

turn_off_top_plane:
    BCLR LATB, #6
    
    
turn_on_bottom_plane:
    BSET LATB, #15
    return

turn_off_bottom_plane:
    BCLR LATB, #15
    
delay:
    CALL delay_inner
    ADD #0x0001, W3
    CP W3, W4
    BRA NZ, delay
    MOV #0x0000, W3
    return
	
delay_inner: 
	ADD #0x0001, W1
	CP W1, W2
	BRA NZ, delay_inner
	MOV #0x0000, W1
	return
	
done:	goto done
.end



