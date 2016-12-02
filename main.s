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
	MOV #0x0000, W3 ;w3 used to represent the state of the LED
start:
	BCLR TRISA, #0
	
led_on:
	MOV #0XFFFF, W0
	;MOV W0, LATA
	BSET LATA, #0
	BRA delay
	
led_off:
	MOV #0X0000, W0
	;MOV W0, LATA
	BCLR LATA, #0
	bra delay
	
delay: 
	ADD #0x0001, W1
	CP W1, W2
	BRA NZ, delay
	MOV #0x0000, W1
	CP W0, W3
	BRA Z, led_on
	BRA led_off

done:	goto done
.end



