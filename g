#include<reg51.h>
unsigned char code ZmCode[]=
{
0x00,0x50,0x00,0x48,0x00,0x40,0x3F,0xFE,0x20,0x40,0x20,0x40,0x20,0x44,0x3E,0x44,0x22,0x44,0x22,0x28,0x22,0x28,0x22,0x12,0x2A,0x32,0x44,0x4A,0x40,0x86,0x81,0x02
};
void LEDDelay(int ms)
{
    int i;
    while(ms--)
         for(i=0;i<140;i++);
}
void main(void)
{
     int i,j;
     unsigned char pos;
     j = 0;
     pos = 0x01;
     while(1)
     {
         pos = 0x01;
         j = 0;
         for(i=0;i<16;i==)
         {
             if(pos == 0) pos = 0x01;
             P1 = ZmCode[j++];
             P2 = ZmCode[j++];
             if(i<8)
             {
                 P0 = ~pos;
                 P3 = 0xff;
             }
             else
             {
                 P0 = 0xff;
                 P3 = ~pos;
             }
             pos <<= 1;
             LEDDelay(2);
         }
      }
}
