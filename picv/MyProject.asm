
_ssd1306_command:

;MyProject.c,239 :: 		void ssd1306_command(uint8_t c)
;MyProject.c,248 :: 		uint8_t control = 0x00;   // Co = 0, D/C = 0
	CLRF       ssd1306_command_control_L0+0
;MyProject.c,249 :: 		SSD1306_I2C_Start();
	CALL       _Soft_I2C_Start+0
;MyProject.c,250 :: 		SSD1306_I2C_Write(_i2caddr);
	MOVF       __i2caddr+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,251 :: 		SSD1306_I2C_Write(control);
	MOVF       ssd1306_command_control_L0+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,252 :: 		SSD1306_I2C_Write(c);
	MOVF       FARG_ssd1306_command_c+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,253 :: 		SSD1306_I2C_Stop();
	CALL       _Soft_I2C_Stop+0
;MyProject.c,255 :: 		}
L_end_ssd1306_command:
	RETURN
; end of _ssd1306_command

_SSD1306_begin:

;MyProject.c,260 :: 		void SSD1306_begin(uint8_t vccstate, uint8_t i2caddr) {
;MyProject.c,261 :: 		_i2caddr  = i2caddr;
	MOVF       FARG_SSD1306_begin_i2caddr+0, 0
	MOVWF      __i2caddr+0
;MyProject.c,263 :: 		_vccstate = vccstate;
	MOVF       FARG_SSD1306_begin_vccstate+0, 0
	MOVWF      __vccstate+0
;MyProject.c,264 :: 		delay_ms(10);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_SSD1306_begin0:
	DECFSZ     R13+0, 1
	GOTO       L_SSD1306_begin0
	DECFSZ     R12+0, 1
	GOTO       L_SSD1306_begin0
	NOP
	NOP
;MyProject.c,287 :: 		ssd1306_command(SSD1306_DISPLAYOFF);                    // 0xAE
	MOVLW      174
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,288 :: 		ssd1306_command(SSD1306_SETDISPLAYCLOCKDIV);            // 0xD5
	MOVLW      213
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,289 :: 		ssd1306_command(0x80);                                  // the suggested ratio 0x80
	MOVLW      128
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,291 :: 		ssd1306_command(SSD1306_SETMULTIPLEX);                  // 0xA8
	MOVLW      168
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,292 :: 		ssd1306_command(SSD1306_LCDHEIGHT - 1);
	MOVLW      63
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,294 :: 		ssd1306_command(SSD1306_SETDISPLAYOFFSET);              // 0xD3
	MOVLW      211
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,295 :: 		ssd1306_command(0x0);                                   // no offset
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,296 :: 		ssd1306_command(SSD1306_SETSTARTLINE | 0x0);            // line #0
	MOVLW      64
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,297 :: 		ssd1306_command(SSD1306_CHARGEPUMP);                    // 0x8D
	MOVLW      141
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,298 :: 		if (vccstate == SSD1306_EXTERNALVCC)
	MOVF       FARG_SSD1306_begin_vccstate+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SSD1306_begin1
;MyProject.c,299 :: 		{ ssd1306_command(0x10); }
	MOVLW      16
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
	GOTO       L_SSD1306_begin2
L_SSD1306_begin1:
;MyProject.c,301 :: 		{ ssd1306_command(0x14); }
	MOVLW      20
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
L_SSD1306_begin2:
;MyProject.c,302 :: 		ssd1306_command(SSD1306_MEMORYMODE);                    // 0x20
	MOVLW      32
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,303 :: 		ssd1306_command(0x00);                                  // 0x0 act like ks0108
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,304 :: 		ssd1306_command(SSD1306_SEGREMAP | 0x1);
	MOVLW      161
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,305 :: 		ssd1306_command(SSD1306_COMSCANDEC);
	MOVLW      200
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,314 :: 		ssd1306_command(SSD1306_SETCOMPINS);                    // 0xDA
	MOVLW      218
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,315 :: 		ssd1306_command(0x12);
	MOVLW      18
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,316 :: 		ssd1306_command(SSD1306_SETCONTRAST);                   // 0x81
	MOVLW      129
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,317 :: 		if (vccstate == SSD1306_EXTERNALVCC)
	MOVF       FARG_SSD1306_begin_vccstate+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SSD1306_begin3
;MyProject.c,318 :: 		{ ssd1306_command(0x9F); }
	MOVLW      159
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
	GOTO       L_SSD1306_begin4
L_SSD1306_begin3:
;MyProject.c,320 :: 		{ ssd1306_command(0xCF); }
	MOVLW      207
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
L_SSD1306_begin4:
;MyProject.c,333 :: 		ssd1306_command(SSD1306_SETPRECHARGE);                  // 0xd9
	MOVLW      217
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,334 :: 		if (vccstate == SSD1306_EXTERNALVCC)
	MOVF       FARG_SSD1306_begin_vccstate+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SSD1306_begin5
;MyProject.c,335 :: 		{ ssd1306_command(0x22); }
	MOVLW      34
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
	GOTO       L_SSD1306_begin6
L_SSD1306_begin5:
;MyProject.c,337 :: 		{ ssd1306_command(0xF1); }
	MOVLW      241
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
L_SSD1306_begin6:
;MyProject.c,338 :: 		ssd1306_command(SSD1306_SETVCOMDETECT);                 // 0xDB
	MOVLW      219
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,339 :: 		ssd1306_command(0x40);
	MOVLW      64
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,340 :: 		ssd1306_command(SSD1306_DISPLAYALLON_RESUME);           // 0xA4
	MOVLW      164
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,341 :: 		ssd1306_command(SSD1306_NORMALDISPLAY);                 // 0xA6
	MOVLW      166
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,343 :: 		ssd1306_command(SSD1306_DEACTIVATE_SCROLL);
	MOVLW      46
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,345 :: 		ssd1306_command(SSD1306_DISPLAYON);  //--turn on oled panel
	MOVLW      175
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,347 :: 		_height = SSD1306_LCDHEIGHT;
	MOVLW      64
	MOVWF      __height+0
;MyProject.c,348 :: 		_width  = SSD1306_LCDWIDTH;
	MOVLW      128
	MOVWF      __width+0
;MyProject.c,349 :: 		}
L_end_SSD1306_begin:
	RETURN
; end of _SSD1306_begin

_display_startScrollRight:

;MyProject.c,353 :: 		void display_startScrollRight(uint8_t start, uint8_t stop)
;MyProject.c,355 :: 		ssd1306_command(SSD1306_RIGHT_HORIZONTAL_SCROLL);
	MOVLW      38
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,356 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,357 :: 		ssd1306_command(start);
	MOVF       FARG_display_startScrollRight_start+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,358 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,359 :: 		ssd1306_command(stop);
	MOVF       FARG_display_startScrollRight_stop+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,360 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,361 :: 		ssd1306_command(0XFF);
	MOVLW      255
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,362 :: 		ssd1306_command(SSD1306_ACTIVATE_SCROLL);
	MOVLW      47
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,363 :: 		}
L_end_display_startScrollRight:
	RETURN
; end of _display_startScrollRight

_display_startScrollLeft:

;MyProject.c,369 :: 		void display_startScrollLeft(uint8_t start, uint8_t stop)
;MyProject.c,371 :: 		ssd1306_command(SSD1306_LEFT_HORIZONTAL_SCROLL);
	MOVLW      39
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,372 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,373 :: 		ssd1306_command(start);
	MOVF       FARG_display_startScrollLeft_start+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,374 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,375 :: 		ssd1306_command(stop);
	MOVF       FARG_display_startScrollLeft_stop+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,376 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,377 :: 		ssd1306_command(0XFF);
	MOVLW      255
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,378 :: 		ssd1306_command(SSD1306_ACTIVATE_SCROLL);
	MOVLW      47
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,379 :: 		}
L_end_display_startScrollLeft:
	RETURN
; end of _display_startScrollLeft

_display_startScrollDiagRight:

;MyProject.c,385 :: 		void display_startScrollDiagRight(uint8_t start, uint8_t stop)
;MyProject.c,387 :: 		ssd1306_command(SSD1306_SET_VERTICAL_SCROLL_AREA);
	MOVLW      163
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,388 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,389 :: 		ssd1306_command(SSD1306_LCDHEIGHT);
	MOVLW      64
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,390 :: 		ssd1306_command(SSD1306_VERTICAL_AND_RIGHT_HORIZONTAL_SCROLL);
	MOVLW      41
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,391 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,392 :: 		ssd1306_command(start);
	MOVF       FARG_display_startScrollDiagRight_start+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,393 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,394 :: 		ssd1306_command(stop);
	MOVF       FARG_display_startScrollDiagRight_stop+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,395 :: 		ssd1306_command(0X01);
	MOVLW      1
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,396 :: 		ssd1306_command(SSD1306_ACTIVATE_SCROLL);
	MOVLW      47
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,397 :: 		}
L_end_display_startScrollDiagRight:
	RETURN
; end of _display_startScrollDiagRight

_display_startScrollDiagLeft:

;MyProject.c,403 :: 		void display_startScrollDiagLeft(uint8_t start, uint8_t stop)
;MyProject.c,405 :: 		ssd1306_command(SSD1306_SET_VERTICAL_SCROLL_AREA);
	MOVLW      163
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,406 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,407 :: 		ssd1306_command(SSD1306_LCDHEIGHT);
	MOVLW      64
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,408 :: 		ssd1306_command(SSD1306_VERTICAL_AND_LEFT_HORIZONTAL_SCROLL);
	MOVLW      42
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,409 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,410 :: 		ssd1306_command(start);
	MOVF       FARG_display_startScrollDiagLeft_start+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,411 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,412 :: 		ssd1306_command(stop);
	MOVF       FARG_display_startScrollDiagLeft_stop+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,413 :: 		ssd1306_command(0X01);
	MOVLW      1
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,414 :: 		ssd1306_command(SSD1306_ACTIVATE_SCROLL);
	MOVLW      47
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,415 :: 		}
L_end_display_startScrollDiagLeft:
	RETURN
; end of _display_startScrollDiagLeft

_display_stopScroll:

;MyProject.c,417 :: 		void display_stopScroll(void)
;MyProject.c,419 :: 		ssd1306_command(SSD1306_DEACTIVATE_SCROLL);
	MOVLW      46
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,420 :: 		}
L_end_display_stopScroll:
	RETURN
; end of _display_stopScroll

_display_dim:

;MyProject.c,425 :: 		void display_dim(bool dim)
;MyProject.c,428 :: 		if (dim)
	MOVF       FARG_display_dim_dim+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_display_dim7
;MyProject.c,429 :: 		contrast = 0; // Dimmed display
	CLRF       display_dim_contrast_L0+0
	GOTO       L_display_dim8
L_display_dim7:
;MyProject.c,431 :: 		if (_vccstate == SSD1306_EXTERNALVCC)
	MOVF       __vccstate+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_display_dim9
;MyProject.c,432 :: 		contrast = 0x9F;
	MOVLW      159
	MOVWF      display_dim_contrast_L0+0
	GOTO       L_display_dim10
L_display_dim9:
;MyProject.c,434 :: 		contrast = 0xCF;
	MOVLW      207
	MOVWF      display_dim_contrast_L0+0
L_display_dim10:
;MyProject.c,435 :: 		}
L_display_dim8:
;MyProject.c,438 :: 		ssd1306_command(SSD1306_SETCONTRAST);
	MOVLW      129
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,439 :: 		ssd1306_command(contrast);
	MOVF       display_dim_contrast_L0+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,440 :: 		}
L_end_display_dim:
	RETURN
; end of _display_dim

_display:

;MyProject.c,442 :: 		void display(void)
;MyProject.c,445 :: 		ssd1306_command(SSD1306_COLUMNADDR);
	MOVLW      33
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,446 :: 		ssd1306_command(0);   // Column start address (0 = reset)
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,447 :: 		ssd1306_command(SSD1306_LCDWIDTH-1); // Column end address (127 = reset)
	MOVLW      127
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,449 :: 		ssd1306_command(SSD1306_PAGEADDR);
	MOVLW      34
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,450 :: 		ssd1306_command(0); // Page start address (0 = reset)
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,452 :: 		ssd1306_command(7); // Page end address
	MOVLW      7
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;MyProject.c,461 :: 		for (i = 0; i < (SSD1306_LCDWIDTH*SSD1306_LCDHEIGHT / 8); i++) {
	CLRF       display_i_L0+0
	CLRF       display_i_L0+1
L_display11:
	MOVLW      4
	SUBWF      display_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__display98
	MOVLW      0
	SUBWF      display_i_L0+0, 0
L__display98:
	BTFSC      STATUS+0, 0
	GOTO       L_display12
;MyProject.c,469 :: 		SSD1306_I2C_Start();
	CALL       _Soft_I2C_Start+0
;MyProject.c,470 :: 		SSD1306_I2C_Write(_i2caddr);
	MOVF       __i2caddr+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,471 :: 		SSD1306_I2C_Write(0x40);
	MOVLW      64
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,472 :: 		for (x = 0; x < 16; x++) {
	CLRF       display_x_L1+0
L_display14:
	MOVLW      16
	SUBWF      display_x_L1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_display15
;MyProject.c,473 :: 		SSD1306_I2C_Write(ssd1306_buffer[i]);
	MOVF       display_i_L0+0, 0
	ADDLW      MyProject_ssd1306_buffer+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,474 :: 		i++;
	INCF       display_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       display_i_L0+1, 1
;MyProject.c,472 :: 		for (x = 0; x < 16; x++) {
	INCF       display_x_L1+0, 1
;MyProject.c,475 :: 		}
	GOTO       L_display14
L_display15:
;MyProject.c,476 :: 		i--;
	MOVLW      1
	SUBWF      display_i_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       display_i_L0+1, 1
;MyProject.c,477 :: 		SSD1306_I2C_Stop();
	CALL       _Soft_I2C_Stop+0
;MyProject.c,461 :: 		for (i = 0; i < (SSD1306_LCDWIDTH*SSD1306_LCDHEIGHT / 8); i++) {
	INCF       display_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       display_i_L0+1, 1
;MyProject.c,479 :: 		}
	GOTO       L_display11
L_display12:
;MyProject.c,480 :: 		}
L_end_display:
	RETURN
; end of _display

_display_clear:

;MyProject.c,482 :: 		void display_clear(void)
;MyProject.c,485 :: 		for (i = 0; i < (SSD1306_LCDWIDTH*SSD1306_LCDHEIGHT / 8); i++)
	CLRF       R1+0
	CLRF       R1+1
L_display_clear17:
	MOVLW      4
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__display_clear100
	MOVLW      0
	SUBWF      R1+0, 0
L__display_clear100:
	BTFSC      STATUS+0, 0
	GOTO       L_display_clear18
;MyProject.c,486 :: 		ssd1306_buffer[i] = 0;
	MOVF       R1+0, 0
	ADDLW      MyProject_ssd1306_buffer+0
	MOVWF      FSR
	CLRF       INDF+0
;MyProject.c,485 :: 		for (i = 0; i < (SSD1306_LCDWIDTH*SSD1306_LCDHEIGHT / 8); i++)
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;MyProject.c,486 :: 		ssd1306_buffer[i] = 0;
	GOTO       L_display_clear17
L_display_clear18:
;MyProject.c,487 :: 		}
L_end_display_clear:
	RETURN
; end of _display_clear

_fillRect:

;MyProject.c,489 :: 		void fillRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h, uint8_t color)
;MyProject.c,492 :: 		for (i = x; i < x + w; i++)
	MOVF       FARG_fillRect_x+0, 0
	MOVWF      fillRect_i_L0+0
L_fillRect20:
	MOVF       FARG_fillRect_w+0, 0
	ADDWF      FARG_fillRect_x+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__fillRect102
	MOVF       R1+0, 0
	SUBWF      fillRect_i_L0+0, 0
L__fillRect102:
	BTFSC      STATUS+0, 0
	GOTO       L_fillRect21
;MyProject.c,493 :: 		drawVLine(i, y, h, color);
	MOVF       fillRect_i_L0+0, 0
	MOVWF      FARG_drawVLine_x+0
	MOVF       FARG_fillRect_y+0, 0
	MOVWF      FARG_drawVLine_y+0
	MOVF       FARG_fillRect_h+0, 0
	MOVWF      FARG_drawVLine_h+0
	MOVF       FARG_fillRect_color+0, 0
	MOVWF      FARG_drawVLine_color+0
	CALL       _drawVLine+0
;MyProject.c,492 :: 		for (i = x; i < x + w; i++)
	INCF       fillRect_i_L0+0, 1
;MyProject.c,493 :: 		drawVLine(i, y, h, color);
	GOTO       L_fillRect20
L_fillRect21:
;MyProject.c,494 :: 		}
L_end_fillRect:
	RETURN
; end of _fillRect

_fillScreen:

;MyProject.c,496 :: 		void fillScreen(void) {
;MyProject.c,497 :: 		fillRect(0, 0, SSD1306_LCDWIDTH, SSD1306_LCDHEIGHT, 1);
	CLRF       FARG_fillRect_x+0
	CLRF       FARG_fillRect_y+0
	MOVLW      128
	MOVWF      FARG_fillRect_w+0
	MOVLW      64
	MOVWF      FARG_fillRect_h+0
	MOVLW      1
	MOVWF      FARG_fillRect_color+0
	CALL       _fillRect+0
;MyProject.c,498 :: 		}
L_end_fillScreen:
	RETURN
; end of _fillScreen

_invertDisplay:

;MyProject.c,501 :: 		void invertDisplay(bool i)
;MyProject.c,503 :: 		if (i)
	MOVF       FARG_invertDisplay_i+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_invertDisplay23
;MyProject.c,504 :: 		ssd1306_command(SSD1306_INVERTDISPLAY_);
	MOVLW      167
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
	GOTO       L_invertDisplay24
L_invertDisplay23:
;MyProject.c,506 :: 		ssd1306_command(SSD1306_NORMALDISPLAY);
	MOVLW      166
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
L_invertDisplay24:
;MyProject.c,507 :: 		}
L_end_invertDisplay:
	RETURN
; end of _invertDisplay

_setRotation:

;MyProject.c,509 :: 		void setRotation(uint8_t m) {
;MyProject.c,510 :: 		rotation = (m & 3);
	MOVLW      3
	ANDWF      FARG_setRotation_m+0, 0
	MOVWF      _rotation+0
;MyProject.c,511 :: 		switch(rotation) {
	GOTO       L_setRotation25
;MyProject.c,512 :: 		case 0:
L_setRotation27:
;MyProject.c,513 :: 		case 2:
L_setRotation28:
;MyProject.c,514 :: 		_width  = SSD1306_LCDWIDTH;
	MOVLW      128
	MOVWF      __width+0
;MyProject.c,515 :: 		_height = SSD1306_LCDHEIGHT;
	MOVLW      64
	MOVWF      __height+0
;MyProject.c,516 :: 		break;
	GOTO       L_setRotation26
;MyProject.c,517 :: 		case 1:
L_setRotation29:
;MyProject.c,518 :: 		case 3:
L_setRotation30:
;MyProject.c,519 :: 		_width  = SSD1306_LCDHEIGHT;
	MOVLW      64
	MOVWF      __width+0
;MyProject.c,520 :: 		_height = SSD1306_LCDWIDTH;
	MOVLW      128
	MOVWF      __height+0
;MyProject.c,521 :: 		break;
	GOTO       L_setRotation26
;MyProject.c,522 :: 		}
L_setRotation25:
	MOVF       _rotation+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_setRotation27
	MOVF       _rotation+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_setRotation28
	MOVF       _rotation+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_setRotation29
	MOVF       _rotation+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_setRotation30
L_setRotation26:
;MyProject.c,523 :: 		}
L_end_setRotation:
	RETURN
; end of _setRotation

_drawHLine:

;MyProject.c,525 :: 		void drawHLine(uint8_t x, uint8_t y, uint8_t w, uint8_t color) {
;MyProject.c,526 :: 		bool bSwap = false;
	CLRF       drawHLine_bSwap_L0+0
;MyProject.c,527 :: 		switch(rotation) {
	GOTO       L_drawHLine31
;MyProject.c,528 :: 		case 0:
L_drawHLine33:
;MyProject.c,530 :: 		break;
	GOTO       L_drawHLine32
;MyProject.c,531 :: 		case 1:
L_drawHLine34:
;MyProject.c,533 :: 		bSwap = true;
	MOVLW      1
	MOVWF      drawHLine_bSwap_L0+0
;MyProject.c,534 :: 		ssd1306_swap(x, y);
	MOVF       FARG_drawHLine_x+0, 0
	MOVWF      drawHLine_t_L2+0
	MOVF       FARG_drawHLine_y+0, 0
	MOVWF      FARG_drawHLine_x+0
	MOVF       drawHLine_t_L2+0, 0
	MOVWF      FARG_drawHLine_y+0
;MyProject.c,535 :: 		x = SSD1306_LCDWIDTH - x - 1;
	MOVF       FARG_drawHLine_x+0, 0
	SUBLW      128
	MOVWF      FARG_drawHLine_x+0
	DECF       FARG_drawHLine_x+0, 1
;MyProject.c,536 :: 		break;
	GOTO       L_drawHLine32
;MyProject.c,537 :: 		case 2:
L_drawHLine35:
;MyProject.c,539 :: 		x = SSD1306_LCDWIDTH - x - 1;
	MOVF       FARG_drawHLine_x+0, 0
	SUBLW      128
	MOVWF      FARG_drawHLine_x+0
	DECF       FARG_drawHLine_x+0, 1
;MyProject.c,540 :: 		y = SSD1306_LCDHEIGHT - y - 1;
	MOVF       FARG_drawHLine_y+0, 0
	SUBLW      64
	MOVWF      FARG_drawHLine_y+0
	DECF       FARG_drawHLine_y+0, 1
;MyProject.c,541 :: 		x -= (w-1);
	DECF       FARG_drawHLine_w+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	SUBWF      FARG_drawHLine_x+0, 1
;MyProject.c,542 :: 		break;
	GOTO       L_drawHLine32
;MyProject.c,543 :: 		case 3:
L_drawHLine36:
;MyProject.c,545 :: 		bSwap = true;
	MOVLW      1
	MOVWF      drawHLine_bSwap_L0+0
;MyProject.c,546 :: 		ssd1306_swap(x, y);
	MOVF       FARG_drawHLine_x+0, 0
	MOVWF      drawHLine_t_L2_L2+0
	MOVF       FARG_drawHLine_y+0, 0
	MOVWF      FARG_drawHLine_x+0
	MOVF       drawHLine_t_L2_L2+0, 0
	MOVWF      FARG_drawHLine_y+0
;MyProject.c,547 :: 		y = SSD1306_LCDHEIGHT - y - 1;
	MOVF       drawHLine_t_L2_L2+0, 0
	SUBLW      64
	MOVWF      FARG_drawHLine_y+0
	DECF       FARG_drawHLine_y+0, 1
;MyProject.c,548 :: 		y -= (w-1);
	DECF       FARG_drawHLine_w+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	SUBWF      FARG_drawHLine_y+0, 1
;MyProject.c,549 :: 		break;
	GOTO       L_drawHLine32
;MyProject.c,550 :: 		}
L_drawHLine31:
	MOVF       _rotation+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_drawHLine33
	MOVF       _rotation+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_drawHLine34
	MOVF       _rotation+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_drawHLine35
	MOVF       _rotation+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_drawHLine36
L_drawHLine32:
;MyProject.c,552 :: 		if(bSwap) {
	MOVF       drawHLine_bSwap_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_drawHLine37
;MyProject.c,553 :: 		drawFastVLineInternal(x, y, w, color);
	MOVF       FARG_drawHLine_x+0, 0
	MOVWF      FARG_drawFastVLineInternal_x+0
	MOVF       FARG_drawHLine_y+0, 0
	MOVWF      FARG_drawFastVLineInternal___y+0
	MOVF       FARG_drawHLine_w+0, 0
	MOVWF      FARG_drawFastVLineInternal___h+0
	MOVF       FARG_drawHLine_color+0, 0
	MOVWF      FARG_drawFastVLineInternal_color+0
	CALL       _drawFastVLineInternal+0
;MyProject.c,554 :: 		} else {
	GOTO       L_drawHLine38
L_drawHLine37:
;MyProject.c,555 :: 		drawFastHLineInternal(x, y, w, color);
	MOVF       FARG_drawHLine_x+0, 0
	MOVWF      FARG_drawFastHLineInternal_x+0
	MOVF       FARG_drawHLine_y+0, 0
	MOVWF      FARG_drawFastHLineInternal_y+0
	MOVF       FARG_drawHLine_w+0, 0
	MOVWF      FARG_drawFastHLineInternal_w+0
	MOVF       FARG_drawHLine_color+0, 0
	MOVWF      FARG_drawFastHLineInternal_color+0
	CALL       _drawFastHLineInternal+0
;MyProject.c,556 :: 		}
L_drawHLine38:
;MyProject.c,557 :: 		}
L_end_drawHLine:
	RETURN
; end of _drawHLine

_drawFastHLineInternal:

;MyProject.c,559 :: 		void drawFastHLineInternal(uint8_t x, uint8_t y, uint8_t w, uint8_t color) {
;MyProject.c,562 :: 		if(y >= SSD1306_LCDHEIGHT) { return; }
	MOVLW      64
	SUBWF      FARG_drawFastHLineInternal_y+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_drawFastHLineInternal39
	GOTO       L_end_drawFastHLineInternal
L_drawFastHLineInternal39:
;MyProject.c,565 :: 		if( (x + w) > SSD1306_LCDWIDTH) {
	MOVF       FARG_drawFastHLineInternal_w+0, 0
	ADDWF      FARG_drawFastHLineInternal_x+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__drawFastHLineInternal108
	MOVF       R1+0, 0
	SUBLW      128
L__drawFastHLineInternal108:
	BTFSC      STATUS+0, 0
	GOTO       L_drawFastHLineInternal40
;MyProject.c,566 :: 		w = (SSD1306_LCDWIDTH - x);
	MOVF       FARG_drawFastHLineInternal_x+0, 0
	SUBLW      128
	MOVWF      FARG_drawFastHLineInternal_w+0
;MyProject.c,567 :: 		}
L_drawFastHLineInternal40:
;MyProject.c,570 :: 		pBuf = ssd1306_buffer;
	MOVLW      MyProject_ssd1306_buffer+0
	MOVWF      R5+0
;MyProject.c,572 :: 		pBuf += ((uint16_t)(y/8) * SSD1306_LCDWIDTH);
	MOVF       FARG_drawFastHLineInternal_y+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVF       R0+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	MOVLW      7
	MOVWF      R2+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__drawFastHLineInternal109:
	BTFSC      STATUS+0, 2
	GOTO       L__drawFastHLineInternal110
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__drawFastHLineInternal109
L__drawFastHLineInternal110:
	MOVF       R0+0, 0
	ADDWF      R5+0, 1
;MyProject.c,574 :: 		pBuf += x;
	MOVF       FARG_drawFastHLineInternal_x+0, 0
	ADDWF      R5+0, 1
;MyProject.c,576 :: 		mask = 1 << (y&7);
	MOVLW      7
	ANDWF      FARG_drawFastHLineInternal_y+0, 0
	MOVWF      R0+0
	MOVLW      1
	MOVWF      R6+0
	MOVF       R0+0, 0
L__drawFastHLineInternal111:
	BTFSC      STATUS+0, 2
	GOTO       L__drawFastHLineInternal112
	RLF        R6+0, 1
	BCF        R6+0, 0
	ADDLW      255
	GOTO       L__drawFastHLineInternal111
L__drawFastHLineInternal112:
;MyProject.c,578 :: 		switch (color)
	GOTO       L_drawFastHLineInternal41
;MyProject.c,580 :: 		case WHITE:                 while(w--) { *pBuf++ |= mask; }; break;
L_drawFastHLineInternal43:
L_drawFastHLineInternal44:
	MOVF       FARG_drawFastHLineInternal_w+0, 0
	MOVWF      R0+0
	DECF       FARG_drawFastHLineInternal_w+0, 1
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_drawFastHLineInternal45
	MOVF       R5+0, 0
	MOVWF      FSR
	MOVF       R6+0, 0
	IORWF      INDF+0, 0
	MOVWF      R0+0
	MOVF       R5+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       R5+0, 1
	GOTO       L_drawFastHLineInternal44
L_drawFastHLineInternal45:
	GOTO       L_drawFastHLineInternal42
;MyProject.c,581 :: 		case BLACK: mask = ~mask;   while(w--) { *pBuf++ &= mask; }; break;
L_drawFastHLineInternal46:
	COMF       R6+0, 1
L_drawFastHLineInternal47:
	MOVF       FARG_drawFastHLineInternal_w+0, 0
	MOVWF      R0+0
	DECF       FARG_drawFastHLineInternal_w+0, 1
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_drawFastHLineInternal48
	MOVF       R5+0, 0
	MOVWF      FSR
	MOVF       R6+0, 0
	ANDWF      INDF+0, 0
	MOVWF      R0+0
	MOVF       R5+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       R5+0, 1
	GOTO       L_drawFastHLineInternal47
L_drawFastHLineInternal48:
	GOTO       L_drawFastHLineInternal42
;MyProject.c,582 :: 		case INVERSE:               while(w--) { *pBuf++ ^= mask; }; break;
L_drawFastHLineInternal49:
L_drawFastHLineInternal50:
	MOVF       FARG_drawFastHLineInternal_w+0, 0
	MOVWF      R0+0
	DECF       FARG_drawFastHLineInternal_w+0, 1
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_drawFastHLineInternal51
	MOVF       R5+0, 0
	MOVWF      FSR
	MOVF       R6+0, 0
	XORWF      INDF+0, 0
	MOVWF      R0+0
	MOVF       R5+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       R5+0, 1
	GOTO       L_drawFastHLineInternal50
L_drawFastHLineInternal51:
	GOTO       L_drawFastHLineInternal42
;MyProject.c,583 :: 		}
L_drawFastHLineInternal41:
	MOVF       FARG_drawFastHLineInternal_color+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_drawFastHLineInternal43
	MOVF       FARG_drawFastHLineInternal_color+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_drawFastHLineInternal46
	MOVF       FARG_drawFastHLineInternal_color+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_drawFastHLineInternal49
L_drawFastHLineInternal42:
;MyProject.c,584 :: 		}
L_end_drawFastHLineInternal:
	RETURN
; end of _drawFastHLineInternal

_drawVLine:

;MyProject.c,586 :: 		void drawVLine(uint8_t x, uint8_t y, uint8_t h, uint8_t color) {
;MyProject.c,587 :: 		bool bSwap = false;
	CLRF       drawVLine_bSwap_L0+0
;MyProject.c,588 :: 		switch(rotation) {
	GOTO       L_drawVLine52
;MyProject.c,589 :: 		case 0:
L_drawVLine54:
;MyProject.c,590 :: 		break;
	GOTO       L_drawVLine53
;MyProject.c,591 :: 		case 1:
L_drawVLine55:
;MyProject.c,593 :: 		bSwap = true;
	MOVLW      1
	MOVWF      drawVLine_bSwap_L0+0
;MyProject.c,594 :: 		ssd1306_swap(x, y);
	MOVF       FARG_drawVLine_x+0, 0
	MOVWF      drawVLine_t_L2+0
	MOVF       FARG_drawVLine_y+0, 0
	MOVWF      FARG_drawVLine_x+0
	MOVF       drawVLine_t_L2+0, 0
	MOVWF      FARG_drawVLine_y+0
;MyProject.c,595 :: 		x = SSD1306_LCDWIDTH - x - 1;
	MOVF       FARG_drawVLine_x+0, 0
	SUBLW      128
	MOVWF      FARG_drawVLine_x+0
	DECF       FARG_drawVLine_x+0, 1
;MyProject.c,596 :: 		x -= (h-1);
	DECF       FARG_drawVLine_h+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	SUBWF      FARG_drawVLine_x+0, 1
;MyProject.c,597 :: 		break;
	GOTO       L_drawVLine53
;MyProject.c,598 :: 		case 2:
L_drawVLine56:
;MyProject.c,600 :: 		x = SSD1306_LCDWIDTH - x - 1;
	MOVF       FARG_drawVLine_x+0, 0
	SUBLW      128
	MOVWF      FARG_drawVLine_x+0
	DECF       FARG_drawVLine_x+0, 1
;MyProject.c,601 :: 		y = SSD1306_LCDHEIGHT - y - 1;
	MOVF       FARG_drawVLine_y+0, 0
	SUBLW      64
	MOVWF      FARG_drawVLine_y+0
	DECF       FARG_drawVLine_y+0, 1
;MyProject.c,602 :: 		y -= (h-1);
	DECF       FARG_drawVLine_h+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	SUBWF      FARG_drawVLine_y+0, 1
;MyProject.c,603 :: 		break;
	GOTO       L_drawVLine53
;MyProject.c,604 :: 		case 3:
L_drawVLine57:
;MyProject.c,606 :: 		bSwap = true;
	MOVLW      1
	MOVWF      drawVLine_bSwap_L0+0
;MyProject.c,607 :: 		ssd1306_swap(x, y);
	MOVF       FARG_drawVLine_x+0, 0
	MOVWF      drawVLine_t_L2_L2+0
	MOVF       FARG_drawVLine_y+0, 0
	MOVWF      FARG_drawVLine_x+0
	MOVF       drawVLine_t_L2_L2+0, 0
	MOVWF      FARG_drawVLine_y+0
;MyProject.c,608 :: 		y = SSD1306_LCDHEIGHT - y - 1;
	MOVF       drawVLine_t_L2_L2+0, 0
	SUBLW      64
	MOVWF      FARG_drawVLine_y+0
	DECF       FARG_drawVLine_y+0, 1
;MyProject.c,609 :: 		break;
	GOTO       L_drawVLine53
;MyProject.c,610 :: 		}
L_drawVLine52:
	MOVF       _rotation+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_drawVLine54
	MOVF       _rotation+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_drawVLine55
	MOVF       _rotation+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_drawVLine56
	MOVF       _rotation+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_drawVLine57
L_drawVLine53:
;MyProject.c,612 :: 		if(bSwap) {
	MOVF       drawVLine_bSwap_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_drawVLine58
;MyProject.c,613 :: 		drawFastHLineInternal(x, y, h, color);
	MOVF       FARG_drawVLine_x+0, 0
	MOVWF      FARG_drawFastHLineInternal_x+0
	MOVF       FARG_drawVLine_y+0, 0
	MOVWF      FARG_drawFastHLineInternal_y+0
	MOVF       FARG_drawVLine_h+0, 0
	MOVWF      FARG_drawFastHLineInternal_w+0
	MOVF       FARG_drawVLine_color+0, 0
	MOVWF      FARG_drawFastHLineInternal_color+0
	CALL       _drawFastHLineInternal+0
;MyProject.c,614 :: 		} else {
	GOTO       L_drawVLine59
L_drawVLine58:
;MyProject.c,615 :: 		drawFastVLineInternal(x, y, h, color);
	MOVF       FARG_drawVLine_x+0, 0
	MOVWF      FARG_drawFastVLineInternal_x+0
	MOVF       FARG_drawVLine_y+0, 0
	MOVWF      FARG_drawFastVLineInternal___y+0
	MOVF       FARG_drawVLine_h+0, 0
	MOVWF      FARG_drawFastVLineInternal___h+0
	MOVF       FARG_drawVLine_color+0, 0
	MOVWF      FARG_drawFastVLineInternal_color+0
	CALL       _drawFastVLineInternal+0
;MyProject.c,616 :: 		}
L_drawVLine59:
;MyProject.c,617 :: 		}
L_end_drawVLine:
	RETURN
; end of _drawVLine

_drawFastVLineInternal:

;MyProject.c,619 :: 		void drawFastVLineInternal(uint8_t x, uint8_t __y, uint8_t __h, uint8_t color) {
;MyProject.c,624 :: 		if(x >= SSD1306_LCDWIDTH) { return; }
	MOVLW      128
	SUBWF      FARG_drawFastVLineInternal_x+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_drawFastVLineInternal60
	GOTO       L_end_drawFastVLineInternal
L_drawFastVLineInternal60:
;MyProject.c,627 :: 		if( (__y + __h) > SSD1306_LCDHEIGHT) {
	MOVF       FARG_drawFastVLineInternal___h+0, 0
	ADDWF      FARG_drawFastVLineInternal___y+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__drawFastVLineInternal115
	MOVF       R1+0, 0
	SUBLW      64
L__drawFastVLineInternal115:
	BTFSC      STATUS+0, 0
	GOTO       L_drawFastVLineInternal61
;MyProject.c,628 :: 		__h = (SSD1306_LCDHEIGHT - __y);
	MOVF       FARG_drawFastVLineInternal___y+0, 0
	SUBLW      64
	MOVWF      FARG_drawFastVLineInternal___h+0
;MyProject.c,629 :: 		}
L_drawFastVLineInternal61:
;MyProject.c,633 :: 		h = __h;
	MOVF       FARG_drawFastVLineInternal___h+0, 0
	MOVWF      R10+0
;MyProject.c,636 :: 		pBuf = ssd1306_buffer;
	MOVLW      MyProject_ssd1306_buffer+0
	MOVWF      R8+0
;MyProject.c,638 :: 		pBuf += ((uint16_t)(y/8) * SSD1306_LCDWIDTH);
	MOVF       FARG_drawFastVLineInternal___y+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVF       R0+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	MOVLW      7
	MOVWF      R2+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__drawFastVLineInternal116:
	BTFSC      STATUS+0, 2
	GOTO       L__drawFastVLineInternal117
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__drawFastVLineInternal116
L__drawFastVLineInternal117:
	MOVF       R0+0, 0
	ADDWF      R8+0, 1
;MyProject.c,640 :: 		pBuf += x;
	MOVF       FARG_drawFastVLineInternal_x+0, 0
	ADDWF      R8+0, 1
;MyProject.c,643 :: 		mod = (y&7);
	MOVLW      7
	ANDWF      FARG_drawFastVLineInternal___y+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R9+0
;MyProject.c,644 :: 		if(mod) {
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_drawFastVLineInternal62
;MyProject.c,646 :: 		mod = 8-mod;
	MOVF       R9+0, 0
	SUBLW      8
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      R9+0
;MyProject.c,648 :: 		mask = premask[mod];
	MOVF       R1+0, 0
	ADDLW      drawFastVLineInternal_premask_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R11+0
;MyProject.c,651 :: 		if( h < mod) {
	MOVF       R1+0, 0
	SUBWF      R10+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_drawFastVLineInternal63
;MyProject.c,652 :: 		mask &= (0XFF >> (mod-h));
	MOVF       R10+0, 0
	SUBWF      R9+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      255
	MOVWF      R0+0
	MOVF       R1+0, 0
L__drawFastVLineInternal118:
	BTFSC      STATUS+0, 2
	GOTO       L__drawFastVLineInternal119
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__drawFastVLineInternal118
L__drawFastVLineInternal119:
	MOVF       R0+0, 0
	ANDWF      R11+0, 1
;MyProject.c,653 :: 		}
L_drawFastVLineInternal63:
;MyProject.c,655 :: 		switch (color)
	GOTO       L_drawFastVLineInternal64
;MyProject.c,657 :: 		case WHITE:   *pBuf |=  mask;  break;
L_drawFastVLineInternal66:
	MOVF       R8+0, 0
	MOVWF      FSR
	MOVF       R11+0, 0
	IORWF      INDF+0, 0
	MOVWF      R0+0
	MOVF       R8+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	GOTO       L_drawFastVLineInternal65
;MyProject.c,658 :: 		case BLACK:   *pBuf &= ~mask;  break;
L_drawFastVLineInternal67:
	COMF       R11+0, 0
	MOVWF      R0+0
	MOVF       R8+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ANDWF      R0+0, 1
	MOVF       R8+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	GOTO       L_drawFastVLineInternal65
;MyProject.c,659 :: 		case INVERSE: *pBuf ^=  mask;  break;
L_drawFastVLineInternal68:
	MOVF       R8+0, 0
	MOVWF      FSR
	MOVF       R11+0, 0
	XORWF      INDF+0, 0
	MOVWF      R0+0
	MOVF       R8+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	GOTO       L_drawFastVLineInternal65
;MyProject.c,660 :: 		}
L_drawFastVLineInternal64:
	MOVF       FARG_drawFastVLineInternal_color+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_drawFastVLineInternal66
	MOVF       FARG_drawFastVLineInternal_color+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_drawFastVLineInternal67
	MOVF       FARG_drawFastVLineInternal_color+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_drawFastVLineInternal68
L_drawFastVLineInternal65:
;MyProject.c,663 :: 		if(h<mod) { return; }
	MOVF       R9+0, 0
	SUBWF      R10+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_drawFastVLineInternal69
	GOTO       L_end_drawFastVLineInternal
L_drawFastVLineInternal69:
;MyProject.c,665 :: 		h -= mod;
	MOVF       R9+0, 0
	SUBWF      R10+0, 1
;MyProject.c,667 :: 		pBuf += SSD1306_LCDWIDTH;
	MOVLW      128
	ADDWF      R8+0, 1
;MyProject.c,668 :: 		}
L_drawFastVLineInternal62:
;MyProject.c,672 :: 		if(h >= 8) {
	MOVLW      8
	SUBWF      R10+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_drawFastVLineInternal70
;MyProject.c,673 :: 		if (color == INVERSE)  {          // separate copy of the code so we don't impact performance of the black/white write version with an extra comparison per loop
	MOVF       FARG_drawFastVLineInternal_color+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_drawFastVLineInternal71
;MyProject.c,674 :: 		do  {
L_drawFastVLineInternal72:
;MyProject.c,675 :: 		*pBuf=~(*pBuf);
	MOVF       R8+0, 0
	MOVWF      FSR
	COMF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R8+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;MyProject.c,678 :: 		pBuf += SSD1306_LCDWIDTH;
	MOVLW      128
	ADDWF      R8+0, 1
;MyProject.c,681 :: 		h -= 8;
	MOVLW      8
	SUBWF      R10+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      R10+0
;MyProject.c,682 :: 		} while(h >= 8);
	MOVLW      8
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_drawFastVLineInternal72
;MyProject.c,683 :: 		}
	GOTO       L_drawFastVLineInternal75
L_drawFastVLineInternal71:
;MyProject.c,686 :: 		register uint8_t val = (color == WHITE) ? 255 : 0;
	MOVF       FARG_drawFastVLineInternal_color+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_drawFastVLineInternal76
	MOVLW      255
	MOVWF      R5+0
	GOTO       L_drawFastVLineInternal77
L_drawFastVLineInternal76:
	CLRF       R5+0
L_drawFastVLineInternal77:
	MOVF       R5+0, 0
	MOVWF      R6+0
;MyProject.c,688 :: 		do  {
L_drawFastVLineInternal78:
;MyProject.c,690 :: 		*pBuf = val;
	MOVF       R8+0, 0
	MOVWF      FSR
	MOVF       R6+0, 0
	MOVWF      INDF+0
;MyProject.c,693 :: 		pBuf += SSD1306_LCDWIDTH;
	MOVLW      128
	ADDWF      R8+0, 1
;MyProject.c,696 :: 		h -= 8;
	MOVLW      8
	SUBWF      R10+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      R10+0
;MyProject.c,697 :: 		} while(h >= 8);
	MOVLW      8
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_drawFastVLineInternal78
;MyProject.c,698 :: 		}
L_drawFastVLineInternal75:
;MyProject.c,699 :: 		}
L_drawFastVLineInternal70:
;MyProject.c,702 :: 		if(h) {
	MOVF       R10+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_drawFastVLineInternal81
;MyProject.c,708 :: 		mod = h & 7;
	MOVLW      7
	ANDWF      R10+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R9+0
;MyProject.c,709 :: 		mask = postmask[mod];
	MOVF       R0+0, 0
	ADDLW      drawFastVLineInternal_postmask_L1+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R7+0
;MyProject.c,710 :: 		switch (color)
	GOTO       L_drawFastVLineInternal82
;MyProject.c,712 :: 		case WHITE:   *pBuf |=  mask;  break;
L_drawFastVLineInternal84:
	MOVF       R8+0, 0
	MOVWF      FSR
	MOVF       R7+0, 0
	IORWF      INDF+0, 0
	MOVWF      R0+0
	MOVF       R8+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	GOTO       L_drawFastVLineInternal83
;MyProject.c,713 :: 		case BLACK:   *pBuf &= ~mask;  break;
L_drawFastVLineInternal85:
	COMF       R7+0, 0
	MOVWF      R0+0
	MOVF       R8+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ANDWF      R0+0, 1
	MOVF       R8+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	GOTO       L_drawFastVLineInternal83
;MyProject.c,714 :: 		case INVERSE: *pBuf ^=  mask;  break;
L_drawFastVLineInternal86:
	MOVF       R8+0, 0
	MOVWF      FSR
	MOVF       R7+0, 0
	XORWF      INDF+0, 0
	MOVWF      R0+0
	MOVF       R8+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	GOTO       L_drawFastVLineInternal83
;MyProject.c,715 :: 		}
L_drawFastVLineInternal82:
	MOVF       FARG_drawFastVLineInternal_color+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_drawFastVLineInternal84
	MOVF       FARG_drawFastVLineInternal_color+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_drawFastVLineInternal85
	MOVF       FARG_drawFastVLineInternal_color+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_drawFastVLineInternal86
L_drawFastVLineInternal83:
;MyProject.c,716 :: 		}
L_drawFastVLineInternal81:
;MyProject.c,717 :: 		}
L_end_drawFastVLineInternal:
	RETURN
; end of _drawFastVLineInternal

_main:

;MyProject.c,724 :: 		void main() {
;MyProject.c,726 :: 		TRISIO = 0b000100;
	MOVLW      4
	MOVWF      TRISIO+0
;MyProject.c,727 :: 		GPIO = 0b000000;
	CLRF       GPIO+0
;MyProject.c,728 :: 		CMCON = 0x07;
	MOVLW      7
	MOVWF      CMCON+0
;MyProject.c,729 :: 		INTCON = 0b00000000;
	CLRF       INTCON+0
;MyProject.c,730 :: 		Soft_I2C_Init();
	CALL       _Soft_I2C_Init+0
;MyProject.c,731 :: 		SSD1306_begin(SSD1306_SWITCHCAPVCC, SSD1306_I2C_ADDRESS);
	MOVLW      2
	MOVWF      FARG_SSD1306_begin_vccstate+0
	MOVLW      60
	MOVWF      FARG_SSD1306_begin_i2caddr+0
	CALL       _SSD1306_begin+0
;MyProject.c,732 :: 		display();
	CALL       _display+0
;MyProject.c,733 :: 		delay_ms(2000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main87:
	DECFSZ     R13+0, 1
	GOTO       L_main87
	DECFSZ     R12+0, 1
	GOTO       L_main87
	DECFSZ     R11+0, 1
	GOTO       L_main87
	NOP
	NOP
;MyProject.c,736 :: 		display_clear();
	CALL       _display_clear+0
;MyProject.c,738 :: 		delay_ms(5000);   // wait 5 seconds
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main88:
	DECFSZ     R13+0, 1
	GOTO       L_main88
	DECFSZ     R12+0, 1
	GOTO       L_main88
	DECFSZ     R11+0, 1
	GOTO       L_main88
	NOP
;MyProject.c,740 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
