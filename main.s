.include "p24Hxxxx.inc"
;.global __reset
.global _main
.bss

.data

.text
_main:
	MOV #__SP_init, W15
	MOV #0x0000, W1
	MOV #0xFFFF, W2
init_ports:
	BCLR TRISA, #2
	BCLR TRISA, #4
	BCLR TRISB, #1
	BCLR TRISA, #1
	
routine_helicopter:	
	BSET LATA, #2
	CALL delay
	CALL delay
	CALL delay
	BCLR LATA, #2
	CALL delay
	CALL delay
	CALL delay
	
	BSET LATA, #4
	CALL delay
	CALL delay
	CALL delay
	BCLR LATA, #4
	CALL delay
	CALL delay
	CALL delay
	
	BSET LATB, #1
	CALL delay
	CALL delay
	CALL delay
	BCLR LATB, #1
	CALL delay
	CALL delay
	CALL delay
	
	BSET LATA, #1
	CALL delay
	CALL delay
	CALL delay
	BCLR LATA, #1
	CALL delay
	CALL delay
	CALL delay
	
	BRA routine_helicopter
	
	
	BRA done

delay: 
	ADD #0x0001, W1
	CP W1, W2
	BRA NZ, delay
	MOV #0x0000, W1
	return
	
done:	goto done
.end



