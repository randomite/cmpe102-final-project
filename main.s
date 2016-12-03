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
	MOV #0x000A, W4	    ;used for delay loop max terminator
	
init_ports:
	BCLR TRISA, #2
	BCLR TRISA, #4
	BCLR TRISB, #1
	BCLR TRISA, #1
	
routine_helicopter:	
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
	
	BRA routine_helicopter
	
	
	BRA done

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



