#include <REG51.H>
#define uchar unsigned char
#define uint unsigned int
sbit DBUS = P1^0;
sbit RS = P1^7;
sbit RW = P1^6;
sbit EN = P1^5;
sbit SW1 = P0^0;
uchar gong[]={0x00,0x1f,0x04,0x04,0x04,0x04,0x1f,0x00,
             0x00,0x0e,0x0a,0x0a,0x0e,0x0a,0x1b,0x00};
uchar chen[]={0x00,0x07,0x04,0x07,0x05,0x09,0x13,0x00,
             0x10,0x1c,0x08,0x0a,0x04,0x0a,0x01,0x00};
uchar yu[]={ 0x01,0x0f,0x08,0x0b,0x01,0x03,0x01,0x03,
             0x10,0x1e,0x02,0x1a,0x10,0x18,0x10,0x10};

union {
     uchar c[2];
     uint x;
} temp;
uchar flag;
uint cc,cc2;
float cc1;
uchar buff1[12] = {"temperature:"};
uchar buff2[7] = {"+00.0 C"};
 
void fbusy()
{
    P2 = 0xff;
    RS = 0;
    RW = 1;
    EN = 1;
    EN = 0;
    while((P2 & 0x80))
    {
	   EN = 0;
	   EN = 1;
    }
}

void wc51r(uchar j)
{
    fbusy();
    EN = 0;
    RS = 0;
    RW = 0;
    EN = 1;
    P2 = j;
    EN = 0;
}

void wc51ddr(uchar j)
{
    fbusy();
    EN = 0;
    RS = 1;
    RW = 0;
    EN = 1;
    P2 = j;
    EN = 0;
}
 void init()
{
    wc51r(0x01);
    wc51r(0x38);
    wc51r(0x0c);
    wc51r(0x06);
}

 void XingMing(uchar a)
{
init();
 { 
   for(a=0;a<16;a++)
   {  
   wc51r(0x40+a);
   wc51ddr(gong[a]);
   }
   wc51r(0x80);
   wc51ddr(0x00);
   wc51ddr(0x01);
  for(a=0;a<16;a++)
   {  
   wc51r(0x50+a);
   wc51ddr(chen[a]);
   }
   wc51r(0x83);
   wc51ddr(0x02);
   wc51ddr(0x03);
   for(a=0;a<16;a++)
   {  
   wc51r(0x60+a);
   wc51ddr(yu[a]);
   }
   wc51r(0x86);
   wc51ddr(0x04);
   wc51ddr(0x05);
 }
}
void XueHao()
{
   wc51r(0xc4);
   wc51ddr('2');
   wc51ddr('0');
   wc51ddr('8');
   wc51ddr('1');
   wc51ddr('2');
   wc51ddr('1');
   wc51ddr('2');
   wc51ddr('2');
   wc51ddr('4');
}
void delay(uint useconds)
{
   for(; useconds>0; useconds--);
}
uchar ow_reset(void)
{
    uchar presence;
	DBUS = 0;
	delay(50);
	DBUS= 1;
	delay(3);
	presence = DBUS;
	delay(25);
	return(presence);
}
uchar read_byte(void)
{
    uchar i;   
    uchar value = 0;
	for (i=8; i>0; i--)
	{
	   value >>= 1;
	   DBUS = 0;
	   DBUS = 1;
	   delay(1);
	   if(DBUS) value |= 0x80;
	   delay(6);
	 }
	 return(value);
}
void write_byte(uchar val)
{
   uchar i;
   for (i=8; i>0; i--)
   {
      DBUS = 0;
	  DBUS = val&0x01;
	  delay(5);
	  DBUS = 1;
	  val = val/2;
    }
	delay(5);
}

void Read_Temperature(void)
{
    ow_reset();
	write_byte(0xCC);
	write_byte(0xBE);
	temp.c[1] = read_byte();
	temp.c[0] = read_byte();
	ow_reset();
	write_byte(0xCC);
	write_byte(0x44);
	return;
}
void main()
{
    uchar k;
	delay(10);
	EA = 0;
	flag = 0;
   while(SW1==1)
	 {
	 delay(1000);
     XingMing();
     XueHao();
   }
	init();
	wc51r(0x80);
	for (k=0; k<12; k++)
	{ wc51ddr(buff1[k]);}	
    while(1)
	{
	    wc51r(0xca);
	    wc51ddr(0xdf);
	    delay(10000);
	    Read_Temperature();
	    cc = temp.c[0]*256.0 + temp.c[1];
        if (temp.c[0] > 0xf8) {flag=1;cc=~cc+1;} else flag=0;
		cc1 = cc*0.0625;
		cc2 = cc1*100;
		buff2[1] = cc2/1000 + 0x30;
		if (buff2[1] == 0x30)
		   buff2[1] == 0x20;
		buff2[2] = cc2/100 - (cc2/1000)*10 + 0x30;
		buff2[4] = cc2/10 - (cc2/100)*10 + 0x30;
		if (flag==1)
		    buff2[0] = '-';
		else
		    buff2[0] = '+';
		wc51r(0xc5);
		for (k=0; k<7; k++)
		{ wc51ddr(buff2[k]); }	
	}
}
