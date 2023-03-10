/******************************************************************************
 SSD1306 OLED driver for mikroC PRO for PIC compiler (SSD1306.c)              *
                                                                              *
 The driver is for I2C mode only.                                             *
                                                                              *
 https://simple-circuit.com/                                                   *
                                                                              *
*******************************************************************************/

#include <stdint.h>

//------------------------------ Definitions ---------------------------------//

#define SSD1306_I2C_ADDRESS   0x3C

#if !defined SSD1306_128_32 && !defined SSD1306_96_16
#define SSD1306_128_64
#endif
#if defined SSD1306_128_32 && defined SSD1306_96_16
  #error "Only one SSD1306 display can be specified at once"
#endif

#if defined SSD1306_128_64
  #define SSD1306_LCDWIDTH            128
  #define SSD1306_LCDHEIGHT            64
#endif
#if defined SSD1306_128_32
  #define SSD1306_LCDWIDTH            128
  #define SSD1306_LCDHEIGHT            32
#endif
#if defined SSD1306_96_16
  #define SSD1306_LCDWIDTH             96
  #define SSD1306_LCDHEIGHT            16
#endif

#define SSD1306_SETCONTRAST          0x81
#define SSD1306_DISPLAYALLON_RESUME  0xA4
#define SSD1306_DISPLAYALLON         0xA5
#define SSD1306_NORMALDISPLAY        0xA6
#define SSD1306_INVERTDISPLAY_       0xA7
#define SSD1306_DISPLAYOFF           0xAE
#define SSD1306_DISPLAYON            0xAF
#define SSD1306_SETDISPLAYOFFSET     0xD3
#define SSD1306_SETCOMPINS           0xDA
#define SSD1306_SETVCOMDETECT        0xDB
#define SSD1306_SETDISPLAYCLOCKDIV   0xD5
#define SSD1306_SETPRECHARGE         0xD9
#define SSD1306_SETMULTIPLEX         0xA8
#define SSD1306_SETLOWCOLUMN         0x00
#define SSD1306_SETHIGHCOLUMN        0x10
#define SSD1306_SETSTARTLINE         0x40
#define SSD1306_MEMORYMODE           0x20
#define SSD1306_COLUMNADDR           0x21
#define SSD1306_PAGEADDR             0x22
#define SSD1306_COMSCANINC           0xC0
#define SSD1306_COMSCANDEC           0xC8
#define SSD1306_SEGREMAP             0xA0
#define SSD1306_CHARGEPUMP           0x8D
#define SSD1306_EXTERNALVCC          0x01
#define SSD1306_SWITCHCAPVCC         0x02

// Scrolling #defines
#define SSD1306_ACTIVATE_SCROLL                      0x2F
#define SSD1306_DEACTIVATE_SCROLL                    0x2E
#define SSD1306_SET_VERTICAL_SCROLL_AREA             0xA3
#define SSD1306_RIGHT_HORIZONTAL_SCROLL              0x26
#define SSD1306_LEFT_HORIZONTAL_SCROLL               0x27
#define SSD1306_VERTICAL_AND_RIGHT_HORIZONTAL_SCROLL 0x29
#define SSD1306_VERTICAL_AND_LEFT_HORIZONTAL_SCROLL  0x2A


char _i2caddr, _vccstate, x_pos = 1, y_pos = 1, wrap = 1;

//--------------------------------------------------------------------------//

#if !defined SSD1306_I2C1  &&  !defined SSD1306_I2C2
#define  SSD1306_I2C1
#endif

#if defined SSD1306_I2C1  &&  defined SSD1306_I2C2
#undef  SSD1306_I2C2
#endif

#ifdef  SSD1306_I2C1
#define SSD1306_Start    Soft_I2C_Start
#define SSD1306_Write    Soft_I2C_Write
#define SSD1306_Stop     Soft_I2C_Stop
#endif

#ifdef  SSD1306_I2C2
#define SSD1306_Start    I2C2_Start
#define SSD1306_Write    I2C2_Wr
#define SSD1306_Stop     I2C2_Stop
#endif

const char Font[] = {
0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x5F, 0x00, 0x00,
0x00, 0x07, 0x00, 0x07, 0x00,
0x14, 0x7F, 0x14, 0x7F, 0x14,
0x24, 0x2A, 0x7F, 0x2A, 0x12,
0x23, 0x13, 0x08, 0x64, 0x62,
0x36, 0x49, 0x56, 0x20, 0x50,
0x00, 0x08, 0x07, 0x03, 0x00,
0x00, 0x1C, 0x22, 0x41, 0x00,
0x00, 0x41, 0x22, 0x1C, 0x00,
0x2A, 0x1C, 0x7F, 0x1C, 0x2A,
0x08, 0x08, 0x3E, 0x08, 0x08,
0x00, 0x80, 0x70, 0x30, 0x00,
0x08, 0x08, 0x08, 0x08, 0x08,
0x00, 0x00, 0x60, 0x60, 0x00,
0x20, 0x10, 0x08, 0x04, 0x02,
0x3E, 0x51, 0x49, 0x45, 0x3E,
0x00, 0x42, 0x7F, 0x40, 0x00,
0x72, 0x49, 0x49, 0x49, 0x46,
0x21, 0x41, 0x49, 0x4D, 0x33,
0x18, 0x14, 0x12, 0x7F, 0x10,
0x27, 0x45, 0x45, 0x45, 0x39,
0x3C, 0x4A, 0x49, 0x49, 0x31,
0x41, 0x21, 0x11, 0x09, 0x07,
0x36, 0x49, 0x49, 0x49, 0x36,
0x46, 0x49, 0x49, 0x29, 0x1E,
0x00, 0x00, 0x14, 0x00, 0x00,
0x00, 0x40, 0x34, 0x00, 0x00,
0x00, 0x08, 0x14, 0x22, 0x41,
0x14, 0x14, 0x14, 0x14, 0x14,
0x00, 0x41, 0x22, 0x14, 0x08,
0x02, 0x01, 0x59, 0x09, 0x06,
0x3E, 0x41, 0x5D, 0x59, 0x4E,
0x7C, 0x12, 0x11, 0x12, 0x7C,
0x7F, 0x49, 0x49, 0x49, 0x36,
0x3E, 0x41, 0x41, 0x41, 0x22,
0x7F, 0x41, 0x41, 0x41, 0x3E,
0x7F, 0x49, 0x49, 0x49, 0x41,
0x7F, 0x09, 0x09, 0x09, 0x01,
0x3E, 0x41, 0x41, 0x51, 0x73,
0x7F, 0x08, 0x08, 0x08, 0x7F,
0x00, 0x41, 0x7F, 0x41, 0x00,
0x20, 0x40, 0x41, 0x3F, 0x01,
0x7F, 0x08, 0x14, 0x22, 0x41,
0x7F, 0x40, 0x40, 0x40, 0x40,
0x7F, 0x02, 0x1C, 0x02, 0x7F,
0x7F, 0x04, 0x08, 0x10, 0x7F,
0x3E, 0x41, 0x41, 0x41, 0x3E,
0x7F, 0x09, 0x09, 0x09, 0x06,
0x3E, 0x41, 0x51, 0x21, 0x5E,
0x7F, 0x09, 0x19, 0x29, 0x46,
0x26, 0x49, 0x49, 0x49, 0x32,
0x03, 0x01, 0x7F, 0x01, 0x03,
0x3F, 0x40, 0x40, 0x40, 0x3F,
0x1F, 0x20, 0x40, 0x20, 0x1F,
0x3F, 0x40, 0x38, 0x40, 0x3F,
0x63, 0x14, 0x08, 0x14, 0x63,
0x03, 0x04, 0x78, 0x04, 0x03,
0x61, 0x59, 0x49, 0x4D, 0x43,
0x00, 0x7F, 0x41, 0x41, 0x41,
0x02, 0x04, 0x08, 0x10, 0x20,
0x00, 0x41, 0x41, 0x41, 0x7F,
0x04, 0x02, 0x01, 0x02, 0x04,
0x40, 0x40, 0x40, 0x40, 0x40,
0x00, 0x03, 0x07, 0x08, 0x00,
0x20, 0x54, 0x54, 0x78, 0x40,
0x7F, 0x28, 0x44, 0x44, 0x38,
0x38, 0x44, 0x44, 0x44, 0x28,
0x38, 0x44, 0x44, 0x28, 0x7F,
0x38, 0x54, 0x54, 0x54, 0x18,
0x00, 0x08, 0x7E, 0x09, 0x02,
0x18, 0xA4, 0xA4, 0x9C, 0x78,
0x7F, 0x08, 0x04, 0x04, 0x78,
0x00, 0x44, 0x7D, 0x40, 0x00,
0x20, 0x40, 0x40, 0x3D, 0x00,
0x7F, 0x10, 0x28, 0x44, 0x00,
0x00, 0x41, 0x7F, 0x40, 0x00,
0x7C, 0x04, 0x78, 0x04, 0x78,
0x7C, 0x08, 0x04, 0x04, 0x78,
0x38, 0x44, 0x44, 0x44, 0x38,
0xFC, 0x18, 0x24, 0x24, 0x18,
0x18, 0x24, 0x24, 0x18, 0xFC,
0x7C, 0x08, 0x04, 0x04, 0x08,
0x48, 0x54, 0x54, 0x54, 0x24,
0x04, 0x04, 0x3F, 0x44, 0x24,
0x3C, 0x40, 0x40, 0x20, 0x7C,
0x1C, 0x20, 0x40, 0x20, 0x1C,
0x3C, 0x40, 0x30, 0x40, 0x3C,
0x44, 0x28, 0x10, 0x28, 0x44,
0x4C, 0x90, 0x90, 0x90, 0x7C,
0x44, 0x64, 0x54, 0x4C, 0x44,
0x00, 0x08, 0x36, 0x41, 0x00,
0x00, 0x00, 0x77, 0x00, 0x00,
0x00, 0x41, 0x36, 0x08, 0x00,
0x02, 0x01, 0x02, 0x04, 0x02
};

void ssd1306_command(uint8_t c) {
    uint8_t control = 0x00;   // Co = 0, D/C = 0
    SSD1306_Start();
    SSD1306_Write(_i2caddr);
    SSD1306_Write(control);
    SSD1306_Write(c);
    SSD1306_Stop();
}

void SSD1306_Init(uint8_t vccstate, uint8_t i2caddr) {
  _vccstate = vccstate;
  _i2caddr  = i2caddr;
  #ifdef SSD1306_RST
    SSD1306_RST = 0;
    #ifdef SSD1306_RST_DIR
      SSD1306_RST_DIR = 0;
    #endif
    delay_ms(10);
    SSD1306_RST = 1;
  #endif
  // Init sequence
  ssd1306_command(SSD1306_DISPLAYOFF);                    // 0xAE
  ssd1306_command(SSD1306_SETDISPLAYCLOCKDIV);            // 0xD5
  ssd1306_command(0x80);                                  // the suggested ratio 0x80

  ssd1306_command(SSD1306_SETMULTIPLEX);                  // 0xA8
  ssd1306_command(SSD1306_LCDHEIGHT - 1);

  ssd1306_command(SSD1306_SETDISPLAYOFFSET);              // 0xD3
  ssd1306_command(0x0);                                   // no offset
  ssd1306_command(SSD1306_SETSTARTLINE | 0x0);            // line #0
  ssd1306_command(SSD1306_CHARGEPUMP);                    // 0x8D
  if (vccstate == SSD1306_EXTERNALVCC)
    { ssd1306_command(0x10); }
  else
    { ssd1306_command(0x14); }
  ssd1306_command(SSD1306_MEMORYMODE);                    // 0x20
  ssd1306_command(0x00);                                  // 0x0 act like ks0108
  ssd1306_command(SSD1306_SEGREMAP | 0x1);
  ssd1306_command(SSD1306_COMSCANDEC);

 #if defined SSD1306_128_32
  ssd1306_command(SSD1306_SETCOMPINS);                    // 0xDA
  ssd1306_command(0x02);
  ssd1306_command(SSD1306_SETCONTRAST);                   // 0x81
  ssd1306_command(0x8F);

#elif defined SSD1306_128_64
  ssd1306_command(SSD1306_SETCOMPINS);                    // 0xDA
  ssd1306_command(0x12);
  ssd1306_command(SSD1306_SETCONTRAST);                   // 0x81
  if (vccstate == SSD1306_EXTERNALVCC)
    { ssd1306_command(0x9F); }
  else
    { ssd1306_command(0xCF); }

#elif defined SSD1306_96_16
  ssd1306_command(SSD1306_SETCOMPINS);                    // 0xDA
  ssd1306_command(0x2);   //ada x12
  ssd1306_command(SSD1306_SETCONTRAST);                   // 0x81
  if (vccstate == SSD1306_EXTERNALVCC)
    { ssd1306_command(0x10); }
  else
    { ssd1306_command(0xAF); }

#endif

  ssd1306_command(SSD1306_SETPRECHARGE);                  // 0xd9
  if (vccstate == SSD1306_EXTERNALVCC)
    { ssd1306_command(0x22); }
  else
    { ssd1306_command(0xF1); }
  ssd1306_command(SSD1306_SETVCOMDETECT);                 // 0xDB
  ssd1306_command(0x40);
  ssd1306_command(SSD1306_DISPLAYALLON_RESUME);           // 0xA4
  ssd1306_command(SSD1306_NORMALDISPLAY);                 // 0xA6

  ssd1306_command(SSD1306_DEACTIVATE_SCROLL);

  ssd1306_command(SSD1306_DISPLAYON);//--turn on oled panel
}

void SSD1306_StartScrollRight(uint8_t start, uint8_t stop) {
  ssd1306_command(SSD1306_RIGHT_HORIZONTAL_SCROLL);
  ssd1306_command(0X00);
  ssd1306_command(start);  // start page
  ssd1306_command(0X00);
  ssd1306_command(stop);   // end page
  ssd1306_command(0X00);
  ssd1306_command(0XFF);
  ssd1306_command(SSD1306_ACTIVATE_SCROLL);
}

void SSD1306_StartScrollLeft(uint8_t start, uint8_t stop) {
  ssd1306_command(SSD1306_LEFT_HORIZONTAL_SCROLL);
  ssd1306_command(0X00);
  ssd1306_command(start);
  ssd1306_command(0X00);
  ssd1306_command(stop);
  ssd1306_command(0X00);
  ssd1306_command(0XFF);
  ssd1306_command(SSD1306_ACTIVATE_SCROLL);
}

void SSD1306_StartScrollDiagRight(uint8_t start, uint8_t stop) {
  ssd1306_command(SSD1306_SET_VERTICAL_SCROLL_AREA);
  ssd1306_command(0X00);
  ssd1306_command(SSD1306_LCDHEIGHT);
  ssd1306_command(SSD1306_VERTICAL_AND_RIGHT_HORIZONTAL_SCROLL);
  ssd1306_command(0X00);
  ssd1306_command(start);
  ssd1306_command(0X00);
  ssd1306_command(stop);
  ssd1306_command(0X01);
  ssd1306_command(SSD1306_ACTIVATE_SCROLL);
}

void SSD1306_StartScrollDiagLeft(uint8_t start, uint8_t stop) {
  ssd1306_command(SSD1306_SET_VERTICAL_SCROLL_AREA);
  ssd1306_command(0X00);
  ssd1306_command(SSD1306_LCDHEIGHT);
  ssd1306_command(SSD1306_VERTICAL_AND_LEFT_HORIZONTAL_SCROLL);
  ssd1306_command(0X00);
  ssd1306_command(start);
  ssd1306_command(0X00);
  ssd1306_command(stop);
  ssd1306_command(0X01);
  ssd1306_command(SSD1306_ACTIVATE_SCROLL);
}

void SSD1306_StopScroll(void) {
  ssd1306_command(SSD1306_DEACTIVATE_SCROLL);
}

void SSD1306_Dim(uint8_t dim) {
  uint8_t contrast;
  if (dim & 1)
    contrast = 0; // Dimmed display
  else {
    if (_vccstate == SSD1306_EXTERNALVCC)
      contrast = 0x9F;
    else
      contrast = 0xCF;
  }
  // the range of contrast to too small to be really useful
  // it is useful to dim the display
  ssd1306_command(SSD1306_SETCONTRAST);
  ssd1306_command(contrast);
}

void SSD1306_SetTextWrap(uint8_t w) {
  wrap = w & 1;
}

void SSD1306_InvertDisplay(uint8_t i) {
  if (i & 1)
    ssd1306_command(SSD1306_INVERTDISPLAY_);
  else
    ssd1306_command(SSD1306_NORMALDISPLAY);
}

void SSD1306_GotoXY(uint8_t x, uint8_t y) {
  if((x > SSD1306_LCDWIDTH / 6) || y > SSD1306_LCDHEIGHT / 8)
    return;
  x_pos = x;
  y_pos = y;
}

void SSD1306_PutC(char c) {
  uint8_t i, font_c;
  if((c < ' ') || (c > '~'))
    c = '?';
  ssd1306_command(SSD1306_COLUMNADDR);
  ssd1306_command(6 * (x_pos - 1));
  ssd1306_command(6 * (x_pos - 1) + 4); // Column end address (127 = reset)

  ssd1306_command(SSD1306_PAGEADDR);
  ssd1306_command(y_pos - 1); // Page start address (0 = reset)
  ssd1306_command(y_pos - 1); // Page end address

  SSD1306_Start();
  SSD1306_Write(_i2caddr);
  SSD1306_Write(0x40);

  for(i = 0; i < 5; i++ ) {
    font_c = font[(c - 32) * 5 + i];

    SSD1306_Write(font_c);
  }
  SSD1306_Stop();

  #if defined SSD1306_128_64 || defined SSD1306_128_32
  x_pos = x_pos % 21 + 1;
  if (wrap && (x_pos == 1))
    #if defined SSD1306_128_64
      y_pos = y_pos % 8 + 1;
    #else
      y_pos = y_pos % 4 + 1;
    #endif

  #else
    x_pos = x_pos % 16 + 1;
    if (wrap && (x_pos == 1))
      y_pos = y_pos % 2 + 1;
  #endif

}

void SSD1306_PutCustomC(char *c) {
  uint8_t i, line;
  ssd1306_command(SSD1306_COLUMNADDR);
  ssd1306_command(6 * (x_pos - 1));
  ssd1306_command(6 * (x_pos - 1) + 4); // Column end address (127 = reset)

  ssd1306_command(SSD1306_PAGEADDR);
  ssd1306_command(y_pos - 1); // Page start address (0 = reset)
  ssd1306_command(y_pos - 1); // Page end address

  SSD1306_Start();
  SSD1306_Write(_i2caddr);
  SSD1306_Write(0x40);

  for(i = 0; i < 5; i++ ) {
    line = c[i];
    SSD1306_Write(line);
  }
  SSD1306_Stop();

  #if defined SSD1306_128_64 || defined SSD1306_128_32
  x_pos = x_pos % 21 + 1;
  if (wrap && (x_pos == 1))
    #if defined SSD1306_128_64
      y_pos = y_pos % 8 + 1;
    #else
      y_pos = y_pos % 4 + 1;
    #endif

  #else
    x_pos = x_pos % 16 + 1;
    if (wrap && (x_pos == 1))
      y_pos = y_pos % 2 + 1;
  #endif

}

void SSD1306_Print(char *s) {
  uint8_t i = 0;
  while (s[i] != '\0'){
    if (s[i] == ' ' & x_pos == 1)
      i++;
    else
      SSD1306_PutC(s[i++]);
  }
}

void SSD1306_ClearDisplay() {
  uint16_t i;
  ssd1306_command(SSD1306_COLUMNADDR);
  ssd1306_command(0);    // Column start address
  #if defined SSD1306_128_64 || defined SSD1306_128_32
  ssd1306_command(127);  // Column end address
  #else
    ssd1306_command(95); // Column end address
  #endif

  ssd1306_command(SSD1306_PAGEADDR);
  ssd1306_command(0);   // Page start address (0 = reset)
  #if defined SSD1306_128_64
  ssd1306_command(7);   // Page end address
  #elif defined SSD1306_128_32
  ssd1306_command(3);   // Page end address
  #elif defined SSD1306_96_16
  ssd1306_command(1);   // Page end address
  #endif

  SSD1306_Start();
  SSD1306_Write(_i2caddr);
  SSD1306_Write(0x40);

  for(i = 0; i < SSD1306_LCDHEIGHT * SSD1306_LCDWIDTH / 8; i++ )
    SSD1306_Write(0);

  SSD1306_Stop();

}

void SSD1306_FillScreen() {
  uint16_t i;
  ssd1306_command(SSD1306_COLUMNADDR);
  ssd1306_command(0);    // Column start address
  #if defined SSD1306_128_64 || defined SSD1306_128_32
  ssd1306_command(127);  // Column end address
  #else
    ssd1306_command(95); // Column end address
  #endif

  ssd1306_command(SSD1306_PAGEADDR);
  ssd1306_command(0);   // Page start address (0 = reset)
  #if defined SSD1306_128_64
  ssd1306_command(7);   // Page end address
  #elif defined SSD1306_128_32
  ssd1306_command(3);   // Page end address
  #elif defined SSD1306_96_16
  ssd1306_command(1);   // Page end address
  #endif

  SSD1306_Start();
  SSD1306_Write(_i2caddr);
  SSD1306_Write(0x40);

  for(i = 0; i < SSD1306_LCDHEIGHT * SSD1306_LCDWIDTH / 8; i++ )
    SSD1306_Write(0xFF);

  SSD1306_Stop();

}