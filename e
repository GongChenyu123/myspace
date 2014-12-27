#include <reg51.h>
unsigned char DisplayBuf[4];
unsigned char code CharCode[]=
{
0xc0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,
0x80,0x90,0x88,0x83,0xC6,0xA1,0x86,0x8E
};
sbit   K0=P2^0;
sbit   K1=P2^1;
sbit   K2=P2^2;
sbit   K3=P2^3;


void Delay(void)
{
  int i;
  i=100;
  while(i--);
}

void display(void)
{
 unsigned char i,pos;
 
 P0=0;
 P1=0xff;


  pos=0x80;
  for(i=0;i<4;i++)
 {
  P1=CharCode[DisplayBuf[i]];
  P0=pos;
  pos>>=1;
  Delay();
 }
}



void  key(void)
{
if(K0==0) {Delay();if(K0==0) DisplayBuf[1]=0;}
if(K1==0) {Delay();if(K1==0) DisplayBuf[1]=1;}
if(K2==0) {Delay();if(K2==0) DisplayBuf[1]=2;}			
if(K3==0) {Delay();if(K3==0) DisplayBuf[1]=3;}
}
void main(void)
 {    unsigned char i;
for(i=0,i<4;i++)DisplayBuf[i]=8;
while(1)
 {    key();
	 display();
  }
 }	 
