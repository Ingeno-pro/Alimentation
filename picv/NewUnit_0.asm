
_ssd1306_command:

;NewUnit_0.c,194 :: 		void ssd1306_command(uint8_t c) {
;NewUnit_0.c,195 :: 		uint8_t control = 0x00;   // Co = 0, D/C = 0
	CLRF       ssd1306_command_control_L0+0
;NewUnit_0.c,196 :: 		SSD1306_Start();
	CALL       _Soft_I2C_Start+0
;NewUnit_0.c,197 :: 		SSD1306_Write(_i2caddr);
	MOVF       __i2caddr+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;NewUnit_0.c,198 :: 		SSD1306_Write(control);
	MOVF       ssd1306_command_control_L0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;NewUnit_0.c,199 :: 		SSD1306_Write(c);
	MOVF       FARG_ssd1306_command_c+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;NewUnit_0.c,200 :: 		SSD1306_Stop();
	CALL       _Soft_I2C_Stop+0
;NewUnit_0.c,201 :: 		}
L_end_ssd1306_command:
	RETURN
; end of _ssd1306_command

_SSD1306_Init:

;NewUnit_0.c,203 :: 		void SSD1306_Init(uint8_t vccstate, uint8_t i2caddr) {
;NewUnit_0.c,204 :: 		_vccstate = vccstate;
	MOVF       FARG_SSD1306_Init_vccstate+0, 0
	MOVWF      __vccstate+0
;NewUnit_0.c,205 :: 		_i2caddr  = i2caddr;
	MOVF       FARG_SSD1306_Init_i2caddr+0, 0
	MOVWF      __i2caddr+0
;NewUnit_0.c,215 :: 		ssd1306_command(SSD1306_DISPLAYOFF);                    // 0xAE
	MOVLW      174
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,216 :: 		ssd1306_command(SSD1306_SETDISPLAYCLOCKDIV);            // 0xD5
	MOVLW      213
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,217 :: 		ssd1306_command(0x80);                                  // the suggested ratio 0x80
	MOVLW      128
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,219 :: 		ssd1306_command(SSD1306_SETMULTIPLEX);                  // 0xA8
	MOVLW      168
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,220 :: 		ssd1306_command(SSD1306_LCDHEIGHT - 1);
	MOVLW      63
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,222 :: 		ssd1306_command(SSD1306_SETDISPLAYOFFSET);              // 0xD3
	MOVLW      211
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,223 :: 		ssd1306_command(0x0);                                   // no offset
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,224 :: 		ssd1306_command(SSD1306_SETSTARTLINE | 0x0);            // line #0
	MOVLW      64
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,225 :: 		ssd1306_command(SSD1306_CHARGEPUMP);                    // 0x8D
	MOVLW      141
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,226 :: 		if (vccstate == SSD1306_EXTERNALVCC)
	MOVF       FARG_SSD1306_Init_vccstate+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SSD1306_Init0
;NewUnit_0.c,227 :: 		{ ssd1306_command(0x10); }
	MOVLW      16
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
	GOTO       L_SSD1306_Init1
L_SSD1306_Init0:
;NewUnit_0.c,229 :: 		{ ssd1306_command(0x14); }
	MOVLW      20
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
L_SSD1306_Init1:
;NewUnit_0.c,230 :: 		ssd1306_command(SSD1306_MEMORYMODE);                    // 0x20
	MOVLW      32
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,231 :: 		ssd1306_command(0x00);                                  // 0x0 act like ks0108
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,232 :: 		ssd1306_command(SSD1306_SEGREMAP | 0x1);
	MOVLW      161
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,233 :: 		ssd1306_command(SSD1306_COMSCANDEC);
	MOVLW      200
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,242 :: 		ssd1306_command(SSD1306_SETCOMPINS);                    // 0xDA
	MOVLW      218
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,243 :: 		ssd1306_command(0x12);
	MOVLW      18
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,244 :: 		ssd1306_command(SSD1306_SETCONTRAST);                   // 0x81
	MOVLW      129
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,245 :: 		if (vccstate == SSD1306_EXTERNALVCC)
	MOVF       FARG_SSD1306_Init_vccstate+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SSD1306_Init2
;NewUnit_0.c,246 :: 		{ ssd1306_command(0x9F); }
	MOVLW      159
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
	GOTO       L_SSD1306_Init3
L_SSD1306_Init2:
;NewUnit_0.c,248 :: 		{ ssd1306_command(0xCF); }
	MOVLW      207
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
L_SSD1306_Init3:
;NewUnit_0.c,261 :: 		ssd1306_command(SSD1306_SETPRECHARGE);                  // 0xd9
	MOVLW      217
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,262 :: 		if (vccstate == SSD1306_EXTERNALVCC)
	MOVF       FARG_SSD1306_Init_vccstate+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SSD1306_Init4
;NewUnit_0.c,263 :: 		{ ssd1306_command(0x22); }
	MOVLW      34
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
	GOTO       L_SSD1306_Init5
L_SSD1306_Init4:
;NewUnit_0.c,265 :: 		{ ssd1306_command(0xF1); }
	MOVLW      241
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
L_SSD1306_Init5:
;NewUnit_0.c,266 :: 		ssd1306_command(SSD1306_SETVCOMDETECT);                 // 0xDB
	MOVLW      219
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,267 :: 		ssd1306_command(0x40);
	MOVLW      64
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,268 :: 		ssd1306_command(SSD1306_DISPLAYALLON_RESUME);           // 0xA4
	MOVLW      164
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,269 :: 		ssd1306_command(SSD1306_NORMALDISPLAY);                 // 0xA6
	MOVLW      166
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,271 :: 		ssd1306_command(SSD1306_DEACTIVATE_SCROLL);
	MOVLW      46
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,273 :: 		ssd1306_command(SSD1306_DISPLAYON);//--turn on oled panel
	MOVLW      175
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,274 :: 		}
L_end_SSD1306_Init:
	RETURN
; end of _SSD1306_Init

_SSD1306_StartScrollRight:

;NewUnit_0.c,276 :: 		void SSD1306_StartScrollRight(uint8_t start, uint8_t stop) {
;NewUnit_0.c,277 :: 		ssd1306_command(SSD1306_RIGHT_HORIZONTAL_SCROLL);
	MOVLW      38
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,278 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,279 :: 		ssd1306_command(start);  // start page
	MOVF       FARG_SSD1306_StartScrollRight_start+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,280 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,281 :: 		ssd1306_command(stop);   // end page
	MOVF       FARG_SSD1306_StartScrollRight_stop+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,282 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,283 :: 		ssd1306_command(0XFF);
	MOVLW      255
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,284 :: 		ssd1306_command(SSD1306_ACTIVATE_SCROLL);
	MOVLW      47
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,285 :: 		}
L_end_SSD1306_StartScrollRight:
	RETURN
; end of _SSD1306_StartScrollRight

_SSD1306_StartScrollLeft:

;NewUnit_0.c,287 :: 		void SSD1306_StartScrollLeft(uint8_t start, uint8_t stop) {
;NewUnit_0.c,288 :: 		ssd1306_command(SSD1306_LEFT_HORIZONTAL_SCROLL);
	MOVLW      39
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,289 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,290 :: 		ssd1306_command(start);
	MOVF       FARG_SSD1306_StartScrollLeft_start+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,291 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,292 :: 		ssd1306_command(stop);
	MOVF       FARG_SSD1306_StartScrollLeft_stop+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,293 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,294 :: 		ssd1306_command(0XFF);
	MOVLW      255
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,295 :: 		ssd1306_command(SSD1306_ACTIVATE_SCROLL);
	MOVLW      47
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,296 :: 		}
L_end_SSD1306_StartScrollLeft:
	RETURN
; end of _SSD1306_StartScrollLeft

_SSD1306_StartScrollDiagRight:

;NewUnit_0.c,298 :: 		void SSD1306_StartScrollDiagRight(uint8_t start, uint8_t stop) {
;NewUnit_0.c,299 :: 		ssd1306_command(SSD1306_SET_VERTICAL_SCROLL_AREA);
	MOVLW      163
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,300 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,301 :: 		ssd1306_command(SSD1306_LCDHEIGHT);
	MOVLW      64
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,302 :: 		ssd1306_command(SSD1306_VERTICAL_AND_RIGHT_HORIZONTAL_SCROLL);
	MOVLW      41
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,303 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,304 :: 		ssd1306_command(start);
	MOVF       FARG_SSD1306_StartScrollDiagRight_start+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,305 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,306 :: 		ssd1306_command(stop);
	MOVF       FARG_SSD1306_StartScrollDiagRight_stop+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,307 :: 		ssd1306_command(0X01);
	MOVLW      1
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,308 :: 		ssd1306_command(SSD1306_ACTIVATE_SCROLL);
	MOVLW      47
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,309 :: 		}
L_end_SSD1306_StartScrollDiagRight:
	RETURN
; end of _SSD1306_StartScrollDiagRight

_SSD1306_StartScrollDiagLeft:

;NewUnit_0.c,311 :: 		void SSD1306_StartScrollDiagLeft(uint8_t start, uint8_t stop) {
;NewUnit_0.c,312 :: 		ssd1306_command(SSD1306_SET_VERTICAL_SCROLL_AREA);
	MOVLW      163
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,313 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,314 :: 		ssd1306_command(SSD1306_LCDHEIGHT);
	MOVLW      64
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,315 :: 		ssd1306_command(SSD1306_VERTICAL_AND_LEFT_HORIZONTAL_SCROLL);
	MOVLW      42
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,316 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,317 :: 		ssd1306_command(start);
	MOVF       FARG_SSD1306_StartScrollDiagLeft_start+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,318 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,319 :: 		ssd1306_command(stop);
	MOVF       FARG_SSD1306_StartScrollDiagLeft_stop+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,320 :: 		ssd1306_command(0X01);
	MOVLW      1
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,321 :: 		ssd1306_command(SSD1306_ACTIVATE_SCROLL);
	MOVLW      47
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,322 :: 		}
L_end_SSD1306_StartScrollDiagLeft:
	RETURN
; end of _SSD1306_StartScrollDiagLeft

_SSD1306_StopScroll:

;NewUnit_0.c,324 :: 		void SSD1306_StopScroll(void) {
;NewUnit_0.c,325 :: 		ssd1306_command(SSD1306_DEACTIVATE_SCROLL);
	MOVLW      46
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,326 :: 		}
L_end_SSD1306_StopScroll:
	RETURN
; end of _SSD1306_StopScroll

_SSD1306_Dim:

;NewUnit_0.c,328 :: 		void SSD1306_Dim(uint8_t dim) {
;NewUnit_0.c,330 :: 		if (dim & 1)
	BTFSS      FARG_SSD1306_Dim_dim+0, 0
	GOTO       L_SSD1306_Dim6
;NewUnit_0.c,331 :: 		contrast = 0; // Dimmed display
	CLRF       SSD1306_Dim_contrast_L0+0
	GOTO       L_SSD1306_Dim7
L_SSD1306_Dim6:
;NewUnit_0.c,333 :: 		if (_vccstate == SSD1306_EXTERNALVCC)
	MOVF       __vccstate+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SSD1306_Dim8
;NewUnit_0.c,334 :: 		contrast = 0x9F;
	MOVLW      159
	MOVWF      SSD1306_Dim_contrast_L0+0
	GOTO       L_SSD1306_Dim9
L_SSD1306_Dim8:
;NewUnit_0.c,336 :: 		contrast = 0xCF;
	MOVLW      207
	MOVWF      SSD1306_Dim_contrast_L0+0
L_SSD1306_Dim9:
;NewUnit_0.c,337 :: 		}
L_SSD1306_Dim7:
;NewUnit_0.c,340 :: 		ssd1306_command(SSD1306_SETCONTRAST);
	MOVLW      129
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,341 :: 		ssd1306_command(contrast);
	MOVF       SSD1306_Dim_contrast_L0+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,342 :: 		}
L_end_SSD1306_Dim:
	RETURN
; end of _SSD1306_Dim

_SSD1306_SetTextWrap:

;NewUnit_0.c,344 :: 		void SSD1306_SetTextWrap(uint8_t w) {
;NewUnit_0.c,345 :: 		wrap = w & 1;
	MOVLW      1
	ANDWF      FARG_SSD1306_SetTextWrap_w+0, 0
	MOVWF      _wrap+0
;NewUnit_0.c,346 :: 		}
L_end_SSD1306_SetTextWrap:
	RETURN
; end of _SSD1306_SetTextWrap

_SSD1306_InvertDisplay:

;NewUnit_0.c,348 :: 		void SSD1306_InvertDisplay(uint8_t i) {
;NewUnit_0.c,349 :: 		if (i & 1)
	BTFSS      FARG_SSD1306_InvertDisplay_i+0, 0
	GOTO       L_SSD1306_InvertDisplay10
;NewUnit_0.c,350 :: 		ssd1306_command(SSD1306_INVERTDISPLAY_);
	MOVLW      167
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
	GOTO       L_SSD1306_InvertDisplay11
L_SSD1306_InvertDisplay10:
;NewUnit_0.c,352 :: 		ssd1306_command(SSD1306_NORMALDISPLAY);
	MOVLW      166
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
L_SSD1306_InvertDisplay11:
;NewUnit_0.c,353 :: 		}
L_end_SSD1306_InvertDisplay:
	RETURN
; end of _SSD1306_InvertDisplay

_SSD1306_GotoXY:

;NewUnit_0.c,355 :: 		void SSD1306_GotoXY(uint8_t x, uint8_t y) {
;NewUnit_0.c,356 :: 		if((x > SSD1306_LCDWIDTH / 6) || y > SSD1306_LCDHEIGHT / 8)
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SSD1306_GotoXY55
	MOVF       FARG_SSD1306_GotoXY_x+0, 0
	SUBLW      21
L__SSD1306_GotoXY55:
	BTFSS      STATUS+0, 0
	GOTO       L__SSD1306_GotoXY40
	MOVF       FARG_SSD1306_GotoXY_y+0, 0
	SUBLW      8
	BTFSS      STATUS+0, 0
	GOTO       L__SSD1306_GotoXY40
	GOTO       L_SSD1306_GotoXY14
L__SSD1306_GotoXY40:
;NewUnit_0.c,357 :: 		return;
	GOTO       L_end_SSD1306_GotoXY
L_SSD1306_GotoXY14:
;NewUnit_0.c,358 :: 		x_pos = x;
	MOVF       FARG_SSD1306_GotoXY_x+0, 0
	MOVWF      _x_pos+0
;NewUnit_0.c,359 :: 		y_pos = y;
	MOVF       FARG_SSD1306_GotoXY_y+0, 0
	MOVWF      _y_pos+0
;NewUnit_0.c,360 :: 		}
L_end_SSD1306_GotoXY:
	RETURN
; end of _SSD1306_GotoXY

_SSD1306_PutC:

;NewUnit_0.c,362 :: 		void SSD1306_PutC(char c) {
;NewUnit_0.c,364 :: 		if((c < ' ') || (c > '~'))
	MOVLW      32
	SUBWF      FARG_SSD1306_PutC_c+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__SSD1306_PutC42
	MOVF       FARG_SSD1306_PutC_c+0, 0
	SUBLW      126
	BTFSS      STATUS+0, 0
	GOTO       L__SSD1306_PutC42
	GOTO       L_SSD1306_PutC17
L__SSD1306_PutC42:
;NewUnit_0.c,365 :: 		c = '?';
	MOVLW      63
	MOVWF      FARG_SSD1306_PutC_c+0
L_SSD1306_PutC17:
;NewUnit_0.c,366 :: 		ssd1306_command(SSD1306_COLUMNADDR);
	MOVLW      33
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,367 :: 		ssd1306_command(6 * (x_pos - 1));
	DECF       _x_pos+0, 0
	MOVWF      R0+0
	MOVLW      6
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,368 :: 		ssd1306_command(6 * (x_pos - 1) + 4); // Column end address (127 = reset)
	DECF       _x_pos+0, 0
	MOVWF      R0+0
	MOVLW      6
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVLW      4
	ADDWF      R0+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,370 :: 		ssd1306_command(SSD1306_PAGEADDR);
	MOVLW      34
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,371 :: 		ssd1306_command(y_pos - 1); // Page start address (0 = reset)
	DECF       _y_pos+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,372 :: 		ssd1306_command(y_pos - 1); // Page end address
	DECF       _y_pos+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,374 :: 		SSD1306_Start();
	CALL       _Soft_I2C_Start+0
;NewUnit_0.c,375 :: 		SSD1306_Write(_i2caddr);
	MOVF       __i2caddr+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;NewUnit_0.c,376 :: 		SSD1306_Write(0x40);
	MOVLW      64
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;NewUnit_0.c,378 :: 		for(i = 0; i < 5; i++ ) {
	CLRF       SSD1306_PutC_i_L0+0
L_SSD1306_PutC18:
	MOVLW      5
	SUBWF      SSD1306_PutC_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SSD1306_PutC19
;NewUnit_0.c,379 :: 		font_c = font[(c - 32) * 5 + i];
	MOVLW      32
	SUBWF      FARG_SSD1306_PutC_c+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      5
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       SSD1306_PutC_i_L0+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      _Font+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_Font+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_Soft_I2C_Write_data_+0
;NewUnit_0.c,381 :: 		SSD1306_Write(font_c);
	CALL       _Soft_I2C_Write+0
;NewUnit_0.c,378 :: 		for(i = 0; i < 5; i++ ) {
	INCF       SSD1306_PutC_i_L0+0, 1
;NewUnit_0.c,382 :: 		}
	GOTO       L_SSD1306_PutC18
L_SSD1306_PutC19:
;NewUnit_0.c,383 :: 		SSD1306_Stop();
	CALL       _Soft_I2C_Stop+0
;NewUnit_0.c,386 :: 		x_pos = x_pos % 21 + 1;
	MOVLW      21
	MOVWF      R4+0
	MOVF       _x_pos+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	INCF       R0+0, 0
	MOVWF      _x_pos+0
;NewUnit_0.c,387 :: 		if (wrap && (x_pos == 1))
	MOVF       _wrap+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SSD1306_PutC23
	MOVF       _x_pos+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SSD1306_PutC23
L__SSD1306_PutC41:
;NewUnit_0.c,389 :: 		y_pos = y_pos % 8 + 1;
	MOVLW      7
	ANDWF      _y_pos+0, 1
	INCF       _y_pos+0, 1
L_SSD1306_PutC23:
;NewUnit_0.c,400 :: 		}
L_end_SSD1306_PutC:
	RETURN
; end of _SSD1306_PutC

_SSD1306_PutCustomC:

;NewUnit_0.c,402 :: 		void SSD1306_PutCustomC(char *c) {
;NewUnit_0.c,404 :: 		ssd1306_command(SSD1306_COLUMNADDR);
	MOVLW      33
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,405 :: 		ssd1306_command(6 * (x_pos - 1));
	DECF       _x_pos+0, 0
	MOVWF      R0+0
	MOVLW      6
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,406 :: 		ssd1306_command(6 * (x_pos - 1) + 4); // Column end address (127 = reset)
	DECF       _x_pos+0, 0
	MOVWF      R0+0
	MOVLW      6
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVLW      4
	ADDWF      R0+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,408 :: 		ssd1306_command(SSD1306_PAGEADDR);
	MOVLW      34
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,409 :: 		ssd1306_command(y_pos - 1); // Page start address (0 = reset)
	DECF       _y_pos+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,410 :: 		ssd1306_command(y_pos - 1); // Page end address
	DECF       _y_pos+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,412 :: 		SSD1306_Start();
	CALL       _Soft_I2C_Start+0
;NewUnit_0.c,413 :: 		SSD1306_Write(_i2caddr);
	MOVF       __i2caddr+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;NewUnit_0.c,414 :: 		SSD1306_Write(0x40);
	MOVLW      64
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;NewUnit_0.c,416 :: 		for(i = 0; i < 5; i++ ) {
	CLRF       SSD1306_PutCustomC_i_L0+0
L_SSD1306_PutCustomC24:
	MOVLW      5
	SUBWF      SSD1306_PutCustomC_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SSD1306_PutCustomC25
;NewUnit_0.c,417 :: 		line = c[i];
	MOVF       SSD1306_PutCustomC_i_L0+0, 0
	ADDWF      FARG_SSD1306_PutCustomC_c+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
;NewUnit_0.c,418 :: 		SSD1306_Write(line);
	CALL       _Soft_I2C_Write+0
;NewUnit_0.c,416 :: 		for(i = 0; i < 5; i++ ) {
	INCF       SSD1306_PutCustomC_i_L0+0, 1
;NewUnit_0.c,419 :: 		}
	GOTO       L_SSD1306_PutCustomC24
L_SSD1306_PutCustomC25:
;NewUnit_0.c,420 :: 		SSD1306_Stop();
	CALL       _Soft_I2C_Stop+0
;NewUnit_0.c,423 :: 		x_pos = x_pos % 21 + 1;
	MOVLW      21
	MOVWF      R4+0
	MOVF       _x_pos+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	INCF       R0+0, 0
	MOVWF      _x_pos+0
;NewUnit_0.c,424 :: 		if (wrap && (x_pos == 1))
	MOVF       _wrap+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SSD1306_PutCustomC29
	MOVF       _x_pos+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SSD1306_PutCustomC29
L__SSD1306_PutCustomC43:
;NewUnit_0.c,426 :: 		y_pos = y_pos % 8 + 1;
	MOVLW      7
	ANDWF      _y_pos+0, 1
	INCF       _y_pos+0, 1
L_SSD1306_PutCustomC29:
;NewUnit_0.c,437 :: 		}
L_end_SSD1306_PutCustomC:
	RETURN
; end of _SSD1306_PutCustomC

_SSD1306_Print:

;NewUnit_0.c,439 :: 		void SSD1306_Print(char *s) {
;NewUnit_0.c,440 :: 		uint8_t i = 0;
	CLRF       SSD1306_Print_i_L0+0
;NewUnit_0.c,441 :: 		while (s[i] != '\0'){
L_SSD1306_Print30:
	MOVF       SSD1306_Print_i_L0+0, 0
	ADDWF      FARG_SSD1306_Print_s+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_SSD1306_Print31
;NewUnit_0.c,442 :: 		if (s[i] == ' ' & x_pos == 1)
	MOVF       SSD1306_Print_i_L0+0, 0
	ADDWF      FARG_SSD1306_Print_s+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      32
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R1+0
	MOVF       _x_pos+0, 0
	XORLW      1
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       R1+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L_SSD1306_Print32
;NewUnit_0.c,443 :: 		i++;
	INCF       SSD1306_Print_i_L0+0, 1
	GOTO       L_SSD1306_Print33
L_SSD1306_Print32:
;NewUnit_0.c,445 :: 		SSD1306_PutC(s[i++]);
	MOVF       SSD1306_Print_i_L0+0, 0
	ADDWF      FARG_SSD1306_Print_s+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_SSD1306_PutC_c+0
	CALL       _SSD1306_PutC+0
	INCF       SSD1306_Print_i_L0+0, 1
L_SSD1306_Print33:
;NewUnit_0.c,446 :: 		}
	GOTO       L_SSD1306_Print30
L_SSD1306_Print31:
;NewUnit_0.c,447 :: 		}
L_end_SSD1306_Print:
	RETURN
; end of _SSD1306_Print

_SSD1306_ClearDisplay:

;NewUnit_0.c,449 :: 		void SSD1306_ClearDisplay() {
;NewUnit_0.c,451 :: 		ssd1306_command(SSD1306_COLUMNADDR);
	MOVLW      33
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,452 :: 		ssd1306_command(0);    // Column start address
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,454 :: 		ssd1306_command(127);  // Column end address
	MOVLW      127
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,459 :: 		ssd1306_command(SSD1306_PAGEADDR);
	MOVLW      34
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,460 :: 		ssd1306_command(0);   // Page start address (0 = reset)
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,462 :: 		ssd1306_command(7);   // Page end address
	MOVLW      7
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,469 :: 		SSD1306_Start();
	CALL       _Soft_I2C_Start+0
;NewUnit_0.c,470 :: 		SSD1306_Write(_i2caddr);
	MOVF       __i2caddr+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;NewUnit_0.c,471 :: 		SSD1306_Write(0x40);
	MOVLW      64
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;NewUnit_0.c,473 :: 		for(i = 0; i < SSD1306_LCDHEIGHT * SSD1306_LCDWIDTH / 8; i++ )
	CLRF       SSD1306_ClearDisplay_i_L0+0
	CLRF       SSD1306_ClearDisplay_i_L0+1
L_SSD1306_ClearDisplay34:
	MOVLW      4
	SUBWF      SSD1306_ClearDisplay_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SSD1306_ClearDisplay60
	MOVLW      0
	SUBWF      SSD1306_ClearDisplay_i_L0+0, 0
L__SSD1306_ClearDisplay60:
	BTFSC      STATUS+0, 0
	GOTO       L_SSD1306_ClearDisplay35
;NewUnit_0.c,474 :: 		SSD1306_Write(0);
	CLRF       FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;NewUnit_0.c,473 :: 		for(i = 0; i < SSD1306_LCDHEIGHT * SSD1306_LCDWIDTH / 8; i++ )
	INCF       SSD1306_ClearDisplay_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       SSD1306_ClearDisplay_i_L0+1, 1
;NewUnit_0.c,474 :: 		SSD1306_Write(0);
	GOTO       L_SSD1306_ClearDisplay34
L_SSD1306_ClearDisplay35:
;NewUnit_0.c,476 :: 		SSD1306_Stop();
	CALL       _Soft_I2C_Stop+0
;NewUnit_0.c,478 :: 		}
L_end_SSD1306_ClearDisplay:
	RETURN
; end of _SSD1306_ClearDisplay

_SSD1306_FillScreen:

;NewUnit_0.c,480 :: 		void SSD1306_FillScreen() {
;NewUnit_0.c,482 :: 		ssd1306_command(SSD1306_COLUMNADDR);
	MOVLW      33
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,483 :: 		ssd1306_command(0);    // Column start address
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,485 :: 		ssd1306_command(127);  // Column end address
	MOVLW      127
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,490 :: 		ssd1306_command(SSD1306_PAGEADDR);
	MOVLW      34
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,491 :: 		ssd1306_command(0);   // Page start address (0 = reset)
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,493 :: 		ssd1306_command(7);   // Page end address
	MOVLW      7
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;NewUnit_0.c,500 :: 		SSD1306_Start();
	CALL       _Soft_I2C_Start+0
;NewUnit_0.c,501 :: 		SSD1306_Write(_i2caddr);
	MOVF       __i2caddr+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;NewUnit_0.c,502 :: 		SSD1306_Write(0x40);
	MOVLW      64
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;NewUnit_0.c,504 :: 		for(i = 0; i < SSD1306_LCDHEIGHT * SSD1306_LCDWIDTH / 8; i++ )
	CLRF       SSD1306_FillScreen_i_L0+0
	CLRF       SSD1306_FillScreen_i_L0+1
L_SSD1306_FillScreen37:
	MOVLW      4
	SUBWF      SSD1306_FillScreen_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SSD1306_FillScreen62
	MOVLW      0
	SUBWF      SSD1306_FillScreen_i_L0+0, 0
L__SSD1306_FillScreen62:
	BTFSC      STATUS+0, 0
	GOTO       L_SSD1306_FillScreen38
;NewUnit_0.c,505 :: 		SSD1306_Write(0xFF);
	MOVLW      255
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;NewUnit_0.c,504 :: 		for(i = 0; i < SSD1306_LCDHEIGHT * SSD1306_LCDWIDTH / 8; i++ )
	INCF       SSD1306_FillScreen_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       SSD1306_FillScreen_i_L0+1, 1
;NewUnit_0.c,505 :: 		SSD1306_Write(0xFF);
	GOTO       L_SSD1306_FillScreen37
L_SSD1306_FillScreen38:
;NewUnit_0.c,507 :: 		SSD1306_Stop();
	CALL       _Soft_I2C_Stop+0
;NewUnit_0.c,509 :: 		}
L_end_SSD1306_FillScreen:
	RETURN
; end of _SSD1306_FillScreen
