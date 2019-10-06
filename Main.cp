#line 1 "Z:/01 Own Projects/HH.Timer (MT11200A)/Produkt/Firmware/Public/MT11200-runlight-demo/Main.c"
#line 1 "z:/01 own projects/hh.timer (mt11200a)/produkt/firmware/public/mt11200-runlight-demo/init_up.h"





void Init_uP(void);
#line 34 "Z:/01 Own Projects/HH.Timer (MT11200A)/Produkt/Firmware/Public/MT11200-runlight-demo/Main.c"
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









unsigned int guiTimer10ms = 0;
unsigned int P1, P2, P3;


volatile void interrupt()
{
 if (TMR1IF_bit)
 {
#line 72 "Z:/01 Own Projects/HH.Timer (MT11200A)/Produkt/Firmware/Public/MT11200-runlight-demo/Main.c"
 TMR1H = 0x63;
 TMR1L = 0xC0;

 guiTimer10ms++;

 }
 TMR1IF_bit = 0;

}




void SetAllPorts(short HiLo){
 if (HiLo > 0) {
 io_1_Direction = 0;
 io_1 = 1;
 io_2_Direction = 0;
 io_2 = 1;
 io_3_Direction = 0;
 io_3 = 1;
 io_4_Direction = 0;
 io_4 = 1;
 io_5_Direction = 0;
 io_5 = 1;
 io_6_Direction = 0;
 io_6 = 1;
 }
 else {

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


 io_1 = 0;
 io_2 = 0;
 io_3 = 0;
 io_4 = 0;
 io_5 = 0;
 io_6 = 0;

 if (PortNr == 0) {
 }

 if (PortNr == 1) {
 io_1_Direction = 0;
 io_1 = 1;
 }

 if (PortNr == 2) {
 io_2_Direction = 0;
 io_2 = 1;
 }

 if (PortNr == 3) {
 io_3_Direction = 0;
 io_3 = 1;
 }

 if (PortNr == 4) {
 io_4_Direction = 0;
 io_4 = 1;
 }

 if (PortNr == 5) {
 io_5_Direction = 0;
 io_5 = 1;
 }

 if (PortNr == 6) {
 io_6_Direction = 0;
 io_6 = 1;
 }

 if (++PortNr > 6) PortNr= 0;

}

void OneSecondPulse(void) {
static unsigned Timer1sLast;

 if (guiTimer10ms - Timer1sLast > 100) {
 StatusLed_Direction = 0;
 StatusLed = ~StatusLed;
 Timer1sLast = guiTimer10ms;
 }

}


void Toggle_StatusLed(void){
 StatusLed_Direction = 0;
 StatusLed = ~StatusLed;
}


void main(void)
{
int i;

 Init_uP();
 delay_ms(1000);

 ADC_Init();



 ANSB4_bit = 1;
 ANSC3_bit = 1;
 ANSC2_bit = 1;

 TMR1IE_bit = 1;
 GIE_bit = 1;

 StatusLed_Direction = 0;
 while ( 1 ) {

 StatusLed = ~StatusLed;
 Runlight();

 P1 = ADC_Get_Sample( 10 );
 for (i = 0; i < P1; i++){
 P1 = (P1 + ADC_Get_Sample( 10 )) / 2;
 delay_ms(1);
 }

 }

}
