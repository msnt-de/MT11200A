
_interrupt:

;Main.c,63 :: 		volatile void interrupt()
;Main.c,65 :: 		if (TMR1IF_bit)
	BTFSS      TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
	GOTO       L_interrupt0
;Main.c,72 :: 		TMR1H         = 0x63;   // preload for 10ms (63C0 @ 16Mhz)
	MOVLW      99
	MOVWF      TMR1H+0
;Main.c,73 :: 		TMR1L         = 0xC0;   //  ""
	MOVLW      192
	MOVWF      TMR1L+0
;Main.c,75 :: 		guiTimer10ms++;
	INCF       _guiTimer10ms+0, 1
	BTFSC      STATUS+0, 2
	INCF       _guiTimer10ms+1, 1
;Main.c,77 :: 		}
L_interrupt0:
;Main.c,78 :: 		TMR1IF_bit = 0;      // clear int after proc
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
;Main.c,80 :: 		}
L_end_interrupt:
L__interrupt20:
	RETFIE     %s
; end of _interrupt

_SetAllPorts:

;Main.c,85 :: 		void SetAllPorts(short HiLo){
;Main.c,86 :: 		if (HiLo > 0) {
	MOVLW      128
	XORLW      0
	MOVWF      R0
	MOVLW      128
	XORWF      FARG_SetAllPorts_HiLo+0, 0
	SUBWF      R0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SetAllPorts1
;Main.c,87 :: 		io_1_Direction = 0;        // Port out
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;Main.c,88 :: 		io_1 = 1;
	BSF        LATC4_bit+0, BitPos(LATC4_bit+0)
;Main.c,89 :: 		io_2_Direction = 0;        // Port out
	BCF        TRISC5_bit+0, BitPos(TRISC5_bit+0)
;Main.c,90 :: 		io_2 = 1;
	BSF        LATC5_bit+0, BitPos(LATC5_bit+0)
;Main.c,91 :: 		io_3_Direction = 0;        // Port out
	BCF        TRISC6_bit+0, BitPos(TRISC6_bit+0)
;Main.c,92 :: 		io_3 = 1;
	BSF        LATC6_bit+0, BitPos(LATC6_bit+0)
;Main.c,93 :: 		io_4_Direction = 0;        // Port out
	BCF        TRISC7_bit+0, BitPos(TRISC7_bit+0)
;Main.c,94 :: 		io_4 = 1;
	BSF        LATC7_bit+0, BitPos(LATC7_bit+0)
;Main.c,95 :: 		io_5_Direction = 0;        // Port out
	BCF        TRISB6_bit+0, BitPos(TRISB6_bit+0)
;Main.c,96 :: 		io_5 = 1;
	BSF        LATB6_bit+0, BitPos(LATB6_bit+0)
;Main.c,97 :: 		io_6_Direction = 0;        // Port out
	BCF        TRISB7_bit+0, BitPos(TRISB7_bit+0)
;Main.c,98 :: 		io_6 = 1;
	BSF        LATB7_bit+0, BitPos(LATB7_bit+0)
;Main.c,99 :: 		}
	GOTO       L_SetAllPorts2
L_SetAllPorts1:
;Main.c,102 :: 		io_1 = 0;
	BCF        LATC4_bit+0, BitPos(LATC4_bit+0)
;Main.c,103 :: 		io_2 = 0;
	BCF        LATC5_bit+0, BitPos(LATC5_bit+0)
;Main.c,104 :: 		io_3 = 0;
	BCF        LATC6_bit+0, BitPos(LATC6_bit+0)
;Main.c,105 :: 		io_4 = 0;
	BCF        LATC7_bit+0, BitPos(LATC7_bit+0)
;Main.c,106 :: 		io_5 = 0;
	BCF        LATB6_bit+0, BitPos(LATB6_bit+0)
;Main.c,107 :: 		io_6 = 0;
	BCF        LATB7_bit+0, BitPos(LATB7_bit+0)
;Main.c,108 :: 		}
L_SetAllPorts2:
;Main.c,109 :: 		}
L_end_SetAllPorts:
	RETURN
; end of _SetAllPorts

_Runlight:

;Main.c,111 :: 		void Runlight(void){
;Main.c,115 :: 		io_1 = 0;
	BCF        LATC4_bit+0, BitPos(LATC4_bit+0)
;Main.c,116 :: 		io_2 = 0;
	BCF        LATC5_bit+0, BitPos(LATC5_bit+0)
;Main.c,117 :: 		io_3 = 0;
	BCF        LATC6_bit+0, BitPos(LATC6_bit+0)
;Main.c,118 :: 		io_4 = 0;
	BCF        LATC7_bit+0, BitPos(LATC7_bit+0)
;Main.c,119 :: 		io_5 = 0;
	BCF        LATB6_bit+0, BitPos(LATB6_bit+0)
;Main.c,120 :: 		io_6 = 0;
	BCF        LATB7_bit+0, BitPos(LATB7_bit+0)
;Main.c,122 :: 		if (PortNr == 0) {  // do nothing
	MOVLW      0
	XORWF      Runlight_PortNr_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Runlight23
	MOVLW      0
	XORWF      Runlight_PortNr_L0+0, 0
L__Runlight23:
	BTFSS      STATUS+0, 2
	GOTO       L_Runlight3
;Main.c,123 :: 		}
L_Runlight3:
;Main.c,125 :: 		if (PortNr == 1) {
	MOVLW      0
	XORWF      Runlight_PortNr_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Runlight24
	MOVLW      1
	XORWF      Runlight_PortNr_L0+0, 0
L__Runlight24:
	BTFSS      STATUS+0, 2
	GOTO       L_Runlight4
;Main.c,126 :: 		io_1_Direction = 0;        // Port out
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;Main.c,127 :: 		io_1 = 1;
	BSF        LATC4_bit+0, BitPos(LATC4_bit+0)
;Main.c,128 :: 		}
L_Runlight4:
;Main.c,130 :: 		if (PortNr == 2) {
	MOVLW      0
	XORWF      Runlight_PortNr_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Runlight25
	MOVLW      2
	XORWF      Runlight_PortNr_L0+0, 0
L__Runlight25:
	BTFSS      STATUS+0, 2
	GOTO       L_Runlight5
;Main.c,131 :: 		io_2_Direction = 0;        // Port out
	BCF        TRISC5_bit+0, BitPos(TRISC5_bit+0)
;Main.c,132 :: 		io_2 = 1;
	BSF        LATC5_bit+0, BitPos(LATC5_bit+0)
;Main.c,133 :: 		}
L_Runlight5:
;Main.c,135 :: 		if (PortNr == 3) {
	MOVLW      0
	XORWF      Runlight_PortNr_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Runlight26
	MOVLW      3
	XORWF      Runlight_PortNr_L0+0, 0
L__Runlight26:
	BTFSS      STATUS+0, 2
	GOTO       L_Runlight6
;Main.c,136 :: 		io_3_Direction = 0;        // Port out
	BCF        TRISC6_bit+0, BitPos(TRISC6_bit+0)
;Main.c,137 :: 		io_3 = 1;
	BSF        LATC6_bit+0, BitPos(LATC6_bit+0)
;Main.c,138 :: 		}
L_Runlight6:
;Main.c,140 :: 		if (PortNr == 4) {
	MOVLW      0
	XORWF      Runlight_PortNr_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Runlight27
	MOVLW      4
	XORWF      Runlight_PortNr_L0+0, 0
L__Runlight27:
	BTFSS      STATUS+0, 2
	GOTO       L_Runlight7
;Main.c,141 :: 		io_4_Direction = 0;        // Port out
	BCF        TRISC7_bit+0, BitPos(TRISC7_bit+0)
;Main.c,142 :: 		io_4 = 1;
	BSF        LATC7_bit+0, BitPos(LATC7_bit+0)
;Main.c,143 :: 		}
L_Runlight7:
;Main.c,145 :: 		if (PortNr == 5) {
	MOVLW      0
	XORWF      Runlight_PortNr_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Runlight28
	MOVLW      5
	XORWF      Runlight_PortNr_L0+0, 0
L__Runlight28:
	BTFSS      STATUS+0, 2
	GOTO       L_Runlight8
;Main.c,146 :: 		io_5_Direction = 0;        // Port out
	BCF        TRISB6_bit+0, BitPos(TRISB6_bit+0)
;Main.c,147 :: 		io_5 = 1;
	BSF        LATB6_bit+0, BitPos(LATB6_bit+0)
;Main.c,148 :: 		}
L_Runlight8:
;Main.c,150 :: 		if (PortNr == 6) {
	MOVLW      0
	XORWF      Runlight_PortNr_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Runlight29
	MOVLW      6
	XORWF      Runlight_PortNr_L0+0, 0
L__Runlight29:
	BTFSS      STATUS+0, 2
	GOTO       L_Runlight9
;Main.c,151 :: 		io_6_Direction = 0;        // Port out
	BCF        TRISB7_bit+0, BitPos(TRISB7_bit+0)
;Main.c,152 :: 		io_6 = 1;
	BSF        LATB7_bit+0, BitPos(LATB7_bit+0)
;Main.c,153 :: 		}
L_Runlight9:
;Main.c,155 :: 		if (++PortNr > 6) PortNr= 0;
	INCF       Runlight_PortNr_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Runlight_PortNr_L0+1, 1
	MOVLW      128
	MOVWF      R0
	MOVLW      128
	XORWF      Runlight_PortNr_L0+1, 0
	SUBWF      R0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Runlight30
	MOVF       Runlight_PortNr_L0+0, 0
	SUBLW      6
L__Runlight30:
	BTFSC      STATUS+0, 0
	GOTO       L_Runlight10
	CLRF       Runlight_PortNr_L0+0
	CLRF       Runlight_PortNr_L0+1
L_Runlight10:
;Main.c,157 :: 		}
L_end_Runlight:
	RETURN
; end of _Runlight

_OneSecondPulse:

;Main.c,159 :: 		void OneSecondPulse(void) {
;Main.c,162 :: 		if (guiTimer10ms - Timer1sLast > 100) {  //  > 1 second difference
	MOVF       OneSecondPulse_Timer1sLast_L0+0, 0
	SUBWF      _guiTimer10ms+0, 0
	MOVWF      R1
	MOVF       OneSecondPulse_Timer1sLast_L0+1, 0
	SUBWFB     _guiTimer10ms+1, 0
	MOVWF      R2
	MOVF       R2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__OneSecondPulse32
	MOVF       R1, 0
	SUBLW      100
L__OneSecondPulse32:
	BTFSC      STATUS+0, 0
	GOTO       L_OneSecondPulse11
;Main.c,163 :: 		StatusLed_Direction = 0;        // Port out
	BCF        TRISB5_bit+0, BitPos(TRISB5_bit+0)
;Main.c,164 :: 		StatusLed = ~StatusLed;
	MOVLW
	XORWF      LATB5_bit+0, 1
;Main.c,165 :: 		Timer1sLast = guiTimer10ms;
	MOVF       _guiTimer10ms+0, 0
	MOVWF      OneSecondPulse_Timer1sLast_L0+0
	MOVF       _guiTimer10ms+1, 0
	MOVWF      OneSecondPulse_Timer1sLast_L0+1
;Main.c,166 :: 		}
L_OneSecondPulse11:
;Main.c,168 :: 		}
L_end_OneSecondPulse:
	RETURN
; end of _OneSecondPulse

_Toggle_StatusLed:

;Main.c,171 :: 		void Toggle_StatusLed(void){
;Main.c,172 :: 		StatusLed_Direction = 0;        // Port out
	BCF        TRISB5_bit+0, BitPos(TRISB5_bit+0)
;Main.c,173 :: 		StatusLed = ~StatusLed;
	MOVLW
	XORWF      LATB5_bit+0, 1
;Main.c,174 :: 		}
L_end_Toggle_StatusLed:
	RETURN
; end of _Toggle_StatusLed

_main:

;Main.c,177 :: 		void main(void)
;Main.c,181 :: 		Init_uP();
	CALL       _Init_uP+0
;Main.c,182 :: 		delay_ms(1000);             //stable clock !!?? 200ms ok, 1s just for visual check
	MOVLW      21
	MOVWF      R11
	MOVLW      75
	MOVWF      R12
	MOVLW      190
	MOVWF      R13
L_main12:
	DECFSZ     R13, 1
	GOTO       L_main12
	DECFSZ     R12, 1
	GOTO       L_main12
	DECFSZ     R11, 1
	GOTO       L_main12
	NOP
;Main.c,184 :: 		ADC_Init();
	CALL       _ADC_Init+0
;Main.c,188 :: 		ANSB4_bit = 1;   // P1
	BSF        ANSB4_bit+0, BitPos(ANSB4_bit+0)
;Main.c,189 :: 		ANSC3_bit = 1;   // P2
	BSF        ANSC3_bit+0, BitPos(ANSC3_bit+0)
;Main.c,190 :: 		ANSC2_bit = 1;   // P3
	BSF        ANSC2_bit+0, BitPos(ANSC2_bit+0)
;Main.c,192 :: 		TMR1IE_bit = 1;   // Enable timer interrupt
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;Main.c,193 :: 		GIE_bit = 1;        // Enable global interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;Main.c,195 :: 		StatusLed_Direction = 0; // Out
	BCF        TRISB5_bit+0, BitPos(TRISB5_bit+0)
;Main.c,196 :: 		while ( 1 ) {
L_main13:
;Main.c,198 :: 		StatusLed = ~StatusLed;
	MOVLW
	XORWF      LATB5_bit+0, 1
;Main.c,199 :: 		Runlight();
	CALL       _Runlight+0
;Main.c,201 :: 		P1 = ADC_Get_Sample(Poti3);
	MOVLW      10
	MOVWF      FARG_ADC_Get_Sample_channel+0
	CALL       _ADC_Get_Sample+0
	MOVF       R0, 0
	MOVWF      _P1+0
	MOVF       R1, 0
	MOVWF      _P1+1
;Main.c,202 :: 		for (i = 0; i < P1; i++){
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main15:
	MOVF       _P1+1, 0
	SUBWF      main_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main35
	MOVF       _P1+0, 0
	SUBWF      main_i_L0+0, 0
L__main35:
	BTFSC      STATUS+0, 0
	GOTO       L_main16
;Main.c,203 :: 		P1 = (P1 + ADC_Get_Sample(Poti3)) / 2;        // "Oversampling"
	MOVLW      10
	MOVWF      FARG_ADC_Get_Sample_channel+0
	CALL       _ADC_Get_Sample+0
	MOVF       _P1+0, 0
	ADDWF      R0, 1
	MOVF       _P1+1, 0
	ADDWFC     R1, 1
	MOVLW      2
	MOVWF      R4
	MOVLW      0
	MOVWF      R5
	CALL       _Div_16X16_U+0
	MOVF       R0, 0
	MOVWF      _P1+0
	MOVF       R1, 0
	MOVWF      _P1+1
;Main.c,204 :: 		delay_ms(1);
	MOVLW      6
	MOVWF      R12
	MOVLW      48
	MOVWF      R13
L_main18:
	DECFSZ     R13, 1
	GOTO       L_main18
	DECFSZ     R12, 1
	GOTO       L_main18
	NOP
;Main.c,202 :: 		for (i = 0; i < P1; i++){
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;Main.c,205 :: 		}
	GOTO       L_main15
L_main16:
;Main.c,207 :: 		} // Mainloop end
	GOTO       L_main13
;Main.c,209 :: 		} /*- main end ---------------------------------------------------------------*/
L_end_main:
	GOTO       $+0
; end of _main
