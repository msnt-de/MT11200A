
_Init_uP:

;Init_up.c,2 :: 		void Init_uP(void) { //Initializes microcontroller
;Init_up.c,17 :: 		PORTA = 0;      // all outputs low
	CLRF       PORTA+0
;Init_up.c,18 :: 		PORTC = 0;
	CLRF       PORTC+0
;Init_up.c,19 :: 		ANSELA = 0;   // PortA all digital input, (this is not default)
	CLRF       ANSELA+0
;Init_up.c,20 :: 		ANSELC = 0;   // Same PortC (ADC enable is a different thing)
	CLRF       ANSELC+0
;Init_up.c,27 :: 		OSCCON = 0b01111100; // PLL off, 16 Mhz, clock source defined in config
	MOVLW      124
	MOVWF      OSCCON+0
;Init_up.c,32 :: 		OPTION_REG = 0b10000000;  // 7: weak pull ups disabled (if 1))
	MOVLW      128
	MOVWF      OPTION_REG+0
;Init_up.c,33 :: 		WPUA = 0b00000000;        // wpua's off
	CLRF       WPUA+0
;Init_up.c,38 :: 		T1CON         = 0x01;
	MOVLW      1
	MOVWF      T1CON+0
;Init_up.c,39 :: 		TMR1IF_bit    = 0;
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
;Init_up.c,40 :: 		TMR1H         = 0x63;
	MOVLW      99
	MOVWF      TMR1H+0
;Init_up.c,41 :: 		TMR1L         = 0xC0;
	MOVLW      192
	MOVWF      TMR1L+0
;Init_up.c,43 :: 		TMR1IE_bit    = 1;
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;Init_up.c,44 :: 		INTCON        = 0xC0;
	MOVLW      192
	MOVWF      INTCON+0
;Init_up.c,50 :: 		}
L_end_Init_uP:
	RETURN
; end of _Init_uP
