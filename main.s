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
start:
	BCLR TRISA, #1
	BSET LATA, #1
	CALL delay
	CALL delay
	CALL delay
	CALL delay
	CALL delay
	CALL delay
	CALL delay
	CALL delay
	CALL delay
	CALL delay
	CALL delay
	CALL delay
	CALL delay
	CALL delay
	CALL delay
	CALL delay
	BCLR LATA, #1
	BRA done

delay: 
	ADD #0x0001, W1
	CP W1, W2
	BRA NZ, delay
	MOV #0x0000, W1
	return
	
done:	goto done
.end



