/*************************************************************************/
void Init_uP(void) { //Initializes microcontroller
/************************************************************************/

// wait for stable uC
/*  while ( 1 ) // booting done chip still on start up oscillator?
    {
      if ( HFIOFS_bit == 1 ) break;
    }
*/

// Port init
    //ADCON0 = 0;   // ADC disabled (ADON ADCON0:0 = 0)   reminder this is default
    //DACCON0 = 0;  // DAC disabled (DACEN DACCON0:7 = 0) default reminder too
    //CM1CON0 = 0;  // Comparator  off (CxON CMxCON0:7 = 0) off is default
    //CM2CON0 = 0;  //INTCON = 0; is default upon reset // Interrupts disabled
    PORTA = 0;      // all outputs low
    PORTC = 0;
    ANSELA = 0;   // PortA all digital input, (this is not default)
    ANSELC = 0;   // Same PortC (ADC enable is a different thing)

    // Oscillator Setup
    // OSCCON - PllEN:7 1= On | PLLMULT:6 1 ->USB 3x OSC, 0 ->Delay_us  = 4x OSC,
    //          IRFC: 5-2 1111 -> 16Mhz | 2-1 OSC Select 1x -> internal OSC
    //          when SPLLEN then CPUDIV (clock divider) is activ (both in config)
    //OSCCON = 0b01111110; // PLL off, 16 Mhz, internal osc
    OSCCON = 0b01111100; // PLL off, 16 Mhz, clock source defined in config

    //!! PLL enabled (in config) produces different clock on eXtal operation

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