/*************************************************************************/
void Init_uP(void) { //Initializes microcontroller
/************************************************************************/

// wait for stable oscillator
/*  while ( 1 )
    {
      if ( HFIOFS_bit == 1 ) break;
    }
*/

// Port init
    PORTA = 0;      // all outputs low
    PORTC = 0;
    ANSELA = 0;   // PortA all digital input, (this is not default)
    ANSELC = 0;   // Same PortC (ADC enable is a different thing)

    OSCCON = 0b01111100; // PLL off, 16 Mhz, clock source defined in config

    // Weak pull ups
    OPTION_REG = 0b10000000;  // 7: weak pull ups disabled (if 1))
    WPUA = 0b00000000;        // wpua's off

#if __FOSC__ == 16000

    // InitTimer1 10ms
    T1CON         = 0x01;
    TMR1IF_bit    = 0;
    TMR1H         = 0x63;
    TMR1L         = 0xC0;

    TMR1IE_bit    = 1;
    INTCON        = 0xC0;

#else
#error "Error Timer init: incorrect oscillator freq (in kHz) check timer osc value"
#endif

}