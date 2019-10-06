#line 1 "Z:/01 Own Projects/HH.Timer (MT11200A)/Produkt/Firmware/Public/MT11200-runlight-demo/Init_up.c"

void Init_uP(void) {
#line 17 "Z:/01 Own Projects/HH.Timer (MT11200A)/Produkt/Firmware/Public/MT11200-runlight-demo/Init_up.c"
 PORTA = 0;
 PORTC = 0;
 ANSELA = 0;
 ANSELC = 0;






 OSCCON = 0b01111100;




 OPTION_REG = 0b10000000;
 WPUA = 0b00000000;




 T1CON = 0x01;
 TMR1IF_bit = 0;
 TMR1H = 0x63;
 TMR1L = 0xC0;

 TMR1IE_bit = 1;
 INTCON = 0xC0;
#line 50 "Z:/01 Own Projects/HH.Timer (MT11200A)/Produkt/Firmware/Public/MT11200-runlight-demo/Init_up.c"
}
