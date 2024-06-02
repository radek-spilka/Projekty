#include <Keyboard.h>

byte JoyA;
byte JoyB;
byte FireA;
byte FireB;

byte SwA;
byte SwB;
byte SwC;

byte Tmp;

void setup() {
  DDRB=0x00; // vstupní porty
  DDRD=0x00;
  DDRF=0x00;

  PORTB=0xff; // pullupy 
  PORTD=0xff;
  PORTF=0xff;

  Serial.begin(9600);
  Keyboard.begin();
 
}


void loop() {
  Tmp=PINF;
  JoyA=(((~Tmp)>>4) & 0x0f);

  Tmp=PINB;
  JoyB=(((~Tmp)>>1) & 0x0f);
  FireA=(((~Tmp)>>6) & 0x01);
  FireB=(((~Tmp)>>5) & 0x01);

  Tmp=PIND;
  SwA=((~Tmp) & 0x01);
  SwB=(((~Tmp)>>1) & 0x03);
  SwC=(((~Tmp)>>3) & 0x01);
  
  if(SwA==0){
    if(JoyA==10){ Keyboard.press('y');}
    if(JoyA!=10) { Keyboard.release('y');}
    if(JoyA==8){ Keyboard.press('u');}
    if(JoyA!=8) { Keyboard.release('u');}
    if(JoyA==9){ Keyboard.press('i');}
    if(JoyA!=9) { Keyboard.release('i');}
    if(JoyA==1){ Keyboard.press('k');}
    if(JoyA!=1) { Keyboard.release('k');}
    if(JoyA==5){ Keyboard.press(',');}
    if(JoyA!=5) { Keyboard.release(',');}
    if(JoyA==4){ Keyboard.press('m');}
    if(JoyA!=4) { Keyboard.release('m');}
    if(JoyA==6){ Keyboard.press('n');}
    if(JoyA!=6) { Keyboard.release('n');}
    if(JoyA==2){ Keyboard.press('h');}
    if(JoyA!=2) { Keyboard.release('h');}

    if(FireA==1){ Keyboard.press(' ');}  
    if(FireA==0){ Keyboard.release(' ');}   
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
  }
  
  
  Serial.print(JoyA);
  Serial.print("\t");
  Serial.print(JoyB);
  Serial.print("\t");
  Serial.print(FireA);
  Serial.print("\t");
  Serial.print(FireB);
  Serial.print("\t");
  Serial.print(SwA);
  Serial.print("\t");
  Serial.print(SwB);
  Serial.print("\t");
  Serial.println(SwC);
  
  delay(100); 
}