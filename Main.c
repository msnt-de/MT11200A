/*****************************************************************************
*
*  Unit:         HH.Timer main
*
*  Copyright:    (c) MSNT GmbH Hamburg 2019
*
*  Description:  Simple Runlight on all leds
*                Time settable with P3
*                Also out relays test
*
*  Controller:   PIC16F1459
*
*  Target:       MT11200A rugged controller w. PIC processor
*                https://www.tight-devices.net/en/mt11200-en.html
*
*  Oscillator:   External 16MHz, no switchover
*  SW:           mikroC PRO for PIC V7.5.0
*                http://www.mikroe.com/mikroc/pic/
*
*  Licence:      GPL 3.0
*                https://www.gnu.org/licenses/gpl-3.0.en.html
*
****************************       CHANGE LOG       *************************
* Version | ACTION                                           |  DATE  | SIG
* --------|--------------------------------------------------|--------|-----
*    0.1  | - Initial release                                |06Oct19 |  JJM
*    x.x  | - Further releases see version control           |        |
*****************************************************************************/

#include "Init_up.h"
//#include "DebugControl.h"

// Port def'
sbit StatusLed at LATB5_bit;

sbit io_1 at LATC4_bit;
sbit io_2 at LATC5_bit;
sbit io_3 at LATC6_bit;
sbit io_4 at LATC7_bit;
sbit io_5 at LATB6_bit;
sbit io_6 at LATB7_bit;

sbit StatusLed_Direction at TRISB5_bit;
sbit io_1_Direction at TRISC4_bit;
sbit io_2_Direction at TRISC5_bit;
sbit io_3_Direction at TRISC6_bit;
sbit io_4_Direction at TRISC7_bit;
sbit io_5_Direction at TRISB6_bit;
sbit io_6_Direction at TRISB7_bit;


// Analog channels potientometer (trimmer)
#define Poti1  6
#define Poti2  7
#define Poti3 10


// globals
unsigned int guiTimer10ms = 0;  // global better as passing var to interrupt
unsigned int P1, P2, P3;        //!! Just for test, move to analog in unit if exist


volatile void interrupt()
{
    if (TMR1IF_bit)
    {


#if __FOSC__ != 16000
#error "Error Timer init: incorrect oscillator freq (in kHz) check timer osc value"
#endif
        TMR1H         = 0x63;   // preload for 10ms (63C0 @ 16Mhz)
        TMR1L         = 0xC0;   //  ""

        guiTimer10ms++;

     }
     TMR1IF_bit = 0;      // clear int after proc

}
/*---------------------------------------------------------------------------*/



void SetAllPorts(short HiLo){
    if (HiLo > 0) {
      io_1_Direction = 0;        // Port out
      io_1 = 1;
      io_2_Direction = 0;        // Port out
      io_2 = 1;
      io_3_Direction = 0;        // Port out
      io_3 = 1;
      io_4_Direction = 0;        // Port out
      io_4 = 1;
      io_5_Direction = 0;        // Port out
      io_5 = 1;
      io_6_Direction = 0;        // Port out
      io_6 = 1;
    }
    else {
      //io_1_Direction = 1;       // in if 0
      io_1 = 0;
      io_2 = 0;
      io_3 = 0;
      io_4 = 0;
      io_5 = 0;
      io_6 = 0;
    }
}

void Runlight(void){
static PortNr = 0;

    // clear ports
    io_1 = 0;
    io_2 = 0;
    io_3 = 0;
    io_4 = 0;
    io_5 = 0;
    io_6 = 0;

    if (PortNr == 0) {  // do nothing
    }

    if (PortNr == 1) {
      io_1_Direction = 0;        // Port out
      io_1 = 1;
    }

    if (PortNr == 2) {
      io_2_Direction = 0;        // Port out
      io_2 = 1;
    }

    if (PortNr == 3) {
      io_3_Direction = 0;        // Port out
      io_3 = 1;
    }

    if (PortNr == 4) {
      io_4_Direction = 0;        // Port out
      io_4 = 1;
    }

    if (PortNr == 5) {
      io_5_Direction = 0;        // Port out
      io_5 = 1;
    }

    if (PortNr == 6) {
      io_6_Direction = 0;        // Port out
      io_6 = 1;
    }

    if (++PortNr > 6) PortNr= 0;

}

void OneSecondPulse(void) {
static unsigned Timer1sLast;

  if (guiTimer10ms - Timer1sLast > 100) {  //  > 1 second difference
      StatusLed_Direction = 0;        // Port out
      StatusLed = ~StatusLed;
      Timer1sLast = guiTimer10ms;
  }

}


void Toggle_StatusLed(void){
      StatusLed_Direction = 0;        // Port out
      StatusLed = ~StatusLed;
}


void main(void) 
{
int  i;
  
  Init_uP();
  delay_ms(1000);             //stable clock !!?? 200ms ok, 1s just for visual check

  ADC_Init();
  
  
  // Configure analog ports
  ANSB4_bit = 1;   // P1
  ANSC3_bit = 1;   // P2
  ANSC2_bit = 1;   // P3

  TMR1IE_bit = 1;   // Enable timer interrupt
  GIE_bit = 1;        // Enable global interrupt

  StatusLed_Direction = 0; // Out
  while ( 1 ) {

    StatusLed = ~StatusLed;
    Runlight();
    
    P1 = ADC_Get_Sample(Poti3);
    for (i = 0; i < P1; i++){
      P1 = (P1 + ADC_Get_Sample(Poti3)) / 2;        // "Oversampling"
      delay_ms(1);
    }
    
  } // Mainloop end

} /*- main end ---------------------------------------------------------------*/