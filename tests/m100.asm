
; ======================================================
; Reset Vector
; ======================================================
0000H  (C3H) JMP 7D33H      ; Boot routine

0003H  DB   "MENU",00H

; ======================================================
; Compare next byte with M
; ======================================================
0008H  (7EH) MOV A,M
0009H  (E3H) XTHL
000AH  (BEH) CMP M
000BH  (C2H) JNZ 0446H      ; Generate Syntax error
000EH  (23H) INX H
000FH  (E3H) XTHL

; ======================================================
; Get next non-white char from M
; ======================================================
0010H  (C3H) JMP 0858H      ; RST 10H routine with pre-increment of HL

; ======================================================
; Load pointer to Storage of TEXT Line Starts in DE
; ======================================================
0013H  (EBH) XCHG
0014H  (2AH) LHLD F6EBH     ; Storage of TEXT Line Starts
0017H  (EBH) XCHG

; ======================================================
; Compare DE and HL
; ======================================================
0018H  (7CH) MOV A,H        ; Compare MSB first to test <>
0019H  (92H) SUB D          ; Compare with D
001AH  (C0H) RNZ            ; Return if not equal
001BH  (7DH) MOV A,L        ; Prepare to test LSB
001CH  (93H) SUB E          ; Compare with E
001DH  (C9H) RET

; ======================================================
; Send a space to screen/printer
; ======================================================
001EH  (3EH) MVI A,20H      ; Load SPACE into A

; ======================================================
; Send character in A to screen/printer
; ======================================================
0020H  (C3H) JMP 4B44H      ; Send A to screen or printer

0023H  (00H) NOP

; ======================================================
; Power down TRAP
; ======================================================
0024H  (C3H) JMP F602H      ; RAM vector for TRAP interrupt

0027H  (00H) NOP

; ======================================================
; Determine type of last var used
; ======================================================
0028H  (C3H) JMP 1069H      ; RST 28H routine

002BH  (00H) NOP

; ======================================================
; RST 5.5 -- Bar Code Reader
; ======================================================
002CH  (F3H) DI
002DH  (C3H) JMP F5F9H      ; RST 5.5 RAM Vector

; ======================================================
; Get sign of FAC1
; ======================================================
0030H  (C3H) JMP 33DCH      ; RST 30H routine

0033H  (00H) NOP

; ======================================================
; RST 6.5 -- RS232 character pending
; ======================================================
0034H  (F3H) DI
0035H  (C3H) JMP 6DACH      ; RST 6.5 routine (RS232 receive interrupt)

; ======================================================
; RAM vector table driver
; ======================================================
0038H  (C3H) JMP 7FD6H      ; RST 38H RAM vector driver routine

003BH  (00H) NOP

; ======================================================
; RST 7.5 -- Timer background task
; ======================================================
003CH  (F3H) DI
003DH  (C3H) JMP 1B32H      ; RST 7.5 interrupt routine

; ======================================================
; Function vector table for SGN to MID$
; ======================================================
0040H  DW   3407H,3654H,33F2H,2B4CH
0048H  DW   1100H,10C8H,10CEH,305AH
0050H  DW   313EH,2FCFH,30A4H,2EEFH
0058H  DW   2F09H,2F58H,2F71H,1284H
0060H  DW   1889H,506DH,506BH,3501H
0068H  DW   352AH,35BAH,3645H,2943H
0070H  DW   273AH,2A07H,294FH,295FH
0078H  DW   298EH,29ABH,29DCH,29E6H

; ======================================================
; BASIC statement keyword table END to NEW
; ======================================================
0080H  DB   80H or 'E',"ND"        ; 0
0083H  DB   80H or 'F',"OR"
0086H  DB   80H or 'N',"EXT"
008AH  DB   80H or 'D',"ATA"
008EH  DB   80H or 'I',"NPUT" 
0093H  DB   80H or 'D',"IM"        ; 5
0096H  DB   80H or 'R',"EAD"
009AH  DB   80H or 'L',"ET"
009DH  DB   80H or 'G',"OTO"
00A1H  DB   80H or 'R',"UN"    
00A4H  DB   80H or 'I',"F"         ; 10
00A6H  DB   80H or 'R',"ESTORE"
00ADH  DB   80H or 'G',"OSUB"
00B2H  DB   80H or 'R',"ETURN"
00B8H  DB   80H or 'R',"EM"    
00BBH  DB   80H or 'S',"TOP"       ; 15
00BFH  DB   80H or 'W',"IDTH"
00C4H  DB   80H or 'E',"LSE"
00C8H  DB   80H or 'L',"INE"
00CCH  DB   80H or 'E',"DIT"   
00D0H  DB   80H or 'E',"RROR"      ; 20
00D5H  DB   80H or 'R',"ESUME"
00DBH  DB   80H or 'O',"UT"
00DEH  DB   80H or 'O',"N"
00E0H  DB   80H or 'D',"SKO$"   
00E5H  DB   80H or 'O',"PEN"       ; 25
00E9H  DB   80H or 'C',"LOSE"
00EEH  DB   80H or 'L',"OAD"
00F2H  DB   80H or 'M',"ERGE"
00F7H  DB   80H or 'F',"ILES"  
00FCH  DB   80H or 'S',"AVE"       ; 30
0100H  DB   80H or 'L',"FILES"
0106H  DB   80H or 'L',"PRINT"
010CH  DB   80H or 'D',"EF"
010FH  DB   80H or 'P',"OKE"  
0113H  DB   80H or 'P',"RINT"      ; 35
0118H  DB   80H or 'C',"ONT"
011CH  DB   80H or 'L',"IST"
0120H  DB   80H or 'L',"LIST"
0125H  DB   80H or 'C',"LEAR" 
012AH  DB   80H or 'C',"LOAD"      ; 40
012FH  DB   80H or 'C',"SAVE"
0134H  DB   80H or 'T',"IME$"
0139H  DB   80H or 'D',"ATE$"
013EH  DB   80H or 'D',"AY$"  
0142H  DB   80H or 'C',"OM"        ; 45
0145H  DB   80H or 'M',"DM"
0148H  DB   80H or 'K',"EY"
014BH  DB   80H or 'C',"LS"
014EH  DB   80H or 'B',"EEP"  
0152H  DB   80H or 'S',"OUND"      ; 50
0157H  DB   80H or 'L',"COPY"
015CH  DB   80H or 'P',"SET"
0160H  DB   80H or 'P',"RESET"
0166H  DB   80H or 'M',"OTOR"  
016BH  DB   80H or 'M',"AX"        ; 55
016EH  DB   80H or 'P',"OWER"
0173H  DB   80H or 'C',"ALL"
0177H  DB   80H or 'M',"ENU"
017BH  DB   80H or 'I',"PL"   
017EH  DB   80H or 'N',"AME"       ; 60
0182H  DB   80H or 'K',"ILL"
0186H  DB   80H or 'S',"CREEN"
018CH  DB   80H or 'N',"EW"

; ======================================================
; Function keyword table TAB to <
; ======================================================
018FH  DB   80H or 'T',"AB("  
0193H  DB   80H or 'T',"O"         ; 65
0195H  DB   80H or 'U',"SING"
019AH  DB   80H or 'V',"ARPTR"
01A0H  DB   80H or 'E',"RL"        
01A3H  DB   80H or 'E',"RR"
01A6H  DB   80H or 'S',"TRING$"    ; 70
01ADH  DB   80H or 'I',"NSTR"
01B2H  DB   80H or 'D',"SKI$"
01B7H  DB   80H or 'I',"NKEY$"
01BDH  DB   80H or 'C',"SRLIN"
01C3H  DB   80H or 'O',"FF"        ; 75
01C6H  DB   80H or 'H',"IMEM"
01CBH  DB   80H or 'T',"HEN"
01CFH  DB   80H or 'N',"OT"
01D2H  DB   80H or 'S',"TEP"
01D6H  DB   80H or '+'             ; 80
01D7H  DB   80H or '-'
01D8H  DB   80H or '*'
01D9H  DB   80H or '/'
01DAH  DB   80H or '^'
01DBH  DB   80H or 'A',"ND"        ; 85
01DEH  DB   80H or 'O',"R"
01E0H  DB   80H or 'X',"OR"
01E3H  DB   80H or 'E',"QV"
01E6H  DB   80H or 'I',"MP"   
01E9H  DB   80H or 'M',"OD"        ; 90
01ECH  DB   80H or '\'
01EDH  DB   80H or '>'
01EEH  DB   80H or '='
01EFH  DB   80H or '<'


; ======================================================
; Function keyword table SGN to MID$
; ======================================================
01F0H  DB   80H or 'S',"GN"        ; 95
01F3H  DB   80H or 'I',"NT"
01F6H  DB   80H or 'A',"BS"
01F9H  DB   80H or 'F',"RE"
01FCH  DB   80H or 'I',"NP"
01FFH  DB   80H or 'L',"POS"       ; 100
0203H  DB   80H or 'P',"OS"
0206H  DB   80H or 'S',"QR"
0209H  DB   80H or 'R',"ND"
020CH  DB   80H or 'L',"OG"
020FH  DB   80H or 'E',"XP"        ; 105
0212H  DB   80H or 'C',"OS"
0215H  DB   80H or 'S',"IN"
0218H  DB   80H or 'T',"AN"
021BH  DB   80H or 'A',"TN"
021EH  DB   80H or 'P',"EEK"       ; 110
0222H  DB   80H or 'E',"OF"
0225H  DB   80H or 'L',"OC"
0228H  DB   80H or 'L',"OF"
022BH  DB   80H or 'C',"INT"
022FH  DB   80H or 'C',"SNG"       ; 115
0233H  DB   80H or 'C',"DBL"
0237H  DB   80H or 'F',"IX"
023AH  DB   80H or 'L',"EN"
023DH  DB   80H or 'S',"TR$"
0241H  DB   80H or 'V',"AL"        ; 120
0244H  DB   80H or 'A',"SC"
0247H  DB   80H or 'C',"HR$"
024BH  DB   80H or 'S',"PACE$"
0251H  DB   80H or 'L',"EFT$"
0256H  DB   80H or 'R',"IGHT$"     ; 125
025CH  DB   80H or 'M',"ID$"
0260H  DB   80H or "'"             ; 127
0261H  DB   80H

; ======================================================
; BASIC statement vector table for END to NEW
; ======================================================
0262H  DW   409FH,0726H,4174H,099EH
026AH  DW   0CA3H,478BH,0CD9H,09C3H
0272H  DW   0936H,090FH,0B1AH,407FH
027AH  DW   091EH,0966H,09A0H,409AH
0282H  DW   1DC3H,09A0H,0C45H,5E51H
028AH  DW   0B0FH,0AB0H,110CH,0A2FH
0292H  DW   5071H,4CCBH,4E28H,4D70H
029AH  DW   4D71H,1F3AH,4DCFH,506FH
02A2H  DW   0B4EH,0872H,128BH,0B56H
02AAH  DW   40DAH,1140H,113BH,40F9H
02B2H  DW   2377H,2280H,19ABH,19BDH
02BAH  DW   19F1H,1A9EH,1A9EH,1BB8H
02C2H  DW   4231H,4229H,1DC5H,1E5EH
02CAH  DW   1C57H,1C66H,1DECH,7F0BH
02D2H  DW   1419H,1DFAH,5797H,1A78H
02DAH  DW   2037H,1F91H,1E22H,20FEH

; ======================================================
; Operator order of precedence table
; ======================================================
02E2H  DB   79H, 79H, 7CH, 7CH
02E6H  DB   7FH, 50H, 46H, 3CH
02EAH  DB   32H, 28H, 7AH, 7BH
02EEH  DB   BAH, 35H, 00H, 00H

; ======================================================
; Vector table for math operations
; ======================================================
02F2H  DW   3501H,35D9H
02F6H  DW   352AH,2B78H,2B69H,2CFFH
02FEH  DW   2DC7H,3D8EH,34FAH,37F4H
0306H  DW   37FDH,3803H,380EH,3D7FH
030EH  DW   3498H,3704H,36F8H,3725H
0316H  DW   0F0DH,3DF7H,34C2H

; ======================================================
; BASIC error message text
; ======================================================
031CH  DB   "NF"
031EH  DB   "SN"
0320H  DB   "RG"
0322H  DB   "OD"
0324H  DB   "FC"
0326H  DB   "OV"
0328H  DB   "OM"
032AH  DB   "UL"
032CH  DB   "BS"
032EH  DB   "DD"
0330H  DB   "/0"
0332H  DB   "ID"
0334H  DB   "TM"
0336H  DB   "OS"
0338H  DB   "LS"
033AH  DB   "ST"
033CH  DB   "CN"
033EH  DB   "IO"
0340H  DB   "NR"
0342H  DB   "RW"
0344H  DB   "UE"
0346H  DB   "MO"
0348H  DB   "IE"
034AH  DB   "BN"
034CH  DB   "FF"
034EH  DB   "AO"
0350H  DB   "EF"
0352H  DB   "NM"
0354H  DB   "DS"
0356H  DB   "FL"
0358H  DB   "CF"

; ======================================================
; Initialization image loaded to F5F0H by COLD BOOT
; ======================================================
035AH  DB  4DH              ; LSB of COLD vs WARM boot marker (at address F5F0H)
035BH  DB  8AH              ; MSB of COLD vs WARM boot marker
035CH  DB  00H              ; Auto PowerDown signature LSB (at address F5F2H)
035DH  DB  00H              ; Auto PowerDown signature MSB
035EH  DB  F0H              ; LSB of HIMEM (F5F4H)
035FH  DB  F5H              ; MSB of HIMEM
0360H  (C9H) RET            ; This RET can be changed to JMP to hook Boot-up (F5F6H)
0361H  (00H) NOP            ; Space for address for JMP
0362H  (00H) NOP
0363H  (FBH) EI             ; This is the hook for WAND (F5F9H) (RST 5.5)
0364H  (C9H) RET            ; Replace EI, RET, NOP with a JMP instruction
0365H  (00H) NOP
0366H  (C9H) RET            ; This is the RST 6.5 routine (RS232 receive interrupt) hook (F5FCH)
0367H  (00H) NOP            ; Replace RET, NOP, NOP with a JMP instruction
0368H  (00H) NOP
0369H  (C9H) RET            ; This is the RST 7.5 hook (Background tick)  (F5FFH)
036AH  (00H) NOP
036BH  (00H) NOP
036CH  (C3H) JMP 1431H      ; Normal TRAP (low power) interrupt routine - Hook at F602H

; ======================================================
; External ROM detect image loaded at F605H
; ======================================================
036FH  DB   3EH,01H,D3H,E8H,21H,40H,00H,11H  ; F605H - MVI A,01H;  OUT E8H; LXI H,0040H;  LXI D,FAA4H
0377H  DB   A4H,FAH,7EH,12H,23H,13H,7DH,D6H  ; F60DH - MVI A,M;    STAX D;  INX H; INX D; MOV A,L; SUI 48H
037FH  DB   48H,C2H,0FH,F6H,D3H,E8H,2AH,A4H  ; F515H - JNZ F60FH;  OUT E8H; LHLD FAA4H;   
0387H  DB   FAH,11H,54H,43H,C3H,18H,00H,F3H  ; F61DH - LXI D,4354H; JMP 0018H;     DI;
038FH  DB   3EH,01H,D3H,E8H,C7H,00H,01H,00H  ; F625H - MVI A,01H;  OUT E8H; RST 0
0397H  DB   00H,FFH,FFH,00H,00H,00H,00H,00H  ; F62DH \
039FH  DB   00H,00H,00H,00H,01H,01H,08H,28H  ; F635H  \
03A7H  DB   00H,00H,00H,01H,01H,01H,01H,19H  ; F63DH   \
03AFH  DB   28H,00H,00H,00H,50H,38H,30H,00H  ; F645H    \
03B7H  DB   00H,00H,00H,00H,00H,00H,00H,00H  ; F64DH     \ Initialized Data space at F6XXH
03BFH  DB   00H,00H,64H,FFH,00H,00H,4DH,37H  ; F655H    /
03C7H  DB   49H,31H,45H,C3H,00H,00H,00H,C9H  ; F65DH   /
03CFH  DB   00H,C9H,D3H,00H,C9H,DBH,00H,C9H  ; F665H  /
03D7H  DB   3AH,00H,00H,00H,00H,00H,00H,00H  ; F66DH /
03DFH  DB   00H,0EH,00H,15H,FDH,FEH,FFH,B2H  ; F675H
03E7H  DB   FCH,00H,00H

; ======================================================
; BASIC message strings
; ======================================================
03EAH  DB   " Error",00H
03F1H  DB   " in ",00H
03F6H  DB   "Ok",0DH,0AH,00H
03FBH  DB   "Break",00H

; ======================================================
; Pop return address for NEXT or RETURN
; ======================================================
0401H  (21H) LXI H,0004H    ; Prepare to point to BASIC token in stack
0404H  (39H) DAD SP         ; Offset into stack
0405H  (7EH) MOV A,M        ; Load BASIC token that caused the push (FOR or GOSUB)
0406H  (23H) INX H          ; Increment back in stack past token
0407H  (FEH) CPI 81H        ; Test for FOR token
0409H  (C0H) RNZ            ; Return if not FOR token
040AH  (4EH) MOV C,M
040BH  (23H) INX H
040CH  (46H) MOV B,M
040DH  (23H) INX H
040EH  (E5H) PUSH H
040FH  (60H) MOV H,B
0410H  (69H) MOV L,C
0411H  (7AH) MOV A,D
0412H  (B3H) ORA E
0413H  (EBH) XCHG
0414H  (CAH) JZ 0419H
0417H  (EBH) XCHG
0418H  (DFH) RST 3          ; Compare DE and HL
0419H  (01H) LXI B,0016H
041CH  (E1H) POP H
041DH  (C8H) RZ
041EH  (09H) DAD B
041FH  (C3H) JMP 0405H      ; Jump to test next level of FOR/GOSUB

; ======================================================
; Initialize system and go to BASIC ready
; ======================================================
0422H  (01H) LXI B,0501H    ; Pop stack and vector to BASIC ready
0425H  (C3H) JMP 048DH      ; Restore stack & runtime and jump to BC

; ======================================================
; Normal end of program reached
; ======================================================
0428H  (2AH) LHLD F67AH     ; Current executing line number
042BH  (7CH) MOV A,H        ; Get MSB of executing line number
042CH  (A5H) ANA L          ; AND LSB of executing line number
042DH  (3CH) INR A          ; Test if executing line number is FFFFh
042EH  (CAH) JZ 043AH       ; Jump if executing line number is FFFFh
0431H  (3AH) LDA FBA7H      ; BASIC Program Running Flag
0434H  (B7H) ORA A          ; Test if program running
0435H  (1EH) MVI E,13H      ; Load code for NR Error (No RESUME)
0437H  (C2H) JNZ 045DH      ; Generate error in E if program running
043AH  (C3H) JMP 40B6H      ; Branch into middle of "END" statement

; ======================================================
; Never CALLed.  Maybe used by OptROMS?
; ======================================================
043DH  (C3H) JMP 045DH      ; Generate error in E

; ======================================================
; Generate SN error on DATA statement line
; ======================================================
0440H  (2AH) LHLD FB94H     ; Line number of current data statement
0443H  (22H) SHLD F67AH     ; Current executing line number

; ======================================================
; Generate Syntax error
; ======================================================
0446H  (1EH) MVI E,02H      ; Load value for SN Error
0448H  DB  01H
0449H  (1EH) MVI E,0BH      ; Load value for /0 Error
044BH  DB  01H
044CH  (1EH) MVI E,01H      ; Load value for NF Error
044EH  DB  01H
044FH  (1EH) MVI E,0AH      ; Load value for DD Error
0451H  DB  01H
0452H  (1EH) MVI E,14H      ; Load value for RW Error
0454H  DB  01H
0455H  (1EH) MVI E,06H      ; Load value for OV Error
0457H  DB  01H
0458H  (1EH) MVI E,16H      ; Load value for MO Error
045AH  DB  01H
045BH  (1EH) MVI E,0DH      ; Load value for TM Error 

; ======================================================
; Generate error in E
; ======================================================
045DH  (AFH) XRA A
045EH  (32H) STA FCA7H
0461H  (2AH) LHLD F67EH
0464H  (7CH) MOV A,H
0465H  (B5H) ORA L
0466H  (CAH) JZ 0473H
0469H  (3AH) LDA FBE6H
046CH  (77H) MOV M,A
046DH  (21H) LXI H,0000H
0470H  (22H) SHLD F67EH
0473H  (FBH) EI
0474H  (2AH) LHLD F652H     ; Load ON ERROR handler address (may be zero)
0477H  (E5H) PUSH H         ; Push ON ERROR handler address to stack
0478H  (7CH) MOV A,H        ; Get MSB of handler address
0479H  (B5H) ORA L          ; OR with LSB of handler address
047AH  (C0H) RNZ            ; RETurn to handler if not zero
047BH  (2AH) LHLD F67AH     ; Current executing line number
047EH  (22H) SHLD FB9FH     ; Line number of last error
0481H  (7CH) MOV A,H        ; Move LSB of address of line number to A
0482H  (A5H) ANA L          ; AND with MSB of address
0483H  (3CH) INR A          ; Increment it test for FFFFH
0484H  (CAH) JZ 048AH       ; Skip saving as most recent line # if FFFFH
0487H  (22H) SHLD FBA1H     ; Most recent used or entered line number
048AH  (01H) LXI B,0493H    ; Load address of ERROR print routine in BC

; ======================================================
; Restore stack & runtime and jump to BC
; ======================================================
048DH  (2AH) LHLD FB9DH     ; SP used by BASIC to reinitialize the stack
0490H  (C3H) JMP 3F78H

; ======================================================
; Generate Error in E Print routine
; ======================================================
0493H  (C1H) POP B
0494H  (7BH) MOV A,E
0495H  (4BH) MOV C,E
0496H  (32H) STA F672H      ; Last Error code
0499H  (2AH) LHLD FB9BH     ; Most recent or currently running line pointer
049CH  (22H) SHLD FBA3H     ; Pointer to occurrence of error
049FH  (EBH) XCHG
04A0H  (2AH) LHLD FB9FH     ; Line number of last error
04A3H  (7CH) MOV A,H
04A4H  (A5H) ANA L
04A5H  (3CH) INR A
04A6H  (CAH) JZ 04B6H
04A9H  (22H) SHLD FBAAH     ; Line where break, END, or STOP occurred
04ACH  (EBH) XCHG
04ADH  (22H) SHLD FBACH     ; Address where program stopped on last break, END, or STOP
04B0H  (2AH) LHLD FBA5H     ; Address of ON ERROR routine
04B3H  (7CH) MOV A,H
04B4H  (B5H) ORA L
04B5H  (EBH) XCHG
04B6H  (21H) LXI H,FBA7H    ; BASIC Program Running Flag
04B9H  (CAH) JZ 04C5H       ; Print BASIC error message - XX error in XXX
04BCH  (A6H) ANA M
04BDH  (C2H) JNZ 04C5H      ; Print BASIC error message - XX error in XXX
04C0H  (35H) DCR M
04C1H  (EBH) XCHG
04C2H  (C3H) JMP 082BH

; ======================================================
; Print BASIC error message - XX error in XXX
; ======================================================
04C5H  (AFH) XRA A
04C6H  (77H) MOV M,A
04C7H  (59H) MOV E,C
04C8H  (CDH) CALL 4BB8H     ; Move LCD to blank line (send CRLF if needed)
04CBH  (7BH) MOV A,E
04CCH  (FEH) CPI 3BH
04CEH  (D2H) JNC 04DBH
04D1H  (FEH) CPI 32H
04D3H  (D2H) JNC 04DDH
04D6H  (FEH) CPI 17H
04D8H  (DAH) JC 04E0H
04DBH  (3EH) MVI A,30H
04DDH  (D6H) SUI 1BH
04DFH  (5FH) MOV E,A
04E0H  (16H) MVI D,00H
04E2H  (21H) LXI H,031AH    ; BASIC error message text
04E5H  (19H) DAD D
04E6H  (19H) DAD D
04E7H  (3EH) MVI A,3FH
04E9H  (E7H) RST 4          ; Send character in A to screen/printer
04EAH  (7EH) MOV A,M
04EBH  (E7H) RST 4          ; Send character in A to screen/printer
04ECH  (D7H) RST 2          ; Get next non-white char from M
04EDH  (E7H) RST 4          ; Send character in A to screen/printer
04EEH  (21H) LXI H,03EAH    ; BASIC message strings
04F1H  (E5H) PUSH H
04F2H  (2AH) LHLD FB9FH     ; Line number of last error
04F5H  (E3H) XTHL
04F6H  (CDH) CALL 27B1H     ; Print buffer at M until NULL or '"'
04F9H  (E1H) POP H
04FAH  (7CH) MOV A,H
04FBH  (A5H) ANA L
04FCH  (3CH) INR A
04FDH  (C4H) CNZ 39CCH      ; Finish printing BASIC ERROR message " in " line #
0500H  DB    3EH            ; Makes "POP B" below look like "MVI A,C1H"

; ======================================================
; Pop stack and vector to BASIC ready
; ======================================================
0501H  (C1H) POP B          ; Cleanup stack

; ======================================================
; Vector to BASIC ready - print Ok
; ======================================================
0502H  (CDH) CALL 4B92H     ; Reinitialize output back to LCD
0505H  (CDH) CALL 4F45H
0508H  (CDH) CALL 4BB8H     ; Move LCD to blank line (send CRLF if needed)
050BH  (21H) LXI H,03F6H    ; Load pointer to "Ok" text
050EH  (CDH) CALL 27B1H     ; Print buffer at M until NULL or '"'

; ======================================================
; Silent vector to BASIC ready
; ======================================================
0511H  (21H) LXI H,FFFFH    ; Prepare to clear the BASIC executing line number
0514H  (22H) SHLD F67AH     ; Current executing line number
0517H  (21H) LXI H,F66DH
051AH  (22H) SHLD FB9BH     ; Most recent or currently running line pointer
051DH  (CDH) CALL 4644H     ; Input and display (no "?") line and store
0520H  (DAH) JC 0511H       ; Silent vector to BASIC ready

; ======================================================
; Perform operation at M and return to ready
; ======================================================
0523H  (D7H) RST 2          ; Get next non-white char from M
0524H  (3CH) INR A          ; Increment A to test if NULL
0525H  (3DH) DCR A          ; Decrement A to test if NULL (why not just "ANA A"?)
0526H  (CAH) JZ 0511H       ; If at end of string, Silent vector to BASIC ready
0529H  (F5H) PUSH PSW       ; Save A & flags
052AH  (CDH) CALL 08EBH     ; Check for line number - Convert ASCII number at M to binary
052DH  (D2H) JNC 0536H      ; If last character received wasn't ASCII Digit, skip ahead
0530H  (CDH) CALL 421AH     ; Test if address FC8CH is Zero.  WHY???
0533H  (CAH) JZ 0446H       ; Generate Syntax error - Line Integer too big
0536H  (2BH) DCX H          ; Rewind BASIC command pointer 1 byte
0537H  (7EH) MOV A,M        ; Get next byte from BASIC command
0538H  (FEH) CPI 20H        ; Test for SPACE
053AH  (CAH) JZ 0536H       ; Jump back to test previous byte
053DH  (FEH) CPI 09H        ; Test for TAB
053FH  (CAH) JZ 0536H       ; Jump back to test previous byte
0542H  (23H) INX H          ; Point to next byte from BASIC command line
0543H  (7EH) MOV A,M        ; Get next byte from BASIC command line
0544H  (FEH) CPI 20H        ; Test for SPACE
0546H  (CCH) CZ 3457H       ; If SPACE, increment HL and return.  Never keep 1st SPACE
0549H  (D5H) PUSH D
054AH  (CDH) CALL 0646H     ; Perform Token compression
054DH  (D1H) POP D
054EH  (F1H) POP PSW
054FH  (22H) SHLD FB9BH     ; Most recent or currently running line pointer
0552H  (D2H) JNC 4F1CH
0555H  (D5H) PUSH D
0556H  (C5H) PUSH B
0557H  (AFH) XRA A
0558H  (32H) STA FB97H
055BH  (D7H) RST 2          ; Get next non-white char from M
055CH  (B7H) ORA A
055DH  (F5H) PUSH PSW
055EH  (EBH) XCHG
055FH  (22H) SHLD FBA1H     ; Most recent used or entered line number
0562H  (EBH) XCHG
0563H  (CDH) CALL 0628H     ; Find line number in DE
0566H  (DAH) JC 056FH
0569H  (F1H) POP PSW
056AH  (F5H) PUSH PSW
056BH  (CAH) JZ 094DH       ; Generate UL error
056EH  (B7H) ORA A
056FH  (C5H) PUSH B
0570H  (D2H) JNC 0591H
0573H  (CDH) CALL 126CH
0576H  (79H) MOV A,C
0577H  (93H) SUB E
0578H  (4FH) MOV C,A
0579H  (78H) MOV A,B
057AH  (9AH) SBB D
057BH  (47H) MOV B,A
057CH  (2AH) LHLD FBAEH     ; Start of DO files pointer
057FH  (09H) DAD B
0580H  (22H) SHLD FBAEH     ; Start of DO files pointer
0583H  (2AH) LHLD FBB0H     ; Start of CO files pointer
0586H  (09H) DAD B
0587H  (22H) SHLD FBB0H     ; Start of CO files pointer
058AH  (2AH) LHLD FAD8H
058DH  (09H) DAD B
058EH  (22H) SHLD FAD8H
0591H  (D1H) POP D
0592H  (F1H) POP PSW
0593H  (D5H) PUSH D
0594H  (CAH) JZ 05DAH
0597H  (D1H) POP D
0598H  (21H) LXI H,0000H
059BH  (22H) SHLD FBA5H     ; Address of ON ERROR routine
059EH  (2AH) LHLD FBB2H     ; Start of variable data pointer
05A1H  (E3H) XTHL
05A2H  (C1H) POP B
05A3H  (E5H) PUSH H
05A4H  (09H) DAD B
05A5H  (E5H) PUSH H
05A6H  (CDH) CALL 3EF0H
05A9H  (E1H) POP H
05AAH  (22H) SHLD FBB2H     ; Start of variable data pointer
05ADH  (EBH) XCHG
05AEH  (74H) MOV M,H
05AFH  (C1H) POP B
05B0H  (D1H) POP D
05B1H  (E5H) PUSH H
05B2H  (23H) INX H
05B3H  (23H) INX H
05B4H  (73H) MOV M,E
05B5H  (23H) INX H
05B6H  (72H) MOV M,D
05B7H  (23H) INX H
05B8H  (11H) LXI D,F681H    ; Address of temp storage for tokenized line
05BBH  (E5H) PUSH H
05BCH  (2AH) LHLD FBAEH     ; Start of DO files pointer
05BFH  (09H) DAD B
05C0H  (22H) SHLD FBAEH     ; Start of DO files pointer
05C3H  (2AH) LHLD FBB0H     ; Start of CO files pointer
05C6H  (09H) DAD B
05C7H  (22H) SHLD FBB0H     ; Start of CO files pointer
05CAH  (2AH) LHLD FAD8H
05CDH  (09H) DAD B
05CEH  (22H) SHLD FAD8H
05D1H  (E1H) POP H
05D2H  (1AH) LDAX D
05D3H  (77H) MOV M,A
05D4H  (23H) INX H
05D5H  (13H) INX D
05D6H  (B7H) ORA A
05D7H  (C2H) JNZ 05D2H
05DAH  (D1H) POP D
05DBH  (CDH) CALL 05F4H     ; Update line addresses for BASIC program at (DE)
05DEH  (2AH) LHLD FC8CH
05E1H  (22H) SHLD FBA8H
05E4H  (CDH) CALL 3F28H     ; Initialize BASIC Variables for new execution
05E7H  (2AH) LHLD FBA8H
05EAH  (22H) SHLD FC8CH
05EDH  (C3H) JMP 0511H      ; Silent vector to BASIC ready

; ======================================================
; Update line addresses for current BASIC program
; ======================================================
05F0H  (2AH) LHLD F67CH     ; Get Start of BASIC program pointer
05F3H  (EBH) XCHG

; ======================================================
; Update line addresses for BASIC program at (DE)
; ======================================================
05F4H  (62H) MOV H,D
05F5H  (6BH) MOV L,E
05F6H  (7EH) MOV A,M
05F7H  (23H) INX H
05F8H  (B6H) ORA M
05F9H  (C8H) RZ
05FAH  (23H) INX H
05FBH  (23H) INX H
05FCH  (23H) INX H
05FDH  (AFH) XRA A
05FEH  (BEH) CMP M
05FFH  (23H) INX H
0600H  (C2H) JNZ 05FEH
0603H  (EBH) XCHG
0604H  (73H) MOV M,E
0605H  (23H) INX H
0606H  (72H) MOV M,D
0607H  (C3H) JMP 05F4H

; ======================================================
; Evaluate LIST statement arguments
; ======================================================
060AH  (11H) LXI D,0000H
060DH  (D5H) PUSH D
060EH  (CAH) JZ 061BH
0611H  (D1H) POP D
0612H  (CDH) CALL 08E0H     ; Evaluate line number text at M
0615H  (D5H) PUSH D
0616H  (CAH) JZ 0624H
0619H  (CFH) RST 1          ; Compare next byte with M
061AH  DB   D1H
061BH  (11H) LXI D,FFFAH
061EH  (C4H) CNZ 08E0H      ; Evaluate line number text at M
0621H  (C2H) JNZ 0446H      ; Generate Syntax error
0624H  (EBH) XCHG
0625H  (D1H) POP D

; ======================================================
; Find line number in DE (preserve HL on stack)
; ======================================================
0626H  (E3H) XTHL           ; Preserve HL on stack
0627H  (E5H) PUSH H         ; PUSH return address back to stack

; ======================================================
; Find line number in DE
; ======================================================
0628H  (2AH) LHLD F67CH     ; Start of BASIC program pointer

; ======================================================
; Find line number in DE starting at HL
; ======================================================
062BH  (44H) MOV B,H        ; Save HL in BC
062CH  (4DH) MOV C,L        ; Save LSB too
062DH  (7EH) MOV A,M        ; Get LSB of pointer to next BASIC line 
062EH  (23H) INX H          ; Increment to MSB
062FH  (B6H) ORA M          ; OR in MSB with LSB to test for 0000H
0630H  (2BH) DCX H          ; Decrement back to LSB
0631H  (C8H) RZ             ; Return if at end of BASIC program
0632H  (23H) INX H          ; Increment to MSB of pointer to next BASIC program
0633H  (23H) INX H          ; Increment to LSB of line number
0634H  (7EH) MOV A,M        ; Get LSB of line number
0635H  (23H) INX H          ; Increment to MSB of line number
0636H  (66H) MOV H,M        ; Get MSB of line number
0637H  (6FH) MOV L,A        ; Move LSB of line number to HL for comparison
0638H  (DFH) RST 3          ; Compare DE and HL
0639H  (60H) MOV H,B        ; Restore pointer to beginning of this BASIC line
063AH  (69H) MOV L,C        ; Restore LSB of pointer too
063BH  (7EH) MOV A,M        ; Get LSB of next BASIC line number
063CH  (23H) INX H          ; Increment to MSB
063DH  (66H) MOV H,M        ; Get MSB of next BASIC line number
063EH  (6FH) MOV L,A        ; Move LSB to HL
063FH  (3FH) CMC            ; Compliment C to indicate line found
0640H  (C8H) RZ             ; Return if HL = DE. BC will have pointer to line
0641H  (3FH) CMC            ; Indicate line not found
0642H  (D0H) RNC            ; Return if beyond line number being sought
0643H  (C3H) JMP 062BH      ; Find line number in DE starting at HL

; ======================================================
; Perform Token compression
; ======================================================
0646H  (AFH) XRA A          ; Prepare to zero out control vars
0647H  (32H) STA FB66H      ; Zero out DATA statement found marker
064AH  (4FH) MOV C,A        ; Zero out line length
064BH  (11H) LXI D,F681H    ; Pointer to temp storage space for tokenized line

; ======================================================
; Tokenize next character from input string
; ======================================================
064EH  (7EH) MOV A,M        ; Get next byte from input string
064FH  (FEH) CPI 20H        ; Compare with SPACE
0651H  (CAH) JZ 06EAH       ; Save token in A to (DE)
0654H  (47H) MOV B,A        ; Save character to B
0655H  (FEH) CPI 22H        ; Compare with QUOTE
0657H  (CAH) JZ 070FH       ; Jump if QUOTE to copy bytes until QUOTE or EOL
065AH  (B7H) ORA A          ; Test for end of input string
065BH  (CAH) JZ 0716H       ; Exit tokenize loop if end of string
065EH  (23H) INX H          ; Increment to next byte in input string
065FH  (B7H) ORA A          ; Test for non-ASCII characters
0660H  (FAH) JM 064EH       ; Skip byte if non-ASCII (CODE or GRAPH character)
0663H  (2BH) DCX H          ; Decrement back to original byte in input string 
0664H  (3AH) LDA FB66H      ; Load marker if DATA statement active
0667H  (B7H) ORA A          ; Test if DATA statement active
0668H  (7EH) MOV A,M        ; Get next byte from input string
0669H  (C2H) JNZ 06EAH      ; Copy byte to output if DATA statement active
066CH  (FEH) CPI 3FH        ; Compare with '?'
066EH  (3EH) MVI A,A3H      ; Load token for PRINT (convert '?' to PRINT)
0670H  (CAH) JZ 06EAH       ; Save token in A to (DE)
0673H  (7EH) MOV A,M        ; Get next byte from input string
0674H  (FEH) CPI 30H        ; Compare with '0'
0676H  (DAH) JC 067EH       ; Skip ahead if not '0-9'
0679H  (FEH) CPI 3CH        ; Compare with '<'
067BH  (DAH) JC 06EAH       ; Jump to add digit to output if '0-9'
067EH  (D5H) PUSH D         ; Save output pointer on stack
067FH  (11H) LXI D,007FH    ; Point to TOKEN table (-1)
0682H  (C5H) PUSH B         ; Save line length count on stack
0683H  (01H) LXI B,06CDH    ; Load address of routine to ???
0686H  (C5H) PUSH B         ; Push address to stack
0687H  (06H) MVI B,7FH      ; Initialize token number counter
0689H  (7EH) MOV A,M        ; Get next byte from input string
068AH  (FEH) CPI 61H        ; Compare with 'a'
068CH  (DAH) JC 0697H       ; Skip uppercase if not 'a-z'
068FH  (FEH) CPI 7BH        ; Compare with '{'  ('z' + 1)
0691H  (D2H) JNC 0697H      ; Skip uppercase if not 'a-z'
0694H  (E6H) ANI 5FH        ; Make uppercase
0696H  (77H) MOV M,A        ; Save as uppercase
0697H  (4EH) MOV C,M        ; Get next byte (uppercase) from input string in C
0698H  (EBH) XCHG           ; HL now has pointer to Token table
0699H  (23H) INX H          ; Increment to next byte in token table
069AH  (B6H) ORA M          ; Test if this is the 1st byte of a token
069BH  (F2H) JP 0699H       ; Jump back to increment to next byte if not the 1st byte of token
069EH  (04H) INR B          ; Increment the token # counter
069FH  (7EH) MOV A,M        ; Get the next byte from the token table
06A0H  (E6H) ANI 7FH        ; Mask off the 1st byte marker
06A2H  (C8H) RZ             ; Return to our tokenizer return hook if token not found
06A3H  (B9H) CMP C          ; Test if input string byte matches next byte from token table
06A4H  (C2H) JNZ 0699H      ; Skip to next token in table if it doesn't match
06A7H  (EBH) XCHG           ; 1st Char of token found.  Move token table ptr to DE and CMP the rest
06A8H  (E5H) PUSH H         ; Save pointer to input string in case no match with this token
06A9H  (13H) INX D          ; Increment to next byte in token table
06AAH  (1AH) LDAX D         ; Load the next byte from token table
06ABH  (B7H) ORA A          ; Test for token 1st byte marker
06ACH  (FAH) JM 06C9H       ; Jump if 1st byte of next token found = match!
06AFH  (4FH) MOV C,A        ; Save next byte from token table in C
06B0H  (78H) MOV A,B        ; Load the token counter
06B1H  (FEH) CPI 88H        ; Test for GOTO token??
06B3H  (C2H) JNZ 06B8H      ; Skip ahead if GOTO?
06B6H  (D7H) RST 2          ; Skip whitespace after GOTO - Get next non-white char from M
06B7H  (2BH) DCX H          ; Pre-decrement pointer to next byte from input string
06B8H  (23H) INX H          ; Increment to next byte from input string
06B9H  (7EH) MOV A,M        ; Get next byte from input string
06BAH  (FEH) CPI 61H        ; Test if byte >= 'a'
06BCH  (DAH) JC 06C1H       ; Skip uppercase if not >= 'a'
06BFH  (E6H) ANI 5FH        ; Make uppercase
06C1H  (B9H) CMP C          ; Compare byte from input string with next byte from token table
06C2H  (CAH) JZ 06A9H       ; If it matches, jump back to test next byte for this token
06C5H  (E1H) POP H          ; Restore pointer to input string to test next token
06C6H  (C3H) JMP 0697H      ; Jump to test input against next token in table

; ======================================================
; Token match found.  Save token to C and RET to our return hook
; ======================================================
06C9H  (48H) MOV C,B        ; Save token number in C
06CAH  (F1H) POP PSW        ; POP saved pointer to input line
06CBH  (EBH) XCHG           ; Pre-XCHG DE and HL
06CCH  (C9H) RET            ; This returns to our Tokenizer return hook

; ======================================================
; Tokenizer return hook - TOKEN or next non-tokenized byte in C
; ======================================================
06CDH  (EBH) XCHG           ; Exchange DE & HL so HL = input string, DE = token table pointer
06CEH  (79H) MOV A,C        ; Move TOKEN or next byte from input to A
06CFH  (C1H) POP B          ; Restore line length from stack
06D0H  (D1H) POP D          ; Restore output pointer from stack
06D1H  (EBH) XCHG           ; HL=output pointer, DE = input string
06D2H  (FEH) CPI 91H        ; Test for ELSE token 
06D4H  (36H) MVI M,3AH      ; Insert a ":" before ELSE token
06D6H  (C2H) JNZ 06DBH      ; Skip insertion if not ELSE token
06D9H  (0CH) INR C          ; It was ELSE token.  Increment line length
06DAH  (23H) INX H          ; And increment output pointer to keep the ':'
06DBH  (FEH) CPI FFH        ; Test for "'" token (Alternate REM)
06DDH  (C2H) JNZ 06E9H      ; Skip ahead to add token to output if not "'" token
06E0H  (36H) MVI M,3AH      ; Insert a ':REM' before the "'" 
06E2H  (23H) INX H          ; Increment to next output byte
06E3H  (06H) MVI B,8EH      ; Load value for REM token
06E5H  (70H) MOV M,B        ; Save REM token to output
06E6H  (23H) INX H          ; Increment to next output byte
06E7H  (0CH) INR C          ; Increment line length to account for added ':'
06E8H  (0CH) INR C          ; Increment line length to account for added REM token
06E9H  (EBH) XCHG           ; HL=input line, DE = output pointer

; ======================================================
; Save token in A to (DE)
; ======================================================
06EAH  (23H) INX H          ; Increment to next input byte
06EBH  (12H) STAX D         ; Store this token to output (DE)
06ECH  (13H) INX D          ; Increment output pointer
06EDH  (0CH) INR C          ; Increment line length counter
06EEH  (D6H) SUI 3AH        ; Test for ':' token
06F0H  (CAH) JZ 06F8H       ; Jump ahead if ':'
06F3H  (FEH) CPI 49H        ; Test for DATA statement (I think?)
06F5H  (C2H) JNZ 06FBH      ; Skip if not DATA statement
06F8H  (32H) STA FB66H      ; Indicate DATA statement found
06FBH  (D6H) SUI 54H        ; Test for REM statement
06FDH  (CAH) JZ 0705H       ; Jump ahead to save termination marker as NULL if REM
0700H  (D6H) SUI 71H        ; Test for FFh token
0702H  (C2H) JNZ 064EH      ; Jump if not FFh token
0705H  (47H) MOV B,A        ; Save termination marker as NULL (end of string)

; ======================================================
; Copy data directly to (DE) for strings, REM and FFh token
; ======================================================
0706H  (7EH) MOV A,M        ; Get next byte from input string
0707H  (B7H) ORA A          ; Test for NULL termination
0708H  (CAH) JZ 0716H       ; Jump out of loop if end of string
070BH  (B8H) CMP B          ; Compare with termination character (QUOTE or NULL)
070CH  (CAH) JZ 06EAH       ; Jump to Save token if termination char found (QUOTE or NULL)

; ======================================================
; Copy Next byte of string or REM to (DE)
; ======================================================
070FH  (23H) INX H          ; Increment to next input byte
0710H  (12H) STAX D         ; Save this character to (DE) output
0711H  (0CH) INR C          ; Increment line length count
0712H  (13H) INX D          ; Increment output pointer
0713H  (C3H) JMP 0706H      ; Jump to test next byte for termination marker (QUOTE or NULL)

; ======================================================
; End of string to tokenize found.
; ======================================================
0716H  (21H) LXI H,0005H    ; Prepare to add 5 to line length for Address, Line # & termination
0719H  (44H) MOV B,H        ; Zero MSB of BC
071AH  (09H) DAD B          ; Add 5 to line length
071BH  (44H) MOV B,H        ; Save MSB of line length in B
071CH  (4DH) MOV C,L        ; Save LSB of line length in C
071DH  (21H) LXI H,F680H    ; Load pointer to End of statement marker
0720H  (12H) STAX D         ; Store Zero to output - End of line marker
0721H  (13H) INX D          ; Increment output pointer
0722H  (12H) STAX D         ; Store 2nd zero to output - NULL next BASIC line address LSB
0723H  (13H) INX D          ; Increment output pointer
0724H  (12H) STAX D         ; Store 3rd zero to output - NULL next BASIC line address MSB
0725H  (C9H) RET

; ======================================================
; FOR statement
; ======================================================
0726H  (3EH) MVI A,64H
0728H  (32H) STA FB96H      ; FOR/NEXT loop active flag
072BH  (CDH) CALL 09C3H     ; LET statement
072EH  (C1H) POP B
072FH  (E5H) PUSH H
0730H  (CDH) CALL 099EH     ; DATA statement
0733H  (22H) SHLD FB92H
0736H  (21H) LXI H,0002H
0739H  (39H) DAD SP
073AH  (CDH) CALL 0405H
073DH  (C2H) JNZ 0758H
0740H  (09H) DAD B
0741H  (D5H) PUSH D
0742H  (2BH) DCX H
0743H  (56H) MOV D,M
0744H  (2BH) DCX H
0745H  (5EH) MOV E,M
0746H  (23H) INX H
0747H  (23H) INX H
0748H  (E5H) PUSH H
0749H  (2AH) LHLD FB92H
074CH  (DFH) RST 3          ; Compare DE and HL
074DH  (E1H) POP H
074EH  (D1H) POP D
074FH  (C2H) JNZ 073AH
0752H  (D1H) POP D
0753H  (F9H) SPHL
0754H  (22H) SHLD FB9DH     ; Set new BASIC SP restore point for FOR loop
0757H  (0EH) MVI C,D1H
0759H  (EBH) XCHG
075AH  (0EH) MVI C,0CH
075CH  (CDH) CALL 3EFFH     ; Test for 24 byte free in stack space
075FH  (E5H) PUSH H
0760H  (2AH) LHLD FB92H
0763H  (E3H) XTHL
0764H  (E5H) PUSH H
0765H  (2AH) LHLD F67AH     ; Current executing line number
0768H  (E3H) XTHL
0769H  (CFH) RST 1          ; Compare next byte with M
076AH  DB   C1H

; ======================================================
; TO statement
; ======================================================
076BH  (EFH) RST 5          ; Determine type of last var used
076CH  (CAH) JZ 045BH       ; Generate TM error if string
076FH  (F5H) PUSH PSW
0770H  (CDH) CALL 0DABH     ; Main BASIC evaluation routine
0773H  (F1H) POP PSW
0774H  (E5H) PUSH H
0775H  (D2H) JNC 0791H
0778H  (F2H) JP 07C8H
077BH  (CDH) CALL 3501H     ; CINT function
077EH  (E3H) XTHL
077FH  (11H) LXI D,0001H
0782H  (7EH) MOV A,M

; ======================================================
; STEP statement
; ======================================================
0783H  (FEH) CPI CFH
0785H  (CCH) CZ 1112H       ; Evaluate expression at M
0788H  (D5H) PUSH D
0789H  (E5H) PUSH H
078AH  (EBH) XCHG
078BH  (CDH) CALL 341BH
078EH  (C3H) JMP 07EAH

0791H  (CDH) CALL 35BAH     ; CDBL function
0794H  (D1H) POP D
0795H  (21H) LXI H,FFF8H
0798H  (39H) DAD SP
0799H  (F9H) SPHL
079AH  (D5H) PUSH D
079BH  (CDH) CALL 3487H
079EH  (E1H) POP H
079FH  (7EH) MOV A,M
07A0H  (FEH) CPI CFH
07A2H  (11H) LXI D,3286H    ; Load pointer to FP 1.000000000
07A5H  (3EH) MVI A,01H
07A7H  (C2H) JNZ 07B7H
07AAH  (D7H) RST 2          ; Get next non-white char from M
07ABH  (CDH) CALL 0DABH     ; Main BASIC evaluation routine
07AEH  (E5H) PUSH H
07AFH  (CDH) CALL 35BAH     ; CDBL function
07B2H  (F7H) RST 6          ; Get sign of FAC1
07B3H  (11H) LXI D,FC18H    ; Start of FAC1 for single and double precision
07B6H  (E1H) POP H
07B7H  (44H) MOV B,H
07B8H  (4DH) MOV C,L
07B9H  (21H) LXI H,FFF8H
07BCH  (39H) DAD SP
07BDH  (F9H) SPHL
07BEH  (F5H) PUSH PSW
07BFH  (C5H) PUSH B
07C0H  (CDH) CALL 3465H
07C3H  (E1H) POP H
07C4H  (F1H) POP PSW
07C5H  (C3H) JMP 07F1H

07C8H  (CDH) CALL 352AH     ; CSNG function
07CBH  (CDH) CALL 343DH     ; Load single precision FAC1 to BCDE
07CEH  (E1H) POP H
07CFH  (C5H) PUSH B
07D0H  (D5H) PUSH D
07D1H  (01H) LXI B,1041H
07D4H  (11H) LXI D,0000H
07D7H  (7EH) MOV A,M
07D8H  (FEH) CPI CFH
07DAH  (3EH) MVI A,01H
07DCH  (C2H) JNZ 07EBH
07DFH  (CDH) CALL 0DACH
07E2H  (E5H) PUSH H
07E3H  (CDH) CALL 352AH     ; CSNG function
07E6H  (CDH) CALL 343DH     ; Load single precision FAC1 to BCDE
07E9H  (F7H) RST 6          ; Get sign of FAC1
07EAH  (E1H) POP H
07EBH  (D5H) PUSH D
07ECH  (C5H) PUSH B
07EDH  (C5H) PUSH B
07EEH  (C5H) PUSH B
07EFH  (C5H) PUSH B
07F0H  (C5H) PUSH B
07F1H  (B7H) ORA A
07F2H  (C2H) JNZ 07F7H
07F5H  (3EH) MVI A,02H
07F7H  (4FH) MOV C,A
07F8H  (EFH) RST 5          ; Determine type of last var used
07F9H  (47H) MOV B,A
07FAH  (C5H) PUSH B
07FBH  (E5H) PUSH H
07FCH  (2AH) LHLD FB99H     ; Address of last variable assigned
07FFH  (E3H) XTHL
0800H  (06H) MVI B,81H
0802H  (C5H) PUSH B
0803H  (33H) INX SP

; ======================================================
; Execute BASIC program
; ======================================================
0804H  (CDH) CALL 6D6DH     ; Check RS232 queue for pending characters
0807H  (C4H) CNZ 4028H      ; Call routine to process ON COM interrupt
080AH  (3AH) LDA F654H      ; Load pending interrupt (ON KEY/TIME/COM/MDM) count
080DH  (B7H) ORA A          ; Test for pending interrupts to process
080EH  (C4H) CNZ 402BH      ; Call routine to process ON KEY/TIME/COM/MDM interrupts
0811H  (CDH) CALL 13F3H     ; Test for CTRL-C or CTRL-S during BASIC execute
0814H  (22H) SHLD FB9BH     ; Most recent or currently running line pointer
0817H  (EBH) XCHG           ; Store line pointer in DE
0818H  (21H) LXI H,0000H    ; Prepare to get Stack Pointer
081BH  (39H) DAD SP         ; Get Stack Pointer prior to BASIC Inst. execution
081CH  (22H) SHLD FB9DH     ; SP used by BASIC to reinitialize the stack
081FH  (EBH) XCHG           ; Restore line pointer
0820H  (7EH) MOV A,M        ; Get next byte from executing BASIC line
0821H  (FEH) CPI 3AH        ; Test for ":" character - Don't update line number
0823H  (CAH) JZ 083AH       ; Start executing BASIC program at HL - Skip line number update
0826H  (B7H) ORA A
0827H  (C2H) JNZ 0446H      ; Generate Syntax error
082AH  (23H) INX H          ; Point to "Next Line #" pointer to test for end
082BH  (7EH) MOV A,M        ; Get LSB of "Next line #" pointer
082CH  (23H) INX H          ; Point to MSB
082DH  (B6H) ORA M          ; Test if "Next line #" pointer is zero
082EH  (CAH) JZ 0428H       ; Jump to terminate if end of BASIC program
0831H  (23H) INX H          ; Point to LSB of line number
0832H  (5EH) MOV E,M        ; Get LSB of Executing Line number
0833H  (23H) INX H          ; Point to MSB of line number
0834H  (56H) MOV D,M        ; Get MSB of line number
0835H  (EBH) XCHG           ; HL=Line #, DE=Pointer to line
0836H  (22H) SHLD F67AH     ; Current executing line number
0839H  (EBH) XCHG           ; HL=pointer to line, DE=line #

; ======================================================
; Start executing BASIC program at HL
; ======================================================
083AH  (D7H) RST 2          ; Get next non-white char from M
083BH  (11H) LXI D,0804H    ; Address of routine to process next BASIC line
083EH  (D5H) PUSH D         ; Push it to the stack
083FH  (C8H) RZ             ; Return to process next line if end of current line

; ======================================================
; Execute instruction in A, HL points to args
; ======================================================
0840H  (D6H) SUI 80H        ; Subtract 80 from instruction to make it zero based
0842H  (DAH) JC 09C3H       ; LET statement
0845H  (FEH) CPI 40H        ; Test instruction number for bounds
0847H  (D2H) JNC 10F4H      ; Test if command to execute is FEH, generate SN error if not
084AH  (07H) RLC            ; Multiply instruction x2 to get offset in address table
084BH  (4FH) MOV C,A        ; Move inst# x 2 into C for index into table
084CH  (06H) MVI B,00H      ; Clear MSB of command offset
084EH  (EBH) XCHG           ; Save pointer to command parameters in DE
084FH  (21H) LXI H,0262H    ; BASIC statement vector table for END to NEW
0852H  (09H) DAD B          ; Index into command handler address table
0853H  (4EH) MOV C,M        ; Load LSB of command handler address
0854H  (23H) INX H          ; Point to MSB of command handler address
0855H  (46H) MOV B,M        ; Load MSB of command handler address
0856H  (C5H) PUSH B         ; PUSH address of command handler to stack
0857H  (EBH) XCHG           ; Restore pointer to command parameters from DE

; ======================================================
; RST 10H routine with pre-increment of HL
; ======================================================
0858H  (23H) INX H          ; Point to next byte of executing BASIC line

; ======================================================
; RST 10H routine
; ======================================================
0859H  (7EH) MOV A,M        ; Load next byte from command arguments
085AH  (FEH) CPI 3AH        ; Test for ":" command separator
085CH  (D0H) RNC            ; This can "RETurn" to the BASIC statement handler
085DH  (FEH) CPI 20H        ; Test for space after command
085FH  (CAH) JZ 0858H       ; Jump to skip over space
0862H  (FEH) CPI 0BH
0864H  (D2H) JNC 086CH
0867H  (FEH) CPI 09H        ; Test for TAB
0869H  (D2H) JNC 0858H      ; RST 10H routine with pre-increment of HL
086CH  (FEH) CPI 30H        ; Test for '0'
086EH  (3FH) CMC
086FH  (3CH) INR A
0870H  (3DH) DCR A          ; Test for zero in command arguments
0871H  (C9H) RET            ; "Return" to the command handler routine

; ======================================================
; DEF statement
; ======================================================
0872H  (FEH) CPI E0H
0874H  (CAH) JZ 0886H       ; DEFINT statement
0877H  (FEH) CPI 44H
0879H  (C2H) JNZ 088CH
087CH  (D7H) RST 2          ; Get next non-white char from M
087DH  (CFH) RST 1          ; Compare next byte with M
087EH  DB   42H
087FH  (CFH) RST 1          ; Compare next byte with M
0880H  DB   4CH

; ======================================================
; DEFDBL statement
; ======================================================
0881H  (1EH) MVI E,08H
0883H  (C3H) JMP 08A1H      ; Declare variable at M to be type E

; ======================================================
; DEFINT statement
; ======================================================
0886H  (D7H) RST 2          ; Get next non-white char from M
0887H  (1EH) MVI E,02H
0889H  (C3H) JMP 08A1H      ; Declare variable at M to be type E

088CH  (CFH) RST 1          ; Compare next byte with M
088DH  DB   53H
088EH  (FEH) CPI 4EH
0890H  (C2H) JNZ 089BH
0893H  (D7H) RST 2          ; Get next non-white char from M
0894H  (CFH) RST 1          ; Compare next byte with M
0895H  DB   47H

; ======================================================
; DEFSNG statement
; ======================================================
0896H  (1EH) MVI E,04H
0898H  (C3H) JMP 08A1H      ; Declare variable at M to be type E

089BH  (CFH) RST 1          ; Compare next byte with M
089CH  DB   54H
089DH  (CFH) RST 1          ; Compare next byte with M
089EH  DB   52H

; ======================================================
; DEFSTR statement
; ======================================================
089FH  (1EH) MVI E,03H

; ======================================================
; Declare variable at M to be type E
; ======================================================
08A1H  (CDH) CALL 40F1H     ; Check if M is alpha character
08A4H  (01H) LXI B,0446H
08A7H  (C5H) PUSH B
08A8H  (D8H) RC
08A9H  (D6H) SUI 41H
08ABH  (4FH) MOV C,A
08ACH  (47H) MOV B,A
08ADH  (D7H) RST 2          ; Get next non-white char from M
08AEH  (FEH) CPI D1H
08B0H  (C2H) JNZ 08BCH
08B3H  (D7H) RST 2          ; Get next non-white char from M
08B4H  (CDH) CALL 40F1H     ; Check if M is alpha character
08B7H  (D8H) RC
08B8H  (D6H) SUI 41H
08BAH  (47H) MOV B,A
08BBH  (D7H) RST 2          ; Get next non-white char from M
08BCH  (78H) MOV A,B
08BDH  (91H) SUB C
08BEH  (D8H) RC
08BFH  (3CH) INR A
08C0H  (E3H) XTHL
08C1H  (21H) LXI H,FBBAH    ; DEF definition table
08C4H  (06H) MVI B,00H
08C6H  (09H) DAD B
08C7H  (73H) MOV M,E
08C8H  (23H) INX H
08C9H  (3DH) DCR A
08CAH  (C2H) JNZ 08C7H
08CDH  (E1H) POP H
08CEH  (7EH) MOV A,M
08CFH  (FEH) CPI 2CH
08D1H  (C0H) RNZ
08D2H  (D7H) RST 2          ; Get next non-white char from M
08D3H  (C3H) JMP 08A1H      ; Declare variable at M to be type E

08D6H  (D7H) RST 2          ; Get next non-white char from M
08D7H  (CDH) CALL 1113H     ; Evaluate expression at M-1
08DAH  (F0H) RP

; ======================================================
; Generate FC error
; ======================================================
08DBH  (1EH) MVI E,05H      ; Load code for FC Error
08DDH  (C3H) JMP 045DH      ; Generate error in E

; ======================================================
; Evaluate line number text at M
; ======================================================
08E0H  (7EH) MOV A,M
08E1H  (FEH) CPI 2EH
08E3H  (EBH) XCHG
08E4H  (2AH) LHLD FBA1H     ; Most recent used or entered line number
08E7H  (EBH) XCHG
08E8H  (CAH) JZ 0858H       ; RST 10H routine with pre-increment of HL

; ======================================================
; Convert ASCII number at M to binary
; ======================================================
08EBH  (2BH) DCX H

; ======================================================
; Convert ASCII number at M+1 to binary
; ======================================================
08ECH  (11H) LXI D,0000H    ; Initialize value to zero
08EFH  (D7H) RST 2          ; Get next non-white char from M
08F0H  (D0H) RNC            ; Return if not ASCII Digit '0-9'
08F1H  (E5H) PUSH H         ; Save pointer to BASIC command line
08F2H  (F5H) PUSH PSW       ; Save next byte from command line
08F3H  (21H) LXI H,1998H    ; Load value of 65520 / 10
08F6H  (DFH) RST 3          ; Compare DE and HL
08F7H  (DAH) JC 090CH       ; Jump if line # would be too big
08FAH  (62H) MOV H,D        ; Move MSB of current value to H
08FBH  (6BH) MOV L,E        ; Move LSB of current value to L
08FCH  (19H) DAD D          ; x2
08FDH  (29H) DAD H          ; x4
08FEH  (19H) DAD D          ; x5
08FFH  (29H) DAD H          ; x10
0900H  (F1H) POP PSW        ; Restore A (next char) from stack
0901H  (D6H) SUI 30H        ; Convert from ASCII '0-9' to binary
0903H  (5FH) MOV E,A        ; Move to DE to perform 16-bit add
0904H  (16H) MVI D,00H      ; Clear MSB
0906H  (19H) DAD D          ; Add to current value (in HL)
0907H  (EBH) XCHG           ; Put current value back in DE
0908H  (E1H) POP H          ; Restore pointer to BASIC command line
0909H  (C3H) JMP 08EFH      ; Jump to read next character

; ======================================================
; ASCII integer too big.  POP ergs and return.
; ======================================================
090CH  (F1H) POP PSW        ; POP next byte from BASIC command line
090DH  (E1H) POP H          ; POP pointer to BASIC command line
090EH  (C9H) RET

; ======================================================
; RUN statement
; ======================================================
090FH  (CAH) JZ 3F28H       ; Initialize BASIC Variables for new execution
0912H  (D2H) JNC 4D6EH      ; RUN statement
0915H  (CDH) CALL 3F2CH
0918H  (01H) LXI B,0804H
091BH  (C3H) JMP 0935H

; ======================================================
; GOSUB statement
; ======================================================
091EH  (0EH) MVI C,03H      ; Prepare to test for 6 bytes stack space
0920H  (CDH) CALL 3EFFH     ; Test if enough Stack space
0923H  (C1H) POP B
0924H  (E5H) PUSH H
0925H  (E5H) PUSH H
0926H  (2AH) LHLD F67AH     ; Current executing line number
0929H  (E3H) XTHL
092AH  (01H) LXI B,0000H
092DH  (C5H) PUSH B
092EH  (01H) LXI B,0804H
0931H  (3EH) MVI A,8CH
0933H  (F5H) PUSH PSW
0934H  (33H) INX SP
0935H  (C5H) PUSH B

; ======================================================
; GOTO statement
; ======================================================
0936H  (CDH) CALL 08EBH     ; Convert ASCII number at M to binary
0939H  (CDH) CALL 09A0H     ; REM statement
093CH  (23H) INX H
093DH  (E5H) PUSH H
093EH  (2AH) LHLD F67AH     ; Current executing line number
0941H  (DFH) RST 3          ; Compare DE and HL
0942H  (E1H) POP H
0943H  (DCH) CC 062BH       ; Find line number in DE starting at HL
0946H  (D4H) CNC 0628H      ; Find line number in DE
0949H  (60H) MOV H,B
094AH  (69H) MOV L,C
094BH  (2BH) DCX H
094CH  (D8H) RC

; ======================================================
; Generate UL error
; ======================================================
094DH  (1EH) MVI E,08H      ; Load code for UL Error
094FH  (C3H) JMP 045DH      ; Generate error in E

; ======================================================
; GOSUB to BASIC line due to ON KEY/TIME$/MDM/COM
; ======================================================
0952H  (E5H) PUSH H         ; Push line # to Stack
0953H  (E5H) PUSH H         ; Push again to preserve through XTHL
0954H  (2AH) LHLD F67AH     ; Current executing line number
0957H  (E3H) XTHL           ; Put Current line number on Stack.  HL=new line
0958H  (C5H) PUSH B         ; Preserve BC on Stack
0959H  (3EH) MVI A,8CH      ; Load token for GOSUB
095BH  (F5H) PUSH PSW       ; Push GOSUB Token to Stack
095CH  (33H) INX SP         ; Remove flags from Stack.  Keep only GOSUB token
095DH  (EBH) XCHG           ; HL now has pointer to GOSUB line
095EH  (2BH) DCX H          ; Decrement to save as currently running line pointer
095FH  (22H) SHLD FB9BH     ; Most recent or currently running line pointer
0962H  (23H) INX H          ; Increment back to beginning of line
0963H  (C3H) JMP 082BH      ; Jump into Execute BASIC program loop

; ======================================================
; RETURN statement
; ======================================================
0966H  (C0H) RNZ
0967H  (16H) MVI D,FFH
0969H  (CDH) CALL 0401H     ; Pop return address for NEXT or RETURN
096CH  (FEH) CPI 8CH
096EH  (CAH) JZ 0972H
0971H  (2BH) DCX H
0972H  (F9H) SPHL
0973H  (22H) SHLD FB9DH     ; SP used by BASIC to reinitialize the stack
0976H  (1EH) MVI E,03H      ; Load code for RG Error
0978H  (C2H) JNZ 045DH      ; Generate error in E
097BH  (E1H) POP H
097CH  (7CH) MOV A,H
097DH  (B5H) ORA L
097EH  (CAH) JZ 0987H
0981H  (7EH) MOV A,M
0982H  (E6H) ANI 01H
0984H  (C4H) CNZ 3FC7H
0987H  (E1H) POP H
0988H  (22H) SHLD F67AH     ; Current executing line number
098BH  (23H) INX H
098CH  (7CH) MOV A,H
098DH  (B5H) ORA L
098EH  (C2H) JNZ 0998H
0991H  (3AH) LDA FB97H
0994H  (B7H) ORA A
0995H  (C2H) JNZ 0501H      ; Pop stack and vector to BASIC ready
0998H  (21H) LXI H,0804H
099BH  (E3H) XTHL
099CH  (3EH) MVI A,E1H

; ======================================================
; DATA statement
; ======================================================
099EH  (01H) LXI B,0E3AH
09A1H  (00H) NOP
09A2H  (06H) MVI B,00H
09A4H  (79H) MOV A,C
09A5H  (48H) MOV C,B
09A6H  (47H) MOV B,A
09A7H  (7EH) MOV A,M
09A8H  (B7H) ORA A
09A9H  (C8H) RZ
09AAH  (B8H) CMP B
09ABH  (C8H) RZ
09ACH  (23H) INX H
09ADH  (FEH) CPI 22H
09AFH  (CAH) JZ 09A4H
09B2H  (D6H) SUI 8AH
09B4H  (C2H) JNZ 09A7H
09B7H  (B8H) CMP B
09B8H  (8AH) ADC D
09B9H  (57H) MOV D,A
09BAH  (C3H) JMP 09A7H

09BDH  (F1H) POP PSW
09BEH  (C6H) ADI 03H
09C0H  (C3H) JMP 09D6H

; ======================================================
; LET statement
; ======================================================
09C3H  (CDH) CALL 4790H     ; Find address of variable at M
09C6H  (CFH) RST 1          ; Compare next byte with M
09C7H  DB   DDH
09C8H  (EBH) XCHG
09C9H  (22H) SHLD FB99H     ; Address of last variable assigned
09CCH  (EBH) XCHG
09CDH  (D5H) PUSH D
09CEH  (3AH) LDA FB65H      ; Type of last variable used
09D1H  (F5H) PUSH PSW
09D2H  (CDH) CALL 0DABH     ; Main BASIC evaluation routine
09D5H  (F1H) POP PSW
09D6H  (E3H) XTHL
09D7H  (47H) MOV B,A
09D8H  (3AH) LDA FB65H      ; Type of last variable used
09DBH  (B8H) CMP B
09DCH  (78H) MOV A,B
09DDH  (CAH) JZ 09E6H
09E0H  (CDH) CALL 10D7H
09E3H  (3AH) LDA FB65H      ; Type of last variable used
09E6H  (11H) LXI D,FC18H    ; Start of FAC1 for single and double precision
09E9H  (FEH) CPI 02H        ; Test if last variable type was integer
09EBH  (C2H) JNZ 09F1H
09EEH  (11H) LXI D,FC1AH    ; Start of FAC1 for integers
09F1H  (E5H) PUSH H
09F2H  (FEH) CPI 03H
09F4H  (C2H) JNZ 0A29H
09F7H  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
09FAH  (E5H) PUSH H
09FBH  (23H) INX H
09FCH  (5EH) MOV E,M
09FDH  (23H) INX H
09FEH  (56H) MOV D,M
09FFH  (21H) LXI H,F684H
0A02H  (DFH) RST 3          ; Compare DE and HL
0A03H  (DAH) JC 0A1DH
0A06H  (2AH) LHLD FBB6H     ; Unused memory pointer
0A09H  (DFH) RST 3          ; Compare DE and HL
0A0AH  (D1H) POP D
0A0BH  (D2H) JNC 0A25H
0A0EH  (21H) LXI H,FB88H
0A11H  (DFH) RST 3          ; Compare DE and HL
0A12H  (DAH) JC 0A1CH
0A15H  (21H) LXI H,FB6AH
0A18H  (DFH) RST 3          ; Compare DE and HL
0A19H  (DAH) JC 0A25H
0A1CH  (3EH) MVI A,D1H
0A1EH  (CDH) CALL 2935H
0A21H  (EBH) XCHG
0A22H  (CDH) CALL 2747H
0A25H  (CDH) CALL 2935H
0A28H  (E3H) XTHL
0A29H  (CDH) CALL 3465H
0A2CH  (D1H) POP D
0A2DH  (E1H) POP H
0A2EH  (C9H) RET

; ======================================================
; ON statement
; ======================================================
0A2FH  (FEH) CPI 94H
0A31H  (C2H) JNZ 0A5BH      ; ON KEY/TIME/COM/MDM GOSUB routine

; ======================================================
; ON ERROR statement
; ======================================================
0A34H  (D7H) RST 2          ; Get next non-white char from M
0A35H  (CFH) RST 1          ; Compare next byte with M
0A36H  DB   88H
0A37H  (CDH) CALL 08EBH     ; Convert ASCII number at M to binary
0A3AH  (7AH) MOV A,D
0A3BH  (B3H) ORA E
0A3CH  (CAH) JZ 0A48H
0A3FH  (CDH) CALL 0626H     ; Find line number in DE (preserve HL on stack)
0A42H  (50H) MOV D,B
0A43H  (59H) MOV E,C
0A44H  (E1H) POP H          ; Restore HL from stack
0A45H  (D2H) JNC 094DH      ; Generate UL error
0A48H  (EBH) XCHG
0A49H  (22H) SHLD FBA5H     ; Address of ON ERROR routine
0A4CH  (EBH) XCHG
0A4DH  (D8H) RC
0A4EH  (3AH) LDA FBA7H      ; BASIC Program Running Flag
0A51H  (B7H) ORA A
0A52H  (7BH) MOV A,E
0A53H  (C8H) RZ
0A54H  (3AH) LDA F672H      ; Last Error code
0A57H  (5FH) MOV E,A
0A58H  (C3H) JMP 048AH

; ======================================================
; ON KEY/TIME/COM/MDM GOSUB routine
; ======================================================
0A5BH  (CDH) CALL 1AFCH     ; Determine device (KEY/TIME/COM/MDM) for ON GOSUB
0A5EH  (DAH) JC 0A94H       ; Jump if not KEY/TIME/COM/MDM to TIME$ handler
0A61H  (C5H) PUSH B         ; Save device code to stack
0A62H  (D7H) RST 2          ; Get next non-white char from M
0A63H  (CFH) RST 1          ; Compare next byte with M
0A64H  DB   8CH             ;   GOSUB token (or generate SN error)
0A65H  (AFH) XRA A          ; Clear A

; ======================================================
; Loop through all devices for this device type
; ======================================================
0A66H  (C1H) POP B          ; Get device code from stack
0A67H  (C5H) PUSH B         ; Push it back on the stach
0A68H  (B9H) CMP C          ; Compare device count with A
0A69H  (D2H) JNC 0446H      ; Generate Syntax error if device count invalid
0A6CH  (F5H) PUSH PSW       ; Save device count on stack
0A6DH  (CDH) CALL 08EBH     ; Convert ASCII number at M to binary = GOSUB line #
0A70H  (7AH) MOV A,D        ; Prepare to test for line# 0
0A71H  (B3H) ORA E          ; Test for line# 0
0A72H  (CAH) JZ 0A7EH       ; Skip finding line# if it is 0
0A75H  (CDH) CALL 0626H     ; Find line number in DE (preserve HL on stack)
0A78H  (50H) MOV D,B        ; Save MSB of line number address to D
0A79H  (59H) MOV E,C        ; Save LSB of line number address
0A7AH  (E1H) POP H          ; Restore HL from stack
0A7BH  (D2H) JNC 094DH      ; Generate UL error if line not found
0A7EH  (F1H) POP PSW        ; Restore device count from stack
0A7FH  (C1H) POP B          ; Restore device code from stack
0A80H  (F5H) PUSH PSW       ; Push device count to stack
0A81H  (80H) ADD B          ; Calculate device number being accessed (1-10)
0A82H  (C5H) PUSH B         ; Save device code to stack
0A83H  (CDH) CALL 1B22H     ; ON COM handler
0A86H  (2BH) DCX H          ; Decrement BASIC line pointer to test for EOL
0A87H  (D7H) RST 2          ; Get next non-white char from M
0A88H  (C1H) POP B          ; Restore device code from stack
0A89H  (D1H) POP D          ; POP device count (&flags) into DE so we don't clobber flags
0A8AH  (C8H) RZ             ; Return if at end of BASIC line
0A8BH  (C5H) PUSH B         ; Save device code to stack
0A8CH  (D5H) PUSH D         ; Save device count to stack
0A8DH  (CFH) RST 1          ; Compare next byte with M
0A8EH  DB   2CH             ;   ','   - Separator for ON GOSUB x,y,z
0A8FH  (F1H) POP PSW        ; Restore device count from stack
0A90H  (3CH) INR A          ; Increment to next device number (for ON KEY GOSUB)
0A91H  (C3H) JMP 0A66H      ; Jump to process next ON KEY GOSUB entry

; ======================================================
; ON TIME$ handler
; ======================================================
0A94H  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
0A97H  (7EH) MOV A,M
0A98H  (47H) MOV B,A
0A99H  (FEH) CPI 8CH
0A9BH  (CAH) JZ 0AA1H
0A9EH  (CFH) RST 1          ; Compare next byte with M
0A9FH  DB   88H
0AA0H  (2BH) DCX H
0AA1H  (4BH) MOV C,E
0AA2H  (0DH) DCR C
0AA3H  (78H) MOV A,B
0AA4H  (CAH) JZ 0840H       ; Execute instruction in A, HL points to args
0AA7H  (CDH) CALL 08ECH     ; Convert ASCII number at M+1 to binary
0AAAH  (FEH) CPI 2CH
0AACH  (C0H) RNZ
0AADH  (C3H) JMP 0AA2H

; ======================================================
; RESUME statement
; ======================================================
0AB0H  (3AH) LDA FBA7H      ; BASIC Program Running Flag
0AB3H  (B7H) ORA A
0AB4H  (C2H) JNZ 0AC0H
0AB7H  (32H) STA FBA5H      ; Address of ON ERROR routine
0ABAH  (32H) STA FBA6H
0ABDH  (C3H) JMP 0452H      ; Generate RW error

0AC0H  (3CH) INR A
0AC1H  (32H) STA F672H      ; Last Error code
0AC4H  (7EH) MOV A,M
0AC5H  (FEH) CPI 82H
0AC7H  (CAH) JZ 0ADBH
0ACAH  (CDH) CALL 08EBH     ; Convert ASCII number at M to binary
0ACDH  (C0H) RNZ
0ACEH  (7AH) MOV A,D
0ACFH  (B3H) ORA E
0AD0H  (CAH) JZ 0AE0H
0AD3H  (CDH) CALL 0939H
0AD6H  (AFH) XRA A
0AD7H  (32H) STA FBA7H      ; BASIC Program Running Flag
0ADAH  (C9H) RET

0ADBH  (D7H) RST 2          ; Get next non-white char from M
0ADCH  (C0H) RNZ
0ADDH  (C3H) JMP 0AE5H

0AE0H  (AFH) XRA A
0AE1H  (32H) STA FBA7H      ; BASIC Program Running Flag
0AE4H  (3CH) INR A
0AE5H  (2AH) LHLD FBA3H     ; Pointer to occurrence of error
0AE8H  (EBH) XCHG
0AE9H  (2AH) LHLD FB9FH     ; Line number of last error
0AECH  (22H) SHLD F67AH     ; Current executing line number
0AEFH  (EBH) XCHG
0AF0H  (C0H) RNZ
0AF1H  (7EH) MOV A,M
0AF2H  (B7H) ORA A
0AF3H  (C2H) JNZ 0AFAH
0AF6H  (23H) INX H
0AF7H  (23H) INX H
0AF8H  (23H) INX H
0AF9H  (23H) INX H
0AFAH  (23H) INX H
0AFBH  (7AH) MOV A,D
0AFCH  (A3H) ANA E
0AFDH  (3CH) INR A
0AFEH  (C2H) JNZ 0B08H
0B01H  (3AH) LDA FB97H
0B04H  (3DH) DCR A
0B05H  (CAH) JZ 40B3H
0B08H  (AFH) XRA A
0B09H  (32H) STA FBA7H      ; BASIC Program Running Flag
0B0CH  (C3H) JMP 099EH      ; DATA statement

; ======================================================
; ERROR statement
; ======================================================
0B0FH  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
0B12H  (C0H) RNZ
0B13H  (B7H) ORA A
0B14H  (CAH) JZ 08DBH       ; Generate FC error
0B17H  (C3H) JMP 045DH      ; Generate error in E

; ======================================================
; IF statement
; ======================================================
0B1AH  (CDH) CALL 0DABH     ; Main BASIC evaluation routine
0B1DH  (7EH) MOV A,M
0B1EH  (FEH) CPI 2CH
0B20H  (CCH) CZ 0858H       ; RST 10H routine with pre-increment of HL
0B23H  (FEH) CPI 88H
0B25H  (CAH) JZ 0B2BH
0B28H  (CFH) RST 1          ; Compare next byte with M
0B29H  DB   CDH
0B2AH  (2BH) DCX H
0B2BH  (E5H) PUSH H
0B2CH  (CDH) CALL 3411H     ; Determine sign of last variable used
0B2FH  (E1H) POP H
0B30H  (CAH) JZ 0B3AH
0B33H  (D7H) RST 2          ; Get next non-white char from M
0B34H  (DAH) JC 0936H       ; GOTO statement
0B37H  (C3H) JMP 083FH

0B3AH  (16H) MVI D,01H
0B3CH  (CDH) CALL 099EH     ; DATA statement
0B3FH  (B7H) ORA A
0B40H  (C8H) RZ
0B41H  (D7H) RST 2          ; Get next non-white char from M
0B42H  (FEH) CPI 91H
0B44H  (C2H) JNZ 0B3CH
0B47H  (15H) DCR D
0B48H  (C2H) JNZ 0B3CH
0B4BH  (C3H) JMP 0B33H

; ======================================================
; LPRINT statement
; ======================================================
0B4EH  (3EH) MVI A,01H
0B50H  (32H) STA F675H      ; Output device for RST 20H (0=screen)
0B53H  (C3H) JMP 0B60H

; ======================================================
; PRINT statement
; ======================================================
0B56H  (0EH) MVI C,02H
0B58H  (CDH) CALL 4F2BH
0B5BH  (FEH) CPI 40H
0B5DH  (CCH) CZ 1D5FH
0B60H  (2BH) DCX H
0B61H  (D7H) RST 2          ; Get next non-white char from M
0B62H  (CCH) CZ 4BCBH
0B65H  (CAH) JZ 0C39H
0B68H  (FEH) CPI C2H
0B6AH  (CAH) JZ 4991H       ; USING function
0B6DH  (FEH) CPI C0H
0B6FH  (CAH) JZ 0C01H       ; TAB statement
0B72H  (E5H) PUSH H
0B73H  (FEH) CPI 2CH
0B75H  (CAH) JZ 0BCDH
0B78H  (FEH) CPI 3BH
0B7AH  (CAH) JZ 0C34H
0B7DH  (C1H) POP B
0B7EH  (CDH) CALL 0DABH     ; Main BASIC evaluation routine
0B81H  (E5H) PUSH H
0B82H  (EFH) RST 5          ; Determine type of last var used
0B83H  (CAH) JZ 0BC6H
0B86H  (CDH) CALL 39E8H     ; Convert binary number in FAC1 to ASCII at M
0B89H  (CDH) CALL 276BH     ; Search string at M until QUOTE found
0B8CH  (36H) MVI M,20H
0B8EH  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
0B91H  (34H) INR M
0B92H  (CDH) CALL 421AH
0B95H  (C2H) JNZ 0BC2H
0B98H  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
0B9BH  (3AH) LDA F675H      ; Output device for RST 20H (0=screen)
0B9EH  (B7H) ORA A
0B9FH  (CAH) JZ 0BABH
0BA2H  (3AH) LDA F674H      ; Line printer head position
0BA5H  (86H) ADD M
0BA6H  (FEH) CPI FFH
0BA8H  (C3H) JMP 0BB9H

0BABH  (3AH) LDA F63CH      ; Active columns count (1-40)
0BAEH  (47H) MOV B,A
0BAFH  (3CH) INR A
0BB0H  (CAH) JZ 0BC2H
0BB3H  (3AH) LDA F788H      ; Horiz. position of cursor (0-39)
0BB6H  (86H) ADD M
0BB7H  (3DH) DCR A
0BB8H  (B8H) CMP B
0BB9H  (DAH) JC 0BC2H
0BBCH  (CCH) CZ 4BD1H
0BBFH  (C4H) CNZ 4BCBH
0BC2H  (CDH) CALL 27B4H
0BC5H  (B7H) ORA A
0BC6H  (CCH) CZ 27B4H
0BC9H  (E1H) POP H
0BCAH  (C3H) JMP 0B60H

; ======================================================
; 
; ======================================================
0BCDH  (01H) LXI B,0008H
0BD0H  (2AH) LHLD FC8CH
0BD3H  (09H) DAD B
0BD4H  (CDH) CALL 421AH
0BD7H  (7EH) MOV A,M
0BD8H  (C2H) JNZ 0BF8H
0BDBH  (3AH) LDA F675H      ; Output device for RST 20H (0=screen)
0BDEH  (B7H) ORA A
0BDFH  (CAH) JZ 0BEAH       ; Process printing the "," field separator
0BE2H  (3AH) LDA F674H      ; Line printer head position
0BE5H  (FEH) CPI EEH
0BE7H  (C3H) JMP 0BF2H

; ======================================================
; Process comma "," in  PRINT Statement
; ======================================================
0BEAH  (3AH) LDA F676H      ; Get COL of last field for comma separation in PRINT
0BEDH  (47H) MOV B,A        ; Save in B
0BEEH  (3AH) LDA F788H      ; Horiz. position of cursor (0-39)
0BF1H  (B8H) CMP B          ; Compare with 0EH or value from DVI calculation
0BF2H  (D4H) CNC 4BCBH      ; If not beyond last field, then 
0BF5H  (D2H) JNC 0C34H      ; Jump to print next item from PRINT statement if it fits
0BF8H  (D6H) SUI 0EH        ; Subtract 14 (comma field width)
0BFAH  (D2H) JNC 0BF8H      ; Keep subtracting until negative
0BFDH  (2FH) CMA            ; 1's compliement the remainder
0BFEH  (C3H) JMP 0C2BH

; ======================================================
; TAB statement
; ======================================================
0C01H  (CDH) CALL 112DH     ; Evaluate expression at M
0C04H  (CFH) RST 1          ; Compare next byte with M
0C05H  DB   29H
0C06H  (2BH) DCX H
0C07H  (E5H) PUSH H
0C08H  (01H) LXI B,0008H
0C0BH  (2AH) LHLD FC8CH
0C0EH  (09H) DAD B
0C0FH  (CDH) CALL 421AH
0C12H  (7EH) MOV A,M
0C13H  (C2H) JNZ 0C26H
0C16H  (3AH) LDA F675H      ; Output device for RST 20H (0=screen)
0C19H  (B7H) ORA A
0C1AH  (CAH) JZ 0C23H
0C1DH  (3AH) LDA F674H      ; Line printer head position
0C20H  (C3H) JMP 0C26H

; ======================================================
; Process TAB printed to SCREEN
; ======================================================
0C23H  (3AH) LDA F788H      ; Horiz. position of cursor (0-39)
0C26H  (2FH) CMA
0C27H  (83H) ADD E
0C28H  (D2H) JNC 0C34H

; ======================================================
; Send A spaces to screen / printer to process TAB or "," in PRINT
; ======================================================
0C2BH  (3CH) INR A          ; Pre-increment count
0C2CH  (47H) MOV B,A        ; Save count in B
0C2DH  (3EH) MVI A,20H      ; Load ASCII code for SPACE
0C2FH  (E7H) RST 4          ; Send character in A to screen/printer
0C30H  (05H) DCR B          ; Decrement counter
0C31H  (C2H) JNZ 0C2FH      ; Keep sending until zero

; ======================================================
; Prepare to process next item to print from PRINT statement
; ======================================================
0C34H  (E1H) POP H          ; Stack cleanup
0C35H  (D7H) RST 2          ; Get next non-white char from M
0C36H  (C3H) JMP 0B65H      ; Jump into PRINT statement to print next item

0C39H  (AFH) XRA A
0C3AH  (32H) STA F675H      ; Output device for RST 20H (0=screen)
0C3DH  (E5H) PUSH H
0C3EH  (67H) MOV H,A
0C3FH  (6FH) MOV L,A
0C40H  (22H) SHLD FC8CH
0C43H  (E1H) POP H
0C44H  (C9H) RET

; ======================================================
; LINE statement
; ======================================================
0C45H  (FEH) CPI 84H
0C47H  (C2H) JNZ 1C6DH      ; LINE statement
0C4AH  (D7H) RST 2          ; Get next non-white char from M
0C4BH  (FEH) CPI 23H
0C4DH  (CAH) JZ 4F5BH       ; LINE INPUT # statement
0C50H  (CDH) CALL 10E6H     ; Check for running program
0C53H  (7EH) MOV A,M
0C54H  (CDH) CALL 0CB4H
0C57H  (CDH) CALL 4790H     ; Find address of variable at M
0C5AH  (CDH) CALL 35D9H     ; Generate TM error if last variable type not string or RET
0C5DH  (D5H) PUSH D
0C5EH  (E5H) PUSH H
0C5FH  (CDH) CALL 4644H     ; Input and display (no "?") line and store
0C62H  (D1H) POP D
0C63H  (C1H) POP B
0C64H  (DAH) JC 40B3H
0C67H  (C5H) PUSH B
0C68H  (D5H) PUSH D
0C69H  (06H) MVI B,00H
0C6BH  (CDH) CALL 276EH
0C6EH  (E1H) POP H
0C6FH  (3EH) MVI A,03H
0C71H  (C3H) JMP 09D6H

0C74H  DB   "?Redo from start",0DH,0AH,00H

0C87H  (3AH) LDA FB98H
0C8AH  (B7H) ORA A
0C8BH  (C2H) JNZ 0440H      ; Jump to generate SN error on DATA statement line
0C8EH  (C1H) POP B
0C8FH  (21H) LXI H,0C74H    ; Load pointer to "?Redo from start" text
0C92H  (CDH) CALL 27B1H     ; Print buffer at M until NULL or '"'
0C95H  (2AH) LHLD FB9BH     ; Most recent or currently running line pointer
0C98H  (C9H) RET

; ======================================================
; INPUT # statement
; ======================================================
0C99H  (CDH) CALL 4F29H
0C9CH  (E5H) PUSH H
0C9DH  (21H) LXI H,F684H
0CA0H  (C3H) JMP 0CD4H

; ======================================================
; INPUT statement
; ======================================================
0CA3H  (CDH) CALL 10E6H     ; Check for running program
0CA6H  (7EH) MOV A,M
0CA7H  (FEH) CPI 23H
0CA9H  (CAH) JZ 0C99H       ; INPUT # statement
0CACH  (CDH) CALL 10E6H     ; Check for running program
0CAFH  (7EH) MOV A,M
0CB0H  (01H) LXI B,0CC4H
0CB3H  (C5H) PUSH B
0CB4H  (FEH) CPI 22H
0CB6H  (3EH) MVI A,00H
0CB8H  (C0H) RNZ
0CB9H  (CDH) CALL 276CH
0CBCH  (CFH) RST 1          ; Compare next byte with M
0CBDH  DB   3BH
0CBEH  (E5H) PUSH H
0CBFH  (CDH) CALL 27B4H
0CC2H  (E1H) POP H
0CC3H  (C9H) RET

0CC4H  (E5H) PUSH H
0CC5H  (CDH) CALL 463EH     ; Input and display line and store
0CC8H  (C1H) POP B
0CC9H  (DAH) JC 40B3H
0CCCH  (23H) INX H
0CCDH  (7EH) MOV A,M
0CCEH  (B7H) ORA A
0CCFH  (2BH) DCX H
0CD0H  (C5H) PUSH B
0CD1H  (CAH) JZ 099DH
0CD4H  (36H) MVI M,2CH
0CD6H  (C3H) JMP 0CDEH

; ======================================================
; READ statement
; ======================================================
0CD9H  (E5H) PUSH H
0CDAH  (2AH) LHLD FBB8H     ; Address where DATA search will begin next
0CDDH  (F6H) ORI AFH
0CDFH  (32H) STA FB98H
0CE2H  (E3H) XTHL
0CE3H  (C3H) JMP 0CE8H

0CE6H  (CFH) RST 1          ; Compare next byte with M
0CE7H  DB   2CH
0CE8H  (CDH) CALL 4790H     ; Find address of variable at M
0CEBH  (E3H) XTHL
0CECH  (D5H) PUSH D
0CEDH  (7EH) MOV A,M
0CEEH  (FEH) CPI 2CH
0CF0H  (CAH) JZ 0D0EH
0CF3H  (3AH) LDA FB98H
0CF6H  (B7H) ORA A
0CF7H  (C2H) JNZ 0D82H
0CFAH  (3EH) MVI A,3FH
0CFCH  (E7H) RST 4          ; Send character in A to screen/printer
0CFDH  (CDH) CALL 463EH     ; Input and display line and store
0D00H  (D1H) POP D
0D01H  (C1H) POP B
0D02H  (DAH) JC 40B3H
0D05H  (23H) INX H
0D06H  (7EH) MOV A,M
0D07H  (2BH) DCX H
0D08H  (B7H) ORA A
0D09H  (C5H) PUSH B
0D0AH  (CAH) JZ 099DH
0D0DH  (D5H) PUSH D
0D0EH  (CDH) CALL 421AH
0D11H  (C2H) JNZ 4F4DH
0D14H  (EFH) RST 5          ; Determine type of last var used
0D15H  (F5H) PUSH PSW
0D16H  (C2H) JNZ 0D3DH
0D19H  (D7H) RST 2          ; Get next non-white char from M
0D1AH  (57H) MOV D,A
0D1BH  (47H) MOV B,A
0D1CH  (FEH) CPI 22H
0D1EH  (CAH) JZ 0D2EH
0D21H  (3AH) LDA FB98H
0D24H  (B7H) ORA A
0D25H  (57H) MOV D,A
0D26H  (CAH) JZ 0D2BH
0D29H  (16H) MVI D,3AH
0D2BH  (06H) MVI B,2CH
0D2DH  (2BH) DCX H
0D2EH  (CDH) CALL 276FH
0D31H  (F1H) POP PSW
0D32H  (C6H) ADI 03H
0D34H  (EBH) XCHG
0D35H  (21H) LXI H,0D45H
0D38H  (E3H) XTHL
0D39H  (D5H) PUSH D
0D3AH  (C3H) JMP 09D7H

0D3DH  (D7H) RST 2          ; Get next non-white char from M
0D3EH  (01H) LXI B,0D31H
0D41H  (C5H) PUSH B
0D42H  (C3H) JMP 3840H      ; Convert ASCII number at M to double precision in FAC1

0D45H  (2BH) DCX H
0D46H  (D7H) RST 2          ; Get next non-white char from M
0D47H  (CAH) JZ 0D4FH
0D4AH  (FEH) CPI 2CH
0D4CH  (C2H) JNZ 0C87H
0D4FH  (E3H) XTHL
0D50H  (2BH) DCX H
0D51H  (D7H) RST 2          ; Get next non-white char from M
0D52H  (C2H) JNZ 0CE6H
0D55H  (D1H) POP D
0D56H  (3AH) LDA FB98H
0D59H  (B7H) ORA A
0D5AH  (EBH) XCHG
0D5BH  (C2H) JNZ 4095H
0D5EH  (D5H) PUSH D
0D5FH  (CDH) CALL 421AH
0D62H  (C2H) JNZ 0D6DH
0D65H  (7EH) MOV A,M
0D66H  (B7H) ORA A
0D67H  (21H) LXI H,0D71H    ; Load pointer to "?Extra ignored" text
0D6AH  (C4H) CNZ 27B1H      ; Print buffer at M until NULL or '"'
0D6DH  (E1H) POP H
0D6EH  (C3H) JMP 0C39H

0D71H  DB   "?Extra ignored",0DH,0AH,00H

0D82H  (CDH) CALL 099EH     ; DATA statement
0D85H  (B7H) ORA A
0D86H  (C2H) JNZ 0D9BH
0D89H  (23H) INX H
0D8AH  (7EH) MOV A,M
0D8BH  (23H) INX H
0D8CH  (B6H) ORA M
0D8DH  (1EH) MVI E,04H      ; Load code for OD Error (Out of Data)
0D8FH  (CAH) JZ 045DH       ; Generate error in E
0D92H  (23H) INX H
0D93H  (5EH) MOV E,M
0D94H  (23H) INX H
0D95H  (56H) MOV D,M
0D96H  (EBH) XCHG
0D97H  (22H) SHLD FB94H     ; Line number of current data statement
0D9AH  (EBH) XCHG
0D9BH  (D7H) RST 2          ; Get next non-white char from M
0D9CH  (FEH) CPI 83H
0D9EH  (C2H) JNZ 0D82H
0DA1H  (C3H) JMP 0D0EH

0DA4H  (CFH) RST 1          ; Compare next byte with M
0DA5H  DB   DDH
0DA6H  (C3H) JMP 0DABH      ; Main BASIC evaluation routine

0DA9H  (CFH) RST 1          ; Compare next byte with M
0DAAH  DB   28H

; ======================================================
; Main BASIC evaluation routine
;
; During evaluation, order of precedence of operators is honored
; by PUSHing function handlers to the stack.  Then they are
; unwound to be handled in the proper order.
; ======================================================
0DABH  (2BH) DCX H
0DACH  (16H) MVI D,00H
0DAEH  (D5H) PUSH D
0DAFH  (0EH) MVI C,01H      ; Prepare to test for 2 bytes free stack space
0DB1H  (CDH) CALL 3EFFH     ; Test for 2 bytes free in stack space
0DB4H  (CDH) CALL 0F1CH     ; Evaluate function at M
0DB7H  (22H) SHLD FBA8H     ; Save new pointer to input string
0DBAH  (2AH) LHLD FBA8H     ; Restore pointer to input string
0DBDH  (C1H) POP B
0DBEH  (7EH) MOV A,M        ; Get next token from input
0DBFH  (22H) SHLD FB8EH     ; Save new pointer to input string
0DC2H  (FEH) CPI D0H        ; Compare token with '+'
0DC4H  (D8H) RC             ; RETurn to perform next level of precedence operation           
0DC5H  (FEH) CPI DFH        ; Compare with "SGN" function
0DC7H  (D0H) RNC            ; RETurn to perform next level of precedence operation
0DC8H  (FEH) CPI DCH        ; Compare with '>'
0DCAH  (D2H) JNC 0E29H      ; Jump to handle '>', '=', '<' operators
0DCDH  (D6H) SUI D0H        ; Make operator token zero based
0DCFH  (5FH) MOV E,A        ; Save zero-based operator token in E
0DD0H  (C2H) JNZ 0DDCH      ; Skip string concatenation test if not '+' token
0DD3H  (3AH) LDA FB65H      ; Type of last variable used
0DD6H  (FEH) CPI 03H        ; Test if last type was String
0DD8H  (7BH) MOV A,E        ; Copy token to A
0DD9H  (CAH) JZ 28CCH       ; Jump (to string concat?) if last variable type was string

; ======================================================
; Perform mathematic operation
; ======================================================
0DDCH  (21H) LXI H,02E2H    ; Load pointer to operator order of precedence table maybe?
0DDFH  (16H) MVI D,00H      ; Make MSB of operator token zero
0DE1H  (19H) DAD D          ; Index into order of precedence table
0DE2H  (78H) MOV A,B
0DE3H  (56H) MOV D,M        ; Get order of precedence from table
0DE4H  (BAH) CMP D
0DE5H  (D0H) RNC
0DE6H  (C5H) PUSH B
0DE7H  (01H) LXI B,0DBAH
0DEAH  (C5H) PUSH B
0DEBH  (7AH) MOV A,D
0DECH  (FEH) CPI 51H
0DEEH  (DAH) JC 0E45H
0DF1H  (E6H) ANI FEH
0DF3H  (FEH) CPI 7AH
0DF5H  (CAH) JZ 0E45H
0DF8H  (21H) LXI H,FC1AH    ; Start of FAC1 for integers
0DFBH  (3AH) LDA FB65H      ; Type of last variable used
0DFEH  (D6H) SUI 03H        ; Test if last type was String
0E00H  (CAH) JZ 045BH       ; Generate TM error
0E03H  (B7H) ORA A
0E04H  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
0E07H  (E5H) PUSH H
0E08H  (FAH) JM 0E1AH
0E0BH  (2AH) LHLD FC18H     ; Start of FAC1 for single and double precision
0E0EH  (E5H) PUSH H
0E0FH  (E2H) JPO 0E1AH
0E12H  (2AH) LHLD FC1EH
0E15H  (E5H) PUSH H
0E16H  (2AH) LHLD FC1CH
0E19H  (E5H) PUSH H
0E1AH  (C6H) ADI 03H
0E1CH  (4BH) MOV C,E
0E1DH  (47H) MOV B,A
0E1EH  (C5H) PUSH B
0E1FH  (01H) LXI B,0E6CH    ; Load pointer to ??? operation vector

; ======================================================
; PUSH operator vector and continue evaluation
; ======================================================
0E22H  (C5H) PUSH B         ; PUSH operation vector to RETurn to later
0E23H  (2AH) LHLD FB8EH     ; Restore pointer to input string
0E26H  (C3H) JMP 0DAEH      ; Jump to continue evaluation

; ======================================================
; Handle '>', '=', '<' operators in expression
; ======================================================
0E29H  (16H) MVI D,00H
0E2BH  (D6H) SUI DCH
0E2DH  (DAH) JC 0E51H
0E30H  (FEH) CPI 03H
0E32H  (D2H) JNC 0E51H
0E35H  (FEH) CPI 01H
0E37H  (17H) RAL
0E38H  (AAH) XRA D
0E39H  (BAH) CMP D
0E3AH  (57H) MOV D,A
0E3BH  (DAH) JC 0446H       ; Generate Syntax error
0E3EH  (22H) SHLD FB8EH
0E41H  (D7H) RST 2          ; Get next non-white char from M
0E42H  (C3H) JMP 0E2BH

0E45H  (D5H) PUSH D
0E46H  (CDH) CALL 3501H     ; CINT function
0E49H  (D1H) POP D
0E4AH  (E5H) PUSH H
0E4BH  (01H) LXI B,1072H    ; Load pointer to vector for handling logic functions
0E4EH  (C3H) JMP 0E22H      ; PUSH operator vector and continue evaluation

0E51H  (78H) MOV A,B
0E52H  (FEH) CPI 64H
0E54H  (D0H) RNC
0E55H  (C5H) PUSH B
0E56H  (D5H) PUSH D
0E57H  (11H) LXI D,6405H
0E5AH  (21H) LXI H,1047H
0E5DH  (E5H) PUSH H
0E5EH  (EFH) RST 5          ; Determine type of last var used
0E5FH  (C2H) JNZ 0DF8H
0E62H  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
0E65H  (E5H) PUSH H
0E66H  (01H) LXI B,270CH
0E69H  (C3H) JMP 0E22H      ; PUSH operator vector and continue evaluation

0E6CH  (C1H) POP B
0E6DH  (79H) MOV A,C
0E6EH  (32H) STA FB66H
0E71H  (3AH) LDA FB65H      ; Type of last variable used
0E74H  (B8H) CMP B          ; Test if last type matches type from Stack
0E75H  (C2H) JNZ 0E85H
0E78H  (FEH) CPI 02H        ; Test if last type as integer
0E7AH  (CAH) JZ 0EA1H
0E7DH  (FEH) CPI 04H        ; Test if last type was Single Precision
0E7FH  (CAH) JZ 0EF0H
0E82H  (D2H) JNC 0EB4H
0E85H  (57H) MOV D,A
0E86H  (78H) MOV A,B
0E87H  (FEH) CPI 08H
0E89H  (CAH) JZ 0EB1H
0E8CH  (7AH) MOV A,D
0E8DH  (FEH) CPI 08H        ; Test if last variable type was Double Precision
0E8FH  (CAH) JZ 0ED8H
0E92H  (78H) MOV A,B
0E93H  (FEH) CPI 04H
0E95H  (CAH) JZ 0EEDH
0E98H  (7AH) MOV A,D
0E99H  (FEH) CPI 03H        ; Test if last variable type was String
0E9BH  (CAH) JZ 045BH       ; Generate TM error
0E9EH  (D2H) JNC 0EF8H
0EA1H  (21H) LXI H,0310H
0EA4H  (06H) MVI B,00H
0EA6H  (09H) DAD B
0EA7H  (09H) DAD B
0EA8H  (4EH) MOV C,M
0EA9H  (23H) INX H
0EAAH  (46H) MOV B,M
0EABH  (D1H) POP D
0EACH  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
0EAFH  (C5H) PUSH B
0EB0H  (C9H) RET

0EB1H  (CDH) CALL 35BAH     ; CDBL function
0EB4H  (CDH) CALL 3484H     ; Copy FAC1 to FAC2
0EB7H  (E1H) POP H
0EB8H  (22H) SHLD FC1CH
0EBBH  (E1H) POP H
0EBCH  (22H) SHLD FC1EH
0EBFH  (C1H) POP B
0EC0H  (D1H) POP D
0EC1H  (CDH) CALL 3432H     ; Load single precision in BCDE to FAC1
0EC4H  (CDH) CALL 35BAH     ; CDBL function
0EC7H  (21H) LXI H,02F8H
0ECAH  (3AH) LDA FB66H
0ECDH  (07H) RLC
0ECEH  (85H) ADD L
0ECFH  (6FH) MOV L,A
0ED0H  (8CH) ADC H
0ED1H  (95H) SUB L
0ED2H  (67H) MOV H,A
0ED3H  (7EH) MOV A,M
0ED4H  (23H) INX H
0ED5H  (66H) MOV H,M
0ED6H  (6FH) MOV L,A
0ED7H  (E9H) PCHL

0ED8H  (78H) MOV A,B
0ED9H  (F5H) PUSH PSW
0EDAH  (CDH) CALL 3484H     ; Copy FAC1 to FAC2
0EDDH  (F1H) POP PSW
0EDEH  (32H) STA FB65H      ; Type of last variable used
0EE1H  (FEH) CPI 04H        ; Test if last type was Single Precision
0EE3H  (CAH) JZ 0EBFH
0EE6H  (E1H) POP H
0EE7H  (22H) SHLD FC1AH     ; Start of FAC1 for integers
0EEAH  (C3H) JMP 0EC4H

0EEDH  (CDH) CALL 352AH     ; CSNG function
0EF0H  (C1H) POP B
0EF1H  (D1H) POP D
0EF2H  (21H) LXI H,0304H
0EF5H  (C3H) JMP 0ECAH

0EF8H  (E1H) POP H
0EF9H  (CDH) CALL 3422H     ; Push single precision FAC1 on stack
0EFCH  (CDH) CALL 3543H     ; Convert signed integer HL to single precision FAC1
0EFFH  (CDH) CALL 343DH     ; Load single precision FAC1 to BCDE
0F02H  (E1H) POP H
0F03H  (22H) SHLD FC18H     ; Start of FAC1 for single and double precision
0F06H  (E1H) POP H
0F07H  (22H) SHLD FC1AH     ; Start of FAC1 for integers
0F0AH  (C3H) JMP 0EF2H

; ======================================================
; Integer Divide FAC1=DE/HL
; ======================================================
0F0DH  (E5H) PUSH H
0F0EH  (EBH) XCHG
0F0FH  (CDH) CALL 3543H     ; Convert signed integer HL to single precision FAC1
0F12H  (E1H) POP H
0F13H  (CDH) CALL 3422H     ; Push single precision FAC1 on stack
0F16H  (CDH) CALL 3543H     ; Convert signed integer HL to single precision FAC1
0F19H  (C3H) JMP 380CH

; ======================================================
; Evaluate function at M
; ======================================================
0F1CH  (D7H) RST 2          ; Get next non-white char from M
0F1DH  (CAH) JZ 0458H       ; Generate MO error
0F20H  (DAH) JC 3840H       ; Convert ASCII number at M to double precision in FAC1
0F23H  (CDH) CALL 40F2H     ; Check if A is alpha character
0F26H  (D2H) JNC 0FDAH      ; Evaluate variable
0F29H  (FEH) CPI D0H
0F2BH  (CAH) JZ 0F1CH       ; Evaluate function at M
0F2EH  (FEH) CPI 2EH
0F30H  (CAH) JZ 3840H       ; Convert ASCII number at M to double precision in FAC1
0F33H  (FEH) CPI D1H
0F35H  (CAH) JZ 0FCCH
0F38H  (FEH) CPI 22H
0F3AH  (CAH) JZ 276CH
0F3DH  (FEH) CPI CEH        ; Test for NOT function
0F3FH  (CAH) JZ 1054H       ; NOT function
0F42H  (FEH) CPI C5H        ; Test for ERR function
0F44H  (C2H) JNZ 0F51H      ; Jump if not ERR function

; ======================================================
; ERR function
; ======================================================
0F47H  (D7H) RST 2          ; Get next non-white char from M
0F48H  (3AH) LDA F672H      ; Last Error code
0F4BH  (E5H) PUSH H
0F4CH  (CDH) CALL 10D1H     ; Load integer in A into FAC1
0F4FH  (E1H) POP H
0F50H  (C9H) RET

; ======================================================
; Test if token in A is ERL
; ======================================================
0F51H  (FEH) CPI C4H        ; Test for ERL function
0F53H  (C2H) JNZ 0F60H      ; Branch if not ERL

; ======================================================
; ERL function
; ======================================================
0F56H  (D7H) RST 2          ; Get next non-white char from M
0F57H  (E5H) PUSH H
0F58H  (2AH) LHLD FB9FH     ; Line number of last error
0F5BH  (CDH) CALL 37DBH     ; Convert unsigned HL to single precision in FAC1
0F5EH  (E1H) POP H
0F5FH  (C9H) RET

; ======================================================
; Test BASIC token being executed for...
; ======================================================
0F60H  (FEH) CPI AAH        ; TIME$ token
0F62H  (CAH) JZ 1904H       ; Jump to TIME$ function
0F65H  (FEH) CPI ABH        ; DATE$ token
0F67H  (CAH) JZ 1924H       ; Jump to DATE$ function
0F6AH  (FEH) CPI ACH        ; DAY token
0F6CH  (CAH) JZ 1955H       ; Jump to DAY function
0F6FH  (FEH) CPI B7H        ; MAX token
0F71H  (CAH) JZ 1D9BH       ; Jump to MAX function
0F74H  (FEH) CPI CCH        ; HIMEM token
0F76H  (CAH) JZ 1DB9H       ; Jump to HIMEM function
0F79H  (FEH) CPI C3H        ; VARPTR token
0F7BH  (C2H) JNZ 0FA3H      ; Jump if not VARPTR to test more

; ======================================================
; VARPTR function
; ======================================================
0F7EH  (D7H) RST 2          ; Get next non-white char from M
0F7FH  (CFH) RST 1          ; Compare next byte with M
0F80H  DB   28H
0F81H  (FEH) CPI 23H
0F83H  (C2H) JNZ 0F92H      ; VARPTR(variable) function

; ======================================================
; VARPTR(#buffer) function
; ======================================================
0F86H  (CDH) CALL 112DH     ; Evaluate expression at M
0F89H  (E5H) PUSH H
0F8AH  (CDH) CALL 4C84H     ; Get file descriptor for file in A
0F8DH  (EBH) XCHG
0F8EH  (E1H) POP H
0F8FH  (C3H) JMP 0F95H

; ======================================================
; VARPTR(variable) function
; ======================================================
0F92H  (CDH) CALL 482CH
0F95H  (CFH) RST 1          ; Compare next byte with M
0F96H  DB   29H
0F97H  (E5H) PUSH H
0F98H  (EBH) XCHG
0F99H  (7CH) MOV A,H
0F9AH  (B5H) ORA L
0F9BH  (CAH) JZ 08DBH       ; Generate FC error
0F9EH  (CDH) CALL 3510H     ; Load signed integer in HL to FAC1
0FA1H  (E1H) POP H
0FA2H  (C9H) RET

; ======================================================
; Test BASIC token being executed for...
; ======================================================
0FA3H  (FEH) CPI C7H
0FA5H  (CAH) JZ 2A37H       ; INSTR function
0FA8H  (FEH) CPI C9H
0FAAH  (CAH) JZ 4BEAH       ; INKEY$ function
0FADH  (FEH) CPI C6H
0FAFH  (CAH) JZ 296DH       ; STRING$ function
0FB2H  (FEH) CPI 84H
0FB4H  (CAH) JZ 4E8EH       ; INPUT statement
0FB7H  (FEH) CPI CAH
0FB9H  (CAH) JZ 1D90H       ; CSRLIN function
0FBCH  (FEH) CPI C8H
0FBEH  (CAH) JZ 5073H       ; DSKI$ function
0FC1H  (D6H) SUI DFH        ; Compare with SGN token to test for function
0FC3H  (D2H) JNC 0FF2H      ; Jump if SGN or higher (function)
0FC6H  (CDH) CALL 0DA9H
0FC9H  (CFH) RST 1          ; Compare next byte with M
0FCAH  DB   29H             ;   ')'
0FCBH  (C9H) RET

0FCCH  (16H) MVI D,7DH
0FCEH  (CDH) CALL 0DAEH
0FD1H  (2AH) LHLD FBA8H
0FD4H  (E5H) PUSH H
0FD5H  (CDH) CALL 33F6H
0FD8H  (E1H) POP H
0FD9H  (C9H) RET

; ======================================================
; Evaluate variable
; ======================================================
0FDAH  (CDH) CALL 4790H     ; Find address of variable at M
0FDDH  (E5H) PUSH H
0FDEH  (EBH) XCHG
0FDFH  (22H) SHLD FC1AH     ; Start of FAC1 for integers
0FE2H  (EFH) RST 5          ; Determine type of last var used
0FE3H  (C4H) CNZ 347EH
0FE6H  (E1H) POP H
0FE7H  (C9H) RET

; ======================================================
; Get char at M and convert to uppercase
; ======================================================
0FE8H  (7EH) MOV A,M        ; Get next character from input string

; ======================================================
; Convert A to uppercase
; ======================================================
0FE9H  (FEH) CPI 61H        ; Test if >= 'a'
0FEBH  (D8H) RC             ; Return if not
0FECH  (FEH) CPI 7BH        ; Test if <= 'z'
0FEEH  (D0H) RNC            ; Return if not
0FEFH  (E6H) ANI 5FH        ; Make uppercase
0FF1H  (C9H) RET

; ======================================================
; Handle functions during BASIC execution (SGN - MID$, zero based)
; ======================================================
0FF2H  (06H) MVI B,00H      ; Set MSB of modified BASIC token to zero
0FF4H  (07H) RLC            ; Multiply modified zero based token x2
0FF5H  (4FH) MOV C,A        ; Save in C
0FF6H  (C5H) PUSH B         ; And PUSH to the stack.  Now we process function args.
0FF7H  (D7H) RST 2          ; Get next non-white char from M
0FF8H  (79H) MOV A,C        ; Restore modified BASIC token
0FF9H  (FEH) CPI 39H        ; Test for string functions (STR$-MID$)
0FFBH  (DAH) JC 1015H       ; Jump if not string function to handle SGN-ASC

; ======================================================
; Handle string functions STR$-MID$
; ======================================================
0FFEH  (CDH) CALL 0DA9H
1001H  (CFH) RST 1          ; Compare next byte with M
1002H  DB   2CH
1003H  (CDH) CALL 35D9H     ; Generate TM error if last variable type not string or RET
1006H  (EBH) XCHG
1007H  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
100AH  (E3H) XTHL           ; Get function index from stack
100BH  (E5H) PUSH H         ; And PUSH it back to the stack
100CH  (EBH) XCHG
100DH  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
1010H  (EBH) XCHG
1011H  (E3H) XTHL           ; Get function index from stack
1012H  (C3H) JMP 102EH      ; Lookup function (SGN-MID$) vector and Jump to it

; ======================================================
; Handle numeric functions SGN-ASC
; ======================================================
1015H  (CDH) CALL 0FC6H
1018H  (E3H) XTHL           ; Get function index from stack
1019H  (7DH) MOV A,L
101AH  (FEH) CPI 0EH
101CH  (DAH) JC 102AH
101FH  (FEH) CPI 1DH
1021H  (D2H) JNC 102AH
1024H  (EFH) RST 5          ; Determine type of last var used
1025H  (E5H) PUSH H
1026H  (DCH) CC 35BAH       ; CDBL function
1029H  (E1H) POP H
102AH  (11H) LXI D,0FD8H
102DH  (D5H) PUSH D

; ======================================================
; Lookup function (SGN-MID$) vector of function (index x2 in HL) and Jump to it
; ======================================================
102EH  (01H) LXI B,0040H    ; Function vector table for SGN to MID$
1031H  (09H) DAD B          ; Index into Function vector table based on HL
1032H  (4EH) MOV C,M        ; Get LSB of function address
1033H  (23H) INX H          ; Increment to MSB
1034H  (66H) MOV H,M        ; Get MSB of function address
1035H  (69H) MOV L,C        ; Copy LSB to HL
1036H  (E9H) PCHL           ; Jump to function

; ======================================================
; ASCII num conversion - find ASCII or tokenized '+' or '-' in A
; ======================================================
1037H  (15H) DCR D
1038H  (FEH) CPI D1H
103AH  (C8H) RZ
103BH  (FEH) CPI 2DH
103DH  (C8H) RZ
103EH  (14H) INR D
103FH  (FEH) CPI 2BH
1041H  (C8H) RZ
1042H  (FEH) CPI D0H
1044H  (C8H) RZ
1045H  (2BH) DCX H
1046H  (C9H) RET

1047H  (3CH) INR A
1048H  (8FH) ADC A
1049H  (C1H) POP B
104AH  (A0H) ANA B
104BH  (C6H) ADI FFH
104DH  (9FH) SBB A
104EH  (CDH) CALL 340AH
1051H  (C3H) JMP 1066H

; ======================================================
; NOT function
; ======================================================
1054H  (16H) MVI D,5AH
1056H  (CDH) CALL 0DAEH
1059H  (CDH) CALL 3501H     ; CINT function
105CH  (7DH) MOV A,L
105DH  (2FH) CMA
105EH  (6FH) MOV L,A
105FH  (7CH) MOV A,H
1060H  (2FH) CMA
1061H  (67H) MOV H,A
1062H  (22H) SHLD FC1AH     ; Start of FAC1 for integers
1065H  (C1H) POP B
1066H  (C3H) JMP 0DBAH

; ======================================================
; RST 28H routine - Determine type of last var used
;
; C:  Clear = Double Precision
; P:  Clear = Single Precision
; Z:  Set = String
; S:  Set = Integer
; ======================================================
1069H  (3AH) LDA FB65H      ; Type of last variable used
106CH  (FEH) CPI 08H        ; Compare with Double Precision to set C flag (Clear if Dbl)
106EH  (3DH) DCR A          ;
106FH  (3DH) DCR A          ; Decrement type 3 times to set Z, P and S flags
1070H  (3DH) DCR A          ;
1071H  (C9H) RET            ; Return with flags set / cleared

1072H  (78H) MOV A,B
1073H  (F5H) PUSH PSW
1074H  (CDH) CALL 3501H     ; CINT function
1077H  (F1H) POP PSW
1078H  (D1H) POP D
1079H  (FEH) CPI 7AH
107BH  (CAH) JZ 37DFH
107EH  (FEH) CPI 7BH
1080H  (CAH) JZ 377EH       ; Signed integer divide (FAC1=DE/HL)
1083H  (01H) LXI B,10D3H
1086H  (C5H) PUSH B
1087H  (FEH) CPI 46H
1089H  (C2H) JNZ 1092H

; ======================================================
; OR function  (HL OR DE)
; ======================================================
108CH  (7BH) MOV A,E        ; Move LSB of DE to A
108DH  (B5H) ORA L          ; OR LSB of HL
108EH  (6FH) MOV L,A        ; Save in L
108FH  (7CH) MOV A,H        ; Move MSB of HL to A
1090H  (B2H) ORA D          ; OR MSB of DE
1091H  (C9H) RET

; ======================================================
; Test if BASIC token is AND & process
; ======================================================
1092H  (FEH) CPI 50H        ; Compare A with AND token
1094H  (C2H) JNZ 109DH      ; Jump if not AND to test XOR

; ======================================================
; AND function  (HL AND DE)
; ======================================================
1097H  (7BH) MOV A,E        ; Move LSB of DE to A
1098H  (A5H) ANA L          ; AND LSB with HL
1099H  (6FH) MOV L,A        ; Save in L
109AH  (7CH) MOV A,H        ; Move MSB of HL to A
109BH  (A2H) ANA D          ; AND with D
109CH  (C9H) RET

; ======================================================
; Test if BASIC token is XOR & process
; ======================================================
109DH  (FEH) CPI 3CH        ; Compare A with XOR token
109FH  (C2H) JNZ 10A8H      ; Jump if not XOR to test EQV

; ======================================================
; XOR function  (HL XOR DE)
; ======================================================
10A2H  (7BH) MOV A,E        ; Move LSB of DE to A
10A3H  (ADH) XRA L          ; XOR with LSB of HL
10A4H  (6FH) MOV L,A        ; Save in L
10A5H  (7CH) MOV A,H        ; Move MSB of HL to A
10A6H  (AAH) XRA D          ; XOR with MSB of DE
10A7H  (C9H) RET

; ======================================================
; Test if BASIC token is EQV & process
; ======================================================
10A8H  (FEH) CPI 32H        ; Compare A with EQV token
10AAH  (C2H) JNZ 10B5H      ; Jump to process IMP function

; ======================================================
; EQV function  (~(HL XOR DE))
; ======================================================
10ADH  (7BH) MOV A,E        ; Move LSB of DE to A
10AEH  (ADH) XRA L          ; XOR with LSB of HL
10AFH  (2FH) CMA            ; Compliment the result
10B0H  (6FH) MOV L,A        ; And save in L
10B1H  (7CH) MOV A,H        ; Move MSB of HL to A
10B2H  (AAH) XRA D          ; XOR with D
10B3H  (2FH) CMA            ; Compliment that result
10B4H  (C9H) RET

; ======================================================
; IMP function  (NOT ((NOT HL) AND DE))
; ======================================================
10B5H  (7DH) MOV A,L        ; Load LSB of HL
10B6H  (2FH) CMA            ; Compliment HL
10B7H  (A3H) ANA E          ; AND with LSB of DE
10B8H  (2FH) CMA            ; Compliment the result
10B9H  (6FH) MOV L,A        ; Save in A
10BAH  (7CH) MOV A,H        ; Get MSB of HL
10BBH  (2FH) CMA            ; Compliment HL
10BCH  (A2H) ANA D          ; AND with MSB of DE
10BDH  (2FH) CMA            ; Compliment the result
10BEH  (C9H) RET

; ======================================================
; Subtract HL - DE and unsigned convert to SNGL in FAC1 
; ======================================================
10BFH  (7DH) MOV A,L        ; Load LSB of HL
10C0H  (93H) SUB E          ; Subtract LSB of DE
10C1H  (6FH) MOV L,A        ; Save the result in HL
10C2H  (7CH) MOV A,H        ; Load MSB of HL
10C3H  (9AH) SBB D          ; Subtract MSB of DE (with borrow)
10C4H  (67H) MOV H,A        ; Save the result in HL
10C5H  (C3H) JMP 37DBH      ; Convert unsigned HL to single precision in FAC1

; ======================================================
; LPOS function
; ======================================================
10C8H  (3AH) LDA F674H      ; Line printer head position
10CBH  (C3H) JMP 10D1H      ; Load integer in A into FAC1

; ======================================================
; POS function
; ======================================================
10CEH  (3AH) LDA F788H      ; Horiz. position of cursor (0-39)

; ======================================================
; Load integer in A into FAC1
; ======================================================
10D1H  (6FH) MOV L,A
10D2H  (AFH) XRA A
10D3H  (67H) MOV H,A
10D4H  (C3H) JMP 3510H      ; Load signed integer in HL to FAC1

10D7H  (E5H) PUSH H
10D8H  (E6H) ANI 07H
10DAH  (21H) LXI H,02EEH    ; Vector table for math operations
10DDH  (4FH) MOV C,A
10DEH  (06H) MVI B,00H
10E0H  (09H) DAD B
10E1H  (CDH) CALL 1031H
10E4H  (E1H) POP H
10E5H  (C9H) RET

; ======================================================
; Check for running program
; ======================================================
10E6H  (E5H) PUSH H
10E7H  (2AH) LHLD F67AH     ; Current executing line number
10EAH  (23H) INX H
10EBH  (7CH) MOV A,H
10ECH  (B5H) ORA L
10EDH  (E1H) POP H
10EEH  (C0H) RNZ

; ======================================================
; Generate ID error
; ======================================================
10EFH  (1EH) MVI E,0CH      ; Load code for ID Error (Illegal Direct)
10F1H  (C3H) JMP 045DH      ; Generate error in E

; ======================================================
; Test if command to execute is FEH, generate SN error if not
; ======================================================
10F4H  (FEH) CPI 7EH        ; Test if command is '~'
10F6H  (C2H) JNZ 0446H      ; Generate Syntax error
10F9H  (23H) INX H          ; Skip to next byte in command string
10FAH  (C3H) JMP 2AC2H

10FDH  (C3H) JMP 0446H      ; Generate Syntax error

; ======================================================
; INP function
; ======================================================
1100H  (CDH) CALL 1131H     ; Get expression integer < 256 in A or FC Error
1103H  (32H) STA F66BH      ; Save port number as argument to IN
1106H  (CDH) CALL F66AH     ; Call the RAM based IN hook
1109H  (C3H) JMP 10D1H      ; Load integer in A into FAC1

; ======================================================
; OUT statement
; ======================================================
110CH  (CDH) CALL 111FH     ; Call to process arguments to OUT statement
110FH  (C3H) JMP F667H      ; Jump to RAM based hook

; ======================================================
; Evaluate expression at M
; ======================================================
1112H  (D7H) RST 2          ; Get next non-white char from M

; ======================================================
; Evaluate expression at M-1
; ======================================================
1113H  (CDH) CALL 0DABH     ; Main BASIC evaluation routine

; ======================================================
; Convert to integer in DE and test if 255 or less
; ======================================================
1116H  (E5H) PUSH H         ; Preserve HL on stack
1117H  (CDH) CALL 3501H     ; CINT function - Get expression in integer form
111AH  (EBH) XCHG           ; Put Integer into DE
111BH  (E1H) POP H          ; Restore HL
111CH  (7AH) MOV A,D        ; Move MSB of integer to A to test if > 255
111DH  (B7H) ORA A          ; Test if integer > 255
111EH  (C9H) RET

; ======================================================
; Process OUT statement arguments
; ======================================================
111FH  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
1122H  (32H) STA F66BH      ; Save port # as argument to IN?  Why?
1125H  (32H) STA F668H      ; Save port # as argument to OUT.  Ok.
1128H  (CFH) RST 1          ; Compare next byte with M
1129H  DB   2CH             ; Compare next byte with ","
112AH  (C3H) JMP 112EH      ; Evaluate expression (0-255) at M-1 - Value to OUT

; ======================================================
; Evaluate expression (0-255) at M
; ======================================================
112DH  (D7H) RST 2          ; Get next non-white char from M

; ======================================================
; Evaluate expression (0-255) at M-1
; ======================================================
112EH  (CDH) CALL 0DABH     ; Main BASIC evaluation routine

; ======================================================
; Get expression integer < 256 in A or FC Error
; ======================================================
1131H  (CDH) CALL 1116H     ; Convert to integer in DE and test if 255 or less
1134H  (C2H) JNZ 08DBH      ; Generate FC error if arg > 256
1137H  (2BH) DCX H          ; Decrement input string pointer
1138H  (D7H) RST 2          ; Get next non-white char from M
1139H  (7BH) MOV A,E        ; Copy LSB of integer to A
113AH  (C9H) RET

; ======================================================
; LLIST statement
; ======================================================
113BH  (3EH) MVI A,01H
113DH  (32H) STA F675H      ; Output device for RST 20H (0=screen)

; ======================================================
; LIST statement
; ======================================================
1140H  (C1H) POP B
1141H  (CDH) CALL 060AH     ; Evaluate LIST statement arguments
1144H  (C5H) PUSH B
1145H  (60H) MOV H,B
1146H  (69H) MOV L,C
1147H  (22H) SHLD FABAH     ; Address where last BASIC list started
114AH  (21H) LXI H,FFFFH
114DH  (22H) SHLD F67AH     ; Current executing line number
1150H  (E1H) POP H
1151H  (22H) SHLD FABCH
1154H  (D1H) POP D
1155H  (4EH) MOV C,M
1156H  (23H) INX H
1157H  (46H) MOV B,M
1158H  (23H) INX H
1159H  (78H) MOV A,B
115AH  (B1H) ORA C
115BH  (CAH) JZ 1195H
115EH  (CDH) CALL 421AH
1161H  (CCH) CZ 13F3H
1164H  (C5H) PUSH B
1165H  (4EH) MOV C,M
1166H  (23H) INX H
1167H  (46H) MOV B,M
1168H  (23H) INX H
1169H  (C5H) PUSH B
116AH  (E3H) XTHL
116BH  (EBH) XCHG
116CH  (DFH) RST 3          ; Compare DE and HL
116DH  (C1H) POP B
116EH  (DAH) JC 1194H
1171H  (E3H) XTHL
1172H  (E5H) PUSH H
1173H  (C5H) PUSH B
1174H  (EBH) XCHG
1175H  (22H) SHLD FBA1H     ; Most recent used or entered line number
1178H  (CDH) CALL 39D4H     ; Print binary number in HL at current position
117BH  (E1H) POP H
117CH  (7EH) MOV A,M
117DH  (FEH) CPI 09H
117FH  (CAH) JZ 1185H
1182H  (3EH) MVI A,20H
1184H  (E7H) RST 4          ; Send character in A to screen/printer
1185H  (CDH) CALL 11AAH
1188H  (21H) LXI H,F685H    ; Keyboard buffer
118BH  (CDH) CALL 11A2H     ; Send buffer at M to screen
118EH  (CDH) CALL 4BCBH
1191H  (C3H) JMP 114AH

1194H  (C1H) POP B
1195H  (3AH) LDA F651H      ; In TEXT because of BASIC EDIT flag
1198H  (A7H) ANA A
1199H  (C2H) JNZ 5E82H
119CH  (3EH) MVI A,1AH
119EH  (E7H) RST 4          ; Send character in A to screen/printer
119FH  (C3H) JMP 0502H      ; Vector to BASIC ready - print Ok

; ======================================================
; Send buffer at M to screen
; ======================================================
11A2H  (7EH) MOV A,M
11A3H  (B7H) ORA A
11A4H  (C8H) RZ
11A5H  (E7H) RST 4          ; Send character in A to screen/printer
11A6H  (23H) INX H
11A7H  (C3H) JMP 11A2H      ; Send buffer at M to screen

11AAH  (01H) LXI B,F685H    ; Keyboard buffer
11ADH  (16H) MVI D,FFH
11AFH  (AFH) XRA A
11B0H  (32H) STA FB66H
11B3H  (C3H) JMP 11B9H

11B6H  (03H) INX B
11B7H  (15H) DCR D
11B8H  (C8H) RZ
11B9H  (7EH) MOV A,M
11BAH  (23H) INX H
11BBH  (B7H) ORA A
11BCH  (02H) STAX B
11BDH  (C8H) RZ
11BEH  (FEH) CPI 22H
11C0H  (C2H) JNZ 11CDH
11C3H  (3AH) LDA FB66H
11C6H  (EEH) XRI 01H
11C8H  (32H) STA FB66H
11CBH  (3EH) MVI A,22H
11CDH  (FEH) CPI 3AH
11CFH  (C2H) JNZ 11E1H
11D2H  (3AH) LDA FB66H
11D5H  (1FH) RAR
11D6H  (DAH) JC 11DFH
11D9H  (17H) RAL
11DAH  (E6H) ANI FDH
11DCH  (32H) STA FB66H
11DFH  (3EH) MVI A,3AH
11E1H  (B7H) ORA A
11E2H  (F2H) JP 11B6H
11E5H  (3AH) LDA FB66H
11E8H  (1FH) RAR
11E9H  (DAH) JC 11B6H
11ECH  (2BH) DCX H
11EDH  (1FH) RAR
11EEH  (1FH) RAR
11EFH  (D2H) JNC 1233H
11F2H  (7EH) MOV A,M
11F3H  (FEH) CPI FFH
11F5H  (E5H) PUSH H
11F6H  (C5H) PUSH B
11F7H  (21H) LXI H,121AH
11FAH  (E5H) PUSH H
11FBH  (C0H) RNZ
11FCH  (0BH) DCX B
11FDH  (0AH) LDAX B
11FEH  (FEH) CPI 4DH
1200H  (C0H) RNZ
1201H  (0BH) DCX B
1202H  (0AH) LDAX B
1203H  (FEH) CPI 45H
1205H  (C0H) RNZ
1206H  (0BH) DCX B
1207H  (0AH) LDAX B
1208H  (FEH) CPI 52H
120AH  (C0H) RNZ
120BH  (0BH) DCX B
120CH  (0AH) LDAX B
120DH  (FEH) CPI 3AH
120FH  (C0H) RNZ
1210H  (F1H) POP PSW
1211H  (F1H) POP PSW
1212H  (E1H) POP H
1213H  (14H) INR D
1214H  (14H) INR D
1215H  (14H) INR D
1216H  (14H) INR D
1217H  (C3H) JMP 1242H

121AH  (C1H) POP B
121BH  (E1H) POP H
121CH  (7EH) MOV A,M
121DH  (23H) INX H
121EH  (C3H) JMP 11B6H

1221H  (3AH) LDA FB66H
1224H  (F6H) ORI 02H
1226H  (32H) STA FB66H
1229H  (AFH) XRA A
122AH  (C9H) RET

122BH  (3AH) LDA FB66H
122EH  (F6H) ORI 04H
1230H  (C3H) JMP 1226H

1233H  (17H) RAL
1234H  (DAH) JC 121DH
1237H  (7EH) MOV A,M
1238H  (FEH) CPI 83H
123AH  (CCH) CZ 1221H
123DH  (FEH) CPI 8EH
123FH  (CCH) CZ 122BH
1242H  (7EH) MOV A,M
1243H  (23H) INX H
1244H  (FEH) CPI 91H
1246H  (CCH) CZ 3643H
1249H  (D6H) SUI 7FH
124BH  (E5H) PUSH H
124CH  (5FH) MOV E,A
124DH  (21H) LXI H,0080H    ; BASIC statement keyword table END to NEW
1250H  (7EH) MOV A,M
1251H  (23H) INX H
1252H  (B7H) ORA A
1253H  (F2H) JP 1250H
1256H  (1DH) DCR E
1257H  (C2H) JNZ 1250H
125AH  (E6H) ANI 7FH
125CH  (02H) STAX B
125DH  (03H) INX B
125EH  (15H) DCR D
125FH  (CAH) JZ 27E2H
1262H  (7EH) MOV A,M
1263H  (23H) INX H
1264H  (B7H) ORA A
1265H  (F2H) JP 125CH
1268H  (E1H) POP H
1269H  (C3H) JMP 11B9H

126CH  (EBH) XCHG
126DH  (2AH) LHLD FBB2H     ; Start of variable data pointer
1270H  (1AH) LDAX D
1271H  (02H) STAX B
1272H  (03H) INX B
1273H  (13H) INX D
1274H  (DFH) RST 3          ; Compare DE and HL
1275H  (C2H) JNZ 1270H
1278H  (60H) MOV H,B
1279H  (69H) MOV L,C
127AH  (22H) SHLD FBB2H     ; Start of variable data pointer
127DH  (22H) SHLD FBB4H     ; Start of array table pointer
1280H  (22H) SHLD FBB6H     ; Unused memory pointer
1283H  (C9H) RET

; ======================================================
; PEEK function
; ======================================================
1284H  (CDH) CALL 12A1H     ; Convert last expression to integer (-32768 to 65535) or OV
1287H  (7EH) MOV A,M        ; Load A from (HL)
1288H  (C3H) JMP 10D1H      ; Load integer in A into FAC1

; ======================================================
; POKE function
; ======================================================
128BH  (CDH) CALL 1297H     ; Evaluate expression at M
128EH  (D5H) PUSH D         ; Save POKE address to stack
128FH  (CFH) RST 1          ; Compare next byte with M
1290H  DB   2CH             ;    ','
1291H  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
1294H  (D1H) POP D          ; Get POKE address form stack
1295H  (12H) STAX D         ; POKE the value in a to (DE)
1296H  (C9H) RET

; ======================================================
; Evaluate expression at M
; ======================================================
1297H  (CDH) CALL 0DABH     ; Main BASIC evaluation routine
129AH  (E5H) PUSH H
129BH  (CDH) CALL 12A1H     ; Convert last expression to integer (-32768 to 65535) or OV
129EH  (EBH) XCHG
129FH  (E1H) POP H
12A0H  (C9H) RET

; ======================================================
; Convert last expression to integer (-32768 to 32767) or OV
; ======================================================
12A1H  (01H) LXI B,3501H    ; CINT function
12A4H  (C5H) PUSH B
12A5H  (EFH) RST 5          ; Determine type of last var used
12A6H  (F8H) RM             ; Return to CINT function if last var was integer
12A7H  (F7H) RST 6          ; Get sign of FAC1
12A8H  (F8H) RM             ; Return to CINT function if FAC1 negative
12A9H  (CDH) CALL 352AH     ; Convert to CSNG
12ACH  (01H) LXI B,3245H    ; Load BCDE with Single precision for 32768.0
12AFH  (11H) LXI D,8076H    ;   "
12B2H  (CDH) CALL 3498H     ; Compare single precision in BCDE with FAC1
12B5H  (D8H) RC             ; Return to CINT function if less than 32768
12B6H  (01H) LXI B,6545H    ; Load BCDE with Single precision for 65536.0
12B9H  (11H) LXI D,6053H    ;   "
12BCH  (CDH) CALL 3498H     ; Compare single precision in BCDE with FAC1
12BFH  (D2H) JNC 0455H      ; Generate OV error if > 65535
12C2H  (01H) LXI B,65C5H    ; Load BCDE with Single precision for -65536.0
12C5H  (11H) LXI D,6053H    ;   "
12C8H  (C3H) JMP 37F4H      ; Single precision addition (FAC1=FAC1+BCDE) convert to nengative

; ======================================================
; Wait for key from keyboard
; ======================================================
12CBH  (E5H) PUSH H         ; Preserve HL on stack
12CCH  (D5H) PUSH D         ; Preserve DE on stack
12CDH  (C5H) PUSH B         ; Preserve BC on stack
12CEH  (CDH) CALL 12D4H     ; Call routine to wait for key
12D1H  (C3H) JMP 14EEH      ; POP BC, DE, HL from stack

; ======================================================
; Wait for key from keyboard - no reg PUSH
; ======================================================
12D4H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
12D5H  DB   04H             ; CHGET Hook

; ======================================================
; Process next byte of FKey text to "inject" the keys
; ======================================================
12D6H  (2AH) LHLD F62CH     ; Get MSB of pointer to FKey text (from FKey table) for selected FKey
12D9H  (24H) INR H          ; Prepare to test if MSB of address is zero
12DAH  (25H) DCR H          ; Test for zero
12DBH  (CAH) JZ 1300H       ; Jump to process paste buffer injection if no FKey selected
12DEH  (46H) MOV B,M        ; Get next byte from selected FKey text
12DFH  (78H) MOV A,B        ; Prepare to test if at end of FKey text
12E0H  (B7H) ORA A          ; Test for NULL termination
12E1H  (CAH) JZ 12EAH       ; Jump ahead of at end of text
12E4H  (23H) INX H          ; Look ahead to the next byte to see if we are at the end of the FKey text
12E5H  (7EH) MOV A,M        ; Get the byte after this one
12E6H  (B7H) ORA A          ; And test for zero
12E7H  (C2H) JNZ 12EBH      ; Jump to save updated FKey address if not at end
12EAH  (67H) MOV H,A        ; Load zero into H to indicate FKey no longer active
12EBH  (22H) SHLD F62CH     ; Save updated address of active FKey text
12EEH  (78H) MOV A,B        ; Get the next byte of the FKey text as our "Key"
12EFH  (C9H) RET

; ======================================================
; Process PASTE key from keyboard
; ======================================================
12F0H  (3AH) LDA F650H
12F3H  (87H) ADD A
12F4H  (D8H) RC
12F5H  (21H) LXI H,0000H    ; Initialize index of next byte to paste from paste buffer
12F8H  (22H) SHLD F62EH     ; Save as index of next byte to paste from paste buffer
12FBH  (3EH) MVI A,0DH      ; Prepare to initialize "last paste char" as ENTER
12FDH  (32H) STA FAA1H      ; Initialize "last paste char" as ENTER

; ======================================================
; Process next byte from Paste buffer to "inject" the keystrokes
; ======================================================
1300H  (2AH) LHLD F62EH     ; Get index into paste buffer
1303H  (7DH) MOV A,L        ; Get LSB of length?
1304H  (A4H) ANA H          ; And with MSB
1305H  (3CH) INR A          ; Increment to test for FFFFH
1306H  (CAH) JZ 133DH       ; Jump if not actively pasting from paste buffer
1309H  (E5H) PUSH H         ; PUSH index to stack
130AH  (3AH) LDA FAA1H      ; Get value of last paste character
130DH  (FEH) CPI 0DH        ; Test if it was ENTER
130FH  (CCH) CZ 2146H       ; Update line addresses for ALL BASIC programs if it was ENTER
1312H  (2AH) LHLD F9A5H     ; Start of Paste Buffer
1315H  (D1H) POP D          ; Restore index of next byte in paste buffer
1316H  (19H) DAD D          ; Point to next byte to paste from paste buffer
1317H  (7EH) MOV A,M        ; Get the next byte to paste
1318H  (32H) STA FAA1H      ; Store it as the "last paste character"
131BH  (47H) MOV B,A        ; Save byte in B
131CH  (FEH) CPI 1AH        ; Test for end of paste buffer marker maybe
131EH  (3EH) MVI A,00H      ; Replace EOL marker with zero in case of match
1320H  (CAH) JZ 1336H       ; Jump if end of paste buffer
1323H  (CDH) CALL 7270H     ; Check keyboard queue for pending characters
1326H  (DAH) JC 1336H       ; If there is keyboard action, halt the paste operation perhaps?
1329H  (23H) INX H          ; Point to next byte in paste buffer
132AH  (7EH) MOV A,M        ; Peek the next byte in paste buffer to see if at end
132BH  (EBH) XCHG           ; Put index into paste buffer into HL
132CH  (23H) INX H          ; Increment the index count
132DH  (22H) SHLD F62EH     ; Save as index into paste buffer of next byte to paste
1330H  (FEH) CPI 1AH        ; Test if next byte past current byte is end of buffer marker
1332H  (78H) MOV A,B        ; Restore the byte to be pasted from B
1333H  (37H) STC            ; Set the C flag
1334H  (3FH) CMC            ; And now clear it
1335H  (C0H) RNZ            ; And return if not at end of paste buffer
1336H  (21H) LXI H,FFFFH    ; At end of paste buffer.  Load value indication paste is "inactive"
1339H  (22H) SHLD F62EH     ; And store it as the active index of paste from paste buffer
133CH  (C9H) RET            ; Now return the next byte from the paste buffer to "inject"

; ======================================================
; Test for actual keystroke characters to process
; ======================================================
133DH  (CDH) CALL 13DBH     ; Check keyboard queue for pending characters
1340H  (C2H) JNZ 1358H
1343H  (CDH) CALL 13C2H     ; Turn cursor on if not already during program pause
1346H  (3EH) MVI A,FFH
1348H  (32H) STA F656H      ; Power off exit condition switch
134BH  (CDH) CALL 13DBH     ; Check keyboard queue for pending characters
134EH  (CAH) JZ 134BH
1351H  (AFH) XRA A
1352H  (32H) STA F656H      ; Power off exit condition switch
1355H  (CDH) CALL 13D0H     ; Turn cursor back off if it was off before
1358H  (21H) LXI H,F932H
135BH  (7EH) MOV A,M
135CH  (A7H) ANA A
135DH  (C2H) JNZ 13B5H
1360H  (CDH) CALL 1BB1H     ; Renew automatic power-off counter
1363H  (CDH) CALL 7242H     ; Scan keyboard for character (CTRL-BREAK ==> CTRL-C)
1366H  (D0H) RNC
1367H  (D6H) SUI 0BH        ; Test for PASTE key
1369H  (CAH) JZ 12F0H       ; Jump to process PASTE key if zero
136CH  (D2H) JNC 13C0H
136FH  (3CH) INR A          ; Test for SHIFT-PRINT key
1370H  (CAH) JZ 139FH       ; Jump to process special "Paste" of SHIFT-PRINT key sequence
1373H  (3CH) INR A          ; Test for PRINT key
1374H  (CAH) JZ 1E5EH       ; Jump to LCOPY statement if PRINT key
1377H  (3CH) INR A          ; Test for LABEL key
1378H  (CAH) JZ 13A5H       ; Toggle function key label line if LABEL key
137BH  (5FH) MOV E,A
137CH  (3AH) LDA F650H
137FH  (87H) ADD A          ;
1380H  (87H) ADD A          ;
1381H  (7BH) MOV A,E        ;
1382H  (D8H) RC             ;
1383H  (16H) MVI D,FFH      ;
1385H  (EBH) XCHG           ;   KDP: TODO: This is calculating the FKey table entry or FKeys somehow!
1386H  (29H) DAD H          ;
1387H  (29H) DAD H          ;
1388H  (29H) DAD H          ;
1389H  (29H) DAD H          ;
138AH  (11H) LXI D,F809H    ;
138DH  (19H) DAD D          ;
138EH  (3AH) LDA F650H      ;
1391H  (A7H) ANA A          ;
1392H  (F2H) JP 1399H       ;
1395H  (23H) INX H
1396H  (23H) INX H
1397H  (23H) INX H
1398H  (23H) INX H

; ======================================================
; Set HL as pointer to text to be "PASTED" / injected as keystrokes
; ======================================================
1399H  (22H) SHLD F62CH     ; Points to text for selected FKey from FKey table
139CH  (C3H) JMP 12D4H      ; Wait for key from keyboard

; ======================================================
; Process paste of key sequence defined for SHIFT-PRINT key
; ======================================================
139FH  (2AH) LHLD F88AH     ; Load pointer to SHIFT-PRINT key sequence for this mode
13A2H  (C3H) JMP 1399H      ; Jump to set HL as pointer to PASTE sequence

; ======================================================
; Toggle function key label line
; ======================================================
13A5H  (3AH) LDA FAADH      ; Label line enable flag
13A8H  (A7H) ANA A          ; Test if Label line is enabled
13A9H  (C8H) RZ             ; Return if not enabled
13AAH  (3AH) LDA F63DH      ; Label line protect status
13ADH  (EEH) XRI FFH        ; Test if Label Line is on or off

; ======================================================
; Erase or Display function key line based on Z flag
; ======================================================
13AFH  (CAH) JZ 428AH       ; Erase function key display
13B2H  (C3H) JMP 42A8H      ; Display function key line

13B5H  (F3H) DI             ; Disable interrupts for power-down
13B6H  (36H) MVI M,00H
13B8H  (3AH) LDA F657H      ; Load power-down time (1/10th of a minute)
13BBH  (2BH) DCX H          ; Point to power-down count-down
13BCH  (77H) MOV M,A        ; Update power-down count-down for next power-up
13BDH  (CDH) CALL 143FH     ; Turn off computer
13C0H  (AFH) XRA A
13C1H  (C9H) RET

; ======================================================
; Turn cursor on if not already during program pause
; ======================================================
13C2H  (3AH) LDA F63FH      ; Cursor status (0 = off)
13C5H  (32H) STA FACBH      ; Storage if cursor was on before BASIC CTRL-S
13C8H  (A7H) ANA A
13C9H  (C0H) RNZ
13CAH  (CDH) CALL 4249H     ; Turn the cursor on
13CDH  (C3H) JMP 4262H      ; Send ESC X

; ======================================================
; Turn cursor back off after BASIC "un-pause" if it was off before
; ======================================================
13D0H  (3AH) LDA FACBH      ; Storage if cursor was on before BASIC CTRL-S
13D3H  (A7H) ANA A
13D4H  (C0H) RNZ
13D5H  (CDH) CALL 424EH     ; Turn the cursor off
13D8H  (C3H) JMP 4262H      ; Send ESC X

; ======================================================
; Check keyboard queue for pending characters
; ======================================================
13DBH  (3AH) LDA F62DH
13DEH  (A7H) ANA A
13DFH  (C0H) RNZ
13E0H  (3AH) LDA F932H
13E3H  (A7H) ANA A
13E4H  (C0H) RNZ
13E5H  (E5H) PUSH H         ; Preserve HL on stack
13E6H  (2AH) LHLD F62EH     ; Load index of active paste buffer paste operation
13E9H  (7DH) MOV A,L        ; Prepare to test for FFFFH
13EAH  (A4H) ANA H          ; AND in MSB to test for FFFFH
13EBH  (3CH) INR A          ; Test for FFFFH = paste operation inactive
13ECH  (E1H) POP H          ; Restore HL
13EDH  (C0H) RNZ            ; Return if paste operation active
13EEH  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
13EFH  DB   06H
13F0H  (C3H) JMP 7270H      ; Check keyboard queue for pending characters

; ======================================================
; Test for CTRL-C or CTRL-S during BASIC Execute
; ======================================================
13F3H  (CDH) CALL 7283H     ; Check for break or wait (CTRL-S)
13F6H  (C8H) RZ
13F7H  (FEH) CPI 03H	    ; Test for CTRL-C
13F9H  (CAH) JZ 1412H	    ; Jump if CTRL-C
13FCH  (FEH) CPI 13H	    ; Test for CTRL-S (pause)
13FEH  (C0H) RNZ            ; Return if not CTRL-S - okay to execute
13FFH  (CDH) CALL 13C2H     ; Turn cursor on if not already during program pause
1402H  (CDH) CALL 7283H     ; Check for break or wait (CTRL-S)
1405H  (FEH) CPI 13H        ; Test for CTRL-S
1407H  (CAH) JZ 13D0H       ; Turn cursor back off if it was off before
140AH  (FEH) CPI 03H        ; Check for CTRL-C
140CH  (C2H) JNZ 1402H      ; Jump if not CTRL-C
140FH  (CDH) CALL 13D0H     ; Turn cursor back off if it was already off
1412H  (AFH) XRA A
1413H  (32H) STA FFAAH      ; Keyboard buffer count
1416H  (C3H) JMP 409AH      ; STOP statement

; ======================================================
; POWER statement
; ======================================================
1419H  (D6H) SUI A4H        ; Test for CONT token
141BH  (CAH) JZ 1459H       ; POWER CONT statement
141EH  (FEH) CPI 27H        ; Test for POWER OFF token
1420H  (C2H) JNZ 1461H      ; POWER statement

; ======================================================
; POWER OFF statement
; ======================================================
1423H  (D7H) RST 2          ; Get next non-white char from M
1424H  (CAH) JZ 1451H       ; If no arguments, jump to turn power off
1427H  (CFH) RST 1          ; Compare next byte with M
1428H  DB   2CH             ; Test for ','
1429H  (CFH) RST 1          ; Compare next byte with M
142AH  DB   95H             ; Test for RESUME token
142BH  (C2H) JNZ 0446H      ; Generate Syntax error
142EH  (C3H) JMP 143FH      ; Turn off computer

; ======================================================
; Normal TRAP (low power) interrupt routine
; ======================================================
1431H  (F5H) PUSH PSW       ; Preserve A on stack
1432H  (3AH) LDA F656H      ; Power off exit condition switch
1435H  (A7H) ANA A          ; Test if system state preserved through power cycle
1436H  (3EH) MVI A,01H      ; Set new exit condition - don't preserve state 
1438H  (32H) STA F656H      ; Power off exit condition switch
143BH  (C2H) JNZ 1451H      ; Jump if not saving system state thru power cycle
143EH  (F1H) POP PSW        ; Restore A from stack

; ======================================================
; Turn off computer - preserve system state to stack
; ======================================================
143FH  (F3H) DI             ; Disable interrupts for PowerDown
1440H  (E5H) PUSH H         ; Push all registers so we can restore
1441H  (D5H) PUSH D         ;    to the same location upon next
1442H  (C5H) PUSH B         ;    power on cycle.
1443H  (F5H) PUSH PSW       ;
1444H  (21H) LXI H,0000H    ; Prepare to save SP for Auto PowerDown
1447H  (39H) DAD SP         ; Get SP into HL
1448H  (22H) SHLD FABEH     ; SP save area for power up/down
144BH  (21H) LXI H,9C0BH    ; Load Auto PowerDown signaure
144EH  (22H) SHLD F5F2H     ; Save Auto PowerDown signature

; ======================================================
; Turn off computer - don't preserve system state
; ======================================================
1451H  (F3H) DI             ; Disable interrupts (again?)
1452H  (DBH) IN BAH         ; Get Current I/O value of BAH
1454H  (F6H) ORI 10H        ; Set the PowerDown bit
1456H  (D3H) OUT BAH        ; PowerDown.  We will loose power here
1458H  (76H) HLT            ; Issue a HLT as power may be left in CAPs, etc.

; ======================================================
; POWER CONT statement
; ======================================================
1459H  (CDH) CALL 1469H     ; Store zero to power down time & counter?
145CH  (32H) STA F932H      ; Store zero
145FH  (D7H) RST 2          ; Get next non-white char from M
1460H  (C9H) RET

; ======================================================
; POWER statement
; ======================================================
1461H  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
1464H  (FEH) CPI 0AH        ; Validate POWER argument is at least 10 (10 * 0.1 min)
1466H  (DAH) JC 08DBH       ; Generate FC error
1469H  (32H) STA F657H      ; Store POWER down time (1/10ths of a minute)
146CH  (32H) STA F931H      ; Update power-off countdown 
146FH  (C9H) RET

; ======================================================
; Output character to printer
; ======================================================
1470H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
1471H  DB   0AH
1472H  (CDH) CALL 6D3FH     ; Send character in A to the printer
1475H  (D2H) JNC 147FH
1478H  (AFH) XRA A
1479H  (32H) STA FACDH
147CH  (C3H) JMP 1494H      ; Generate I/O error

147FH  (F5H) PUSH PSW
1480H  (3EH) MVI A,FFH
1482H  (32H) STA FACDH
1485H  (CDH) CALL 1BB1H     ; Renew automatic power-off counter
1488H  (F1H) POP PSW
1489H  (C9H) RET

; ======================================================
; Start tape and load tape header
; ======================================================
148AH  (CDH) CALL 14A8H     ; Turn cassette motor on
148DH  (CDH) CALL 6F85H     ; Read cassette header and sync byte
1490H  (D0H) RNC

; ======================================================
; Turn cassette motor off and generate I/O Error
; ======================================================
1491H  (CDH) CALL 14AAH     ; Turn cassette motor off

; ======================================================
; Generate I/O error
; ======================================================
1494H  (1EH) MVI E,12H      ; Load code for I/O Error
1496H  (C3H) JMP 045DH      ; Generate error in E

; ======================================================
; Turn cassette motor on and detect sync header
; ======================================================
1499H  (CDH) CALL 14A8H     ; Turn cassette motor on
149CH  (01H) LXI B,0000H
149FH  (0BH) DCX B
14A0H  (78H) MOV A,B
14A1H  (B1H) ORA C
14A2H  (C2H) JNZ 149FH
14A5H  (C3H) JMP 6F46H      ; Write cassette header and sync byte

; ======================================================
; Turn cassette motor on
; ======================================================
14A8H  (F3H) DI
14A9H  (11H) LXI D,1EFBH
14ACH  (00H) NOP
14ADH  (C3H) JMP 7043H      ; Cassette REMOTE routine - turn motor on or off

; ======================================================
; Read byte from tape & update checksum
; ======================================================
14B0H  (D5H) PUSH D
14B1H  (E5H) PUSH H
14B2H  (C5H) PUSH B
14B3H  (CDH) CALL 702AH     ; Read character from cassette w/o checksum
14B6H  (DAH) JC 1491H       ; Turn cassette motor off and generate I/O Error
14B9H  (7AH) MOV A,D
14BAH  (C1H) POP B
14BBH  (81H) ADD C
14BCH  (4FH) MOV C,A
14BDH  (7AH) MOV A,D
14BEH  (E1H) POP H
14BFH  (D1H) POP D
14C0H  (C9H) RET

; ======================================================
; Write byte to tape & update checksum
; ======================================================
14C1H  (D5H) PUSH D
14C2H  (E5H) PUSH H
14C3H  (57H) MOV D,A
14C4H  (81H) ADD C
14C5H  (4FH) MOV C,A
14C6H  (C5H) PUSH B
14C7H  (7AH) MOV A,D
14C8H  (CDH) CALL 6F5BH     ; Write char in A to cassette w/o checksum
14CBH  (DAH) JC 1491H       ; Turn cassette motor off and generate I/O Error
14CEH  (C1H) POP B
14CFH  (E1H) POP H
14D0H  (D1H) POP D
14D1H  (C9H) RET

; ======================================================
; LCD Device control block
; ======================================================
14D2H  DW   14D8H,4D59H,14E5H

; ======================================================
; LCD and PRT file open routine
; ======================================================
14D8H  (3EH) MVI A,02H
14DAH  (BBH) CMP E
14DBH  (C2H) JNZ 504EH      ; Generate NM error
14DEH  (22H) SHLD FC8CH
14E1H  (73H) MOV M,E
14E2H  (F1H) POP PSW
14E3H  (E1H) POP H
14E4H  (C9H) RET

; ======================================================
; Output to LCD file
; ======================================================
14E5H  (F1H) POP PSW
14E6H  (F5H) PUSH PSW
14E7H  (CDH) CALL 431FH
14EAH  (CDH) CALL 1BB1H     ; Renew automatic power-off counter

; ======================================================
; Pop AF, BC, DE, HL from stack
; ======================================================
14EDH  (F1H) POP PSW

; ======================================================
; BC, DE, HL from stack
; ======================================================
14EEH  (C1H) POP B
14EFH  (D1H) POP D
14F0H  (E1H) POP H
14F1H  (C9H) RET

; ======================================================
; CRT device control block
; ======================================================
14F2H  DW   14F8H,4D59H,14FAH

14F8H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
14F9H  DB   40H
14FAH  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
14FBH  DB   44H

; ======================================================
; RAM device control block
; ======================================================
14FCH  DW   1506H,158DH,15ACH,15C4H
1504H  DW   161BH

; ======================================================
; Open RAM file
; ======================================================
1506H  (E5H) PUSH H
1507H  (D5H) PUSH D
1508H  (23H) INX H
1509H  (23H) INX H
150AH  (E5H) PUSH H
150BH  (7BH) MOV A,E
150CH  (FEH) CPI 01H
150EH  (CAH) JZ 1541H
1511H  (FEH) CPI 08H
1513H  (CAH) JZ 155CH
1516H  (CDH) CALL 220FH     ; Open a text file at (FC93H)
1519H  (DAH) JC 1580H
151CH  (D5H) PUSH D
151DH  (CDH) CALL 18DAH
1520H  (D1H) POP D
1521H  (01H) LXI B,0000H
1524H  (E1H) POP H
1525H  (1AH) LDAX D
1526H  (E6H) ANI 02H
1528H  (C2H) JNZ 5051H      ; Generate AO error
152BH  (1AH) LDAX D
152CH  (F6H) ORI 02H
152EH  (12H) STAX D
152FH  (13H) INX D
1530H  (73H) MOV M,E
1531H  (23H) INX H
1532H  (72H) MOV M,D
1533H  (23H) INX H
1534H  (23H) INX H
1535H  (23H) INX H
1536H  (36H) MVI M,00H
1538H  (23H) INX H
1539H  (71H) MOV M,C
153AH  (23H) INX H
153BH  (70H) MOV M,B
153CH  (D1H) POP D
153DH  (E1H) POP H
153EH  (C3H) JMP 14DEH

1541H  (3AH) LDA F651H      ; In TEXT because of BASIC EDIT flag
1544H  (A7H) ANA A
1545H  (21H) LXI H,F9AFH
1548H  (CCH) CZ 208FH
154BH  (CAH) JZ 5057H       ; Generate FF error
154EH  (EBH) XCHG
154FH  (CDH) CALL 1675H
1552H  (AFH) XRA A
1553H  (77H) MOV M,A
1554H  (6FH) MOV L,A
1555H  (67H) MOV H,A
1556H  (22H) SHLD FAD8H
1559H  (C3H) JMP 1521H

155CH  (E1H) POP H
155DH  (D1H) POP D
155EH  (1EH) MVI E,02H
1560H  (D5H) PUSH D
1561H  (E5H) PUSH H
1562H  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
1565H  (CDH) CALL 208FH
1568H  (CAH) JZ 1516H
156BH  (5DH) MOV E,L
156CH  (54H) MOV D,H
156DH  (23H) INX H
156EH  (7EH) MOV A,M
156FH  (23H) INX H
1570H  (66H) MOV H,M
1571H  (6FH) MOV L,A
1572H  (01H) LXI B,FFFFH
1575H  (7EH) MOV A,M
1576H  (23H) INX H
1577H  (03H) INX B
1578H  (FEH) CPI 1AH
157AH  (C2H) JNZ 1575H
157DH  (C3H) JMP 1524H

; ======================================================
; Test if RAM file Already Open.  DE points to FCB
; ======================================================
1580H  (1AH) LDAX D         ; Get Open flag
1581H  (E6H) ANI 02H        ; Test if file already open
1583H  (C2H) JNZ 5051H      ; Generate AO error
1586H  (EBH) XCHG
1587H  (CDH) CALL 1FBFH     ; Kill a text file     
158AH  (C3H) JMP 1516H

; ======================================================
; Close RAM file
; ======================================================
158DH  (E5H) PUSH H
158EH  (CDH) CALL 15A0H
1591H  (E1H) POP H
1592H  (CDH) CALL 172AH
1595H  (C4H) CNZ 1621H
1598H  (CDH) CALL 1675H
159BH  (36H) MVI M,00H
159DH  (C3H) JMP 4D59H      ; LCD, CRT, and LPT file close routine

15A0H  (23H) INX H
15A1H  (23H) INX H
15A2H  (7EH) MOV A,M
15A3H  (23H) INX H
15A4H  (66H) MOV H,M
15A5H  (6FH) MOV L,A
15A6H  (2BH) DCX H
15A7H  (7EH) MOV A,M
15A8H  (E6H) ANI FDH
15AAH  (77H) MOV M,A
15ABH  (C9H) RET

; ======================================================
; Output to RAM file
; ======================================================
15ACH  (F1H) POP PSW
15ADH  (F5H) PUSH PSW
15AEH  (01H) LXI B,14EAH
15B1H  (C5H) PUSH B
15B2H  (A7H) ANA A
15B3H  (C8H) RZ
15B4H  (FEH) CPI 1AH
15B6H  (C8H) RZ
15B7H  (FEH) CPI 7FH
15B9H  (C8H) RZ
15BAH  (CDH) CALL 1739H
15BDH  (C0H) RNZ
15BEH  (01H) LXI B,0100H
15C1H  (C3H) JMP 1621H

; ======================================================
; Input from RAM file
; ======================================================
15C4H  (EBH) XCHG
15C5H  (CDH) CALL 1675H
15C8H  (CDH) CALL 18C7H
15CBH  (EBH) XCHG
15CCH  (CDH) CALL 1749H
15CFH  (C2H) JNZ 1609H
15D2H  (EBH) XCHG
15D3H  (2AH) LHLD FC87H
15D6H  (DFH) RST 3          ; Compare DE and HL
15D7H  (F5H) PUSH PSW
15D8H  (D5H) PUSH D
15D9H  (C4H) CNZ 2146H      ; Update line addresses for ALL BASIC programs
15DCH  (E1H) POP H
15DDH  (F1H) POP PSW
15DEH  (01H) LXI B,FFF9H
15E1H  (09H) DAD B
15E2H  (5EH) MOV E,M
15E3H  (23H) INX H
15E4H  (56H) MOV D,M
15E5H  (EBH) XCHG
15E6H  (7EH) MOV A,M
15E7H  (23H) INX H
15E8H  (66H) MOV H,M
15E9H  (6FH) MOV L,A
15EAH  (C2H) JNZ 15F5H
15EDH  (D5H) PUSH D
15EEH  (EBH) XCHG
15EFH  (2AH) LHLD FAD8H
15F2H  (EBH) XCHG
15F3H  (19H) DAD D
15F4H  (D1H) POP D
15F5H  (EBH) XCHG
15F6H  (23H) INX H
15F7H  (23H) INX H
15F8H  (23H) INX H
15F9H  (23H) INX H
15FAH  (4EH) MOV C,M
15FBH  (23H) INX H
15FCH  (46H) MOV B,M
15FDH  (34H) INR M
15FEH  (23H) INX H
15FFH  (EBH) XCHG
1600H  (09H) DAD B
1601H  (06H) MVI B,00H
1603H  (CDH) CALL 2542H     ; Move B bytes from M to (DE)
1606H  (EBH) XCHG
1607H  (25H) DCR H
1608H  (AFH) XRA A
1609H  (4FH) MOV C,A
160AH  (09H) DAD B
160BH  (7EH) MOV A,M
160CH  (FEH) CPI 1AH
160EH  (37H) STC
160FH  (3FH) CMC
1610H  (C2H) JNZ 4E8AH
1613H  (CDH) CALL 1675H
1616H  (77H) MOV M,A
1617H  (37H) STC
1618H  (C3H) JMP 4E8AH

; ======================================================
; Special RAM file I/O vector
; ======================================================
161BH  (CDH) CALL 1675H
161EH  (C3H) JMP 17CDH

1621H  (E5H) PUSH H
1622H  (C5H) PUSH B
1623H  (E5H) PUSH H
1624H  (EBH) XCHG
1625H  (2AH) LHLD FC87H
1628H  (DFH) RST 3          ; Compare DE and HL
1629H  (C4H) CNZ 2146H      ; Update line addresses for ALL BASIC programs
162CH  (E1H) POP H
162DH  (2BH) DCX H
162EH  (56H) MOV D,M
162FH  (2BH) DCX H
1630H  (5EH) MOV E,M
1631H  (EBH) XCHG
1632H  (C1H) POP B
1633H  (C5H) PUSH B
1634H  (E5H) PUSH H
1635H  (09H) DAD B
1636H  (EBH) XCHG
1637H  (73H) MOV M,E
1638H  (23H) INX H
1639H  (72H) MOV M,D
163AH  (01H) LXI B,FFFAH
163DH  (09H) DAD B
163EH  (5EH) MOV E,M
163FH  (23H) INX H
1640H  (56H) MOV D,M
1641H  (1AH) LDAX D
1642H  (6FH) MOV L,A
1643H  (13H) INX D
1644H  (1AH) LDAX D
1645H  (67H) MOV H,A
1646H  (C1H) POP B
1647H  (09H) DAD B
1648H  (C1H) POP B
1649H  (E5H) PUSH H
164AH  (C5H) PUSH B
164BH  (CDH) CALL 6B6DH     ; Insert BC spaces at M
164EH  (D4H) CNC 18DDH
1651H  (C1H) POP B
1652H  (D1H) POP D
1653H  (E1H) POP H
1654H  (DAH) JC 1669H
1657H  (E5H) PUSH H
1658H  (7EH) MOV A,M
1659H  (12H) STAX D
165AH  (13H) INX D
165BH  (23H) INX H
165CH  (0DH) DCR C
165DH  (C2H) JNZ 1658H
1660H  (D1H) POP D
1661H  (2AH) LHLD FC87H
1664H  (DFH) RST 3          ; Compare DE and HL
1665H  (C8H) RZ
1666H  (C3H) JMP 2146H      ; Update line addresses for ALL BASIC programs

1669H  (01H) LXI B,FFF7H
166CH  (09H) DAD B
166DH  (36H) MVI M,00H
166FH  (CDH) CALL 15A0H
1672H  (C3H) JMP 3F17H

; ======================================================
; Special RAM file I/O
; ======================================================
1675H  (D5H) PUSH D
1676H  (2AH) LHLD FAA2H
1679H  (11H) LXI D,FA91H
167CH  (19H) DAD D
167DH  (D1H) POP D
167EH  (C9H) RET

; ======================================================
; CAS device control block
; ======================================================
167FH  DW   1689H,16ADH,16C7H,16D2H
1687H  DW   1710H

; ======================================================
; Open CAS file
; ======================================================
1689H  (E5H) PUSH H
168AH  (D5H) PUSH D
168BH  (01H) LXI B,0006H
168EH  (09H) DAD B
168FH  (AFH) XRA A
1690H  (77H) MOV M,A
1691H  (32H) STA FA8EH
1694H  (7BH) MOV A,E
1695H  (FEH) CPI 08H
1697H  (CAH) JZ 504EH       ; Generate NM error
169AH  (FEH) CPI 01H
169CH  (CAH) JZ 16A7H
169FH  (CDH) CALL 260EH     ; Open CAS for output of TEXT files
16A2H  (D1H) POP D
16A3H  (E1H) POP H
16A4H  (C3H) JMP 14DEH

16A7H  (CDH) CALL 2653H     ; Open CAS for input of TEXT files
16AAH  (C3H) JMP 16A2H

; ======================================================
; Close CAS file
; ======================================================
16ADH  (CDH) CALL 172AH
16B0H  (CAH) JZ 16C0H
16B3H  (E5H) PUSH H
16B4H  (09H) DAD B
16B5H  (36H) MVI M,1AH
16B7H  (23H) INX H
16B8H  (0CH) INR C
16B9H  (C2H) JNZ 16B5H
16BCH  (E1H) POP H
16BDH  (CDH) CALL 1716H
16C0H  (AFH) XRA A
16C1H  (32H) STA FA8EH
16C4H  (C3H) JMP 4D59H      ; LCD, CRT, and LPT file close routine

; ======================================================
; Output to CAS file
; ======================================================
16C7H  (F1H) POP PSW
16C8H  (F5H) PUSH PSW
16C9H  (CDH) CALL 1739H
16CCH  (CCH) CZ 1716H
16CFH  (C3H) JMP 14EAH

; ======================================================
; Input from CAS file
; ======================================================
16D2H  (EBH) XCHG
16D3H  (21H) LXI H,FA8EH
16D6H  (CDH) CALL 18C7H
16D9H  (EBH) XCHG
16DAH  (CDH) CALL 1749H
16DDH  (C2H) JNZ 16FFH
16E0H  (E5H) PUSH H
16E1H  (CDH) CALL 26D1H
16E4H  (E1H) POP H
16E5H  (01H) LXI B,0000H
16E8H  (CDH) CALL 14B0H     ; Read byte from tape & update checksum
16EBH  (77H) MOV M,A
16ECH  (23H) INX H
16EDH  (05H) DCR B
16EEH  (C2H) JNZ 16E8H
16F1H  (CDH) CALL 14B0H     ; Read byte from tape & update checksum
16F4H  (79H) MOV A,C
16F5H  (A7H) ANA A
16F6H  (C2H) JNZ 1491H      ; Turn cassette motor off and generate I/O Error
16F9H  (CDH) CALL 14AAH     ; Turn cassette motor off
16FCH  (25H) DCR H
16FDH  (AFH) XRA A
16FEH  (47H) MOV B,A
16FFH  (4FH) MOV C,A
1700H  (09H) DAD B
1701H  (7EH) MOV A,M
1702H  (FEH) CPI 1AH
1704H  (37H) STC
1705H  (3FH) CMC
1706H  (C2H) JNZ 4E8AH
1709H  (32H) STA FA8EH
170CH  (37H) STC
170DH  (C3H) JMP 4E8AH

1710H  (21H) LXI H,FA8EH
1713H  (C3H) JMP 17CDH

1716H  (E5H) PUSH H
1717H  (CDH) CALL 2648H
171AH  (E1H) POP H
171BH  (01H) LXI B,0000H
171EH  (7EH) MOV A,M
171FH  (CDH) CALL 14C1H     ; Write byte to tape & update checksum
1722H  (23H) INX H
1723H  (05H) DCR B
1724H  (C2H) JNZ 171EH
1727H  (C3H) JMP 2635H

172AH  (7EH) MOV A,M
172BH  (FEH) CPI 01H
172DH  (C8H) RZ
172EH  (01H) LXI B,0006H
1731H  (09H) DAD B
1732H  (7EH) MOV A,M
1733H  (4FH) MOV C,A
1734H  (36H) MVI M,00H
1736H  (C3H) JMP 174FH

1739H  (5FH) MOV E,A
173AH  (01H) LXI B,0006H
173DH  (09H) DAD B
173EH  (7EH) MOV A,M
173FH  (34H) INR M
1740H  (23H) INX H
1741H  (23H) INX H
1742H  (23H) INX H
1743H  (E5H) PUSH H
1744H  (4FH) MOV C,A
1745H  (09H) DAD B
1746H  (73H) MOV M,E
1747H  (E1H) POP H
1748H  (C9H) RET

1749H  (01H) LXI B,0006H
174CH  (09H) DAD B
174DH  (7EH) MOV A,M
174EH  (34H) INR M
174FH  (23H) INX H
1750H  (23H) INX H
1751H  (23H) INX H
1752H  (A7H) ANA A
1753H  (C9H) RET

; ======================================================
; LPT device control block
; ======================================================
1754H  DW   14D8H,4D59H,175AH

; ======================================================
; Output to LPT file
; ======================================================
175AH  (F1H) POP PSW
175BH  (F5H) PUSH PSW
175CH  (CDH) CALL 4B55H     ; Print A to printer, expanding tabs if necessary
175FH  (C3H) JMP 14EAH

; ======================================================
; COM device control block
; ======================================================
1762H  DW   176DH,179EH,17A8H,17B0H
176AH  DW   17CAH

; ======================================================
; Open MDM file
; ======================================================
176CH  (F6H) ORI 37H
176EH  (F5H) PUSH PSW
176FH  (DCH) CC 52BBH       ; Disconnect phone line and disable modem carrier
1772H  (F1H) POP PSW
1773H  (F5H) PUSH PSW
1774H  (E5H) PUSH H
1775H  (D5H) PUSH D
1776H  (21H) LXI H,FC93H    ; Filename of current BASIC program
1779H  (CDH) CALL 17E6H     ; Set RS232 parameters from string at M
177CH  (D1H) POP D
177DH  (7BH) MOV A,E
177EH  (FEH) CPI 08H
1780H  (CAH) JZ 504EH       ; Generate NM error
1783H  (D6H) SUI 01H
1785H  (C2H) JNZ 178BH
1788H  (32H) STA FA8FH
178BH  (E1H) POP H
178CH  (F1H) POP PSW
178DH  (DAH) JC 14DEH
1790H  (CDH) CALL 52E4H     ; Go off-hook and wait for carrier
1793H  (DAH) JC 1494H       ; Generate I/O error
1796H  (3EH) MVI A,02H
1798H  (CDH) CALL 5316H
179BH  (C3H) JMP 14DEH

; ======================================================
; Close COM file
; ======================================================
179EH  (CDH) CALL 6ECBH     ; Deactivate RS232 or modem
17A1H  (AFH) XRA A
17A2H  (32H) STA FA8FH
17A5H  (C3H) JMP 4D59H      ; LCD, CRT, and LPT file close routine

; ======================================================
; Output to COM/MDM file
; ======================================================
17A8H  (F1H) POP PSW
17A9H  (F5H) PUSH PSW
17AAH  (CDH) CALL 6E32H     ; Send character in A to serial port using XON/XOFF
17ADH  (C3H) JMP 14EAH

; ======================================================
; Input from COM/MDM file
; ======================================================
17B0H  (21H) LXI H,FA8FH
17B3H  (CDH) CALL 18C7H
17B6H  (CDH) CALL 6D7EH     ; Get a character from RS232 receive queue
17B9H  (DAH) JC 1494H       ; Generate I/O error
17BCH  (FEH) CPI 1AH
17BEH  (37H) STC
17BFH  (3FH) CMC
17C0H  (C2H) JNZ 4E8AH
17C3H  (32H) STA FA8FH
17C6H  (37H) STC
17C7H  (C3H) JMP 4E8AH

; ======================================================
; Special COM/MDM file I/O
; ======================================================
17CAH  (21H) LXI H,FA8FH
17CDH  (71H) MOV M,C
17CEH  (C3H) JMP 5023H

; ======================================================
; MDM Device control block
; ======================================================
17D1H  DW   176CH,17DBH,17A8H,17B0H
17D9H  DW   17CAH

; ======================================================
; Close MDM file
; ======================================================
17DBH  (3EH) MVI A,02H
17DDH  (CDH) CALL 5316H
17E0H  (CDH) CALL 52BBH     ; Disconnect phone line and disable modem carrier
17E3H  (C3H) JMP 179EH      ; Close COM file

; ======================================================
; Set RS232 parameters from string at M
; ======================================================
17E6H  (F5H) PUSH PSW
17E7H  (01H) LXI B,504EH
17EAH  (C5H) PUSH B
17EBH  (D2H) JNC 17F7H
17EEH  (7EH) MOV A,M
17EFH  (D6H) SUI 31H
17F1H  (FEH) CPI 09H
17F3H  (D0H) RNC
17F4H  (3CH) INR A
17F5H  (57H) MOV D,A
17F6H  (23H) INX H
17F7H  (7EH) MOV A,M
17F8H  (D6H) SUI 36H
17FAH  (FEH) CPI 03H
17FCH  (D0H) RNC
17FDH  (3CH) INR A
17FEH  (87H) ADD A
17FFH  (87H) ADD A
1800H  (87H) ADD A
1801H  (5FH) MOV E,A
1802H  (23H) INX H
1803H  (CDH) CALL 0FE8H     ; Get char at M and convert to uppercase
1806H  (FEH) CPI 49H
1808H  (C2H) JNZ 181CH
180BH  (7BH) MOV A,E
180CH  (FEH) CPI 18H
180EH  (C8H) RZ
180FH  (C6H) ADI 0CH
1811H  (5FH) MOV E,A
1812H  (E6H) ANI 08H
1814H  (87H) ADD A
1815H  (87H) ADD A
1816H  (87H) ADD A
1817H  (F6H) ORI 3FH
1819H  (C3H) JMP 1832H

181CH  (FEH) CPI 45H
181EH  (06H) MVI B,02H
1820H  (CAH) JZ 182DH
1823H  (D6H) SUI 4EH
1825H  (06H) MVI B,04H
1827H  (CAH) JZ 182DH
182AH  (3DH) DCR A
182BH  (C0H) RNZ
182CH  (47H) MOV B,A
182DH  (78H) MOV A,B
182EH  (B3H) ORA E
182FH  (5FH) MOV E,A
1830H  (3EH) MVI A,FFH
1832H  (32H) STA FF8DH      ; RS232 Parity Control byte
1835H  (23H) INX H
1836H  (7EH) MOV A,M
1837H  (D6H) SUI 31H
1839H  (FEH) CPI 02H
183BH  (D0H) RNC
183CH  (B3H) ORA E
183DH  (5FH) MOV E,A
183EH  (23H) INX H
183FH  (CDH) CALL 0FE8H     ; Get char at M and convert to uppercase
1842H  (FEH) CPI 44H
1844H  (CAH) JZ 184EH
1847H  (FEH) CPI 45H
1849H  (C0H) RNZ
184AH  (CDH) CALL 6F31H     ; Enable XON/OFF when CTRL-S / CTRL-Q sent
184DH  (37H) STC
184EH  (D4H) CNC 6F32H
1851H  (C1H) POP B
1852H  (F1H) POP PSW
1853H  (F5H) PUSH PSW
1854H  (D5H) PUSH D
1855H  (2BH) DCX H
1856H  (2BH) DCX H
1857H  (2BH) DCX H
1858H  (2BH) DCX H
1859H  (11H) LXI D,F65BH    ; RS232 parameter setting table
185CH  (06H) MVI B,05H
185EH  (7EH) MOV A,M
185FH  (DAH) JC 1864H
1862H  (3EH) MVI A,4DH
1864H  (12H) STAX D
1865H  (23H) INX H
1866H  (13H) INX D
1867H  (CDH) CALL 0FE8H     ; Get char at M and convert to uppercase
186AH  (05H) DCR B
186BH  (C2H) JNZ 1864H
186EH  (EBH) XCHG
186FH  (E1H) POP H
1870H  (F1H) POP PSW
1871H  (D5H) PUSH D
1872H  (CDH) CALL 6EA6H     ; Initialize RS232 or modem
1875H  (E1H) POP H
1876H  (C9H) RET

; ======================================================
; Wand device control block
; ======================================================
1877H  DW   1881H,1883H,08DBH,1885H
187FH  DW   1887H

; ======================================================
; Wand device vectors
; ======================================================
1881H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
1882H  DB   46H
1883H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
1884H  DB   48H
1885H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
1886H  DB   4AH
1887H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
1888H  DB   4CH

; ======================================================
; EOF function
; ======================================================
1889H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
188AH  DB   26H
188BH  (CDH) CALL 4C81H
188EH  (CAH) JZ 505AH       ; Generate CF error
1891H  (FEH) CPI 01H
1893H  (C2H) JNZ 504EH      ; Generate NM error
1896H  (E5H) PUSH H
1897H  (CDH) CALL 18BFH
189AH  (4FH) MOV C,A
189BH  (9FH) SBB A
189CH  (CDH) CALL 340AH
189FH  (E1H) POP H
18A0H  (23H) INX H
18A1H  (23H) INX H
18A2H  (23H) INX H
18A3H  (23H) INX H
18A4H  (7EH) MOV A,M
18A5H  (21H) LXI H,FA8FH
18A8H  (FEH) CPI FCH
18AAH  (CAH) JZ 18BDH
18ADH  (FEH) CPI F9H
18AFH  (CAH) JZ 18BDH
18B2H  (CDH) CALL 1675H
18B5H  (FEH) CPI F8H
18B7H  (CAH) JZ 18BDH
18BAH  (21H) LXI H,FA8EH
18BDH  (71H) MOV M,C
18BEH  (C9H) RET

18BFH  (C5H) PUSH B
18C0H  (E5H) PUSH H
18C1H  (D5H) PUSH D
18C2H  (3EH) MVI A,06H
18C4H  (C3H) JMP 5123H

18C7H  (7EH) MOV A,M
18C8H  (36H) MVI M,00H
18CAH  (A7H) ANA A
18CBH  (C8H) RZ
18CCH  (33H) INX SP
18CDH  (33H) INX SP
18CEH  (FEH) CPI 1AH
18D0H  (37H) STC
18D1H  (3FH) CMC
18D2H  (C2H) JNZ 4E8AH
18D5H  (77H) MOV M,A
18D6H  (37H) STC
18D7H  (C3H) JMP 4E8AH

; ======================================================
; This routine is walking up the BASIC execution stack and modifying
; the address of the control variable for FOR loop entries for some
; reason.  Still need to figure out why?
; ======================================================
18DAH  (01H) LXI B,0001H
18DDH  (2AH) LHLD FB9DH     ; SP used by BASIC to reinitialize the stack
18E0H  (7EH) MOV A,M        ; Get next byte from stack
18E1H  (A7H) ANA A          ; Test for zero (end of stack)
18E2H  (C8H) RZ             ; Return if at bottom of stack
18E3H  (EBH) XCHG
18E4H  (2AH) LHLD F678H     ; BASIC string buffer pointer
18E7H  (EBH) XCHG
18E8H  (DFH) RST 3          ; Compare DE and HL
18E9H  (D0H) RNC
18EAH  (7EH) MOV A,M
18EBH  (FEH) CPI 81H        ; Test if token that PUSHed the stack was FOR
18EDH  (11H) LXI D,0007H    ; Prepare to advance up the stack by 7 bytes (amount pushed by GOSUB)
18F0H  (C2H) JNZ 1900H      ; Jump to add 7 if not FOR statement
18F3H  (23H) INX H          ; Increment to address of loop control value
18F4H  (5EH) MOV E,M        ; Get LSB of FOR loop control variable
18F5H  (23H) INX H          ; Increment to MSB
18F6H  (56H) MOV D,M        ; Get MSB of FOR loop control variable
18F7H  (EBH) XCHG           ; Put address in HL
18F8H  (09H) DAD B          ; Point to original FOR loop source variable perhaps?
18F9H  (EBH) XCHG           ; HL=stack, DE=address of variable
18FAH  (72H) MOV M,D        ; Put new variable address on stack?
18FBH  (2BH) DCX H          ; Decrement to LSB
18FCH  (73H) MOV M,E        ; Put LSB of new variable location on stack?
18FDH  (11H) LXI D,0018H    ; FOR loop occupies 18H bytes on stack
1900H  (19H) DAD D          ; Rewind the FOR loop
1901H  (C3H) JMP 18E0H      ; Jump to process next stack level

; ======================================================
; TIME$ function
; ======================================================
1904H  (D7H) RST 2          ; Get next non-white char from M
1905H  (E5H) PUSH H         ; Save pointer to BASIC string on stack
1906H  (CDH) CALL 198DH     ; Create an 8-byte transient string and return address in HL
1909H  (CDH) CALL 190FH     ; Read time and store it at M
190CH  (C3H) JMP 278DH      ; Add new transient string to string stack

; ======================================================
; Read time and store it at M
; ======================================================
190FH  (CDH) CALL 19A0H     ; Update in-memory (F923H) clock values
1912H  (11H) LXI D,F928H    ; Hours (tens) - Load pointer to Time string
1915H  (CDH) CALL 1996H     ; Hours - Convert 2 binary digits at (DE) to ASCII digits at (HL) and increment
1918H  (36H) MVI M,3AH      ; Add a ":" between hours and minutes
191AH  (23H) INX H          ; Increment string pointer
191BH  (CDH) CALL 1996H     ; Convert 2 binary digits at (DE) to ASCII digits at (HL) and increment
191EH  (36H) MVI M,3AH      ; Add a ":" between minutes and seconds

; ======================================================
; Convert 2 binary digits at (DE) to ASCII digits at (HL+1) and increment
; ======================================================
1920H  (23H) INX H          ; Increment string pointer
1921H  (C3H) JMP 1996H      ; Convert 2 binary digits at (DE) to ASCII digits at (HL) and increment

; ======================================================
; DATE$ function
; ======================================================
1924H  (D7H) RST 2          ; Get next non-white char from M
1925H  (E5H) PUSH H         ; Save pointer to BASIC command line
1926H  (CDH) CALL 198DH     ; Create an 8-byte transient string and return address in HL
1929H  (CDH) CALL 192FH     ; DATE$ function
192CH  (C3H) JMP 278DH      ; Add new transient string to string stack

; ======================================================
; DATE$ function handler
; ======================================================
192FH  (CDH) CALL 19A0H     ; Update in-memory (F923H) clock values
1932H  (11H) LXI D,F92CH    ; Load pointer to Month (1-12) from clock chip
1935H  (1AH) LDAX D         ; Load month value
1936H  (FEH) CPI 0AH        ; Test if month >= 10
1938H  (06H) MVI B,30H      ; Load ASCII '0' in case month < 10
193AH  (DAH) JC 1941H       ; Jump to save '0' as 1st digit of month if month < 10
193DH  (06H) MVI B,31H      ; Load ASCII '1' for 1st digit of month
193FH  (D6H) SUI 0AH        ; Subtract 10 from month to convert to ASCII
1941H  (70H) MOV M,B        ; Save 1st digit of month to output string
1942H  (23H) INX H          ; Increment to 2nd digit of month
1943H  (CDH) CALL 199AH     ; Convert binary digit in A to ASCII digit at (HL) and increment
1946H  (1BH) DCX D          ; Decrement pointer to days in clock chip registers
1947H  (36H) MVI M,2FH      ; Add a '/' between month and day
1949H  (23H) INX H          ; Increment output string pointer
194AH  (CDH) CALL 1996H     ; Convert 2 binary digits at (DE) to ASCII digits at (HL) and increment     
194DH  (36H) MVI M,2FH      ; Add a '/' between day and year
194FH  (11H) LXI D,F92EH    ; Load pointer to Year (tens)
1952H  (C3H) JMP 1920H      ; Convert 2 binary digits at (DE) to ASCII digits at (HL+1) and increment

; ======================================================
; DAY function
; ======================================================
1955H  (D7H) RST 2          ; Get next non-white char from M
1956H  (E5H) PUSH H         ; Preserve HL on stack
1957H  (3EH) MVI A,03H      ; Prepare to create a 3-byte string
1959H  (CDH) CALL 198FH     ; Create a string with length A and return address in HL
195CH  (CDH) CALL 1962H     ; Read day and store at M
195FH  (C3H) JMP 278DH      ; Add new transient string to string stack

; ======================================================
; Read day and store at M
; ======================================================
1962H  (CDH) CALL 19A0H     ; Update in-memory (F923H) clock values
1965H  (3AH) LDA F92BH      ; Day code (0=Sun, 1=Mon, etc.)
1968H  (4FH) MOV C,A        ; Save the day code in A
1969H  (87H) ADD A          ; Multiply day code x2
196AH  (81H) ADD C          ; Multiply day code x3 (size of ASCII days)
196BH  (4FH) MOV C,A        ; Move day code x3 to C for offset into Day table
196CH  (06H) MVI B,00H      ; Zero out MSB of BC for add
196EH  (EBH) XCHG           ; Save HL (the pointer to BASIC string)
196FH  (21H) LXI H,1978H    ; Load pointer to ASCII table with Days
1972H  (09H) DAD B          ; Index into Day ASCII table
1973H  (06H) MVI B,03H      ; Prepare to copy 3 bytes from Day table
1975H  (C3H) JMP 2542H      ; Move B bytes from M to (DE)

; ======================================================
; Table of ASCII Days
; ======================================================
1978H  DB   "Sun"
197BH  DB   "Mon"
197EH  DB   "Tue"
1981H  DB   "Wed"           ; Do I really need to explain these line by line? :)
1984H  DB   "Thu"
1987H  DB   "Fri"
198AH  DB   "Sat"

; ======================================================
; Create an 8-byte transient string and return address in HL
; ======================================================
198DH  (3EH) MVI A,08H      ; Prepare to create an 8-byte transient string

; ======================================================
; Create a string with length A and return address in HL
; ======================================================
198FH  (CDH) CALL 275DH     ; Create a transient string of length A
1992H  (2AH) LHLD FB8AH     ; Address of transient string
1995H  (C9H) RET

; ======================================================
; Convert 2 binary digits at (DE) to ASCII digits at (HL) and increment
; ======================================================
1996H  (CDH) CALL 1999H     ; Convert binary digit at (DE) to ASCII digit at (HL)

; ======================================================
; Convert binary digit at (DE) to ASCII digit at (HL) and increment
;
; Decrements DE and increments HL
; ======================================================
1999H  (1AH) LDAX D         ; Load binary value

; ======================================================
; Convert binary digit in A to ASCII digit at (HL) and increment
;
; Decrements DE and increments HL
; ======================================================
199AH  (F6H) ORI 30H        ; Convert to ASCII digit
199CH  (77H) MOV M,A        ; Save ASCII digit at M
199DH  (1BH) DCX D          ; Decrement source pointer
199EH  (23H) INX H          ; Increment destination pointer
199FH  (C9H) RET

; ======================================================
; Update in-memory (F923H) clock values
; ======================================================
19A0H  (E5H) PUSH H         ; Preserve BASIC string pointer to stack
19A1H  (21H) LXI H,F923H    ; Seconds (ones)
19A4H  (F3H) DI             ; Disable interrupts during copy
19A5H  (CDH) CALL 7329H     ; Copy clock chip regs to M
19A8H  (FBH) EI             ; Re-enable interrupts
19A9H  (E1H) POP H          ; Restore BASIC string pointer
19AAH  (C9H) RET

; ======================================================
; TIME$ statement
; ======================================================
19ABH  (FEH) CPI DDH        ; Test for '=' token
19ADH  (C2H) JNZ 1AA5H      ; Jump to process ON/OFF/STOP arguments
19B0H  (CDH) CALL 1A42H     ; Get time string from command line

; ======================================================
; Update clock chip from memory F923H
; ======================================================
19B3H  (21H) LXI H,F923H    ; Seconds (ones)
19B6H  (F3H) DI
19B7H  (CDH) CALL 732AH     ; Update clock chip regs from M
19BAH  (FBH) EI
19BBH  (E1H) POP H
19BCH  (C9H) RET

; ======================================================
; DATE$ statement
; ======================================================
19BDH  (CDH) CALL 1A2CH
19C0H  (C2H) JNZ 0446H      ; Generate Syntax error
19C3H  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
19C6H  (3DH) DCR A
19C7H  (FEH) CPI 0CH
19C9H  (D2H) JNC 0446H      ; Generate Syntax error
19CCH  (3CH) INR A
19CDH  (11H) LXI D,F92CH    ; Month (1-12)
19D0H  (12H) STAX D
19D1H  (CFH) RST 1          ; Compare next byte with M
19D2H  DB   2FH
19D3H  (1BH) DCX D
19D4H  (CDH) CALL 1A6AH
19D7H  (FEH) CPI 04H
19D9H  (D2H) JNC 0446H      ; Generate Syntax error
19DCH  (CDH) CALL 1A6AH
19DFH  (CFH) RST 1          ; Compare next byte with M
19E0H  DB   2FH
19E1H  (11H) LXI D,F92FH
19E4H  (CDH) CALL 1A6AH
19E7H  (CDH) CALL 1A6AH
19EAH  (AFH) XRA A
19EBH  (32H) STA F655H
19EEH  (C3H) JMP 19B3H      ; Update clock chip from memory F923H

; ======================================================
; DAY$ statement
; ======================================================
19F1H  (CDH) CALL 1A2CH
19F4H  (FEH) CPI 03H
19F6H  (C2H) JNZ 0446H      ; Generate Syntax error
19F9H  (11H) LXI D,1978H
19FCH  (0EH) MVI C,07H
19FEH  (E5H) PUSH H
19FFH  (06H) MVI B,03H
1A01H  (1AH) LDAX D
1A02H  (D5H) PUSH D
1A03H  (CDH) CALL 0FE9H     ; Convert A to uppercase
1A06H  (5FH) MOV E,A
1A07H  (CDH) CALL 0FE8H     ; Get char at M and convert to uppercase
1A0AH  (BBH) CMP E
1A0BH  (D1H) POP D
1A0CH  (C2H) JNZ 1A1FH
1A0FH  (13H) INX D
1A10H  (23H) INX H
1A11H  (05H) DCR B
1A12H  (C2H) JNZ 1A01H
1A15H  (E1H) POP H
1A16H  (3EH) MVI A,07H
1A18H  (91H) SUB C
1A19H  (32H) STA F92BH      ; Day code (0=Sun, 1=Mon, etc.)
1A1CH  (C3H) JMP 19B3H      ; Update clock chip from memory F923H

1A1FH  (13H) INX D
1A20H  (05H) DCR B
1A21H  (C2H) JNZ 1A1FH
1A24H  (E1H) POP H
1A25H  (0DH) DCR C
1A26H  (C2H) JNZ 19FEH
1A29H  (C3H) JMP 0446H      ; Generate Syntax error

1A2CH  (CFH) RST 1          ; Compare next byte with M
1A2DH  DB   DDH
1A2EH  (CDH) CALL 0DABH     ; Main BASIC evaluation routine
1A31H  (E3H) XTHL
1A32H  (E5H) PUSH H
1A33H  (CDH) CALL 19A0H     ; Update in-memory (F923H) clock values
1A36H  (CDH) CALL 2916H     ; Get pointer to most recently used string (Len + address)
1A39H  (7EH) MOV A,M
1A3AH  (23H) INX H
1A3BH  (5EH) MOV E,M
1A3CH  (23H) INX H
1A3DH  (66H) MOV H,M
1A3EH  (6BH) MOV L,E
1A3FH  (FEH) CPI 08H
1A41H  (C9H) RET

; ======================================================
; Get time string from command line
; ======================================================
1A42H  (CDH) CALL 1A2CH
1A45H  (C2H) JNZ 0446H      ; Generate Syntax error
1A48H  (EBH) XCHG
1A49H  (E1H) POP H
1A4AH  (E3H) XTHL
1A4BH  (E5H) PUSH H
1A4CH  (EBH) XCHG
1A4DH  (11H) LXI D,F929H    ; Date (ones)
1A50H  (CDH) CALL 1A6AH
1A53H  (FEH) CPI 03H
1A55H  (D2H) JNC 0446H      ; Generate Syntax error
1A58H  (CDH) CALL 1A6AH
1A5BH  (CFH) RST 1          ; Compare next byte with M
1A5CH  DB   3AH
1A5DH  (CDH) CALL 1A62H
1A60H  (CFH) RST 1          ; Compare next byte with M
1A61H  DB   3AH
1A62H  (CDH) CALL 1A6AH
1A65H  (FEH) CPI 06H
1A67H  (D2H) JNC 0446H      ; Generate Syntax error
1A6AH  (1BH) DCX D
1A6BH  (7EH) MOV A,M
1A6CH  (23H) INX H
1A6DH  (D6H) SUI 30H
1A6FH  (FEH) CPI 0AH
1A71H  (D2H) JNC 0446H      ; Generate Syntax error
1A74H  (E6H) ANI 0FH
1A76H  (12H) STAX D
1A77H  (C9H) RET

; ======================================================
; IPL statement
; ======================================================
1A78H  (CAH) JZ 1A96H       ; Erase current IPL program
1A7BH  (CDH) CALL 1A2EH
1A7EH  (A7H) ANA A
1A7FH  (CAH) JZ 1A95H
1A82H  (FEH) CPI 0AH
1A84H  (D2H) JNC 08DBH      ; Generate FC error
1A87H  (47H) MOV B,A
1A88H  (EBH) XCHG
1A89H  (21H) LXI H,FAAFH    ; Start of IPL filename
1A8CH  (CDH) CALL 3469H     ; Move B bytes from (DE) to M with increment
1A8FH  (36H) MVI M,0DH
1A91H  (23H) INX H
1A92H  (70H) MOV M,B
1A93H  (E1H) POP H
1A94H  (C9H) RET

1A95H  (E1H) POP H

; ======================================================
; Erase current IPL program
; ======================================================
1A96H  (AFH) XRA A
1A97H  (32H) STA FAAFH      ; Start of IPL filename
1A9AH  (32H) STA FAB0H
1A9DH  (C9H) RET

; ======================================================
; COM and MDM statements
; ======================================================
1A9EH  (E5H) PUSH H
1A9FH  (21H) LXI H,F944H    ; On Com flag
1AA2H  (C3H) JMP 1AA9H

; ======================================================
; Process TIME$ ON/OFF/STOP statements
; ======================================================
1AA5H  (E5H) PUSH H         ; Preserve HL (BASIC string pointer) on stack
1AA6H  (21H) LXI H,F947H    ; Load pointer to On Time flag
1AA9H  (CDH) CALL 1AEAH     ; Determine argument (ON/OFF/STOP) for TIME$ statement

; ======================================================
; Restore HL from stack, pop return address and jump to BASIC execution
; ======================================================
1AACH  (E1H) POP H          ; Retore HL
1AADH  (F1H) POP PSW        ; POP return address from stack (we jump directly to BASIC loop)
1AAEH  (D7H) RST 2          ; Get next non-white char from M
1AAFH  (C3H) JMP 0811H      ; Jump into BASIC execution loop

; ======================================================
; KEY() statement
; ======================================================
1AB2H  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
1AB5H  (3DH) DCR A          ; Make key selection zero based
1AB6H  (FEH) CPI 08H        ; Test if FKey selection > 7 (zero based)
1AB8H  (D2H) JNC 08DBH      ; Generate FC error if key value too big
1ABBH  (7EH) MOV A,M        ; Get 1st byte of FKey string
1ABCH  (E5H) PUSH H         ; Preserve HL (BASIC string pointer) on stack
1ABDH  (CDH) CALL 1AD4H     ; Process KEY() statement key number - KEY(x) ON/OFF/STOP
1AC0H  (C3H) JMP 1AACH      ; Restore HL from stack, pop return address and jump to BASIC execution

; ======================================================
; KEY STOP/ON/OFF statements
; ======================================================
1AC3H  (E5H) PUSH H         ; Preserve HL (BASIC string pointer) to stack
1AC4H  (1EH) MVI E,08H      ;
1AC6H  (D5H) PUSH D
1AC7H  (F5H) PUSH PSW
1AC8H  (CDH) CALL 1AD4H
1ACBH  (F1H) POP PSW
1ACCH  (D1H) POP D
1ACDH  (1DH) DCR E
1ACEH  (C2H) JNZ 1AC6H
1AD1H  (C3H) JMP 1AACH      ; Restore HL from stack, pop return address and jump to BASIC execution

; ======================================================
; Process KEY() statement key number
; ======================================================
1AD4H  (16H) MVI D,00H      ; Clear MSB of DE for index into KEY ON enabled table
1AD6H  (21H) LXI H,F62FH    ; Load pointer to KEY ON enabled table
1AD9H  (19H) DAD D          ; Index into KEY ON enabled table
1ADAH  (E5H) PUSH H         ; Push pointer to KEY ON enabled to stack
1ADBH  (21H) LXI H,F947H    ; On Time flag
1ADEH  (19H) DAD D          ; Add key number 3 times to index into ONx interrupt table
1ADFH  (19H) DAD D          ; ... once for ON-x trigger flag, another for LSB of handler
1AE0H  (19H) DAD D          ; ... and another for MSB of handler 
1AE1H  (CDH) CALL 1AEAH     ; Determine argument (ON/OFF/STOP) for TIME$ statement
1AE4H  (7EH) MOV A,M        ; Get trigger flag for this ONx interrupt
1AE5H  (E6H) ANI 01H        ; Test if this key was triggered
1AE7H  (E1H) POP H          ; Restore pointer to KEY ON enabled table
1AE8H  (77H) MOV M,A        ; Load code indicating if KEY ON enabled for this key
1AE9H  (C9H) RET

; ======================================================
; Determine argument (ON/OFF/STOP) for TIME$ and KEY statement
; ======================================================
1AEAH  (FEH) CPI 97H        ; Load code for ON token
1AECH  (CAH) JZ 3FA0H       ; TIME$ ON statement
1AEFH  (FEH) CPI CBH        ; Load code for OFF token
1AF1H  (CAH) JZ 3FB2H       ; TIME$ OFF statement
1AF4H  (FEH) CPI 8FH        ; Load code for STOP token
1AF6H  (CAH) JZ 3FB9H       ; TIME$ STOP statement
1AF9H  (C3H) JMP 0446H      ; Generate Syntax error

; ======================================================
; Determine device (KEY/TIME/COM/MDM) for ON GOSUB
; ======================================================
1AFCH  (FEH) CPI ADH        ; Compare with value of COM token
1AFEH  (01H) LXI B,0001H    ; Load value for COM/MDM device
1B01H  (C8H) RZ             ; Return if COM
1B02H  (FEH) CPI AEH        ; Compare with value of MDM token
1B04H  (C8H) RZ             ; Return if MDM
1B05H  (FEH) CPI AFH        ; Compare with value of KEY token
1B07H  (01H) LXI B,0208H    ; Load value for KEY device
1B0AH  (C8H) RZ             ; Return if KEY
1B0BH  (FEH) CPI AAH        ; Compare with value for TIME$ token
1B0DH  (37H) STC            ; Set C flag to indicate invalid device
1B0EH  (C0H) RNZ            ; Return if not TIME$ token

; ======================================================
; ON TIME$ statement
; ======================================================
1B0FH  (23H) INX H          ; Increment to next BASIC line text (Skip QUOTE perhaps?)
1B10H  (CDH) CALL 1A42H     ; Get time string from command line
1B13H  (21H) LXI H,F93DH    ; Time for ON TIME interrupt (SSHHMM)
1B16H  (06H) MVI B,06H      ; Prepare to copy 6 bytes of string "SSMMHH"
1B18H  (CDH) CALL 3469H     ; Move B bytes from (DE) to M with increment
1B1BH  (E1H) POP H          ; POP pointer to BASIC line string from stack
1B1CH  (2BH) DCX H          ; Decrement pointer.  Why?
1B1DH  (01H) LXI B,0101H    ; Load value for TIME$ device
1B20H  (A7H) ANA A          ; Clear C flag to indicate valid device
1B21H  (C9H) RET

; ======================================================
; ON COM handler - save line number for ON COM/KEY/TIME$
; ======================================================
1B22H  (E5H) PUSH H         ; Preserve HL on stack
1B23H  (47H) MOV B,A        ; Copy device number to B
1B24H  (87H) ADD A          ; Multiply device number x2
1B25H  (80H) ADD B          ; Multiply device number x3
1B26H  (6FH) MOV L,A        ; Move device number x 3 to L for index into ON COM table
1B27H  (26H) MVI H,00H      ; Clear MSB of index
1B29H  (01H) LXI B,F945H    ; On Com routine address
1B2CH  (09H) DAD B          ; Index into ON COM/KEY/TIME$ interrupt table
1B2DH  (73H) MOV M,E        ; Save LSB of line number to ON COM/KEY/TIME$ interrupt table
1B2EH  (23H) INX H          ; Increment to MSB of line number
1B2FH  (72H) MOV M,D        ; Save MSB of line number to ON COM/KEY/TIME$ interrupt table
1B30H  (E1H) POP H          ; Restore HL
1B31H  (C9H) RET

; ======================================================
; RST 7.5 interrupt routine (Background tick)
; ======================================================
1B32H  (CDH) CALL F5FFH     ; RST 7.5 RAM Vector
1B35H  (E5H) PUSH H         ; \
1B36H  (D5H) PUSH D         ;  \ Save all registers on stack
1B37H  (C5H) PUSH B         ;  /
1B38H  (F5H) PUSH PSW       ; /
1B39H  (3EH) MVI A,0DH      ; Prepare to re-enable RST 7.5 interrupt
1B3BH  (30H) SIM            ; Re-enable RST 7.5 interrupt
1B3CH  (FBH) EI             ; Re-enable interrupts
1B3DH  (21H) LXI H,F92FH    ; Load address of 2Hz count-down value
1B40H  (35H) DCR M          ; Decrement the 2Hz count-down counter
1B41H  (C2H) JNZ 1BAEH      ; Jump if not zero to skip 10Hz background logic
1B44H  (36H) MVI M,7DH      ; Re-load count-down value for 2 Hz
1B46H  (23H) INX H          ; Point to 6-minute count-down counter (F930H)
1B47H  (35H) DCR M          ; Decrement 6-minute count-down counter
1B48H  (C2H) JNZ 1B65H      ; Jump if not zero to refresh from clock chip
1B4BH  (36H) MVI M,0CH      ; Re-load 6-minute count-down value
1B4DH  (23H) INX H          ; Increment to power-down count-down
1B4EH  (E5H) PUSH H         ; Preserve HL on stack
1B4FH  (2AH) LHLD F67AH     ; Current executing line number
1B52H  (23H) INX H          ; Prepare to check if BASIC is executing.  Increment line #
1B53H  (7CH) MOV A,H        ; Get MSB of line number in A
1B54H  (B5H) ORA L          ; OR in LSB to test for zero (tests for FFFFH because of INX H)
1B55H  (E1H) POP H          ; Restore pointer to power-down count-down
1B56H  (C4H) CNZ 1BB1H      ; Renew automatic power-off counter if BASIC is executing
1B59H  (7EH) MOV A,M        ; Load current power-down count-down
1B5AH  (A7H) ANA A          ; Test if count-down is zero (disabled)
1B5BH  (CAH) JZ 1B65H       ; Skip power-down count-down if disabled
1B5EH  (35H) DCR M          ; Decrement power-down count-down (HL = F931H)
1B5FH  (C2H) JNZ 1B65H      ; Skip update of power-down enable flag if count != 0
1B62H  (23H) INX H          ; Increment to power-down enable flag
1B63H  (36H) MVI M,FFH      ; Set power-down enable flag (HL = F932H)
1B65H  (21H) LXI H,F933H    ; Load pointer to current time Seconds (ones)
1B68H  (E5H) PUSH H         ; Push pointer to current time on stack
1B69H  (CDH) CALL 7329H     ; Copy clock chip regs to M - Update the time
1B6CH  (D1H) POP D          ; Get pointer to current time in DE
1B6DH  (21H) LXI H,F93DH    ; Load pointer to time for ON TIME interrupt (SSHHMM)
1B70H  (06H) MVI B,06H      ; Prepare to compare 6 bytes of time to detect ON TIME interrupt
1B72H  (1AH) LDAX D         ; Load next byte of current time
1B73H  (96H) SUB M          ; Subtract ON TIME value 
1B74H  (C2H) JNZ 1B88H      ; Exit loop if it doesn't match
1B77H  (13H) INX D          ; Increment to next byte of current time
1B78H  (23H) INX H          ; Increment to next byte of ON TIME value
1B79H  (05H) DCR B          ; Decrement byte counter
1B7AH  (C2H) JNZ 1B72H      ; Jump to test next byte if count != 0
1B7DH  (B6H) ORA M          ; Test if ON TIME already triggered (F943H)
1B7EH  (C2H) JNZ 1B8CH      ; Jump to skip setting ON TIME interrupt if already triggered
1B81H  (21H) LXI H,F947H    ; On Time flag
1B84H  (CDH) CALL 3FD2H     ; Trigger interrupt.  HL points to interrupt table
1B87H  DB    3EH            ; Create a MVI A,AFH instruction using following byte.

; ======================================================
; Mark ON TIME interrupt as not triggered.  The XRA A is modified
; by the instruction above to "MVI A,AFH" for pass-thru code such
; that A has either AFH or zero.
; ======================================================
1B88H  (AFH) XRA A          ; Zero out A to indicate no ON TIME interrupt
1B89H  (32H) STA F943H      ; Save ON TIME interrupt indication (A has either AFH or zero)
1B8CH  (3AH) LDA F93CH      ; Load LSB of Month (From Clock Chip Read routine)
1B8FH  (21H) LXI H,F655H    ; Load pointer to storage of last known month
1B92H  (BEH) CMP M          ; Test if month changed from the last time
1B93H  (77H) MOV M,A        ; Update last known month with current month
1B94H  (D2H) JNC 1BABH      ; Jump if the month decreased (changed from Dec to Jan)
1B97H  (21H) LXI H,F92DH    ; Point to Year (ones) to increment to increment the year
1B9AH  (34H) INR M          ; Increment 1's place of the year -- Happy New Year!!
1B9BH  (7EH) MOV A,M        ; Load the 1's place of the year to test for roll-over to 10's
1B9CH  (D6H) SUI 0AH        ; Test if 1's place is 10
1B9EH  (C2H) JNZ 1BABH      ; Jump if not 10 to skip incrementing 10's place
1BA1H  (77H) MOV M,A        ; Save new 1's place (A is now zero)
1BA2H  (23H) INX H          ; Increment to 10's place
1BA3H  (34H) INR M          ; Increment 10's place of the year
1BA4H  (7EH) MOV A,M        ; Get 10's place to test for century roll-over
1BA5H  (D6H) SUI 0AH        ; Subtract 10 to perform the test
1BA7H  (C2H) JNZ 1BABH      ; Jump to skip update if not a new century
1BAAH  (77H) MOV M,A        ; Save the new 10's place - Happy Y2K bug!
1BABH  (CDH) CALL 7682H     ; Check for optional external controller
1BAEH  (C3H) JMP 7391H      ; Jump to Cursor BLINK - Continuation of RST 7.5 Background hook

; ======================================================
; Renew automatic power-off counter
; ======================================================
1BB1H  (3AH) LDA F657H      ; Get Power down time (1/10ths of a minute)
1BB4H  (32H) STA F931H      ; Update power-down count-down
1BB7H  (C9H) RET

; ======================================================
; KEY statement
; ======================================================
1BB8H  (FEH) CPI A5H        ; Load value of LIST token
1BBAH  (C2H) JNZ 1BF6H      ; Jump if not LIST to test for ON/OFF

; ======================================================
; KEY LIST statement
; ======================================================
1BBDH  (D7H) RST 2          ; Get next non-white char from M
1BBEH  (E5H) PUSH H         ; Preserve HL on stack
1BBFH  (21H) LXI H,F789H    ; Function key definition area
1BC2H  (0EH) MVI C,04H      ; Prepare to print 4 lines of FKey text, 2 per line
1BC4H  (CDH) CALL 1BD3H     ; Print 1st FKey text for this line
1BC7H  (CDH) CALL 1BD3H     ; Print 2nd FKey text for this line
1BCAH  (CDH) CALL 4222H     ; Send CRLF to screen or printer
1BCDH  (0DH) DCR C          ; Decrement line counter
1BCEH  (C2H) JNZ 1BC4H      ; Keep looping until count=0
1BD1H  (E1H) POP H          ; Restore HL from stack
1BD2H  (C9H) RET

; ======================================================
; Print 16-byte string plus 3 SPACES (for KEY LIST)
; ======================================================
1BD3H  (06H) MVI B,10H      ; Prepare to send 16 bytes of FKey text
1BD5H  (CDH) CALL 1BE0H     ; Send B characters from M to the screen
1BD8H  (06H) MVI B,03H      ; Prepare to send 3 spaces
1BDAH  (E7H) RST 4          ; Send character in A to screen/printer
1BDBH  (05H) DCR B          ; Decrement counter 
1BDCH  (C2H) JNZ 1BDAH      ; Loop until 3 spaces sent
1BDFH  (C9H) RET

; ======================================================
; Send B characters from M to the screen
; ======================================================
1BE0H  (7EH) MOV A,M        ; Get next character from string
1BE1H  (FEH) CPI 7FH        ; Test for non-printable character
1BE3H  (CAH) JZ 1BEBH       ; Print SPACE for non-printable characters
1BE6H  (FEH) CPI 20H        ; Test if less than SPACE
1BE8H  (D2H) JNC 1BEDH      ; Skip to print the character

; ======================================================
; Print SPACE for non-printable characters
; ======================================================
1BEBH  (3EH) MVI A,20H      ; Substitute a SPACE for non-printable characters
1BEDH  (E7H) RST 4          ; Send character in A to screen/printer
1BEEH  (23H) INX H          ; Increment to next byte to print
1BEFH  (05H) DCR B          ; Decrement byte counter
1BF0H  (C2H) JNZ 1BE0H      ; Loop until all bytes printed
1BF3H  (3EH) MVI A,20H      ; Leave a SPACE in A for return
1BF5H  (C9H) RET

; ======================================================
; Test for KEY ON/OFF/STOP parameter
; ======================================================
1BF6H  (FEH) CPI 28H        ; Test for '('
1BF8H  (CAH) JZ 1AB2H       ; KEY() statement
1BFBH  (FEH) CPI 97H        ; Test for OFF token
1BFDH  (CAH) JZ 1AC3H       ; KEY STOP/ON/OFF statements
1C00H  (FEH) CPI CBH        ; Test for ON token
1C02H  (CAH) JZ 1AC3H       ; KEY STOP/ON/OFF statements
1C05H  (FEH) CPI 8FH        ; Test for STOP token
1C07H  (CAH) JZ 1AC3H       ; KEY STOP/ON/OFF statements
1C0AH  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
1C0DH  (3DH) DCR A          ; Decrement KEY number to make it zero based
1C0EH  (FEH) CPI 08H        ; Test if KEY number too big
1C10H  (D2H) JNC 08DBH      ; Generate FC error if too big
1C13H  (EBH) XCHG           ; Save HL in DE
1C14H  (6FH) MOV L,A        ; Prepare to multiply key number x16 (up to 16 bytes per key)
1C15H  (26H) MVI H,00H      ; Make MSB of HL zero
1C17H  (29H) DAD H          ; x2
1C18H  (29H) DAD H          ; x4
1C19H  (29H) DAD H          ; x8
1C1AH  (29H) DAD H          ; x16
1C1BH  (01H) LXI B,F789H    ; Function key definition area
1C1EH  (09H) DAD B          ; Index into function key definition area
1C1FH  (E5H) PUSH H         ; Save address to FKey text
1C20H  (EBH) XCHG           ; Restore HL (BASIC string pointer)
1C21H  (CFH) RST 1          ; Compare next byte with M
1C22H  DB   2CH             ;   ','
1C23H  (CDH) CALL 0DABH     ; Main BASIC evaluation routine
1C26H  (E5H) PUSH H         ; Save BASIC string pointer to stack
1C27H  (CDH) CALL 2916H     ; Get pointer to most recently used string (Len + address)
1C2AH  (46H) MOV B,M        ; Get length of string for FKey
1C2BH  (23H) INX H          ; Increment to LSB of string address
1C2CH  (5EH) MOV E,M        ; Get LSB of string address
1C2DH  (23H) INX H          ; Increment to MSB of string address
1C2EH  (56H) MOV D,M        ; Get MSB of string address
1C2FH  (E1H) POP H          ; Retrieve BASIC string pointer from stack
1C30H  (E3H) XTHL           ; HL=string address, DE=BASIC string pointer
1C31H  (0EH) MVI C,0FH      ; Prepare to copy up to 15 bytes of string data (Need 1 byte for NULL)
1C33H  (78H) MOV A,B        ; Get length of string to set as FKey text
1C34H  (A7H) ANA A          ; Test for zero length string
1C35H  (CAH) JZ 1C48H       ; Jump if string length is zero to skip string copy
1C38H  (1AH) LDAX D         ; Get next byte of string from BASIC command string
1C39H  (A7H) ANA A          ; Test for NULL in string (shouldn't happen)
1C3AH  (CAH) JZ 08DBH       ; Generate FC error
1C3DH  (77H) MOV M,A        ; Save byte to FKey table
1C3EH  (13H) INX D          ; Increment to next byte of BASIC string
1C3FH  (23H) INX H          ; Increment to next byte of FKey table
1C40H  (0DH) DCR C          ; Decrement max string copy size
1C41H  (CAH) JZ 1C4EH       ; Jump NULL terminate FKey string if max length reached
1C44H  (05H) DCR B          ; Decrement length of source string from BASIC command line
1C45H  (C2H) JNZ 1C38H      ; Jump to copy next string if not zero

; ======================================================
; Clear remainder of FKey string text
; ======================================================
1C48H  (70H) MOV M,B        ; Zero out next byte of FKey text
1C49H  (23H) INX H          ; Increment to next FKey text byte
1C4AH  (0DH) DCR C          ; Decrement FKey string length count
1C4BH  (C2H) JNZ 1C48H      ; Keep zero'ing out FKey until count = 0

; ======================================================
; NULL terminate the FKey text (last byte of string)
; ======================================================
1C4EH  (71H) MOV M,C        ; NULL terminate the FKey text
1C4FH  (CDH) CALL 5A9EH     ; Display function keys on 8th line
1C52H  (CDH) CALL 6C93H     ; Copy BASIC Function key table to key definition area
1C55H  (E1H) POP H          ; POP address of FKey text from stack.
1C56H  (C9H) RET

; ======================================================
; PSET statement
; ======================================================
1C57H  (CDH) CALL 1D2EH     ; Get (X,Y) coordinate from tokenized string at M
1C5AH  (0FH) RRC
1C5BH  (E5H) PUSH H
1C5CH  (F5H) PUSH PSW
1C5DH  (DCH) CC 744CH       ; Plot (set) point (D,E) on the LCD
1C60H  (F1H) POP PSW
1C61H  (D4H) CNC 744DH      ; Clear (reset) point (D,E) on the LCD
1C64H  (E1H) POP H
1C65H  (C9H) RET

; ======================================================
; PRESET statement
; ======================================================
1C66H  (CDH) CALL 1D2EH     ; Get (X,Y) coordinate from tokenized string at M
1C69H  (2FH) CMA
1C6AH  (C3H) JMP 1C5AH

; ======================================================
; LINE statement
; ======================================================
1C6DH  (FEH) CPI D1H
1C6FH  (EBH) XCHG
1C70H  (2AH) LHLD F64EH     ; X coord of last point plotted
1C73H  (EBH) XCHG
1C74H  (C4H) CNZ 1D2EH      ; Get (X,Y) coordinate from tokenized string at M
1C77H  (D5H) PUSH D
1C78H  (CFH) RST 1          ; Compare next byte with M
1C79H  DB   D1H
1C7AH  (CDH) CALL 1D2EH     ; Get (X,Y) coordinate from tokenized string at M
1C7DH  (D5H) PUSH D
1C7EH  (11H) LXI D,744CH
1C81H  (CAH) JZ 1C94H
1C84H  (D5H) PUSH D
1C85H  (CFH) RST 1          ; Compare next byte with M
1C86H  DB   2CH
1C87H  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
1C8AH  (D1H) POP D
1C8BH  (0FH) RRC
1C8CH  (DAH) JC 1C92H
1C8FH  (11H) LXI D,744DH
1C92H  (2BH) DCX H
1C93H  (D7H) RST 2          ; Get next non-white char from M
1C94H  (EBH) XCHG
1C95H  (22H) SHLD F661H     ; Address last called
1C98H  (EBH) XCHG
1C99H  (CAH) JZ 1CD2H
1C9CH  (CFH) RST 1          ; Compare next byte with M
1C9DH  DB   2CH
1C9EH  (CFH) RST 1          ; Compare next byte with M
1C9FH  DB   42H
1CA0H  (CAH) JZ 1CBCH       ; Draw an unfilled box on LCD. Coords are on stack
1CA3H  (CFH) RST 1          ; Compare next byte with M
1CA4H  DB   46H
1CA5H  (D1H) POP D

; ======================================================
; Draw a filled box on LCD. Coords are on stack
; ======================================================
1CA6H  (E3H) XTHL
1CA7H  (7BH) MOV A,E
1CA8H  (95H) SUB L
1CA9H  (D2H) JNC 1CAFH
1CACH  (2FH) CMA
1CADH  (3CH) INR A
1CAEH  (6BH) MOV L,E
1CAFH  (47H) MOV B,A
1CB0H  (04H) INR B
1CB1H  (5DH) MOV E,L
1CB2H  (CDH) CALL 1CD9H
1CB5H  (2CH) INR L
1CB6H  (05H) DCR B
1CB7H  (C2H) JNZ 1CB1H
1CBAH  (E1H) POP H
1CBBH  (C9H) RET

; ======================================================
; Draw an unfilled box on LCD. Coords are on stack
; ======================================================
1CBCH  (D1H) POP D
1CBDH  (E3H) XTHL
1CBEH  (D5H) PUSH D
1CBFH  (5DH) MOV E,L
1CC0H  (CDH) CALL 1CD9H
1CC3H  (D1H) POP D
1CC4H  (D5H) PUSH D
1CC5H  (54H) MOV D,H
1CC6H  (CDH) CALL 1CD9H
1CC9H  (D1H) POP D
1CCAH  (E5H) PUSH H
1CCBH  (62H) MOV H,D
1CCCH  (CDH) CALL 1CD9H
1CCFH  (E1H) POP H
1CD0H  (6BH) MOV L,E
1CD1H  (01H) LXI B,E3D1H
1CD4H  (CDH) CALL 1CD9H
1CD7H  (E1H) POP H
1CD8H  (C9H) RET

; ======================================================
; Draw n box (filled or unfilled) on LCD. Coords are on stack
; ======================================================
1CD9H  (E5H) PUSH H
1CDAH  (D5H) PUSH D
1CDBH  (C5H) PUSH B
1CDCH  (7DH) MOV A,L
1CDDH  (93H) SUB E
1CDEH  (D2H) JNC 1CE4H
1CE1H  (EBH) XCHG
1CE2H  (2FH) CMA
1CE3H  (3CH) INR A
1CE4H  (47H) MOV B,A
1CE5H  (0EH) MVI C,14H
1CE7H  (7CH) MOV A,H
1CE8H  (92H) SUB D
1CE9H  (D2H) JNC 1CEFH
1CECH  (2FH) CMA
1CEDH  (3CH) INR A
1CEEH  (0CH) INR C
1CEFH  (B8H) CMP B
1CF0H  (DAH) JC 1CFAH
1CF3H  (67H) MOV H,A
1CF4H  (68H) MOV L,B
1CF5H  (3EH) MVI A,1CH
1CF7H  (C3H) JMP 1CFFH

1CFAH  (6FH) MOV L,A
1CFBH  (60H) MOV H,B
1CFCH  (79H) MOV A,C
1CFDH  (0EH) MVI C,1CH
1CFFH  (32H) STA F663H
1D02H  (79H) MOV A,C
1D03H  (32H) STA F665H
1D06H  (44H) MOV B,H
1D07H  (04H) INR B
1D08H  (7CH) MOV A,H
1D09H  (A7H) ANA A
1D0AH  (1FH) RAR
1D0BH  (4FH) MOV C,A
1D0CH  (E5H) PUSH H
1D0DH  (D5H) PUSH D
1D0EH  (C5H) PUSH B
1D0FH  (CDH) CALL F660H
1D12H  (C1H) POP B
1D13H  (D1H) POP D
1D14H  (E1H) POP H
1D15H  (CDH) CALL F665H
1D18H  (79H) MOV A,C
1D19H  (85H) ADD L
1D1AH  (4FH) MOV C,A
1D1BH  (DAH) JC 1D22H
1D1EH  (BCH) CMP H
1D1FH  (DAH) JC 1D27H
1D22H  (94H) SUB H
1D23H  (4FH) MOV C,A
1D24H  (CDH) CALL F663H
1D27H  (05H) DCR B
1D28H  (C2H) JNZ 1D0CH
1D2BH  (C3H) JMP 14EEH      ; POP BC, DE, HL from stack

; ======================================================
; Get (X,Y) coordinate from tokenized string at M
; ======================================================
1D2EH  (CFH) RST 1          ; Compare next byte with M
1D2FH  DB   28H
1D30H  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
1D33H  (FEH) CPI F0H
1D35H  (D2H) JNC 08DBH      ; Generate FC error
1D38H  (F5H) PUSH PSW
1D39H  (CFH) RST 1          ; Compare next byte with M
1D3AH  DB   2CH
1D3BH  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
1D3EH  (FEH) CPI 40H
1D40H  (D2H) JNC 08DBH      ; Generate FC error
1D43H  (F1H) POP PSW
1D44H  (57H) MOV D,A
1D45H  (EBH) XCHG
1D46H  (22H) SHLD F64EH     ; X coord of last point plotted
1D49H  (EBH) XCHG
1D4AH  (7EH) MOV A,M
1D4BH  (FEH) CPI 29H
1D4DH  (C2H) JNZ 1D54H
1D50H  (D7H) RST 2          ; Get next non-white char from M
1D51H  (3EH) MVI A,01H
1D53H  (C9H) RET

1D54H  (D5H) PUSH D
1D55H  (CFH) RST 1          ; Compare next byte with M
1D56H  DB   2CH
1D57H  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
1D5AH  (CFH) RST 1          ; Compare next byte with M
1D5BH  DB   29H
1D5CH  (7BH) MOV A,E
1D5DH  (D1H) POP D
1D5EH  (C9H) RET

1D5FH  (CDH) CALL 1112H     ; Evaluate expression at M
1D62H  (CFH) RST 1          ; Compare next byte with M
1D63H  DB   2CH
1D64H  (E5H) PUSH H
1D65H  (EBH) XCHG
1D66H  (3AH) LDA F63CH      ; Active columns count (1-40)
1D69H  (2FH) CMA
1D6AH  (3CH) INR A
1D6BH  (4FH) MOV C,A
1D6CH  (06H) MVI B,FFH
1D6EH  (58H) MOV E,B
1D6FH  (1CH) INR E
1D70H  (55H) MOV D,L
1D71H  (09H) DAD B
1D72H  (DAH) JC 1D6FH
1D75H  (3AH) LDA F63CH      ; Active columns count (1-40)
1D78H  (14H) INR D
1D79H  (BAH) CMP D
1D7AH  (DAH) JC 08DBH       ; Generate FC error
1D7DH  (3AH) LDA F63BH      ; Active rows count (1-8)
1D80H  (1CH) INR E
1D81H  (BBH) CMP E
1D82H  (DAH) JC 08DBH       ; Generate FC error
1D85H  (EBH) XCHG
1D86H  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
1D89H  (7CH) MOV A,H
1D8AH  (3DH) DCR A
1D8BH  (32H) STA F788H      ; Horiz. position of cursor (0-39)
1D8EH  (E1H) POP H
1D8FH  (C9H) RET

; ======================================================
; CSRLIN function
; ======================================================
1D90H  (E5H) PUSH H
1D91H  (3AH) LDA F639H      ; Cursor row (1-8)
1D94H  (3DH) DCR A
1D95H  (CDH) CALL 340AH
1D98H  (E1H) POP H
1D99H  (D7H) RST 2          ; Get next non-white char from M
1D9AH  (C9H) RET

; ======================================================
; MAX function
; ======================================================
1D9BH  (D7H) RST 2          ; Get next non-white char from M
1D9CH  (FEH) CPI 9DH
1D9EH  (CAH) JZ 1DB2H       ; MAXFILES function
1DA1H  (CFH) RST 1          ; Compare next byte with M
1DA2H  DB   52H
1DA3H  (CFH) RST 1          ; Compare next byte with M
1DA4H  DB   41H
1DA5H  (CFH) RST 1          ; Compare next byte with M
1DA6H  DB   4DH

; ======================================================
; MAXRAM function
; ======================================================
1DA7H  (E5H) PUSH H
1DA8H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
1DA9H  DB   02H
1DAAH  (21H) LXI H,F5F0H    ; Active system signature -- Warm vs Cold boot
1DADH  (CDH) CALL 37DBH     ; Convert unsigned HL to single precision in FAC1
1DB0H  (E1H) POP H
1DB1H  (C9H) RET

; ======================================================
; MAXFILES function
; ======================================================
1DB2H  (E5H) PUSH H
1DB3H  (3AH) LDA FC82H      ; Maxfiles
1DB6H  (C3H) JMP 1D95H

; ======================================================
; HIMEM function
; ======================================================
1DB9H  (E5H) PUSH H
1DBAH  (2AH) LHLD F5F4H     ; HIMEM
1DBDH  (CDH) CALL 37DBH     ; Convert unsigned HL to single precision in FAC1
1DC0H  (E1H) POP H
1DC1H  (D7H) RST 2          ; Get next non-white char from M
1DC2H  (C9H) RET

; ======================================================
; WIDTH statement
; ======================================================
1DC3H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
1DC4H  DB   3AH

; ======================================================
; SOUND statement
; ======================================================
1DC5H  (FEH) CPI 97H
1DC7H  (CAH) JZ 1DE6H       ; SOUND ON statement
1DCAH  (FEH) CPI CBH
1DCCH  (CAH) JZ 1DE5H       ; SOUND OFF statement
1DCFH  (CDH) CALL 1297H     ; Evaluate expression at M
1DD2H  (7AH) MOV A,D
1DD3H  (E6H) ANI C0H
1DD5H  (C2H) JNZ 08DBH      ; Generate FC error
1DD8H  (D5H) PUSH D
1DD9H  (CFH) RST 1          ; Compare next byte with M
1DDAH  DB   2CH
1DDBH  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
1DDEH  (A7H) ANA A
1DDFH  (47H) MOV B,A
1DE0H  (D1H) POP D
1DE1H  (C2H) JNZ 72C5H      ; Produce a tone of DE freq and B duration
1DE4H  (C9H) RET

; ======================================================
; SOUND OFF statement
; ======================================================
1DE5H  (3EH) MVI A,AFH
1DE7H  (32H) STA FF44H      ; Sound flag
1DEAH  (D7H) RST 2          ; Get next non-white char from M
1DEBH  (C9H) RET

; ======================================================
; MOTOR statement
; ======================================================
1DECH  (D6H) SUI CBH
1DEEH  (CAH) JZ 1DF5H       ; MOTOR OFF statement

; ======================================================
; MOTOR ON statement
; ======================================================
1DF1H  (CFH) RST 1          ; Compare next byte with M
1DF2H  DB   97H
1DF3H  (2BH) DCX H
1DF4H  (7CH) MOV A,H

; ======================================================
; MOTOR OFF statement
; ======================================================
1DF5H  (5FH) MOV E,A
1DF6H  (D7H) RST 2          ; Get next non-white char from M
1DF7H  (C3H) JMP 7043H      ; Cassette REMOTE routine - turn motor on or off

; ======================================================
; CALL statement
; ======================================================
1DFAH  (CDH) CALL 1297H     ; Evaluate expression at M
1DFDH  (EBH) XCHG
1DFEH  (22H) SHLD F661H     ; Address last called
1E01H  (EBH) XCHG
1E02H  (2BH) DCX H
1E03H  (D7H) RST 2          ; Get next non-white char from M
1E04H  (CAH) JZ 1E1BH
1E07H  (CFH) RST 1          ; Compare next byte with M
1E08H  DB   2CH
1E09H  (FEH) CPI 2CH
1E0BH  (CAH) JZ 1E14H
1E0EH  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
1E11H  (CAH) JZ 1E1BH
1E14H  (F5H) PUSH PSW
1E15H  (CFH) RST 1          ; Compare next byte with M
1E16H  DB   2CH
1E17H  (CDH) CALL 1297H     ; Evaluate expression at M
1E1AH  (F1H) POP PSW
1E1BH  (E5H) PUSH H
1E1CH  (EBH) XCHG
1E1DH  (CDH) CALL F660H
1E20H  (E1H) POP H
1E21H  (C9H) RET

; ======================================================
; SCREEN statement
; ======================================================
1E22H  (FEH) CPI 2CH        ; Test if 1st byte of parameter is ','
1E24H  (3AH) LDA F638H      ; New Console device flag
1E27H  (C4H) CNZ 112EH      ; Evaluate expression (0-255) at M-1
1E2AH  (CDH) CALL 1E3CH     ; Process SCREEN number selection (0 or 1)
1E2DH  (2BH) DCX H          ; Back command line pointer up to previous char
1E2EH  (D7H) RST 2          ; Get next non-white char from M
1E2FH  (C8H) RZ             ; Return if no more arguments
1E30H  (CFH) RST 1          ; Compare next byte with M
1E31H  DB   2CH             ; Test if byte is ',' and return only if it is
1E32H  (CDH) CALL 112EH     ; Evaluate expression at M-1 (get label line param)
1E35H  (E5H) PUSH H         ; Save BASIC command line pointer to stack
1E36H  (A7H) ANA A          ; Test if Label Line requested
1E37H  (CDH) CALL 13AFH     ; Erase or Display function key line based on Z flag
1E3AH  (E1H) POP H          ; Restore BASIC command line pointer
1E3BH  (C9H) RET

; ======================================================
; Process SCREEN statement including calling SCREEN RST7 Hook
; A has New Console Device flag
; ======================================================
1E3CH  (E5H) PUSH H         ; Preserve HL on stack
1E3DH  (32H) STA F638H      ; Save A as New Console device flag
1E40H  (A7H) ANA A          ; Test if New Console flag set
1E41H  (11H) LXI D,2808H    ; Load ROW,COL value for 8,40
1E44H  (2AH) LHLD F640H     ; Cursor row (1-8)
1E47H  (3EH) MVI A,0EH      ; Value of last column before wrap for PRINT ,
1E49H  (CAH) JZ 1E52H       ; Jump over RST7 if not New Console Device
1E4CH  (AFH) XRA A          ; Clear New Console device flag
1E4DH  (32H) STA F638H      ; Save in New Console device flag
1E50H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
1E51H  DB   3EH             ; SCREEN statement hook
1E52H  (22H) SHLD F639H     ; Cursor row (1-8)
1E55H  (EBH) XCHG           ; DE has active ROWS,COLS (for LCD or DVI)
1E56H  (22H) SHLD F63BH     ; Active rows count (1-8)
1E59H  (32H) STA F676H      ; Store value of column wrap for PRINT , (14 or 56 if 80 COL mode)
1E5CH  (E1H) POP H          ; Restore HL from stack
1E5DH  (C9H) RET

; ======================================================
; LCOPY statement
; ======================================================
1E5EH  (E5H) PUSH H
1E5FH  (CDH) CALL 4BA0H
1E62H  (21H) LXI H,FE00H    ; Start of LCD character buffer
1E65H  (1EH) MVI E,08H
1E67H  (16H) MVI D,28H
1E69H  (7EH) MOV A,M
1E6AH  (CDH) CALL 1470H     ; Output character to printer
1E6DH  (23H) INX H
1E6EH  (15H) DCR D
1E6FH  (C2H) JNZ 1E69H
1E72H  (CDH) CALL 4BA0H
1E75H  (1DH) DCR E
1E76H  (C2H) JNZ 1E67H
1E79H  (E1H) POP H
1E7AH  (C9H) RET

1E7BH  (E5H) PUSH H
1E7CH  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
1E7FH  (2AH) LHLD FC99H
1E82H  (11H) LXI D,2020H
1E85H  (DFH) RST 3          ; Compare DE and HL
1E86H  (F5H) PUSH PSW
1E87H  (CAH) JZ 1E91H
1E8AH  (11H) LXI D,4142H
1E8DH  (DFH) RST 3          ; Compare DE and HL
1E8EH  (C2H) JNZ 1EC7H
1E91H  (CDH) CALL 20A6H
1E94H  (CAH) JZ 1EC7H
1E97H  (F1H) POP PSW
1E98H  (C1H) POP B
1E99H  (F1H) POP PSW
1E9AH  (CAH) JZ 08DBH       ; Generate FC error
1E9DH  (3EH) MVI A,00H
1E9FH  (F5H) PUSH PSW
1EA0H  (C5H) PUSH B
1EA1H  (22H) SHLD FA8CH
1EA4H  (EBH) XCHG
1EA5H  (22H) SHLD F67CH     ; Start of BASIC program pointer
1EA8H  (CDH) CALL 05F0H     ; Update line addresses for current BASIC program
1EABH  (E1H) POP H
1EACH  (7EH) MOV A,M
1EADH  (FEH) CPI 2CH
1EAFH  (C2H) JNZ 1EBAH
1EB2H  (D7H) RST 2          ; Get next non-white char from M
1EB3H  (CFH) RST 1          ; Compare next byte with M
1EB4H  DB   52H
1EB5H  (F1H) POP PSW
1EB6H  (3EH) MVI A,80H
1EB8H  (37H) STC
1EB9H  (F5H) PUSH PSW
1EBAH  (F1H) POP PSW
1EBBH  (32H) STA FCA7H
1EBEH  (DAH) JC 3F28H       ; Initialize BASIC Variables for new execution
1EC1H  (CDH) CALL 3F28H     ; Initialize BASIC Variables for new execution
1EC4H  (C3H) JMP 0502H      ; Vector to BASIC ready - print Ok

1EC7H  (F1H) POP PSW
1EC8H  (E1H) POP H
1EC9H  (16H) MVI D,F8H
1ECBH  (C2H) JNZ 4D8DH
1ECEH  (E5H) PUSH H
1ECFH  (21H) LXI H,2020H
1ED2H  (22H) SHLD FC99H
1ED5H  (E1H) POP H
1ED6H  (C3H) JMP 4D8DH

1ED9H  (E5H) PUSH H
1EDAH  (2AH) LHLD FC99H
1EDDH  (11H) LXI D,4F44H
1EE0H  (DFH) RST 3          ; Compare DE and HL
1EE1H  (06H) MVI B,00H
1EE3H  (CAH) JZ 1EF8H
1EE6H  (11H) LXI D,4142H
1EE9H  (DFH) RST 3          ; Compare DE and HL
1EEAH  (06H) MVI B,01H
1EECH  (CAH) JZ 1EF8H
1EEFH  (11H) LXI D,2020H
1EF2H  (DFH) RST 3          ; Compare DE and HL
1EF3H  (06H) MVI B,02H
1EF5H  (C2H) JNZ 504EH      ; Generate NM error
1EF8H  (E1H) POP H
1EF9H  (C5H) PUSH B
1EFAH  (2BH) DCX H
1EFBH  (D7H) RST 2          ; Get next non-white char from M
1EFCH  (CAH) JZ 1F10H
1EFFH  (CFH) RST 1          ; Compare next byte with M
1F00H  DB   2CH
1F01H  (CFH) RST 1          ; Compare next byte with M
1F02H  DB   41H
1F03H  (C1H) POP B
1F04H  (05H) DCR B
1F05H  (CAH) JZ 504EH       ; Generate NM error
1F08H  (AFH) XRA A
1F09H  (11H) LXI D,F802H
1F0CH  (F5H) PUSH PSW
1F0DH  (C3H) JMP 4E0BH

1F10H  (C1H) POP B
1F11H  (05H) DCR B
1F12H  (FAH) JM 1F08H
1F15H  (CDH) CALL 2081H
1F18H  (C2H) JNZ 08DBH      ; Generate FC error
1F1BH  (CDH) CALL 20A6H
1F1EH  (C4H) CNZ 2017H
1F21H  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
1F24H  (CDH) CALL 20E4H
1F27H  (22H) SHLD FA8CH
1F2AH  (3EH) MVI A,80H
1F2CH  (EBH) XCHG
1F2DH  (2AH) LHLD F67CH     ; Start of BASIC program pointer
1F30H  (EBH) XCHG
1F31H  (CDH) CALL 2239H
1F34H  (CDH) CALL 21D4H
1F37H  (C3H) JMP 0502H      ; Vector to BASIC ready - print Ok

; ======================================================
; FILES statement
; ======================================================
1F3AH  (E5H) PUSH H
1F3BH  (CDH) CALL 1F42H     ; Display Catalog
1F3EH  (E1H) POP H
1F3FH  (C3H) JMP 4BB8H      ; Move LCD to blank line (send CRLF if needed)

; ======================================================
; Display Catalog
; ======================================================
1F42H  (21H) LXI H,F957H
1F45H  (0EH) MVI C,03H
1F47H  (3AH) LDA F63CH      ; Active columns count (1-40)
1F4AH  (FEH) CPI 28H
1F4CH  (CAH) JZ 1F51H
1F4FH  (0EH) MVI C,06H
1F51H  (CDH) CALL 20D5H     ; Find next Non-Empty catalog entry
1F54H  (C8H) RZ
1F55H  (E6H) ANI 18H
1F57H  (C2H) JNZ 1F51H
1F5AH  (E5H) PUSH H
1F5BH  (23H) INX H
1F5CH  (5EH) MOV E,M
1F5DH  (23H) INX H
1F5EH  (56H) MOV D,M
1F5FH  (23H) INX H
1F60H  (D5H) PUSH D
1F61H  (06H) MVI B,06H
1F63H  (7EH) MOV A,M
1F64H  (E7H) RST 4          ; Send character in A to screen/printer
1F65H  (23H) INX H
1F66H  (05H) DCR B
1F67H  (C2H) JNZ 1F63H
1F6AH  (3EH) MVI A,2EH
1F6CH  (E7H) RST 4          ; Send character in A to screen/printer
1F6DH  (7EH) MOV A,M
1F6EH  (E7H) RST 4          ; Send character in A to screen/printer
1F6FH  (23H) INX H
1F70H  (7EH) MOV A,M
1F71H  (E7H) RST 4          ; Send character in A to screen/printer
1F72H  (D1H) POP D
1F73H  (2AH) LHLD F67CH     ; Start of BASIC program pointer
1F76H  (DFH) RST 3          ; Compare DE and HL
1F77H  (3EH) MVI A,2AH
1F79H  (06H) MVI B,20H
1F7BH  (CAH) JZ 1F7FH
1F7EH  (78H) MOV A,B
1F7FH  (E7H) RST 4          ; Send character in A to screen/printer
1F80H  (78H) MOV A,B
1F81H  (E7H) RST 4          ; Send character in A to screen/printer
1F82H  (E7H) RST 4          ; Send character in A to screen/printer
1F83H  (E1H) POP H
1F84H  (0DH) DCR C
1F85H  (C2H) JNZ 1F51H
1F88H  (CDH) CALL 4222H     ; Send CRLF to screen or printer
1F8BH  (CDH) CALL 13F3H
1F8EH  (C3H) JMP 1F45H

; ======================================================
; KILL statement
; ======================================================
1F91H  (CDH) CALL 207AH
1F94H  (2BH) DCX H
1F95H  (D7H) RST 2          ; Get next non-white char from M
1F96H  (C2H) JNZ 0446H      ; Generate Syntax error
1F99H  (7AH) MOV A,D
1F9AH  (FEH) CPI F8H
1F9CH  (CAH) JZ 1FA1H
1F9FH  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
1FA0H  DB   58H
1FA1H  (E5H) PUSH H
1FA2H  (AFH) XRA A
1FA3H  (32H) STA FCA7H
1FA6H  (CDH) CALL 4E22H
1FA9H  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
1FACH  (CDH) CALL 20AFH
1FAFH  (CAH) JZ 5057H       ; Generate FF error
1FB2H  (47H) MOV B,A
1FB3H  (E6H) ANI 20H
1FB5H  (C2H) JNZ 1FDAH
1FB8H  (78H) MOV A,B
1FB9H  (E6H) ANI 40H
1FBBH  (CAH) JZ 2005H
1FBEH  DB    3EH            ; Make "PUSH H" look like "MVI A,E5H" for pass-thru

; ======================================================
; Kill a text file at DE
; ======================================================
1FBFH  (E5H) PUSH H         ; Preserve HL on stack
1FC0H  (01H) LXI B,0000H    ; Set deletion length to zero
1FC3H  (71H) MOV M,C        ; Zero out (HL).  Why?
1FC4H  (6BH) MOV L,E        ; Copy LSB of DE to HL
1FC5H  (62H) MOV H,D        ; Copy MSB of DE to HL.
1FC6H  (1AH) LDAX D         ; Load next byte of DO file to test for EOF
1FC7H  (13H) INX D          ; Increment to next byte
1FC8H  (03H) INX B          ; Increment length of deletion count
1FC9H  (FEH) CPI 1AH        ; Test if at end of DO file
1FCBH  (C2H) JNZ 1FC6H      ; Jump to test next byte until EOF
1FCEH  (CDH) CALL 6B9FH     ; Delete BC characters at M
1FD1H  (CDH) CALL 18DDH
1FD4H  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
1FD7H  (E1H) POP H          ; Restore HL from stack
1FD8H  (C9H) RET

1FD9H  (E5H) PUSH H
1FDAH  (36H) MVI M,00H
1FDCH  (2AH) LHLD FBB0H     ; Start of CO files pointer
1FDFH  (E5H) PUSH H
1FE0H  (EBH) XCHG
1FE1H  (E5H) PUSH H
1FE2H  (23H) INX H
1FE3H  (23H) INX H
1FE4H  (4EH) MOV C,M
1FE5H  (23H) INX H
1FE6H  (46H) MOV B,M
1FE7H  (21H) LXI H,0006H
1FEAH  (09H) DAD B
1FEBH  (44H) MOV B,H
1FECH  (4DH) MOV C,L
1FEDH  (E1H) POP H
1FEEH  (CDH) CALL 6B9FH     ; Delete BC characters at M
1FF1H  (E1H) POP H
1FF2H  (22H) SHLD FBB0H     ; Start of CO files pointer
1FF5H  (C3H) JMP 1FD1H

1FF8H  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
1FFBH  (2AH) LHLD F9B0H
1FFEH  (EBH) XCHG
1FFFH  (21H) LXI H,F9AFH
2002H  (C3H) JMP 1FBFH      ; Kill a text file

2005H  (E5H) PUSH H
2006H  (2AH) LHLD F67CH     ; Start of BASIC program pointer
2009H  (DFH) RST 3          ; Compare DE and HL
200AH  (E1H) POP H
200BH  (CAH) JZ 08DBH       ; Generate FC error
200EH  (CDH) CALL 2017H
2011H  (CDH) CALL 3F2CH
2014H  (C3H) JMP 0502H      ; Vector to BASIC ready - print Ok

2017H  (36H) MVI M,00H
2019H  (2AH) LHLD F67CH     ; Start of BASIC program pointer
201CH  (DFH) RST 3          ; Compare DE and HL
201DH  (F5H) PUSH PSW
201EH  (D5H) PUSH D
201FH  (CDH) CALL 05F4H     ; Update line addresses for BASIC program at (DE)
2022H  (D1H) POP D
2023H  (23H) INX H
2024H  (CDH) CALL 2134H     ; Delete bytes between HL and DE
2027H  (C5H) PUSH B
2028H  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
202BH  (C1H) POP B
202CH  (F1H) POP PSW
202DH  (C8H) RZ
202EH  (D8H) RC
202FH  (2AH) LHLD F67CH     ; Start of BASIC program pointer
2032H  (09H) DAD B
2033H  (22H) SHLD F67CH     ; Start of BASIC program pointer
2036H  (C9H) RET

; ======================================================
; NAME statement
; ======================================================
2037H  (CDH) CALL 207AH
203AH  (D5H) PUSH D
203BH  (CDH) CALL 224CH
203EH  (CFH) RST 1          ; Compare next byte with M
203FH  DB   41H
2040H  (CFH) RST 1          ; Compare next byte with M
2041H  DB   53H
2042H  (CDH) CALL 207AH
2045H  (7AH) MOV A,D
2046H  (D1H) POP D
2047H  (BAH) CMP D
2048H  (C2H) JNZ 08DBH      ; Generate FC error
204BH  (FEH) CPI F8H
204DH  (CAH) JZ 2052H
2050H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
2051H  DB   5AH
2052H  (E5H) PUSH H
2053H  (CDH) CALL 20AFH
2056H  (C2H) JNZ 08DBH      ; Generate FC error
2059H  (CDH) CALL 224CH
205CH  (CDH) CALL 20AFH
205FH  (CAH) JZ 5057H       ; Generate FF error
2062H  (E5H) PUSH H
2063H  (2AH) LHLD FC99H
2066H  (EBH) XCHG
2067H  (2AH) LHLD FCA2H
206AH  (DFH) RST 3          ; Compare DE and HL
206BH  (C2H) JNZ 08DBH      ; Generate FC error
206EH  (E1H) POP H
206FH  (CDH) CALL 224CH
2072H  (23H) INX H
2073H  (23H) INX H
2074H  (23H) INX H
2075H  (CDH) CALL 2241H
2078H  (E1H) POP H
2079H  (C9H) RET

207AH  (CDH) CALL 4C0FH     ; Evaluate arguments to RUN/OPEN/SAVE commands
207DH  (C0H) RNZ
207EH  (16H) MVI D,F8H
2080H  (C9H) RET

2081H  (2AH) LHLD FA8CH
2084H  (11H) LXI D,F999H
2087H  (DFH) RST 3          ; Compare DE and HL
2088H  (C9H) RET

2089H  (01H) LXI B,434FH
208CH  (C3H) JMP 20A9H

208FH  (2AH) LHLD FC99H
2092H  (11H) LXI D,2020H
2095H  (DFH) RST 3          ; Compare DE and HL
2096H  (CAH) JZ 20A0H
2099H  (11H) LXI D,4F44H
209CH  (DFH) RST 3          ; Compare DE and HL
209DH  (C2H) JNZ 504EH      ; Generate NM error
20A0H  (01H) LXI B,444FH
20A3H  (C3H) JMP 20A9H

20A6H  (01H) LXI B,4241H
20A9H  (21H) LXI H,FC99H
20ACH  (70H) MOV M,B
20ADH  (23H) INX H
20AEH  (71H) MOV M,C
20AFH  (21H) LXI H,F957H
20B2H  (3EH) MVI A,E1H
20B4H  (CDH) CALL 20D5H     ; Find next Non-Empty catalog entry
20B7H  (C8H) RZ
20B8H  (E5H) PUSH H
20B9H  (23H) INX H
20BAH  (23H) INX H
20BBH  (11H) LXI D,FC92H
20BEH  (06H) MVI B,08H
20C0H  (13H) INX D
20C1H  (23H) INX H
20C2H  (1AH) LDAX D
20C3H  (BEH) CMP M
20C4H  (C2H) JNZ 20B3H
20C7H  (05H) DCR B
20C8H  (C2H) JNZ 20C0H
20CBH  (E1H) POP H
20CCH  (7EH) MOV A,M
20CDH  (23H) INX H
20CEH  (5EH) MOV E,M
20CFH  (23H) INX H
20D0H  (56H) MOV D,M
20D1H  (2BH) DCX H
20D2H  (2BH) DCX H
20D3H  (A7H) ANA A
20D4H  (C9H) RET

; ====================================================
; Find Non-Empty catalog entry
; ====================================================
20D5H  (C5H) PUSH B         ; Preserve BC on stack
20D6H  (01H) LXI B,000BH    ; Load offset to next Catalog entry
20D9H  (09H) DAD B          ; Advance pointer to next Catalog entry
20DAH  (C1H) POP B          ; Restore BC from stack
20DBH  (7EH) MOV A,M        ; Get Catalog file type byte
20DCH  (FEH) CPI FFH        ; Test for FFH termination marker
20DEH  (C8H) RZ             ; Return if at end of Directory
20DFH  (A7H) ANA A          ; Test if entry is empty (MSB zero = empty)
20E0H  (F2H) JP 20D5H       ; Jump to test next entry in Catalog if empty
20E3H  (C9H) RET

20E4H  (3AH) LDA F651H      ; In TEXT because of BASIC EDIT flag
20E7H  (A7H) ANA A
20E8H  (21H) LXI H,F9AFH
20EBH  (C0H) RNZ
20ECH  (21H) LXI H,F9AFH
20EFH  (01H) LXI B,000BH
20F2H  (09H) DAD B
20F3H  (7EH) MOV A,M
20F4H  (FEH) CPI FFH
20F6H  (CAH) JZ 5066H       ; Generate FL error
20F9H  (87H) ADD A
20FAH  (DAH) JC 20F2H
20FDH  (C9H) RET

; ======================================================
; NEW statement
; ======================================================
20FEH  (C0H) RNZ
20FFH  (CDH) CALL 2081H
2102H  (C4H) CNZ 2146H      ; Update line addresses for ALL BASIC programs
2105H  (21H) LXI H,F999H
2108H  (22H) SHLD FA8CH
210BH  (2AH) LHLD F99AH     ; BASIC program not saved pointer
210EH  (22H) SHLD F67CH     ; Start of BASIC program pointer
2111H  (AFH) XRA A          ; Prepare to zero out BASIC program not savedpointer
2112H  (77H) MOV M,A        ; Zero LSB of BASIC program not saved
2113H  (23H) INX H          ; Increment to MSB
2114H  (77H) MOV M,A        ; Zero out MSB of BASIC program not saved
2115H  (23H) INX H          ; Point to next byte beyond (now) empty BASIC program
2116H  (EBH) XCHG           ; Put address beyond empty BASIC program in DE
2117H  (2AH) LHLD FBAEH     ; Start of DO files pointer
211AH  (CDH) CALL 2134H     ; Call routine to delete bytes between last BASIC program and DO files
211DH  (2AH) LHLD FAD8H
2120H  (09H) DAD B
2121H  (22H) SHLD FAD8H
2124H  (21H) LXI H,FFFFH    ; Load code to indicate no paste operation in progress
2127H  (22H) SHLD F62EH     ; Save as index into paste buffer of "active paste operation"
212AH  (C3H) JMP 3F28H      ; Initialize BASIC Variables for new execution

212DH  (2AH) LHLD FABAH     ; Address where last BASIC list started
2130H  (EBH) XCHG
2131H  (2AH) LHLD FABCH

; ======================================================
; Delete Bytes between HL and DE
; ======================================================
2134H  (7DH) MOV A,L        ; Prepare to calc LSB of length to delete
2135H  (93H) SUB E          ; Calculate LSB of delete length
2136H  (4FH) MOV C,A        ; Save LSB in BC
2137H  (7CH) MOV A,H        ; Prepare to calc MSB of delete length
2138H  (9AH) SBB D          ; Calculate MSB of delete length
2139H  (47H) MOV B,A        ; Save MSB in BC
213AH  (EBH) XCHG           ; Put lower address in HL for the delete
213BH  (CDH) CALL 6B9FH     ; Delete BC characters at M
213EH  (2AH) LHLD FBAEH     ; Start of DO files pointer
2141H  (09H) DAD B          ; Update Start of DO files pointer by delete length
2142H  (22H) SHLD FBAEH     ; Start of DO files pointer
2145H  (C9H) RET

; ======================================================
; Update line addresses for ALL BASIC programs
; ======================================================
2146H  (AFH) XRA A          ; Mark type of file being searched as "BA" (BA=0, DO=1, CO=2)
2147H  (32H) STA F809H      ; Store file type to search / move?
214AH  (2AH) LHLD FAC0H     ; Lowest RAM address used by system
214DH  (23H) INX H          ; Increment Lowest RAM address used by system
214EH  (E5H) PUSH H         ; And save it to the stack
214FH  (21H) LXI H,F98EH    ; Point to first Catalog Entry past ROM programs (-1 entry)
2152H  (11H) LXI D,FFFFH    ; Initialize "Min address" to FFFFH
2155H  (CDH) CALL 20D5H     ; Find next Non-Empty catalog entry
2158H  (CAH) JZ 2175H       ; Exit loop if at end of Catalog
215BH  (0FH) RRC            ; Get LSB of Catalog entry type into C flag
215CH  (DAH) JC 2155H       ; Jump to get next entry if LSB of file type is set - skip these.
215FH  (E5H) PUSH H         ; Preserve starting address of this entry on stack
2160H  (23H) INX H          ; Increment to LSB of the file's address
2161H  (7EH) MOV A,M        ; Get LSB of catalog file's address
2162H  (23H) INX H          ; Increment to MSB of address
2163H  (66H) MOV H,M        ; Get MSB of file's address
2164H  (6FH) MOV L,A        ; Move LSB to HL for comparison
2165H  (DFH) RST 3          ; Compare DE and HL - DE has FFFFH
2166H  (E1H) POP H          ; Restore pointer to catalog entry
2167H  (D2H) JNC 2155H      ; Test if HL < DE (find lowest file address)
216AH  (44H) MOV B,H        ; Save address of file with lowest address in BC
216BH  (4DH) MOV C,L        ; Save LSB too
216CH  (23H) INX H          ; Increment past file type to get file's address into DE
216DH  (5EH) MOV E,M        ; Get LSB of file's address
216EH  (23H) INX H          ; Increment to MSB
216FH  (56H) MOV D,M        ; Get MSB of file's address
2170H  (2BH) DCX H          ; Decrement back to LSB of address
2171H  (2BH) DCX H          ; Decrement back to start of Catalog entry
2172H  (C3H) JMP 2155H      ; Jump to test if next file has a lower address

; ======================================================
; Catalog entry with the lowest File RAM address found.
; Mark the LSB of that file's catalog entry type byte.
; ======================================================
2175H  (7BH) MOV A,E        ; Get LSB of lowest RAM file address
2176H  (A2H) ANA D          ; AND with MSB to test for FFFFH
2177H  (3CH) INR A          ; Increment to complete the test
2178H  (D1H) POP D          ; Pop lowest RAM address used by system from stack
2179H  (CAH) JZ 218DH       ; If FFFFH, Clear LSB of File Type byte for all Catalog entries.
217CH  (60H) MOV H,B        ; Get pointer to Catalog entry with lowest RAM address
217DH  (69H) MOV L,C        ; Get LSB too
217EH  (7EH) MOV A,M        ; Get the file type byte for that entry
217FH  (F6H) ORI 01H        ; Set the LSB of the file type byte
2181H  (77H) MOV M,A        ; And write it back to the catalog.  What are we marking here, the fact it is lowest?
2182H  (23H) INX H          ; Increment to the file's address LSB
2183H  (73H) MOV M,E        ; Get LSB of that file
2184H  (23H) INX H          ; Increment to MSB of the address
2185H  (72H) MOV M,D        ; Get MSB of the file's address
2186H  (EBH) XCHG           ; HL = Address of file, DE = address of Catalog entry for the file
2187H  (CDH) CALL 219AH     ; Advance HL past end of current file based on type
218AH  (C3H) JMP 214EH      ; Jump to process next file

; ======================================================
; Clear LSB of File Type byte for all Catalog entries.
; ======================================================
218DH  (21H) LXI H,F957H    ; Load address of RAM Catalog (-1 entry, or 11 bytes)
2190H  (CDH) CALL 20D5H     ; Find next Non-Empty catalog entry
2193H  (C8H) RZ             ; Return if empty catalog entry 
2194H  (E6H) ANI FEH        ; Clear LSB of Catalog entry type
2196H  (77H) MOV M,A        ; Save modified Catalog entry type
2197H  (C3H) JMP 2190H      ; Jump to find next catalog entry

; ======================================================
; Advance HL past end of current file based on type
; ======================================================
219AH  (3AH) LDA F809H      ; Load type of files being processed (BA, DO, CO)
219DH  (3DH) DCR A          ; Test type being processed
219EH  (FAH) JM 21C2H       ; Jump if BA (BA=0)
21A1H  (CAH) JZ 21AEH       ; Jump if DO (DO=1)

; ======================================================
; Advance HL past end of CO file
; ======================================================
21A4H  (23H) INX H          ; Skip LSB of load address of CO file
21A5H  (23H) INX H          ; Skip MSB of load address of CO file
21A6H  (5EH) MOV E,M        ; Get LSB of length of CO file
21A7H  (23H) INX H          ; Increment to MSB of length
21A8H  (56H) MOV D,M        ; Get MSB of length of CO file
21A9H  (23H) INX H          ; Increment to LSB of entry of CO file
21AAH  (23H) INX H          ; Increment to MSB of entry
21ABH  (23H) INX H          ; Increment again to get past end of file
21ACH  (19H) DAD D          ; Offset to end of file by adding length
21ADH  (C9H) RET

; ======================================================
; Advance HL past end of DO file
; ======================================================
21AEH  (3EH) MVI A,1AH      ; Load End-Of-File marker
21B0H  (BEH) CMP M          ; Test if at end of file
21B1H  (23H) INX H          ; Increment to next byte in file
21B2H  (C2H) JNZ 21B0H      ; Loop until EOF marker found
21B5H  (EBH) XCHG           ; Save HL in DE
21B6H  (2AH) LHLD FBB0H     ; Get start of CO files pointer
21B9H  (EBH) XCHG           ; Restore HL
21BAH  (DFH) RST 3          ; Compare DE and HL - test if at end of DO file space
21BBH  (C0H) RNZ            ; Return if not at end of DO file space
21BCH  (3EH) MVI A,02H      ; At end of DO.  Change type to CO
21BEH  (32H) STA F809H      ; And store it
21C1H  (C9H) RET

; ======================================================
; Update line addresses for BA and advance HL to end of file
; ======================================================
21C2H  (EBH) XCHG           ; Move file pointer HL to DE
21C3H  (CDH) CALL 05F4H     ; Update line addresses for BASIC program at (DE)
21C6H  (23H) INX H          ; Increment to next file
21C7H  (EBH) XCHG           ; Store HL in DE
21C8H  (2AH) LHLD FBAEH     ; Load start of DO files pointer
21CBH  (EBH) XCHG           ; Restore HL from DE
21CCH  (DFH) RST 3          ; Compare DE and HL - test if at end of BASIC space
21CDH  (C0H) RNZ            ; Return if not at end of BASIC file space
21CEH  (3EH) MVI A,01H      ; Indicate we are now in DO file space
21D0H  (32H) STA F809H      ; And save it
21D3H  (C9H) RET

21D4H  (2AH) LHLD FBB2H     ; Start of variable data pointer
21D7H  (22H) SHLD FBB4H     ; Start of array table pointer
21DAH  (22H) SHLD FBB6H     ; Unused memory pointer
21DDH  (2AH) LHLD FBAEH     ; Start of DO files pointer
21E0H  (2BH) DCX H
21E1H  (22H) SHLD F99AH     ; BASIC program not saved pointer
21E4H  (23H) INX H
21E5H  (01H) LXI B,0002H
21E8H  (EBH) XCHG
21E9H  (CDH) CALL 6B7FH
21ECH  (AFH) XRA A
21EDH  (77H) MOV M,A
21EEH  (23H) INX H
21EFH  (77H) MOV M,A
21F0H  (2AH) LHLD FBAEH     ; Start of DO files pointer
21F3H  (09H) DAD B
21F4H  (22H) SHLD FBAEH     ; Start of DO files pointer
21F7H  (C3H) JMP 2146H      ; Update line addresses for ALL BASIC programs

; ======================================================
; Count length of string at M
; ======================================================
21FAH  (E5H) PUSH H
21FBH  (1EH) MVI E,FFH
21FDH  (1CH) INR E
21FEH  (7EH) MOV A,M
21FFH  (23H) INX H
2200H  (A7H) ANA A
2201H  (C2H) JNZ 21FDH
2204H  (E1H) POP H
2205H  (C9H) RET

; ======================================================
; Get .DO filename and locate in RAM directory
; ======================================================
2206H  (CDH) CALL 21FAH     ; Count length of string at M
2209H  (CDH) CALL 4C0BH
220CH  (C2H) JNZ 0446H      ; Generate Syntax error

; ======================================================
; Open a text file at (FC93H)
; ======================================================
220FH  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
2212H  (CDH) CALL 208FH
2215H  (EBH) XCHG
2216H  (37H) STC
2217H  (C0H) RNZ
2218H  (CDH) CALL 20E4H
221BH  (E5H) PUSH H
221CH  (2AH) LHLD FBAEH     ; Start of DO files pointer
221FH  (E5H) PUSH H
2220H  (3EH) MVI A,1AH
2222H  (CDH) CALL 6B61H     ; Insert A into text file at M
2225H  (DAH) JC 3F17H
2228H  (D1H) POP D
2229H  (E1H) POP H
222AH  (E5H) PUSH H
222BH  (D5H) PUSH D
222CH  (3EH) MVI A,C0H
222EH  (1BH) DCX D
222FH  (CDH) CALL 2239H
2232H  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
2235H  (E1H) POP H
2236H  (D1H) POP D
2237H  (A7H) ANA A
2238H  (C9H) RET

2239H  (D5H) PUSH D
223AH  (77H) MOV M,A
223BH  (23H) INX H
223CH  (73H) MOV M,E
223DH  (23H) INX H
223EH  (72H) MOV M,D
223FH  (23H) INX H
2240H  (3EH) MVI A,D5H
2242H  (11H) LXI D,FC93H    ; Filename of current BASIC program
2245H  (06H) MVI B,08H
2247H  (CDH) CALL 3469H     ; Move B bytes from (DE) to M with increment
224AH  (D1H) POP D
224BH  (C9H) RET

224CH  (E5H) PUSH H
224DH  (06H) MVI B,09H
224FH  (11H) LXI D,FC93H    ; Filename of current BASIC program
2252H  (21H) LXI H,FC9CH    ; Filename of last program loaded from tape
2255H  (4EH) MOV C,M
2256H  (1AH) LDAX D
2257H  (77H) MOV M,A
2258H  (79H) MOV A,C
2259H  (12H) STAX D
225AH  (13H) INX D
225BH  (23H) INX H
225CH  (05H) DCR B
225DH  (C2H) JNZ 2255H
2260H  (E1H) POP H
2261H  (C9H) RET

2262H  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
2265H  (21H) LXI H,FFFFH    ; Load code to indicate no paste operation in progress
2268H  (22H) SHLD F62EH     ; Save as index into paste buffer of "active paste operation"
226BH  (44H) MOV B,H
226CH  (4DH) MOV C,L
226DH  (2AH) LHLD F9A5H     ; Start of Paste Buffer
2270H  (E5H) PUSH H
2271H  (3EH) MVI A,1AH
2273H  (BEH) CMP M
2274H  (03H) INX B
2275H  (23H) INX H
2276H  (C2H) JNZ 2273H
2279H  (E1H) POP H
227AH  (CDH) CALL 6B9FH     ; Delete BC characters at M
227DH  (C3H) JMP 2146H      ; Update line addresses for ALL BASIC programs

; ======================================================
; CSAVE statement
; ======================================================
2280H  (FEH) CPI 4DH        ; Test next byte is "M"
2282H  (CAH) JZ 22DDH       ; Jump to process CSAVEM statement
2285H  (CDH) CALL 25FCH     ; Evaluate arguments to CSAVE/CSAVEM commands
2288H  (2BH) DCX H
2289H  (D7H) RST 2          ; Get next non-white char from M
228AH  (CAH) JZ 2298H
228DH  (CFH) RST 1          ; Compare next byte with M
228EH  DB   2CH
228FH  (CFH) RST 1          ; Compare next byte with M
2290H  DB   41H
2291H  (1EH) MVI E,02H
2293H  (A7H) ANA A
2294H  (F5H) PUSH PSW
2295H  (C3H) JMP 4E0BH

2298H  (CDH) CALL 05F0H     ; Update line addresses for current BASIC program
229BH  (EBH) XCHG
229CH  (2AH) LHLD F67CH     ; Start of BASIC program pointer
229FH  (7BH) MOV A,E
22A0H  (95H) SUB L
22A1H  (6FH) MOV L,A
22A2H  (7AH) MOV A,D
22A3H  (9CH) SUB H
22A4H  (67H) MOV H,A
22A5H  (2BH) DCX H
22A6H  (7CH) MOV A,H
22A7H  (B5H) ORA L
22A8H  (CAH) JZ 0501H       ; Pop stack and vector to BASIC ready
22ABH  (22H) SHLD FAD0H     ; Length of last program loaded/saved to tape
22AEH  (E5H) PUSH H
22AFH  (CDH) CALL 260BH     ; Open CAS for output of BASIC files
22B2H  (CDH) CALL 2648H
22B5H  (D1H) POP D
22B6H  (2AH) LHLD F67CH     ; Start of BASIC program pointer

; ======================================================
; Save buffer at M to tape
; ======================================================
22B9H  (0EH) MVI C,00H
22BBH  (7EH) MOV A,M
22BCH  (CDH) CALL 14C1H     ; Write byte to tape & update checksum
22BFH  (23H) INX H
22C0H  (1BH) DCX D
22C1H  (7AH) MOV A,D
22C2H  (B3H) ORA E
22C3H  (C2H) JNZ 22BBH
22C6H  (CDH) CALL 2635H
22C9H  (C3H) JMP 0501H      ; Pop stack and vector to BASIC ready

; ======================================================
; SAVEM statement
; ======================================================
22CCH  (D7H) RST 2          ; Get next non-white char from M
22CDH  (CDH) CALL 207AH
22D0H  (7AH) MOV A,D
22D1H  (FEH) CPI FDH
22D3H  (CAH) JZ 22E1H
22D6H  (FEH) CPI F8H
22D8H  (CAH) JZ 22F4H
22DBH  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
22DCH  DB   5CH

; ======================================================
; CSAVEM statement
; ======================================================
22DDH  (D7H) RST 2          ; Get next non-white char from M
22DEH  (CDH) CALL 25FCH     ; Evaluate arguments to CSAVE/CSAVEM commands
22E1H  (CDH) CALL 2346H
22E4H  (CDH) CALL 2611H     ; Open CAS for output of CO files
22E7H  (CDH) CALL 2648H
22EAH  (2AH) LHLD FAD0H     ; Length of last program loaded/saved to tape
22EDH  (EBH) XCHG
22EEH  (2AH) LHLD FACEH
22F1H  (C3H) JMP 22B9H      ; Save buffer at M to tape

22F4H  (CDH) CALL 2346H
22F7H  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
22FAH  (CDH) CALL 2089H
22FDH  (C4H) CNZ 1FD9H
2300H  (CDH) CALL 20E4H
2303H  (E5H) PUSH H
2304H  (2AH) LHLD FBB0H     ; Start of CO files pointer
2307H  (E5H) PUSH H
2308H  (2AH) LHLD FAD0H     ; Length of last program loaded/saved to tape
230BH  (7CH) MOV A,H
230CH  (B5H) ORA L
230DH  (CAH) JZ 3F17H
2310H  (E5H) PUSH H
2311H  (01H) LXI B,0006H
2314H  (09H) DAD B
2315H  (44H) MOV B,H
2316H  (4DH) MOV C,L
2317H  (2AH) LHLD FBB2H     ; Start of variable data pointer
231AH  (22H) SHLD FB99H     ; Address of last variable assigned
231DH  (D4H) CNC 6B6DH      ; Insert BC spaces at M
2320H  (DAH) JC 3F17H
2323H  (EBH) XCHG
2324H  (21H) LXI H,FACEH
2327H  (CDH) CALL 2540H     ; Copy 6 bytes from (DC) to (HL)
232AH  (2AH) LHLD FACEH
232DH  (C1H) POP B
232EH  (CDH) CALL 6BDBH     ; Move BC bytes from M to (DE) with increment
2331H  (E1H) POP H
2332H  (22H) SHLD FBB0H     ; Start of CO files pointer
2335H  (E1H) POP H
2336H  (3EH) MVI A,A0H
2338H  (EBH) XCHG
2339H  (2AH) LHLD FB99H     ; Address of last variable assigned
233CH  (EBH) XCHG
233DH  (CDH) CALL 2239H
2340H  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
2343H  (C3H) JMP 0502H      ; Vector to BASIC ready - print Ok

2346H  (CDH) CALL 2372H
2349H  (D5H) PUSH D
234AH  (CDH) CALL 2372H
234DH  (D5H) PUSH D
234EH  (2BH) DCX H
234FH  (D7H) RST 2          ; Get next non-white char from M
2350H  (11H) LXI D,0000H
2353H  (C4H) CNZ 2372H
2356H  (2BH) DCX H
2357H  (D7H) RST 2          ; Get next non-white char from M
2358H  (C2H) JNZ 0446H      ; Generate Syntax error
235BH  (EBH) XCHG
235CH  (22H) SHLD FAD2H
235FH  (D1H) POP D
2360H  (E1H) POP H
2361H  (22H) SHLD FACEH
2364H  (7BH) MOV A,E
2365H  (95H) SUB L
2366H  (6FH) MOV L,A
2367H  (7AH) MOV A,D
2368H  (9CH) SUB H
2369H  (67H) MOV H,A
236AH  (DAH) JC 08DBH       ; Generate FC error
236DH  (23H) INX H
236EH  (22H) SHLD FAD0H     ; Length of last program loaded/saved to tape
2371H  (C9H) RET

2372H  (CFH) RST 1          ; Compare next byte with M
2373H  DB   2CH
2374H  (C3H) JMP 1297H      ; Evaluate expression at M

; ======================================================
; CLOAD statement
; ======================================================
2377H  (FEH) CPI 4DH
2379H  (CAH) JZ 24A7H       ; CLOADM statement
237CH  (FEH) CPI A3H
237EH  (CAH) JZ 2456H
2381H  (CDH) CALL 25E7H     ; Evaluate arguments to CLOAD/CLOADM & Clear current BASIC program
2384H  (F6H) ORI FFH
2386H  (F5H) PUSH PSW
2387H  (F1H) POP PSW
2388H  (F5H) PUSH PSW
2389H  (C2H) JNZ 2391H
238CH  (2BH) DCX H
238DH  (D7H) RST 2          ; Get next non-white char from M
238EH  (C2H) JNZ 08DBH      ; Generate FC error
2391H  (2BH) DCX H
2392H  (D7H) RST 2          ; Get next non-white char from M
2393H  (3EH) MVI A,00H
2395H  (37H) STC
2396H  (3FH) CMC
2397H  (CAH) JZ 23A6H
239AH  (CFH) RST 1          ; Compare next byte with M
239BH  DB   2CH
239CH  (CFH) RST 1          ; Compare next byte with M
239DH  DB   52H
239EH  (C2H) JNZ 0446H      ; Generate Syntax error
23A1H  (F1H) POP PSW
23A2H  (37H) STC
23A3H  (F5H) PUSH PSW
23A4H  (3EH) MVI A,80H
23A6H  (F5H) PUSH PSW
23A7H  (32H) STA FCA7H
23AAH  (CDH) CALL 2667H
23ADH  (FEH) CPI D3H
23AFH  (CAH) JZ 23BDH
23B2H  (FEH) CPI 9CH
23B4H  (CAH) JZ 2432H
23B7H  (CDH) CALL 26DDH     ; Print program on tape being skipped
23BAH  (C3H) JMP 23AAH

23BDH  (C1H) POP B
23BEH  (F1H) POP PSW
23BFH  (F5H) PUSH PSW
23C0H  (C5H) PUSH B
23C1H  (CAH) JZ 23B7H
23C4H  (F1H) POP PSW
23C5H  (F1H) POP PSW
23C6H  (9FH) SBB A`
23C7H  (32H) STA FC92H
23CAH  (CDH) CALL 26E3H     ; Print selected program/file "Found" on tape
23CDH  (CDH) CALL 20FFH     ; NEW statement
23D0H  (2AH) LHLD FAD0H     ; Length of last program loaded/saved to tape
23D3H  (E5H) PUSH H
23D4H  (44H) MOV B,H
23D5H  (4DH) MOV C,L
23D6H  (2AH) LHLD F67CH     ; Start of BASIC program pointer
23D9H  (E5H) PUSH H
23DAH  (CDH) CALL 6B6DH     ; Insert BC spaces at M
23DDH  (DAH) JC 3F17H
23E0H  (21H) LXI H,2426H    ; ON ERROR handler for CLOAD
23E3H  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
23E6H  (2AH) LHLD FBAEH     ; Start of DO files pointer
23E9H  (09H) DAD B
23EAH  (22H) SHLD FBAEH     ; Start of DO files pointer
23EDH  (CDH) CALL 26D1H
23F0H  (E1H) POP H
23F1H  (D1H) POP D
23F2H  (CDH) CALL 2413H     ; Load record from tape and store at M
23F5H  (C2H) JNZ 2426H
23F8H  (6FH) MOV L,A
23F9H  (67H) MOV H,A
23FAH  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
23FDH  (CDH) CALL 14AAH     ; Turn cassette motor off
2400H  (CDH) CALL 4BB8H     ; Move LCD to blank line (send CRLF if needed)
2403H  (CDH) CALL 05F0H     ; Update line addresses for current BASIC program
2406H  (CDH) CALL 3F28H     ; Initialize BASIC Variables for new execution
2409H  (3AH) LDA FC92H
240CH  (A7H) ANA A
240DH  (C2H) JNZ 0804H      ; Execute BASIC program
2410H  (C3H) JMP 0502H      ; Vector to BASIC ready - print Ok

; ======================================================
; Load record from tape and store at M
; ======================================================
2413H  (0EH) MVI C,00H
2415H  (CDH) CALL 14B0H     ; Read byte from tape & update checksum
2418H  (77H) MOV M,A
2419H  (23H) INX H
241AH  (1BH) DCX D
241BH  (7AH) MOV A,D
241CH  (B3H) ORA E
241DH  (C2H) JNZ 2415H
2420H  (CDH) CALL 14B0H     ; Read byte from tape & update checksum
2423H  (79H) MOV A,C
2424H  (A7H) ANA A
2425H  (C9H) RET

; ======================================================
; ON ERROR handler for CLOAD
; ======================================================
2426H  (CDH) CALL 20FFH     ; NEW statement
2429H  (21H) LXI H,0000H    ; Prepare to clear ON ERROR handler vector
242CH  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
242FH  (C3H) JMP 1491H      ; Turn cassette motor off and generate I/O Error

2432H  (CDH) CALL 26E3H     ; Print selected program/file "Found" on tape
2435H  (CDH) CALL 4BB8H     ; Move LCD to blank line (send CRLF if needed)
2438H  (2AH) LHLD FC83H     ; File number description table pointer
243BH  (7EH) MOV A,M
243CH  (23H) INX H
243DH  (66H) MOV H,M
243EH  (6FH) MOV L,A
243FH  (22H) SHLD FC8CH
2442H  (36H) MVI M,01H
2444H  (23H) INX H
2445H  (23H) INX H
2446H  (23H) INX H
2447H  (23H) INX H
2448H  (36H) MVI M,FDH
244AH  (23H) INX H
244BH  (23H) INX H
244CH  (AFH) XRA A
244DH  (77H) MOV M,A
244EH  (23H) INX H
244FH  (77H) MOV M,A
2450H  (32H) STA FA8EH
2453H  (C3H) JMP 4DA6H

2456H  (CDH) CALL 25E8H
2459H  (E5H) PUSH H         ; Preserve HL on stack
245AH  (CDH) CALL 2650H     ; Open CAS for input of BASIC files
245DH  (CDH) CALL 26D1H
2460H  (2AH) LHLD FAD0H     ; Length of last program loaded/saved to tape
2463H  (EBH) XCHG
2464H  (2AH) LHLD F67CH     ; Start of BASIC program pointer
2467H  (CDH) CALL 2590H
246AH  (C2H) JNZ 2478H      ; Generate Verify Failed error
246DH  (7EH) MOV A,M
246EH  (23H) INX H
246FH  (B6H) ORA M
2470H  (C2H) JNZ 2478H      ; Generate Verify Failed error

; ======================================================
; Turn the cassette motor off, POP H and return
; ======================================================
2473H  (CDH) CALL 14AAH     ; Turn cassette motor off
2476H  (E1H) POP H          ; Restore HL
2477H  (C9H) RET

; ======================================================
; Generate Verify Failed error
; ======================================================
2478H  (21H) LXI H,2481H    ; Load pointer to "Verify failed" text
247BH  (CDH) CALL 5791H     ; Print buffer at M until NULL or '"'
247EH  (C3H) JMP 2473H      ; Turn the cassette motor off, POP H and return

2481H  DB   "Verify failed",0DH,0AH,00H

; ======================================================
; LOADM and RUNM statement
; ======================================================
2491H  (D7H) RST 2          ; Get next non-white char from M
2492H  (F1H) POP PSW
2493H  (F5H) PUSH PSW
2494H  (CAH) JZ 08DBH       ; Generate FC error
2497H  (CDH) CALL 207AH
249AH  (7AH) MOV A,D
249BH  (FEH) CPI FDH
249DH  (CAH) JZ 24B3H
24A0H  (FEH) CPI F8H
24A2H  (CAH) JZ 24E7H
24A5H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
24A6H  DB   5EH

; ======================================================
; CLOADM statement
; ======================================================
24A7H  (D7H) RST 2          ; Get next non-white char from M
24A8H  (FEH) CPI A3H
24AAH  (CAH) JZ 2573H
24ADH  (CDH) CALL 25E7H     ; Evaluate arguments to CLOAD/CLOADM & Clear current BASIC program
24B0H  (F6H) ORI FFH
24B2H  (F5H) PUSH PSW
24B3H  (2BH) DCX H
24B4H  (D7H) RST 2          ; Get next non-white char from M
24B5H  (C2H) JNZ 0446H      ; Generate Syntax error
24B8H  (E5H) PUSH H
24B9H  (CDH) CALL 2656H     ; Open CAS for input of CO files
24BCH  (2AH) LHLD FAD2H
24BFH  (7CH) MOV A,H
24C0H  (B5H) ORA L
24C1H  (C2H) JNZ 24CBH
24C4H  (E1H) POP H
24C5H  (F1H) POP PSW
24C6H  (F5H) PUSH PSW
24C7H  (E5H) PUSH H
24C8H  (DAH) JC 08DBH       ; Generate FC error
24CBH  (CDH) CALL 2531H
24CEH  (DAH) JC 3F17H
24D1H  (CDH) CALL 26D1H
24D4H  (2AH) LHLD FAD0H     ; Length of last program loaded/saved to tape
24D7H  (EBH) XCHG
24D8H  (2AH) LHLD FACEH
24DBH  (CDH) CALL 2413H     ; Load record from tape and store at M
24DEH  (C2H) JNZ 1491H      ; Turn cassette motor off and generate I/O Error
24E1H  (CDH) CALL 14AAH     ; Turn cassette motor off
24E4H  (C3H) JMP 251AH

24E7H  (E5H) PUSH H
24E8H  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
24EBH  (CDH) CALL 2089H
24EEH  (CAH) JZ 5057H       ; Generate FF error
24F1H  (EBH) XCHG
24F2H  (CDH) CALL 253DH
24F5H  (E5H) PUSH H
24F6H  (2AH) LHLD FAD2H
24F9H  (7CH) MOV A,H
24FAH  (B5H) ORA L
24FBH  (C2H) JNZ 2507H
24FEH  (D1H) POP D
24FFH  (E1H) POP H
2500H  (F1H) POP PSW
2501H  (F5H) PUSH PSW
2502H  (E5H) PUSH H
2503H  (D5H) PUSH D
2504H  (DAH) JC 08DBH       ; Generate FC error
2507H  (CDH) CALL 2531H
250AH  (DAH) JC 3F17H
250DH  (2AH) LHLD FAD0H     ; Length of last program loaded/saved to tape
2510H  (44H) MOV B,H
2511H  (4DH) MOV C,L
2512H  (2AH) LHLD FACEH
2515H  (EBH) XCHG
2516H  (E1H) POP H
2517H  (CDH) CALL 6BDBH     ; Move BC bytes from M to (DE) with increment
251AH  (E1H) POP H
251BH  (F1H) POP PSW
251CH  (D2H) JNC 3F2CH
251FH  (CDH) CALL 3F2CH
2522H  (2AH) LHLD FAD2H
2525H  (22H) SHLD F661H     ; Address last called
2528H  (CDH) CALL F660H
252BH  (2AH) LHLD FB99H     ; Address of last variable assigned
252EH  (C3H) JMP 0804H      ; Execute BASIC program

2531H  (CDH) CALL 25A4H
2534H  (2AH) LHLD F5F4H     ; HIMEM
2537H  (EBH) XCHG
2538H  (2AH) LHLD FACEH
253BH  (DFH) RST 3          ; Compare DE and HL
253CH  (C9H) RET

; ======================================================
; Move 6 bytes (FILENAME) from M to (FACEH)
; ======================================================
253DH  (11H) LXI D,FACEH
2540H  (06H) MVI B,06H

; ======================================================
; Move B bytes from M to (DE)
; ======================================================
2542H  (7EH) MOV A,M
2543H  (12H) STAX D
2544H  (23H) INX H
2545H  (13H) INX D
2546H  (05H) DCR B
2547H  (C2H) JNZ 2542H      ; Move B bytes from M to (DE)
254AH  (C9H) RET

; ======================================================
; Launch .CO files from MENU
; ======================================================
254BH  (CDH) CALL 253DH
254EH  (E5H) PUSH H
254FH  (CDH) CALL 2534H
2552H  (DAH) JC 256DH
2555H  (EBH) XCHG
2556H  (2AH) LHLD FAD0H     ; Length of last program loaded/saved to tape
2559H  (44H) MOV B,H
255AH  (4DH) MOV C,L
255BH  (E1H) POP H
255CH  (CDH) CALL 6BDBH     ; Move BC bytes from M to (DE) with increment
255FH  (2AH) LHLD FAD2H
2562H  (7CH) MOV A,H
2563H  (B5H) ORA L
2564H  (22H) SHLD F661H     ; Address last called
2567H  (C4H) CNZ F660H
256AH  (C3H) JMP 5797H      ; MENU Program

256DH  (CDH) CALL 4229H     ; BEEP statement
2570H  (C3H) JMP 5797H      ; MENU Program

2573H  (D7H) RST 2          ; Get next non-white char from M
2574H  (CDH) CALL 25E7H     ; Evaluate arguments to CLOAD/CLOADM & Clear current BASIC program
2577H  (E5H) PUSH H         ; Save pointer to BASIC command line
2578H  (CDH) CALL 2656H     ; Open CAS for input of CO files
257BH  (CDH) CALL 26D1H
257EH  (2AH) LHLD FAD0H     ; Length of last program loaded/saved to tape
2581H  (EBH) XCHG
2582H  (2AH) LHLD FACEH
2585H  (CDH) CALL 2590H
2588H  (C2H) JNZ 2478H      ; Generate Verify Failed error
258BH  (CDH) CALL 14AAH     ; Turn cassette motor off
258EH  (E1H) POP H          ; Restore pointer to BASIC command line
258FH  (C9H) RET

2590H  (0EH) MVI C,00H
2592H  (CDH) CALL 14B0H     ; Read byte from tape & update checksum
2595H  (BEH) CMP M
2596H  (C0H) RNZ
2597H  (23H) INX H
2598H  (1BH) DCX D
2599H  (7AH) MOV A,D
259AH  (B3H) ORA E
259BH  (C2H) JNZ 2592H
259EH  (CDH) CALL 14B0H     ; Read byte from tape & update checksum
25A1H  (79H) MOV A,C
25A2H  (A7H) ANA A
25A3H  (C9H) RET

25A4H  (2AH) LHLD F67AH     ; Current executing line number
25A7H  (23H) INX H
25A8H  (7CH) MOV A,H
25A9H  (B5H) ORA L
25AAH  (C0H) RNZ
25ABH  (2AH) LHLD FACEH
25AEH  (E5H) PUSH H
25AFH  (EBH) XCHG
25B0H  (21H) LXI H,25D5H    ; Load pointer to "Top: " text
25B3H  (CDH) CALL 25CDH
25B6H  (2AH) LHLD FAD0H     ; Length of last program loaded/saved to tape
25B9H  (2BH) DCX H
25BAH  (D1H) POP D
25BBH  (19H) DAD D
25BCH  (EBH) XCHG
25BDH  (21H) LXI H,25DBH    ; Load pointer to "End: " text
25C0H  (CDH) CALL 25CDH
25C3H  (2AH) LHLD FAD2H
25C6H  (7CH) MOV A,H
25C7H  (B5H) ORA L
25C8H  (C8H) RZ
25C9H  (EBH) XCHG
25CAH  (21H) LXI H,25E1H    ; Load pointer to "Exe: " text
25CDH  (D5H) PUSH D
25CEH  (CDH) CALL 5791H     ; Print buffer at M until NULL or '"'
25D1H  (E1H) POP H
25D2H  (C3H) JMP 39D4H      ; Print binary number in HL at current position

25D5H  DB   "Top: ",00H
25DBH  DB   "End: ",00H
25E1H  DB   "Exe: ",00H

; ======================================================
; Evaluate arguments to CLOAD/CLOADM & Clear current BASIC program
; ======================================================
25E7H  (2BH) DCX H          ; Point to byte before SPACE in command line
25E8H  (D7H) RST 2          ; Get next non-white char from M
25E9H  (C2H) JNZ 25FCH      ; Evaluate arguments to CSAVE/CSAVEM commands
25ECH  (06H) MVI B,06H      ; Get length of filenames
25EEH  (11H) LXI D,FC93H    ; Filename of current BASIC program
25F1H  (3EH) MVI A,20H      ; Prepare to clear out the current BASIC program
25F3H  (12H) STAX D         ; Set next byte of current BASIC program to SPACE
25F4H  (13H) INX D          ; Point to next byte
25F5H  (05H) DCR B          ; Decrement counter
25F6H  (C2H) JNZ 25F3H      ; Keep looping until counter is zero
25F9H  (C3H) JMP 2602H

; ======================================================
; Evaluate arguments to CSAVE/CSAVEM commands
; ======================================================
25FCH  (CDH) CALL 4C0FH     ; Evaluate arguments to RUN/OPEN/SAVE commands
25FFH  (C2H) JNZ 2604H      ; Skip if valid argument not provided
2602H  (16H) MVI D,FDH      ; Load value indicating valid argument
2604H  (7AH) MOV A,D        ; Copy to A
2605H  (FEH) CPI FDH        ; Test if valid argument provided
2607H  (C2H) JNZ 08DBH      ; Generate FC error if not
260AH  (C9H) RET

; ======================================================
; Open CAS for output of BASIC files
; ======================================================
260BH  (3EH) MVI A,D3H
260DH  (01H) LXI B,9C3EH
2610H  (01H) LXI B,D03EH
2613H  (F5H) PUSH PSW
2614H  (CDH) CALL 1499H     ; Turn cassette motor on and detect sync header
2617H  (F1H) POP PSW
2618H  (CDH) CALL 14C1H     ; Write byte to tape & update checksum
261BH  (0EH) MVI C,00H
261DH  (21H) LXI H,FC93H    ; Filename of current BASIC program
2620H  (11H) LXI D,0602H
2623H  (7EH) MOV A,M
2624H  (CDH) CALL 14C1H     ; Write byte to tape & update checksum
2627H  (23H) INX H
2628H  (15H) DCR D
2629H  (C2H) JNZ 2623H
262CH  (21H) LXI H,FACEH
262FH  (16H) MVI D,0AH
2631H  (1DH) DCR E
2632H  (C2H) JNZ 2623H
2635H  (79H) MOV A,C
2636H  (2FH) CMA
2637H  (3CH) INR A
2638H  (CDH) CALL 14C1H     ; Write byte to tape & update checksum
263BH  (06H) MVI B,14H
263DH  (AFH) XRA A
263EH  (CDH) CALL 14C1H     ; Write byte to tape & update checksum
2641H  (05H) DCR B
2642H  (C2H) JNZ 263DH
2645H  (C3H) JMP 14AAH      ; Turn cassette motor off

2648H  (CDH) CALL 1499H     ; Turn cassette motor on and detect sync header
264BH  (3EH) MVI A,8DH
264DH  (C3H) JMP 14C1H      ; Write byte to tape & update checksum

; ======================================================
; Open CAS for input of BASIC files
; ======================================================
2650H  (06H) MVI B,D3H
2652H  (11H) LXI D,9C06H
2655H  (11H) LXI D,D006H
2658H  (C5H) PUSH B
2659H  (CDH) CALL 2667H
265CH  (C1H) POP B
265DH  (B8H) CMP B
265EH  (CAH) JZ 26E3H       ; Print selected program/file "Found" on tape
2661H  (CDH) CALL 26DDH     ; Print program on tape being skipped
2664H  (C3H) JMP 2658H

2667H  (CDH) CALL 148AH     ; Start tape and load tape header
266AH  (CDH) CALL 14B0H     ; Read byte from tape & update checksum
266DH  (FEH) CPI D3H
266FH  (CAH) JZ 267CH
2672H  (FEH) CPI 9CH
2674H  (CAH) JZ 267CH
2677H  (FEH) CPI D0H
2679H  (C2H) JNZ 2667H
267CH  (F5H) PUSH PSW
267DH  (21H) LXI H,FC9CH    ; Filename of last program loaded from tape
2680H  (11H) LXI D,0602H
2683H  (0EH) MVI C,00H
2685H  (CDH) CALL 14B0H     ; Read byte from tape & update checksum
2688H  (77H) MOV M,A
2689H  (23H) INX H
268AH  (15H) DCR D
268BH  (C2H) JNZ 2685H
268EH  (21H) LXI H,FACEH
2691H  (16H) MVI D,0AH
2693H  (1DH) DCR E
2694H  (C2H) JNZ 2685H
2697H  (CDH) CALL 14B0H     ; Read byte from tape & update checksum
269AH  (79H) MOV A,C
269BH  (A7H) ANA A
269CH  (C2H) JNZ 26CDH
269FH  (CDH) CALL 14AAH     ; Turn cassette motor off
26A2H  (21H) LXI H,FC93H    ; Filename of current BASIC program
26A5H  (06H) MVI B,06H
26A7H  (3EH) MVI A,20H
26A9H  (BEH) CMP M
26AAH  (C2H) JNZ 26B5H
26ADH  (23H) INX H
26AEH  (05H) DCR B
26AFH  (C2H) JNZ 26A9H
26B2H  (C3H) JMP 26C8H

26B5H  (11H) LXI D,FC93H    ; Filename of current BASIC program
26B8H  (21H) LXI H,FC9CH    ; Filename of last program loaded from tape
26BBH  (06H) MVI B,06H
26BDH  (1AH) LDAX D
26BEH  (BEH) CMP M
26BFH  (C2H) JNZ 26CAH
26C2H  (13H) INX D
26C3H  (23H) INX H
26C4H  (05H) DCR B
26C5H  (C2H) JNZ 26BDH
26C8H  (F1H) POP PSW
26C9H  (C9H) RET

26CAH  (CDH) CALL 26DDH     ; Print program on tape being skipped
26CDH  (F1H) POP PSW
26CEH  (C3H) JMP 2667H

26D1H  (CDH) CALL 148AH     ; Start tape and load tape header
26D4H  (CDH) CALL 14B0H     ; Read byte from tape & update checksum
26D7H  (FEH) CPI 8DH
26D9H  (C2H) JNZ 1491H      ; Turn cassette motor off and generate I/O Error
26DCH  (C9H) RET

; ======================================================
; Print program on tape being skipped
; ======================================================
26DDH  (11H) LXI D,2705H    ; Point to "Skip :" text
26E0H  (C3H) JMP 26E6H

; ======================================================
; Print selected program/file "Found" on tape 
; ======================================================
26E3H  (11H) LXI D,26FEH    ; Point to "Found:" text
26E6H  (2AH) LHLD F67AH     ; Current executing line number
26E9H  (23H) INX H
26EAH  (7CH) MOV A,H
26EBH  (B5H) ORA L
26ECH  (C0H) RNZ
26EDH  (EBH) XCHG
26EEH  (CDH) CALL 5791H     ; Print buffer at M until NULL or '"'
26F1H  (AFH) XRA A
26F2H  (32H) STA FCA2H
26F5H  (21H) LXI H,FC9CH    ; Filename of last program loaded from tape
26F8H  (CDH) CALL 27B1H     ; Print buffer at M until NULL or '"'
26FBH  (C3H) JMP 425DH      ; Erase from cursor to end of line

26FEH  DB   "Found:",00H
2705H  DB   "Skip :",00H

; ======================================================
; BASIC expression evaluation operator vector for String Compare
; ======================================================
270CH  (CDH) CALL 2916H     ; Get pointer to most recently used string (Len + address)
270FH  (7EH) MOV A,M        ; Get length of most recently used string
2710H  (23H) INX H          ; Increment to LSB of string pointer
2711H  (4EH) MOV C,M        ; Get LSB of string pointer
2712H  (23H) INX H          ; Increment to MSB of string pointer
2713H  (46H) MOV B,M        ; Get MSB of string pointer
2714H  (D1H) POP D
2715H  (C5H) PUSH B         ; Push pointer to string on stack
2716H  (F5H) PUSH PSW       ; Preserve string length
2717H  (CDH) CALL 291DH     ; Get pointer to stack string (Len + address).  POP based on DE
271AH  (F1H) POP PSW        ; Restore length of most recently used string
271BH  (57H) MOV D,A        ; Save length in D
271CH  (5EH) MOV E,M        ; Get length of string from stack into E
271DH  (23H) INX H          ; Increment to LSB of stack string
271EH  (4EH) MOV C,M        ; Get LSB of pointer to string from stack
271FH  (23H) INX H          ; Increment to MSB
2720H  (46H) MOV B,M        ; Get MSB of pointer to string
2721H  (E1H) POP H          ; Restore pointer to most recently used string
2722H  (7BH) MOV A,E        ; Get length of string from string stack
2723H  (B2H) ORA D          ; Or in length of most recently used string
2724H  (C8H) RZ             ; Return if both lengths are zero
2725H  (7AH) MOV A,D        ; Get length of most recently used string
2726H  (D6H) SUI 01H        ; Subtract 1 from length to test for zero
2728H  (D8H) RC             ; Return if at end of string
2729H  (AFH) XRA A          ; Zero out A
272AH  (BBH) CMP E          ; Test if at end of string from string stack
272BH  (3CH) INR A          ; Increment A (I guess to indicate strings different length)
272CH  (D0H) RNC            ; Return if at end of string from string stack
272DH  (15H) DCR D          ; Decrement length of string 1
272EH  (1DH) DCR E          ; Decrement length of string 2
272FH  (0AH) LDAX B         ; Load next byte of string from string stack
2730H  (03H) INX B          ; Increment string pointer
2731H  (BEH) CMP M          ; Compare with next byte from most recently used string
2732H  (23H) INX H          ; Increment pointer
2733H  (CAH) JZ 2722H       ; If they are equal, jump back to test the length again until at end
2736H  (3FH) CMC            ; Compliment the Carry flag for calculation of which string is larger
2737H  (C3H) JMP 33E9H      ; Jump to return 1 or -1 in A based on Carry flag

; ======================================================
; STR$ function
; ======================================================
273AH  (CDH) CALL 39E8H     ; Convert binary number in FAC1 to ASCII at M
273DH  (CDH) CALL 276BH     ; Search string at M until QUOTE found
2740H  (CDH) CALL 2919H
2743H  (01H) LXI B,2969H
2746H  (C5H) PUSH B
2747H  (7EH) MOV A,M
2748H  (23H) INX H
2749H  (E5H) PUSH H
274AH  (CDH) CALL 27C8H     ; Find space in BASIC String storage for A bytes
274DH  (E1H) POP H
274EH  (4EH) MOV C,M
274FH  (23H) INX H
2750H  (46H) MOV B,M
2751H  (CDH) CALL 2760H
2754H  (E5H) PUSH H
2755H  (6FH) MOV L,A
2756H  (CDH) CALL 290CH
2759H  (D1H) POP D
275AH  (C9H) RET

; ======================================================
; Create a 1-byte transient string (for CHR$ & INKEY$)
; ======================================================
275BH  (3EH) MVI A,01H      ; Prepare to find 1 byte in BASIC String storage

; ======================================================
; Create a transient string of length A
; ======================================================
275DH  (CDH) CALL 27C8H     ; Find space in BASIC String storage for A bytes

; ======================================================
; Save A and DE to transient string location
; ======================================================
2760H  (21H) LXI H,FB89H    ; Load address of transient string
2763H  (E5H) PUSH H         ; Save address on stack
2764H  (77H) MOV M,A        ; Copy A to transient string
2765H  (23H) INX H          ; Increment to next byte
2766H  (73H) MOV M,E        ; Save LSB of DE to transient
2767H  (23H) INX H          ; Increment to next byte
2768H  (72H) MOV M,D        ; Save MSB of DE to transient
2769H  (E1H) POP H          ; Restore address of transient
276AH  (C9H) RET

; ======================================================
; Search string at M until QUOTE found
; ======================================================
276BH  (2BH) DCX H          ; Pre-decrement HL
276CH  (06H) MVI B,22H      ; Load ASCII code for QUOTE

; ======================================================
; Search string at M until CHAR in B found
; ======================================================
276EH  (50H) MOV D,B        ; Make B & D termination chars the same

; ======================================================
; Search string at M until CHAR in B or D found and push to string stack
; ======================================================
276FH  (E5H) PUSH H         ; Save HL on stack
2770H  (0EH) MVI C,FFH      ; Initialize counter / index
2772H  (23H) INX H          ; Increment to next byte in string
2773H  (7EH) MOV A,M        ; Get next byte in string
2774H  (0CH) INR C          ; Increment count / index
2775H  (B7H) ORA A          ; Test for zero (end of string)
2776H  (CAH) JZ 2781H       ; Jump if end of string
2779H  (BAH) CMP D          ; Compare with character in D
277AH  (CAH) JZ 2781H       ; Exit loop if match
277DH  (B8H) CMP B          ; Compare with character in B
277EH  (C2H) JNZ 2772H      ; Jump back to compare next byte in string if no match
2781H  (FEH) CPI 22H        ; Compare with QUOTE
2783H  (CCH) CZ 0858H       ; RST 10H routine with pre-increment of HL
2786H  (E3H) XTHL           ; Restore pointer to string from stack
2787H  (23H) INX H
2788H  (EBH) XCHG
2789H  (79H) MOV A,C
278AH  (CDH) CALL 2760H     ; Save A and DE to transient string storage

; ======================================================
; Add new transient string to string stack
; ======================================================
278DH  (11H) LXI D,FB89H    ; Point to transient string storage
2790H  (3EH) MVI A,D5H      ; Seems pointless considering "MVI A,03H" below???
2792H  (2AH) LHLD FB69H     ; Get current location in string stack maybe?
2795H  (22H) SHLD FC1AH     ; Start of FAC1 for integers
2798H  (3EH) MVI A,03H      ; Make type of last variable a string
279AH  (32H) STA FB65H      ; Type of last variable used
279DH  (CDH) CALL 3465H     ; Copy transient string onto string stack perhaps?
27A0H  (11H) LXI D,FB8CH    ; Pointer to current location in BASIC string buffer
27A3H  (DFH) RST 3          ; Compare DE and HL
27A4H  (22H) SHLD FB69H     ; Save new location in string stack?
27A7H  (E1H) POP H
27A8H  (7EH) MOV A,M
27A9H  (C0H) RNZ
27AAH  (11H) LXI D,0010H    ; Load code for ST error (String too Complex)
27ADH  (C3H) JMP 045DH      ; Generate error in E

; ======================================================
; Print buffer at M-1 until NULL or '"'
; ======================================================
27B0H  (23H) INX H

; ======================================================
; Print buffer at M until NULL or '"'
; ======================================================
27B1H  (CDH) CALL 276BH     ; Search string at M until QUOTE found
27B4H  (CDH) CALL 2919H
27B7H  (CDH) CALL 3452H
27BAH  (14H) INR D
27BBH  (15H) DCR D
27BCH  (C8H) RZ
27BDH  (0AH) LDAX B
27BEH  (E7H) RST 4          ; Send character in A to screen/printer
27BFH  (FEH) CPI 0DH
27C1H  (CCH) CZ 4BD1H
27C4H  (03H) INX B
27C5H  (C3H) JMP 27BBH

; ======================================================
; Maybe find space in BASIC String storage for A bytes?
; ======================================================
27C8H  (B7H) ORA A          ; Test if A is zero
27C9H  (0EH) MVI C,F1H      ; I think this is a hidden "(F1H) POP PSW" at address 27CAH
27CBH  (F5H) PUSH PSW       ; Save A & flags to stack
27CCH  (2AH) LHLD F678H     ; BASIC string buffer pointer
27CFH  (EBH) XCHG
27D0H  (2AH) LHLD FB8CH     ; Pointer to current location in BASIC string buffer
27D3H  (2FH) CMA            ; Compliment A to determine how much space needed in buffer for string
27D4H  (4FH) MOV C,A        ; Move Negative value to C
27D5H  (06H) MVI B,FFH      ; Sign extend BC
27D7H  (09H) DAD B          ; Subtract length from current buffer location
27D8H  (23H) INX H          ; Increment for 2's compliment
27D9H  (DFH) RST 3          ; Compare DE and HL
27DAH  (DAH) JC 27E4H       ; Jump to move stuff around if no space
27DDH  (22H) SHLD FB8CH     ; Save new current BASIC string buffer location
27E0H  (23H) INX H          ; Increment to next location in BASIC string buffer.  Why?
27E1H  (EBH) XCHG           ; DE has current location, HL has start
27E2H  (F1H) POP PSW        ; Restore stack frame
27E3H  (C9H) RET

; ======================================================
; ?? Maybe make space in BASIC String storage for A bytes
; ======================================================
27E4H  (F1H) POP PSW        ; Get Flags from stack
27E5H  (11H) LXI D,000EH    ; Prepare to generate OS Error
27E8H  (CAH) JZ 045DH       ; Generate error in E
27EBH  (BFH) CMP A
27ECH  (F5H) PUSH PSW
27EDH  (01H) LXI B,27CAH    ; I think this is a RET address to a POP PSW above
27F0H  (C5H) PUSH B
27F1H  (2AH) LHLD FB67H     ; File buffer area pointer
27F4H  (22H) SHLD FB8CH     ; Pointer to current location in BASIC string buffer
27F7H  (21H) LXI H,0000H
27FAH  (E5H) PUSH H
27FBH  (2AH) LHLD FBB6H     ; Unused memory pointer
27FEH  (E5H) PUSH H
27FFH  (21H) LXI H,FB6BH
2802H  (EBH) XCHG
2803H  (2AH) LHLD FB69H
2806H  (EBH) XCHG
2807H  (DFH) RST 3          ; Compare DE and HL
2808H  (01H) LXI B,2802H
280BH  (C2H) JNZ 2887H
280EH  (21H) LXI H,FBD9H
2811H  (22H) SHLD FBE2H
2814H  (2AH) LHLD FBB4H     ; Start of array table pointer
2817H  (22H) SHLD FBDFH
281AH  (2AH) LHLD FBB2H     ; Start of variable data pointer
281DH  (EBH) XCHG
281EH  (2AH) LHLD FBDFH
2821H  (EBH) XCHG
2822H  (DFH) RST 3          ; Compare DE and HL
2823H  (CAH) JZ 283AH
2826H  (7EH) MOV A,M
2827H  (23H) INX H
2828H  (23H) INX H
2829H  (23H) INX H
282AH  (FEH) CPI 03H
282CH  (C2H) JNZ 2833H
282FH  (CDH) CALL 2888H
2832H  (AFH) XRA A
2833H  (5FH) MOV E,A
2834H  (16H) MVI D,00H
2836H  (19H) DAD D
2837H  (C3H) JMP 281DH

283AH  (2AH) LHLD FBE2H
283DH  (5EH) MOV E,M
283EH  (23H) INX H
283FH  (56H) MOV D,M
2840H  (7AH) MOV A,D
2841H  (B3H) ORA E
2842H  (2AH) LHLD FBB4H     ; Start of array table pointer
2845H  (CAH) JZ 285CH
2848H  (EBH) XCHG
2849H  (22H) SHLD FBE2H
284CH  (23H) INX H
284DH  (23H) INX H
284EH  (5EH) MOV E,M.*lxi.*\n.*lxi.*\n.*lxi.*\n.*lxi
284FH  (23H) INX H
2850H  (56H) MOV D,M
2851H  (23H) INX H
2852H  (EBH) XCHG
2853H  (19H) DAD D
2854H  (22H) SHLD FBDFH
2857H  (EBH) XCHG
2858H  (C3H) JMP 281DH

285BH  (C1H) POP B
285CH  (EBH) XCHG
285DH  (2AH) LHLD FBB6H     ; Unused memory pointer
2860H  (EBH) XCHG
2861H  (DFH) RST 3          ; Compare DE and HL
2862H  (CAH) JZ 28A8H
2865H  (7EH) MOV A,M
2866H  (23H) INX H
2867H  (CDH) CALL 3450H     ; Reverse load single precision at M to DEBC
286AH  (E5H) PUSH H
286BH  (09H) DAD B
286CH  (FEH) CPI 03H
286EH  (C2H) JNZ 285BH
2871H  (22H) SHLD FB90H
2874H  (E1H) POP H
2875H  (4EH) MOV C,M
2876H  (06H) MVI B,00H
2878H  (09H) DAD B
2879H  (09H) DAD B
287AH  (23H) INX H
287BH  (EBH) XCHG
287CH  (2AH) LHLD FB90H
287FH  (EBH) XCHG
2880H  (DFH) RST 3          ; Compare DE and HL
2881H  (CAH) JZ 285CH
2884H  (01H) LXI B,287BH
2887H  (C5H) PUSH B
2888H  (AFH) XRA A
2889H  (B6H) ORA M
288AH  (23H) INX H
288BH  (5EH) MOV E,M
288CH  (23H) INX H
288DH  (56H) MOV D,M
288EH  (23H) INX H
288FH  (C8H) RZ
2890H  (44H) MOV B,H
2891H  (4DH) MOV C,L
2892H  (2AH) LHLD FB8CH     ; Pointer to current location in BASIC string buffer
2895H  (DFH) RST 3          ; Compare DE and HL
2896H  (60H) MOV H,B
2897H  (69H) MOV L,C
2898H  (D8H) RC
2899H  (E1H) POP H
289AH  (E3H) XTHL
289BH  (DFH) RST 3          ; Compare DE and HL
289CH  (E3H) XTHL
289DH  (E5H) PUSH H
289EH  (60H) MOV H,B
289FH  (69H) MOV L,C
28A0H  (D0H) RNC
28A1H  (C1H) POP B
28A2H  (F1H) POP PSW
28A3H  (F1H) POP PSW
28A4H  (E5H) PUSH H
28A5H  (D5H) PUSH D
28A6H  (C5H) PUSH B
28A7H  (C9H) RET

28A8H  (D1H) POP D
28A9H  (E1H) POP H
28AAH  (7CH) MOV A,H
28ABH  (B5H) ORA L
28ACH  (C8H) RZ
28ADH  (2BH) DCX H
28AEH  (46H) MOV B,M
28AFH  (2BH) DCX H
28B0H  (4EH) MOV C,M
28B1H  (E5H) PUSH H
28B2H  (2BH) DCX H
28B3H  (6EH) MOV L,M
28B4H  (26H) MVI H,00H
28B6H  (09H) DAD B
28B7H  (50H) MOV D,B
28B8H  (59H) MOV E,C
28B9H  (2BH) DCX H
28BAH  (44H) MOV B,H
28BBH  (4DH) MOV C,L
28BCH  (2AH) LHLD FB8CH     ; Pointer to current location in BASIC string buffer
28BFH  (CDH) CALL 3EF3H
28C2H  (E1H) POP H
28C3H  (71H) MOV M,C
28C4H  (23H) INX H
28C5H  (70H) MOV M,B
28C6H  (60H) MOV H,B
28C7H  (69H) MOV L,C
28C8H  (2BH) DCX H
28C9H  (C3H) JMP 27F4H

28CCH  (C5H) PUSH B
28CDH  (E5H) PUSH H
28CEH  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
28D1H  (E3H) XTHL
28D2H  (CDH) CALL 0F1CH     ; Evaluate function at M
28D5H  (E3H) XTHL
28D6H  (CDH) CALL 35D9H     ; Generate TM error if last variable type not string or RET
28D9H  (7EH) MOV A,M
28DAH  (E5H) PUSH H
28DBH  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
28DEH  (E5H) PUSH H
28DFH  (86H) ADD M
28E0H  (11H) LXI D,000FH    ; Prepare to generate LS Error (String too Long)
28E3H  (DAH) JC 045DH       ; Generate error in E
28E6H  (CDH) CALL 275DH     ; Create a transient string of length A
28E9H  (D1H) POP D
28EAH  (CDH) CALL 291DH
28EDH  (E3H) XTHL
28EEH  (CDH) CALL 291CH
28F1H  (E5H) PUSH H
28F2H  (2AH) LHLD FB8AH     ; Address of transient string
28F5H  (EBH) XCHG
28F6H  (CDH) CALL 2904H     ; Move Variable pointed to on Stack to (DE)
28F9H  (CDH) CALL 2904H     ; Move Variable pointed to on Stack to (DE)
28FCH  (21H) LXI H,0DB7H
28FFH  (E3H) XTHL
2900H  (E5H) PUSH H
2901H  (C3H) JMP 278DH      ; Add new transient string to string stack

; ======================================================
; Move Variable pointed to by top of Stack to (DE)
; ======================================================
2904H  (E1H) POP H          ; POP return address from Stack
2905H  (E3H) XTHL           ; Swap RET address with top of Stack (Pointer to var)
2906H  (7EH) MOV A,M        ; Get length of variable (2, 4, or 8)
2907H  (23H) INX H          ; Increment to variable address LSB
2908H  (4EH) MOV C,M        ; Get LSB of variable address in C
2909H  (23H) INX H          ; Increment to variable address MSB
290AH  (46H) MOV B,M        ; Get MSB of variable address
290BH  (6FH) MOV L,A        ; Move variable length to L
290CH  (2CH) INR L          ; Pre-increment L

; ======================================================
; Keep copying bytes from (BC) to (DE) until counter (L) is zero
; ======================================================
290DH  (2DH) DCR L          ; Decrement loop counter
290EH  (C8H) RZ             ; Return if counter is zero

; ======================================================
; Move L bytes from (BC) to (DE)
; ======================================================
290FH  (0AH) LDAX B         ; Load next byte from BC
2910H  (12H) STAX D         ; Store byte in DE
2911H  (03H) INX B          ; Increment Source ptr
2912H  (13H) INX D          ; Increment Dest ptr
2913H  (C3H) JMP 290DH      ; Jump to test loop counter

; ======================================================
; Get pointer to most recently used string (Len + address)
; This may be pointed to by FAC1 or may from from the string stack
; ======================================================
2916H  (CDH) CALL 35D9H     ; Generate TM error if last variable type not string or RET
2919H  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
291CH  (EBH) XCHG           ; DE = Start of FAC1 for integers

; ======================================================
; Get pointer to stack string (Len + address).  POP based on DE
; This may point to FAC1 or may be from the string stack
; ======================================================
291DH  (CDH) CALL 2935H     ; POP next string from string stack for computation into BC
2920H  (EBH) XCHG           ; HL = Start of FAC1 for integers
2921H  (C0H) RNZ            ; Return if string stack empty
2922H  (D5H) PUSH D         ; Save address of "POPed" string to stack
2923H  (50H) MOV D,B        ; Load address of string to DE
2924H  (59H) MOV E,C        ; Load LSB too
2925H  (1BH) DCX D
2926H  (4EH) MOV C,M
2927H  (2AH) LHLD FB8CH     ; Pointer to current location in BASIC string buffer
292AH  (DFH) RST 3          ; Compare DE and HL
292BH  (C2H) JNZ 2933H
292EH  (47H) MOV B,A
292FH  (09H) DAD B
2930H  (22H) SHLD FB8CH     ; Pointer to current location in BASIC string buffer
2933H  (E1H) POP H
2934H  (C9H) RET

; ======================================================
; Get top  string from string stack for computation into BC perhaps?
; POP if Stack = DE
; ======================================================
2935H  (2AH) LHLD FB69H     ; Load current string stack address
2938H  (2BH) DCX H          ; Pre-decrement to get MSB of string address
2939H  (46H) MOV B,M        ; Get MSB of top entry
293AH  (2BH) DCX H          ; Decrement to LSB of string address
293BH  (4EH) MOV C,M        ; Get LSB of top entry
293CH  (2BH) DCX H          ; Decrement again to point to string length 
293DH  (DFH) RST 3          ; Compare DE and HL
293EH  (C0H) RNZ            ; Don't save new stack location if HL == DE?
293FH  (22H) SHLD FB69H     ; Save new stack location
2942H  (C9H) RET

; ======================================================
; LEN function
; ======================================================
2943H  (01H) LXI B,10D1H    ; Address of Load integer in A into FAC1 routine
2946H  (C5H) PUSH B         ; PUSH return address to load A to FAC1

; ======================================================
; Get length of most recently used string
; ======================================================
2947H  (CDH) CALL 2916H     ; Get pointer to most recently used string (Len + address)
294AH  (AFH) XRA A          ; Zero out A.  Not sure why, we overwrite below
294BH  (57H) MOV D,A        ; Zero out D. Why?
294CH  (7EH) MOV A,M        ; Get Length of string
294DH  (B7H) ORA A          ; Test length for zero
294EH  (C9H) RET

; ======================================================
; ASC function
; ======================================================
294FH  (01H) LXI B,10D1H    ; Address of Load integer in A into FAC1 routine
2952H  (C5H) PUSH B         ; PUSH return address to load A to FAC1
2953H  (CDH) CALL 2947H     ; Why not just call 2943? Get Length of most recently used String
2956H  (CAH) JZ 08DBH       ; Generate FC error if LEN=0
2959H  (23H) INX H          ; Increment past string length to LSB of string
295AH  (5EH) MOV E,M        ; Get LSB of string pointer
295BH  (23H) INX H          ; Increment to MSB 
295CH  (56H) MOV D,M        ; Get MSB of string pointer
295DH  (1AH) LDAX D         ; Get value of 1st character = ASC function
295EH  (C9H) RET

; ======================================================
; CHR$ function
; ======================================================
295FH  (CDH) CALL 275BH     ; Create a 1-byte transient string (for CHR$ & INKEY$)
2962H  (CDH) CALL 1131H     ; Get expression integer < 256 in A or FC Error
2965H  (2AH) LHLD FB8AH     ; Address of transient string
2968H  (73H) MOV M,E
2969H  (C1H) POP B
296AH  (C3H) JMP 278DH      ; Add new transient string to string stack

; ======================================================
; STRING$ function
; ======================================================
296DH  (D7H) RST 2          ; Get next non-white char from M
296EH  (CFH) RST 1          ; Compare next byte with M
296FH  DB   28H
2970H  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
2973H  (D5H) PUSH D
2974H  (CFH) RST 1          ; Compare next byte with M
2975H  DB   2CH
2976H  (CDH) CALL 0DABH     ; Main BASIC evaluation routine
2979H  (CFH) RST 1          ; Compare next byte with M
297AH  DB   29H
297BH  (E3H) XTHL
297CH  (E5H) PUSH H
297DH  (EFH) RST 5          ; Determine type of last var used
297EH  (CAH) JZ 2987H
2981H  (CDH) CALL 1131H     ; Get expression integer < 256 in A or FC Error
2984H  (C3H) JMP 298AH

2987H  (CDH) CALL 2953H
298AH  (D1H) POP D
298BH  (CDH) CALL 2993H

; ======================================================
; SPACE$ function
; ======================================================
298EH  (CDH) CALL 1131H     ; Get expression integer < 256 in A or FC Error
2991H  (3EH) MVI A,20H
2993H  (F5H) PUSH PSW
2994H  (7BH) MOV A,E
2995H  (CDH) CALL 275DH     ; Create a transient string of length A
2998H  (47H) MOV B,A
2999H  (F1H) POP PSW
299AH  (04H) INR B
299BH  (05H) DCR B
299CH  (CAH) JZ 2969H
299FH  (2AH) LHLD FB8AH     ; Address of transient string
29A2H  (77H) MOV M,A
29A3H  (23H) INX H
29A4H  (05H) DCR B
29A5H  (C2H) JNZ 29A2H
29A8H  (C3H) JMP 2969H

; ======================================================
; LEFT$ function
; ======================================================
29ABH  (CDH) CALL 2A2FH
29AEH  (AFH) XRA A
29AFH  (E3H) XTHL
29B0H  (4FH) MOV C,A
29B1H  (3EH) MVI A,E5H      ; This is a Hidden (E5H) PUSH H at 29B2H
29B3H  (E5H) PUSH H
29B4H  (7EH) MOV A,M
29B5H  (B8H) CMP B
29B6H  (DAH) JC 29BBH
29B9H  (78H) MOV A,B
29BAH  (11H) LXI D,000EH
29BDH  (C5H) PUSH B
29BEH  (CDH) CALL 27C8H     ; Find space in BASIC String storage for A bytes
29C1H  (C1H) POP B
29C2H  (E1H) POP H
29C3H  (E5H) PUSH H
29C4H  (23H) INX H
29C5H  (46H) MOV B,M
29C6H  (23H) INX H
29C7H  (66H) MOV H,M
29C8H  (68H) MOV L,B
29C9H  (06H) MVI B,00H
29CBH  (09H) DAD B
29CCH  (44H) MOV B,H
29CDH  (4DH) MOV C,L
29CEH  (CDH) CALL 2760H
29D1H  (6FH) MOV L,A
29D2H  (CDH) CALL 290CH
29D5H  (D1H) POP D
29D6H  (CDH) CALL 291DH
29D9H  (C3H) JMP 278DH      ; Add new transient string to string stack

; ======================================================
; RIGHT$ function
; ======================================================
29DCH  (CDH) CALL 2A2FH
29DFH  (D1H) POP D
29E0H  (D5H) PUSH D
29E1H  (1AH) LDAX D
29E2H  (90H) SUB B
29E3H  (C3H) JMP 29AFH


; ======================================================
; MID$ function
; ======================================================
29E6H  (EBH) XCHG
29E7H  (7EH) MOV A,M
29E8H  (CDH) CALL 2A32H
29EBH  (04H) INR B
29ECH  (05H) DCR B
29EDH  (CAH) JZ 08DBH       ; Generate FC error
29F0H  (C5H) PUSH B
29F1H  (CDH) CALL 2B3DH
29F4H  (F1H) POP PSW
29F5H  (E3H) XTHL
29F6H  (01H) LXI B,29B3H
29F9H  (C5H) PUSH B
29FAH  (3DH) DCR A
29FBH  (BEH) CMP M
29FCH  (06H) MVI B,00H
29FEH  (D0H) RNC
29FFH  (4FH) MOV C,A
2A00H  (7EH) MOV A,M
2A01H  (91H) SUB C
2A02H  (BBH) CMP E
2A03H  (47H) MOV B,A
2A04H  (D8H) RC
2A05H  (43H) MOV B,E
2A06H  (C9H) RET


; ======================================================
; VAL function
; ======================================================
2A07H  (CDH) CALL 2947H
2A0AH  (CAH) JZ 10D1H       ; Load integer in A into FAC1
2A0DH  (5FH) MOV E,A
2A0EH  (23H) INX H
2A0FH  (7EH) MOV A,M
2A10H  (23H) INX H
2A11H  (66H) MOV H,M
2A12H  (6FH) MOV L,A
2A13H  (E5H) PUSH H
2A14H  (19H) DAD D
2A15H  (46H) MOV B,M
2A16H  (22H) SHLD F67EH
2A19H  (78H) MOV A,B
2A1AH  (32H) STA FBE6H
2A1DH  (72H) MOV M,D
2A1EH  (E3H) XTHL
2A1FH  (C5H) PUSH B
2A20H  (2BH) DCX H
2A21H  (D7H) RST 2          ; Get next non-white char from M
2A22H  (CDH) CALL 3840H     ; Convert ASCII number at M to double precision in FAC1
2A25H  (21H) LXI H,0000H
2A28H  (22H) SHLD F67EH
2A2BH  (C1H) POP B
2A2CH  (E1H) POP H
2A2DH  (70H) MOV M,B
2A2EH  (C9H) RET

2A2FH  (EBH) XCHG
2A30H  (CFH) RST 1          ; Compare next byte with M
2A31H  DB   29H             ;     compare with ')'
2A32H  (C1H) POP B
2A33H  (D1H) POP D
2A34H  (C5H) PUSH B
2A35H  (43H) MOV B,E
2A36H  (C9H) RET

; ======================================================
; INSTR function
; ======================================================
2A37H  (D7H) RST 2          ; Get next non-white char from M
2A38H  (CDH) CALL 0DA9H
2A3BH  (EFH) RST 5          ; Determine type of last var used
2A3CH  (3EH) MVI A,01H
2A3EH  (F5H) PUSH PSW
2A3FH  (CAH) JZ 2A53H
2A42H  (F1H) POP PSW
2A43H  (CDH) CALL 1131H     ; Get expression integer < 256 in A or FC Error
2A46H  (B7H) ORA A
2A47H  (CAH) JZ 08DBH       ; Generate FC error
2A4AH  (F5H) PUSH PSW
2A4BH  (CFH) RST 1          ; Compare next byte with M
2A4CH  DB   2CH
2A4DH  (CDH) CALL 0DABH     ; Main BASIC evaluation routine
2A50H  (CDH) CALL 35D9H
2A53H  (CFH) RST 1          ; Compare next byte with M
2A54H  DB   2CH
2A55H  (E5H) PUSH H
2A56H  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
2A59H  (E3H) XTHL
2A5AH  (CDH) CALL 0DABH     ; Main BASIC evaluation routine
2A5DH  (CFH) RST 1          ; Compare next byte with M
2A5EH  DB   29H
2A5FH  (E5H) PUSH H
2A60H  (CDH) CALL 2916H     ; Get pointer to most recently used string (Len + address)
2A63H  (EBH) XCHG
2A64H  (C1H) POP B
2A65H  (E1H) POP H
2A66H  (F1H) POP PSW
2A67H  (C5H) PUSH B
2A68H  (01H) LXI B,383EH
2A6BH  (C5H) PUSH B
2A6CH  (01H) LXI B,10D1H    ; Load integer in A into FAC1
2A6FH  (C5H) PUSH B
2A70H  (F5H) PUSH PSW
2A71H  (D5H) PUSH D
2A72H  (CDH) CALL 291CH
2A75H  (D1H) POP D
2A76H  (F1H) POP PSW
2A77H  (47H) MOV B,A
2A78H  (3DH) DCR A
2A79H  (4FH) MOV C,A
2A7AH  (BEH) CMP M
2A7BH  (3EH) MVI A,00H
2A7DH  (D0H) RNC
2A7EH  (1AH) LDAX D
2A7FH  (B7H) ORA A
2A80H  (78H) MOV A,B
2A81H  (C8H) RZ
2A82H  (7EH) MOV A,M
2A83H  (23H) INX H
2A84H  (46H) MOV B,M
2A85H  (23H) INX H
2A86H  (66H) MOV H,M
2A87H  (68H) MOV L,B
2A88H  (06H) MVI B,00H
2A8AH  (09H) DAD B
2A8BH  (91H) SUB C
2A8CH  (47H) MOV B,A
2A8DH  (C5H) PUSH B
2A8EH  (D5H) PUSH D
2A8FH  (E3H) XTHL
2A90H  (4EH) MOV C,M
2A91H  (23H) INX H
2A92H  (5EH) MOV E,M
2A93H  (23H) INX H
2A94H  (56H) MOV D,M
2A95H  (E1H) POP H
2A96H  (E5H) PUSH H
2A97H  (D5H) PUSH D
2A98H  (C5H) PUSH B
2A99H  (1AH) LDAX D
2A9AH  (BEH) CMP M
2A9BH  (C2H) JNZ 2AB7H
2A9EH  (13H) INX D
2A9FH  (0DH) DCR C
2AA0H  (CAH) JZ 2AAEH
2AA3H  (23H) INX H
2AA4H  (05H) DCR B
2AA5H  (C2H) JNZ 2A99H
2AA8H  (D1H) POP D
2AA9H  (D1H) POP D
2AAAH  (C1H) POP B
2AABH  (D1H) POP D
2AACH  (AFH) XRA A
2AADH  (C9H) RET

2AAEH  (E1H) POP H
2AAFH  (D1H) POP D
2AB0H  (D1H) POP D
2AB1H  (C1H) POP B
2AB2H  (78H) MOV A,B
2AB3H  (94H) SUB H
2AB4H  (81H) ADD C
2AB5H  (3CH) INR A
2AB6H  (C9H) RET

2AB7H  (C1H) POP B
2AB8H  (D1H) POP D
2AB9H  (E1H) POP H
2ABAH  (23H) INX H
2ABBH  (05H) DCR B
2ABCH  (C2H) JNZ 2A96H
2ABFH  (C3H) JMP 2AABH

2AC2H  (CFH) RST 1          ; Compare next byte with M
2AC3H  DB   28H
2AC4H  (CDH) CALL 4790H     ; Find address of variable at M
2AC7H  (CDH) CALL 35D9H
2ACAH  (E5H) PUSH H
2ACBH  (D5H) PUSH D
2ACCH  (EBH) XCHG
2ACDH  (23H) INX H
2ACEH  (5EH) MOV E,M
2ACFH  (23H) INX H
2AD0H  (56H) MOV D,M
2AD1H  (2AH) LHLD FBB6H     ; Unused memory pointer
2AD4H  (DFH) RST 3          ; Compare DE and HL
2AD5H  (DAH) JC 2AE9H
2AD8H  (2AH) LHLD F67CH     ; Start of BASIC program pointer
2ADBH  (DFH) RST 3          ; Compare DE and HL
2ADCH  (D2H) JNC 2AE9H
2ADFH  (E1H) POP H
2AE0H  (E5H) PUSH H
2AE1H  (CDH) CALL 2747H
2AE4H  (E1H) POP H
2AE5H  (E5H) PUSH H
2AE6H  (CDH) CALL 3465H
2AE9H  (E1H) POP H
2AEAH  (E3H) XTHL
2AEBH  (CFH) RST 1          ; Compare next byte with M
2AECH  DB   2CH
2AEDH  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
2AF0H  (B7H) ORA A
2AF1H  (CAH) JZ 08DBH       ; Generate FC error
2AF4H  (F5H) PUSH PSW
2AF5H  (7EH) MOV A,M
2AF6H  (CDH) CALL 2B3DH
2AF9H  (D5H) PUSH D
2AFAH  (CDH) CALL 0DA4H
2AFDH  (E5H) PUSH H
2AFEH  (CDH) CALL 2916H     ; Get pointer to most recently used string (Len + address)
2B01H  (EBH) XCHG
2B02H  (E1H) POP H
2B03H  (C1H) POP B
2B04H  (F1H) POP PSW
2B05H  (47H) MOV B,A
2B06H  (E3H) XTHL
2B07H  (E5H) PUSH H
2B08H  (21H) LXI H,383EH
2B0BH  (E3H) XTHL
2B0CH  (79H) MOV A,C
2B0DH  (B7H) ORA A
2B0EH  (C8H) RZ
2B0FH  (7EH) MOV A,M
2B10H  (90H) SUB B
2B11H  (DAH) JC 08DBH       ; Generate FC error
2B14H  (3CH) INR A
2B15H  (B9H) CMP C
2B16H  (DAH) JC 2B1AH
2B19H  (79H) MOV A,C
2B1AH  (48H) MOV C,B
2B1BH  (0DH) DCR C
2B1CH  (06H) MVI B,00H
2B1EH  (D5H) PUSH D
2B1FH  (23H) INX H
2B20H  (5EH) MOV E,M
2B21H  (23H) INX H
2B22H  (66H) MOV H,M
2B23H  (6BH) MOV L,E
2B24H  (09H) DAD B
2B25H  (47H) MOV B,A
2B26H  (D1H) POP D
2B27H  (EBH) XCHG
2B28H  (4EH) MOV C,M
2B29H  (23H) INX H
2B2AH  (7EH) MOV A,M
2B2BH  (23H) INX H
2B2CH  (66H) MOV H,M
2B2DH  (6FH) MOV L,A
2B2EH  (EBH) XCHG
2B2FH  (79H) MOV A,C
2B30H  (B7H) ORA A
2B31H  (C8H) RZ
2B32H  (1AH) LDAX D
2B33H  (77H) MOV M,A
2B34H  (13H) INX D
2B35H  (23H) INX H
2B36H  (0DH) DCR C
2B37H  (C8H) RZ
2B38H  (05H) DCR B
2B39H  (C2H) JNZ 2B32H
2B3CH  (C9H) RET

2B3DH  (1EH) MVI E,FFH
2B3FH  (FEH) CPI 29H
2B41H  (CAH) JZ 2B49H
2B44H  (CFH) RST 1          ; Compare next byte with M
2B45H  DB   2CH
2B46H  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
2B49H  (CFH) RST 1          ; Compare next byte with M
2B4AH  DB   29H
2B4BH  (C9H) RET

; ======================================================
; FRE function
; ======================================================
2B4CH  (2AH) LHLD FBB6H     ; Unused memory pointer
2B4FH  (EBH) XCHG           ; Move unused memory location to DE
2B50H  (21H) LXI H,0000H    ; Prepare to get current SP to calc free space
2B53H  (39H) DAD SP         ; Get current SP
2B54H  (EFH) RST 5          ; Determine type of last var used
2B55H  (C2H) JNZ 10BFH      ; If not string, Subtract HL - DE and unsigned convert to SNGL in FAC1
2B58H  (CDH) CALL 2919H
2B5BH  (CDH) CALL 27F1H
2B5EH  (EBH) XCHG
2B5FH  (2AH) LHLD F678H     ; BASIC string buffer pointer
2B62H  (EBH) XCHG
2B63H  (2AH) LHLD FB8CH     ; Pointer to current location in BASIC string buffer
2B66H  (C3H) JMP 10BFH      ; Subtract HL - DE and unsigned convert to SNGL in FAC1

; ======================================================
; Double precision subtract (FAC1=FAC1-FAC2)
; ======================================================
2B69H  (21H) LXI H,FC69H    ; Start of FAC2 for single and double precision
2B6CH  (7EH) MOV A,M
2B6DH  (B7H) ORA A
2B6EH  (C8H) RZ
2B6FH  (EEH) XRI 80H
2B71H  (77H) MOV M,A
2B72H  (C3H) JMP 2B7EH

2B75H  (CDH) CALL 3461H     ; Move M to FAC2 using precision at (FB65H)

; ======================================================
; Double precision addition (FAC1=FAC1+FAC2)
; ======================================================
2B78H  (21H) LXI H,FC69H    ; Start of FAC2 for single and double precision
2B7BH  (7EH) MOV A,M
2B7CH  (B7H) ORA A
2B7DH  (C8H) RZ
2B7EH  (E6H) ANI 7FH
2B80H  (47H) MOV B,A
2B81H  (11H) LXI D,FC18H    ; Start of FAC1 for single and double precision
2B84H  (1AH) LDAX D
2B85H  (B7H) ORA A
2B86H  (CAH) JZ 347BH       ; Copy FAC2 to FAC1
2B89H  (E6H) ANI 7FH
2B8BH  (90H) SUB B
2B8CH  (D2H) JNC 2BA2H
2B8FH  (2FH) CMA
2B90H  (3CH) INR A
2B91H  (F5H) PUSH PSW
2B92H  (E5H) PUSH H
2B93H  (06H) MVI B,08H
2B95H  (1AH) LDAX D
2B96H  (4EH) MOV C,M
2B97H  (77H) MOV M,A
2B98H  (79H) MOV A,C
2B99H  (12H) STAX D
2B9AH  (13H) INX D
2B9BH  (23H) INX H
2B9CH  (05H) DCR B
2B9DH  (C2H) JNZ 2B95H
2BA0H  (E1H) POP H
2BA1H  (F1H) POP PSW
2BA2H  (FEH) CPI 10H
2BA4H  (D0H) RNC
2BA5H  (F5H) PUSH PSW
2BA6H  (AFH) XRA A
2BA7H  (32H) STA FC20H      ; Temp BCD value for computation?
2BAAH  (32H) STA FC71H
2BADH  (21H) LXI H,FC6AH
2BB0H  (F1H) POP PSW
2BB1H  (CDH) CALL 2CADH
2BB4H  (21H) LXI H,FC69H    ; Start of FAC2 for single and double precision
2BB7H  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
2BBAH  (AEH) XRA M
2BBBH  (FAH) JM 2BDBH
2BBEH  (3AH) LDA FC71H
2BC1H  (32H) STA FC20H      ; Temp BCD value for computation?
2BC4H  (CDH) CALL 2C46H     ; Add FAC2 to FAC1
2BC7H  (D2H) JNC 2C27H
2BCAH  (EBH) XCHG
2BCBH  (7EH) MOV A,M
2BCCH  (34H) INR M
2BCDH  (AEH) XRA M
2BCEH  (FAH) JM 0455H       ; Generate OV error
2BD1H  (CDH) CALL 2CF2H
2BD4H  (7EH) MOV A,M
2BD5H  (F6H) ORI 10H
2BD7H  (77H) MOV M,A
2BD8H  (C3H) JMP 2C27H

; ======================================================
; Normalize FAC1 such that the 1st BCD digit isn't zero
; ======================================================
2BDBH  (CDH) CALL 2C5AH
2BDEH  (21H) LXI H,FC19H    ; Point to BCD portion of FAC1
2BE1H  (01H) LXI B,0800H    ; Prepare to process 8 bytes, C = 0 = BCD Shift distance
2BE4H  (7EH) MOV A,M        ; Test next 2 digits from FAC1
2BE5H  (B7H) ORA A          ; Test for digits "00"
2BE6H  (C2H) JNZ 2BF3H      ; Jump if not "00"
2BE9H  (23H) INX H          ; Increment to next 2 digits in FAC1 - Skip this byte
2BEAH  (0DH) DCR C          ; Decrement Digit counter
2BEBH  (0DH) DCR C          ; Decrement Digit counter
2BECH  (05H) DCR B          ; Decrement byte counter
2BEDH  (C2H) JNZ 2BE4H      ; Keep looping until all bytes processed
2BF0H  (C3H) JMP 33EDH      ; Initialize FAC1 for SGL & DBL precision to zero

; ======================================================
; First non "00" BCD digit found.  Test MSB for zero & adjust
; ======================================================
2BF3H  (E6H) ANI F0H        ; Mask off the lower digit to see if BCD shift needed (4-bit shift)
2BF5H  (C2H) JNZ 2BFEH      ; Jump ahead if not zero MSB of this byte isn't zero
2BF8H  (E5H) PUSH H         ; Save pointer to current location in FAC1
2BF9H  (CDH) CALL 2C94H     ; Rotate FAC1 1 BCD digit left to normalize starting at HL for B bytes
2BFCH  (E1H) POP H          ; Restore current pointer into FAC1
2BFDH  (0DH) DCR C          ; Decrement the digit counter
2BFEH  (3EH) MVI A,08H      ; Prepare to calculate number of bytes with "00" that were skipped
2C00H  (90H) SUB B          ; Subtract 8 from the byte counter to test if first set of digits
2C01H  (CAH) JZ 2C17H       ; Skip copying bytes to FAC1 if no bytes to copy (already normalized)
2C04H  (F5H) PUSH PSW       ; Preserve count of bytes skipped on stack
2C05H  (C5H) PUSH B         ; Preserve BC on stack
2C06H  (48H) MOV C,B        ; Move number of bytes to copy to C
2C07H  (11H) LXI D,FC19H    ; Point to BCD portion of FAC1
2C0AH  (CDH) CALL 2EDDH     ; Move C bytes from M to (DE) with increment - shift the bytes
2C0DH  (C1H) POP B          ; Restore byte counter from stack
2C0EH  (F1H) POP PSW        ; Restore A from stack
2C0FH  (47H) MOV B,A        ; Move count of bytes skipped to B to use as a count to zero out the end
2C10H  (AFH) XRA A          ; Prepare to zero out B bytes from end of FAC1 that were shifted left
2C11H  (12H) STAX D         ; Zero out next LSB from BCD
2C12H  (13H) INX D          ; Increment to next lower BCD value in FAC1
2C13H  (05H) DCR B          ; Decrement the counter
2C14H  (C2H) JNZ 2C11H      ; Loop until all bytes zeroed

; ======================================================
; BCD portion of FAC1 normalized.  Update Decimal point location and round
; ======================================================
2C17H  (79H) MOV A,C        ; Get digit count from normalize
2C18H  (B7H) ORA A          ; Test if no bytes copied from normalize (don't need to adjust decimal point)
2C19H  (CAH) JZ 2C27H       ; Jump to round if BCD value was not shifted / normalized
2C1CH  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision
2C1FH  (46H) MOV B,M        ; Get current sign / decimal point location
2C20H  (86H) ADD M          ; Add number of BCD digits shifted to calculate new decimal location
2C21H  (77H) MOV M,A        ; Save new decimal point location
2C22H  (A8H) XRA B          ; Test for overflow in shift (too small)
2C23H  (FAH) JM 0455H       ; Generate OV error if 1e-66 or less
2C26H  (C8H) RZ             ; Return if FAC1 is zero -- no need to round

; ======================================================
; Round FAC1 using extended precision portion at end of FAC1 
; ======================================================
2C27H  (21H) LXI H,FC20H    ; Point to end of FAC1+1 = "Fraction portion" for accuracy
2C2AH  (06H) MVI B,07H      ; Prepare to perform rounding operation on 7 byte of BCD
2C2CH  (7EH) MOV A,M        ; Get "fraction portion" of FAC1
2C2DH  (FEH) CPI 50H        ; Test for value 0.50 decimal (this is BCD)
2C2FH  (D8H) RC             ; Return if less than 0.50 - no rounding needed
2C30H  (2BH) DCX H          ; Decrement to next higher BCD pair
2C31H  (AFH) XRA A          ; Clear A to perform ADD of 1 to FAC1 (to perform round up)
2C32H  (37H) STC            ; Set the C flag (this is our "1")
2C33H  (8EH) ADC M          ; Add Zero with carry to the next BCD pair
2C34H  (27H) DAA            ; Decimal adjust for BCD calculations
2C35H  (77H) MOV M,A        ; Save this byte of BCD data
2C36H  (D0H) RNC            ; Return if no more carry to additional bytes
2C37H  (2BH) DCX H          ; Decrement to next higher BCD pair
2C38H  (05H) DCR B          ; Decrement byte count
2C39H  (C2H) JNZ 2C33H      ; Loop until all bytes rounded (or no carry)
2C3CH  (7EH) MOV A,M        ; We rounded to the last byte and had Carry.  Must shift decimal point.
2C3DH  (34H) INR M          ; Increment the decimal point position to account for carry
2C3EH  (AEH) XRA M          ; Test for overflow during rounding
2C3FH  (FAH) JM 0455H       ; Generate OV error
2C42H  (23H) INX H          ; Increment to 1st BCD pair to change from .99 to 1.00
2C43H  (36H) MVI M,10H      ; Change value to 1.0 since our "carry" was really a decimal point shift
2C45H  (C9H) RET

; ======================================================
; Add FAC2 to FAC1
; ======================================================
2C46H  (21H) LXI H,FC70H    ; Point to end of FAC2
2C49H  (11H) LXI D,FC1FH    ; Point to end of FAC1
2C4CH  (06H) MVI B,07H      ; Prepare to add 7 bytes of BCD (14 digits)

; ======================================================
; Add BCD value at (HL) to the one at (DE)
; ======================================================
2C4EH  (AFH) XRA A          ; Clear C flag for 1st ADD

; ======================================================
; Add next bytes of FAC2 to FAC1
; ======================================================
2C4FH  (1AH) LDAX D         ; Load first byte into A
2C50H  (8EH) ADC M          ; ADD with carry the next byte from M
2C51H  (27H) DAA            ; Decimal Adjust for BCD add
2C52H  (12H) STAX D         ; Store sum at (DE)
2C53H  (1BH) DCX D          ; Decrement to next higher position of DE
2C54H  (2BH) DCX H          ; Decrement to next higher position of HL
2C55H  (05H) DCR B          ; Decrement byte counter
2C56H  (C2H) JNZ 2C4FH      ; Keep looping until byte count = 0
2C59H  (C9H) RET

; ======================================================
; ??? Part of Normalize FAC1 routine.  Not sure what it does yet.
; ======================================================
2C5AH  (21H) LXI H,FC71H    ; Point to extended precision portion of FAC2 
2C5DH  (7EH) MOV A,M        ; Get extended precision portion to test for rounding
2C5EH  (FEH) CPI 50H        ; Compare with 50 BCD (represent 0.50)
2C60H  (C2H) JNZ 2C64H      ; Jump if extended precision portion of FAC2 != 0.50
2C63H  (34H) INR M          ; Increment extended precision portion of FAC2
2C64H  (11H) LXI D,FC20H    ; Point to extended precision portion of FAC1
2C67H  (06H) MVI B,08H      ; Prepare to subtract FAC2 from 0.999999999999 maybe?
2C69H  (37H) STC            ; Set carry to initiate no-borrow 
2C6AH  (3EH) MVI A,99H      ; Load 0.99 BCD into A
2C6CH  (CEH) ACI 00H        ; Add 00 BCD to set AC flag2
2C6EH  (96H) SUB M          ; Subtract extended precision portion of FAC2 from 0.99 BCD
2C6FH  (4FH) MOV C,A        ; Save difference in C
2C70H  (1AH) LDAX D         ; Load next byte from FAC1
2C71H  (81H) ADD C          ; Add difference of 0.99-FAC2
2C72H  (27H) DAA            ; Decimal adjust for BCD value
2C73H  (12H) STAX D         ; Store in FAC1  (FAC1 = FAC1 + (0.999999999 - FAC2))
2C74H  (1BH) DCX D          ; Decrement to next higher BCD pair for FAC1
2C75H  (2BH) DCX H          ; Decrement to next higher BCD pair for FAC2
2C76H  (05H) DCR B          ; Decrement byte count
2C77H  (C2H) JNZ 2C6AH      ; Keep looping until count = 0
2C7AH  (D8H) RC             ; Return if no borrow 
2C7BH  (EBH) XCHG
2C7CH  (7EH) MOV A,M
2C7DH  (EEH) XRI 80H
2C7FH  (77H) MOV M,A
2C80H  (21H) LXI H,FC20H    ; Point to extended precision portion of FAC1
2C83H  (06H) MVI B,08H
2C85H  (AFH) XRA A
2C86H  (3EH) MVI A,9AH
2C88H  (9EH) SBB M
2C89H  (CEH) ACI 00H
2C8BH  (27H) DAA
2C8CH  (3FH) CMC
2C8DH  (77H) MOV M,A
2C8EH  (2BH) DCX H
2C8FH  (05H) DCR B
2C90H  (C2H) JNZ 2C86H
2C93H  (C9H) RET

; ======================================================
; Rotate FAC1 1 BCD digit left to normalize starting at HL for B bytes
; ======================================================
2C94H  (21H) LXI H,FC20H    ; Point to end of FAC1 (+1 to rotate in a "0")
2C97H  (C5H) PUSH B         ; Preserve byte & digit count on stack
2C98H  (50H) MOV D,B        ; Move byte count to D
2C99H  (0EH) MVI C,04H      ; Prepare to rotate the remaining bytes 4 bits to populate MSB of 1st byte
2C9BH  (E5H) PUSH H         ; Preserve the pointer to end of FAC1 for next shift loop
2C9CH  (B7H) ORA A          ; Clear the C flag so we rotate 0 in
2C9DH  (7EH) MOV A,M        ; Get the next highest byte from FAC1
2C9EH  (17H) RAL            ; Rotate the C bit (bit 8 from previous byte) into this byte & shift
2C9FH  (77H) MOV M,A        ; Save the shifted byte back to FAC1
2CA0H  (2BH) DCX H          ; Decrement to next higher BCD value pair
2CA1H  (05H) DCR B          ; Decrement the byte count
2CA2H  (C2H) JNZ 2C9DH      ; Keep looping until B bytes shifted
2CA5H  (42H) MOV B,D        ; Restore B for next pass (we rotate through B bytes 4 times)
2CA6H  (E1H) POP H          ; Restore the pointer to the end of FAC1 for next shift loop
2CA7H  (0DH) DCR C          ; Decrement the bit shift count
2CA8H  (C2H) JNZ 2C9BH      ; Keep looping until we have shifted 4 times (1 BCD digit)
2CABH  (C1H) POP B          ; Restore byte & digit counts from stack
2CACH  (C9H) RET

2CADH  (B7H) ORA A
2CAEH  (1FH) RAR
2CAFH  (F5H) PUSH PSW
2CB0H  (B7H) ORA A
2CB1H  (CAH) JZ 2CFAH
2CB4H  (F5H) PUSH PSW
2CB5H  (2FH) CMA
2CB6H  (3CH) INR A
2CB7H  (4FH) MOV C,A
2CB8H  (06H) MVI B,FFH
2CBAH  (11H) LXI D,0007H
2CBDH  (19H) DAD D
2CBEH  (54H) MOV D,H
2CBFH  (5DH) MOV E,L
2CC0H  (09H) DAD B
2CC1H  (3EH) MVI A,08H
2CC3H  (81H) ADD C
2CC4H  (4FH) MOV C,A
2CC5H  (C5H) PUSH B
2CC6H  (CDH) CALL 2EE6H     ; Move C bytes from M to (DE) with decrement
2CC9H  (C1H) POP B
2CCAH  (F1H) POP PSW
2CCBH  (23H) INX H
2CCCH  (13H) INX D
2CCDH  (D5H) PUSH D
2CCEH  (47H) MOV B,A
2CCFH  (AFH) XRA A
2CD0H  (77H) MOV M,A
2CD1H  (23H) INX H
2CD2H  (05H) DCR B
2CD3H  (C2H) JNZ 2CD0H
2CD6H  (E1H) POP H
2CD7H  (F1H) POP PSW
2CD8H  (D0H) RNC
2CD9H  (79H) MOV A,C
2CDAH  (C5H) PUSH B
2CDBH  (D5H) PUSH D
2CDCH  (57H) MOV D,A
2CDDH  (0EH) MVI C,04H
2CDFH  (42H) MOV B,D
2CE0H  (E5H) PUSH H
2CE1H  (B7H) ORA A
2CE2H  (7EH) MOV A,M
2CE3H  (1FH) RAR
2CE4H  (77H) MOV M,A
2CE5H  (23H) INX H
2CE6H  (05H) DCR B
2CE7H  (C2H) JNZ 2CE2H
2CEAH  (E1H) POP H
2CEBH  (0DH) DCR C
2CECH  (C2H) JNZ 2CDFH
2CEFH  (D1H) POP D
2CF0H  (C1H) POP B
2CF1H  (C9H) RET

2CF2H  (21H) LXI H,FC19H    ; Point to BCD portion of FAC1
2CF5H  (3EH) MVI A,08H
2CF7H  (C3H) JMP 2CDAH

2CFAH  (F1H) POP PSW
2CFBH  (D0H) RNC
2CFCH  (C3H) JMP 2CF5H

; ======================================================
; Double precision multiply (FAC1=FAC1*FAC2)
; ======================================================
2CFFH  (F7H) RST 6          ; Get sign of FAC1
2D00H  (C8H) RZ             ; Return if FAC1 is zero - product is zero also
2D01H  (3AH) LDA FC69H      ; Get sign and exponent for FAC2
2D04H  (B7H) ORA A          ; Test if FAC2 is zero
2D05H  (CAH) JZ 33EDH       ; Set FAC1 to zero - Initialize FAC1 for SGL & DBL precision to zero
2D08H  (47H) MOV B,A        ; Save Sign and Decimal point for FAC2
2D09H  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision
2D0CH  (AEH) XRA M          ; Test if Sign of FAC1 and FAC2 are different
2D0DH  (E6H) ANI 80H        ; Keep only the sign bit
2D0FH  (4FH) MOV C,A        ; Save the resulting sign of the product in C
2D10H  (78H) MOV A,B        ; Restore the sign and decimal point of FAC2
2D11H  (E6H) ANI 7FH        ; Mask the sign bit out
2D13H  (47H) MOV B,A        ; Save the decimal point info in B
2D14H  (7EH) MOV A,M        ; Get the sign and decimal point for FAC1
2D15H  (E6H) ANI 7FH        ; Mask off the sign bit
2D17H  (80H) ADD B          ; Add the decimal point for FAC1 and FAC2 for multiply
2D18H  (47H) MOV B,A        ; Save the sum in B
2D19H  (36H) MVI M,00H      ; Initialize FAC1 decimal point to zero
2D1BH  (E6H) ANI C0H        ; Mask off lower 6 bits of the sum of decimal points
2D1DH  (C8H) RZ             ; Return if it's zero.  Not sure why - we didn't actually multiply anything yet
2D1EH  (FEH) CPI C0H        ; Test if upper 2 bits of sum of decimal points are both 1
2D20H  (C2H) JNZ 2D26H      ; Jump if not C0H
2D23H  (C3H) JMP 0455H      ; Generate OV error

; ======================================================
; Multiply BCD portion of FAC1*FAC2
; ======================================================
2D26H  (78H) MOV A,B        ; Reload the sum of the decimal points
2D27H  (C6H) ADI 40H        ; Add 40H to it (the "zero" point)
2D29H  (E6H) ANI 7FH        ; Mask off the upper bit (where sign bit goes)
2D2BH  (C8H) RZ             ; Return if the product generates zero
2D2CH  (B1H) ORA C          ; OR in the sign of the product
2D2DH  (2BH) DCX H          ; Decrement HL to save decimal point & sign temporarily
2D2EH  (77H) MOV M,A        ; Save decimal & sign
2D2FH  (11H) LXI D,FC67H    ; Temp BCD value for computation (BCD_TEMP8)
2D32H  (01H) LXI B,0008H    ; Prepare to copy 8 bytes of BCD
2D35H  (21H) LXI H,FC1FH    ; Point to end of FAC1
2D38H  (D5H) PUSH D         ; Preserve address of temp float to stack
2D39H  (CDH) CALL 2EE6H     ; Move C bytes from M to (DE) with decrement - Copy FAC1 to BCD_TEMP8
2D3CH  (23H) INX H          ; Increment to beginning of FAC1
2D3DH  (AFH) XRA A          ; Clear A
2D3EH  (06H) MVI B,08H      ; Prepare to clear 8 bytes of FAC1
2D40H  (77H) MOV M,A        ; Zero out next byte of FAC1
2D41H  (23H) INX H          ; Increment to next byte of FAC1
2D42H  (05H) DCR B          ; Decrement loop counter
2D43H  (C2H) JNZ 2D40H      ; Keep looping until count = 0
2D46H  (D1H) POP D          ; Restore address of BCD_TEMP8
2D47H  (01H) LXI B,2DA8H    ; Load address of routine to retrieve saved Decimal/sign byte and normalize FAC1
2D4AH  (C5H) PUSH B         ; PUSH new RETurn address to stack

; ======================================================
; Multiply BCD at (HL) times BCD at (DE)
; ======================================================
2D4BH  (CDH) CALL 2DAFH     ; Multiply BCD at (DE) x2, x4 and x8 into BCD_TEMP7, BCD_TEMP6, BCD_TEMP5
2D4EH  (E5H) PUSH H         ; Push address of BCD_TEMP4 to stack
2D4FH  (01H) LXI B,0008H    ; Prepare to copy 8 BCD bytes
2D52H  (EBH) XCHG           ; HL=BCD_TEMP5 (x8), DE=BCD_TEMP4
2D53H  (CDH) CALL 2EE6H     ; Move C bytes from M to (DE) with decrement - copy x8 value to BCD_TEMP4
2D56H  (EBH) XCHG           ; HL=BCD_TEMP3, DE=BCD_TEMP4 (x8)
2D57H  (21H) LXI H,FC5FH    ; Point to BCD_TEMP7 (x2)
2D5AH  (06H) MVI B,08H      ; Prepare to add 8 bytes of BCD (Add BCD_TEMP3 to BCD_TEMP7)
2D5CH  (CDH) CALL 2C4EH     ; Add BCD value at (HL) to the one at (DE) -- BCD_TEMP4 = x8 + x2 = x10
2D5FH  (D1H) POP D          ; POP address of BCD_TEMP4 from stack
2D60H  (CDH) CALL 2DAFH     ; Multiply BCD_TEMP4 (x10) times 2, 4 and 8 into BCD_TEMP3, BCD_TEMP2, BCD_TEMP1
2D63H  (0EH) MVI C,07H      ; Prepare to multiply 7 bytes of BCD from FAC2?
2D65H  (11H) LXI D,FC70H    ; Point to end of FAC2
2D68H  (1AH) LDAX D         ; Load next BCD pair from FAC2
2D69H  (B7H) ORA A          ; Test if byte pair is "00"
2D6AH  (C2H) JNZ 2D72H      ; Jump to start multiply when first non "00" BCD found
2D6DH  (1BH) DCX D          ; Decrement to next higher BCD pair
2D6EH  (0DH) DCR C          ; Decrement byte counter (no need to test for zero - we won't be here if FAC2=0.0000)
2D6FH  (C3H) JMP 2D68H      ; Jump to test next byte of FAC2

; ======================================================
; First non "00" BCD in FAC1 found. Perform multiply?
; ======================================================
2D72H  (1AH) LDAX D         ; Load next byte of BCD from FAC2
2D73H  (1BH) DCX D          ; Decrement to next higher BCD pair in FAC2
2D74H  (D5H) PUSH D         ; Save address of BCD pair being processed in FAC2 to stack 
2D75H  (21H) LXI H,FC2FH    ; Point to BCD_TEMP1 (this is FAC1 x 80)
2D78H  (87H) ADD A          ; Multiply BCD from FAC2 x 2
2D79H  (DAH) JC 2D86H       ; Add BCD value at (HL) to FAC1
2D7CH  (CAH) JZ 2D95H       ; If zero (overflow to 100H), then jump to divide by 100
2D7FH  (11H) LXI D,0008H    ; Prepare to point to next BCD_TEMPx value
2D82H  (19H) DAD D          ; Advance HL to next BCD_TEMPx value
2D83H  (C3H) JMP 2D78H      ; Jump to test if this BCD_TEMPx value should be added to FAC1 

; ======================================================
; Add BCD value at (HL) to FAC1
; ======================================================
2D86H  (F5H) PUSH PSW       ; Save A on stack
2D87H  (06H) MVI B,08H      ; Load BCD byte count
2D89H  (11H) LXI D,FC1FH    ; Point to end of FAC1
2D8CH  (E5H) PUSH H         ; Preserve HL on stack
2D8DH  (CDH) CALL 2C4EH     ; Add BCD value at (HL) to the one at FAC1
2D90H  (E1H) POP H          ; Restore HL
2D91H  (F1H) POP PSW        ; Restore A
2D92H  (C3H) JMP 2D7FH      ; Jump to test if next BCD_TEMPx value should be added to FAC1

; ======================================================
; Divide extended precision FAC1 by 100 and test for end of multiply
; ======================================================
2D95H  (06H) MVI B,0FH      ; Prepare to shift 15 bytes (extended precision) of FAC1
2D97H  (11H) LXI D,FC26H    ; Start 1 byte from end of FAC1 (extended precision)
2D9AH  (21H) LXI H,FC27H    ; Move to last byte of FAC1 (this is /100 because of BCD)
2D9DH  (CDH) CALL 3472H     ; Move B bytes from (DE) to M with decrement
2DA0H  (36H) MVI M,00H      ; Set the 1st byte (sign / decimal point) to zero
2DA2H  (D1H) POP D          ; Restore pointer to current BCD pair in FAC2
2DA3H  (0DH) DCR C          ; Decrement BCD count for FAC2
2DA4H  (C2H) JNZ 2D72H      ; Jump to process next byte
2DA7H  (C9H) RET            ; Return to our hook (below) to retrieve the Decimal/sign & normalize

; ======================================================
; Retrieve saved Decimal/sign byte and normalize FAC1
; ======================================================
2DA8H  (2BH) DCX H          ; Decrement from start of FAC1 to save byte for sign/decimal point
2DA9H  (7EH) MOV A,M        ; Get saved sign/decimal point
2DAAH  (23H) INX H          ; Increment back to start of FAC1
2DABH  (77H) MOV M,A        ; Copy saved sign/decimal point to FAC1
2DACH  (C3H) JMP 2BDEH      ; Normalize FAC1 such that the 1st BCD digit isn't zero

; ======================================================
; Multiply BCD at (DE) x2, x4 and x8 into 3 BCD values before (DE)
; ======================================================
2DAFH  (21H) LXI H,FFF8H    ; Load -8 into HL
2DB2H  (19H) DAD D          ; HL=DE-8 -- Point to next lower temp BCD value
2DB3H  (0EH) MVI C,03H      ; Prepare to process 3 floating point values
2DB5H  (06H) MVI B,08H      ; Load byte counter for 1 floating point value
2DB7H  (B7H) ORA A          ; Clear C flag
2DB8H  (1AH) LDAX D         ; Load next byte of floating point value
2DB9H  (8FH) ADC A          ; Add with carry (x2)
2DBAH  (27H) DAA            ; Decimal adjust for BCD math
2DBBH  (77H) MOV M,A        ; Save byte x 2 to next lower temp floating point value
2DBCH  (2BH) DCX H          ; Decrement pointer to temp floating point 1
2DBDH  (1BH) DCX D          ; Decrement pointer to temp floating point 2
2DBEH  (05H) DCR B          ; Decrement byte counter
2DBFH  (C2H) JNZ 2DB8H      ; Keep looping until byte counter = 0
2DC2H  (0DH) DCR C          ; Decrement x2 loop counter
2DC3H  (C2H) JNZ 2DB5H      ; Keep looping until count=0 (x2, x4, x8)
2DC6H  (C9H) RET

; ======================================================
; Double precision divide (FAC1=FAC1/FAC2)
; ======================================================
2DC7H  (3AH) LDA FC69H      ; Start of FAC2 for single and double precision
2DCAH  (B7H) ORA A
2DCBH  (CAH) JZ 0449H       ; Generate /0 error
2DCEH  (47H) MOV B,A
2DCFH  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision
2DD2H  (7EH) MOV A,M
2DD3H  (B7H) ORA A
2DD4H  (CAH) JZ 33EDH       ; Initialize FAC1 for SGL & DBL precision to zero
2DD7H  (A8H) XRA B
2DD8H  (E6H) ANI 80H
2DDAH  (4FH) MOV C,A
2DDBH  (78H) MOV A,B
2DDCH  (E6H) ANI 7FH
2DDEH  (47H) MOV B,A
2DDFH  (7EH) MOV A,M
2DE0H  (E6H) ANI 7FH
2DE2H  (90H) SUB B
2DE3H  (47H) MOV B,A
2DE4H  (1FH) RAR
2DE5H  (A8H) XRA B
2DE6H  (E6H) ANI 40H
2DE8H  (36H) MVI M,00H
2DEAH  (CAH) JZ 2DF4H
2DEDH  (78H) MOV A,B
2DEEH  (E6H) ANI 80H
2DF0H  (C0H) RNZ
2DF1H  (C3H) JMP 0455H      ; Generate OV error

2DF4H  (78H) MOV A,B
2DF5H  (C6H) ADI 41H
2DF7H  (E6H) ANI 7FH
2DF9H  (77H) MOV M,A
2DFAH  (CAH) JZ 2DF1H
2DFDH  (B1H) ORA C
2DFEH  (36H) MVI M,00H
2E00H  (2BH) DCX H
2E01H  (77H) MOV M,A
2E02H  (11H) LXI D,FC1FH    ; Point to end of FAC1
2E05H  (21H) LXI H,FC70H    ; Point to end of FAC2
2E08H  (06H) MVI B,07H
2E0AH  (7EH) MOV A,M
2E0BH  (B7H) ORA A
2E0CH  (C2H) JNZ 2E15H
2E0FH  (1BH) DCX D
2E10H  (2BH) DCX H
2E11H  (05H) DCR B
2E12H  (C2H) JNZ 2E0AH
2E15H  (22H) SHLD FC14H
2E18H  (EBH) XCHG
2E19H  (22H) SHLD FC12H
2E1CH  (78H) MOV A,B
2E1DH  (32H) STA FC16H
2E20H  (21H) LXI H,FC60H    ; Floating Point Temp 2
2E23H  (06H) MVI B,0FH
2E25H  (E5H) PUSH H
2E26H  (C5H) PUSH B
2E27H  (2AH) LHLD FC14H
2E2AH  (EBH) XCHG
2E2BH  (2AH) LHLD FC12H
2E2EH  (3AH) LDA FC16H
2E31H  (0EH) MVI C,FFH
2E33H  (37H) STC
2E34H  (0CH) INR C
2E35H  (47H) MOV B,A
2E36H  (E5H) PUSH H
2E37H  (D5H) PUSH D
2E38H  (3EH) MVI A,99H
2E3AH  (CEH) ACI 00H
2E3CH  (EBH) XCHG
2E3DH  (96H) SUB M
2E3EH  (EBH) XCHG
2E3FH  (86H) ADD M
2E40H  (27H) DAA
2E41H  (77H) MOV M,A
2E42H  (2BH) DCX H
2E43H  (1BH) DCX D
2E44H  (05H) DCR B
2E45H  (C2H) JNZ 2E38H
2E48H  (7EH) MOV A,M
2E49H  (3FH) CMC
2E4AH  (DEH) SBI 00H
2E4CH  (77H) MOV M,A
2E4DH  (D1H) POP D
2E4EH  (E1H) POP H
2E4FH  (3AH) LDA FC16H
2E52H  (D2H) JNC 2E33H
2E55H  (47H) MOV B,A
2E56H  (EBH) XCHG
2E57H  (CDH) CALL 2C4EH     ; Add BCD value at (HL) to the one at FAC1
2E5AH  (D2H) JNC 2E5FH
2E5DH  (EBH) XCHG
2E5EH  (34H) INR M
2E5FH  (79H) MOV A,C
2E60H  (C1H) POP B
2E61H  (4FH) MOV C,A
2E62H  (C5H) PUSH B
2E63H  (78H) MOV A,B
2E64H  (B7H) ORA A
2E65H  (1FH) RAR
2E66H  (47H) MOV B,A
2E67H  (04H) INR B
2E68H  (58H) MOV E,B
2E69H  (16H) MVI D,00H
2E6BH  (21H) LXI H,FC17H
2E6EH  (19H) DAD D
2E6FH  (CDH) CALL 2C97H
2E72H  (C1H) POP B
2E73H  (E1H) POP H
2E74H  (78H) MOV A,B
2E75H  (0CH) INR C
2E76H  (0DH) DCR C
2E77H  (C2H) JNZ 2EBBH
2E7AH  (FEH) CPI 0FH
2E7CH  (CAH) JZ 2EACH
2E7FH  (0FH) RRC
2E80H  (07H) RLC
2E81H  (D2H) JNC 2EBBH
2E84H  (C5H) PUSH B
2E85H  (E5H) PUSH H
2E86H  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision
2E89H  (06H) MVI B,08H
2E8BH  (7EH) MOV A,M
2E8CH  (B7H) ORA A
2E8DH  (C2H) JNZ 2EA6H
2E90H  (23H) INX H
2E91H  (05H) DCR B
2E92H  (C2H) JNZ 2E8BH
2E95H  (E1H) POP H
2E96H  (C1H) POP B
2E97H  (78H) MOV A,B
2E98H  (B7H) ORA A
2E99H  (1FH) RAR
2E9AH  (3CH) INR A
2E9BH  (47H) MOV B,A
2E9CH  (AFH) XRA A
2E9DH  (77H) MOV M,A
2E9EH  (23H) INX H
2E9FH  (05H) DCR B
2EA0H  (C2H) JNZ 2E9DH
2EA3H  (C3H) JMP 2ECFH

2EA6H  (E1H) POP H
2EA7H  (C1H) POP B
2EA8H  (78H) MOV A,B
2EA9H  (C3H) JMP 2EBBH

2EACH  (3AH) LDA FC17H
2EAFH  (5FH) MOV E,A
2EB0H  (3DH) DCR A
2EB1H  (32H) STA FC17H
2EB4H  (ABH) XRA E
2EB5H  (F2H) JP 2E23H
2EB8H  (C3H) JMP 33EDH      ; Initialize FAC1 for SGL & DBL precision to zero

2EBBH  (1FH) RAR
2EBCH  (79H) MOV A,C
2EBDH  (DAH) JC 2EC6H
2EC0H  (B6H) ORA M
2EC1H  (77H) MOV M,A
2EC2H  (23H) INX H
2EC3H  (C3H) JMP 2ECBH

2EC6H  (87H) ADD A
2EC7H  (87H) ADD A
2EC8H  (87H) ADD A
2EC9H  (87H) ADD A
2ECAH  (77H) MOV M,A
2ECBH  (05H) DCR B
2ECCH  (C2H) JNZ 2E25H
2ECFH  (21H) LXI H,FC20H    ; Point to extended precision portion of FAC1
2ED2H  (11H) LXI D,FC67H    ; Temp BCD value for computation?
2ED5H  (06H) MVI B,08H      ; Prepare to copy BCD value
2ED7H  (CDH) CALL 3472H     ; Move B bytes from (DE) to M with decrement
2EDAH  (C3H) JMP 2DA8H

; ======================================================
; Move C bytes from M to (DE) with increment
; ======================================================
2EDDH  (7EH) MOV A,M        ; Get next byte from M
2EDEH  (12H) STAX D         ; Save at (DE)
2EDFH  (23H) INX H          ; Increment source pointer
2EE0H  (13H) INX D          ; Increment destination pointer
2EE1H  (0DH) DCR C          ; Decrement loop counter
2EE2H  (C2H) JNZ 2EDDH      ; Keep looping until C = 0
2EE5H  (C9H) RET

; ======================================================
; Move C bytes from M to (DE) with decrement
; ======================================================
2EE6H  (7EH) MOV A,M        ; Get next byte from M
2EE7H  (12H) STAX D         ; Store at (DE)
2EE8H  (2BH) DCX H          ; Decrement source pointer
2EE9H  (1BH) DCX D          ; Decrement dest pointer
2EEAH  (0DH) DCR C          ; Decrement loop counter
2EEBH  (C2H) JNZ 2EE6H      ; Move C bytes from M to (DE)
2EEEH  (C9H) RET

; ======================================================
; COS function
; ======================================================
2EEFH  (21H) LXI H,32CEH    ; Load pointer to FP 0.15915494309190
2EF2H  (CDH) CALL 31A3H     ; Double precision math (FAC1=M * FAC2))
2EF5H  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
2EF8H  (E6H) ANI 7FH        ; ABS(FAC1)
2EFAH  (32H) STA FC18H      ; Start of FAC1 for single and double precision
2EFDH  (21H) LXI H,328EH    ; Load pointer to FP 0.2500000000000
2F00H  (CDH) CALL 319AH     ; Double precision subtract FP at (HL) from FAC1
2F03H  (CDH) CALL 33FDH     ; Perform ABS function on FAC1
2F06H  (C3H) JMP 2F0FH

; ======================================================
; SIN function
; ======================================================
2F09H  (21H) LXI H,32CEH    ; Load pointer to FP 0.15915494309190
2F0CH  (CDH) CALL 31A3H     ; Double precision math (FAC1=M * FAC2))
2F0FH  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
2F12H  (B7H) ORA A          ; Test if FAC1 negative
2F13H  (FCH) CM 31E3H       ; If negative, Take ABS(FAC1) and push return address to ABS(FAC1)
2F16H  (CDH) CALL 3234H     ; Push FAC1 on stack
2F19H  (CDH) CALL 3654H     ; INT function
2F1CH  (CDH) CALL 31B5H     ; Move FAC1 to FAC2
2F1FH  (CDH) CALL 324BH     ; Pop FAC1 from stack
2F22H  (CDH) CALL 2B69H     ; Double precision subtract (FAC1=FAC1-FAC2)
2F25H  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
2F28H  (FEH) CPI 40H
2F2AH  (DAH) JC 2F52H
2F2DH  (3AH) LDA FC19H      ; Get 1st byte of BCD portion of FAC1
2F30H  (FEH) CPI 25H        ; Test for 0.25
2F32H  (DAH) JC 2F52H
2F35H  (FEH) CPI 75H        ; Test for 0.75
2F37H  (D2H) JNC 2F49H      ; Subtract 1.00 from FAC1 and do table based math
2F3AH  (CDH) CALL 31B5H     ; Move FAC1 to FAC2
2F3DH  (21H) LXI H,327CH    ; Load pointer to FP 0.500000000
2F40H  (CDH) CALL 31C4H     ; Move floating point number M to FAC1
2F43H  (CDH) CALL 2B69H     ; Double precision subtract (FAC1=FAC1-FAC2)
2F46H  (C3H) JMP 2F52H      ; Jump to perform table based math for SIN function

; ======================================================
; Part of SIN function.  Subtract 1.0 from FAC1 & do table based math
; ======================================================
2F49H  (21H) LXI H,3286H    ; Load pointer to FP 1.000000000
2F4CH  (CDH) CALL 31B8H     ; Move floating point number M to FAC2
2F4FH  (CDH) CALL 2B69H     ; Double precision subtract (FAC1=FAC1-FAC2)
2F52H  (21H) LXI H,335AH    ; Table of FP numbers for SIN function
2F55H  (C3H) JMP 31F7H      ; FAC1 = FAC1 * (FAC1^2 * table based math)

; ======================================================
; TAN function
; ======================================================
2F58H  (CDH) CALL 3234H     ; Push FAC1 on stack
2F5BH  (CDH) CALL 2EEFH     ; COS function
2F5EH  (CDH) CALL 31D2H     ; Swap FAC1 with Floating Point number on stack
2F61H  (CDH) CALL 2F09H     ; SIN function
2F64H  (CDH) CALL 3245H     ; Pop FAC2 from stack
2F67H  (3AH) LDA FC69H      ; Start of FAC2 for single and double precision
2F6AH  (B7H) ORA A          ; Test if FAC2 is zero
2F6BH  (C2H) JNZ 2DC7H      ; Double precision divide (FAC1=FAC1/FAC2)
2F6EH  (C3H) JMP 0455H      ; Generate OV error

; ======================================================
; ATN function
; ======================================================
2F71H  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
2F74H  (B7H) ORA A          ; Test if FAC1 is zero
2F75H  (C8H) RZ             ; Return if FAC1 is zero - answer also zero
2F76H  (FCH) CM 31E3H       ; If negative, take ABS(FAC1) and push return address to ABS(FAC1)
2F79H  (FEH) CPI 41H        ; Test if FAC1 > 1.0
2F7BH  (DAH) JC 2F99H       ; Perform series approximation for ATN
2F7EH  (CDH) CALL 31B5H     ; Move FAC1 to FAC2
2F81H  (21H) LXI H,3286H    ; Load pointer to FP 1.000000000
2F84H  (CDH) CALL 31C4H     ; Move floating point number M to FAC1
2F87H  (CDH) CALL 2DC7H     ; Double precision divide (FAC1=FAC1/FAC2)
2F8AH  (CDH) CALL 2F99H     ; Perform series approximation for ATN
2F8DH  (CDH) CALL 31B5H     ; Move FAC1 to FAC2
2F90H  (21H) LXI H,32AEH    ; Load pointer to FP 1.5707963267949
2F93H  (CDH) CALL 31C4H     ; Move floating point number M to FAC1
2F96H  (C3H) JMP 2B69H      ; Double precision subtract (FAC1=FAC1-FAC2)

; ======================================================
; Perform series approximation for ATN
; ======================================================
2F99H  (21H) LXI H,32B6H    ; Load pointer to FP 0.26794919243112
2F9CH  (CDH) CALL 31AFH     ; Double precision compare FAC1 with floating point at HL
2F9FH  (FAH) JM 2FC9H       ; Do table based math for ATN
2FA2H  (CDH) CALL 3234H     ; Push FAC1 on stack
2FA5H  (21H) LXI H,32BEH    ; Load pointer to FP 1.7320508075689
2FA8H  (CDH) CALL 3194H     ; Double precision add FP at (HL) to FAC1
2FABH  (CDH) CALL 31D2H     ; Swap FAC1 with Floating Point number on stack
2FAEH  (21H) LXI H,32BEH    ; Load pointer to FP 1.7320508075689
2FB1H  (CDH) CALL 31A3H     ; Double precision math (FAC1=M * FAC2))
2FB4H  (21H) LXI H,3286H    ; Load pointer to FP 1.000000000
2FB7H  (CDH) CALL 319AH     ; Double precision subtract FP at (HL) from FAC1
2FBAH  (CDH) CALL 3245H     ; Pop FAC2 from stack
2FBDH  (CDH) CALL 2DC7H     ; Double precision divide (FAC1=FAC1/FAC2)
2FC0H  (CDH) CALL 2FC9H     ; Do Table based math for ATN
2FC3H  (21H) LXI H,32C6H    ; Load pointer to FP 0.52359877559830
2FC6H  (C3H) JMP 3194H      ; Double precision add FP at (HL) to FAC1

; ======================================================
; Do table based math for ATN
; ======================================================
2FC9H  (21H) LXI H,339BH    ; Load pointer to FP table for ATN
2FCCH  (C3H) JMP 31F7H      ; FAC1 = FAC1 * (FAC1^2 * table based math)

; ======================================================
; LOG function
; ======================================================
2FCFH  (F7H) RST 6          ; Get sign of FAC1
2FD0H  (FAH) JM 08DBH       ; Generate FC error
2FD3H  (CAH) JZ 08DBH       ; Generate FC error
2FD6H  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision
2FD9H  (7EH) MOV A,M
2FDAH  (F5H) PUSH PSW
2FDBH  (36H) MVI M,41H
2FDDH  (21H) LXI H,3296H    ; Load pointer to FP 3.1622776601684
2FE0H  (CDH) CALL 31AFH     ; Double precision compare FAC1 with floating point at HL
2FE3H  (FAH) JM 2FEDH
2FE6H  (F1H) POP PSW
2FE7H  (3CH) INR A
2FE8H  (F5H) PUSH PSW
2FE9H  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision
2FECH  (35H) DCR M
2FEDH  (F1H) POP PSW
2FEEH  (32H) STA FB8EH
2FF1H  (CDH) CALL 3234H     ; Push FAC1 on stack
2FF4H  (21H) LXI H,3286H    ; Load pointer to FP 1.000000000
2FF7H  (CDH) CALL 3194H     ; Double precision add FP at (HL) to FAC1
2FFAH  (CDH) CALL 31D2H     ; Swap FAC1 with Floating Point number on stack
2FFDH  (21H) LXI H,3286H    ; Load pointer to FP 1.000000000
3000H  (CDH) CALL 319AH     ; Double precision subtract FP at (HL) from FAC1
3003H  (CDH) CALL 3245H     ; Pop FAC2 from stack
3006H  (CDH) CALL 2DC7H     ; Double precision divide (FAC1=FAC1/FAC2)
3009H  (CDH) CALL 3234H     ; Push FAC1 on stack
300CH  (CDH) CALL 31A0H     ; Double precision Square (FAC1=SQR(FAC1))
300FH  (CDH) CALL 3234H     ; Push FAC1 on stack
3012H  (CDH) CALL 3234H     ; Push FAC1 on stack
3015H  (21H) LXI H,3331H    ; Point to 1st table of FP numbers for LOG
3018H  (CDH) CALL 3209H     ; Table based math (FAC1=(((FAC1*M)+(M+1))*(M+2)+(M+3)...
301BH  (CDH) CALL 31D2H     ; Swap FAC1 with Floating Point number on stack
301EH  (21H) LXI H,3310H    ; Point to 2nd table of FP numbers for LOG
3021H  (CDH) CALL 3209H     ; Table based math (FAC1=(((FAC1*M)+(M+1))*(M+2)+(M+3)...
3024H  (CDH) CALL 3245H     ; Pop FAC2 from stack
3027H  (CDH) CALL 2DC7H     ; Double precision divide (FAC1=FAC1/FAC2)
302AH  (CDH) CALL 3245H     ; Pop FAC2 from stack
302DH  (CDH) CALL 2CFFH     ; Double precision multiply (FAC1=FAC1*FAC2)
3030H  (21H) LXI H,329EH    ; Load pointer to FP 0.86858896380650
3033H  (CDH) CALL 3194H     ; Double precision add FP at (HL) to FAC1
3036H  (CDH) CALL 3245H     ; Pop FAC2 from stack
3039H  (CDH) CALL 2CFFH     ; Double precision multiply (FAC1=FAC1*FAC2)
303CH  (CDH) CALL 3234H     ; Push FAC1 on stack
303FH  (3AH) LDA FB8EH
3042H  (D6H) SUI 41H
3044H  (6FH) MOV L,A
3045H  (87H) ADD A
3046H  (9FH) SBB A
3047H  (67H) MOV H,A
3048H  (CDH) CALL 3543H     ; Convert signed integer HL to single precision FAC1
304BH  (CDH) CALL 35C2H     ; Convert FAC11 to double precision
304EH  (CDH) CALL 3245H     ; Pop FAC2 from stack
3051H  (CDH) CALL 2B78H     ; Double precision addition (FAC1=FAC1+FAC2)
3054H  (21H) LXI H,32A6H    ; Load pointer to FP 2.3025850929940
3057H  (C3H) JMP 31A3H      ; Double precision math (FAC1=M * FAC2))

; ======================================================
; SQR function
; ======================================================
305AH  (F7H) RST 6          ; Get sign of FAC1
305BH  (C8H) RZ
305CH  (FAH) JM 08DBH       ; Generate FC error
305FH  (CDH) CALL 31B5H     ; Move FAC1 to FAC2
3062H  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
3065H  (B7H) ORA A
3066H  (1FH) RAR
3067H  (CEH) ACI 20H
3069H  (32H) STA FC69H      ; Start of FAC2 for single and double precision
306CH  (3AH) LDA FC19H      ; Get 1st byte of BCD portion of FAC1
306FH  (B7H) ORA A
3070H  (0FH) RRC
3071H  (B7H) ORA A
3072H  (0FH) RRC
3073H  (E6H) ANI 33H
3075H  (C6H) ADI 10H
3077H  (32H) STA FC6AH
307AH  (3EH) MVI A,07H
307CH  (32H) STA FB8EH
307FH  (CDH) CALL 3234H     ; Push FAC1 on stack
3082H  (CDH) CALL 322EH     ; Push FAC2 on stack
3085H  (CDH) CALL 2DC7H     ; Double precision divide (FAC1=FAC1/FAC2)
3088H  (CDH) CALL 3245H     ; Pop FAC2 from stack
308BH  (CDH) CALL 2B78H     ; Double precision addition (FAC1=FAC1+FAC2)
308EH  (21H) LXI H,327CH    ; Load pointer to FP 0.500000000
3091H  (CDH) CALL 31A3H     ; Double precision math (FAC1=M * FAC2))
3094H  (CDH) CALL 31B5H     ; Move FAC1 to FAC2
3097H  (CDH) CALL 324BH     ; Pop FAC1 from stack
309AH  (3AH) LDA FB8EH
309DH  (3DH) DCR A
309EH  (C2H) JNZ 307CH
30A1H  (C3H) JMP 31C1H      ; Move FAC2 to FAC1

; ======================================================
; EXP function
; ======================================================
30A4H  (21H) LXI H,3274H
30A7H  (CDH) CALL 31A3H     ; Double precision math (FAC1=M * FAC2))
30AAH  (CDH) CALL 3234H     ; Push FAC1 on stack
30ADH  (CDH) CALL 3501H     ; CINT function
30B0H  (7DH) MOV A,L
30B1H  (17H) RAL
30B2H  (9FH) SBB A
30B3H  (BCH) CMP H
30B4H  (CAH) JZ 30CBH
30B7H  (7CH) MOV A,H
30B8H  (B7H) ORA A
30B9H  (F2H) JP 30C8H
30BCH  (CDH) CALL 35CFH     ; Set type of last variable to DBL
30BFH  (CDH) CALL 324BH     ; Pop FAC1 from stack
30C2H  (21H) LXI H,327EH
30C5H  (C3H) JMP 31C4H      ; Move floating point number M to FAC1

30C8H  (C3H) JMP 0455H      ; Generate OV error

30CBH  (22H) SHLD FB8EH
30CEH  (CDH) CALL 35BAH     ; CDBL function
30D1H  (CDH) CALL 31B5H     ; Move FAC1 to FAC2
30D4H  (CDH) CALL 324BH     ; Pop FAC1 from stack
30D7H  (CDH) CALL 2B69H     ; Double precision subtract (FAC1=FAC1-FAC2)
30DAH  (21H) LXI H,327CH    ; Load pointer to FP 0.500000000
30DDH  (CDH) CALL 31AFH     ; Double precision compare FAC1 with floating point at HL
30E0H  (F5H) PUSH PSW
30E1H  (CAH) JZ 30EDH
30E4H  (DAH) JC 30EDH
30E7H  (21H) LXI H,327CH    ; Load pointer to FP 0.500000000
30EAH  (CDH) CALL 319AH     ; Double precision subtract FP at (HL) from FAC1
30EDH  (CDH) CALL 3234H     ; Push FAC1 on stack
30F0H  (21H) LXI H,32F7H    ; Load pointer to FP table for EXP function
30F3H  (CDH) CALL 31F7H     ; FAC1 = FAC1 * (FAC1^2 * table based math)
30F6H  (CDH) CALL 31D2H     ; Swap FAC1 with Floating Point number on stack
30F9H  (21H) LXI H,32D6H
30FCH  (CDH) CALL 31EBH     ; Square FAC1 & do table based math
30FFH  (CDH) CALL 3245H     ; Pop FAC2 from stack
3102H  (CDH) CALL 322EH     ; Push FAC2 on stack
3105H  (CDH) CALL 3234H     ; Push FAC1 on stack
3108H  (CDH) CALL 2B69H     ; Double precision subtract (FAC1=FAC1-FAC2)
310BH  (21H) LXI H,FC60H    ; Floating Point Temp 2
310EH  (CDH) CALL 31CAH     ; Move FAC1 to M
3111H  (CDH) CALL 3245H     ; Pop FAC2 from stack
3114H  (CDH) CALL 324BH     ; Pop FAC1 from stack
3117H  (CDH) CALL 2B78H     ; Double precision addition (FAC1=FAC1+FAC2)
311AH  (21H) LXI H,FC60H    ; Floating Point Temp 2
311DH  (CDH) CALL 31B8H     ; Move floating point number M to FAC2
3120H  (CDH) CALL 2DC7H     ; Double precision divide (FAC1=FAC1/FAC2)
3123H  (F1H) POP PSW
3124H  (DAH) JC 3130H
3127H  (CAH) JZ 3130H
312AH  (21H) LXI H,3296H    ; Load pointer to FP 3.1622776601684
312DH  (CDH) CALL 31A3H     ; Double precision math (FAC1=M * FAC2))
3130H  (3AH) LDA FB8EH
3133H  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision
3136H  (4EH) MOV C,M
3137H  (86H) ADD M
3138H  (77H) MOV M,A
3139H  (A9H) XRA C
313AH  (F0H) RP
313BH  (C3H) JMP 0455H      ; Generate OV error

; ======================================================
; RND function
; ======================================================
313EH  (F7H) RST 6          ; Get sign of FAC1
313FH  (21H) LXI H,FC79H    ; Pointer to FP_RND
3142H  (CAH) JZ 3173H       ; If argument to RND is zero, then return last value
3145H  (FCH) CM 31CAH       ; If argument is negative, seed FP_RND (Move FAC1 to M)
3148H  (21H) LXI H,FC60H    ; Load pointer to BCD_TEMP8
314BH  (11H) LXI D,FC79H    ; Pointer to FP_RND
314EH  (CDH) CALL 31CDH     ; Move Floating point at (DE) to M
3151H  (21H) LXI H,3264H    ; Load pointer to FP 2.1132486540519e-65
3154H  (CDH) CALL 31B8H     ; Move floating point number M to FAC2
3157H  (21H) LXI H,325CH    ; Load pointer to FP 1.4389820420821e-65
315AH  (CDH) CALL 31C4H     ; Move floating point number M to FAC1
315DH  (11H) LXI D,FC67H    ; Load pointer to BCD_TEMP8
3160H  (CDH) CALL 2D4BH     ; Multiply BCD at (DE) times FAC2
3163H  (11H) LXI D,FC20H    ; Load pointer to extended precision portion of FAC1
3166H  (21H) LXI H,FC7AH    ; Point to BCD portion of Floating point number
3169H  (06H) MVI B,07H      ; Prepare to move BCD portion of floating point
316BH  (CDH) CALL 3469H     ; Move B bytes from (DE) to M with increment
316EH  (21H) LXI H,FC79H    ; Pointer to FP_RND
3171H  (36H) MVI M,00H      ; Make RND seed exponent "e-65"

; ======================================================
; Return value from RND generator (FP_RND) in FAC1
; ======================================================
3173H  (CDH) CALL 31C4H     ; Move floating point number M to FAC1
3176H  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision
3179H  (36H) MVI M,40H      ; Make RND number a sane value < 1 (vs 1.332e-65, etc)
317BH  (AFH) XRA A          ; Clear A
317CH  (32H) STA FC20H      ; Zero out 1st byte of extended precision portion of FAC1
317FH  (C3H) JMP 2BDEH      ; Normalize FAC1 such that the 1st BCD digit isn't zero

; ======================================================
; Initialize FP_RND for new program
; ======================================================
3182H  (11H) LXI D,326CH    ; Load pointer to REALLY small number
3185H  (21H) LXI H,FC79H    ; Pointer to FP_RND
3188H  (C3H) JMP 31CDH      ; Move Floating point at (DE) to M

; ======================================================
; Seed FP_RND with signed integer HL -- not called
; ======================================================
318BH  (CDH) CALL 3543H     ; Convert signed integer HL to single precision FAC1
318EH  (21H) LXI H,FC79H    ; Load pointer to FP_RND
3191H  (C3H) JMP 31CAH      ; Move FAC1 to M

; ======================================================
; Double precision add FP at (HL) to FAC1
; ======================================================
3194H  (CDH) CALL 31B8H     ; Move floating point number M to FAC2
3197H  (C3H) JMP 2B78H      ; Double precision addition (FAC1=FAC1+FAC2)

; ======================================================
; Double precision subtract FP at (HL) from FAC1
; ======================================================
319AH  (CDH) CALL 31B8H     ; Move floating point number M to FAC2
319DH  (C3H) JMP 2B69H      ; Double precision subtract (FAC1=FAC1-FAC2)

; ======================================================
; Double precision Square (FAC1=SQR(FAC1))
; ======================================================
31A0H  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision

; ======================================================
; Double precision math (FAC1=M * FAC2))
; ======================================================
31A3H  (CDH) CALL 31B8H     ; Move floating point number M to FAC2
31A6H  (C3H) JMP 2CFFH      ; Double precision multiply (FAC1=FAC1*FAC2)

; ======================================================
; Double precision math (FAC1=M / FAC2))  -- Not called??
; ======================================================
31A9H  (CDH) CALL 31B8H     ; Move floating point number M to FAC2
31ACH  (C3H) JMP 2DC7H      ; Double precision divide (FAC1=FAC1/FAC2)

; ======================================================
; Double precision compare FAC1 with floating point at HL
; ======================================================
31AFH  (CDH) CALL 31B8H     ; Move floating point number M to FAC2
31B2H  (C3H) JMP 34D2H      ; Double precision compare FAC1 with FAC2

; ======================================================
; Move FAC1 to FAC2
; ======================================================
31B5H  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision

; ======================================================
; Move floating point number M to FAC2
; ======================================================
31B8H  (11H) LXI D,FC69H    ; Start of FAC2 for single and double precision

; ======================================================
; Move floating point number at (HL) to the one at (DE)
; ======================================================
31BBH  (EBH) XCHG           ; DE = floating point number to move, HL = FAC2
31BCH  (CDH) CALL 31CDH     ; Call routine to Move 
31BFH  (EBH) XCHG           ; HL = Floating point number
31C0H  (C9H) RET

; ======================================================
; Move FAC2 to FAC1
; ======================================================
31C1H  (21H) LXI H,FC69H    ; Start of FAC2 for single and double precision

; ======================================================
; Move floating point number M to FAC1
; ======================================================
31C4H  (11H) LXI D,FC18H    ; Start of FAC1 for single and double precision
31C7H  (C3H) JMP 31BBH      ; Jump to routine to copy FP in DE to HL 

; ======================================================
; Move FAC1 to M
; ======================================================
31CAH  (11H) LXI D,FC18H    ; Start of FAC1 for single and double precision

; ======================================================
; Move Floating point at (DE) to M
; ======================================================
31CDH  (06H) MVI B,08H      ; Prepare to move 8 bytes of floating point number
31CFH  (C3H) JMP 3469H      ; Move B bytes from (DE) to M with increment

; ======================================================
; Swap FAC1 with Floating Point number on stack
; ======================================================
31D2H  (E1H) POP H          ; POP return address from stack
31D3H  (22H) SHLD FBE7H     ; Save return address in Temp FP 1
31D6H  (CDH) CALL 3245H     ; Pop FAC2 from stack
31D9H  (CDH) CALL 3234H     ; Push FAC1 on stack
31DCH  (CDH) CALL 31C1H     ; Move FAC2 to FAC1
31DFH  (2AH) LHLD FBE7H     ; Restore return address from Temp FP 1
31E2H  (E9H) PCHL           ; RETurn (HL has return address)

; ======================================================
; Take ABS(FAC1) and push return address to ABS(FAC1)
; ======================================================
31E3H  (CDH) CALL 33FDH     ; Perform ABS function on FAC1
31E6H  (21H) LXI H,33FDH    ; Load address to Perform ABS function on FAC1
31E9H  (E3H) XTHL           ; Change return address to Perform ABS function on FAC1
31EAH  (E9H) PCHL           ; Return to calling program (we changed his RET address)

; ======================================================
; Square FAC1 & do table based math
; ======================================================
31EBH  (22H) SHLD FBE7H     ; Floating Point Temp 1
31EEH  (CDH) CALL 31A0H     ; Double precision Square (FAC1=SQR(FAC1))
31F1H  (2AH) LHLD FBE7H     ; Floating Point Temp 1
31F4H  (C3H) JMP 3209H      ; Table based math (FAC1=(((FAC1*M)+(M+1))*(M+2)+(M+3)...

; ======================================================
; FAC1 = FAC1 * (FAC1^2 * table based math)
; ======================================================
31F7H  (22H) SHLD FBE7H     ; Save HL temporarily in Floating Point Temp 1 -- can't use stack
31FAH  (CDH) CALL 3234H     ; Push FAC1 on stack
31FDH  (2AH) LHLD FBE7H     ; Restore HL from Floating Point Temp 1
3200H  (CDH) CALL 31EBH     ; Square FAC1 & do table based math
3203H  (CDH) CALL 3245H     ; Pop FAC2 from stack (FAC2 equals original FAC1)
3206H  (C3H) JMP 2CFFH      ; Double precision multiply (FAC1=FAC1*FAC2)

; ======================================================
; Table based math (FAC1=(((FAC1*M)+(M+1))*(M+2)+(M+3)...
; ======================================================
3209H  (7EH) MOV A,M        ; Get count of products to add
320AH  (F5H) PUSH PSW       ; Save count on stack
320BH  (23H) INX H          ; Increment to first term
320CH  (E5H) PUSH H         ; Save address of first term on stack
320DH  (21H) LXI H,FBE7H    ; Floating Point Temp 1
3210H  (CDH) CALL 31CAH     ; Move FAC1 to M
3213H  (E1H) POP H          ; Restore first term from stack
3214H  (CDH) CALL 31C4H     ; Move floating point number M to FAC1

3217H  (F1H) POP PSW        ; Restore count of products to add from stack
3218H  (3DH) DCR A          ; Decrement count
3219H  (C8H) RZ             ; Return if count = 0
321AH  (F5H) PUSH PSW       ; Save new count to stack
321BH  (E5H) PUSH H         ; Save address of next term to stack
321CH  (21H) LXI H,FBE7H    ; Floating Point Temp 1
321FH  (CDH) CALL 31A3H     ; Double precision math (FAC1=M * FAC2))
3222H  (E1H) POP H          ; Restore address of next term from stack
3223H  (CDH) CALL 31B8H     ; Move floating point number M to FAC2
3226H  (E5H) PUSH H         ; Save address to stack again
3227H  (CDH) CALL 2B78H     ; Double precision addition (FAC1=FAC1+FAC2)
322AH  (E1H) POP H          ; Restore address of next term from stack
322BH  (C3H) JMP 3217H      ; Jump to process next term in series

; ======================================================
; Push FAC2 on stack
; ======================================================
322EH  (21H) LXI H,FC70H    ; Point to end of FAC2
3231H  (C3H) JMP 3237H      ; Jump to push 4 bytes to stack

; ======================================================
; Push FAC1  on stack
; ======================================================
3234H  (21H) LXI H,FC1FH    ; Point to end of FAC1

; ======================================================
; Push 8-bytes of FAC from (M) to stack
; ======================================================
3237H  (3EH) MVI A,04H      ; Load byte counter
3239H  (D1H) POP D          ; POP return address (so we can push to stack)
323AH  (46H) MOV B,M        ; Get next BCD byte from (M) to MSB (BCD is stored big endian)
323BH  (2BH) DCX H          ; Decrement to next higher byte
323CH  (4EH) MOV C,M        ; Get next BCD byte into LSB (BCD is stored big endian)
323DH  (2BH) DCX H          ; Decrement to next higher byte
323EH  (C5H) PUSH B         ; Push next 2 bytes to stack
323FH  (3DH) DCR A          ; Decrement counter (each count is 2 bytes)
3240H  (C2H) JNZ 323AH      ; Keep looping until 8 bytes (4 words) pushed
3243H  (EBH) XCHG           ; Put RETurn address in HL
3244H  (E9H) PCHL           ; RETurn (we modified the stack)

; ======================================================
; Pop FAC2 from stack
; ======================================================
3245H  (21H) LXI H,FC69H    ; Start of FAC2 for single and double precision
3248H  (C3H) JMP 324EH      ; Jump to POP a BCD value from the stack

; ======================================================
; Pop FAC1 from stack
; ======================================================
324BH  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision

; ======================================================
; Pop a Floating point value from the stack
; ======================================================
324EH  (3EH) MVI A,04H      ; Prepare to pop 4 words (8 bytes)
3250H  (D1H) POP D          ; POP the return address to get to the BCD number
3251H  (C1H) POP B          ; POP next 2 bytes 
3252H  (71H) MOV M,C        ; Move next byte to FAC1 / 2
3253H  (23H) INX H          ; Increment to next byte of FAC
3254H  (70H) MOV M,B        ; Move next byte to FAC1 / 2
3255H  (23H) INX H          ; Increment to next byte of FAC
3256H  (3DH) DCR A          ; Decrement word counter
3257H  (C2H) JNZ 3251H      ; Keep looping until 4 words POPed
325AH  (EBH) XCHG           ; Put return address in HL
325BH  (E9H) PCHL           ; Return (return address from stack is in HL)

; ======================================================
; Floating point numbers for math operations 
; ======================================================
325CH  DB   00H,14H,38H,98H,20H,42H,08H,21H    ; 1.4389820420821e-65 - RND
3264H  DB   00H,21H,13H,24H,86H,54H,05H,19H    ; 2.1132486540519e-65 - RND
326CH  DB   00H,40H,64H,96H,51H,37H,23H,58H    ; 4.0649651372358e-65 - BASIC initialize
3274H  DB   40H,43H,42H,94H,48H,19H,03H,24H    ; 0.43429448190324    - EXP

; ======================================================
; Floating point num-shares 6 bytes from next number
; ======================================================
327CH  DB   40H,50H                            ; 0.500000000000    - SIN, SQR, EXP

; ======================================================
; Floating point numbers for math operations 
; ======================================================
327EH  DB   00H,00H,00H,00H,00H,00H,00H,00H    ; 0.0000000000000  - Various
3286H  DB   41H,10H,00H,00H,00H,00H,00H,00H    ; 1.0000000000000  - Various
328EH  DB   40H,25H,00H,00H,00H,00H,00H,00H    ; 0.2500000000000  - COS
3296H  DB   41H,31H,62H,27H,76H,60H,16H,84H    ; 3.1622776601684  - LOG & EXP
329EH  DB   40H,86H,85H,88H,96H,38H,06H,50H    ; 0.86858896380650 - LOG
32A6H  DB   41H,23H,02H,58H,50H,92H,99H,40H    ; 2.3025850929940  - LOG
32AEH  DB   41H,15H,70H,79H,63H,26H,79H,49H    ; 1.5707963267949  - ATN
32B6H  DB   40H,26H,79H,49H,19H,24H,31H,12H    ; 0.26794919243112 - ATN
32BEH  DB   41H,17H,32H,05H,08H,07H,56H,89H    ; 1.7320508075689  - ATN
32C6H  DB   40H,52H,35H,98H,77H,55H,98H,30H    ; 0.52359877559830 - ATN
32CEH  DB   40H,15H,91H,54H,94H,30H,91H,90H    ; 0.15915494309190 - SIN & COS


; ======================================================
; Count of Floating point numbers to follow for EXP
; ======================================================
32D6H  DB   04H

32D7H  DB   41H,10H,00H,00H,00H,00H,00H,00H    ; 1.0000000000000
32DFH  DB   43H,15H,93H,74H,15H,23H,60H,31H    ; 159.37415236031
32E7H  DB   44H,27H,09H,31H,69H,40H,85H,16H    ; 2709.3169408516
32EFH  DB   44H,44H,97H,63H,35H,57H,40H,58H    ; 4497.6335574058


; ======================================================
; Count of Floating point numbers to follow for EXP
; ======================================================
32F7H  DB   03H

32F8H  DB   42H,18H,31H,23H,60H,15H,92H,75H    ; 18.312360159275
3300H  DB   43H,83H,14H,06H,72H,12H,93H,71H    ; 831.40672129371
3308H  DB   44H,51H,78H,09H,19H,91H,51H,62H    ; 5178.0919915162


; ======================================================
; Count of Floating point numbers to follow for LOG
; ======================================================
3310H  DB   04H

3311H  DB   C0H,71H,43H,33H,82H,15H,32H,26H    ; -0.71433382153226
3319H  DB   41H,62H,50H,36H,51H,12H,79H,08H    ;  6.2503651127908
3321H  DB   C2H,13H,68H,23H,70H,24H,15H,03H    ; -13.682370241503
3329H  DB   41H,85H,16H,73H,19H,87H,23H,89H    ;  8.5167319872389


; ======================================================
; Count of Floating point numbers to follow for LOG
; ======================================================
3331H  DB   05H

3332H  DB   41H,10H,00H,00H,00H,00H,00H,00H    ;  1.0000000000000
333AH  DB   C2H,13H,21H,04H,78H,35H,01H,56H    ; -13.210478350156
3342H  DB   42H,47H,92H,52H,56H,04H,38H,73H    ;  47.925256043873
334AH  DB   C2H,64H,90H,66H,82H,74H,09H,43H    ; -64.906682740943
3352H  DB   42H,29H,41H,57H,50H,17H,23H,23H    ;  29.415750172323


; ======================================================
; Count of Floating point numbers to follow for SIN
; ======================================================
335AH  DB   08H

335BH  DB   C0H,69H,21H,56H,92H,29H,18H,09H    ; -0.69215692291809
3363H  DB   41H,38H,17H,28H,86H,38H,57H,71H    ;  3.8172886385771
336BH  DB   C2H,15H,09H,44H,99H,47H,48H,01H    ; -15.094499474801
3373H  DB   42H,42H,05H,86H,89H,66H,73H,55H    ;  42.058689667355
337BH  DB   C2H,76H,70H,58H,59H,68H,32H,91H    ; -76.705859683291
3383H  DB   42H,81H,60H,52H,49H,27H,55H,13H    ;  81.605249275513
338BH  DB   C2H,41H,34H,17H,02H,24H,03H,98H    ; -41.341702240398
3393H  DB   41H,62H,83H,18H,53H,07H,17H,96H    ;  6.2831853071796


; ======================================================
; Count of Floating point numbers to follow for ATN
; ======================================================
339BH  DB   08H

339CH  DB   BFH,52H,08H,69H,39H,04H,00H,00H    ; -0.052086939040000
33A4H  DB   3FH,75H,30H,71H,49H,13H,48H,00H    ;  0.075307149134800
33ACH  DB   BFH,90H,81H,34H,32H,24H,70H,50H    ; -0.090813432247050
33B4H  DB   40H,11H,11H,07H,94H,18H,40H,29H    ;  0.11110794184029
33BCH  DB   C0H,14H,28H,56H,08H,55H,48H,84H    ; -0.14285608554884
33C4H  DB   40H,19H,99H,99H,99H,94H,89H,67H    ;  0.19999999948967
33CCH  DB   C0H,33H,33H,33H,33H,33H,31H,60H    ; -0.33333333333160
33D4H  DB   41H,10H,00H,00H,00H,00H,00H,00H    ;  1.0000000000000


; ======================================================
; RST 30H routine - Get sign of SGL or DBL precision
; ======================================================
33DCH  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
33DFH  (B7H) ORA A          ; Test if zero
33E0H  (C8H) RZ             ; Return if zero
33E1H  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
33E4H  (C3H) JMP 33E8H      ; Return 1 or -1 in A based on Sign bit in A

; ======================================================
; Return 1 or -1 in A based on Inverse of Sign bit in A
; ======================================================
33E7H  (2FH) CMA            ; Compliment sign of A

; ======================================================
; Return 1 or -1 in A based on Sign bit in A
; ======================================================
33E8H  (17H) RAL            ; Rotate sign bit to C flag

; ======================================================
; Return 1 or -1 in A based on Carry flag
; ======================================================
33E9H  (9FH) SBB A          ; Subtract with borrow generates -1 or 0 based on C
33EAH  (C0H) RNZ            ; Return if -1
33EBH  (3CH) INR A          ; Increment zero to 1
33ECH  (C9H) RET

; ======================================================
; Initialize FAC1 for SGL & DBL precision to zero
; ======================================================
33EDH  (AFH) XRA A          ; Zero out A
33EEH  (32H) STA FC18H      ; Store as start of FAC1 for single and double precision
33F1H  (C9H) RET

; ======================================================
; ABS function
; ======================================================
33F2H  (CDH) CALL 3411H     ; Determine sign of last variable used
33F5H  (F0H) RP             ; Return if already positive
33F6H  (EFH) RST 5          ; Determine type of last var used
33F7H  (FAH) JM 37D0H       ; If integer, jump to ABS function for integer FAC1
33FAH  (CAH) JZ 045BH       ; Generate TM error if last var was string

; ======================================================
; Perform ABS function on FAC1
; ======================================================
33FDH  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision
3400H  (7EH) MOV A,M        ; Get sign / decimal point byte
3401H  (B7H) ORA A          ; Test if FAC1 is zero
3402H  (C8H) RZ             ; Return if zero
3403H  (EEH) XRI 80H        ; Invert the sign bit - make positive
3405H  (77H) MOV M,A        ; Save inverted sign bit to FAC1
3406H  (C9H) RET

; ======================================================
; SGN function
; ======================================================
3407H  (CDH) CALL 3411H     ; Get sign in A of last variable used
340AH  (6FH) MOV L,A        ; Move sign to LSB of HL
340BH  (17H) RAL            ; Prepare to sign extend into MSB
340CH  (9FH) SBB A          ; Generate zero or 1 based C flag (sign of integer)
340DH  (67H) MOV H,A        ; Sign extend into MSB of HL (HL has FFFFH, 0001H or 0000H)
340EH  (C3H) JMP 3510H      ; Load signed integer in HL to FAC1

; ======================================================
; Determine sign of last variable used
; ======================================================
3411H  (EFH) RST 5          ; Determine type of last var used
3412H  (CAH) JZ 045BH       ; Generate TM error if last var was string
3415H  (F2H) JP 33DCH       ; RST 30H routine - jump if not integer
3418H  (2AH) LHLD FC1AH     ; Start of FAC1 for integers - get value of last integer
341BH  (7CH) MOV A,H        ; Get MSB of integer
341CH  (B5H) ORA L          ; OR in LSB to test for zero
341DH  (C8H) RZ             ; Return if zero
341EH  (7CH) MOV A,H        ; Get MSB of integer to test sign
341FH  (C3H) JMP 33E8H      ; Return 1 or -1 in A based on Sign bit in A

; ======================================================
; Push single precision FAC1 on stack
; ======================================================
3422H  (EBH) XCHG
3423H  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
3426H  (E3H) XTHL
3427H  (E5H) PUSH H
3428H  (2AH) LHLD FC18H     ; Start of FAC1 for single and double precision
342BH  (E3H) XTHL
342CH  (E5H) PUSH H
342DH  (EBH) XCHG
342EH  (C9H) RET

; ======================================================
; Load single precision at M to FAC1
; ======================================================
342FH  (CDH) CALL 3450H     ; Reverse load single precision at M to DEBC

; ======================================================
; Load single precision in BCDE to FAC1
; ======================================================
3432H  (EBH) XCHG           ; Load DE to HL, save HL
3433H  (22H) SHLD FC1AH     ; Store DE to FAC1
3436H  (60H) MOV H,B        ; Copy MSB of BE to HL
3437H  (69H) MOV L,C        ; Copy LSB
3438H  (22H) SHLD FC18H     ; Store BC in FAC1
343BH  (EBH) XCHG           ; Restore HL
343CH  (C9H) RET

; ======================================================
; Load single precision FAC1 to BCDE
; ======================================================
343DH  (2AH) LHLD FC1AH     ; Load LSW of FAC1
3440H  (EBH) XCHG           ; Move LSW of FAC1 to DE
3441H  (2AH) LHLD FC18H     ; Load MSW of FAC1
3444H  (4DH) MOV C,L        ; Copy LSB of MSW from FAC1 to C
3445H  (44H) MOV B,H        ; Copy MSB of FAC1 to B
3446H  (C9H) RET

; ======================================================
; Load single precision at M to BCDE
; ======================================================
3447H  (4EH) MOV C,M        ; Load 2 MSB BCD digits to C 
3448H  (23H) INX H          ; Increment to next 2 BCD digits
3449H  (46H) MOV B,M        ; Load next 2 BCD to B
344AH  (23H) INX H          ; Increment to next 2 lower digits
344BH  (5EH) MOV E,M        ; Load next 2 BCD to E
344CH  (23H) INX H          ; Increment to least significant BCD digits
344DH  (56H) MOV D,M        ; Load 2 LSB BCD digits to D
344EH  (23H) INX H          ; Increment to next BCD
344FH  (C9H) RET

; ======================================================
; Reverse load single precision at M to DEBC
; ======================================================
3450H  (5EH) MOV E,M        ; Load 2 MSB BCD digits to E
3451H  (23H) INX H          ; Increment to next 2 lower BCD digits
3452H  (56H) MOV D,M        ; Move next 2 BCD to D
3453H  (23H) INX H          ; Increment to next 2 lower BCD digits
3454H  (4EH) MOV C,M        ; Load next 2 BCD to C
3455H  (23H) INX H          ; Increment to 2 least significant BCD digits
3456H  (46H) MOV B,M        ; Load 2 LSB BCD digits to B
3457H  (23H) INX H          ; Final increment
3458H  (C9H) RET

; ======================================================
; Move single precision FAC1 to M
; ======================================================
3459H  (11H) LXI D,FC18H    ; Start of FAC1 for single and double precision
345CH  (06H) MVI B,04H      ; Prepare to copy 4 bytes
345EH  (C3H) JMP 3469H      ; Move B bytes from (DE) to M with increment

; ======================================================
; Move M to FAC2 using precision of last var used (FB65H)
; ======================================================
3461H  (11H) LXI D,FC69H    ; Start of FAC2 for single and double precision

; ======================================================
; Copy (HL) to (DE) using precision of last var used (FB65H)
; ======================================================
3464H  (EBH) XCHG           ; Swap SRC and DEST address in HL & DE

; ======================================================
; Copy (DE) to (HL) using precision of last var used (FB65H)
; ======================================================
3465H  (3AH) LDA FB65H      ; Type of last variable used
3468H  (47H) MOV B,A        ; Prepare to copy bytes based on precision of last var (2, 4 or 8)

; ======================================================
; Move B bytes from (DE) to M with increment
; ======================================================
3469H  (1AH) LDAX D         ; Load next byte to copy
346AH  (77H) MOV M,A        ; Save byte in destination address
346BH  (13H) INX D          ; Increment source pointer
346CH  (23H) INX H          ; Increment destination pointer
346DH  (05H) DCR B          ; Decrement byte counter
346EH  (C2H) JNZ 3469H      ; Keep looping until count = 0
3471H  (C9H) RET

; ======================================================
; Move B bytes from (DE) to M with decrement
; ======================================================
3472H  (1AH) LDAX D         ; Load next byte to copy
3473H  (77H) MOV M,A        ; Save next byte to destination
3474H  (1BH) DCX D          ; Decrement source pointer
3475H  (2BH) DCX H          ; Decrement destination pointer
3476H  (05H) DCR B          ; Decrement counter
3477H  (C2H) JNZ 3472H      ; Loop until counter = 0
347AH  (C9H) RET

; ======================================================
; Copy FAC2 to FAC1
; ======================================================
347BH  (21H) LXI H,FC69H    ; Start of FAC2 for single and double precision
347EH  (11H) LXI D,3464H    ; Copy (HL) to (DE) using precision of last var used (FB65H) 
3481H  (C3H) JMP 348AH      ; Jump to push copy operation to stack & copy to from FAC1

; ======================================================
; Copy FAC1 to FAC2
; ======================================================
3484H  (21H) LXI H,FC69H    ; Start of FAC2 for single and double precision
3487H  (11H) LXI D,3465H    ; Copy (DE) to (HL) using precision of last var used (FB65H) 
348AH  (D5H) PUSH D         ; Push address of copy operation to stack
348BH  (11H) LXI D,FC18H    ; Start of FAC1 for single and double precision
348EH  (3AH) LDA FB65H      ; Type of last variable used
3491H  (FEH) CPI 02H        ; Test if type of last variable is integer
3493H  (C0H) RNZ            ; Return to start copy if not integer FAC
3494H  (11H) LXI D,FC1AH    ; Get start of FAC1 for integers
3497H  (C9H) RET            ; Return to PUSHed copy routine to perform copy (to / from FAC1)

; ======================================================
; Compare single precision in BCDE with FAC1
; ======================================================
3498H  (79H) MOV A,C        ; Move sign/decimal point to A
3499H  (B7H) ORA A          ; Test if value is zero
349AH  (CAH) JZ 33DCH       ; If zero, return sign of FAC1 RST 30H routine
349DH  (21H) LXI H,33E7H    ; Load address of routine to teturn 1 or -1 in A 
34A0H  (E5H) PUSH H         ; Push new return address to stack to return SGN
34A1H  (F7H) RST 6          ; Get sign of FAC1
34A2H  (79H) MOV A,C        ; Move sign/decimal point of BCDE to A
34A3H  (C8H) RZ             ; If FAC1 is zero, return to calc sign of BCDE as return value
34A4H  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision
34A7H  (AEH) XRA M          ; Compare sign bit of BCDE and FAC1
34A8H  (79H) MOV A,C        ; Get sign/decimal point of BCDE in A
34A9H  (F8H) RM             ; Return to calc sign of BCDE as result if BCDE & FAC1 have different sign
34AAH  (CDH) CALL 34B0H     ; Compare single precision in BCDE with M
34ADH  (1FH) RAR            ; Rotate the C bit into  A to determine which is bigger based on sign
34AEH  (A9H) XRA C          ; XOR the sign of BCDE with A
34AFH  (C9H) RET            ; Return to routine to calc 1 or -1 base on sign of A

; ======================================================
; Compare single precision in BCDE with M
; ======================================================
34B0H  (79H) MOV A,C
34B1H  (BEH) CMP M
34B2H  (C0H) RNZ
34B3H  (23H) INX H
34B4H  (78H) MOV A,B
34B5H  (BEH) CMP M
34B6H  (C0H) RNZ
34B7H  (23H) INX H
34B8H  (7BH) MOV A,E
34B9H  (BEH) CMP M
34BAH  (C0H) RNZ
34BBH  (23H) INX H
34BCH  (7AH) MOV A,D
34BDH  (96H) SUB M
34BEH  (C0H) RNZ
34BFH  (E1H) POP H
34C0H  (E1H) POP H
34C1H  (C9H) RET

; ======================================================
; Compare signed integer in DE with that in HL
; ======================================================
34C2H  (7AH) MOV A,D        ; Prepare to compare MSB of DE and HL
34C3H  (ACH) XRA H          ; Test if sign of 2 integers are different
34C4H  (7CH) MOV A,H        ; Load sign of H in case they are different
34C5H  (FAH) JM 33E8H       ; Return 1 or -1 in A based on Sign bit in A
34C8H  (BAH) CMP D          ; Compare MSB of DE and HL to test if equal
34C9H  (C2H) JNZ 34CFH      ; Jump if not equal to determine which is bigger
34CCH  (7DH) MOV A,L        ; Prepare to compare LSB of HL and DE
34CDH  (93H) SUB E          ; Compare LSB of HL and DE
34CEH  (C8H) RZ             ; Return zero in A if they are equal
34CFH  (C3H) JMP 33E9H      ; Return 1 or -1 in A based on Carry flag

; ======================================================
; Double precision compare FAC1 with FAC2
; ======================================================
34D2H  (11H) LXI D,FC69H    ; Start of FAC2 for single and double precision
34D5H  (1AH) LDAX D         ; Get Sign and Decimal point location for FAC2
34D6H  (B7H) ORA A          ; Test if FAC2 is zero
34D7H  (CAH) JZ 33DCH       ; If FAC2 is zero, jump to return SGN(FAC1) as the answer
34DAH  (21H) LXI H,33E7H    ; Return 1 or -1 in A based on Inverse of Sign bit in A
34DDH  (E5H) PUSH H         ; Push address of routine to return 1 or -1 based on A to stack
34DEH  (F7H) RST 6          ; Get sign of FAC1
34DFH  (1AH) LDAX D         ; Get Sign and Decimal point location for FAC2
34E0H  (4FH) MOV C,A        ; Save sign of FAC2 in C
34E1H  (C8H) RZ             ; If FAC1 is zero, return to calculate 1 or -1 base on sign of FAC2
34E2H  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision
34E5H  (AEH) XRA M          ; XOR sign bit of FAC1 and FAC2 to determine if they are equal
34E6H  (79H) MOV A,C        ; Restore sign of FAC2 to A
34E7H  (F8H) RM             ; Return to calculate 1 or -1 based on sign of FAC2 if sign of FAC1 != FAC2
34E8H  (06H) MVI B,08H      ; Prepare to compare 8 bytes of floating point 
34EAH  (1AH) LDAX D         ; Get next byte from FAC2
34EBH  (96H) SUB M          ; Subtract next byte from FAC1
34ECH  (C2H) JNZ 34F7H      ; If not equal, jump to determine which is bigger
34EFH  (13H) INX D          ; Point to next byte of FAC2
34F0H  (23H) INX H          ; Increment to next byte of FAC1
34F1H  (05H) DCR B          ; Decrement byte counter
34F2H  (C2H) JNZ 34EAH      ; Keep looping until 8 bytes compared
34F5H  (C1H) POP B          ; POP address of of SIGN routine ... they are equal and A already has zero 
34F6H  (C9H) RET

; ======================================================
; FAC1 and FAC2 not equal.  Get C flag & XOR with sign of FAC2 to determine which is bigger
; ======================================================
34F7H  (1FH) RAR            ; Get C flag from last subtract
34F8H  (A9H) XRA C          ; XOR with sign of FAC1 & FAC2
34F9H  (C9H) RET            ; Return to calculate 1 or -1 based on A

; ======================================================
; Compare double precision FAC1 with FAC2
; ======================================================
34FAH  (CDH) CALL 34D2H     ; Double precision compare FAC1 with FAC2
34FDH  (C2H) JNZ 33E7H      ; Return 1 or -1 in A based on Inverse of Sign bit in A
3500H  (C9H) RET

; ======================================================
; CINT function
; ======================================================
3501H  (EFH) RST 5          ; Determine type of last var used
3502H  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
3505H  (F8H) RM             ; Return if already an integer
3506H  (CAH) JZ 045BH       ; Generate TM error
3509H  (CDH) CALL 35DEH
350CH  (DAH) JC 0455H       ; Generate OV error
350FH  (EBH) XCHG

; ======================================================
; Load signed integer in HL to FAC1
; ======================================================
3510H  (22H) SHLD FC1AH     ; Start of FAC1 for integers
3513H  (3EH) MVI A,02H      ; Load code for integer type variable

; ======================================================
; Save type of last variable from A
; ======================================================
3515H  (32H) STA FB65H      ; Type of last variable used
3518H  (C9H) RET

; ======================================================
; Test if FAC1 has 32768 in it
; ======================================================
3519H  (01H) LXI B,32C5H    ; SNGL precision value for 32768
351CH  (11H) LXI D,8076H    ;   "
351FH  (CDH) CALL 3498H     ; Compare single precision in BCDE with FAC1
3522H  (C0H) RNZ            ; Return if FAC1 != 32768.0
3523H  (21H) LXI H,8000H    ; Load HL with Decimal 32768
3526H  (D1H) POP D
3527H  (C3H) JMP 3510H      ; Load signed integer in HL to FAC1

; ======================================================
; CSNG function
; ======================================================
352AH  (EFH) RST 5          ; Determine type of last var used
352BH  (E0H) RPO
352CH  (FAH) JM 3540H       ; Convert signed integer in FAC1 to single precision
352FH  (CAH) JZ 045BH       ; Generate TM error if last type was string
3532H  (CDH) CALL 35D4H     ; Set type of last variable to SGL
3535H  (CDH) CALL 3D04H
3538H  (23H) INX H
3539H  (78H) MOV A,B
353AH  (B7H) ORA A
353BH  (1FH) RAR
353CH  (47H) MOV B,A
353DH  (C3H) JMP 2C2CH

; ======================================================
; Convert signed integer in FAC1 to single precision
; ======================================================
3540H  (2AH) LHLD FC1AH     ; Start of FAC1 for integers

; ======================================================
; Convert signed integer HL to single precision FAC1
; ======================================================
3543H  (7CH) MOV A,H
3544H  (B7H) ORA A
3545H  (F5H) PUSH PSW
3546H  (FCH) CM 37C6H
3549H  (CDH) CALL 35D4H     ; Set type of last variable to SGL
354CH  (EBH) XCHG
354DH  (21H) LXI H,0000H
3550H  (22H) SHLD FC18H     ; Start of FAC1 for single and double precision
3553H  (22H) SHLD FC1AH     ; Start of FAC1 for integers
3556H  (7AH) MOV A,D
3557H  (B3H) ORA E
3558H  (CAH) JZ 27E2H
355BH  (01H) LXI B,0500H
355EH  (21H) LXI H,FC19H    ; Point to BCD portion of FAC1
3561H  (E5H) PUSH H
3562H  (21H) LXI H,35B0H
3565H  (3EH) MVI A,FFH
3567H  (D5H) PUSH D
3568H  (5EH) MOV E,M
3569H  (23H) INX H
356AH  (56H) MOV D,M
356BH  (23H) INX H
356CH  (E3H) XTHL
356DH  (C5H) PUSH B
356EH  (44H) MOV B,H
356FH  (4DH) MOV C,L
3570H  (19H) DAD D
3571H  (3CH) INR A
3572H  (DAH) JC 356EH
3575H  (60H) MOV H,B
3576H  (69H) MOV L,C
3577H  (C1H) POP B
3578H  (D1H) POP D
3579H  (EBH) XCHG
357AH  (0CH) INR C
357BH  (0DH) DCR C
357CH  (C2H) JNZ 358BH
357FH  (B7H) ORA A
3580H  (CAH) JZ 35A1H
3583H  (F5H) PUSH PSW
3584H  (3EH) MVI A,40H
3586H  (80H) ADD B
3587H  (32H) STA FC18H      ; Start of FAC1 for single and double precision
358AH  (F1H) POP PSW
358BH  (0CH) INR C
358CH  (E3H) XTHL
358DH  (F5H) PUSH PSW
358EH  (79H) MOV A,C
358FH  (1FH) RAR
3590H  (D2H) JNC 359CH
3593H  (F1H) POP PSW
3594H  (87H) ADD A
3595H  (87H) ADD A
3596H  (87H) ADD A
3597H  (87H) ADD A
3598H  (77H) MOV M,A
3599H  (C3H) JMP 35A0H

359CH  (F1H) POP PSW
359DH  (B6H) ORA M
359EH  (77H) MOV M,A
359FH  (23H) INX H
35A0H  (E3H) XTHL
35A1H  (7AH) MOV A,D
35A2H  (B3H) ORA E
35A3H  (CAH) JZ 35AAH
35A6H  (05H) DCR B
35A7H  (C2H) JNZ 3565H
35AAH  (E1H) POP H
35ABH  (F1H) POP PSW
35ACH  (F0H) RP
35ADH  (C3H) JMP 33FDH      ; Perform ABS function on FAC1

35B0H  (F0H) RP
35B1H  (D8H) RC
35B2H  (18H) RLDE
35B3H  (FCH) CM FF9CH
35B6H  (F6H) ORI FFH
35B8H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
35B9H  DB   FFH

; ======================================================
; CDBL function
; ======================================================
35BAH  (EFH) RST 5          ; Determine type of last var used
35BBH  (D0H) RNC            ; Return if already double precision
35BCH  (CAH) JZ 045BH       ; Generate TM error if last type is string
35BFH  (FCH) CM 3540H       ; If integer, convert signed integer in FAC1 to single precision

; ======================================================
; Convert FAC1 to double precision
; ======================================================
35C2H  (21H) LXI H,0000H    ; Prepare to "zero out" the double precision portion of FAC1
35C5H  (22H) SHLD FC1CH     ; Zero out next 4 digits of FAC1
35C8H  (22H) SHLD FC1EH     ; Zero out least 4 significant digits of FAC1
35CBH  (7CH) MOV A,H        ; Prepare to zero out extended precision portion of FAC1
35CCH  (32H) STA FC20H      ; Zero out extended precision portion of FAC1

; ======================================================
; Set type of last variable to DBL
; ======================================================
35CFH  (3EH) MVI A,08H      ; Load code for double precision variable type
35D1H  (C3H) JMP 35D6H      ; Jump to set type of last variable

; ======================================================
; Set type of last variable to SGL
; ======================================================
35D4H  (3EH) MVI A,04H      ; Load code for Single Precision variable type

; ======================================================
; Set type of last variable to A
; ======================================================
35D6H  (C3H) JMP 3515H      ; Save type of last variable from A

; ======================================================
; Generate TM error if last variable type not string or RET 
; ======================================================
35D9H  (EFH) RST 5          ; Determine type of last var used
35DAH  (C8H) RZ             ; Return if type is string
35DBH  (C3H) JMP 045BH      ; Generate TM error

35DEH  (21H) LXI H,3641H
35E1H  (E5H) PUSH H
35E2H  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision
35E5H  (7EH) MOV A,M
35E6H  (E6H) ANI 7FH
35E8H  (FEH) CPI 46H
35EAH  (D0H) RNC
35EBH  (D6H) SUI 41H
35EDH  (D2H) JNC 35F6H
35F0H  (B7H) ORA A
35F1H  (D1H) POP D
35F2H  (11H) LXI D,0000H
35F5H  (C9H) RET

35F6H  (3CH) INR A
35F7H  (47H) MOV B,A

; ======================================================
; Signed integer subtract (FAC1=HL-DE)
; ======================================================
35F8H  (11H) LXI D,0000H
35FBH  (4AH) MOV C,D
35FCH  (23H) INX H
35FDH  (79H) MOV A,C
35FEH  (0CH) INR C
35FFH  (1FH) RAR
3600H  (7EH) MOV A,M
3601H  (DAH) JC 360BH
3604H  (1FH) RAR
3605H  (1FH) RAR
3606H  (1FH) RAR
3607H  (1FH) RAR
3608H  (C3H) JMP 360CH

360BH  (23H) INX H
360CH  (E6H) ANI 0FH
360EH  (22H) SHLD FC12H
3611H  (62H) MOV H,D
3612H  (6BH) MOV L,E
3613H  (29H) DAD H
3614H  (D8H) RC
3615H  (29H) DAD H
3616H  (D8H) RC
3617H  (19H) DAD D
3618H  (D8H) RC
3619H  (29H) DAD H
361AH  (D8H) RC
361BH  (5FH) MOV E,A
361CH  (16H) MVI D,00H
361EH  (19H) DAD D
361FH  (D8H) RC
3620H  (EBH) XCHG
3621H  (2AH) LHLD FC12H
3624H  (05H) DCR B
3625H  (C2H) JNZ 35FDH
3628H  (21H) LXI H,8000H
362BH  (DFH) RST 3          ; Compare DE and HL
362CH  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
362FH  (D8H) RC
3630H  (CAH) JZ 363DH
3633H  (E1H) POP H
3634H  (B7H) ORA A
3635H  (F0H) RP
3636H  (EBH) XCHG
3637H  (CDH) CALL 37C6H
363AH  (EBH) XCHG
363BH  (B7H) ORA A
363CH  (C9H) RET

363DH  (B7H) ORA A
363EH  (F0H) RP
363FH  (E1H) POP H
3640H  (C9H) RET

3641H  (37H) STC
3642H  (C9H) RET

3643H  (0BH) DCX B
3644H  (C9H) RET


; ======================================================
; FIX function
; ======================================================
3645H  (EFH) RST 5          ; Determine type of last var used
3646H  (F8H) RM
3647H  (F7H) RST 6          ; Get sign of FAC1
3648H  (F2H) JP 3654H       ; INT function
364BH  (CDH) CALL 33FDH     ; Perform ABS function on FAC1
364EH  (CDH) CALL 3654H     ; INT function
3651H  (C3H) JMP 33F6H


; ======================================================
; INT function
; ======================================================
3654H  (EFH) RST 5          ; Determine type of last var used
3655H  (F8H) RM
3656H  (21H) LXI H,FC20H    ; Temp BCD value for computation?
3659H  (0EH) MVI C,0EH
365BH  (D2H) JNC 3666H
365EH  (CAH) JZ 045BH       ; Generate TM error
3661H  (21H) LXI H,FC1CH
3664H  (0EH) MVI C,06H
3666H  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
3669H  (B7H) ORA A
366AH  (FAH) JM 3688H
366DH  (E6H) ANI 7FH
366FH  (D6H) SUI 41H
3671H  (DAH) JC 33EDH       ; Initialize FAC1 for SGL & DBL precision to zero
3674H  (3CH) INR A
3675H  (91H) SUB C
3676H  (D0H) RNC
3677H  (2FH) CMA
3678H  (3CH) INR A
3679H  (47H) MOV B,A
367AH  (2BH) DCX H
367BH  (7EH) MOV A,M
367CH  (E6H) ANI F0H
367EH  (77H) MOV M,A
367FH  (05H) DCR B
3680H  (C8H) RZ
3681H  (AFH) XRA A
3682H  (77H) MOV M,A
3683H  (05H) DCR B
3684H  (C2H) JNZ 367AH
3687H  (C9H) RET

3688H  (E6H) ANI 7FH
368AH  (D6H) SUI 41H
368CH  (D2H) JNC 3695H
368FH  (21H) LXI H,FFFFH
3692H  (C3H) JMP 3510H      ; Load signed integer in HL to FAC1

3695H  (3CH) INR A
3696H  (91H) SUB C
3697H  (D0H) RNC
3698H  (2FH) CMA
3699H  (3CH) INR A
369AH  (47H) MOV B,A
369BH  (1EH) MVI E,00H
369DH  (2BH) DCX H
369EH  (7EH) MOV A,M
369FH  (57H) MOV D,A
36A0H  (E6H) ANI F0H
36A2H  (77H) MOV M,A
36A3H  (BAH) CMP D
36A4H  (CAH) JZ 36A8H
36A7H  (1CH) INR E
36A8H  (05H) DCR B
36A9H  (CAH) JZ 36B7H
36ACH  (AFH) XRA A
36ADH  (77H) MOV M,A
36AEH  (BAH) CMP D
36AFH  (CAH) JZ 36B3H
36B2H  (1CH) INR E
36B3H  (05H) DCR B
36B4H  (C2H) JNZ 369DH
36B7H  (1CH) INR E
36B8H  (1DH) DCR E
36B9H  (C8H) RZ
36BAH  (79H) MOV A,C
36BBH  (FEH) CPI 06H
36BDH  (01H) LXI B,10C1H
36C0H  (11H) LXI D,0000H
36C3H  (CAH) JZ 37F4H       ; Single precision addition (FAC1=FAC1+BCDE)
36C6H  (EBH) XCHG
36C7H  (22H) SHLD FC6FH
36CAH  (22H) SHLD FC6DH
36CDH  (22H) SHLD FC6BH     ; Start of FAC2 for integers
36D0H  (60H) MOV H,B
36D1H  (69H) MOV L,C
36D2H  (22H) SHLD FC69H     ; Start of FAC2 for single and double precision
36D5H  (C3H) JMP 2B78H      ; Double precision addition (FAC1=FAC1+FAC2)

36D8H  (E5H) PUSH H
36D9H  (21H) LXI H,0000H
36DCH  (78H) MOV A,B
36DDH  (B1H) ORA C
36DEH  (CAH) JZ 36F5H
36E1H  (3EH) MVI A,10H
36E3H  (29H) DAD H
36E4H  (DAH) JC 48F6H
36E7H  (EBH) XCHG
36E8H  (29H) DAD H
36E9H  (EBH) XCHG
36EAH  (D2H) JNC 36F1H
36EDH  (09H) DAD B
36EEH  (DAH) JC 48F6H
36F1H  (3DH) DCR A
36F2H  (C2H) JNZ 36E3H
36F5H  (EBH) XCHG
36F6H  (E1H) POP H
36F7H  (C9H) RET

36F8H  (7CH) MOV A,H
36F9H  (17H) RAL
36FAH  (9FH) SBB A
36FBH  (47H) MOV B,A
36FCH  (CDH) CALL 37C6H
36FFH  (79H) MOV A,C
3700H  (98H) SBB B
3701H  (C3H) JMP 3707H


; ======================================================
; Signed integer addition (FAC1=HL+DE)
; ======================================================
3704H  (7CH) MOV A,H
3705H  (17H) RAL
3706H  (9FH) SBB A
3707H  (47H) MOV B,A
3708H  (E5H) PUSH H
3709H  (7AH) MOV A,D
370AH  (17H) RAL
370BH  (9FH) SBB A
370CH  (19H) DAD D
370DH  (88H) ADC B
370EH  (0FH) RRC
370FH  (ACH) XRA H
3710H  (F2H) JP 3526H
3713H  (C5H) PUSH B
3714H  (EBH) XCHG
3715H  (CDH) CALL 3543H     ; Convert signed integer HL to single precision FAC1
3718H  (F1H) POP PSW
3719H  (E1H) POP H
371AH  (CDH) CALL 3422H     ; Push single precision FAC1 on stack
371DH  (CDH) CALL 3543H     ; Convert signed integer HL to single precision FAC1
3720H  (C1H) POP B
3721H  (D1H) POP D
3722H  (C3H) JMP 37F4H      ; Single precision addition (FAC1=FAC1+BCDE)


; ======================================================
; Signed integer muliply (FAC1=HL*DE)
; ======================================================
3725H  (7CH) MOV A,H
3726H  (B5H) ORA L
3727H  (CAH) JZ 3510H       ; Load signed integer in HL to FAC1
372AH  (E5H) PUSH H
372BH  (D5H) PUSH D
372CH  (CDH) CALL 37BAH
372FH  (C5H) PUSH B
3730H  (44H) MOV B,H
3731H  (4DH) MOV C,L
3732H  (21H) LXI H,0000H
3735H  (3EH) MVI A,10H
3737H  (29H) DAD H
3738H  (DAH) JC 375FH
373BH  (EBH) XCHG
373CH  (29H) DAD H
373DH  (EBH) XCHG
373EH  (D2H) JNC 3745H
3741H  (09H) DAD B
3742H  (DAH) JC 375FH
3745H  (3DH) DCR A
3746H  (C2H) JNZ 3737H
3749H  (C1H) POP B
374AH  (D1H) POP D
374BH  (7CH) MOV A,H
374CH  (B7H) ORA A
374DH  (FAH) JM 3755H
3750H  (D1H) POP D
3751H  (78H) MOV A,B
3752H  (C3H) JMP 37C2H

3755H  (EEH) XRI 80H
3757H  (B5H) ORA L
3758H  (CAH) JZ 3770H
375BH  (EBH) XCHG
375CH  (C3H) JMP 3761H

375FH  (C1H) POP B
3760H  (E1H) POP H
3761H  (CDH) CALL 3543H     ; Convert signed integer HL to single precision FAC1
3764H  (E1H) POP H
3765H  (CDH) CALL 3422H     ; Push single precision FAC1 on stack
3768H  (CDH) CALL 3543H     ; Convert signed integer HL to single precision FAC1
376BH  (C1H) POP B
376CH  (D1H) POP D
376DH  (C3H) JMP 3803H      ; Single precision multiply (FAC1=FAC1*BCDE)

3770H  (78H) MOV A,B
3771H  (B7H) ORA A
3772H  (C1H) POP B
3773H  (FAH) JM 3510H       ; Load signed integer in HL to FAC1
3776H  (D5H) PUSH D
3777H  (CDH) CALL 3543H     ; Convert signed integer HL to single precision FAC1
377AH  (D1H) POP D
377BH  (C3H) JMP 33FDH      ; Perform ABS function on FAC1


; ======================================================
; Signed integer divide (FAC1=DE/HL)
; ======================================================
377EH  (7CH) MOV A,H
377FH  (B5H) ORA L
3780H  (CAH) JZ 0449H       ; Generate /0 error
3783H  (CDH) CALL 37BAH
3786H  (C5H) PUSH B
3787H  (EBH) XCHG
3788H  (CDH) CALL 37C6H
378BH  (44H) MOV B,H
378CH  (4DH) MOV C,L
378DH  (21H) LXI H,0000H
3790H  (3EH) MVI A,11H
3792H  (F5H) PUSH PSW
3793H  (B7H) ORA A
3794H  (C3H) JMP 37A3H

3797H  (F5H) PUSH PSW
3798H  (E5H) PUSH H
3799H  (09H) DAD B
379AH  (D2H) JNC 37A2H
379DH  (F1H) POP PSW
379EH  (37H) STC
379FH  (C3H) JMP 37A3H

37A2H  (E1H) POP H
37A3H  (7BH) MOV A,E
37A4H  (17H) RAL
37A5H  (5FH) MOV E,A
37A6H  (7AH) MOV A,D
37A7H  (17H) RAL
37A8H  (57H) MOV D,A
37A9H  (7DH) MOV A,L
37AAH  (17H) RAL
37ABH  (6FH) MOV L,A
37ACH  (7CH) MOV A,H
37ADH  (17H) RAL
37AEH  (67H) MOV H,A
37AFH  (F1H) POP PSW
37B0H  (3DH) DCR A
37B1H  (C2H) JNZ 3797H
37B4H  (EBH) XCHG
37B5H  (C1H) POP B
37B6H  (D5H) PUSH D
37B7H  (C3H) JMP 374BH

37BAH  (7CH) MOV A,H
37BBH  (AAH) XRA D
37BCH  (47H) MOV B,A
37BDH  (CDH) CALL 37C1H
37C0H  (EBH) XCHG
37C1H  (7CH) MOV A,H
37C2H  (B7H) ORA A
37C3H  (F2H) JP 3510H       ; Load signed integer in HL to FAC1
37C6H  (AFH) XRA A
37C7H  (4FH) MOV C,A
37C8H  (95H) SUB L
37C9H  (6FH) MOV L,A
37CAH  (79H) MOV A,C
37CBH  (9CH) SUB H
37CCH  (67H) MOV H,A
37CDH  (C3H) JMP 3510H      ; Load signed integer in HL to FAC1

; ======================================================
; ABS function for integer FAC1
; ======================================================
37D0H  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
37D3H  (CDH) CALL 37C6H
37D6H  (7CH) MOV A,H
37D7H  (EEH) XRI 80H
37D9H  (B5H) ORA L
37DAH  (C0H) RNZ

; ======================================================
; Convert unsigned HL to single precision in FAC1
; ======================================================
37DBH  (AFH) XRA A          ; Clear A to perform unsigned comparison
37DCH  (C3H) JMP 3544H      ; Jump into Convert Signed to single precision in FAC1

37DFH  (D5H) PUSH D
37E0H  (CDH) CALL 377EH     ; Signed integer divide (FAC1=DE/HL)
37E3H  (AFH) XRA A
37E4H  (82H) ADD D
37E5H  (1FH) RAR
37E6H  (67H) MOV H,A
37E7H  (7BH) MOV A,E
37E8H  (1FH) RAR
37E9H  (6FH) MOV L,A
37EAH  (CDH) CALL 3513H
37EDH  (F1H) POP PSW
37EEH  (C3H) JMP 37C2H

37F1H  (CDH) CALL 3450H     ; Reverse load single precision at M to DEBC

; ======================================================
; Single precision addition (FAC1=FAC1+BCDE)
; ======================================================
37F4H  (CDH) CALL 3827H     ; Single precision load (FAC2=BCDE)

; ======================================================
; Single precision addition (FAC1=FAC1+FAC2)
; ======================================================
37F7H  (CDH) CALL 35C2H     ; Convert FAC1 to double precision
37FAH  (C3H) JMP 2B78H      ; Double precision addition (FAC1=FAC1+FAC2)


; ======================================================
; Single precision subtract (FAC1=FAC1-BCDE)
; ======================================================
37FDH  (CDH) CALL 33FDH     ; Perform ABS function on FAC1
3800H  (C3H) JMP 37F4H      ; Single precision addition (FAC1=FAC1+BCDE)


; ======================================================
; Single precision multiply (FAC1=FAC1*BCDE)
; ======================================================
3803H  (CDH) CALL 3827H     ; Single precision load (FAC2=BCDE)

; ======================================================
; Single precision multiply (FAC1=FAC2*FAC2)
; ======================================================
3806H  (CDH) CALL 35C2H     ; Convert FAC1 to double precision
3809H  (C3H) JMP 2CFFH      ; Double precision multiply (FAC1=FAC1*FAC2)

380CH  (C1H) POP B
380DH  (D1H) POP D

; ======================================================
; Single precision divide (FAC1=BCDE/FAC1)
; ======================================================
380EH  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
3811H  (EBH) XCHG
3812H  (22H) SHLD FC1AH     ; Start of FAC1 for integers
3815H  (C5H) PUSH B
3816H  (2AH) LHLD FC18H     ; Start of FAC1 for single and double precision
3819H  (E3H) XTHL
381AH  (22H) SHLD FC18H     ; Start of FAC1 for single and double precision
381DH  (C1H) POP B
381EH  (CDH) CALL 3827H     ; Single precision load (FAC2=BCDE)
3821H  (CDH) CALL 35C2H     ; Convert FAC11 to double precision
3824H  (C3H) JMP 2DC7H      ; Double precision divide (FAC1=FAC1/FAC2)


; ======================================================
; Single precision load (FAC2=BCDE)
; ======================================================
3827H  (EBH) XCHG
3828H  (22H) SHLD FC6BH     ; Start of FAC2 for integers
382BH  (60H) MOV H,B
382CH  (69H) MOV L,C
382DH  (22H) SHLD FC69H     ; Start of FAC2 for single and double precision
3830H  (21H) LXI H,0000H
3833H  (22H) SHLD FC6DH
3836H  (22H) SHLD FC6FH
3839H  (C9H) RET

383AH  (3DH) DCR A
383BH  (C9H) RET

383CH  (2BH) DCX H
383DH  (C9H) RET

383EH  (E1H) POP H
383FH  (C9H) RET


; ======================================================
; Convert ASCII number at M to double precision in FAC1
; ======================================================
3840H  (EBH) XCHG
3841H  (01H) LXI B,00FFH
3844H  (60H) MOV H,B
3845H  (68H) MOV L,B
3846H  (CDH) CALL 3510H     ; Load signed integer in HL to FAC1
3849H  (EBH) XCHG
384AH  (7EH) MOV A,M
384BH  (FEH) CPI 2DH
384DH  (F5H) PUSH PSW
384EH  (CAH) JZ 3857H
3851H  (FEH) CPI 2BH
3853H  (CAH) JZ 3857H
3856H  (2BH) DCX H
3857H  (D7H) RST 2          ; Get next non-white char from M
3858H  (DAH) JC 3940H       ; Convert ASCII number that starts with a Digit
385BH  (FEH) CPI 2EH
385DH  (CAH) JZ 3904H       ; Found '.' in ASCII number
3860H  (FEH) CPI 65H
3862H  (CAH) JZ 3867H       ; Found 'e' in ASCII number
3865H  (FEH) CPI 45H

; ======================================================
; Found 'e' in ASCII number
; ======================================================
3867H  (C2H) JNZ 388AH      ; Found 'E' in ASCII number
386AH  (E5H) PUSH H
386BH  (D7H) RST 2          ; Get next non-white char from M
386CH  (FEH) CPI 6CH
386EH  (CAH) JZ 387DH
3871H  (FEH) CPI 4CH
3873H  (CAH) JZ 387DH
3876H  (FEH) CPI 71H
3878H  (CAH) JZ 387DH
387BH  (FEH) CPI 51H
387DH  (E1H) POP H
387EH  (CAH) JZ 3889H
3881H  (EFH) RST 5          ; Determine type of last var used
3882H  (D2H) JNC 38A3H
3885H  (AFH) XRA A
3886H  (C3H) JMP 38A4H

3889H  (7EH) MOV A,M

; ======================================================
; Found 'E' in ASCII number
; ======================================================
388AH  (FEH) CPI 25H        ; Compare next byte with '%'
388CH  (CAH) JZ 391AH       ; Jump if found '%' in ASCII number
388FH  (FEH) CPI 23H        ; Compare next byte with '#'
3891H  (CAH) JZ 3929H       ; Jump if found '#' in ASCII number
3894H  (FEH) CPI 21H        ; Compare next byte with '!'
3896H  (CAH) JZ 392AH       ; Jump if found '!' in ASCII number
3899H  (FEH) CPI 64H        ; Compare next byte with 'd'
389BH  (CAH) JZ 38A3H
389EH  (FEH) CPI 44H        ; Compare next byte with 'D'
38A0H  (C2H) JNZ 38D1H
38A3H  (B7H) ORA A
38A4H  (CDH) CALL 3931H     ; Deal with single & double precision ASCII conversions
38A7H  (D7H) RST 2          ; Get next non-white char from M
38A8H  (D5H) PUSH D
38A9H  (16H) MVI D,00H
38ABH  (CDH) CALL 1037H     ; ASCII num conversion - find ASCII or tokenized '+' or '-' in A
38AEH  (4AH) MOV C,D
38AFH  (D1H) POP D
38B0H  (D7H) RST 2          ; Get next non-white char from M
38B1H  (D2H) JNC 38CAH
38B4H  (7BH) MOV A,E
38B5H  (FEH) CPI 0CH
38B7H  (D2H) JNC 38C5H
38BAH  (07H) RLC
38BBH  (07H) RLC
38BCH  (83H) ADD E
38BDH  (07H) RLC
38BEH  (86H) ADD M
38BFH  (D6H) SUI 30H
38C1H  (5FH) MOV E,A
38C2H  (C3H) JMP 38B0H

38C5H  (1EH) MVI E,80H
38C7H  (C3H) JMP 38B0H

38CAH  (0CH) INR C
38CBH  (C2H) JNZ 38D1H
38CEH  (AFH) XRA A
38CFH  (93H) SUB E
38D0H  (5FH) MOV E,A

38D1H  (EFH) RST 5          ; Determine type of last var used
38D2H  (FAH) JM 38E8H       ; Skip ahead if last var type was integer
38D5H  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
38D8H  (B7H) ORA A          ; Test if FAC1 is zero
38D9H  (CAH) JZ 38E8H       ; Skip ahead if FAC1 is zero
38DCH  (7AH) MOV A,D
38DDH  (90H) SUB B
38DEH  (83H) ADD E
38DFH  (C6H) ADI 40H
38E1H  (32H) STA FC18H      ; Start of FAC1 for single and double precision
38E4H  (B7H) ORA A
38E5H  (FCH) CM 3901H

38E8H  (F1H) POP PSW
38E9H  (E5H) PUSH H
38EAH  (CCH) CZ 33F6H
38EDH  (EFH) RST 5          ; Determine type of last var used
38EEH  (D2H) JNC 38FCH
38F1H  (E1H) POP H
38F2H  (E8H) RPE
38F3H  (E5H) PUSH H
38F4H  (21H) LXI H,383EH
38F7H  (E5H) PUSH H
38F8H  (CDH) CALL 3519H
38FBH  (C9H) RET

38FCH  (CDH) CALL 2C27H
38FFH  (E1H) POP H
3900H  (C9H) RET

3901H  (C3H) JMP 0455H      ; Generate OV error

; ======================================================
; Found '.' in ASCII number
; ======================================================
3904H  (EFH) RST 5          ; Determine type of last var used
3905H  (0CH) INR C
3906H  (C2H) JNZ 38D1H
3909H  (D2H) JNC 3917H
390CH  (CDH) CALL 3931H     ; Deal with single & double precision ASCII conversions
390FH  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
3912H  (B7H) ORA A
3913H  (C2H) JNZ 3917H
3916H  (57H) MOV D,A
3917H  (C3H) JMP 3857H

; ======================================================
; Found '%' in ASCII number - Integer number
; ======================================================
391AH  (D7H) RST 2          ; Get next non-white char from M
391BH  (F1H) POP PSW
391CH  (E5H) PUSH H
391DH  (21H) LXI H,383EH
3920H  (E5H) PUSH H
3921H  (21H) LXI H,3501H    ; Load address of CINT function
3924H  (E5H) PUSH H         ; Push new return address to stack
3925H  (F5H) PUSH PSW
3926H  (C3H) JMP 38D1H

; ======================================================
; Found '#' in ASCII number - double precision
; ======================================================
3929H  (B7H) ORA A          ; Clear Z flag to denote double precision

; ======================================================
; Found '!' in ASCII number - single precision
; ======================================================
392AH  (CDH) CALL 3931H     ; Deal with single & double precision ASCII conversions
392DH  (D7H) RST 2          ; Get next non-white char from M
392EH  (C3H) JMP 38D1H

; ======================================================
; Deal with single & double precision ASCII conversions
;
; Input:  Z:  Set if Single precision
;             Clear if Double precision
; ======================================================
3931H  (E5H) PUSH H         ; Preserve HL on stack
3932H  (D5H) PUSH D         ; Preserve DE on stack
3933H  (C5H) PUSH B         ; Preserve BC on stack
3934H  (F5H) PUSH PSW       ; Save flags on stack
3935H  (CCH) CZ 352AH       ; If Z set, convert to single precision - CSNG function
3938H  (F1H) POP PSW        ; Restore flags
3939H  (C4H) CNZ 35BAH      ; If Z clear, convert to double precision - CDBL function
393CH  (C1H) POP B          ; Restore BC
393DH  (D1H) POP D          ; Restore DE
393EH  (E1H) POP H          ; Restore HL
393FH  (C9H) RET

; ======================================================
; Convert ASCII number that starts with a Digit
; ======================================================
3940H  (D6H) SUI 30H
3942H  (C2H) JNZ 394DH
3945H  (B1H) ORA C
3946H  (CAH) JZ 394DH
3949H  (A2H) ANA D
394AH  (CAH) JZ 3857H
394DH  (14H) INR D
394EH  (7AH) MOV A,D
394FH  (FEH) CPI 07H
3951H  (C2H) JNZ 3958H
3954H  (B7H) ORA A
3955H  (CDH) CALL 3931H     ; Deal with single & double precision ASCII conversions
3958H  (D5H) PUSH D
3959H  (78H) MOV A,B
395AH  (81H) ADD C
395BH  (3CH) INR A
395CH  (47H) MOV B,A
395DH  (C5H) PUSH B
395EH  (E5H) PUSH H
395FH  (7EH) MOV A,M
3960H  (D6H) SUI 30H
3962H  (F5H) PUSH PSW
3963H  (EFH) RST 5          ; Determine type of last var used
3964H  (F2H) JP 398DH
3967H  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
396AH  (11H) LXI D,0CCDH
396DH  (DFH) RST 3          ; Compare DE and HL
396EH  (D2H) JNC 398AH
3971H  (54H) MOV D,H
3972H  (5DH) MOV E,L
3973H  (29H) DAD H
3974H  (29H) DAD H
3975H  (19H) DAD D
3976H  (29H) DAD H
3977H  (F1H) POP PSW
3978H  (4FH) MOV C,A
3979H  (09H) DAD B
397AH  (7CH) MOV A,H
397BH  (B7H) ORA A
397CH  (FAH) JM 3988H
397FH  (22H) SHLD FC1AH     ; Start of FAC1 for integers
3982H  (E1H) POP H
3983H  (C1H) POP B
3984H  (D1H) POP D
3985H  (C3H) JMP 3857H

3988H  (79H) MOV A,C
3989H  (F5H) PUSH PSW
398AH  (CDH) CALL 3540H     ; Convert signed integer in FAC1 to single precision
398DH  (F1H) POP PSW
398EH  (E1H) POP H
398FH  (C1H) POP B
3990H  (D1H) POP D
3991H  (C2H) JNZ 39A1H
3994H  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
3997H  (B7H) ORA A
3998H  (3EH) MVI A,00H
399AH  (C2H) JNZ 39A1H
399DH  (57H) MOV D,A
399EH  (C3H) JMP 3857H

39A1H  (D5H) PUSH D
39A2H  (C5H) PUSH B
39A3H  (E5H) PUSH H
39A4H  (F5H) PUSH PSW
39A5H  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision
39A8H  (36H) MVI M,01H
39AAH  (7AH) MOV A,D
39ABH  (FEH) CPI 10H
39ADH  (DAH) JC 39B4H
39B0H  (F1H) POP PSW
39B1H  (C3H) JMP 3982H

39B4H  (3CH) INR A
39B5H  (B7H) ORA A
39B6H  (1FH) RAR
39B7H  (06H) MVI B,00H
39B9H  (4FH) MOV C,A
39BAH  (09H) DAD B
39BBH  (F1H) POP PSW
39BCH  (4FH) MOV C,A
39BDH  (7AH) MOV A,D
39BEH  (1FH) RAR
39BFH  (79H) MOV A,C
39C0H  (D2H) JNC 39C7H
39C3H  (87H) ADD A
39C4H  (87H) ADD A
39C5H  (87H) ADD A
39C6H  (87H) ADD A
39C7H  (B6H) ORA M
39C8H  (77H) MOV M,A
39C9H  (C3H) JMP 3982H

; ======================================================
; Finish printing BASIC ERROR message " in " line #
; ======================================================
39CCH  (E5H) PUSH H         ; Preserve line number in HL on stack
39CDH  (21H) LXI H,03F1H    ; Load pointer to " in " text
39D0H  (CDH) CALL 27B1H     ; Print buffer at M until NULL or '"'
39D3H  (E1H) POP H          ; Restore line number to HL

; ======================================================
; Print binary number in HL at current position
; ======================================================
39D4H  (01H) LXI B,27B0H    ; Load address of Print buffer at M-1 until NULL or '"'
39D7H  (C5H) PUSH B
39D8H  (CDH) CALL 3510H     ; Load signed integer in HL to FAC1
39DBH  (AFH) XRA A
39DCH  (32H) STA FB8EH
39DFH  (21H) LXI H,FBE8H
39E2H  (36H) MVI M,20H
39E4H  (B6H) ORA M
39E5H  (C3H) JMP 3A05H

; ======================================================
; Convert binary number in FAC1 to ASCII at M
; ======================================================
39E8H  (AFH) XRA A
39E9H  (CDH) CALL 3D11H     ; Initialize FAC1 with 0.0 if it has no value

; ======================================================
; Convert binary number in FAC1 to ASCII at M with format
; ======================================================
39ECH  (E6H) ANI 08H
39EEH  (CAH) JZ 39F3H
39F1H  (36H) MVI M,2BH
39F3H  (EBH) XCHG
39F4H  (CDH) CALL 3411H     ; Determine sign of last variable used
39F7H  (EBH) XCHG
39F8H  (F2H) JP 3A05H
39FBH  (36H) MVI M,2DH
39FDH  (C5H) PUSH B
39FEH  (E5H) PUSH H
39FFH  (CDH) CALL 33F6H
3A02H  (E1H) POP H
3A03H  (C1H) POP B
3A04H  (B4H) ORA H
3A05H  (23H) INX H
3A06H  (36H) MVI M,30H
3A08H  (3AH) LDA FB8EH
3A0BH  (57H) MOV D,A
3A0CH  (17H) RAL
3A0DH  (3AH) LDA FB65H      ; Type of last variable used
3A10H  (DAH) JC 3ACAH
3A13H  (CAH) JZ 3AC2H
3A16H  (FEH) CPI 04H        ; Test if last variable type is Double Precision?
3A18H  (D2H) JNC 3A6FH
3A1BH  (01H) LXI B,0000H
3A1EH  (CDH) CALL 3CC3H
3A21H  (21H) LXI H,FBE8H
3A24H  (46H) MOV B,M
3A25H  (0EH) MVI C,20H
3A27H  (3AH) LDA FB8EH
3A2AH  (5FH) MOV E,A
3A2BH  (E6H) ANI 20H
3A2DH  (CAH) JZ 3A3EH
3A30H  (78H) MOV A,B
3A31H  (B9H) CMP C
3A32H  (0EH) MVI C,2AH
3A34H  (C2H) JNZ 3A3EH
3A37H  (7BH) MOV A,E
3A38H  (E6H) ANI 04H
3A3AH  (C2H) JNZ 3A3EH
3A3DH  (41H) MOV B,C
3A3EH  (71H) MOV M,C
3A3FH  (D7H) RST 2          ; Get next non-white char from M
3A40H  (CAH) JZ 3A5CH
3A43H  (FEH) CPI 45H
3A45H  (CAH) JZ 3A5CH
3A48H  (FEH) CPI 44H
3A4AH  (CAH) JZ 3A5CH
3A4DH  (FEH) CPI 30H
3A4FH  (CAH) JZ 3A3EH
3A52H  (FEH) CPI 2CH
3A54H  (CAH) JZ 3A3EH
3A57H  (FEH) CPI 2EH
3A59H  (C2H) JNZ 3A5FH
3A5CH  (2BH) DCX H
3A5DH  (36H) MVI M,30H
3A5FH  (7BH) MOV A,E
3A60H  (E6H) ANI 10H
3A62H  (CAH) JZ 3A68H
3A65H  (2BH) DCX H
3A66H  (36H) MVI M,24H
3A68H  (7BH) MOV A,E
3A69H  (E6H) ANI 04H
3A6BH  (C0H) RNZ
3A6CH  (2BH) DCX H
3A6DH  (70H) MOV M,B
3A6EH  (C9H) RET

3A6FH  (E5H) PUSH H
3A70H  (CDH) CALL 3D04H
3A73H  (50H) MOV D,B
3A74H  (14H) INR D
3A75H  (01H) LXI B,0300H
3A78H  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
3A7BH  (D6H) SUI 3FH
3A7DH  (DAH) JC 3A89H
3A80H  (14H) INR D
3A81H  (BAH) CMP D
3A82H  (D2H) JNC 3A89H
3A85H  (3CH) INR A
3A86H  (47H) MOV B,A
3A87H  (3EH) MVI A,02H
3A89H  (D6H) SUI 02H
3A8BH  (E1H) POP H
3A8CH  (F5H) PUSH PSW
3A8DH  (CDH) CALL 3C70H
3A90H  (36H) MVI M,30H
3A92H  (CCH) CZ 3457H      ; Increment HL and return
3A95H  (CDH) CALL 3C97H
3A98H  (2BH) DCX H
3A99H  (7EH) MOV A,M
3A9AH  (FEH) CPI 30H
3A9CH  (CAH) JZ 3A98H
3A9FH  (FEH) CPI 2EH
3AA1H  (C4H) CNZ 3457H      ; Increment HL and return
3AA4H  (F1H) POP PSW
3AA5H  (CAH) JZ 3AC3H
3AA8H  (36H) MVI M,45H
3AAAH  (23H) INX H
3AABH  (36H) MVI M,2BH
3AADH  (F2H) JP 3AB4H
3AB0H  (36H) MVI M,2DH
3AB2H  (2FH) CMA
3AB3H  (3CH) INR A
3AB4H  (06H) MVI B,2FH
3AB6H  (04H) INR B
3AB7H  (D6H) SUI 0AH
3AB9H  (D2H) JNC 3AB6H
3ABCH  (C6H) ADI 3AH
3ABEH  (23H) INX H
3ABFH  (70H) MOV M,B
3AC0H  (23H) INX H
3AC1H  (77H) MOV M,A
3AC2H  (23H) INX H
3AC3H  (36H) MVI M,00H
3AC5H  (EBH) XCHG
3AC6H  (21H) LXI H,FBE8H
3AC9H  (C9H) RET

3ACAH  (23H) INX H
3ACBH  (C5H) PUSH B
3ACCH  (FEH) CPI 04H
3ACEH  (7AH) MOV A,D
3ACFH  (D2H) JNC 3B42H
3AD2H  (1FH) RAR
3AD3H  (DAH) JC 3BCCH
3AD6H  (01H) LXI B,0603H
3AD9H  (CDH) CALL 3C68H
3ADCH  (D1H) POP D
3ADDH  (7AH) MOV A,D
3ADEH  (D6H) SUI 05H
3AE0H  (F4H) CP 3C44H
3AE3H  (CDH) CALL 3CC3H
3AE6H  (7BH) MOV A,E
3AE7H  (B7H) ORA A
3AE8H  (CCH) CZ 383CH
3AEBH  (3DH) DCR A
3AECH  (F4H) CP 3C44H
3AEFH  (E5H) PUSH H
3AF0H  (CDH) CALL 3A21H
3AF3H  (E1H) POP H
3AF4H  (CAH) JZ 3AF9H
3AF7H  (70H) MOV M,B
3AF8H  (23H) INX H
3AF9H  (36H) MVI M,00H
3AFBH  (21H) LXI H,FBE7H    ; Floating Point Temp 1
3AFEH  (23H) INX H
3AFFH  (3AH) LDA FBA8H
3B02H  (95H) SUB L
3B03H  (92H) SUB D
3B04H  (C8H) RZ
3B05H  (7EH) MOV A,M
3B06H  (FEH) CPI 20H
3B08H  (CAH) JZ 3AFEH
3B0BH  (FEH) CPI 2AH
3B0DH  (CAH) JZ 3AFEH
3B10H  (2BH) DCX H
3B11H  (E5H) PUSH H
3B12H  (F5H) PUSH PSW
3B13H  (01H) LXI B,3B12H
3B16H  (C5H) PUSH B
3B17H  (D7H) RST 2          ; Get next non-white char from M
3B18H  (FEH) CPI 2DH
3B1AH  (C8H) RZ
3B1BH  (FEH) CPI 2BH
3B1DH  (C8H) RZ
3B1EH  (FEH) CPI 24H
3B20H  (C8H) RZ
3B21H  (C1H) POP B
3B22H  (FEH) CPI 30H
3B24H  (C2H) JNZ 3B3AH
3B27H  (23H) INX H
3B28H  (D7H) RST 2          ; Get next non-white char from M
3B29H  (D2H) JNC 3B3AH
3B2CH  (2BH) DCX H
3B2DH  (C3H) JMP 3B32H

3B30H  (2BH) DCX H
3B31H  (77H) MOV M,A
3B32H  (F1H) POP PSW
3B33H  (CAH) JZ 3B30H
3B36H  (C1H) POP B
3B37H  (C3H) JMP 3AFFH

3B3AH  (F1H) POP PSW
3B3BH  (CAH) JZ 3B3AH
3B3EH  (E1H) POP H
3B3FH  (36H) MVI M,25H
3B41H  (C9H) RET

3B42H  (E5H) PUSH H
3B43H  (1FH) RAR
3B44H  (DAH) JC 3BD2H
3B47H  (CDH) CALL 3D04H
3B4AH  (50H) MOV D,B
3B4BH  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
3B4EH  (D6H) SUI 4FH
3B50H  (DAH) JC 3B5EH
3B53H  (E1H) POP H
3B54H  (C1H) POP B
3B55H  (CDH) CALL 39E8H     ; Convert binary number in FAC1 to ASCII at M
3B58H  (21H) LXI H,FBE7H    ; Floating Point Temp 1
3B5BH  (36H) MVI M,25H
3B5DH  (C9H) RET

3B5EH  (F7H) RST 6          ; Get sign of FAC1
3B5FH  (C4H) CNZ 3D55H
3B62H  (E1H) POP H
3B63H  (C1H) POP B
3B64H  (FAH) JM 3B81H
3B67H  (C5H) PUSH B
3B68H  (5FH) MOV E,A
3B69H  (78H) MOV A,B
3B6AH  (92H) SUB D
3B6BH  (93H) SUB E
3B6CH  (F4H) CP 3C44H
3B6FH  (CDH) CALL 3C5BH
3B72H  (CDH) CALL 3C97H
3B75H  (B3H) ORA E
3B76H  (C4H) CNZ 3C54H
3B79H  (B3H) ORA E
3B7AH  (C4H) CNZ 3C83H
3B7DH  (D1H) POP D
3B7EH  (C3H) JMP 3AE6H

3B81H  (5FH) MOV E,A
3B82H  (79H) MOV A,C
3B83H  (B7H) ORA A
3B84H  (C4H) CNZ 383AH
3B87H  (83H) ADD E
3B88H  (FAH) JM 3B8CH
3B8BH  (AFH) XRA A
3B8CH  (C5H) PUSH B
3B8DH  (F5H) PUSH PSW
3B8EH  (FCH) CM 3D2DH
3B91H  (C1H) POP B
3B92H  (7BH) MOV A,E
3B93H  (90H) SUB B
3B94H  (C1H) POP B
3B95H  (5FH) MOV E,A
3B96H  (82H) ADD D
3B97H  (78H) MOV A,B
3B98H  (FAH) JM 3BA7H
3B9BH  (92H) SUB D
3B9CH  (93H) SUB E
3B9DH  (F4H) CP 3C44H
3BA0H  (C5H) PUSH B
3BA1H  (CDH) CALL 3C5BH
3BA4H  (C3H) JMP 3BB8H

3BA7H  (CDH) CALL 3C44H
3BAAH  (79H) MOV A,C
3BABH  (CDH) CALL 3C87H
3BAEH  (4FH) MOV C,A
3BAFH  (AFH) XRA A
3BB0H  (92H) SUB D
3BB1H  (93H) SUB E
3BB2H  (CDH) CALL 3C44H
3BB5H  (C5H) PUSH B
3BB6H  (47H) MOV B,A
3BB7H  (4FH) MOV C,A
3BB8H  (CDH) CALL 3C97H
3BBBH  (C1H) POP B
3BBCH  (B1H) ORA C
3BBDH  (C2H) JNZ 3BC3H
3BC0H  (2AH) LHLD FBA8H
3BC3H  (83H) ADD E
3BC4H  (3DH) DCR A
3BC5H  (F4H) CP 3C44H
3BC8H  (50H) MOV D,B
3BC9H  (C3H) JMP 3AEFH

3BCCH  (E5H) PUSH H
3BCDH  (D5H) PUSH D
3BCEH  (CDH) CALL 3540H     ; Convert signed integer in FAC1 to single precision
3BD1H  (D1H) POP D
3BD2H  (CDH) CALL 3D04H
3BD5H  (58H) MOV E,B
3BD6H  (F7H) RST 6          ; Get sign of FAC1
3BD7H  (F5H) PUSH PSW
3BD8H  (C4H) CNZ 3D55H
3BDBH  (F1H) POP PSW
3BDCH  (E1H) POP H
3BDDH  (C1H) POP B
3BDEH  (F5H) PUSH PSW
3BDFH  (79H) MOV A,C
3BE0H  (B7H) ORA A
3BE1H  (F5H) PUSH PSW
3BE2H  (C4H) CNZ 383AH
3BE5H  (80H) ADD B
3BE6H  (4FH) MOV C,A
3BE7H  (7AH) MOV A,D
3BE8H  (E6H) ANI 04H
3BEAH  (FEH) CPI 01H
3BECH  (9FH) SBB A
3BEDH  (57H) MOV D,A
3BEEH  (81H) ADD C
3BEFH  (4FH) MOV C,A
3BF0H  (93H) SUB E
3BF1H  (F5H) PUSH PSW
3BF2H  (F2H) JP 3C04H
3BF5H  (CDH) CALL 3D2DH
3BF8H  (C2H) JNZ 3C04H
3BFBH  (E5H) PUSH H
3BFCH  (CDH) CALL 2CF2H
3BFFH  (21H) LXI H,FC18H    ; Start of FAC1 for single and double precision
3C02H  (34H) INR M
3C03H  (E1H) POP H
3C04H  (F1H) POP PSW
3C05H  (C5H) PUSH B
3C06H  (F5H) PUSH PSW
3C07H  (FAH) JM 3C0BH
3C0AH  (AFH) XRA A
3C0BH  (2FH) CMA
3C0CH  (3CH) INR A
3C0DH  (80H) ADD B
3C0EH  (3CH) INR A
3C0FH  (82H) ADD D
3C10H  (47H) MOV B,A
3C11H  (0EH) MVI C,00H
3C13H  (CCH) CZ 3C70H
3C16H  (CDH) CALL 3C97H
3C19H  (F1H) POP PSW
3C1AH  (F4H) CP 3C4DH
3C1DH  (CDH) CALL 3C83H
3C20H  (C1H) POP B
3C21H  (F1H) POP PSW
3C22H  (C2H) JNZ 3C31H
3C25H  (CDH) CALL 383CH
3C28H  (7EH) MOV A,M
3C29H  (FEH) CPI 2EH
3C2BH  (C4H) CNZ 3457H      ; Increment HL and return
3C2EH  (22H) SHLD FBA8H
3C31H  (F1H) POP PSW
3C32H  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
3C35H  (CAH) JZ 3C3BH
3C38H  (83H) ADD E
3C39H  (90H) SUB B
3C3AH  (92H) SUB D
3C3BH  (C5H) PUSH B
3C3CH  (CDH) CALL 3AA8H
3C3FH  (EBH) XCHG
3C40H  (D1H) POP D
3C41H  (C3H) JMP 3AEFH

3C44H  (B7H) ORA A
3C45H  (C8H) RZ
3C46H  (3DH) DCR A
3C47H  (36H) MVI M,30H
3C49H  (23H) INX H
3C4AH  (C3H) JMP 3C45H

3C4DH  (C2H) JNZ 3C54H
3C50H  (C8H) RZ
3C51H  (CDH) CALL 3C83H
3C54H  (36H) MVI M,30H
3C56H  (23H) INX H
3C57H  (3DH) DCR A
3C58H  (C3H) JMP 3C50H

3C5BH  (7BH) MOV A,E
3C5CH  (82H) ADD D
3C5DH  (3CH) INR A
3C5EH  (47H) MOV B,A
3C5FH  (3CH) INR A
3C60H  (D6H) SUI 03H
3C62H  (D2H) JNC 3C60H
3C65H  (C6H) ADI 05H
3C67H  (4FH) MOV C,A
3C68H  (3AH) LDA FB8EH
3C6BH  (E6H) ANI 40H
3C6DH  (C0H) RNZ
3C6EH  (4FH) MOV C,A
3C6FH  (C9H) RET

3C70H  (05H) DCR B
3C71H  (F2H) JP 3C84H
3C74H  (22H) SHLD FBA8H
3C77H  (36H) MVI M,2EH
3C79H  (23H) INX H
3C7AH  (36H) MVI M,30H
3C7CH  (04H) INR B
3C7DH  (48H) MOV C,B
3C7EH  (C2H) JNZ 3C79H
3C81H  (23H) INX H
3C82H  (C9H) RET

3C83H  (05H) DCR B
3C84H  (C2H) JNZ 3C8FH
3C87H  (36H) MVI M,2EH
3C89H  (22H) SHLD FBA8H
3C8CH  (23H) INX H
3C8DH  (48H) MOV C,B
3C8EH  (C9H) RET

3C8FH  (0DH) DCR C
3C90H  (C0H) RNZ
3C91H  (36H) MVI M,2CH
3C93H  (23H) INX H
3C94H  (0EH) MVI C,03H
3C96H  (C9H) RET

3C97H  (D5H) PUSH D
3C98H  (E5H) PUSH H
3C99H  (C5H) PUSH B
3C9AH  (CDH) CALL 3D04H
3C9DH  (78H) MOV A,B
3C9EH  (C1H) POP B
3C9FH  (E1H) POP H
3CA0H  (11H) LXI D,FC19H    ; Point to BCD portion of FAC1
3CA3H  (37H) STC
3CA4H  (F5H) PUSH PSW
3CA5H  (CDH) CALL 3C83H
3CA8H  (1AH) LDAX D
3CA9H  (D2H) JNC 3CB3H
3CACH  (1FH) RAR
3CADH  (1FH) RAR
3CAEH  (1FH) RAR
3CAFH  (1FH) RAR
3CB0H  (C3H) JMP 3CB4H

3CB3H  (13H) INX D
3CB4H  (E6H) ANI 0FH
3CB6H  (C6H) ADI 30H
3CB8H  (77H) MOV M,A
3CB9H  (23H) INX H
3CBAH  (F1H) POP PSW
3CBBH  (3DH) DCR A
3CBCH  (3FH) CMC
3CBDH  (C2H) JNZ 3CA4H
3CC0H  (C3H) JMP 3CF4H

3CC3H  (D5H) PUSH D
3CC4H  (11H) LXI D,3CFAH
3CC7H  (3EH) MVI A,05H
3CC9H  (CDH) CALL 3C83H
3CCCH  (C5H) PUSH B
3CCDH  (F5H) PUSH PSW
3CCEH  (E5H) PUSH H
3CCFH  (EBH) XCHG
3CD0H  (4EH) MOV C,M
3CD1H  (23H) INX H
3CD2H  (46H) MOV B,M
3CD3H  (C5H) PUSH B
3CD4H  (23H) INX H
3CD5H  (E3H) XTHL
3CD6H  (EBH) XCHG
3CD7H  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
3CDAH  (06H) MVI B,2FH
3CDCH  (04H) INR B
3CDDH  (7DH) MOV A,L
3CDEH  (93H) SUB E
3CDFH  (6FH) MOV L,A
3CE0H  (7CH) MOV A,H
3CE1H  (9AH) SBB D
3CE2H  (67H) MOV H,A
3CE3H  (D2H) JNC 3CDCH
3CE6H  (19H) DAD D
3CE7H  (22H) SHLD FC1AH     ; Start of FAC1 for integers
3CEAH  (D1H) POP D
3CEBH  (E1H) POP H
3CECH  (70H) MOV M,B
3CEDH  (23H) INX H
3CEEH  (F1H) POP PSW
3CEFH  (C1H) POP B
3CF0H  (3DH) DCR A
3CF1H  (C2H) JNZ 3CC9H
3CF4H  (CDH) CALL 3C83H
3CF7H  (77H) MOV M,A
3CF8H  (D1H) POP D
3CF9H  (C9H) RET

3CFAH  (10H) ASHR
3CFBH  (27H) DAA
3CFCH  (E8H) RPE
3CFDH  (03H) INX B
3CFEH  (64H) MOV H,H
3CFFH  (00H) NOP
3D00H  (0AH) LDAX B
3D01H  (00H) NOP
3D02H  (01H) LXI B,EF00H
3D05H  (21H) LXI H,FC1FH     ; Point to end of FAC1
3D08H  (06H) MVI B,0EH
3D0AH  (D0H) RNC
3D0BH  (21H) LXI H,FC1BH
3D0EH  (06H) MVI B,06H
3D10H  (C9H) RET

; ======================================================
; Initialize FAC1 with 0.0 if it has no value
; ======================================================
3D11H  (32H) STA FB8EH
3D14H  (F5H) PUSH PSW
3D15H  (C5H) PUSH B
3D16H  (D5H) PUSH D
3D17H  (CDH) CALL 35BAH     ; CDBL function
3D1AH  (21H) LXI H,327EH
3D1DH  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
3D20H  (A7H) ANA A
3D21H  (CCH) CZ 31C4H       ; Move floating point number M to FAC1
3D24H  (D1H) POP D
3D25H  (C1H) POP B
3D26H  (F1H) POP PSW
3D27H  (21H) LXI H,FBE8H
3D2AH  (36H) MVI M,20H
3D2CH  (C9H) RET

3D2DH  (E5H) PUSH H
3D2EH  (D5H) PUSH D
3D2FH  (C5H) PUSH B
3D30H  (F5H) PUSH PSW
3D31H  (2FH) CMA
3D32H  (3CH) INR A
3D33H  (5FH) MOV E,A
3D34H  (3EH) MVI A,01H
3D36H  (CAH) JZ 3D4FH
3D39H  (CDH) CALL 3D04H
3D3CH  (E5H) PUSH H
3D3DH  (CDH) CALL 2CF2H
3D40H  (1DH) DCR E
3D41H  (C2H) JNZ 3D3DH
3D44H  (E1H) POP H
3D45H  (23H) INX H
3D46H  (78H) MOV A,B
3D47H  (0FH) RRC
3D48H  (47H) MOV B,A
3D49H  (CDH) CALL 2C2CH
3D4CH  (CDH) CALL 3D67H
3D4FH  (C1H) POP B
3D50H  (80H) ADD B
3D51H  (C1H) POP B
3D52H  (D1H) POP D
3D53H  (E1H) POP H
3D54H  (C9H) RET

3D55H  (C5H) PUSH B
3D56H  (E5H) PUSH H
3D57H  (CDH) CALL 3D04H
3D5AH  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
3D5DH  (D6H) SUI 40H
3D5FH  (90H) SUB B
3D60H  (32H) STA FC18H      ; Start of FAC1 for single and double precision
3D63H  (E1H) POP H
3D64H  (C1H) POP B
3D65H  (B7H) ORA A
3D66H  (C9H) RET

3D67H  (C5H) PUSH B
3D68H  (CDH) CALL 3D04H
3D6BH  (7EH) MOV A,M
3D6CH  (E6H) ANI 0FH
3D6EH  (C2H) JNZ 3D7CH
3D71H  (05H) DCR B
3D72H  (7EH) MOV A,M
3D73H  (B7H) ORA A
3D74H  (C2H) JNZ 3D7CH
3D77H  (2BH) DCX H
3D78H  (05H) DCR B
3D79H  (C2H) JNZ 3D6BH
3D7CH  (78H) MOV A,B
3D7DH  (C1H) POP B
3D7EH  (C9H) RET

; ======================================================
; Single precision exponential function
; ======================================================
3D7FH  (CDH) CALL 3827H     ; Single precision load (FAC2=BCDE)
3D82H  (CDH) CALL 35C2H     ; Convert FAC11 to double precision
3D85H  (CDH) CALL 322EH     ; Push FAC2 on stack
3D88H  (CDH) CALL 31D2H     ; Swap FAC1 with Floating Point number on stack
3D8BH  (CDH) CALL 3245H     ; Pop FAC2 from stack

; ======================================================
; Double precision exponential function
; ======================================================
3D8EH  (3AH) LDA FC69H      ; Start of FAC2 for single and double precision
3D91H  (B7H) ORA A
3D92H  (CAH) JZ 3DFCH
3D95H  (67H) MOV H,A
3D96H  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
3D99H  (B7H) ORA A
3D9AH  (CAH) JZ 3E07H
3D9DH  (CDH) CALL 3234H     ; Push FAC1 on stack
3DA0H  (CDH) CALL 3EDCH
3DA3H  (DAH) JC 3DE2H
3DA6H  (EBH) XCHG
3DA7H  (22H) SHLD FB90H
3DAAH  (CDH) CALL 35CFH     ; Set type of last variable to DBL
3DADH  (CDH) CALL 3245H     ; Pop FAC2 from stack
3DB0H  (CDH) CALL 3EDCH
3DB3H  (CDH) CALL 35CFH     ; Set type of last variable to DBL
3DB6H  (2AH) LHLD FB90H
3DB9H  (D2H) JNC 3E15H
3DBCH  (3AH) LDA FC69H      ; Start of FAC2 for single and double precision
3DBFH  (F5H) PUSH PSW
3DC0H  (E5H) PUSH H
3DC1H  (CDH) CALL 31C1H     ; Move FAC2 to FAC1
3DC4H  (21H) LXI H,FBE7H    ; Floating Point Temp 1
3DC7H  (CDH) CALL 31CAH     ; Move FAC1 to M
3DCAH  (21H) LXI H,3286H    ; Load pointer to FP 1.000000000
3DCDH  (CDH) CALL 31C4H     ; Move floating point number M to FAC1
3DD0H  (E1H) POP H
3DD1H  (7CH) MOV A,H
3DD2H  (B7H) ORA A
3DD3H  (F5H) PUSH PSW
3DD4H  (F2H) JP 3DDEH
3DD7H  (AFH) XRA A
3DD8H  (4FH) MOV C,A
3DD9H  (95H) SUB L
3DDAH  (6FH) MOV L,A
3DDBH  (79H) MOV A,C
3DDCH  (9CH) SUB H
3DDDH  (67H) MOV H,A
3DDEH  (E5H) PUSH H
3DDFH  (C3H) JMP 3E53H

3DE2H  (CDH) CALL 35CFH     ; Set type of last variable to DBL
3DE5H  (CDH) CALL 31C1H     ; Move FAC2 to FAC1
3DE8H  (CDH) CALL 31D2H     ; Swap FAC1 with Floating Point number on stack
3DEBH  (CDH) CALL 2FCFH     ; LOG function
3DEEH  (CDH) CALL 3245H     ; Pop FAC2 from stack
3DF1H  (CDH) CALL 2CFFH     ; Double precision multiply (FAC1=FAC1*FAC2)
3DF4H  (C3H) JMP 30A4H      ; EXP function

; ======================================================
; Integer exponential function
; ======================================================
3DF7H  (7CH) MOV A,H        ; Prepare to test for zero
3DF8H  (B5H) ORA L          ; OR in LSB to test for zero
3DF9H  (C2H) JNZ 3E02H      ; Jump if not zero to calc exp
3DFCH  (21H) LXI H,0001H    ; 
3DFFH  (C3H) JMP 3E12H

3E02H  (7AH) MOV A,D
3E03H  (B3H) ORA E
3E04H  (C2H) JNZ 3E15H
3E07H  (7CH) MOV A,H
3E08H  (17H) RAL
3E09H  (D2H) JNC 3E0FH
3E0CH  (C3H) JMP 0449H      ; Generate /0 error

3E0FH  (21H) LXI H,0000H
3E12H  (C3H) JMP 3510H      ; Load signed integer in HL to FAC1

3E15H  (22H) SHLD FB90H
3E18H  (D5H) PUSH D
3E19H  (7CH) MOV A,H
3E1AH  (B7H) ORA A
3E1BH  (F5H) PUSH PSW
3E1CH  (FCH) CM 37C6H
3E1FH  (44H) MOV B,H
3E20H  (4DH) MOV C,L
3E21H  (21H) LXI H,0001H
3E24H  (B7H) ORA A
3E25H  (78H) MOV A,B
3E26H  (1FH) RAR
3E27H  (47H) MOV B,A
3E28H  (79H) MOV A,C
3E29H  (1FH) RAR
3E2AH  (4FH) MOV C,A
3E2BH  (D2H) JNC 3E34H
3E2EH  (CDH) CALL 3ECFH
3E31H  (C2H) JNZ 3E85H
3E34H  (78H) MOV A,B
3E35H  (B1H) ORA C
3E36H  (CAH) JZ 3E9EH
3E39H  (E5H) PUSH H
3E3AH  (62H) MOV H,D
3E3BH  (6BH) MOV L,E
3E3CH  (CDH) CALL 3ECFH
3E3FH  (EBH) XCHG
3E40H  (E1H) POP H
3E41H  (CAH) JZ 3E24H
3E44H  (C5H) PUSH B
3E45H  (E5H) PUSH H
3E46H  (21H) LXI H,FBE7H    ; Floating Point Temp 1
3E49H  (CDH) CALL 31CAH     ; Move FAC1 to M
3E4CH  (E1H) POP H
3E4DH  (CDH) CALL 3543H     ; Convert signed integer HL to single precision FAC1
3E50H  (CDH) CALL 35C2H     ; Convert FAC11 to double precision
3E53H  (C1H) POP B
3E54H  (78H) MOV A,B
3E55H  (B7H) ORA A
3E56H  (1FH) RAR
3E57H  (47H) MOV B,A
3E58H  (79H) MOV A,C
3E59H  (1FH) RAR
3E5AH  (4FH) MOV C,A
3E5BH  (D2H) JNC 3E66H
3E5EH  (C5H) PUSH B
3E5FH  (21H) LXI H,FBE7H    ; Floating Point Temp 1
3E62H  (CDH) CALL 31A3H     ; Double precision math (FAC1=M * FAC2))
3E65H  (C1H) POP B
3E66H  (78H) MOV A,B
3E67H  (B1H) ORA C
3E68H  (CAH) JZ 3E9EH
3E6BH  (C5H) PUSH B
3E6CH  (CDH) CALL 3234H     ; Push FAC1 on stack
3E6FH  (21H) LXI H,FBE7H    ; Floating Point Temp 1
3E72H  (E5H) PUSH H
3E73H  (CDH) CALL 31C4H     ; Move floating point number M to FAC1
3E76H  (E1H) POP H
3E77H  (E5H) PUSH H
3E78H  (CDH) CALL 31A3H     ; Double precision math (FAC1=M * FAC2))
3E7BH  (E1H) POP H
3E7CH  (CDH) CALL 31CAH     ; Move FAC1 to M
3E7FH  (CDH) CALL 324BH     ; Pop FAC1 from stack
3E82H  (C3H) JMP 3E53H

3E85H  (C5H) PUSH B
3E86H  (D5H) PUSH D
3E87H  (CDH) CALL 7FF4H
3E8AH  (E1H) POP H
3E8BH  (CDH) CALL 3543H     ; Convert signed integer HL to single precision FAC1
3E8EH  (CDH) CALL 35C2H     ; Convert FAC11 to double precision
3E91H  (21H) LXI H,FBE7H    ; Floating Point Temp 1
3E94H  (CDH) CALL 31CAH     ; Move FAC1 to M
3E97H  (CDH) CALL 31C1H     ; Move FAC2 to FAC1
3E9AH  (C1H) POP B
3E9BH  (C3H) JMP 3E66H

3E9EH  (F1H) POP PSW
3E9FH  (C1H) POP B
3EA0H  (F0H) RP
3EA1H  (3AH) LDA FB65H      ; Type of last variable used
3EA4H  (FEH) CPI 02H        ; Test if last type was Integer
3EA6H  (C2H) JNZ 3EB1H
3EA9H  (C5H) PUSH B
3EAAH  (CDH) CALL 3543H     ; Convert signed integer HL to single precision FAC1
3EADH  (CDH) CALL 35C2H     ; Convert FAC11 to double precision
3EB0H  (C1H) POP B
3EB1H  (3AH) LDA FC18H      ; Start of FAC1 for single and double precision
3EB4H  (B7H) ORA A
3EB5H  (C2H) JNZ 3EC3H
3EB8H  (2AH) LHLD FB90H
3EBBH  (B4H) ORA H
3EBCH  (F0H) RP
3EBDH  (7DH) MOV A,L
3EBEH  (0FH) RRC
3EBFH  (A0H) ANA B
3EC0H  (C3H) JMP 0455H      ; Generate OV error

3EC3H  (CDH) CALL 31B5H     ; Move FAC1 to FAC2
3EC6H  (21H) LXI H,3286H    ; Load pointer to FP 1.000000000
3EC9H  (CDH) CALL 31C4H     ; Move floating point number M to FAC1
3ECCH  (C3H) JMP 2DC7H      ; Double precision divide (FAC1=FAC1/FAC2)

3ECFH  (C5H) PUSH B
3ED0H  (D5H) PUSH D
3ED1H  (CDH) CALL 3725H     ; Signed integer muliply (FAC1=HL*DE)
3ED4H  (3AH) LDA FB65H      ; Type of last variable used
3ED7H  (FEH) CPI 02H        ; Test if last type was integer
3ED9H  (D1H) POP D
3EDAH  (C1H) POP B
3EDBH  (C9H) RET

3EDCH  (CDH) CALL 31C1H     ; Move FAC2 to FAC1
3EDFH  (CDH) CALL 322EH     ; Push FAC2 on stack
3EE2H  (CDH) CALL 3654H     ; INT function
3EE5H  (CDH) CALL 3245H     ; Pop FAC2 from stack
3EE8H  (CDH) CALL 34D2H     ; Double precision compare FAC1 with FAC2
3EEBH  (37H) STC
3EECH  (C0H) RNZ
3EEDH  (C3H) JMP 35DEH

3EF0H  (CDH) CALL 3F08H     ; Test HL against stack space for collision
3EF3H  (C5H) PUSH B
3EF4H  (E3H) XTHL
3EF5H  (C1H) POP B
3EF6H  (DFH) RST 3          ; Compare DE and HL
3EF7H  (7EH) MOV A,M
3EF8H  (02H) STAX B
3EF9H  (C8H) RZ
3EFAH  (0BH) DCX B
3EFBH  (2BH) DCX H
3EFCH  (C3H) JMP 3EF6H

; ======================================================
; Test for C * 2 bytes of stack space 
; ======================================================
3EFFH  (E5H) PUSH H
3F00H  (2AH) LHLD FBB6H     ; Unused memory pointer
3F03H  (06H) MVI B,00H
3F05H  (09H) DAD B
3F06H  (09H) DAD B
3F07H  DB    3EH            ; Makes pass-through code look like "MVI A,E5H"

; ======================================================
; Test HL against stack space for collision 
; ======================================================
3F08H  (E5H) PUSH H
3F09H  (3EH) MVI A,88H
3F0BH  (95H) SUB L
3F0CH  (6FH) MOV L,A
3F0DH  (3EH) MVI A,FFH
3F0FH  (9CH) SUB H
3F10H  (67H) MOV H,A
3F11H  (DAH) JC 3F17H
3F14H  (39H) DAD SP
3F15H  (E1H) POP H
3F16H  (D8H) RC
3F17H  (CDH) CALL 05F0H     ; Update line addresses for current BASIC program
3F1AH  (2AH) LHLD F678H     ; BASIC string buffer pointer
3F1DH  (2BH) DCX H
3F1EH  (2BH) DCX H
3F1FH  (22H) SHLD FB9DH     ; SP used by BASIC to reinitialize the stack
3F22H  (11H) LXI D,0007H    ; Prepare to generate OM Error
3F25H  (C3H) JMP 045DH      ; Generate error in E

; ======================================================
; Initialize BASIC Variables for new execution
; ======================================================
3F28H  (2AH) LHLD F67CH     ; Start of BASIC program pointer
3F2BH  (2BH) DCX H
3F2CH  (22H) SHLD FB99H     ; Address of last variable assigned
3F2FH  (CDH) CALL 4009H     ; Clear all COM, TIME, and KEY interrupt definitions
3F32H  (06H) MVI B,1AH
3F34H  (21H) LXI H,FBBAH    ; DEF definition table
3F37H  (36H) MVI M,08H
3F39H  (23H) INX H
3F3AH  (05H) DCR B
3F3BH  (C2H) JNZ 3F37H
3F3EH  (CDH) CALL 3182H     ; Initialize FP_RND to 4.0649651372358e-65 for new program
3F41H  (AFH) XRA A
3F42H  (32H) STA FBA7H      ; BASIC Program Running Flag
3F45H  (6FH) MOV L,A
3F46H  (67H) MOV H,A
3F47H  (22H) SHLD FBA5H     ; Address of ON ERROR routine
3F4AH  (22H) SHLD FBACH     ; Address where program stopped on last break, END, or STOP
3F4DH  (2AH) LHLD FB67H     ; File buffer area pointer
3F50H  (22H) SHLD FB8CH     ; Pointer to current location in BASIC string buffer
3F53H  (CDH) CALL 407FH     ; RESTORE statement
3F56H  (2AH) LHLD FBB2H     ; Start of variable data pointer
3F59H  (22H) SHLD FBB4H     ; Start of array table pointer
3F5CH  (22H) SHLD FBB6H     ; Unused memory pointer
3F5FH  (CDH) CALL 4E22H
3F62H  (3AH) LDA FCA7H
3F65H  (E6H) ANI 01H
3F67H  (C2H) JNZ 3F6DH
3F6AH  (32H) STA FCA7H
3F6DH  (C1H) POP B
3F6EH  (2AH) LHLD F678H     ; BASIC string buffer pointer
3F71H  (2BH) DCX H
3F72H  (2BH) DCX H
3F73H  (22H) SHLD FB9DH     ; SP used by BASIC to reinitialize the stack
3F76H  (23H) INX H
3F77H  (23H) INX H
3F78H  (F9H) SPHL
3F79H  (21H) LXI H,FB6BH
3F7CH  (22H) SHLD FB69H
3F7FH  (CDH) CALL 4B92H     ; Reinitialize output back to LCD
3F82H  (CDH) CALL 0C39H
3F85H  (AFH) XRA A
3F86H  (67H) MOV H,A
3F87H  (6FH) MOV L,A
3F88H  (22H) SHLD FBD6H
3F8BH  (32H) STA FBE1H
3F8EH  (22H) SHLD FBDBH
3F91H  (22H) SHLD FBE4H
3F94H  (22H) SHLD FBD4H
3F97H  (32H) STA FB96H      ; FOR/NEXT loop active flag
3F9AH  (E5H) PUSH H
3F9BH  (C5H) PUSH B
3F9CH  (2AH) LHLD FB99H     ; Address of last variable assigned
3F9FH  (C9H) RET


; ======================================================
; TIME$ ON statement
; ======================================================
3FA0H  (F3H) DI
3FA1H  (7EH) MOV A,M
3FA2H  (E6H) ANI 04H
3FA4H  (F6H) ORI 01H
3FA6H  (BEH) CMP M
3FA7H  (77H) MOV M,A
3FA8H  (CAH) JZ 3FB0H
3FABH  (E6H) ANI 04H
3FADH  (C2H) JNZ 3FE8H
3FB0H  (FBH) EI
3FB1H  (C9H) RET


; ======================================================
; TIME$ OFF statement
; ======================================================
3FB2H  (F3H) DI
3FB3H  (7EH) MOV A,M
3FB4H  (36H) MVI M,00H
3FB6H  (C3H) JMP 3FC0H


; ======================================================
; TIME$ STOP statement
; ======================================================
3FB9H  (F3H) DI
3FBAH  (7EH) MOV A,M
3FBBH  (F5H) PUSH PSW
3FBCH  (F6H) ORI 02H
3FBEH  (77H) MOV M,A
3FBFH  (F1H) POP PSW
3FC0H  (EEH) XRI 05H
3FC2H  (CAH) JZ 3FFCH
3FC5H  (FBH) EI
3FC6H  (C9H) RET

3FC7H  (F3H) DI
3FC8H  (7EH) MOV A,M
3FC9H  (E6H) ANI 05H
3FCBH  (BEH) CMP M
3FCCH  (77H) MOV M,A
3FCDH  (C2H) JNZ 3FE1H
3FD0H  (FBH) EI
3FD1H  (C9H) RET

; ======================================================
; Trigger interrupt.  HL points to interrupt table
; ======================================================
3FD2H  (F3H) DI             ; Disable interrupts
3FD3H  (7EH) MOV A,M        ; Load trigger control for this interrupt
3FD4H  (E6H) ANI 01H        ; Test if interrupt needs to be triggered maybe?
3FD6H  (CAH) JZ 3FE6H       ; Jump if source hasn't issued a trigger
3FD9H  (7EH) MOV A,M        ; Load trigger control again
3FDAH  (F6H) ORI 04H        ; Prepare to test if interrupt already counted
3FDCH  (BEH) CMP M          ; Test if interrupt already reported / counted
3FDDH  (CAH) JZ 3FE6H       ; Jump to return if interrupt already reported
3FE0H  (77H) MOV M,A        ; Mark interrupt as counted
3FE1H  (EEH) XRI 05H        ; Validate the interrupt should be counted
3FE3H  (CAH) JZ 3FE8H       ; Jump to increment the interrupt count
3FE6H  (FBH) EI             ; Re-enable interrupts
3FE7H  (C9H) RET

; ======================================================
; Increment the pending interrupt count
; ======================================================
3FE8H  (3AH) LDA F654H      ; Load current pending interrupt count
3FEBH  (3CH) INR A          ; Increment
3FECH  (32H) STA F654H      ; Save new pending interrupt count
3FEFH  (FBH) EI             ; Re-enable interrupts
3FF0H  (C9H) RET

; ======================================================
; Clear interrupt.  HL points to interrupt table
; ======================================================
3FF1H  (F3H) DI             ; Disable interrupts for protection
3FF2H  (7EH) MOV A,M        ; Get interrupt control register
3FF3H  (E6H) ANI 03H        ; Clear bit indicating interrupt reported as "pending"
3FF5H  (BEH) CMP M          ; Test if interrupt had been reported as "pending"
3FF6H  (77H) MOV M,A        ; Mark interrupt as not pending
3FF7H  (C2H) JNZ 3FFCH      ; Jump if interrupt previously marked as pending to decrement count
3FFAH  (FBH) EI             ; Re-enable interrupts
3FFBH  (C9H) RET

; ======================================================
; Decrement the pending interrupt count
; ======================================================
3FFCH  (3AH) LDA F654H      ; Load pending interrupt count
3FFFH  (D6H) SUI 01H        ; Decrement the count
4001H  (DAH) JC 3FFAH       ; Skip save if count was already zero
4004H  (32H) STA F654H      ; Save new pending interrupt count
4007H  (FBH) EI             ; Re-enable interrupts
4008H  (C9H) RET

; ======================================================
; Clear all COM, TIME, and KEY interrupt definitions
; ======================================================
4009H  (21H) LXI H,F944H    ; On Com flag
400CH  (06H) MVI B,0AH
400EH  (AFH) XRA A
400FH  (77H) MOV M,A
4010H  (23H) INX H
4011H  (77H) MOV M,A
4012H  (23H) INX H
4013H  (77H) MOV M,A
4014H  (23H) INX H
4015H  (05H) DCR B
4016H  (C2H) JNZ 400FH
4019H  (21H) LXI H,F630H    ; Function key status table (1 = on)
401CH  (06H) MVI B,08H
401EH  (77H) MOV M,A
401FH  (23H) INX H
4020H  (05H) DCR B
4021H  (C2H) JNZ 401EH
4024H  (32H) STA F654H
4027H  (C9H) RET

; ======================================================
; Process ON KEY/TIME$/COM/MDM interrupts from BASIC
; ======================================================
4028H  (06H) MVI B,02H      ; Mark entry from ON COM
402AH  DB    11H            ; Make "MVI B,01H" look like "LXI D,0106H"
402BH  (06H) MVI B,01H      ; Mark entry from ON KEY/TIME$
402DH  (3AH) LDA FBA7H      ; BASIC Program Running Flag
4030H  (B7H) ORA A          ; Test if BASIC runnin
4031H  (C0H) RNZ            ; Return if BASIC program not running
4032H  (E5H) PUSH H         ; Preserve HL on stack
4033H  (2AH) LHLD F67AH     ; Current executing line number
4036H  (7CH) MOV A,H        ; Get line number MSB
4037H  (A5H) ANA L          ; and with line number LSB
4038H  (3CH) INR A          ; Test if line number = 0xFFFF
4039H  (CAH) JZ 4052H       ; Jump to exit if line number = 0xFFFF
403CH  (05H) DCR B          ; Test for entry from ON COM
403DH  (C2H) JNZ 4075H      ; Jump if entered from ON COM
4040H  (21H) LXI H,F947H    ; On Time flag
4043H  (06H) MVI B,09H      ; Loop for 9 ON-TIME, ON-KEY, etc. interrupts
4045H  (7EH) MOV A,M        ; Get the ON-XXX flag
4046H  (FEH) CPI 05H        ; Test if Interrupt triggered by this event F1, F2, TIME$, etc.
4048H  (CAH) JZ 4054H       ; Jump to process ON-XXX interrupt
404BH  (23H) INX H          ; Skip ON-XXX flag
404CH  (23H) INX H          ; Skip ON-XXX line number LSB
404DH  (23H) INX H          ; SKip ON-XXX line number MSB
404EH  (05H) DCR B          ; Decrement number of ON-XXX events checked
404FH  (C2H) JNZ 4045H      ; Jump to process next ON-XXX interrupt?
4052H  (E1H) POP H          ; Restore HL from stack
4053H  (C9H) RET

; ======================================================
; Process a triggered ON-XXX interrupt (F1, F2, ..., Time$)
; ======================================================
4054H  (C5H) PUSH B         ; Save the ON-XXX index number
4055H  (23H) INX H          ; Skip to the BASIC line number LSB
4056H  (5EH) MOV E,M        ; Read the BASIC line number LSB
4057H  (23H) INX H          ; Skip to the MSB
4058H  (56H) MOV D,M        ; Read the BASIC line number MSB
4059H  (2BH) DCX H          ; Restore HL back to ON-XXX flag
405AH  (2BH) DCX H          ;    "
405BH  (7AH) MOV A,D        ; Prepare to test if the ON-XXX line = 0
405CH  (B3H) ORA E          ; OR in the MSB of the line
405DH  (C1H) POP B          ; Restore the stack frame
405EH  (CAH) JZ 404BH       ; SKip processing if line number = 0
4061H  (D5H) PUSH D         ; Preserve DE on Stack
4062H  (E5H) PUSH H         ; Preserve HL on Stack
4063H  (CDH) CALL 3FF1H     ; Clear interrupt.  HL points to interrupt table
4066H  (CDH) CALL 3FB9H     ; TIME$ STOP statement
4069H  (0EH) MVI C,03H      ; Prepare to validate 6 bytes free in Unused memory
406BH  (CDH) CALL 3EFFH     ; Validate 6 bytes free from stack space
406EH  (C1H) POP B          ; POP H from stack.  We don't really need to keep this one
406FH  (D1H) POP D          ; Restore DE from stack
4070H  (E1H) POP H          ; Restore HL from stack
4071H  (F1H) POP PSW
4072H  (C3H) JMP 0952H

; ======================================================
; Process ON COM interrupt
; ======================================================
4075H  (21H) LXI H,F944H    ; On Com flag
4078H  (7EH) MOV A,M        ; Get COM flag
4079H  (3DH) DCR A          ; Decrement to test for 1
407AH  (CAH) JZ 4054H       ; If 1, jump to process interrupt
407DH  (E1H) POP H          ; Restore HL from stack
407EH  (C9H) RET

; ======================================================
; RESTORE statement
; ======================================================
407FH  (EBH) XCHG
4080H  (2AH) LHLD F67CH     ; Start of BASIC program pointer
4083H  (CAH) JZ 4094H
4086H  (EBH) XCHG
4087H  (CDH) CALL 08EBH     ; Convert ASCII number at M to binary
408AH  (E5H) PUSH H
408BH  (CDH) CALL 0628H     ; Find line number in DE
408EH  (60H) MOV H,B
408FH  (69H) MOV L,C
4090H  (D1H) POP D
4091H  (D2H) JNC 094DH      ; Generate UL error
4094H  (2BH) DCX H
4095H  (22H) SHLD FBB8H     ; Address where DATA search will begin next
4098H  (EBH) XCHG
4099H  (C9H) RET


; ======================================================
; STOP statement
; ======================================================
409AH  (C0H) RNZ
409BH  (3CH) INR A
409CH  (C3H) JMP 40A9H


; ======================================================
; END statement
; ======================================================
409FH  (C0H) RNZ
40A0H  (AFH) XRA A
40A1H  (32H) STA FBA7H      ; BASIC Program Running Flag
40A4H  (F5H) PUSH PSW
40A5H  (CCH) CZ 4E22H
40A8H  (F1H) POP PSW
40A9H  (22H) SHLD FB9BH     ; Most recent or currently running line pointer
40ACH  (21H) LXI H,FB6BH
40AFH  (22H) SHLD FB69H
40B2H  (21H) LXI H,FFF6H
40B5H  (C1H) POP B
40B6H  (2AH) LHLD F67AH     ; Current executing line number
40B9H  (E5H) PUSH H
40BAH  (F5H) PUSH PSW
40BBH  (7DH) MOV A,L
40BCH  (A4H) ANA H
40BDH  (3CH) INR A
40BEH  (CAH) JZ 40CAH
40C1H  (22H) SHLD FBAAH     ; Line where break, END, or STOP occurred
40C4H  (2AH) LHLD FB9BH     ; Most recent or currently running line pointer
40C7H  (22H) SHLD FBACH     ; Address where program stopped on last break, END, or STOP
40CAH  (CDH) CALL 4B92H     ; Reinitialize output back to LCD
40CDH  (CDH) CALL 4BB8H     ; Move LCD to blank line (send CRLF if needed)
40D0H  (F1H) POP PSW
40D1H  (21H) LXI H,03FBH    ; Load pointer to "Break" text
40D4H  (C2H) JNZ 04F6H
40D7H  (C3H) JMP 0501H      ; Pop stack and vector to BASIC ready


; ======================================================
; CONT statement
; ======================================================
40DAH  (2AH) LHLD FBACH     ; Address where program stopped on last break, END, or STOP
40DDH  (7CH) MOV A,H
40DEH  (B5H) ORA L
40DFH  (11H) LXI D,0011H    ; Prepare to generate CN Error (Can't Continue)
40E2H  (CAH) JZ 045DH       ; Generate error in E
40E5H  (EBH) XCHG
40E6H  (2AH) LHLD FBAAH     ; Line where break, END, or STOP occurred
40E9H  (22H) SHLD F67AH     ; Current executing line number
40ECH  (EBH) XCHG
40EDH  (C9H) RET

40EEH  (C3H) JMP 08DBH      ; Generate FC error


; ======================================================
; Check if M is alpha character
; ======================================================
40F1H  (7EH) MOV A,M

; ======================================================
; Check if A is alpha character
; ======================================================
40F2H  (FEH) CPI 41H
40F4H  (D8H) RC
40F5H  (FEH) CPI 5BH
40F7H  (3FH) CMC
40F8H  (C9H) RET


; ======================================================
; CLEAR statement
; ======================================================
40F9H  (E5H) PUSH H
40FAH  (CDH) CALL 2262H
40FDH  (E1H) POP H
40FEH  (2BH) DCX H
40FFH  (D7H) RST 2          ; Get next non-white char from M
4100H  (CAH) JZ 3F2CH
4103H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
4104H  DB   00H
4105H  (CDH) CALL 08D7H
4108H  (2BH) DCX H
4109H  (D7H) RST 2          ; Get next non-white char from M
410AH  (E5H) PUSH H
410BH  (2AH) LHLD F5F4H     ; HIMEM
410EH  (44H) MOV B,H
410FH  (4DH) MOV C,L
4110H  (2AH) LHLD FB67H     ; File buffer area pointer
4113H  (CAH) JZ 4140H
4116H  (E1H) POP H
4117H  (CFH) RST 1          ; Compare next byte with M
4118H  DB   2CH
4119H  (D5H) PUSH D
411AH  (CDH) CALL 1297H     ; Evaluate expression at M
411DH  (2BH) DCX H
411EH  (D7H) RST 2          ; Get next non-white char from M
411FH  (C2H) JNZ 0446H      ; Generate Syntax error
4122H  (E3H) XTHL
4123H  (EBH) XCHG
4124H  (7CH) MOV A,H
4125H  (A7H) ANA A
4126H  (F2H) JP 08DBH       ; Generate FC error
4129H  (D5H) PUSH D
412AH  (11H) LXI D,F5F1H
412DH  (DFH) RST 3          ; Compare DE and HL
412EH  (D2H) JNC 08DBH      ; Generate FC error
4131H  (D1H) POP D
4132H  (E5H) PUSH H
4133H  (01H) LXI B,FEF5H
4136H  (3AH) LDA FC82H      ; Maxfiles
4139H  (09H) DAD B
413AH  (3DH) DCR A
413BH  (F2H) JP 4139H
413EH  (C1H) POP B
413FH  (2BH) DCX H
4140H  (7DH) MOV A,L
4141H  (93H) SUB E
4142H  (5FH) MOV E,A
4143H  (7CH) MOV A,H
4144H  (9AH) SBB D
4145H  (57H) MOV D,A
4146H  (DAH) JC 3F17H
4149H  (E5H) PUSH H
414AH  (2AH) LHLD FBB2H     ; Start of variable data pointer
414DH  (C5H) PUSH B
414EH  (01H) LXI B,00A0H
4151H  (09H) DAD B
4152H  (C1H) POP B
4153H  (DFH) RST 3          ; Compare DE and HL
4154H  (D2H) JNC 3F17H
4157H  (EBH) XCHG
4158H  (22H) SHLD F678H     ; BASIC string buffer pointer
415BH  (60H) MOV H,B
415CH  (69H) MOV L,C
415DH  (22H) SHLD F5F4H     ; HIMEM
4160H  (E1H) POP H
4161H  (22H) SHLD FB67H     ; File buffer area pointer
4164H  (E1H) POP H
4165H  (CDH) CALL 3F2CH
4168H  (3AH) LDA FC82H      ; Maxfiles
416BH  (CDH) CALL 7F2BH
416EH  (2AH) LHLD FB99H     ; Address of last variable assigned
4171H  (C3H) JMP 0804H      ; Execute BASIC program


; ======================================================
; NEXT statement
; ======================================================
4174H  (11H) LXI D,0000H
4177H  (C4H) CNZ 4790H      ; Find address of variable at M
417AH  (22H) SHLD FB99H     ; Address of last variable assigned
417DH  (CDH) CALL 0401H     ; Pop return address for NEXT or RETURN
4180H  (C2H) JNZ 044CH      ; Generate NF error
4183H  (F9H) SPHL
4184H  (D5H) PUSH D
4185H  (7EH) MOV A,M
4186H  (F5H) PUSH PSW
4187H  (23H) INX H
4188H  (D5H) PUSH D
4189H  (7EH) MOV A,M
418AH  (23H) INX H
418BH  (B7H) ORA A
418CH  (FAH) JM 41BBH
418FH  (3DH) DCR A
4190H  (C2H) JNZ 4197H
4193H  (01H) LXI B,0008H
4196H  (09H) DAD B
4197H  (C6H) ADI 04H
4199H  (32H) STA FB65H      ; Type of last variable used
419CH  (CDH) CALL 347EH
419FH  (EBH) XCHG
41A0H  (E3H) XTHL
41A1H  (E5H) PUSH H
41A2H  (EFH) RST 5          ; Determine type of last var used
41A3H  (D2H) JNC 41F6H
41A6H  (CDH) CALL 3447H     ; Load single precision at M to BCDE
41A9H  (CDH) CALL 37F4H     ; Single precision addition (FAC1=FAC1+BCDE)
41ACH  (E1H) POP H
41ADH  (CDH) CALL 3459H     ; Move single precision FAC1 to M
41B0H  (E1H) POP H
41B1H  (CDH) CALL 3450H     ; Reverse load single precision at M to DEBC
41B4H  (E5H) PUSH H
41B5H  (CDH) CALL 3498H     ; Compare single precision in BCDE with FAC1
41B8H  (C3H) JMP 41E4H

41BBH  (01H) LXI B,000CH
41BEH  (09H) DAD B
41BFH  (4EH) MOV C,M
41C0H  (23H) INX H
41C1H  (46H) MOV B,M
41C2H  (23H) INX H
41C3H  (E3H) XTHL
41C4H  (5EH) MOV E,M
41C5H  (23H) INX H
41C6H  (56H) MOV D,M
41C7H  (E5H) PUSH H
41C8H  (69H) MOV L,C
41C9H  (60H) MOV H,B
41CAH  (CDH) CALL 3704H     ; Signed integer addition (FAC1=HL+DE)
41CDH  (3AH) LDA FB65H      ; Type of last variable used
41D0H  (FEH) CPI 02H        ; Test if last type was integer
41D2H  (C2H) JNZ 0455H      ; Generate OV error
41D5H  (EBH) XCHG
41D6H  (E1H) POP H
41D7H  (72H) MOV M,D
41D8H  (2BH) DCX H
41D9H  (73H) MOV M,E
41DAH  (E1H) POP H
41DBH  (D5H) PUSH D
41DCH  (5EH) MOV E,M
41DDH  (23H) INX H
41DEH  (56H) MOV D,M
41DFH  (23H) INX H
41E0H  (E3H) XTHL
41E1H  (CDH) CALL 34C2H     ; Compare signed integer in DE with that in HL
41E4H  (E1H) POP H
41E5H  (C1H) POP B
41E6H  (90H) SUB B
41E7H  (CDH) CALL 3450H     ; Reverse load single precision at M to DEBC
41EAH  (CAH) JZ 4208H
41EDH  (EBH) XCHG
41EEH  (22H) SHLD F67AH     ; Current executing line number
41F1H  (69H) MOV L,C
41F2H  (60H) MOV H,B
41F3H  (C3H) JMP 0800H

41F6H  (CDH) CALL 2B75H
41F9H  (E1H) POP H
41FAH  (CDH) CALL 3487H
41FDH  (E1H) POP H
41FEH  (CDH) CALL 3461H     ; Move M to FAC2 using precision at (FB65H)
4201H  (D5H) PUSH D
4202H  (CDH) CALL 34D2H     ; Double precision compare FAC1 with FAC2
4205H  (C3H) JMP 41E4H

4208H  (F9H) SPHL
4209H  (22H) SHLD FB9DH     ; SP used by BASIC to reinitialize the stack
420CH  (EBH) XCHG
420DH  (2AH) LHLD FB99H     ; Address of last variable assigned
4210H  (7EH) MOV A,M
4211H  (FEH) CPI 2CH
4213H  (C2H) JNZ 0804H      ; Execute BASIC program
4216H  (D7H) RST 2          ; Get next non-white char from M
4217H  (CDH) CALL 4177H

; ======================================================
; Test if address FC8CH is Zero
; ======================================================
421AH  (E5H) PUSH H
421BH  (2AH) LHLD FC8CH
421EH  (7CH) MOV A,H
421FH  (B5H) ORA L
4220H  (E1H) POP H
4221H  (C9H) RET


; ======================================================
; Send CRLF to screen or printer
; ======================================================
4222H  (3EH) MVI A,0DH      ; Load ASCII value for CR
4224H  (E7H) RST 4          ; Send character in A to screen/printer

; ======================================================
; Send LF to screen or printer
; ======================================================
4225H  (3EH) MVI A,0AH      ; Load ASCII value for LF
4227H  (E7H) RST 4          ; Send character in A to screen/printer
4228H  (C9H) RET

; ======================================================
; BEEP statement
; ======================================================
4229H  (3EH) MVI A,07H      ; Load ASCII value for BELL
422BH  (E7H) RST 4          ; Send character in A to screen/printer
422CH  (C9H) RET

; ======================================================
; Home cursor
; ======================================================
422DH  (3EH) MVI A,0BH
422FH  (E7H) RST 4          ; Send character in A to screen/printer
4230H  (C9H) RET

; ======================================================
; CLS statement
; ======================================================
4231H  (3EH) MVI A,0CH      ; Load ASCIi value for Clear Screen
4233H  (E7H) RST 4          ; Send character in A to screen/printer
4234H  (C9H) RET


; ======================================================
; Protect line 8.  An ESC T is printed
; ======================================================
4235H  (3EH) MVI A,54H
4237H  (C3H) JMP 4270H      ; End escape sequence


; ======================================================
; Unprotect line 8.  An ESC U is printed
; ======================================================
423AH  (3EH) MVI A,55H
423CH  (C3H) JMP 4270H      ; End escape sequence


; ======================================================
; Stop automatic scrolling
; ======================================================
423FH  (3EH) MVI A,56H
4241H  (C3H) JMP 4270H      ; End escape sequence


; ======================================================
; Resume automatic scrolling
; ======================================================
4244H  (3EH) MVI A,57H
4246H  (C3H) JMP 4270H      ; End escape sequence


; ======================================================
; Turn the cursor on
; ======================================================
4249H  (3EH) MVI A,50H
424BH  (C3H) JMP 4270H      ; End escape sequence


; ======================================================
; Turn the cursor off
; ======================================================
424EH  (3EH) MVI A,51H
4250H  (C3H) JMP 4270H      ; End escape sequence


; ======================================================
; Delete current line on screen
; ======================================================
4253H  (3EH) MVI A,4DH
4255H  (C3H) JMP 4270H      ; End escape sequence


; ======================================================
; Insert line a current line
; ======================================================
4258H  (3EH) MVI A,4CH
425AH  (C3H) JMP 4270H      ; End escape sequence


; ======================================================
; Erase from cursor to end of line
; ======================================================
425DH  (3EH) MVI A,4BH
425FH  (C3H) JMP 4270H      ; End escape sequence


; ======================================================
; Send ESC X
; ======================================================
4262H  (3EH) MVI A,58H
4264H  (C3H) JMP 4270H      ; End escape sequence

4267H  (B6H) ORA M
4268H  (C8H) RZ

; ======================================================
; Start inverse character mode
; ======================================================
4269H  (3EH) MVI A,70H
426BH  (C3H) JMP 4270H      ; End escape sequence


; ======================================================
; Cancel inverse character mode
; ======================================================
426EH  (3EH) MVI A,71H

; ======================================================
; End escape sequence
; ======================================================
4270H  (F5H) PUSH PSW
4271H  (3EH) MVI A,1BH
4273H  (E7H) RST 4          ; Send character in A to screen/printer
4274H  (F1H) POP PSW
4275H  (E7H) RST 4          ; Send character in A to screen/printer
4276H  (C9H) RET


; ======================================================
; Send cursor to lower left of CRT
; ======================================================
4277H  (2AH) LHLD F63BH     ; Active rows count (1-8)
427AH  (26H) MVI H,01H

; ======================================================
; Set the current cursor position (H=Row,L=Col)
; ======================================================
427CH  (3EH) MVI A,59H
427EH  (CDH) CALL 4270H     ; End escape sequence
4281H  (7DH) MOV A,L
4282H  (C6H) ADI 1FH
4284H  (E7H) RST 4          ; Send character in A to screen/printer
4285H  (7CH) MOV A,H
4286H  (C6H) ADI 1FH
4288H  (E7H) RST 4          ; Send character in A to screen/printer
4289H  (C9H) RET


; ======================================================
; Erase function key display
; ======================================================
428AH  (3AH) LDA F63DH      ; Label line protect status
428DH  (A7H) ANA A
428EH  (C8H) RZ
428FH  (CDH) CALL 423AH     ; Unprotect line 8.  An ESC U is printed
4292H  (2AH) LHLD F639H     ; Cursor row (1-8)
4295H  (E5H) PUSH H
4296H  (CDH) CALL 4277H     ; Send cursor to lower left of CRT
4299H  (CDH) CALL 425DH     ; Erase from cursor to end of line
429CH  (E1H) POP H
429DH  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
42A0H  (CDH) CALL 4262H     ; Send ESC X
42A3H  (AFH) XRA A
42A4H  (C9H) RET


; ======================================================
; Set and display function keys (M has key table)
; ======================================================
42A5H  (CDH) CALL 5A7CH     ; Set new function key table

; ======================================================
; Display function key line
; ======================================================
42A8H  (2AH) LHLD F639H     ; Cursor row (1-8)
42ABH  (3AH) LDA F63BH      ; Active rows count (1-8)
42AEH  (BDH) CMP L
42AFH  (C2H) JNZ 42C0H
42B2H  (E5H) PUSH H
42B3H  (CDH) CALL 45EDH
42B6H  (2EH) MVI L,01H
42B8H  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
42BBH  (CDH) CALL 4253H     ; Delete current line on screen
42BEH  (E1H) POP H
42BFH  (2DH) DCR L
42C0H  (E5H) PUSH H
42C1H  (CDH) CALL 423AH     ; Unprotect line 8.  An ESC U is printed
42C4H  (CDH) CALL 4277H     ; Send cursor to lower left of CRT
42C7H  (21H) LXI H,F789H    ; Function key definition area
42CAH  (1EH) MVI E,08H
42CCH  (3AH) LDA F648H      ; Reverse video switch
42CFH  (F5H) PUSH PSW
42D0H  (CDH) CALL 426EH     ; Cancel inverse character mode
42D3H  (3AH) LDA F63CH      ; Active columns count (1-40)
42D6H  (FEH) CPI 28H
42D8H  (01H) LXI B,040CH
42DBH  (CAH) JZ 42E1H
42DEH  (01H) LXI B,0907H
42E1H  (E5H) PUSH H
42E2H  (21H) LXI H,FAC3H
42E5H  (7BH) MOV A,E
42E6H  (D6H) SUI 06H
42E8H  (CAH) JZ 42EDH
42EBH  (3DH) DCR A
42ECH  (2BH) DCX H
42EDH  (CCH) CZ 4267H
42F0H  (E1H) POP H
42F1H  (CDH) CALL 1BE0H     ; Send B characters from M to the screen
42F4H  (09H) DAD B
42F5H  (CDH) CALL 426EH     ; Cancel inverse character mode
42F8H  (1DH) DCR E
42F9H  (C4H) CNZ 001EH      ; Send a space to screen/printer
42FCH  (C2H) JNZ 42D3H
42FFH  (CDH) CALL 425DH     ; Erase from cursor to end of line
4302H  (CDH) CALL 4235H     ; Protect line 8.  An ESC T is printed
4305H  (F1H) POP PSW
4306H  (A7H) ANA A
4307H  (C4H) CNZ 4269H      ; Start inverse character mode
430AH  (E1H) POP H
430BH  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
430EH  (CDH) CALL 4262H     ; Send ESC X
4311H  (AFH) XRA A
4312H  (C9H) RET


; ======================================================
; Print A to the screen
; ======================================================
4313H  (E5H) PUSH H         ; Preserve registers on stack
4314H  (D5H) PUSH D
4315H  (C5H) PUSH B
4316H  (F5H) PUSH PSW
4317H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
4318H  DB   08H
4319H  (CDH) CALL 431FH     ; RST 7 returned to us.  Print to the LCD.
431CH  (C3H) JMP 14EDH      ; Pop AF, BC, DE, HL from stack

; ======================================================
; Print A to the LCD (RST 7 08 didn't print to DVI).
; ======================================================
431FH  (4FH) MOV C,A        ; Save value to PLOT to LCD to C
4320H  (AFH) XRA A          ; Clear A to indicate POP of PSW not required
4321H  (32H) STA FAC7H      ; Indicate POP of PSW not required
4324H  (3AH) LDA F638H      ; New Console device flag
4327H  (A7H) ANA A          ; Test if new console flag set
4328H  (C2H) JNZ 434AH      ; Jump if New Console flag set
432BH  (CDH) CALL 4335H     ; Character plotting level 4. Turn off background task & call level 5
432EH  (2AH) LHLD F639H     ; Cursor row (1-8)
4331H  (22H) SHLD F640H     ; Cursor row (1-8)
4334H  (C9H) RET


; ======================================================
; Character plotting level 4. Turn off background task & call level 5
; ======================================================
4335H  (CDH) CALL 73C5H     ; Turn off background task, blink & reinitialize cursor blink time
4338H  (CDH) CALL 434CH     ; Character plotting level 5. Handle ESC sequences & call level 6

; ======================================================
; Get Cursor ROW,COL in DE and start cursor blinking if cursor on
; ======================================================
433BH  (2AH) LHLD F639H     ; Cursor row (1-8)
433EH  (EBH) XCHG
433FH  (CDH) CALL 7440H     ; Disable Automatic Scrolling
4342H  (3AH) LDA F63FH      ; Cursor status (0 = off)
4345H  (A7H) ANA A          ; Test if cursor is off
4346H  (C8H) RZ             ; Return if cursor off
4347H  (C3H) JMP 73D9H      ; Initialize Cursor Blink to start blinking

; ======================================================
; Initialize New Screen for LCD/DVI RST 7 hook
; ======================================================
434AH  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
434BH  DB   3CH

; ======================================================
; Character plotting level 5. Handle ESC sequences & call level 6
; ======================================================
434CH  (21H) LXI H,F646H    ; ESC mode flag for RST 20H
434FH  (7EH) MOV A,M
4350H  (A7H) ANA A
4351H  (C2H) JNZ 43FAH      ; ESCape sequence driver
4354H  (79H) MOV A,C
4355H  (2AH) LHLD F639H     ; Cursor row (1-8)
4358H  (FEH) CPI 09H
435AH  (CAH) JZ 4480H       ; Tab routine
435DH  (FEH) CPI 7FH
435FH  (CAH) JZ 451FH
4362H  (FEH) CPI 20H
4364H  (DAH) JC 4373H       ; LCD output driver
4367H  (CDH) CALL 4560H     ; Character plotting level 6.  Save character in C to LCD RAM & call level 7
436AH  (CDH) CALL 4453H     ; ESC C routine (move cursor right)
436DH  (C0H) RNZ
436EH  (26H) MVI H,01H
4370H  (C3H) JMP 4494H      ; Linefeed routine


; ======================================================
; LCD output driver
; ======================================================
4373H  (21H) LXI H,4388H    ; Point to LCD key to vector table
4376H  (0EH) MVI C,08H      ; Indicate 8 entries in table

; ======================================================
; Key Vector table lookup
; ======================================================
4378H  (23H) INX H
4379H  (23H) INX H
437AH  (0DH) DCR C
437BH  (F8H) RM
437CH  (BEH) CMP M
437DH  (23H) INX H
437EH  (C2H) JNZ 4378H      ; Jump back to test next entry 
4381H  (7EH) MOV A,M
4382H  (23H) INX H
4383H  (66H) MOV H,M
4384H  (6FH) MOV L,A
4385H  (E5H) PUSH H
4386H  (2AH) LHLD F639H     ; Cursor row (1-8)
4389H  (C9H) RET


; ======================================================
; RST 20H lookup table
; ======================================================
438AH  DB   07H
438BH  DW   7662H           ; Beep routine
438DH  DB   08H
438EH  DW   4461H           ; Backspace routine
4390H  DB   09H
4391H  DW   4480H           ; Tab routine
4393H  DB   0AH
4394H  DW   4494H           ; Linefeed routine
4396H  DB   0BH
4397H  DW   44A8H           ; Vertical tab and ESC H routine (home cursor)
4399H  DB   0CH
439AH  DW   4548H           ; Form Feed (0CH), CLS, ESC E, and ESC J routine
439CH  DB   0DH
439DH  DW   44AAH           ; CR routine
439FH  DB   1BH
43A0H  DW   43B2H           ; LCD output Escape routine

; ======================================================
; Conditionally POP PSW from stack based on value at FAC7H
; ======================================================
43A2H  (3AH) LDA FAC7H      ; Get value at FAC7H
43A5H  (A7H) ANA A          ; Test if zero
43A6H  (C8H) RZ             ; Return if zero (No POP needed)
43A7H  (F1H) POP PSW        ; POP PSW from stack
43A8H  (C9H) RET

43A9H  (3AH) LDA F63DH      ; Label line protect status
43ACH  (C6H) ADI 08H
43AEH  (C9H) RET


; ======================================================
; ESC Y routine (Set cursor position)
; ======================================================
43AFH  (3EH) MVI A,02H
43B1H  (01H) LXI B,AF3EH
43B4H  (32H) STA F646H      ; ESC mode flag for RST 20H
43B7H  (C9H) RET


; ======================================================
; LCD Escape sequence lookup table
; ======================================================
43B8H  DB   'j'
43B9H  DW   4548H           ; Form Feed (0CH), CLS, ESC E, and ESC J routine
43BBH  DB   'E'
43BCH  DW   4548H           ; Form Feed (0CH), CLS, ESC E, and ESC J routine
43BEH  DB   'K'
43BFH  DW   4537H
43C1H  DB   'J'
43C2H  DW   454EH
43C4H  DB   'l'
43C5H  DW   4535H
43C7H  DB   'L'
43C8H  DW   44EAH
43CAH  DB   'M'
43CBH  DW   44C4H
43CDH  DB   'Y'
43CEH  DW   43AFH
43D0H  DB   'A'
43D1H  DW   4469H
43D3H  DB   'B'
43D4H  DW   446EH
43D6H  DB   'C'
43D7H  DW   4453H
43D9H  DB   'D'
43DAH  DW   445CH
43DCH  DB   'H'
43DDH  DW   44A8H           ; Vertical tab and ESC H routine (home cursor)
43DFH  DB   'p'
43E0H  DW   4431H
43E2H  DB   'q'
43E3H  DW   4432H
43E5H  DB   'P'
43E6H  DW   44AFH
43E8H  DB   'Q'
43E9H  DW   44BAH
43EBH  DB   'T'
43ECH  DW   4439H
43EEH  DB   'U'
43EFH  DW   4437H
43F1H  DB   'V'
43F2H  DW   443FH
43F4H  DB   'W'
43F5H  DW   4440H
43F7H  DB   'X'
43F8H  DW   444AH

; ======================================================
; ESCape sequence driver
; ======================================================
43FAH  (79H) MOV A,C
43FBH  (FEH) CPI 1BH
43FDH  (7EH) MOV A,M
43FEH  (CAH) JZ 4445H
4401H  (A7H) ANA A
4402H  (F2H) JP 4411H
4405H  (CDH) CALL 43B3H
4408H  (79H) MOV A,C
4409H  (21H) LXI H,43B6H    ; Load pointer to key vector table
440CH  (0EH) MVI C,16H      ; 16 entries in table
440EH  (C3H) JMP 4378H      ; Key Vector table lookup

4411H  (3DH) DCR A
4412H  (32H) STA F646H      ; ESC mode flag for RST 20H
4415H  (3AH) LDA F63CH      ; Active columns count (1-40)
4418H  (11H) LXI D,F63AH    ; Cursor column (1-40)
441BH  (CAH) JZ 4426H
441EH  (3AH) LDA F63BH      ; Active rows count (1-8)
4421H  (21H) LXI H,F63DH    ; Label line protect status
4424H  (86H) ADD M
4425H  (1BH) DCX D
4426H  (47H) MOV B,A
4427H  (79H) MOV A,C
4428H  (D6H) SUI 20H
442AH  (B8H) CMP B
442BH  (3CH) INR A
442CH  (12H) STAX D
442DH  (D8H) RC
442EH  (78H) MOV A,B
442FH  (12H) STAX D
4430H  (C9H) RET


; ======================================================
; ESC p routine (start inverse video)
; ======================================================
4431H  (F6H) ORI AFH
4433H  (32H) STA F648H      ; Reverse video switch
4436H  (C9H) RET


; ======================================================
; ESC U routine (unprotect line 8)
; ======================================================
4437H  (AFH) XRA A
4438H  (C2H) JNZ FF3EH
443BH  (32H) STA F63DH      ; Label line protect status
443EH  (C9H) RET


; ======================================================
; ESC V routine (stop automatic scrolling)
; ======================================================
443FH  (F6H) ORI AFH
4441H  (32H) STA F63EH      ; Scroll disable flag
4444H  (C9H) RET

4445H  (23H) INX H
4446H  (77H) MOV M,A
4447H  (C3H) JMP 43B2H      ; LCD output Escape routine

444AH  (21H) LXI H,F647H
444DH  (7EH) MOV A,M
444EH  (36H) MVI M,00H
4450H  (2BH) DCX H
4451H  (77H) MOV M,A
4452H  (C9H) RET


; ======================================================
; ESC C routine (move cursor right)
; ======================================================
4453H  (3AH) LDA F63CH      ; Active columns count (1-40)
4456H  (BCH) CMP H
4457H  (C8H) RZ
4458H  (24H) INR H
4459H  (C3H) JMP 4477H


; ======================================================
; ESC D routine (move cursor left)
; ======================================================
445CH  (25H) DCR H
445DH  (C8H) RZ
445EH  (C3H) JMP 4477H


; ======================================================
; Backspace routine
; ======================================================
4461H  (CDH) CALL 445CH     ; ESC D routine (move cursor left)
4464H  (C0H) RNZ
4465H  (3AH) LDA F63CH      ; Active columns count (1-40)
4468H  (67H) MOV H,A

; ======================================================
; ESC A routine (move cursor up)
; ======================================================
4469H  (2DH) DCR L
446AH  (C8H) RZ
446BH  (C3H) JMP 4477H


; ======================================================
; ESC B routine (move cursor down)
; ======================================================
446EH  (CDH) CALL 63CDH
4471H  (BDH) CMP L
4472H  (C8H) RZ
4473H  (DAH) JC 447BH
4476H  (2CH) INR L
4477H  (22H) SHLD F639H     ; Cursor row (1-8)
447AH  (C9H) RET

447BH  (2DH) DCR L
447CH  (AFH) XRA A
447DH  (C3H) JMP 4477H


; ======================================================
; Tab routine
; ======================================================
4480H  (3AH) LDA F63AH      ; Cursor column (1-40)
4483H  (F5H) PUSH PSW
4484H  (3EH) MVI A,20H
4486H  (E7H) RST 4          ; Send character in A to screen/printer
4487H  (C1H) POP B
4488H  (3AH) LDA F63AH      ; Cursor column (1-40)
448BH  (B8H) CMP B
448CH  (C8H) RZ
448DH  (3DH) DCR A
448EH  (E6H) ANI 07H
4490H  (C2H) JNZ 4480H      ; Tab routine
4493H  (C9H) RET


; ======================================================
; Linefeed routine
; ======================================================
4494H  (CDH) CALL 446EH     ; ESC B routine (move cursor down)
4497H  (C0H) RNZ
4498H  (3AH) LDA F63EH      ; Scroll disable flag
449BH  (A7H) ANA A
449CH  (C0H) RNZ
449DH  (CDH) CALL 4477H
44A0H  (CDH) CALL 45EDH
44A3H  (2EH) MVI L,01H
44A5H  (C3H) JMP 44C7H

; ======================================================
; Vertical tab and ESC H routine (home cursor)
; ======================================================
44A8H  (2EH) MVI L,01H      ; Set ROW to 1 (TOP)

; ======================================================
; CR routine
; ======================================================
44AAH  (26H) MVI H,01H      ; Set COL to 1 (Left)
44ACH  (C3H) JMP 4477H      ; Jump to set new ROW,COL

; ======================================================
; ESC P routine (turn cursor on)
; ======================================================
44AFH  (3EH) MVI A,01H
44B1H  (32H) STA F63FH      ; Cursor status (0 = off)
44B4H  (CDH) CALL 43A2H     ; Conditionally POP PSW from stack based on value at FAC7H
44B7H  (C3H) JMP 73D9H      ; Initialize Cursor Blink to start blinking


; ======================================================
; ESC Q routine (turn cursor off)
; ======================================================
44BAH  (AFH) XRA A
44BBH  (32H) STA F63FH      ; Cursor status (0 = off)
44BEH  (CDH) CALL 43A2H     ; Conditionally POP PSW from stack based on value at FAC7H
44C1H  (C3H) JMP 73C5H      ; Turn off background task, blink & reinitialize cursor blink time


; ======================================================
; ESC M routine
; ======================================================
44C4H  (CDH) CALL 44AAH     ; CR routine
44C7H  (CDH) CALL 43A2H     ; Conditionally POP PSW from stack based on value at FAC7H 
44CAH  (CDH) CALL 43A9H
44CDH  (95H) SUB L
44CEH  (D8H) RC
44CFH  (CAH) JZ 4535H       ; ESC l routine (erase current line)

; ======================================================
; Scroll LCD screen A times at line number in L
; ======================================================
44D2H  (F5H) PUSH PSW
44D3H  (26H) MVI H,28H
44D5H  (2CH) INR L
44D6H  (CDH) CALL 4512H     ; Get character at (H,L) from LCD RAM)
44D9H  (2DH) DCR L
44DAH  (CDH) CALL 4566H
44DDH  (25H) DCR H
44DEH  (C2H) JNZ 44D5H
44E1H  (2CH) INR L
44E2H  (F1H) POP PSW
44E3H  (3DH) DCR A
44E4H  (C2H) JNZ 44D2H      ; Scroll LCD screen A times at line number in L
44E7H  (C3H) JMP 4535H      ; ESC l routine (erase current line)


; ======================================================
; ESC L routine (insert line)
; ======================================================
44EAH  (CDH) CALL 44AAH     ; CR routine
44EDH  (CDH) CALL 43A2H     ; Conditionally POP PSW from stack based on value at FAC7H
44F0H  (CDH) CALL 43A9H
44F3H  (67H) MOV H,A
44F4H  (95H) SUB L
44F5H  (D8H) RC
44F6H  (CAH) JZ 4535H       ; ESC l routine (erase current line)
44F9H  (6CH) MOV L,H
44FAH  (F5H) PUSH PSW
44FBH  (26H) MVI H,28H
44FDH  (2DH) DCR L
44FEH  (CDH) CALL 4512H     ; Get character at (H,L) from LCD RAM)
4501H  (2CH) INR L
4502H  (CDH) CALL 4566H
4505H  (25H) DCR H
4506H  (C2H) JNZ 44FDH
4509H  (2DH) DCR L
450AH  (F1H) POP PSW
450BH  (3DH) DCR A
450CH  (C2H) JNZ 44FAH
450FH  (C3H) JMP 4535H      ; ESC l routine (erase current line)


; ======================================================
; Get character at (H,L) from LCD RAM)
; ======================================================
4512H  (E5H) PUSH H
4513H  (E5H) PUSH H
4514H  (CDH) CALL 4586H
4517H  (4EH) MOV C,M
4518H  (E1H) POP H
4519H  (CDH) CALL 45AAH
451CH  (A6H) ANA M
451DH  (E1H) POP H
451EH  (C9H) RET

451FH  (3AH) LDA F648H      ; Reverse video switch
4522H  (F5H) PUSH PSW
4523H  (CDH) CALL 426EH     ; Cancel inverse character mode
4526H  (3EH) MVI A,08H
4528H  (E7H) RST 4          ; Send character in A to screen/printer
4529H  (3EH) MVI A,20H
452BH  (E7H) RST 4          ; Send character in A to screen/printer
452CH  (3EH) MVI A,08H
452EH  (E7H) RST 4          ; Send character in A to screen/printer
452FH  (F1H) POP PSW
4530H  (A7H) ANA A
4531H  (C8H) RZ
4532H  (C3H) JMP 4269H      ; Start inverse character mode


; ======================================================
; ESC l routine (erase current line)
; ======================================================
4535H  (26H) MVI H,01H

; ======================================================
; ESC K routine (erase to EOL)
; ======================================================
4537H  (CDH) CALL 43A2H     ; Conditionally POP PSW from stack based on value at FAC7H
453AH  (0EH) MVI C,20H
453CH  (AFH) XRA A
453DH  (CDH) CALL 4566H
4540H  (24H) INR H
4541H  (7CH) MOV A,H
4542H  (FEH) CPI 29H
4544H  (DAH) JC 453AH
4547H  (C9H) RET


; ======================================================
; Form Feed (0CH), CLS, ESC E, and ESC J routine
; ======================================================
4548H  (CDH) CALL 44A8H     ; Vertical tab and ESC H routine (home cursor)
454BH  (CDH) CALL 45D3H

; ======================================================
; ESC J routine
; ======================================================
454EH  (CDH) CALL 43A2H     ; Conditionally POP PSW from stack based on value at FAC7H
4551H  (CDH) CALL 4537H     ; ESC K routine (erase to EOL)
4554H  (CDH) CALL 43A9H
4557H  (BDH) CMP L
4558H  (D8H) RC
4559H  (C8H) RZ
455AH  (26H) MVI H,01H
455CH  (2CH) INR L
455DH  (C3H) JMP 4551H


; ======================================================
; Character plotting level 6.  Save character in C to LCD RAM & call level 7
; ======================================================
4560H  (CDH) CALL 43A2H     ; Conditionally POP PSW from stack based on value at FAC7H
4563H  (3AH) LDA F648H      ; Reverse video switch
4566H  (E5H) PUSH H
4567H  (F5H) PUSH PSW
4568H  (E5H) PUSH H
4569H  (E5H) PUSH H
456AH  (CDH) CALL 459AH
456DH  (E1H) POP H
456EH  (CDH) CALL 4586H
4571H  (71H) MOV M,C
4572H  (D1H) POP D
4573H  (CDH) CALL 73EEH     ; Character plotting level 7.  Plot character in C on LCD at (H,L)
4576H  (F1H) POP PSW
4577H  (A7H) ANA A
4578H  (E1H) POP H
4579H  (C8H) RZ
457AH  (F3H) DI
457BH  (3EH) MVI A,0DH
457DH  (30H) SIM
457EH  (FBH) EI
457FH  (CDH) CALL 73A9H     ; Blink the cursor
4582H  (3EH) MVI A,09H
4584H  (30H) SIM
4585H  (C9H) RET

4586H  (7DH) MOV A,L
4587H  (87H) ADD A
4588H  (87H) ADD A
4589H  (85H) ADD L
458AH  (87H) ADD A
458BH  (87H) ADD A
458CH  (87H) ADD A
458DH  (5FH) MOV E,A
458EH  (9FH) SBB A
458FH  (2FH) CMA
4590H  (57H) MOV D,A
4591H  (6CH) MOV L,H
4592H  (26H) MVI H,00H
4594H  (19H) DAD D
4595H  (11H) LXI D,FED7H
4598H  (19H) DAD D
4599H  (C9H) RET

459AH  (47H) MOV B,A
459BH  (CDH) CALL 45AAH
459EH  (04H) INR B
459FH  (05H) DCR B
45A0H  (CAH) JZ 45A6H
45A3H  (B6H) ORA M
45A4H  (77H) MOV M,A
45A5H  (C9H) RET

45A6H  (2FH) CMA
45A7H  (A6H) ANA M
45A8H  (77H) MOV M,A
45A9H  (C9H) RET

45AAH  (7DH) MOV A,L
45ABH  (87H) ADD A
45ACH  (87H) ADD A
45ADH  (85H) ADD L
45AEH  (6FH) MOV L,A
45AFH  (7CH) MOV A,H
45B0H  (3DH) DCR A
45B1H  (F5H) PUSH PSW
45B2H  (0FH) RRC
45B3H  (0FH) RRC
45B4H  (0FH) RRC
45B5H  (E6H) ANI 1FH
45B7H  (85H) ADD L
45B8H  (6FH) MOV L,A
45B9H  (26H) MVI H,00H
45BBH  (11H) LXI D,FB35H
45BEH  (19H) DAD D
45BFH  (F1H) POP PSW
45C0H  (E6H) ANI 07H
45C2H  (57H) MOV D,A
45C3H  (AFH) XRA A
45C4H  (37H) STC
45C5H  (1FH) RAR
45C6H  (15H) DCR D
45C7H  (F2H) JP 45C5H
45CAH  (C9H) RET

45CBH  (E5H) PUSH H
45CCH  (CDH) CALL 45AAH
45CFH  (AEH) XRA M
45D0H  (77H) MOV M,A
45D1H  (E1H) POP H
45D2H  (C9H) RET

45D3H  (CDH) CALL 43A2H     ; Conditionally POP PSW from stack based on value at FAC7H
45D6H  (3AH) LDA F650H
45D9H  (87H) ADD A
45DAH  (F0H) RP
45DBH  (E5H) PUSH H
45DCH  (21H) LXI H,FCC0H    ; Start of Alt LCD character buffer
45DFH  (01H) LXI B,0140H
45E2H  (36H) MVI M,20H
45E4H  (23H) INX H
45E5H  (0BH) DCX B
45E6H  (78H) MOV A,B
45E7H  (B1H) ORA C
45E8H  (C2H) JNZ 45E2H
45EBH  (E1H) POP H
45ECH  (C9H) RET

45EDH  (CDH) CALL 43A2H     ; Conditionally POP PSW from stack based on value at FAC7H
45F0H  (3AH) LDA F650H
45F3H  (87H) ADD A
45F4H  (F0H) RP
45F5H  (11H) LXI D,FCC0H    ; Start of Alt LCD character buffer
45F8H  (21H) LXI H,FCE8H
45FBH  (01H) LXI B,0140H
45FEH  (C3H) JMP 6BDBH      ; Move BC bytes from M to (DE) with increment


; ======================================================
; Redraw SCREEN from LCD RAM
; ======================================================
4601H  (CDH) CALL 73C5H     ; Turn off background task, blink & reinitialize cursor blink time
4604H  (2EH) MVI L,01H      ; Prepare to point to LCD RAM (1,1)
4606H  (26H) MVI H,01H      ;   "
4608H  (CDH) CALL 4512H     ; Get character at (H,L) from LCD RAM)
460BH  (CDH) CALL 4566H     ; Call Level 6 Character Draw routine
460EH  (24H) INR H          ; Increment column 
460FH  (7CH) MOV A,H        ; Prepare to test for column 40
4610H  (FEH) CPI 29H        ; Test if beyond column 40
4612H  (C2H) JNZ 4608H      ; Jump if more columns on this line
4615H  (2CH) INR L          ; Increment line
4616H  (7DH) MOV A,L        ; Prepare to test if last line refreshed
4617H  (FEH) CPI 09H        ; Test if beyond line 8
4619H  (C2H) JNZ 4606H      ; Jump back to refresh next line if not on line 9
461CH  (C3H) JMP 433BH      ; Get Cursor ROW,COL in DE and start cursor blinking if cursor on      

461FH  (21H) LXI H,FCC0H    ; Start of Alt LCD character buffer
4622H  (1EH) MVI E,01H
4624H  (16H) MVI D,01H
4626H  (E5H) PUSH H
4627H  (D5H) PUSH D
4628H  (4EH) MOV C,M
4629H  (CDH) CALL 73EEH     ; Character plotting level 7.  Plot character in C on LCD at (H,L)
462CH  (D1H) POP D
462DH  (E1H) POP H
462EH  (23H) INX H
462FH  (14H) INR D
4630H  (7AH) MOV A,D
4631H  (FEH) CPI 29H
4633H  (C2H) JNZ 4626H
4636H  (1CH) INR E
4637H  (7BH) MOV A,E
4638H  (FEH) CPI 09H
463AH  (C2H) JNZ 4624H
463DH  (C9H) RET


; ======================================================
; Input and display line and store
; ======================================================
463EH  (3EH) MVI A,3FH
4640H  (E7H) RST 4          ; Send character in A to screen/printer
4641H  (3EH) MVI A,20H
4643H  (E7H) RST 4          ; Send character in A to screen/printer

; ======================================================
; Input and display (no "?") line and store
; ======================================================
4644H  (CDH) CALL 421AH
4647H  (C2H) JNZ 4703H
464AH  (3AH) LDA F63AH      ; Cursor column (1-40)
464DH  (32H) STA FACAH
4650H  (11H) LXI D,F685H    ; Keyboard buffer
4653H  (06H) MVI B,01H
4655H  (CDH) CALL 12CBH     ; Wait for key from keyboard
4658H  (21H) LXI H,4655H
465BH  (E5H) PUSH H
465CH  (D8H) RC
465DH  (FEH) CPI 7FH
465FH  (CAH) JZ 46A0H       ; Input routine backspace, left arrow, CTRL-H handler
4662H  (FEH) CPI 20H
4664H  (D2H) JNC 46CCH
4667H  (21H) LXI H,466DH    ; Load pointer to key vector table
466AH  (0EH) MVI C,07H      ; Seven entries in table
466CH  (C3H) JMP 4378H      ; Key Vector table lookup

; ======================================================
; Input routine Key vector table
; ======================================================
466FH  DB   03H
4670H  DW   4684H           ; CTRL-C Handler
4672H  DB   08H
4673H  DW   46A0H           ; Backspace handler
4675H  DB   09H
4676H  DW   46CAH           ; TAB handler
4678H  DB   0DH
4679H  DW   4696H           ; ENTER key handler
467BH  DB   15H
467CH  DW   46C3H           ; CTRL-U handler
467EH  DB   18H
467FH  DW   46C3H           ; CTRL-X Handler
4681H  DB   1DH
4682H  DW   46A0H           ; Left arrow handler

; ======================================================
; Input routine Control-C handler
; ======================================================
4684H  (E1H) POP H
4685H  (3EH) MVI A,5EH
4687H  (E7H) RST 4          ; Send character in A to screen/printer
4688H  (3EH) MVI A,43H
468AH  (E7H) RST 4          ; Send character in A to screen/printer
468BH  (CDH) CALL 4222H     ; Send CRLF to screen or printer
468EH  (21H) LXI H,F685H    ; Keyboard buffer
4691H  (36H) MVI M,00H
4693H  (2BH) DCX H
4694H  (37H) STC
4695H  (C9H) RET


; ======================================================
; Input routine ENTER handler
; ======================================================
4696H  (E1H) POP H
4697H  (CDH) CALL 4222H     ; Send CRLF to screen or printer
469AH  (AFH) XRA A
469BH  (12H) STAX D
469CH  (21H) LXI H,F684H
469FH  (C9H) RET


; ======================================================
; Input routine backspace, left arrow, CTRL-H handler
; ======================================================
46A0H  (78H) MOV A,B
46A1H  (3DH) DCR A
46A2H  (37H) STC
46A3H  (C8H) RZ
46A4H  (05H) DCR B
46A5H  (1BH) DCX D
46A6H  (CDH) CALL 46D8H
46A9H  (F5H) PUSH PSW
46AAH  (3EH) MVI A,7FH
46ACH  (E7H) RST 4          ; Send character in A to screen/printer
46ADH  (2AH) LHLD F639H     ; Cursor row (1-8)
46B0H  (2DH) DCR L
46B1H  (25H) DCR H
46B2H  (7CH) MOV A,H
46B3H  (B5H) ORA L
46B4H  (CAH) JZ 46C0H
46B7H  (21H) LXI H,F63AH    ; Cursor column (1-40)
46BAH  (F1H) POP PSW
46BBH  (BEH) CMP M
46BCH  (C2H) JNZ 46A9H
46BFH  (C9H) RET

46C0H  (F1H) POP PSW
46C1H  (37H) STC
46C2H  (C9H) RET


; ======================================================
; Input routine CTRL-U & X handler
; ======================================================
46C3H  (CDH) CALL 46A0H     ; Input routine backspace, left arrow, CTRL-H handler
46C6H  (D2H) JNC 46C3H      ; Input routine CTRL-U & X handler
46C9H  (C9H) RET


; ======================================================
; Input routine Tab handler
; ======================================================
46CAH  (3EH) MVI A,09H
46CCH  (04H) INR B
46CDH  (CAH) JZ 46D4H
46D0H  (E7H) RST 4          ; Send character in A to screen/printer
46D1H  (12H) STAX D
46D2H  (13H) INX D
46D3H  (C9H) RET

46D4H  (05H) DCR B
46D5H  (C3H) JMP 4229H      ; BEEP statement

46D8H  (C5H) PUSH B
46D9H  (3AH) LDA FACAH
46DCH  (05H) DCR B
46DDH  (CAH) JZ 4701H
46E0H  (4FH) MOV C,A
46E1H  (21H) LXI H,F685H    ; Keyboard buffer
46E4H  (0CH) INR C
46E5H  (7EH) MOV A,M
46E6H  (FEH) CPI 09H
46E8H  (C2H) JNZ 46F2H
46EBH  (79H) MOV A,C
46ECH  (3DH) DCR A
46EDH  (E6H) ANI 07H
46EFH  (C2H) JNZ 46E4H
46F2H  (3AH) LDA F63CH      ; Active columns count (1-40)
46F5H  (B9H) CMP C
46F6H  (D2H) JNC 46FBH
46F9H  (0EH) MVI C,01H
46FBH  (23H) INX H
46FCH  (05H) DCR B
46FDH  (C2H) JNZ 46E4H
4700H  (79H) MOV A,C
4701H  (C1H) POP B
4702H  (C9H) RET

4703H  (2AH) LHLD FC8CH
4706H  (E5H) PUSH H
4707H  (23H) INX H
4708H  (23H) INX H
4709H  (23H) INX H
470AH  (23H) INX H
470BH  (7EH) MOV A,M
470CH  (D6H) SUI F8H
470EH  (C2H) JNZ 4728H
4711H  (6FH) MOV L,A
4712H  (67H) MOV H,A
4713H  (22H) SHLD FC8CH
4716H  (21H) LXI H,FAC4H
4719H  (34H) INR M
471AH  (7EH) MOV A,M
471BH  (0FH) RRC
471CH  (D4H) CNC 4269H      ; Start inverse character mode
471FH  (21H) LXI H,5593H
4722H  (CDH) CALL 27B1H     ; Print buffer at M until NULL or '"'
4725H  (CDH) CALL 426EH     ; Cancel inverse character mode
4728H  (E1H) POP H
4729H  (22H) SHLD FC8CH
472CH  (06H) MVI B,00H
472EH  (21H) LXI H,F685H    ; Keyboard buffer
4731H  (AFH) XRA A
4732H  (32H) STA FAA2H
4735H  (32H) STA FAA3H
4738H  (CDH) CALL 4E7AH
473BH  (DAH) JC 4759H
473EH  (77H) MOV M,A
473FH  (FEH) CPI 0DH
4741H  (CAH) JZ 4753H
4744H  (FEH) CPI 09H
4746H  (CAH) JZ 474EH
4749H  (FEH) CPI 20H
474BH  (DAH) JC 4731H
474EH  (23H) INX H
474FH  (05H) DCR B
4750H  (C2H) JNZ 4731H
4753H  (AFH) XRA A
4754H  (77H) MOV M,A
4755H  (21H) LXI H,F684H
4758H  (C9H) RET

4759H  (78H) MOV A,B
475AH  (A7H) ANA A
475BH  (C2H) JNZ 4753H
475EH  (3AH) LDA FCA7H
4761H  (E6H) ANI 80H
4763H  (32H) STA FCA7H
4766H  (CDH) CALL 4F45H
4769H  (3EH) MVI A,0DH
476BH  (E7H) RST 4          ; Send character in A to screen/printer
476CH  (CDH) CALL 425DH     ; Erase from cursor to end of line
476FH  (3AH) LDA FC92H
4772H  (A7H) ANA A
4773H  (CAH) JZ 477CH
4776H  (CDH) CALL 3F28H     ; Initialize BASIC Variables for new execution
4779H  (C3H) JMP 0804H      ; Execute BASIC program

477CH  (3AH) LDA F651H      ; In TEXT because of BASIC EDIT flag
477FH  (A7H) ANA A
4780H  (C2H) JNZ 5EBAH
4783H  (C3H) JMP 0501H      ; Pop stack and vector to BASIC ready

4786H  (2BH) DCX H
4787H  (D7H) RST 2          ; Get next non-white char from M
4788H  (C8H) RZ
4789H  (CFH) RST 1          ; Compare next byte with M
478AH  DB   2CH

; ======================================================
; DIM statement
; ======================================================
478BH  (01H) LXI B,4786H
478EH  (C5H) PUSH B
478FH  (F6H) ORI AFH
4791H  (32H) STA FB64H      ; Variable Create/Locate switch
4794H  (4EH) MOV C,M
4795H  (CDH) CALL 40F1H     ; Check if M is alpha character
4798H  (DAH) JC 0446H       ; Generate Syntax error
479BH  (AFH) XRA A
479CH  (47H) MOV B,A
479DH  (D7H) RST 2          ; Get next non-white char from M
479EH  (DAH) JC 47A7H
47A1H  (CDH) CALL 40F2H     ; Check if A is alpha character
47A4H  (DAH) JC 47B2H
47A7H  (47H) MOV B,A
47A8H  (D7H) RST 2          ; Get next non-white char from M
47A9H  (DAH) JC 47A8H
47ACH  (CDH) CALL 40F2H     ; Check if A is alpha character
47AFH  (D2H) JNC 47A8H
47B2H  (FEH) CPI 26H
47B4H  (D2H) JNC 47CEH
47B7H  (11H) LXI D,47DCH
47BAH  (D5H) PUSH D
47BBH  (16H) MVI D,02H
47BDH  (FEH) CPI 25H
47BFH  (C8H) RZ
47C0H  (14H) INR D
47C1H  (FEH) CPI 24H
47C3H  (C8H) RZ
47C4H  (14H) INR D
47C5H  (FEH) CPI 21H
47C7H  (C8H) RZ
47C8H  (16H) MVI D,08H
47CAH  (FEH) CPI 23H
47CCH  (C8H) RZ
47CDH  (F1H) POP PSW
47CEH  (79H) MOV A,C
47CFH  (E6H) ANI 7FH
47D1H  (5FH) MOV E,A
47D2H  (16H) MVI D,00H
47D4H  (E5H) PUSH H
47D5H  (21H) LXI H,FB79H
47D8H  (19H) DAD D
47D9H  (56H) MOV D,M
47DAH  (E1H) POP H
47DBH  (2BH) DCX H
47DCH  (7AH) MOV A,D
47DDH  (32H) STA FB65H      ; Type of last variable used
47E0H  (D7H) RST 2          ; Get next non-white char from M
47E1H  (3AH) LDA FB96H      ; FOR/NEXT loop active flag
47E4H  (3DH) DCR A
47E5H  (CAH) JZ 48BCH
47E8H  (F2H) JP 47F6H
47EBH  (7EH) MOV A,M
47ECH  (D6H) SUI 28H
47EEH  (CAH) JZ 488DH
47F1H  (D6H) SUI 33H
47F3H  (CAH) JZ 488DH
47F6H  (AFH) XRA A
47F7H  (32H) STA FB96H      ; FOR/NEXT loop active flag
47FAH  (E5H) PUSH H
47FBH  (2AH) LHLD FBB2H     ; Start of variable data pointer
47FEH  (C3H) JMP 481AH

4801H  (1AH) LDAX D
4802H  (6FH) MOV L,A
4803H  (13H) INX D
4804H  (1AH) LDAX D
4805H  (13H) INX D
4806H  (B9H) CMP C
4807H  (C2H) JNZ 4816H
480AH  (3AH) LDA FB65H      ; Type of last variable used
480DH  (BDH) CMP L
480EH  (C2H) JNZ 4816H
4811H  (1AH) LDAX D
4812H  (B8H) CMP B
4813H  (CAH) JZ 4876H
4816H  (13H) INX D
4817H  (26H) MVI H,00H
4819H  (19H) DAD D
481AH  (EBH) XCHG
481BH  (3AH) LDA FBB4H      ; Start of array table pointer
481EH  (BBH) CMP E
481FH  (C2H) JNZ 4801H
4822H  (3AH) LDA FBB5H
4825H  (BAH) CMP D
4826H  (C2H) JNZ 4801H
4829H  (C3H) JMP 4835H

482CH  (CDH) CALL 4790H     ; Find address of variable at M
482FH  (C9H) RET

4830H  (57H) MOV D,A
4831H  (5FH) MOV E,A
4832H  (C1H) POP B
4833H  (E3H) XTHL
4834H  (C9H) RET

4835H  (E1H) POP H
4836H  (E3H) XTHL
4837H  (D5H) PUSH D
4838H  (11H) LXI D,482FH
483BH  (DFH) RST 3          ; Compare DE and HL
483CH  (CAH) JZ 4830H
483FH  (11H) LXI D,0FDDH
4842H  (DFH) RST 3          ; Compare DE and HL
4843H  (D1H) POP D
4844H  (CAH) JZ 4879H
4847H  (E3H) XTHL
4848H  (E5H) PUSH H
4849H  (C5H) PUSH B
484AH  (3AH) LDA FB65H      ; Type of last variable used
484DH  (4FH) MOV C,A
484EH  (C5H) PUSH B
484FH  (06H) MVI B,00H
4851H  (03H) INX B
4852H  (03H) INX B
4853H  (03H) INX B
4854H  (2AH) LHLD FBB6H     ; Unused memory pointer
4857H  (E5H) PUSH H
4858H  (09H) DAD B
4859H  (C1H) POP B
485AH  (E5H) PUSH H
485BH  (CDH) CALL 3EF0H
485EH  (E1H) POP H
485FH  (22H) SHLD FBB6H     ; Unused memory pointer
4862H  (60H) MOV H,B
4863H  (69H) MOV L,C
4864H  (22H) SHLD FBB4H     ; Start of array table pointer
4867H  (2BH) DCX H
4868H  (36H) MVI M,00H
486AH  (DFH) RST 3          ; Compare DE and HL
486BH  (C2H) JNZ 4867H
486EH  (D1H) POP D
486FH  (73H) MOV M,E
4870H  (23H) INX H
4871H  (D1H) POP D
4872H  (73H) MOV M,E
4873H  (23H) INX H
4874H  (72H) MOV M,D
4875H  (EBH) XCHG
4876H  (13H) INX D
4877H  (E1H) POP H
4878H  (C9H) RET

4879H  (32H) STA FC18H      ; Start of FAC1 for single and double precision
487CH  (67H) MOV H,A
487DH  (6FH) MOV L,A
487EH  (22H) SHLD FC1AH     ; Start of FAC1 for integers
4881H  (EFH) RST 5          ; Determine type of last var used
4882H  (C2H) JNZ 488BH
4885H  (21H) LXI H,03F5H
4888H  (22H) SHLD FC1AH     ; Start of FAC1 for integers
488BH  (E1H) POP H
488CH  (C9H) RET

488DH  (E5H) PUSH H
488EH  (2AH) LHLD FB64H     ; Variable Create/Locate switch
4891H  (E3H) XTHL
4892H  (57H) MOV D,A
4893H  (D5H) PUSH D
4894H  (C5H) PUSH B
4895H  (CDH) CALL 08D6H
4898H  (C1H) POP B
4899H  (F1H) POP PSW
489AH  (EBH) XCHG
489BH  (E3H) XTHL
489CH  (E5H) PUSH H
489DH  (EBH) XCHG
489EH  (3CH) INR A
489FH  (57H) MOV D,A
48A0H  (7EH) MOV A,M
48A1H  (FEH) CPI 2CH
48A3H  (CAH) JZ 4893H
48A6H  (FEH) CPI 29H
48A8H  (CAH) JZ 48B0H
48ABH  (FEH) CPI 5DH
48ADH  (C2H) JNZ 0446H      ; Generate Syntax error
48B0H  (D7H) RST 2          ; Get next non-white char from M
48B1H  (22H) SHLD FBA8H
48B4H  (E1H) POP H
48B5H  (22H) SHLD FB64H     ; Variable Create/Locate switch
48B8H  (1EH) MVI E,00H
48BAH  (D5H) PUSH D
48BBH  (11H) LXI D,F5E5H
48BEH  (2AH) LHLD FBB4H     ; Start of array table pointer
48C1H  (3EH) MVI A,19H
48C3H  (EBH) XCHG
48C4H  (2AH) LHLD FBB6H     ; Unused memory pointer
48C7H  (EBH) XCHG
48C8H  (DFH) RST 3          ; Compare DE and HL
48C9H  (CAH) JZ 48FCH
48CCH  (5EH) MOV E,M
48CDH  (23H) INX H
48CEH  (7EH) MOV A,M
48CFH  (23H) INX H
48D0H  (B9H) CMP C
48D1H  (C2H) JNZ 48DDH
48D4H  (3AH) LDA FB65H      ; Type of last variable used
48D7H  (BBH) CMP E
48D8H  (C2H) JNZ 48DDH
48DBH  (7EH) MOV A,M
48DCH  (B8H) CMP B
48DDH  (23H) INX H
48DEH  (5EH) MOV E,M
48DFH  (23H) INX H
48E0H  (56H) MOV D,M
48E1H  (23H) INX H
48E2H  (C2H) JNZ 48C2H
48E5H  (3AH) LDA FB64H      ; Variable Create/Locate switch
48E8H  (B7H) ORA A
48E9H  (C2H) JNZ 044FH      ; Generate DD error
48ECH  (F1H) POP PSW
48EDH  (44H) MOV B,H
48EEH  (4DH) MOV C,L
48EFH  (CAH) JZ 383EH
48F2H  (96H) SUB M
48F3H  (CAH) JZ 495AH
48F6H  (11H) LXI D,0009H    ; Prepare to generate BS Error (Bad Subscript)
48F9H  (C3H) JMP 045DH      ; Generate error in E

48FCH  (3AH) LDA FB65H      ; Type of last variable used
48FFH  (77H) MOV M,A
4900H  (23H) INX H
4901H  (5FH) MOV E,A
4902H  (16H) MVI D,00H
4904H  (F1H) POP PSW
4905H  (CAH) JZ 08DBH       ; Generate FC error
4908H  (71H) MOV M,C
4909H  (23H) INX H
490AH  (70H) MOV M,B
490BH  (23H) INX H
490CH  (4FH) MOV C,A
490DH  (CDH) CALL 3EFFH     ; Test for C * 2 bytes free space in Stack
4910H  (23H) INX H
4911H  (23H) INX H
4912H  (22H) SHLD FB8EH
4915H  (71H) MOV M,C
4916H  (23H) INX H
4917H  (3AH) LDA FB64H      ; Variable Create/Locate switch
491AH  (17H) RAL
491BH  (79H) MOV A,C
491CH  (01H) LXI B,000BH
491FH  (D2H) JNC 4924H
4922H  (C1H) POP B
4923H  (03H) INX B
4924H  (71H) MOV M,C
4925H  (F5H) PUSH PSW
4926H  (23H) INX H
4927H  (70H) MOV M,B
4928H  (23H) INX H
4929H  (CDH) CALL 36D8H
492CH  (F1H) POP PSW
492DH  (3DH) DCR A
492EH  (C2H) JNZ 491CH
4931H  (F5H) PUSH PSW
4932H  (42H) MOV B,D
4933H  (4BH) MOV C,E
4934H  (EBH) XCHG
4935H  (19H) DAD D
4936H  (DAH) JC 3F17H
4939H  (CDH) CALL 3F08H     ; Test HL against stack space for collision
493CH  (22H) SHLD FBB6H     ; Unused memory pointer
493FH  (2BH) DCX H
4940H  (36H) MVI M,00H
4942H  (DFH) RST 3          ; Compare DE and HL
4943H  (C2H) JNZ 493FH
4946H  (03H) INX B
4947H  (57H) MOV D,A
4948H  (2AH) LHLD FB8EH
494BH  (5EH) MOV E,M
494CH  (EBH) XCHG
494DH  (29H) DAD H
494EH  (09H) DAD B
494FH  (EBH) XCHG
4950H  (2BH) DCX H
4951H  (2BH) DCX H
4952H  (73H) MOV M,E
4953H  (23H) INX H
4954H  (72H) MOV M,D
4955H  (23H) INX H
4956H  (F1H) POP PSW
4957H  (DAH) JC 498DH
495AH  (47H) MOV B,A
495BH  (4FH) MOV C,A
495CH  (7EH) MOV A,M
495DH  (23H) INX H
495EH  (16H) MVI D,E1H
4960H  (5EH) MOV E,M
4961H  (23H) INX H
4962H  (56H) MOV D,M
4963H  (23H) INX H
4964H  (E3H) XTHL
4965H  (F5H) PUSH PSW
4966H  (DFH) RST 3          ; Compare DE and HL
4967H  (D2H) JNC 48F6H
496AH  (CDH) CALL 36D8H
496DH  (19H) DAD D
496EH  (F1H) POP PSW
496FH  (3DH) DCR A
4970H  (44H) MOV B,H
4971H  (4DH) MOV C,L
4972H  (C2H) JNZ 495FH
4975H  (3AH) LDA FB65H      ; Type of last variable used
4978H  (44H) MOV B,H
4979H  (4DH) MOV C,L
497AH  (29H) DAD H
497BH  (D6H) SUI 04H
497DH  (DAH) JC 4985H
4980H  (29H) DAD H
4981H  (CAH) JZ 498AH
4984H  (29H) DAD H
4985H  (B7H) ORA A
4986H  (E2H) JPO 498AH
4989H  (09H) DAD B
498AH  (C1H) POP B
498BH  (09H) DAD B
498CH  (EBH) XCHG
498DH  (2AH) LHLD FBA8H
4990H  (C9H) RET


; ======================================================
; USING function
; ======================================================
4991H  (CDH) CALL 0DACH
4994H  (CDH) CALL 35D9H     ; Generate TM error if last variable type not string or RET
4997H  (CFH) RST 1          ; Compare next byte with M
4998H  DB   3BH
4999H  (EBH) XCHG
499AH  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
499DH  (C3H) JMP 49A9H

49A0H  (3AH) LDA FB98H
49A3H  (B7H) ORA A
49A4H  (CAH) JZ 49B4H
49A7H  (D1H) POP D
49A8H  (EBH) XCHG
49A9H  (E5H) PUSH H
49AAH  (AFH) XRA A
49ABH  (32H) STA FB98H
49AEH  (3CH) INR A
49AFH  (F5H) PUSH PSW
49B0H  (D5H) PUSH D
49B1H  (46H) MOV B,M
49B2H  (04H) INR B
49B3H  (05H) DCR B
49B4H  (CAH) JZ 08DBH       ; Generate FC error
49B7H  (23H) INX H
49B8H  (7EH) MOV A,M
49B9H  (23H) INX H
49BAH  (66H) MOV H,M
49BBH  (6FH) MOV L,A
49BCH  (C3H) JMP 49DCH

49BFH  (58H) MOV E,B
49C0H  (E5H) PUSH H
49C1H  (0EH) MVI C,02H
49C3H  (7EH) MOV A,M
49C4H  (23H) INX H
49C5H  (FEH) CPI 5CH
49C7H  (CAH) JZ 4B07H
49CAH  (FEH) CPI 20H
49CCH  (C2H) JNZ 49D4H
49CFH  (0CH) INR C
49D0H  (05H) DCR B
49D1H  (C2H) JNZ 49C3H
49D4H  (E1H) POP H
49D5H  (43H) MOV B,E
49D6H  (3EH) MVI A,5CH
49D8H  (CDH) CALL 4B3AH
49DBH  (E7H) RST 4          ; Send character in A to screen/printer
49DCH  (AFH) XRA A
49DDH  (5FH) MOV E,A
49DEH  (57H) MOV D,A
49DFH  (CDH) CALL 4B3AH
49E2H  (57H) MOV D,A
49E3H  (7EH) MOV A,M
49E4H  (23H) INX H
49E5H  (FEH) CPI 21H
49E7H  (CAH) JZ 4B04H
49EAH  (FEH) CPI 23H
49ECH  (CAH) JZ 4A2EH
49EFH  (05H) DCR B
49F0H  (CAH) JZ 4AF0H
49F3H  (FEH) CPI 2BH
49F5H  (3EH) MVI A,08H
49F7H  (CAH) JZ 49DFH
49FAH  (2BH) DCX H
49FBH  (7EH) MOV A,M
49FCH  (23H) INX H
49FDH  (FEH) CPI 2EH
49FFH  (CAH) JZ 4A4DH
4A02H  (FEH) CPI 5CH
4A04H  (CAH) JZ 49BFH
4A07H  (BEH) CMP M
4A08H  (C2H) JNZ 49D8H
4A0BH  (FEH) CPI 24H
4A0DH  (CAH) JZ 4A27H
4A10H  (FEH) CPI 2AH
4A12H  (C2H) JNZ 49D8H
4A15H  (23H) INX H
4A16H  (78H) MOV A,B
4A17H  (FEH) CPI 02H
4A19H  (DAH) JC 4A1FH
4A1CH  (7EH) MOV A,M
4A1DH  (FEH) CPI 24H
4A1FH  (3EH) MVI A,20H
4A21H  (C2H) JNZ 4A2BH
4A24H  (05H) DCR B
4A25H  (1CH) INR E
4A26H  (FEH) CPI AFH
4A28H  (C6H) ADI 10H
4A2AH  (23H) INX H
4A2BH  (1CH) INR E
4A2CH  (82H) ADD D
4A2DH  (57H) MOV D,A
4A2EH  (1CH) INR E
4A2FH  (0EH) MVI C,00H
4A31H  (05H) DCR B
4A32H  (CAH) JZ 4A83H
4A35H  (7EH) MOV A,M
4A36H  (23H) INX H
4A37H  (FEH) CPI 2EH
4A39H  (CAH) JZ 4A58H
4A3CH  (FEH) CPI 23H
4A3EH  (CAH) JZ 4A2EH
4A41H  (FEH) CPI 2CH
4A43H  (C2H) JNZ 4A64H
4A46H  (7AH) MOV A,D
4A47H  (F6H) ORI 40H
4A49H  (57H) MOV D,A
4A4AH  (C3H) JMP 4A2EH

4A4DH  (7EH) MOV A,M
4A4EH  (FEH) CPI 23H
4A50H  (3EH) MVI A,2EH
4A52H  (C2H) JNZ 49D8H
4A55H  (0EH) MVI C,01H
4A57H  (23H) INX H
4A58H  (0CH) INR C
4A59H  (05H) DCR B
4A5AH  (CAH) JZ 4A83H
4A5DH  (7EH) MOV A,M
4A5EH  (23H) INX H
4A5FH  (FEH) CPI 23H
4A61H  (CAH) JZ 4A58H
4A64H  (D5H) PUSH D
4A65H  (11H) LXI D,4A81H
4A68H  (D5H) PUSH D
4A69H  (54H) MOV D,H
4A6AH  (5DH) MOV E,L
4A6BH  (FEH) CPI 5EH
4A6DH  (C0H) RNZ
4A6EH  (BEH) CMP M
4A6FH  (C0H) RNZ
4A70H  (23H) INX H
4A71H  (BEH) CMP M
4A72H  (C0H) RNZ
4A73H  (23H) INX H
4A74H  (BEH) CMP M
4A75H  (C0H) RNZ
4A76H  (23H) INX H
4A77H  (78H) MOV A,B
4A78H  (D6H) SUI 04H
4A7AH  (D8H) RC
4A7BH  (D1H) POP D
4A7CH  (D1H) POP D
4A7DH  (47H) MOV B,A
4A7EH  (14H) INR D
4A7FH  (23H) INX H
4A80H  (CAH) JZ D1EBH
4A83H  (7AH) MOV A,D
4A84H  (2BH) DCX H
4A85H  (1CH) INR E
4A86H  (E6H) ANI 08H
4A88H  (C2H) JNZ 4AA3H
4A8BH  (1DH) DCR E
4A8CH  (78H) MOV A,B
4A8DH  (B7H) ORA A
4A8EH  (CAH) JZ 4AA3H
4A91H  (7EH) MOV A,M
4A92H  (D6H) SUI 2DH
4A94H  (CAH) JZ 4A9EH
4A97H  (FEH) CPI FEH
4A99H  (C2H) JNZ 4AA3H
4A9CH  (3EH) MVI A,08H
4A9EH  (C6H) ADI 04H
4AA0H  (82H) ADD D
4AA1H  (57H) MOV D,A
4AA2H  (05H) DCR B
4AA3H  (E1H) POP H
4AA4H  (F1H) POP PSW
4AA5H  (CAH) JZ 4AF9H
4AA8H  (C5H) PUSH B
4AA9H  (D5H) PUSH D
4AAAH  (CDH) CALL 0DABH     ; Main BASIC evaluation routine
4AADH  (D1H) POP D
4AAEH  (C1H) POP B
4AAFH  (C5H) PUSH B
4AB0H  (E5H) PUSH H
4AB1H  (43H) MOV B,E
4AB2H  (78H) MOV A,B
4AB3H  (81H) ADD C
4AB4H  (FEH) CPI 19H
4AB6H  (D2H) JNC 08DBH      ; Generate FC error
4AB9H  (7AH) MOV A,D
4ABAH  (F6H) ORI 80H
4ABCH  (CDH) CALL 39E9H
4ABFH  (CDH) CALL 27B1H     ; Print buffer at M until NULL or '"'
4AC2H  (E1H) POP H
4AC3H  (2BH) DCX H
4AC4H  (D7H) RST 2          ; Get next non-white char from M
4AC5H  (37H) STC
4AC6H  (CAH) JZ 4AD7H
4AC9H  (32H) STA FB98H
4ACCH  (FEH) CPI 3BH
4ACEH  (CAH) JZ 4AD6H
4AD1H  (FEH) CPI 2CH
4AD3H  (C2H) JNZ 0446H      ; Generate Syntax error
4AD6H  (D7H) RST 2          ; Get next non-white char from M
4AD7H  (C1H) POP B
4AD8H  (EBH) XCHG
4AD9H  (E1H) POP H
4ADAH  (E5H) PUSH H
4ADBH  (F5H) PUSH PSW
4ADCH  (D5H) PUSH D
4ADDH  (7EH) MOV A,M
4ADEH  (90H) SUB B
4ADFH  (23H) INX H
4AE0H  (16H) MVI D,00H
4AE2H  (5FH) MOV E,A
4AE3H  (7EH) MOV A,M
4AE4H  (23H) INX H
4AE5H  (66H) MOV H,M
4AE6H  (6FH) MOV L,A
4AE7H  (19H) DAD D
4AE8H  (78H) MOV A,B
4AE9H  (B7H) ORA A
4AEAH  (C2H) JNZ 49DCH
4AEDH  (C3H) JMP 4AF4H

4AF0H  (CDH) CALL 4B3AH
4AF3H  (E7H) RST 4          ; Send character in A to screen/printer
4AF4H  (E1H) POP H
4AF5H  (F1H) POP PSW
4AF6H  (C2H) JNZ 49A0H
4AF9H  (DCH) CC 4BCBH
4AFCH  (E3H) XTHL
4AFDH  (CDH) CALL 291CH
4B00H  (E1H) POP H
4B01H  (C3H) JMP 0C39H

4B04H  (0EH) MVI C,01H
4B06H  (3EH) MVI A,F1H
4B08H  (05H) DCR B
4B09H  (CDH) CALL 4B3AH
4B0CH  (E1H) POP H
4B0DH  (F1H) POP PSW
4B0EH  (CAH) JZ 4AF9H
4B11H  (C5H) PUSH B
4B12H  (CDH) CALL 0DABH     ; Main BASIC evaluation routine
4B15H  (CDH) CALL 35D9H     ; Generate TM error if last variable type not string or RET
4B18H  (C1H) POP B
4B19H  (C5H) PUSH B
4B1AH  (E5H) PUSH H
4B1BH  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
4B1EH  (41H) MOV B,C
4B1FH  (0EH) MVI C,00H
4B21H  (78H) MOV A,B
4B22H  (F5H) PUSH PSW
4B23H  (CDH) CALL 29B2H
4B26H  (CDH) CALL 27B4H
4B29H  (2AH) LHLD FC1AH     ; Start of FAC1 for integers
4B2CH  (F1H) POP PSW
4B2DH  (96H) SUB M
4B2EH  (47H) MOV B,A
4B2FH  (3EH) MVI A,20H
4B31H  (04H) INR B
4B32H  (05H) DCR B
4B33H  (CAH) JZ 4AC2H
4B36H  (E7H) RST 4          ; Send character in A to screen/printer
4B37H  (C3H) JMP 4B32H

4B3AH  (F5H) PUSH PSW
4B3BH  (7AH) MOV A,D
4B3CH  (B7H) ORA A
4B3DH  (3EH) MVI A,2BH
4B3FH  (C4H) CNZ 4B44H      ; Send A to screen or printer
4B42H  (F1H) POP PSW
4B43H  (C9H) RET


; ======================================================
; Send A to screen or printer
; ======================================================
4B44H  (F5H) PUSH PSW
4B45H  (E5H) PUSH H
4B46H  (CDH) CALL 421AH
4B49H  (C2H) JNZ 4E52H
4B4CH  (E1H) POP H
4B4DH  (3AH) LDA F675H      ; Output device for RST 20H (0=screen)
4B50H  (B7H) ORA A
4B51H  (CAH) JZ 4BAAH
4B54H  (F1H) POP PSW

; ======================================================
; Print A to printer, expanding tabs if necessary
; ======================================================
4B55H  (F5H) PUSH PSW
4B56H  (FEH) CPI 09H
4B58H  (C2H) JNZ 4B6AH
4B5BH  (3EH) MVI A,20H
4B5DH  (CDH) CALL 4B55H     ; Print A to printer, expanding tabs if necessary
4B60H  (3AH) LDA F674H      ; Line printer head position
4B63H  (E6H) ANI 07H
4B65H  (C2H) JNZ 4B5BH
4B68H  (F1H) POP PSW
4B69H  (C9H) RET

4B6AH  (D6H) SUI 0DH
4B6CH  (CAH) JZ 4B76H
4B6FH  (DAH) JC 4B79H
4B72H  (3AH) LDA F674H      ; Line printer head position
4B75H  (3CH) INR A
4B76H  (32H) STA F674H      ; Line printer head position
4B79H  (F1H) POP PSW
4B7AH  (FEH) CPI 0AH
4B7CH  (C2H) JNZ 4B88H
4B7FH  (C5H) PUSH B
4B80H  (47H) MOV B,A
4B81H  (3AH) LDA FAACH      ; Last char sent to printer
4B84H  (FEH) CPI 0DH
4B86H  (78H) MOV A,B
4B87H  (C1H) POP B
4B88H  (32H) STA FAACH      ; Last char sent to printer
4B8BH  (C8H) RZ
4B8CH  (FEH) CPI 1AH
4B8EH  (C8H) RZ
4B8FH  (C3H) JMP 1470H      ; Output character to printer


; ======================================================
; Reinitialize output back to LCD
; ======================================================
4B92H  (AFH) XRA A
4B93H  (32H) STA F675H      ; Output device for RST 20H (0=screen)
4B96H  (3AH) LDA F674H      ; Line printer head position
4B99H  (B7H) ORA A
4B9AH  (C8H) RZ
4B9BH  (3AH) LDA FACDH
4B9EH  (B7H) ORA A
4B9FH  (C8H) RZ
4BA0H  (3EH) MVI A,0DH
4BA2H  (CDH) CALL 4B7AH
4BA5H  (AFH) XRA A
4BA6H  (32H) STA F674H      ; Line printer head position
4BA9H  (C9H) RET

4BAAH  (F1H) POP PSW

; ======================================================
; LCD character output routine
; ======================================================
4BABH  (F5H) PUSH PSW
4BACH  (CDH) CALL 4313H     ; Print A to the screen
4BAFH  (3AH) LDA F63AH      ; Cursor column (1-40)
4BB2H  (3DH) DCR A
4BB3H  (32H) STA F788H      ; Horiz. position of cursor (0-39)
4BB6H  (F1H) POP PSW
4BB7H  (C9H) RET


; ======================================================
; Move LCD to blank line (send CRLF if needed)
; ======================================================
4BB8H  (3AH) LDA F63AH      ; Cursor column (1-40)
4BBBH  (3DH) DCR A
4BBCH  (C8H) RZ
4BBDH  (C3H) JMP 4BCBH

4BC0H  (36H) MVI M,00H
4BC2H  (CDH) CALL 421AH
4BC5H  (21H) LXI H,F684H
4BC8H  (C2H) JNZ 4BD1H
4BCBH  (3EH) MVI A,0DH
4BCDH  (E7H) RST 4          ; Send character in A to screen/printer
4BCEH  (3EH) MVI A,0AH
4BD0H  (E7H) RST 4          ; Send character in A to screen/printer
4BD1H  (CDH) CALL 421AH
4BD4H  (CAH) JZ 4BD9H
4BD7H  (AFH) XRA A
4BD8H  (C9H) RET

4BD9H  (3AH) LDA F675H      ; Output device for RST 20H (0=screen)
4BDCH  (B7H) ORA A
4BDDH  (CAH) JZ 4BE5H
4BE0H  (AFH) XRA A
4BE1H  (32H) STA F674H      ; Line printer head position
4BE4H  (C9H) RET

4BE5H  (AFH) XRA A
4BE6H  (32H) STA F788H      ; Horiz. position of cursor (0-39)
4BE9H  (C9H) RET


; ======================================================
; INKEY$ function
; ======================================================
4BEAH  (D7H) RST 2          ; Get next non-white char from M
4BEBH  (E5H) PUSH H
4BECH  (CDH) CALL 13DBH     ; Check keyboard queue for pending characters
4BEFH  (CAH) JZ 4BFEH
4BF2H  (CDH) CALL 12CBH     ; Wait for key from keyboard
4BF5H  (F5H) PUSH PSW
4BF6H  (CDH) CALL 275BH     ; Create a 1-byte transient string (for CHR$ & INKEY$)
4BF9H  (F1H) POP PSW
4BFAH  (5FH) MOV E,A
4BFBH  (CDH) CALL 2965H
4BFEH  (21H) LXI H,03F5H
4C01H  (22H) SHLD FC1AH     ; Start of FAC1 for integers
4C04H  (3EH) MVI A,03H      ; Load code for String variable type
4C06H  (32H) STA FB65H      ; Type of last variable used
4C09H  (E1H) POP H
4C0AH  (C9H) RET

4C0BH  (E5H) PUSH H
4C0CH  (C3H) JMP 4C21H

; ======================================================
; Evaluate arguments to RUN/OPEN/SAVE commands
; ======================================================
4C0FH  (CDH) CALL 0DABH     ; Main BASIC evaluation routine
4C12H  (E5H) PUSH H
4C13H  (CDH) CALL 2916H     ; Get pointer to most recently used string (Len + address)
4C16H  (7EH) MOV A,M
4C17H  (B7H) ORA A
4C18H  (CAH) JZ 4C55H
4C1BH  (23H) INX H
4C1CH  (5EH) MOV E,M
4C1DH  (23H) INX H
4C1EH  (66H) MOV H,M
4C1FH  (6BH) MOV L,E
4C20H  (5FH) MOV E,A
4C21H  (CDH) CALL 5075H
4C24H  (F5H) PUSH PSW
4C25H  (01H) LXI B,FC93H    ; Filename of current BASIC program
4C28H  (16H) MVI D,09H
4C2AH  (1CH) INR E
4C2BH  (1DH) DCR E
4C2CH  (CAH) JZ 4C72H       ; Copy D SPACES to (BC)
4C2FH  (CDH) CALL 0FE8H     ; Get char at M and convert to uppercase
4C32H  (FEH) CPI 20H
4C34H  (DAH) JC 4C55H
4C37H  (FEH) CPI 7FH
4C39H  (CAH) JZ 4C55H
4C3CH  (FEH) CPI 2EH
4C3EH  (CAH) JZ 4C5CH
4C41H  (02H) STAX B
4C42H  (03H) INX B
4C43H  (23H) INX H
4C44H  (15H) DCR D
4C45H  (C2H) JNZ 4C2BH
4C48H  (F1H) POP PSW
4C49H  (F5H) PUSH PSW
4C4AH  (57H) MOV D,A
4C4BH  (3AH) LDA FC93H      ; Filename of current BASIC program
4C4EH  (3CH) INR A
4C4FH  (CAH) JZ 4C55H
4C52H  (F1H) POP PSW
4C53H  (E1H) POP H
4C54H  (C9H) RET

4C55H  (C3H) JMP 504EH      ; Generate NM error

4C58H  (23H) INX H
4C59H  (C3H) JMP 4C2BH

4C5CH  (7AH) MOV A,D
4C5DH  (FEH) CPI 09H
4C5FH  (CAH) JZ 4C55H
4C62H  (FEH) CPI 03H
4C64H  (DAH) JC 4C55H
4C67H  (CAH) JZ 4C58H
4C6AH  (3EH) MVI A,20H
4C6CH  (02H) STAX B
4C6DH  (03H) INX B
4C6EH  (15H) DCR D
4C6FH  (C3H) JMP 4C5CH

; ======================================================
; Copy D SPACES to (BC)
; ======================================================
4C72H  (3EH) MVI A,20H      ; Load ASCII value for SPACE
4C74H  (02H) STAX B         ; Store next SPACE at (BC)
4C75H  (03H) INX B          ; Increment pointer
4C76H  (15H) DCR D          ; Decrement counter
4C77H  (C2H) JNZ 4C72H      ; Keep looping until counter is zero
4C7AH  (C3H) JMP 4C48H

4C7DH  (7EH) MOV A,M
4C7EH  (23H) INX H
4C7FH  (1DH) DCR E
4C80H  (C9H) RET

4C81H  (CDH) CALL 1131H     ; Get expression integer < 256 in A or FC Error

; ======================================================
; Get file descriptor for file in A
; ======================================================
4C84H  (6FH) MOV L,A
4C85H  (3AH) LDA FC82H      ; Maxfiles
4C88H  (BDH) CMP L
4C89H  (DAH) JC 505DH       ; Generate BN error
4C8CH  (26H) MVI H,00H
4C8EH  (22H) SHLD FAA2H
4C91H  (29H) DAD H
4C92H  (EBH) XCHG
4C93H  (2AH) LHLD FC83H     ; File number description table pointer
4C96H  (19H) DAD D
4C97H  (7EH) MOV A,M
4C98H  (23H) INX H
4C99H  (66H) MOV H,M
4C9AH  (6FH) MOV L,A
4C9BH  (7EH) MOV A,M
4C9CH  (B7H) ORA A
4C9DH  (C8H) RZ
4C9EH  (E5H) PUSH H
4C9FH  (11H) LXI D,0004H
4CA2H  (19H) DAD D
4CA3H  (7EH) MOV A,M
4CA4H  (FEH) CPI 09H
4CA6H  (D2H) JNC 4CAEH
4CA9H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
4CAAH  DB   1EH
4CABH  (C3H) JMP 5060H      ; Generate IE error

4CAEH  (E1H) POP H
4CAFH  (7EH) MOV A,M
4CB0H  (B7H) ORA A
4CB1H  (37H) STC
4CB2H  (C9H) RET

4CB3H  (2BH) DCX H
4CB4H  (D7H) RST 2          ; Get next non-white char from M
4CB5H  (FEH) CPI 23H
4CB7H  (CCH) CZ 0858H       ; RST 10H routine with pre-increment of HL
4CBAH  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
4CBDH  (E3H) XTHL
4CBEH  (E5H) PUSH H
4CBFH  (CDH) CALL 4C84H     ; Get file descriptor for file in A
4CC2H  (CAH) JZ 505AH       ; Generate CF error
4CC5H  (22H) SHLD FC8CH
4CC8H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
4CC9H  DB   0CH
4CCAH  (C9H) RET


; ======================================================
; OPEN statement
; ======================================================
4CCBH  (01H) LXI B,0C39H
4CCEH  (C5H) PUSH B
4CCFH  (CDH) CALL 4C0FH     ; Evaluate arguments to RUN/OPEN/SAVE commands
4CD2H  (C2H) JNZ 4CD7H
4CD5H  (16H) MVI D,F8H
4CD7H  (CFH) RST 1          ; Compare next byte with M
4CD8H  DB   81H
4CD9H  (FEH) CPI 84H
4CDBH  (1EH) MVI E,01H
4CDDH  (CAH) JZ 4CFCH
4CE0H  (FEH) CPI 96H
4CE2H  (CAH) JZ 4CF2H
4CE5H  (CFH) RST 1          ; Compare next byte with M
4CE6H  DB   41H
4CE7H  (CFH) RST 1          ; Compare next byte with M
4CE8H  DB   50H
4CE9H  (CFH) RST 1          ; Compare next byte with M
4CEAH  DB   50H
4CEBH  (CFH) RST 1          ; Compare next byte with M
4CECH  DB   80H
4CEDH  (1EH) MVI E,08H
4CEFH  (C3H) JMP 4CFDH

4CF2H  (D7H) RST 2          ; Get next non-white char from M
4CF3H  (CFH) RST 1          ; Compare next byte with M
4CF4H  DB   50H
4CF5H  (CFH) RST 1          ; Compare next byte with M
4CF6H  DB   55H
4CF7H  (CFH) RST 1          ; Compare next byte with M
4CF8H  DB   54H
4CF9H  (1EH) MVI E,02H
4CFBH  (3EH) MVI A,D7H
4CFDH  (CFH) RST 1          ; Compare next byte with M
4CFEH  DB   41H
4CFFH  (CFH) RST 1          ; Compare next byte with M
4D00H  DB   53H
4D01H  (D5H) PUSH D
4D02H  (7EH) MOV A,M
4D03H  (FEH) CPI 23H
4D05H  (CCH) CZ 0858H       ; RST 10H routine with pre-increment of HL
4D08H  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
4D0BH  (B7H) ORA A
4D0CH  (CAH) JZ 505DH       ; Generate BN error
4D0FH  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
4D10H  DB   18H
4D11H  (1EH) MVI E,D5H
4D13H  (2BH) DCX H
4D14H  (5FH) MOV E,A
4D15H  (D7H) RST 2          ; Get next non-white char from M
4D16H  (C2H) JNZ 0446H      ; Generate Syntax error
4D19H  (E3H) XTHL
4D1AH  (7BH) MOV A,E
4D1BH  (F5H) PUSH PSW
4D1CH  (E5H) PUSH H
4D1DH  (CDH) CALL 4C84H     ; Get file descriptor for file in A
4D20H  (C2H) JNZ 5051H      ; Generate AO error
4D23H  (D1H) POP D
4D24H  (7AH) MOV A,D
4D25H  (FEH) CPI 09H
4D27H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
4D28H  DB   1CH
4D29H  (DAH) JC 5060H       ; Generate IE error
4D2CH  (E5H) PUSH H
4D2DH  (01H) LXI B,0004H
4D30H  (09H) DAD B
4D31H  (72H) MOV M,D
4D32H  (3EH) MVI A,00H
4D34H  (E1H) POP H
4D35H  (C3H) JMP 5123H

4D38H  (E5H) PUSH H
4D39H  (B7H) ORA A
4D3AH  (C2H) JNZ 4D45H
4D3DH  (3AH) LDA FCA7H
4D40H  (E6H) ANI 01H
4D42H  (C2H) JNZ 4F08H
4D45H  (CDH) CALL 4C84H     ; Get file descriptor for file in A
4D48H  (CAH) JZ 4D5DH
4D4BH  (22H) SHLD FC8CH
4D4EH  (E5H) PUSH H
4D4FH  (3EH) MVI A,02H
4D51H  (DAH) JC 5123H
4D54H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
4D55H  DB   14H
4D56H  (C3H) JMP 5060H      ; Generate IE error


; ======================================================
; LCD, CRT, and LPT file close routine
; ======================================================
4D59H  (CDH) CALL 4EFFH
4D5CH  (E1H) POP H
4D5DH  (E5H) PUSH H
4D5EH  (11H) LXI D,0007H
4D61H  (19H) DAD D
4D62H  (77H) MOV M,A
4D63H  (67H) MOV H,A
4D64H  (6FH) MOV L,A
4D65H  (22H) SHLD FC8CH
4D68H  (E1H) POP H
4D69H  (86H) ADD M
4D6AH  (36H) MVI M,00H
4D6CH  (E1H) POP H
4D6DH  (C9H) RET


; ======================================================
; RUN statement
; ======================================================
4D6EH  (37H) STC
4D6FH  (11H) LXI D,AFF6H
4D72H  (F5H) PUSH PSW
4D73H  (2BH) DCX H          ; Point to byte in BASIC command before space
4D74H  (D7H) RST 2          ; Get next non-white char from M
4D75H  (FEH) CPI 4DH        ; Test for "M"
4D77H  (CAH) JZ 2491H       ; Jump if "M" to process LOADM and RUNM statement
4D7AH  (CDH) CALL 4C0FH     ; Evaluate arguments to RUN/OPEN/SAVE commands
4D7DH  (CAH) JZ 1E7BH
4D80H  (7AH) MOV A,D
4D81H  (FEH) CPI F8H
4D83H  (CAH) JZ 1E7BH
4D86H  (FEH) CPI FDH
4D88H  (CAH) JZ 2387H
4D8BH  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
4D8CH  DB   1AH
4D8DH  (F1H) POP PSW
4D8EH  (F5H) PUSH PSW
4D8FH  (CAH) JZ 4D9FH
4D92H  (7EH) MOV A,M
4D93H  (D6H) SUI 2CH
4D95H  (B7H) ORA A
4D96H  (C2H) JNZ 4D9FH
4D99H  (D7H) RST 2          ; Get next non-white char from M
4D9AH  (CFH) RST 1          ; Compare next byte with M
4D9BH  DB   52H
4D9CH  (F1H) POP PSW
4D9DH  (37H) STC
4D9EH  (F5H) PUSH PSW
4D9FH  (F5H) PUSH PSW
4DA0H  (AFH) XRA A
4DA1H  (1EH) MVI E,01H
4DA3H  (CDH) CALL 4D12H
4DA6H  (2AH) LHLD FC8CH
4DA9H  (01H) LXI B,0007H
4DACH  (09H) DAD B
4DADH  (F1H) POP PSW
4DAEH  (9FH) SBB A
4DAFH  (E6H) ANI 80H
4DB1H  (F6H) ORI 01H
4DB3H  (32H) STA FCA7H
4DB6H  (F1H) POP PSW
4DB7H  (F5H) PUSH PSW
4DB8H  (9FH) SBB A
4DB9H  (32H) STA FC92H
4DBCH  (7EH) MOV A,M
4DBDH  (B7H) ORA A
4DBEH  (FAH) JM 4E1DH
4DC1H  (F1H) POP PSW
4DC2H  (C4H) CNZ 20FFH      ; NEW statement
4DC5H  (CDH) CALL 4E22H
4DC8H  (AFH) XRA A
4DC9H  (CDH) CALL 4CBFH
4DCCH  (C3H) JMP 0511H      ; Silent vector to BASIC ready


; ======================================================
; SAVE statement
; ======================================================
4DCFH  (FEH) CPI 4DH
4DD1H  (CAH) JZ 22CCH       ; SAVEM statement
4DD4H  (CDH) CALL 3F2CH
4DD7H  (CDH) CALL 4C0FH     ; Evaluate arguments to RUN/OPEN/SAVE commands
4DDAH  (CAH) JZ 1ED9H
4DDDH  (7AH) MOV A,D
4DDEH  (FEH) CPI F8H
4DE0H  (CAH) JZ 1ED9H
4DE3H  (FEH) CPI FDH
4DE5H  (CAH) JZ 2288H
4DE8H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
4DE9H  DB   16H
4DEAH  (2BH) DCX H
4DEBH  (D7H) RST 2          ; Get next non-white char from M
4DECH  (1EH) MVI E,80H
4DEEH  (37H) STC
4DEFH  (CAH) JZ 4DF9H
4DF2H  (CFH) RST 1          ; Compare next byte with M
4DF3H  DB   2CH
4DF4H  (CFH) RST 1          ; Compare next byte with M
4DF5H  DB   41H
4DF6H  (B7H) ORA A
4DF7H  (1EH) MVI E,02H
4DF9H  (F5H) PUSH PSW
4DFAH  (7AH) MOV A,D
4DFBH  (FEH) CPI 09H
4DFDH  (DAH) JC 4E0BH
4E00H  (7BH) MOV A,E
4E01H  (E6H) ANI 80H
4E03H  (CAH) JZ 4E0BH
4E06H  (1EH) MVI E,02H
4E08H  (F1H) POP PSW
4E09H  (AFH) XRA A
4E0AH  (F5H) PUSH PSW
4E0BH  (AFH) XRA A
4E0CH  (CDH) CALL 4D12H
4E0FH  (F1H) POP PSW
4E10H  (DAH) JC 4E18H
4E13H  (2BH) DCX H
4E14H  (D7H) RST 2          ; Get next non-white char from M
4E15H  (C3H) JMP 1140H      ; LIST statement

4E18H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
4E19H  DB   22H
4E1AH  (C3H) JMP 504EH      ; Generate NM error

4E1DH  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
4E1EH  DB   24H
4E1FH  (C3H) JMP 504EH      ; Generate NM error

; ======================================================
; CLOSE file if it is opened?
; ======================================================
4E22H  (3AH) LDA FCA7H
4E25H  (B7H) ORA A
4E26H  (F8H) RM
4E27H  (AFH) XRA A

; ======================================================
; CLOSE statement
; ======================================================
4E28H  (3AH) LDA FC82H      ; Maxfiles
4E2BH  (C2H) JNZ 4E3BH
4E2EH  (E5H) PUSH H
4E2FH  (F5H) PUSH PSW
4E30H  (B7H) ORA A
4E31H  (CDH) CALL 4D38H
4E34H  (F1H) POP PSW
4E35H  (3DH) DCR A
4E36H  (F2H) JP 4E2FH
4E39H  (E1H) POP H
4E3AH  (C9H) RET

4E3BH  (7EH) MOV A,M
4E3CH  (FEH) CPI 23H
4E3EH  (CCH) CZ 0858H       ; RST 10H routine with pre-increment of HL
4E41H  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
4E44H  (E5H) PUSH H
4E45H  (37H) STC
4E46H  (CDH) CALL 4D38H
4E49H  (E1H) POP H
4E4AH  (7EH) MOV A,M
4E4BH  (FEH) CPI 2CH
4E4DH  (C0H) RNZ
4E4EH  (D7H) RST 2          ; Get next non-white char from M
4E4FH  (C3H) JMP 4E3BH

4E52H  (E1H) POP H
4E53H  (F1H) POP PSW
4E54H  (E5H) PUSH H
4E55H  (D5H) PUSH D
4E56H  (C5H) PUSH B
4E57H  (F5H) PUSH PSW
4E58H  (2AH) LHLD FC8CH
4E5BH  (3EH) MVI A,04H
4E5DH  (CDH) CALL 4E65H
4E60H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
4E61H  DB   20H
4E62H  (C3H) JMP 504EH      ; Generate NM error

4E65H  (F5H) PUSH PSW
4E66H  (D5H) PUSH D
4E67H  (EBH) XCHG
4E68H  (21H) LXI H,0004H
4E6BH  (19H) DAD D
4E6CH  (7EH) MOV A,M
4E6DH  (EBH) XCHG
4E6EH  (D1H) POP D
4E6FH  (FEH) CPI 09H
4E71H  (DAH) JC 4F1AH
4E74H  (F1H) POP PSW
4E75H  (E3H) XTHL
4E76H  (E1H) POP H
4E77H  (C3H) JMP 5123H

4E7AH  (C5H) PUSH B
4E7BH  (E5H) PUSH H
4E7CH  (D5H) PUSH D
4E7DH  (2AH) LHLD FC8CH
4E80H  (3EH) MVI A,06H
4E82H  (CDH) CALL 4E65H
4E85H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
4E86H  DB   0EH
4E87H  (C3H) JMP 504EH      ; Generate NM error

4E8AH  (D1H) POP D
4E8BH  (E1H) POP H
4E8CH  (C1H) POP B
4E8DH  (C9H) RET


; ======================================================
; INPUT statement
; ======================================================
4E8EH  (D7H) RST 2          ; Get next non-white char from M
4E8FH  (CFH) RST 1          ; Compare next byte with M
4E90H  DB   24H
4E91H  (CFH) RST 1          ; Compare next byte with M
4E92H  DB   28H
4E93H  (E5H) PUSH H
4E94H  (2AH) LHLD FC8CH
4E97H  (E5H) PUSH H
4E98H  (21H) LXI H,0000H
4E9BH  (22H) SHLD FC8CH
4E9EH  (E1H) POP H
4E9FH  (E3H) XTHL
4EA0H  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
4EA3H  (D5H) PUSH D
4EA4H  (7EH) MOV A,M
4EA5H  (FEH) CPI 2CH
4EA7H  (C2H) JNZ 4EBBH
4EAAH  (D7H) RST 2          ; Get next non-white char from M
4EABH  (CDH) CALL 4CB3H
4EAEH  (FEH) CPI 01H
4EB0H  (CAH) JZ 4EB8H
4EB3H  (FEH) CPI 04H
4EB5H  (C2H) JNZ 5063H      ; Generate EF error
4EB8H  (E1H) POP H
4EB9H  (AFH) XRA A
4EBAH  (7EH) MOV A,M
4EBBH  (F5H) PUSH PSW
4EBCH  (CFH) RST 1          ; Compare next byte with M
4EBDH  DB   29H
4EBEH  (F1H) POP PSW
4EBFH  (E3H) XTHL
4EC0H  (F5H) PUSH PSW
4EC1H  (7DH) MOV A,L
4EC2H  (B7H) ORA A
4EC3H  (CAH) JZ 08DBH       ; Generate FC error
4EC6H  (E5H) PUSH H
4EC7H  (CDH) CALL 275DH     ; Create a transient string of length A
4ECAH  (EBH) XCHG
4ECBH  (C1H) POP B
4ECCH  (F1H) POP PSW
4ECDH  (F5H) PUSH PSW
4ECEH  (CAH) JZ 4EF6H
4ED1H  (CDH) CALL 12CBH     ; Wait for key from keyboard
4ED4H  (FEH) CPI 03H
4ED6H  (CAH) JZ 4EEBH
4ED9H  (77H) MOV M,A
4EDAH  (23H) INX H
4EDBH  (0DH) DCR C
4EDCH  (C2H) JNZ 4ECCH
4EDFH  (F1H) POP PSW
4EE0H  (C1H) POP B
4EE1H  (E1H) POP H
4EE2H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
4EE3H  DB   10H
4EE4H  (22H) SHLD FC8CH
4EE7H  (C5H) PUSH B
4EE8H  (C3H) JMP 278DH      ; Add new transient string to string stack

4EEBH  (F1H) POP PSW
4EECH  (2AH) LHLD F67AH     ; Current executing line number
4EEFH  (22H) SHLD FB9FH     ; Line number of last error
4EF2H  (E1H) POP H
4EF3H  (C3H) JMP 0422H      ; Initialize system and go to BASIC ready

4EF6H  (CDH) CALL 4E7AH
4EF9H  (DAH) JC 5063H       ; Generate EF error
4EFCH  (C3H) JMP 4ED9H

4EFFH  (CDH) CALL 4F12H
4F02H  (E5H) PUSH H
4F03H  (06H) MVI B,00H
4F05H  (CDH) CALL 4F0AH     ; Zero B bytes at M
4F08H  (E1H) POP H
4F09H  (C9H) RET


; ======================================================
; Zero B bytes at M
; ======================================================
4F0AH  (AFH) XRA A

; ======================================================
; Load B bytes at M with A
; ======================================================
4F0BH  (77H) MOV M,A
4F0CH  (23H) INX H
4F0DH  (05H) DCR B
4F0EH  (C2H) JNZ 4F0BH      ; Load B bytes at M with A
4F11H  (C9H) RET

4F12H  (2AH) LHLD FC8CH
4F15H  (11H) LXI D,0009H
4F18H  (19H) DAD D
4F19H  (C9H) RET

4F1AH  (F1H) POP PSW
4F1BH  (C9H) RET

4F1CH  (CDH) CALL 421AH
4F1FH  (CAH) JZ 083AH       ; Start executing BASIC program at HL
4F22H  (AFH) XRA A
4F23H  (CDH) CALL 4D38H
4F26H  (C3H) JMP 5054H      ; Generate DS error

4F29H  (0EH) MVI C,01H
4F2BH  (FEH) CPI 23H
4F2DH  (C0H) RNZ

; ======================================================
; PRINT # initialization routine
; ======================================================
4F2EH  (C5H) PUSH B
4F2FH  (CDH) CALL 112DH     ; Evaluate expression at M
4F32H  (CFH) RST 1          ; Compare next byte with M
4F33H  DB   2CH
4F34H  (7BH) MOV A,E
4F35H  (E5H) PUSH H
4F36H  (CDH) CALL 4CBFH
4F39H  (7EH) MOV A,M
4F3AH  (E1H) POP H
4F3BH  (C1H) POP B
4F3CH  (B9H) CMP C
4F3DH  (CAH) JZ 4F43H
4F40H  (C3H) JMP 505DH      ; Generate BN error

4F43H  (7EH) MOV A,M
4F44H  (C9H) RET

4F45H  (01H) LXI B,3F9CH
4F48H  (C5H) PUSH B
4F49H  (AFH) XRA A
4F4AH  (C3H) JMP 4D38H

4F4DH  (EFH) RST 5          ; Determine type of last var used
4F4EH  (01H) LXI B,0D31H
4F51H  (11H) LXI D,2C20H
4F54H  (C2H) JNZ 4F6FH
4F57H  (5AH) MOV E,D
4F58H  (C3H) JMP 4F6FH


; ======================================================
; LINE INPUT # statement
; ======================================================
4F5BH  (01H) LXI B,0C39H
4F5EH  (C5H) PUSH B
4F5FH  (CDH) CALL 4F29H
4F62H  (CDH) CALL 4790H     ; Find address of variable at M
4F65H  (CDH) CALL 35D9H     ; Generate TM error if last variable type not string or RET
4F68H  (D5H) PUSH D
4F69H  (01H) LXI B,09BDH
4F6CH  (AFH) XRA A
4F6DH  (57H) MOV D,A
4F6EH  (5FH) MOV E,A
4F6FH  (F5H) PUSH PSW
4F70H  (C5H) PUSH B
4F71H  (E5H) PUSH H
4F72H  (CDH) CALL 4E7AH
4F75H  (DAH) JC 5063H       ; Generate EF error
4F78H  (FEH) CPI 20H
4F7AH  (C2H) JNZ 4F82H
4F7DH  (14H) INR D
4F7EH  (15H) DCR D
4F7FH  (C2H) JNZ 4F72H
4F82H  (FEH) CPI 22H
4F84H  (C2H) JNZ 4F97H
4F87H  (7BH) MOV A,E
4F88H  (FEH) CPI 2CH
4F8AH  (3EH) MVI A,22H
4F8CH  (C2H) JNZ 4F97H
4F8FH  (57H) MOV D,A
4F90H  (5FH) MOV E,A
4F91H  (CDH) CALL 4E7AH
4F94H  (DAH) JC 4FEAH
4F97H  (21H) LXI H,F685H    ; Keyboard buffer
4F9AH  (06H) MVI B,FFH
4F9CH  (4FH) MOV C,A
4F9DH  (7AH) MOV A,D
4F9EH  (FEH) CPI 22H
4FA0H  (79H) MOV A,C
4FA1H  (CAH) JZ 4FD5H
4FA4H  (FEH) CPI 0DH
4FA6H  (E5H) PUSH H
4FA7H  (CAH) JZ 500AH
4FAAH  (E1H) POP H
4FABH  (FEH) CPI 0AH
4FADH  (C2H) JNZ 4FD5H
4FB0H  (4FH) MOV C,A
4FB1H  (7BH) MOV A,E
4FB2H  (FEH) CPI 2CH
4FB4H  (79H) MOV A,C
4FB5H  (C4H) CNZ 5044H
4FB8H  (CDH) CALL 4E7AH
4FBBH  (DAH) JC 4FEAH
4FBEH  (FEH) CPI 0AH
4FC0H  (CAH) JZ 4FB0H
4FC3H  (FEH) CPI 0DH
4FC5H  (C2H) JNZ 4FD5H
4FC8H  (7BH) MOV A,E
4FC9H  (FEH) CPI 20H
4FCBH  (CAH) JZ 4FE4H
4FCEH  (FEH) CPI 2CH
4FD0H  (3EH) MVI A,0DH
4FD2H  (CAH) JZ 4FE4H
4FD5H  (B7H) ORA A
4FD6H  (CAH) JZ 4FE4H
4FD9H  (BAH) CMP D
4FDAH  (CAH) JZ 4FEAH
4FDDH  (BBH) CMP E
4FDEH  (CAH) JZ 4FEAH
4FE1H  (CDH) CALL 5044H
4FE4H  (CDH) CALL 4E7AH
4FE7H  (D2H) JNC 4F9CH
4FEAH  (E5H) PUSH H
4FEBH  (FEH) CPI 22H
4FEDH  (CAH) JZ 4FF5H
4FF0H  (FEH) CPI 20H
4FF2H  (C2H) JNZ 5023H
4FF5H  (CDH) CALL 4E7AH
4FF8H  (DAH) JC 5023H
4FFBH  (FEH) CPI 20H
4FFDH  (CAH) JZ 4FF5H
5000H  (FEH) CPI 2CH
5002H  (CAH) JZ 5023H
5005H  (FEH) CPI 0DH
5007H  (C2H) JNZ 5015H
500AH  (CDH) CALL 4E7AH
500DH  (DAH) JC 5023H
5010H  (FEH) CPI 0AH
5012H  (CAH) JZ 5023H
5015H  (2AH) LHLD FC8CH
5018H  (4FH) MOV C,A
5019H  (3EH) MVI A,08H
501BH  (CDH) CALL 4E65H
501EH  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
501FH  DB   12H
5020H  (C3H) JMP 504EH      ; Generate NM error

5023H  (E1H) POP H
5024H  (36H) MVI M,00H
5026H  (21H) LXI H,F684H
5029H  (7BH) MOV A,E
502AH  (D6H) SUI 20H
502CH  (CAH) JZ 5036H
502FH  (06H) MVI B,00H
5031H  (CDH) CALL 276EH
5034H  (E1H) POP H
5035H  (C9H) RET

5036H  (EFH) RST 5          ; Determine type of last var used
5037H  (F5H) PUSH PSW
5038H  (D7H) RST 2          ; Get next non-white char from M
5039H  (F1H) POP PSW
503AH  (F5H) PUSH PSW
503BH  (DCH) CC 3840H       ; Convert ASCII number at M to double precision in FAC1
503EH  (F1H) POP PSW
503FH  (D4H) CNC 3840H      ; Convert ASCII number at M to double precision in FAC1
5042H  (E1H) POP H
5043H  (C9H) RET

5044H  (B7H) ORA A
5045H  (C8H) RZ
5046H  (77H) MOV M,A
5047H  (23H) INX H
5048H  (05H) DCR B
5049H  (C0H) RNZ
504AH  (F1H) POP PSW
504BH  (C3H) JMP 5024H


; ======================================================
; Generate NM error
;
; The DB 01H embedded between the MVI makes the codes
; after the entry code look like an LXI B,XX1EH opcode.
; This is done to save space in the ROM.
; ======================================================
504EH  (1EH) MVI E,37H
5050H  DB  01H
5051H  (1EH) MVI E,35H      ; Load code for AO Error
5053H  DB  01H
5054H  (1EH) MVI E,38H      ; Load code for DS Error
5056H  DB  01H
5057H  (1EH) MVI E,34H      ; Load code for FF Error
5059H  DB  01H
505AH  (1EH) MVI E,3AH      ; Load code for CF Error
505CH  DB  01H
505DH  (1EH) MVI E,33H      ; Load code for BN Error
505FH  DB  01H
5060H  (1EH) MVI E,32H      ; Load code for IE Error
5062H  DB  01H
5063H  (1EH) MVI E,36H      ; Load code for EF Error
5065H  DB  01H
5066H  (1EH) MVI E,39H      ; Load code for FL Error
5068H  (C3H) JMP 045DH      ; Generate error in E

; ======================================================
; LOF function
; ======================================================
506BH  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
506CH  DB   4EH

; ======================================================
; LOC function
; ======================================================
506DH  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
506EH  DB   50H

; ======================================================
; LFILES function
; ======================================================
506FH  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
5070H  DB   52H

; ======================================================
; DSKO$ function
; ======================================================
5071H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
5072H  DB   56H

; ======================================================
; DSKI$ function
; ======================================================
5073H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
5074H  DB   54H
5075H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
5076H  DB   28H
5077H  (7EH) MOV A,M
5078H  (FEH) CPI 3AH
507AH  (DAH) JC 5096H
507DH  (E5H) PUSH H
507EH  (53H) MOV D,E
507FH  (CDH) CALL 4C7DH
5082H  (CAH) JZ 5090H
5085H  (FEH) CPI 3AH
5087H  (CAH) JZ 509BH
508AH  (CDH) CALL 4C7DH
508DH  (F2H) JP 5085H
5090H  (5AH) MOV E,D
5091H  (E1H) POP H
5092H  (AFH) XRA A
5093H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
5094H  DB   2AH
5095H  (C9H) RET

5096H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
5097H  DB   2EH
5098H  (C3H) JMP 504EH      ; Generate NM error

509BH  (7AH) MOV A,D
509CH  (93H) SUB E
509DH  (3DH) DCR A
509EH  (FEH) CPI 02H
50A0H  (D2H) JNC 50A8H
50A3H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
50A4H  DB   2CH
50A5H  (C3H) JMP 504EH      ; Generate NM error

50A8H  (FEH) CPI 05H
50AAH  (D2H) JNC 504EH      ; Generate NM error
50ADH  (C1H) POP B
50AEH  (D5H) PUSH D
50AFH  (C5H) PUSH B
50B0H  (4FH) MOV C,A
50B1H  (47H) MOV B,A
50B2H  (11H) LXI D,50F1H
50B5H  (E3H) XTHL
50B6H  (E5H) PUSH H
50B7H  (CDH) CALL 0FE8H     ; Get char at M and convert to uppercase
50BAH  (C5H) PUSH B
50BBH  (47H) MOV B,A
50BCH  (1AH) LDAX D
50BDH  (23H) INX H
50BEH  (13H) INX D
50BFH  (B8H) CMP B
50C0H  (C1H) POP B
50C1H  (C2H) JNZ 50DCH
50C4H  (0DH) DCR C
50C5H  (C2H) JNZ 50B7H
50C8H  (1AH) LDAX D
50C9H  (B7H) ORA A
50CAH  (FAH) JM 50D7H
50CDH  (FEH) CPI 31H
50CFH  (C2H) JNZ 50DCH
50D2H  (13H) INX D
50D3H  (1AH) LDAX D
50D4H  (C3H) JMP 50DCH

50D7H  (E1H) POP H
50D8H  (E1H) POP H
50D9H  (D1H) POP D
50DAH  (B7H) ORA A
50DBH  (C9H) RET

50DCH  (B7H) ORA A
50DDH  (FAH) JM 50C8H
50E0H  (1AH) LDAX D
50E1H  (B7H) ORA A
50E2H  (13H) INX D
50E3H  (F2H) JP 50E0H
50E6H  (48H) MOV C,B
50E7H  (E1H) POP H
50E8H  (E5H) PUSH H
50E9H  (1AH) LDAX D
50EAH  (B7H) ORA A
50EBH  (C2H) JNZ 50B7H
50EEH  (C3H) JMP 504EH      ; Generate NM error

; ======================================================
; Device name table
; ======================================================
50F1H  DB   "LCD",FFH
50F5H  DB   "CRT",FEH
50F9H  DB   "CAS",FDH
50FDH  DB   "COM",FCH
5101H  DB   "WAND",FBH
5106H  DB   "LPT",FAH
510AH  DB   "MDM",F9H
510EH  DB   "RAM",F8H
5112H  DB   00H

; ======================================================
; Device control block vector addresses table
; ======================================================
5113H  DW   14D2H,14F2H,167FH,1762H
511BH  DW   1877H,1754H,17D1H,14FCH

; ======================================================
; Call OPEN Hook and DCB Vector identified in A
;
; A = DCB vector number
; HL = Pointer to File Control Block for file #
; ======================================================
5123H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
5124H  DB   30H             ; OPEN hook
5125H  (E5H) PUSH H         ; Save FCB pointer on stack
5126H  (D5H) PUSH D         ; Preserve DE
5127H  (F5H) PUSH PSW       ; Save vector number to stack
5128H  (11H) LXI D,0004H    ; Load offset in FCB of device type identifier
512BH  (19H) DAD D          ; Point to FCB device type location
512CH  (3EH) MVI A,FFH      ; Prepare to calculate device type offset
512EH  (96H) SUB M          ; Calculate device type offset in DCB vector address table
512FH  (87H) ADD A          ; Multiply x2 since each entry is 2 bytes
5130H  (5FH) MOV E,A        ; Move to DE to index into table
5131H  (16H) MVI D,00H      ; Clear MSB of index
5133H  (21H) LXI H,5113H    ; Load pointer to DCB vector address table
5136H  (19H) DAD D          ; Index into the DCB vector address table for appropriate device
5137H  (5EH) MOV E,M        ; Get LSB of pointer to DCB vector address table
5138H  (23H) INX H          ; Point to MSB
5139H  (56H) MOV D,M        ; Get MSB of pointer to DCB vector address table
513AH  (F1H) POP PSW        ; Restore index of DCB vector to call
513BH  (6FH) MOV L,A        ; Prepare to point to selected vector in table
513CH  (26H) MVI H,00H      ; Clear MSB to perform index into table
513EH  (19H) DAD D          ; Index into DCB vector table
513FH  (5EH) MOV E,M        ; Get LSB of selected DCB table vector
5140H  (23H) INX H          ; Point to MSB
5141H  (56H) MOV D,M        ; Get MSB of selected DCB table vector
5142H  (EBH) XCHG           ; Put vector in HL
5143H  (D1H) POP D          ; Restore DE
5144H  (E3H) XTHL           ; Put selected table vector on Stack
5145H  (C9H) RET            ; And return to it

; ======================================================
; TELCOM Entry point
; ======================================================
5146H  (CDH) CALL 4244H     ; Resume automatic scrolling
5149H  (21H) LXI H,51A4H    ; Get pointer to TELCOM FKey labels
514CH  (CDH) CALL 42A5H     ; Set and display function keys (M has key table)
514FH  (C3H) JMP 51C7H      ; Print current STAT settings

; ======================================================
; TELCOM ON ERROR Handler
; ======================================================
5152H  (CDH) CALL 4229H     ; BEEP statement
5155H  (21H) LXI H,51A4H    ; Load pointer to Main FKeys
5158H  (CDH) CALL 5A7CH     ; Set new function key table

; ======================================================
; Re-entry point for TELCOM commands
; ======================================================
515BH  (CDH) CALL 5D53H
515EH  (21H) LXI H,5152H    ; Load pointer to TELCOM ON ERROR handler
5161H  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
5164H  (21H) LXI H,517CH    ; Load pointer to "Telcom: " prompt
5167H  (CDH) CALL 5791H     ; Print buffer at M until NULL or '"'
516AH  (CDH) CALL 4644H     ; Input and display (no "?") line and store
516DH  (D7H) RST 2          ; Get next non-white char from M
516EH  (A7H) ANA A          ; Test if TELCOM command is NULL
516FH  (CAH) JZ 515BH       ; Re-entry point for TELCOM commands
5172H  (11H) LXI D,5185H    ; Load pointer to TELCOM instruction vector table
5175H  (CDH) CALL 6CA7H
5178H  (CAH) JZ 5152H       ; Jump to ON ERROR handler if error
517BH  (C9H) RET

517CH  DB   "Telcom: ",00H

; ======================================================
; TELCOM instruction vector table
; ======================================================
5185H  DB   "STAT"
5189H  DW   51C0H
518BH  DB   "TERM"
518FH  DW   5455H
5191H  DB   "CALL"
5195H  DW   522FH
5197H  DB   "FIND"
519BH  DW   524DH
519DH  DB   "MENU"
51A1H  DW   5797H
51A3H  DB   FFH

; ======================================================
; TELCOM label line text table
; ======================================================
51A4H  DB   "Find",A0H
51A9H  DB   "Call",A0H
51AEH  DB   "Stat",A0H
51B3H  DB   "Term",8DH
51B8H  DB   80H
51B9H  DB   80H
51BAH  DB   80H
51BBH  DB   "Menu",8DH

; ======================================================
; TELCOM STAT instruction routine
; ======================================================
51C0H  (2BH) DCX H
51C1H  (D7H) RST 2          ; Get next non-white char from M
51C2H  (3CH) INR A
51C3H  (3DH) DCR A
51C4H  (C2H) JNZ 51EDH      ; Set STAT and return to TELCOM ready

; ======================================================
; Print current STAT settings
; ======================================================
51C7H  (21H) LXI H,F65BH    ; RS232 parameter setting table
51CAH  (06H) MVI B,05H
51CCH  (7EH) MOV A,M
51CDH  (E7H) RST 4          ; Send character in A to screen/printer
51CEH  (23H) INX H
51CFH  (05H) DCR B
51D0H  (C2H) JNZ 51CCH
51D3H  (3EH) MVI A,2CH
51D5H  (E7H) RST 4          ; Send character in A to screen/printer
51D6H  (3AH) LDA F62BH      ; Dial speed (1=10pps, 2=20pps)
51D9H  (0FH) RRC
51DAH  (3EH) MVI A,32H
51DCH  (98H) SBB B
51DDH  (E7H) RST 4          ; Send character in A to screen/printer
51DEH  (21H) LXI H,51E7H    ; Load pointer to "0 pps" text
51E1H  (CDH) CALL 27B1H     ; Print buffer at M until NULL or '"'
51E4H  (C3H) JMP 515BH      ; Re-entry point for TELCOM commands

51E7H  DB   "0 pps",00H

; ======================================================
; Set STAT and return to TELCOM ready
; ======================================================
51EDH  (DAH) JC 51FEH
51F0H  (FEH) CPI 2CH
51F2H  (CAH) JZ 520AH
51F5H  (CDH) CALL 0FE9H     ; Convert A to uppercase
51F8H  (FEH) CPI 4DH
51FAH  (C2H) JNZ 5152H
51FDH  (23H) INX H
51FEH  (CDH) CALL 17E6H     ; Set RS232 parameters from string at M
5201H  (CDH) CALL 6ECBH     ; Deactivate RS232 or modem
5204H  (2BH) DCX H
5205H  (D7H) RST 2          ; Get next non-white char from M
5206H  (A7H) ANA A
5207H  (CAH) JZ 515BH       ; Re-entry point for TELCOM commands
520AH  (CFH) RST 1          ; Compare next byte with M
520BH  DB   2CH
520CH  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
520FH  (FEH) CPI 14H
5211H  (CAH) JZ 521AH
5214H  (D6H) SUI 0AH
5216H  (C2H) JNZ 5152H
5219H  (3CH) INR A
521AH  (32H) STA F62BH      ; Dial speed (1=10pps, 2=20pps)
521DH  (C3H) JMP 515BH      ; Re-entry point for TELCOM commands

5220H  (21H) LXI H,5244H
5223H  (CDH) CALL 5A58H     ; Print NULL terminated string at M
5226H  (D1H) POP D
5227H  (CDH) CALL 5284H
522AH  (CAH) JZ 5152H
522DH  (EBH) XCHG
522EH  (F6H) ORI 37H
5230H  (E5H) PUSH H
5231H  (21H) LXI H,5244H    ; Load pointer to "Calling " text
5234H  (DCH) CC 5A58H       ; Print NULL terminated string at M
5237H  (E1H) POP H
5238H  (CDH) CALL 532DH     ; Execute logon sequence at M
523BH  (DAH) JC 5152H
523EH  (C2H) JNZ 515BH      ; Re-entry point for TELCOM commands
5241H  (C3H) JMP 5468H

5244H  DB   "Calling ",00H

; ======================================================
; TELCOM FIND instruction routine
; ======================================================
524DH  (97H) SUB A
524EH  (CDH) CALL 5DB1H
5251H  (E5H) PUSH H
5252H  (CDH) CALL 5AA6H
5255H  (CAH) JZ 5152H
5258H  (CDH) CALL 5AE3H     ; Get start address of file at M
525BH  (EBH) XCHG
525CH  (E1H) POP H
525DH  (CDH) CALL 5C3FH     ; Find text at M in the file at (DE)
5260H  (D2H) JNC 515BH      ; Re-entry point for TELCOM commands
5263H  (E5H) PUSH H
5264H  (D5H) PUSH D
5265H  (CDH) CALL 5DC5H
5268H  (CDH) CALL 5284H
526BH  (C4H) CNZ 5292H
526EH  (CDH) CALL 4222H     ; Send CRLF to screen or printer
5271H  (CDH) CALL 5C7FH
5274H  (CAH) JZ 515BH       ; Re-entry point for TELCOM commands
5277H  (FEH) CPI 43H
5279H  (CAH) JZ 5220H
527CH  (D1H) POP D
527DH  (CDH) CALL 5C6DH     ; Increment DE past next CRLF in text file at (DE)
5280H  (E1H) POP H
5281H  (C3H) JMP 525DH

5284H  (CDH) CALL 52A8H
5287H  (C8H) RZ
5288H  (E7H) RST 4          ; Send character in A to screen/printer
5289H  (FEH) CPI 3AH
528BH  (13H) INX D
528CH  (C2H) JNZ 5284H
528FH  (C3H) JMP 52AEH

5292H  (CDH) CALL 52A8H
5295H  (C8H) RZ
5296H  (FEH) CPI 3CH
5298H  (CAH) JZ 52A3H
529BH  (FEH) CPI 3AH
529DH  (C8H) RZ
529EH  (E7H) RST 4          ; Send character in A to screen/printer
529FH  (13H) INX D
52A0H  (C3H) JMP 5292H

52A3H  (E7H) RST 4          ; Send character in A to screen/printer
52A4H  (3EH) MVI A,3EH
52A6H  (E7H) RST 4          ; Send character in A to screen/printer
52A7H  (C9H) RET

52A8H  (CDH) CALL 5C74H     ; Check next byte(s) at (DE) for CRLF
52ABH  (1BH) DCX D
52ACH  (1AH) LDAX D
52ADH  (C8H) RZ
52AEH  (FEH) CPI 1AH
52B0H  (CAH) JZ 5152H
52B3H  (C9H) RET


; ======================================================
; Go off-hook
; ======================================================
52B4H  (DBH) IN BAH         ; Get current value of 8155 Port B
52B6H  (E6H) ANI 7FH        ; Clear /RTS bit to connect phone line
52B8H  (D3H) OUT BAH        ; Send new value to I/O port
52BAH  (C9H) RET


; ======================================================
; Disconnect phone line and disable modem carrier
; ======================================================
52BBH  (CDH) CALL 52D8H     ; Disable modem carrier
52BEH  (CDH) CALL 5351H
52C1H  (DBH) IN BAH         ; Get current value of 8155 Port B
52C3H  (F6H) ORI 80H        ; Set /RTS bit to disconnect phone line
52C5H  (D3H) OUT BAH        ; Send new value to I/O port
52C7H  (C9H) RET

; ======================================================
; Connect phone line 
; ======================================================
52C8H  (3AH) LDA FAAEH      ; Contents of port A8H
52CBH  (F6H) ORI 01H        ; Set bit to connect phone line
52CDH  (C3H) JMP 52DDH      ; Update Modem enable and RS-232 mux settings from A

; ======================================================
; Connect phone line and enable modem carrier
; ======================================================
52D0H  (CDH) CALL 52B4H     ; Go off-hook
52D3H  (3EH) MVI A,03H      ; Set bits to connect phone & enable modem
52D5H  (C3H) JMP 52DDH      ; Update Modem enable and RS-232 mux settings from A

; ======================================================
; Disable Modem carrier
; ======================================================
52D8H  (3AH) LDA FAAEH      ; Contents of port A8H
52DBH  (E6H) ANI 01H        ; Clear Modem Enable bit

; ======================================================
; Update Modem enable and RS-232 mux settings from A
; ======================================================
52DDH  (32H) STA FAAEH      ; Contents of port A8H
52E0H  (D3H) OUT A8H
52E2H  (37H) STC
52E3H  (C9H) RET

; ======================================================
; Go off-hook and wait for carrier
; ======================================================
52E4H  (DBH) IN BBH
52E6H  (E6H) ANI 10H
52E8H  (CAH) JZ 52F9H
52EBH  (CDH) CALL 52D0H     ; Connect phone line and enable modem carrier
52EEH  (CDH) CALL 729FH     ; Check if SHIFT-BREAK is being pressed
52F1H  (D8H) RC
52F2H  (CDH) CALL 6EEFH     ; Check for carrier detect
52F5H  (C2H) JNZ 52EEH
52F8H  (C9H) RET

52F9H  (CDH) CALL 52C8H     ; Connect phone line
52FCH  (CDH) CALL 52B4H     ; Go off-hook
52FFH  (00H) NOP
5300H  (00H) NOP
5301H  (00H) NOP
5302H  (CDH) CALL 52EEH
5305H  (D8H) RC
5306H  (3EH) MVI A,05H
5308H  (CDH) CALL 5316H
530BH  (CDH) CALL 52D0H     ; Connect phone line and enable modem carrier
530EH  (A7H) ANA A
530FH  (C9H) RET


; ======================================================
; Pause for about 2 seconds
; ======================================================
5310H  (AFH) XRA A
5311H  (3EH) MVI A,05H
5313H  (C4H) CNZ 531AH
5316H  (3DH) DCR A
5317H  (C2H) JNZ 5313H
531AH  (0EH) MVI C,C8H
531CH  (CDH) CALL 5326H
531FH  (CDH) CALL 5326H
5322H  (0DH) DCR C
5323H  (C2H) JNZ 531CH
5326H  (06H) MVI B,ACH
5328H  (05H) DCR B
5329H  (C2H) JNZ 5328H
532CH  (C9H) RET


; ======================================================
; Execute logon sequence at M
; ======================================================
532DH  (DBH) IN BAH
532FH  (F5H) PUSH PSW
5330H  (F6H) ORI 08H
5332H  (D3H) OUT BAH
5334H  (CDH) CALL 5359H     ; Dialing routine
5337H  (C1H) POP B
5338H  (F5H) PUSH PSW
5339H  (78H) MOV A,B
533AH  (E6H) ANI 08H
533CH  (47H) MOV B,A
533DH  (DBH) IN BAH
533FH  (E6H) ANI F7H
5341H  (B0H) ORA B
5342H  (D3H) OUT BAH
5344H  (F1H) POP PSW
5345H  (D0H) RNC
5346H  (CDH) CALL 52BBH     ; Disconnect phone line and disable modem carrier
5349H  (CDH) CALL 52C8H     ; Connect phone line??
534CH  (3EH) MVI A,03H
534EH  (CDH) CALL 5316H
5351H  (3AH) LDA FAAEH      ; Contents of port A8H
5354H  (E6H) ANI 02H
5356H  (C3H) JMP 52DDH      ; Update Modem enable and RS-232 mux settings from A

; ======================================================
; Dialing routine
; ======================================================
5359H  (AFH) XRA A
535AH  (32H) STA FAAEH      ; Contents of port A8H
535DH  (CDH) CALL 52C1H
5360H  (CDH) CALL 52C8H     ; Connect phone line
5363H  (CDH) CALL 531AH
5366H  (CDH) CALL 52D0H     ; Connect phone line and enable modem carrier
5369H  (CDH) CALL 52D8H     ; Disable modem carrier
536CH  (CDH) CALL 5310H     ; Pause for about 2 seconds
536FH  (2BH) DCX H
5370H  (CDH) CALL 729FH     ; Check if SHIFT-BREAK is being pressed
5373H  (D8H) RC
5374H  (E5H) PUSH H
5375H  (EBH) XCHG
5376H  (CDH) CALL 5C74H     ; Check next byte(s) at (DE) for CRLF
5379H  (1BH) DCX D
537AH  (1AH) LDAX D
537BH  (E1H) POP H
537CH  (CAH) JZ 539EH       ; Auto logon sequence
537FH  (FEH) CPI 1AH
5381H  (CAH) JZ 539EH       ; Auto logon sequence
5384H  (D7H) RST 2          ; Get next non-white char from M
5385H  (CAH) JZ 539EH       ; Auto logon sequence
5388H  (F5H) PUSH PSW
5389H  (DCH) CC 540AH       ; Dial the digit in A & print on LCD
538CH  (F1H) POP PSW
538DH  (DAH) JC 5370H
5390H  (FEH) CPI 3CH
5392H  (37H) STC
5393H  (CAH) JZ 539EH       ; Auto logon sequence
5396H  (FEH) CPI 3DH
5398H  (CCH) CZ 5310H       ; Pause for about 2 seconds
539BH  (C3H) JMP 5370H


; ======================================================
; Auto logon sequence
; ======================================================
539EH  (F5H) PUSH PSW
539FH  (3AH) LDA F62BH      ; Dial speed (1=10pps, 2=20pps
53A2H  (0FH) RRC
53A3H  (D4H) CNC 531AH
53A6H  (F1H) POP PSW
53A7H  (D2H) JNC 52BBH      ; Disconnect phone line and disable modem carrier
53AAH  (3AH) LDA F65BH      ; RS232 parameter setting table
53ADH  (FEH) CPI 4DH
53AFH  (37H) STC
53B0H  (C0H) RNZ
53B1H  (E5H) PUSH H
53B2H  (21H) LXI H,F65CH
53B5H  (A7H) ANA A
53B6H  (CDH) CALL 17E6H     ; Set RS232 parameters from string at M
53B9H  (3EH) MVI A,04H
53BBH  (CDH) CALL 5316H
53BEH  (E1H) POP H
53BFH  (CDH) CALL 52E4H     ; Go off-hook and wait for carrier
53C2H  (D8H) RC
53C3H  (CDH) CALL 5673H
53C6H  (CDH) CALL 5406H
53C9H  (C8H) RZ
53CAH  (FEH) CPI 3EH
53CCH  (C8H) RZ
53CDH  (FEH) CPI 3DH
53CFH  (CAH) JZ 53E7H
53D2H  (FEH) CPI 5EH
53D4H  (CAH) JZ 53FDH
53D7H  (FEH) CPI 3FH
53D9H  (CAH) JZ 53EDH
53DCH  (FEH) CPI 21H
53DEH  (CCH) CZ 5406H
53E1H  (C8H) RZ
53E2H  (CDH) CALL 6E32H     ; Send character in A to serial port using XON/XOFF
53E5H  (AFH) XRA A
53E6H  (3CH) INR A
53E7H  (CCH) CZ 5310H       ; Pause for about 2 seconds
53EAH  (C3H) JMP 53C3H

53EDH  (CDH) CALL 5406H
53F0H  (C8H) RZ
53F1H  (CDH) CALL 6D7EH     ; Get a character from RS232 receive queue
53F4H  (D8H) RC
53F5H  (E7H) RST 4          ; Send character in A to screen/printer
53F6H  (BEH) CMP M
53F7H  (C2H) JNZ 53F1H
53FAH  (C3H) JMP 53C3H

53FDH  (CDH) CALL 5406H
5400H  (C8H) RZ
5401H  (E6H) ANI 1FH
5403H  (C3H) JMP 53E2H

5406H  (23H) INX H
5407H  (7EH) MOV A,M
5408H  (A7H) ANA A
5409H  (C9H) RET


; ======================================================
; Dial the digit in A & print on LCD
; ======================================================
540AH  (E7H) RST 4          ; Send character in A to screen/printer
540BH  (F3H) DI
540CH  (E6H) ANI 0FH
540EH  (4FH) MOV C,A
540FH  (C2H) JNZ 5414H
5412H  (0EH) MVI C,0AH
5414H  (3AH) LDA F62BH      ; Dial speed (1=10pps, 2=20pps
5417H  (0FH) RRC
5418H  (11H) LXI D,161CH
541BH  (D2H) JNC 5421H
541EH  (11H) LXI D,2440H
5421H  (CDH) CALL 52C1H
5424H  (CDH) CALL 5326H
5427H  (1DH) DCR E
5428H  (C2H) JNZ 5424H
542BH  (CDH) CALL 52B4H     ; Go off-hook
542EH  (CDH) CALL 5326H
5431H  (15H) DCR D
5432H  (C2H) JNZ 542EH
5435H  (0DH) DCR C
5436H  (C2H) JNZ 5414H
5439H  (FBH) EI
543AH  (3AH) LDA F62BH      ; Dial speed (1=10pps, 2=20pps
543DH  (E6H) ANI 01H
543FH  (3CH) INR A
5440H  (C3H) JMP 5316H

; ======================================================
; TELCOM TERM FKey Label table
; ======================================================
5443H  DB   "Pre",F6H
5447H  DB   "Dow",EEH
544BH  DB   " U",F0H
544EH  DB   80H
544FH  DB   80H
5450H  DB   80H
5451H  DB   80H
5452H  DB   "By",E5H

; ======================================================
; TELCOM TERM instruction routine
; ======================================================
5455H  (21H) LXI H,F65AH    ; RS232 auto linefeed switch
5458H  (D7H) RST 2          ; Get next non-white char from M
5459H  (D4H) CNC 3457H      ; Increment HL and return
545CH  (F5H) PUSH PSW
545DH  (CDH) CALL 17E6H     ; Set RS232 parameters from string at M
5460H  (F1H) POP PSW
5461H  (3FH) CMC
5462H  (DCH) CC 52E4H       ; Go off-hook and wait for carrier
5465H  (DAH) JC 5739H
5468H  (3EH) MVI A,40H
546AH  (32H) STA F650H
546DH  (32H) STA F67BH
5470H  (AFH) XRA A
5471H  (32H) STA FAC2H
5474H  (32H) STA FAC3H
5477H  (CDH) CALL 45D3H
547AH  (21H) LXI H,5443H    ; Load TELCOM TERM FKey table pointer
547DH  (CDH) CALL 5A7CH     ; Set new function key table
5480H  (CDH) CALL 5544H
5483H  (CDH) CALL 5556H
5486H  (CDH) CALL 5562H
5489H  (CDH) CALL 42A8H     ; Display function key line
548CH  (CDH) CALL 4249H     ; Turn the cursor on
548FH  (CDH) CALL 5D5DH
5492H  (21H) LXI H,54EFH
5495H  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
5498H  (3AH) LDA FF42H      ; XON/XOFF enable flag
549BH  (A7H) ANA A
549CH  (CAH) JZ 54AAH
549FH  (3AH) LDA FF40H      ; XON/XOFF protocol control
54A2H  (21H) LXI H,F7D9H
54A5H  (AEH) XRA M
54A6H  (0FH) RRC
54A7H  (DCH) CC 5562H
54AAH  (CDH) CALL 13DBH     ; Check keyboard queue for pending characters
54ADH  (CAH) JZ 54C6H
54B0H  (CDH) CALL 12CBH     ; Wait for key from keyboard
54B3H  (DAH) JC 54FCH       ; TELCOM "dispatcher" routine
54B6H  (47H) MOV B,A
54B7H  (3AH) LDA F658H      ; Full/Half duplex switch
54BAH  (A7H) ANA A
54BBH  (78H) MOV A,B
54BCH  (CCH) CZ 4B44H       ; Send A to screen or printer
54BFH  (A7H) ANA A
54C0H  (C4H) CNZ 6E32H      ; Send character in A to serial port using XON/XOFF
54C3H  (DAH) JC 54E2H
54C6H  (CDH) CALL 6D6DH     ; Check RS232 queue for pending characters
54C9H  (CAH) JZ 548FH
54CCH  (CDH) CALL 6D7EH     ; Get a character from RS232 receive queue
54CFH  (DAH) JC 548FH
54D2H  (E7H) RST 4          ; Send character in A to screen/printer
54D3H  (47H) MOV B,A
54D4H  (3AH) LDA F659H
54D7H  (A7H) ANA A
54D8H  (78H) MOV A,B
54D9H  (C4H) CNZ 4B55H      ; Print A to printer, expanding tabs if necessary
54DCH  (CDH) CALL 56C5H
54DFH  (C3H) JMP 548FH

54E2H  (AFH) XRA A
54E3H  (32H) STA FF40H      ; XON/XOFF protocol control
54E6H  (CDH) CALL 729FH     ; Check if SHIFT-BREAK is being pressed
54E9H  (DAH) JC 54E6H
54ECH  (C3H) JMP 548FH

54EFH  (CDH) CALL 4229H     ; BEEP statement
54F2H  (AFH) XRA A
54F3H  (32H) STA F659H
54F6H  (CDH) CALL 5556H
54F9H  (C3H) JMP 548FH


; ======================================================
; TELCOM "dispatcher" routine
; ======================================================
54FCH  (5FH) MOV E,A
54FDH  (16H) MVI D,FFH
54FFH  (21H) LXI H,551DH    ; TERM Mode function key vector table
5502H  (19H) DAD D
5503H  (19H) DAD D
5504H  (7EH) MOV A,M
5505H  (23H) INX H
5506H  (66H) MOV H,M
5507H  (6FH) MOV L,A
5508H  (11H) LXI D,548FH
550BH  (D5H) PUSH D
550CH  (E9H) PCHL


; ======================================================
; TERM Mode function key vector table
; ======================================================
550DH  DW   5523H,567EH,559DH,553EH
5515H  DW   5550H,551DH,5520H,571EH

551DH  DB   FFH

551EH  (32H) STA FFC9H
5521H  (34H) INR M
5522H  (C9H) RET


; ======================================================
; TELCOM PREV function routine
; ======================================================
5523H  (CDH) CALL 43A2H     ; Conditionally POP PSW from stack based on value at FAC7H
5526H  (CDH) CALL 424EH     ; Turn the cursor off
5529H  (CDH) CALL 461FH
552CH  (CDH) CALL 13DBH     ; Check keyboard queue for pending characters
552FH  (CAH) JZ 552CH
5532H  (CDH) CALL 12CBH     ; Wait for key from keyboard
5535H  (CDH) CALL 4601H
5538H  (CDH) CALL 4249H     ; Turn the cursor on
553BH  (C3H) JMP 4262H      ; Send ESC X


; ======================================================
; TELCOM FULL/HALF function routine
; ======================================================
553EH  (21H) LXI H,F658H    ; Full/Half duplex switch
5541H  (7EH) MOV A,M
5542H  (2FH) CMA
5543H  (77H) MOV M,A
5544H  (3AH) LDA F658H      ; Full/Half duplex switch
5547H  (11H) LXI D,F7B9H
554AH  (21H) LXI H,5583H    ; Load pointer to TELCOM "FullHalfEcho" text
554DH  (C3H) JMP 556BH


; ======================================================
; TELCOM ECHO function routine
; ======================================================
5550H  (21H) LXI H,F659H
5553H  (7EH) MOV A,M
5554H  (2FH) CMA
5555H  (77H) MOV M,A
5556H  (3AH) LDA F659H
5559H  (11H) LXI D,F7C9H
555CH  (21H) LXI H,558BH
555FH  (C3H) JMP 556BH

5562H  (3AH) LDA FF40H      ; XON/XOFF protocol control
5565H  (11H) LXI D,F7D9H
5568H  (21H) LXI H,5595H    ; Load pointer to "Wait" text
556BH  (A7H) ANA A
556CH  (01H) LXI B,0004H
556FH  (C2H) JNZ 5573H
5572H  (09H) DAD B
5573H  (41H) MOV B,C
5574H  (CDH) CALL 2542H     ; Move B bytes from M to (DE)
5577H  (06H) MVI B,0CH
5579H  (AFH) XRA A
557AH  (12H) STAX D
557BH  (13H) INX D
557CH  (05H) DCR B
557DH  (C2H) JNZ 557AH
5580H  (C3H) JMP 5A9EH      ; Display function keys on 8th line

5583H  DB   "FullHalfEcho    ",0DH," "
5595H  DB   "Wait ",00H
559BH  DB   20H,20H


; ======================================================
; TELCOM UP function routine
; ======================================================
559DH  (21H) LXI H,56EFH    ; Load TELCOM UP ON ERROR handler address
55A0H  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
55A3H  (E5H) PUSH H
55A4H  (3AH) LDA FAC2H
55A7H  (A7H) ANA A
55A8H  (C0H) RNZ
55A9H  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
55ACH  (21H) LXI H,5751H    ; Load pointer to "File to upload" text
55AFH  (CDH) CALL 5791H     ; Print buffer at M until NULL or '"'
55B2H  (CDH) CALL 463EH     ; Input and display line and store
55B5H  (D7H) RST 2          ; Get next non-white char from M
55B6H  (A7H) ANA A
55B7H  (C8H) RZ
55B8H  (32H) STA FAC6H
55BBH  (CDH) CALL 21FAH     ; Count length of string at M
55BEH  (CDH) CALL 4C0BH
55C1H  (C0H) RNZ
55C2H  (CDH) CALL 208FH
55C5H  (21H) LXI H,577CH    ; Load pointer to "No file" text
55C8H  (CAH) JZ 5791H       ; Print buffer at M until NULL or '"'
55CBH  (EBH) XCHG
55CCH  (E3H) XTHL
55CDH  (E5H) PUSH H
55CEH  (21H) LXI H,670CH    ; Load pointer to "Width:" text
55D1H  (CDH) CALL 5791H     ; Print buffer at M until NULL or '"'
55D4H  (CDH) CALL 4644H     ; Input and display (no "?") line and store
55D7H  (D8H) RC
55D8H  (D7H) RST 2          ; Get next non-white char from M
55D9H  (A7H) ANA A
55DAH  (3EH) MVI A,01H
55DCH  (32H) STA FAC3H
55DFH  (32H) STA F920H
55E2H  (CAH) JZ 55FDH
55E5H  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
55E8H  (FEH) CPI 0AH
55EAH  (D8H) RC
55EBH  (FEH) CPI 85H
55EDH  (D0H) RNC
55EEH  (21H) LXI H,F894H
55F1H  (22H) SHLD F892H
55F4H  (32H) STA F922H
55F7H  (32H) STA FAC3H
55FAH  (F1H) POP PSW
55FBH  (D1H) POP D
55FCH  (01H) LXI B,E1F1H
55FFH  (D5H) PUSH D
5600H  (E5H) PUSH H
5601H  (CDH) CALL 5A9EH     ; Display function keys on 8th line
5604H  (E1H) POP H
5605H  (D1H) POP D
5606H  (3AH) LDA FAC3H
5609H  (3DH) DCR A
560AH  (CAH) JZ 562DH
560DH  (D5H) PUSH D
560EH  (EBH) XCHG
560FH  (2AH) LHLD F892H
5612H  (EBH) XCHG
5613H  (DFH) RST 3          ; Compare DE and HL
5614H  (D1H) POP D
5615H  (C2H) JNZ 562DH
5618H  (CDH) CALL 67DFH
561BH  (7AH) MOV A,D
561CH  (A3H) ANA E
561DH  (3CH) INR A
561EH  (C2H) JNZ 562AH
5621H  (2AH) LHLD F892H
5624H  (36H) MVI M,1AH
5626H  (23H) INX H
5627H  (22H) SHLD F892H
562AH  (21H) LXI H,F894H
562DH  (7EH) MOV A,M
562EH  (FEH) CPI 1AH
5630H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
5631H  DB   36H
5632H  (CAH) JZ 566CH
5635H  (FEH) CPI 0AH
5637H  (C2H) JNZ 5646H
563AH  (3AH) LDA F65AH      ; RS232 auto linefeed switch
563DH  (A7H) ANA A
563EH  (C2H) JNZ 5646H
5641H  (3AH) LDA FAC6H
5644H  (FEH) CPI 0DH
5646H  (7EH) MOV A,M
5647H  (32H) STA FAC6H
564AH  (CAH) JZ 5653H
564DH  (CDH) CALL 6E32H     ; Send character in A to serial port using XON/XOFF
5650H  (CDH) CALL 5673H
5653H  (23H) INX H
5654H  (CDH) CALL 13DBH     ; Check keyboard queue for pending characters
5657H  (CAH) JZ 5606H
565AH  (CDH) CALL 12CBH     ; Wait for key from keyboard
565DH  (FEH) CPI 03H
565FH  (CAH) JZ 566CH
5662H  (FEH) CPI 13H
5664H  (CCH) CZ 12CBH       ; Wait for key from keyboard
5667H  (FEH) CPI 03H
5669H  (C2H) JNZ 5606H
566CH  (AFH) XRA A
566DH  (32H) STA FAC3H
5670H  (C3H) JMP 5A9EH      ; Display function keys on 8th line

5673H  (CDH) CALL 6D6DH     ; Check RS232 queue for pending characters
5676H  (C8H) RZ
5677H  (CDH) CALL 6D7EH     ; Get a character from RS232 receive queue
567AH  (E7H) RST 4          ; Send character in A to screen/printer
567BH  (C3H) JMP 5673H


; ======================================================
; TELCOM DOWN function routine
; ======================================================
567EH  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
5681H  (3AH) LDA FAC2H
5684H  (EEH) XRI FFH
5686H  (32H) STA FAC2H
5689H  (CAH) JZ 56BFH
568CH  (21H) LXI H,56E2H    ; Load address of TELCOM DOWN ON ERROR handler
568FH  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
5692H  (E5H) PUSH H
5693H  (21H) LXI H,5760H    ; Load pointer to "File to download" text
5696H  (CDH) CALL 5791H     ; Print buffer at M until NULL or '"'
5699H  (CDH) CALL 463EH     ; Input and display line and store
569CH  (D7H) RST 2          ; Get next non-white char from M
569DH  (A7H) ANA A
569EH  (C8H) RZ
569FH  (32H) STA FAC6H
56A2H  (F1H) POP PSW
56A3H  (E5H) PUSH H
56A4H  (CDH) CALL 2206H     ; Get .DO filename and locate in RAM directory
56A7H  (DAH) JC 56B7H
56AAH  (22H) SHLD FAC4H
56ADH  (CDH) CALL 6B2DH
56B0H  (F1H) POP PSW
56B1H  (CDH) CALL 634AH
56B4H  (C3H) JMP 5A9EH      ; Display function keys on 8th line

56B7H  (EBH) XCHG
56B8H  (CDH) CALL 1FBFH     ; Kill a text file
56BBH  (E1H) POP H
56BCH  (C3H) JMP 56A3H

56BFH  (CDH) CALL 5A9EH     ; Display function keys on 8th line
56C2H  (C3H) JMP 6383H

56C5H  (4FH) MOV C,A
56C6H  (3AH) LDA FAC2H
56C9H  (A7H) ANA A
56CAH  (79H) MOV A,C
56CBH  (C8H) RZ
56CCH  (CDH) CALL 56FEH
56CFH  (C8H) RZ
56D0H  (D2H) JNC 56D8H
56D3H  (CDH) CALL 56D8H
56D6H  (3EH) MVI A,0AH
56D8H  (2AH) LHLD FAC4H
56DBH  (CDH) CALL 6396H
56DEH  (22H) SHLD FAC4H
56E1H  (D0H) RNC

; ======================================================
; TELCOM DOWN function ON ERROR Handler
; ======================================================
56E2H  (AFH) XRA A
56E3H  (32H) STA FAC2H
56E6H  (CDH) CALL 5A9EH     ; Display function keys on 8th line
56E9H  (21H) LXI H,5768H    ; Load pointer to "Download" text
56ECH  (C3H) JMP 56F2H      ; Jump to print M to SCREEN

; ======================================================
; TELCOM UP function ON ERROR Handler
; ======================================================
56EFH  (21H) LXI H,5759H    ; Load pointer to "Upload" text
56F2H  (CDH) CALL 5791H     ; Print buffer at M until NULL or '"'
56F5H  (21H) LXI H,5771H    ; Load pointer to "aborted" text
56F8H  (CDH) CALL 27B1H     ; Print buffer at M until NULL or '"'
56FBH  (C3H) JMP 548FH

56FEH  (4FH) MOV C,A
56FFH  (A7H) ANA A
5700H  (C8H) RZ
5701H  (FEH) CPI 1AH
5703H  (C8H) RZ
5704H  (FEH) CPI 7FH
5706H  (C8H) RZ
5707H  (FEH) CPI 0AH
5709H  (C2H) JNZ 5711H
570CH  (3AH) LDA FAC6H
570FH  (FEH) CPI 0DH
5711H  (79H) MOV A,C
5712H  (32H) STA FAC6H
5715H  (C8H) RZ
5716H  (FEH) CPI 0DH
5718H  (37H) STC
5719H  (3FH) CMC
571AH  (C0H) RNZ
571BH  (A7H) ANA A
571CH  (37H) STC
571DH  (C9H) RET

; ======================================================
; TELCOM BYE function routine
; ======================================================
571EH  (21H) LXI H,5786H    ; Load pointer to "Disconnect" text
5721H  (CDH) CALL 5791H     ; Print buffer at M until NULL or '"'
5724H  (CDH) CALL 463EH     ; Input and display line and store
5727H  (D7H) RST 2          ; Get next non-white char from M
5728H  (CDH) CALL 0FE9H     ; Convert A to uppercase
572BH  (FEH) CPI 59H        ; Test for "Y" response
572DH  (CAH) JZ 5739H       ; Jump if "Y" pressed
5730H  (21H) LXI H,5771H    ; Load pointer to "aborted" text
5733H  (CDH) CALL 5791H     ; Print buffer at M until NULL or '"'
5736H  (C3H) JMP 548FH      ; Jump back into TELCOM TERM routine

; ======================================================
; TELCOM BYE function - "Y" pressed
; ======================================================
5739H  (AFH) XRA A
573AH  (32H) STA F650H
573DH  (6FH) MOV L,A
573EH  (67H) MOV H,A
573FH  (22H) SHLD FAC2H
5742H  (CDH) CALL 6ECBH     ; Deactivate RS232 or modem
5745H  (CDH) CALL 424EH     ; Turn the cursor off
5748H  (CDH) CALL 52BBH     ; Disconnect phone line and disable modem carrier
574BH  (CDH) CALL 6370H
574EH  (C3H) JMP 5146H      ; TELCOM Entry point

; ======================================================
; TELCOM Strings
; ======================================================
5751H  DB   "File to Upload",00H
5760H  DB   "File to Download",00H
5771H  DB   " aborted",0DH,0AH,00H
577CH  DB   "No file",0DH,0AH,00H
5786H  DB   "Disconnect",00H

; ======================================================
; Print buffer at M until NULL or '"'
; ======================================================
5791H  (CDH) CALL 4BB8H     ; Move LCD to blank line (send CRLF if needed)
5794H  (C3H) JMP 27B1H      ; Print buffer at M until NULL or '"'


; ======================================================
; MENU Program
; ======================================================
5797H  (2AH) LHLD FB67H     ; File buffer area pointer
579AH  (22H) SHLD F678H     ; BASIC string buffer pointer
579DH  (CDH) CALL 3F2CH     ; Initialize BASIC variables for new execution
57A0H  (CDH) CALL 6ECBH     ; Deactivate RS232 or modem
57A3H  (CDH) CALL 6370H
57A6H  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
57A9H  (CDH) CALL 426EH     ; Cancel inverse character mode
57ACH  (CDH) CALL 424EH     ; Turn the cursor off
57AFH  (CDH) CALL 428AH     ; Erase function key display
57B2H  (CDH) CALL 423FH     ; Stop automatic scrolling
57B5H  (3AH) LDA F638H      ; New Console device flag
57B8H  (32H) STA FDFAH
57BBH  (3EH) MVI A,FFH
57BDH  (32H) STA FAC8H
57C0H  (3CH) INR A          ; Increment A to zero
57C1H  (32H) STA F650H
57C4H  (32H) STA FAADH      ; Label line enable flag
57C7H  (CDH) CALL 1E3CH
57CAH  (CDH) CALL 5D4DH     ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
57CDH  (21H) LXI H,5797H    ; Set MENU program as the ON ERROR handler
57D0H  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
57D3H  (CDH) CALL 5A79H     ; Clear function key definition table
57D6H  (CDH) CALL 5A12H     ; Print time, day and date on first line of screen
57D9H  (21H) LXI H,1C01H    ; Load code for ROW1, COL 28 (Copyright notice location)
57DCH  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
57DFH  (21H) LXI H,5B0DH    ; Load pointer to copyright text
57E2H  (CDH) CALL 5A58H     ; Print NULL terminated string at M
57E5H  (21H) LXI H,FDA1H    ; Map of MENU entry positions to RAM directory positions
57E8H  (22H) SHLD FDD7H
57EBH  (06H) MVI B,36H
57EDH  (36H) MVI M,FFH
57EFH  (23H) INX H
57F0H  (05H) DCR B
57F1H  (C2H) JNZ 57EDH
57F4H  (68H) MOV L,B
57F5H  (11H) LXI D,5B1EH    ; Directory file-type display order table

; ======================================================
; Display directory entries
; ======================================================
57F8H  (1AH) LDAX D
57F9H  (B7H) ORA A
57FAH  (CAH) JZ 5807H
57FDH  (4FH) MOV C,A
57FEH  (D5H) PUSH D
57FFH  (CDH) CALL 5970H     ; Display directory entries of type in register C
5802H  (D1H) POP D
5803H  (13H) INX D
5804H  (C3H) JMP 57F8H      ; Display directory entries

5807H  (7DH) MOV A,L
5808H  (3DH) DCR A
5809H  (32H) STA FDEFH      ; Maximum MENU directory location
580CH  (FEH) CPI 17H
580EH  (CAH) JZ 5823H
5811H  (CDH) CALL 59C9H     ; Position cursor for next directory entry
5814H  (E5H) PUSH H
5815H  (21H) LXI H,5B1AH
5818H  (CDH) CALL 5A58H     ; Print NULL terminated string at M
581BH  (E1H) POP H
581CH  (2CH) INR L
581DH  (7DH) MOV A,L
581EH  (FEH) CPI 18H
5820H  (C2H) JNZ 5811H
5823H  (97H) SUB A
5824H  (32H) STA FDD9H
5827H  (32H) STA FDEEH      ; Current MENU directory location
582AH  (6FH) MOV L,A
582BH  (CDH) CALL 59E5H
582EH  (21H) LXI H,1808H
5831H  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
5834H  (CDH) CALL 7EACH     ; Display number of free bytes on LCD

; ======================================================
; Handle CTRL-U key from MENU command loop
; ======================================================
5837H  (CDH) CALL 5D4DH     ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
583AH  (21H) LXI H,5906H    ; Load pointer to CTRL-U ON ERROR handler
583DH  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
5840H  (21H) LXI H,0108H
5843H  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
5846H  (21H) LXI H,5B24H
5849H  (CDH) CALL 5A58H     ; Print NULL terminated string at M
584CH  (21H) LXI H,0908H
584FH  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
5852H  (97H) SUB A
5853H  (32H) STA FDEDH      ; Flag to indicate MENU entry location or command entry
5856H  (21H) LXI H,FDD9H
5859H  (3CH) INR A

; ======================================================
; MENU Program command loop
; ======================================================
585AH  (CCH) CZ 4229H       ; BEEP statement
585DH  (CDH) CALL 5D70H     ; Print time on top line until key pressed
5860H  (CDH) CALL 5D64H     ; Wait for char from keyboard & convert to uppercase
5863H  (FEH) CPI 0DH
5865H  (CAH) JZ 58F7H       ; Handle ENTER key from MENU command loop
5868H  (FEH) CPI 08H
586AH  (CAH) JZ 588EH       ; Handle Backspace key from MENU command loop
586DH  (FEH) CPI 7FH
586FH  (CAH) JZ 588EH       ; Handle Backspace key from MENU command loop
5872H  (FEH) CPI 15H
5874H  (CAH) JZ 5837H       ; Handle CTRL-U key from MENU command loop
5877H  (FEH) CPI 20H
5879H  (DAH) JC 589CH
587CH  (4FH) MOV C,A
587DH  (3AH) LDA FDEDH      ; Flag to indicate MENU entry location or command entry
5880H  (CCH) CZ 5897H
5883H  (FEH) CPI 09H
5885H  (CAH) JZ 585AH       ; MENU Program command loop
5888H  (CDH) CALL 5D88H
588BH  (C3H) JMP 585DH


; ======================================================
; Handle Backspace key from MENU command loop
; ======================================================
588EH  (CDH) CALL 5D9EH
5891H  (CAH) JZ 585AH       ; MENU Program command loop
5894H  (C3H) JMP 585DH

5897H  (B7H) ORA A
5898H  (C0H) RNZ
5899H  (F1H) POP PSW
589AH  (3EH) MVI A,1CH
589CH  (F5H) PUSH PSW
589DH  (3AH) LDA FDEEH      ; Current MENU directory location
58A0H  (5FH) MOV E,A
58A1H  (F1H) POP PSW
58A2H  (D6H) SUI 1CH
58A4H  (01H) LXI B,585DH
58A7H  (C5H) PUSH B
58A8H  (F8H) RM
58A9H  (01H) LXI B,58C3H
58ACH  (C5H) PUSH B
58ADH  (CAH) JZ 58EBH
58B0H  (3DH) DCR A
58B1H  (CAH) JZ 58E2H
58B4H  (3DH) DCR A
58B5H  (C1H) POP B
58B6H  (CAH) JZ 58DBH
58B9H  (7BH) MOV A,E
58BAH  (C6H) ADI 04H
58BCH  (57H) MOV D,A
58BDH  (3AH) LDA FDEFH      ; Maximum MENU directory location
58C0H  (BAH) CMP D
58C1H  (F8H) RM
58C2H  (7AH) MOV A,D
58C3H  (32H) STA FDEEH      ; Current MENU directory location
58C6H  (E5H) PUSH H
58C7H  (2AH) LHLD F639H     ; Cursor row (1-8)
58CAH  (E5H) PUSH H
58CBH  (6BH) MOV L,E
58CCH  (D5H) PUSH D
58CDH  (CDH) CALL 59E5H
58D0H  (D1H) POP D
58D1H  (6AH) MOV L,D
58D2H  (CDH) CALL 59E5H
58D5H  (E1H) POP H
58D6H  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
58D9H  (E1H) POP H
58DAH  (C9H) RET

58DBH  (7BH) MOV A,E
58DCH  (D6H) SUI 04H
58DEH  (57H) MOV D,A
58DFH  (F8H) RM
58E0H  (C5H) PUSH B
58E1H  (C9H) RET

58E2H  (7BH) MOV A,E
58E3H  (3DH) DCR A
58E4H  (57H) MOV D,A
58E5H  (F0H) RP
58E6H  (3AH) LDA FDEFH      ; Maximum MENU directory location
58E9H  (57H) MOV D,A
58EAH  (C9H) RET

58EBH  (7BH) MOV A,E
58ECH  (3CH) INR A
58EDH  (57H) MOV D,A
58EEH  (3AH) LDA FDEFH      ; Maximum MENU directory location
58F1H  (BAH) CMP D
58F2H  (7AH) MOV A,D
58F3H  (F0H) RP
58F4H  (97H) SUB A
58F5H  (57H) MOV D,A
58F6H  (C9H) RET


; ======================================================
; Handle ENTER key from MENU command loop
; ======================================================
58F7H  (3AH) LDA FDEDH      ; Flag to indicate MENU entry location or command entry
58FAH  (B7H) ORA A
58FBH  (CAH) JZ 590CH
58FEH  (36H) MVI M,00H
5900H  (CDH) CALL 5AB1H
5903H  (C2H) JNZ 5921H

; ======================================================
; MENU CTRL-U ON ERROR Handler
; ======================================================
5906H  (CDH) CALL 4229H     ; BEEP statement
5909H  (C3H) JMP 5837H      ; Handle CTRL-U key from MENU command loop

590CH  (3AH) LDA FDEEH      ; Current MENU directory location
590FH  (21H) LXI H,FDA1H    ; Map of MENU entry positions to RAM directory positions
5912H  (11H) LXI D,0002H
5915H  (B7H) ORA A
5916H  (CAH) JZ 591EH
5919H  (19H) DAD D
591AH  (3DH) DCR A
591BH  (C3H) JMP 5915H

591EH  (CDH) CALL 5AE4H
5921H  (E5H) PUSH H
5922H  (CDH) CALL 4231H     ; CLS statement
5925H  (CDH) CALL 4244H     ; Resume automatic scrolling
5928H  (3AH) LDA FDFAH
592BH  (CDH) CALL 1E3CH
592EH  (3EH) MVI A,0CH
5930H  (E7H) RST 4          ; Send character in A to screen/printer
5931H  (97H) SUB A
5932H  (32H) STA FAC8H
5935H  (6FH) MOV L,A
5936H  (65H) MOV H,L
5937H  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
593AH  (3DH) DCR A
593BH  (32H) STA FAADH      ; Label line enable flag
593EH  (E1H) POP H
593FH  (7EH) MOV A,M
5940H  (CDH) CALL 5AE3H     ; Get start address of file at M
5943H  (FEH) CPI A0H
5945H  (CAH) JZ 254BH       ; Launch .CO files from MENU
5948H  (FEH) CPI B0H
594AH  (CAH) JZ 596FH       ; Launch ROM command file from MENU program
594DH  (FEH) CPI F0H
594FH  (CAH) JZ F624H       ; Call Hook routine copied to RAM to jump to OptROM
5952H  (FEH) CPI C0H
5954H  (CAH) JZ 5F65H       ; Edit .DO files
5957H  (22H) SHLD F67CH     ; Start of BASIC program pointer
595AH  (1BH) DCX D
595BH  (1BH) DCX D
595CH  (EBH) XCHG
595DH  (22H) SHLD FA8CH
5960H  (CDH) CALL 05F0H     ; Update line addresses for current BASIC program
5963H  (CDH) CALL 6C9CH     ; Copy BASIC Function key table to key definition area
5966H  (CDH) CALL 6C7FH
5969H  (CDH) CALL 3F28H     ; Initialize BASIC Variables for new execution
596CH  (C3H) JMP 0804H      ; Execute BASIC program


; ======================================================
; Launch ROM command file from MENU program
; ======================================================
596FH  (E9H) PCHL


; ======================================================
; Display directory entries of type in register C
; ======================================================
5970H  (06H) MVI B,1BH
5972H  (11H) LXI D,F962H    ; Start of RAM directory
5975H  (1AH) LDAX D
5976H  (3CH) INR A
5977H  (C8H) RZ
5978H  (3DH) DCR A
5979H  (B9H) CMP C
597AH  (C2H) JNZ 59A1H
597DH  (C5H) PUSH B
597EH  (D5H) PUSH D
597FH  (E5H) PUSH H
5980H  (2AH) LHLD FDD7H
5983H  (73H) MOV M,E
5984H  (23H) INX H
5985H  (72H) MOV M,D
5986H  (23H) INX H
5987H  (13H) INX D
5988H  (13H) INX D
5989H  (13H) INX D
598AH  (22H) SHLD FDD7H
598DH  (E1H) POP H
598EH  (CDH) CALL 59C9H     ; Position cursor for next directory entry
5991H  (E5H) PUSH H
5992H  (21H) LXI H,FDD9H
5995H  (E5H) PUSH H
5996H  (CDH) CALL 59ADH     ; Convert filename from space padded to '.ext' format
5999H  (E1H) POP H
599AH  (CDH) CALL 5A58H     ; Print NULL terminated string at M
599DH  (E1H) POP H
599EH  (2CH) INR L
599FH  (D1H) POP D
59A0H  (C1H) POP B
59A1H  (E5H) PUSH H
59A2H  (21H) LXI H,000BH
59A5H  (19H) DAD D
59A6H  (EBH) XCHG
59A7H  (E1H) POP H
59A8H  (05H) DCR B
59A9H  (C2H) JNZ 5975H
59ACH  (C9H) RET


; ======================================================
; Convert filename from space padded to '.ext' format
; ======================================================
59ADH  (3EH) MVI A,06H
59AFH  (CDH) CALL 5A62H     ; Copy A bytes from (DE) to M
59B2H  (3EH) MVI A,20H
59B4H  (2BH) DCX H
59B5H  (BEH) CMP M
59B6H  (CAH) JZ 59B4H
59B9H  (23H) INX H
59BAH  (36H) MVI M,00H
59BCH  (1AH) LDAX D
59BDH  (FEH) CPI 20H
59BFH  (C8H) RZ
59C0H  (36H) MVI M,2EH
59C2H  (23H) INX H
59C3H  (CDH) CALL 5A60H     ; Copy 2 bytes from (DE) to M
59C6H  (36H) MVI M,00H
59C8H  (C9H) RET


; ======================================================
; Position cursor for next directory entry
; ======================================================
59C9H  (D5H) PUSH D
59CAH  (E5H) PUSH H
59CBH  (7DH) MOV A,L
59CCH  (1FH) RAR
59CDH  (1FH) RAR
59CEH  (E6H) ANI 3FH
59D0H  (5FH) MOV E,A
59D1H  (1CH) INR E
59D2H  (1CH) INR E
59D3H  (7DH) MOV A,L
59D4H  (E6H) ANI 03H
59D6H  (87H) ADD A
59D7H  (57H) MOV D,A
59D8H  (87H) ADD A
59D9H  (87H) ADD A
59DAH  (82H) ADD D
59DBH  (57H) MOV D,A
59DCH  (14H) INR D
59DDH  (14H) INR D
59DEH  (EBH) XCHG
59DFH  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
59E2H  (E1H) POP H
59E3H  (D1H) POP D
59E4H  (C9H) RET

59E5H  (CDH) CALL 73C5H     ; Turn off background task, blink & reinitialize cursor blink time
59E8H  (CDH) CALL 59C9H     ; Position cursor for next directory entry
59EBH  (06H) MVI B,0AH
59EDH  (E5H) PUSH H
59EEH  (21H) LXI H,F63AH    ; Cursor column (1-40)
59F1H  (35H) DCR M
59F2H  (C5H) PUSH B
59F3H  (D5H) PUSH D
59F4H  (2AH) LHLD F639H     ; Cursor row (1-8)
59F7H  (CDH) CALL 45CBH
59FAH  (EBH) XCHG
59FBH  (CDH) CALL 7440H
59FEH  (F3H) DI
59FFH  (CDH) CALL 73A9H     ; Blink the cursor
5A02H  (FBH) EI
5A03H  (D1H) POP D
5A04H  (21H) LXI H,F63AH    ; Cursor column (1-40)
5A07H  (34H) INR M
5A08H  (C1H) POP B
5A09H  (05H) DCR B
5A0AH  (C2H) JNZ 59F2H
5A0DH  (CDH) CALL 73C5H     ; Turn off background task, blink & reinitialize cursor blink time
5A10H  (E1H) POP H
5A11H  (C9H) RET


; ======================================================
; Print time, day and date on first line of screen
; ======================================================
5A12H  (CDH) CALL 4231H     ; CLS statement

; ======================================================
; Print time,day,date on first line w/o CLS
; ======================================================
5A15H  (CDH) CALL 5D6AH     ; Home cursor
5A18H  (21H) LXI H,FD8BH
5A1BH  (CDH) CALL 192FH     ; DATE$ function
5A1EH  (36H) MVI M,20H
5A20H  (23H) INX H
5A21H  (CDH) CALL 1962H     ; Read day and store at M
5A24H  (EBH) XCHG
5A25H  (36H) MVI M,20H
5A27H  (23H) INX H
5A28H  (CDH) CALL 190FH     ; Read time and store it at M
5A2BH  (36H) MVI M,00H
5A2DH  (3AH) LDA F92CH      ; Month (1-12)
5A30H  (21H) LXI H,5AE6H    ; Load pointer to Month ASCII table (-3)
5A33H  (01H) LXI B,0003H    ; Point to "MENU" Text
5A36H  (09H) DAD B
5A37H  (3DH) DCR A
5A38H  (C2H) JNZ 5A36H
5A3BH  (11H) LXI D,FD88H
5A3EH  (EBH) XCHG
5A3FH  (E5H) PUSH H
5A40H  (79H) MOV A,C
5A41H  (CDH) CALL 5A62H     ; Copy A bytes from (DE) to M
5A44H  (54H) MOV D,H
5A45H  (5DH) MOV E,L
5A46H  (36H) MVI M,20H
5A48H  (13H) INX D
5A49H  (13H) INX D
5A4AH  (13H) INX D
5A4BH  (23H) INX H
5A4CH  (CDH) CALL 5A60H     ; Copy 2 bytes from (DE) to M
5A4FH  (36H) MVI M,2CH
5A51H  (23H) INX H
5A52H  (36H) MVI M,32H
5A54H  (23H) INX H
5A55H  (36H) MVI M,30H
5A57H  (E1H) POP H

; ======================================================
; Print NULL terminated string at M
; ======================================================
5A58H  (7EH) MOV A,M
5A59H  (B7H) ORA A
5A5AH  (C8H) RZ
5A5BH  (E7H) RST 4          ; Send character in A to screen/printer
5A5CH  (23H) INX H
5A5DH  (C3H) JMP 5A58H      ; Print NULL terminated string at M

; ======================================================
; Copy 2 bytes from (DE) to M
; ======================================================
5A60H  (3EH) MVI A,02H

; ======================================================
; Copy A bytes from (DE) to M
; ======================================================
5A62H  (F5H) PUSH PSW
5A63H  (1AH) LDAX D
5A64H  (77H) MOV M,A
5A65H  (13H) INX D
5A66H  (23H) INX H
5A67H  (F1H) POP PSW
5A68H  (3DH) DCR A
5A69H  (C2H) JNZ 5A62H      ; Copy A bytes from (DE) to M
5A6CH  (C9H) RET

; ======================================================
; Compare string at DE with that at M (max C bytes)
; ======================================================
5A6DH  (1AH) LDAX D
5A6EH  (BEH) CMP M
5A6FH  (C0H) RNZ
5A70H  (B7H) ORA A
5A71H  (C8H) RZ
5A72H  (23H) INX H
5A73H  (13H) INX D
5A74H  (0DH) DCR C
5A75H  (C2H) JNZ 5A6DH      ; Compare string at DE with that at M (max C bytes)
5A78H  (C9H) RET


; ======================================================
; Clear function key definition table
; ======================================================
5A79H  (21H) LXI H,5B3EH

; ======================================================
; Set new function key table
; ======================================================
5A7CH  (11H) LXI D,F789H    ; Function key definition area
5A7FH  (06H) MVI B,08H
5A81H  (0EH) MVI C,10H
5A83H  (7EH) MOV A,M
5A84H  (23H) INX H
5A85H  (B7H) ORA A
5A86H  (F5H) PUSH PSW
5A87H  (E6H) ANI 7FH
5A89H  (12H) STAX D
5A8AH  (F1H) POP PSW
5A8BH  (FAH) JM 5A93H
5A8EH  (13H) INX D
5A8FH  (0DH) DCR C
5A90H  (C2H) JNZ 5A83H
5A93H  (97H) SUB A
5A94H  (13H) INX D
5A95H  (0DH) DCR C
5A96H  (12H) STAX D
5A97H  (C2H) JNZ 5A94H
5A9AH  (05H) DCR B
5A9BH  (C2H) JNZ 5A81H

; ======================================================
; Display function keys on 8th line
; ======================================================
5A9EH  (3AH) LDA F63DH      ; Label line protect status
5AA1H  (B7H) ORA A
5AA2H  (C4H) CNZ 42A8H      ; Display function key line
5AA5H  (C9H) RET

5AA6H  (11H) LXI D,5CCEH

; ======================================================
; Search directory for filename
; ======================================================
5AA9H  (3EH) MVI A,08H
5AABH  (21H) LXI H,FDD9H
5AAEH  (CDH) CALL 5A62H     ; Copy A bytes from (DE) to M
5AB1H  (06H) MVI B,1BH
5AB3H  (11H) LXI D,F962H    ; Start of RAM directory
5AB6H  (21H) LXI H,FDF0H
5AB9H  (1AH) LDAX D
5ABAH  (3CH) INR A
5ABBH  (C8H) RZ
5ABCH  (E6H) ANI 80H
5ABEH  (CAH) JZ 5AD9H
5AC1H  (D5H) PUSH D
5AC2H  (13H) INX D
5AC3H  (13H) INX D
5AC4H  (13H) INX D
5AC5H  (E5H) PUSH H
5AC6H  (CDH) CALL 59ADH     ; Convert filename from space padded to '.ext' format
5AC9H  (E1H) POP H
5ACAH  (0EH) MVI C,09H
5ACCH  (11H) LXI D,FDD9H
5ACFH  (CDH) CALL 5A6DH     ; Compare string at DE with that at M (max C bytes)
5AD2H  (C2H) JNZ 5AD8H
5AD5H  (E1H) POP H
5AD6H  (0CH) INR C
5AD7H  (C9H) RET

5AD8H  (D1H) POP D
5AD9H  (21H) LXI H,000BH
5ADCH  (19H) DAD D
5ADDH  (EBH) XCHG
5ADEH  (05H) DCR B
5ADFH  (C2H) JNZ 5AB6H
5AE2H  (C9H) RET


; ======================================================
; Get start address of file at M
; ======================================================
5AE3H  (23H) INX H
5AE4H  (5EH) MOV E,M
5AE5H  (23H) INX H
5AE6H  (56H) MOV D,M
5AE7H  (EBH) XCHG
5AE8H  (C9H) RET

5AE9H  DB   "Jan"
5AECH  DB   "Feb"
5AEFH  DB   "Mar"
5AF2H  DB   "Apr"
5AF5H  DB   "May"
5AF8H  DB   "Jun"
5AFBH  DB   "Jly"
5AFEH  DB   "Aug"
5B01H  DB   "Sep"
5B04H  DB   "Oct"
5B07H  DB   "Nov"
5B0AH  DB   "Dec"
5B0DH  DB   "VirtualT 1.2",00H
5B1AH  DB   "-.-",00H

; ======================================================
; Directory file-type display order table
; ======================================================
5B1EH  DB   B0H,F0H,C0H,80H,A0H,00H

5B24H  DB   "Select: _         ",00H
5B37H  DB   20H,08H,08H,5FH,08H,00H,00H,80H
5B3FH  DB   80H,80H,80H,80H,80H,80H,80H

; ======================================================
; Function Key Labels for BASIC
; ======================================================
5B46H  DB   "Files",8DH
5B4CH  DB   "Load ",A2H
5B52H  DB   "Save ",A2H
5B58H  DB   "Run",8DH
5B5CH  DB   "List",8DH
5B61H  DB   80H
5B62H  DB   80H
5B63H  DB   "Menu",8DH

; ======================================================
; ADDRSS Entry point
; ======================================================
5B68H  (11H) LXI D,5CCEH

; ======================================================
; ADDRSS entry with (DE) pointing to filename
; ======================================================
5B6BH  (97H) SUB A
5B6CH  (C3H) JMP 5B74H

; ======================================================
; SCHEDL Entry point
; ======================================================
5B6FH  (11H) LXI D,5D02H    ; Load pointer to "NOTE.DO" text

; ======================================================
; SCHEDL entry with (DE) pointing to filename
; ======================================================
5B72H  (3EH) MVI A,FFH
5B74H  (32H) STA FDEDH      ; Flag to indicate MENU entry location or command entry
5B77H  (CDH) CALL 5D4DH     ; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
5B7AH  (D5H) PUSH D
5B7BH  (CDH) CALL 5AA9H     ; Search directory for filename
5B7EH  (CDH) CALL 5AE3H     ; Get start address of file at M
5B81H  (C2H) JNZ 5BA9H      ; Jump if "NOTE.DO" found
5B84H  (E1H) POP H 
5B85H  (22H) SHLD FDEEH     ; Current MENU directory location
5B88H  (21H) LXI H,5B88H    ; Point to self for ON ERROR handler to keep looping
5B8BH  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
5B8EH  (CDH) CALL 4231H     ; CLS statement
5B91H  (CDH) CALL 4229H     ; BEEP statement
5B94H  (2AH) LHLD FDEEH     ; Current MENU directory location
5B97H  (CDH) CALL 5A58H     ; Print NULL terminated string at M
5B9AH  (21H) LXI H,5CD6H    ; Point to " not found" text
5B9DH  (CDH) CALL 5A58H     ; Print NULL terminated string at M
5BA0H  (21H) LXI H,0003H    ; Point to "MENU" Text
5BA3H  (CDH) CALL 5F24H     ; Display "Press space bar for " (Text at HL)
5BA6H  (C3H) JMP 5797H      ; MENU Program

; ======================================================
; NOTE.DO found.  Open and start SCHEDL.
; ======================================================
5BA9H  (22H) SHLD FDD7H
5BACH  (CDH) CALL 4231H     ; CLS statement
5BAFH  (21H) LXI H,5D0AH
5BB2H  (CDH) CALL 42A5H     ; Set and display function keys (M has key table)
5BB5H  (21H) LXI H,5BE2H
5BB8H  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
5BBBH  (CDH) CALL 5D5DH
5BBEH  (97H) SUB A
5BBFH  (32H) STA F675H      ; Output device for RST 20H (0=screen)
5BC2H  (21H) LXI H,5CE1H
5BC5H  (3AH) LDA FDEDH      ; Flag to indicate MENU entry location or command entry
5BC8H  (B7H) ORA A
5BC9H  (CAH) JZ 5BCFH
5BCCH  (21H) LXI H,5CE8H
5BCFH  (CDH) CALL 5A58H     ; Print NULL terminated string at M
5BD2H  (CDH) CALL 4644H     ; Input and display (no "?") line and store
5BD5H  (23H) INX H
5BD6H  (7EH) MOV A,M
5BD7H  (B7H) ORA A
5BD8H  (CAH) JZ 5BBBH
5BDBH  (11H) LXI D,5CEFH
5BDEH  (CDH) CALL 6CA7H
5BE1H  (C0H) RNZ
5BE2H  (97H) SUB A
5BE3H  (32H) STA F675H      ; Output device for RST 20H (0=screen)
5BE6H  (CDH) CALL 4BB8H     ; Move LCD to blank line (send CRLF if needed)
5BE9H  (CDH) CALL 4229H     ; BEEP statement
5BECH  (21H) LXI H,5D0AH
5BEFH  (CDH) CALL 5A7CH     ; Set new function key table
5BF2H  (C3H) JMP 5BBBH

; ======================================================
; FIND instruction for ADDRSS/SCHEDL
; ======================================================
5BF5H  (97H) SUB A
5BF6H  (01H) LXI B,FF3EH
5BF9H  (CDH) CALL 5DB1H
5BFCH  (CDH) CALL 5C3FH     ; Find text at M in the file at (DE)
5BFFH  (D2H) JNC 5BBBH
5C02H  (E5H) PUSH H
5C03H  (D5H) PUSH D
5C04H  (CDH) CALL 5DC5H
5C07H  (CDH) CALL 67DFH
5C0AH  (3AH) LDA FDEEH      ; Current MENU directory location
5C0DH  (32H) STA F675H      ; Output device for RST 20H (0=screen)
5C10H  (CDH) CALL 6A10H
5C13H  (97H) SUB A
5C14H  (32H) STA F675H      ; Output device for RST 20H (0=screen)
5C17H  (3AH) LDA FDEEH      ; Current MENU directory location
5C1AH  (B7H) ORA A
5C1BH  (C2H) JNZ 5C24H
5C1EH  (CDH) CALL 5DE4H
5C21H  (CAH) JZ 5BBBH
5C24H  (1BH) DCX D
5C25H  (1AH) LDAX D
5C26H  (13H) INX D
5C27H  (FEH) CPI 0AH
5C29H  (CAH) JZ 5C37H
5C2CH  (D5H) PUSH D
5C2DH  (13H) INX D
5C2EH  (7BH) MOV A,E
5C2FH  (B2H) ORA D
5C30H  (D1H) POP D
5C31H  (C2H) JNZ 5C07H
5C34H  (C3H) JMP 5BBBH

5C37H  (D1H) POP D
5C38H  (CDH) CALL 5C6DH     ; Increment DE past next CRLF in text file at (DE)
5C3BH  (E1H) POP H
5C3CH  (C3H) JMP 5BFCH


; ======================================================
; Find text at M in the file at (DE)
; ======================================================
5C3FH  (D5H) PUSH D
5C40H  (E5H) PUSH H
5C41H  (D5H) PUSH D
5C42H  (1AH) LDAX D
5C43H  (CDH) CALL 0FE9H     ; Convert A to uppercase
5C46H  (4FH) MOV C,A
5C47H  (CDH) CALL 0FE8H     ; Get char at M and convert to uppercase
5C4AH  (B9H) CMP C
5C4BH  (C2H) JNZ 5C53H
5C4EH  (13H) INX D
5C4FH  (23H) INX H
5C50H  (C3H) JMP 5C42H

5C53H  (FEH) CPI 00H
5C55H  (79H) MOV A,C
5C56H  (C1H) POP B
5C57H  (E1H) POP H
5C58H  (CAH) JZ 5C6AH
5C5BH  (FEH) CPI 1AH
5C5DH  (CAH) JZ 5C96H
5C60H  (CDH) CALL 5C74H     ; Check next byte(s) at (DE) for CRLF
5C63H  (C2H) JNZ 5C40H
5C66H  (F1H) POP PSW
5C67H  (C3H) JMP 5C3FH      ; Find text at M in the file at (DE)

5C6AH  (D1H) POP D
5C6BH  (37H) STC
5C6CH  (C9H) RET


; ======================================================
; Increment DE past next CRLF in text file at (DE)
; ======================================================
5C6DH  (CDH) CALL 5C74H     ; Check next byte(s) at (DE) for CRLF
5C70H  (C2H) JNZ 5C6DH      ; Increment DE past next CRLF in text file at (DE)
5C73H  (C9H) RET


; ======================================================
; Check next byte(s) at (DE) for CRLF
; ======================================================
5C74H  (1AH) LDAX D
5C75H  (FEH) CPI 0DH
5C77H  (13H) INX D
5C78H  (C0H) RNZ
5C79H  (1AH) LDAX D
5C7AH  (FEH) CPI 0AH
5C7CH  (C0H) RNZ
5C7DH  (13H) INX D
5C7EH  (C9H) RET

5C7FH  (D5H) PUSH D
5C80H  (21H) LXI H,5D2BH
5C83H  (CDH) CALL 5A7CH     ; Set new function key table
5C86H  (CDH) CALL 5CAEH
5C89H  (F5H) PUSH PSW
5C8AH  (21H) LXI H,51A4H
5C8DH  (CDH) CALL 5A7CH     ; Set new function key table
5C90H  (CDH) CALL 5DBCH
5C93H  (F1H) POP PSW
5C94H  (FEH) CPI 51H
5C96H  (D1H) POP D
5C97H  (C9H) RET

5C98H  (D5H) PUSH D
5C99H  (21H) LXI H,5D1EH
5C9CH  (CDH) CALL 5A7CH     ; Set new function key table
5C9FH  (CDH) CALL 5CAEH
5CA2H  (FEH) CPI 43H
5CA4H  (CAH) JZ 5C9FH
5CA7H  (F5H) PUSH PSW
5CA8H  (21H) LXI H,5D0AH
5CABH  (C3H) JMP 5C8DH

5CAEH  (CDH) CALL 12CBH     ; Wait for key from keyboard
5CB1H  (F5H) PUSH PSW
5CB2H  (97H) SUB A
5CB3H  (32H) STA F62DH
5CB6H  (F1H) POP PSW
5CB7H  (CDH) CALL 0FE9H     ; Convert A to uppercase
5CBAH  (FEH) CPI 51H
5CBCH  (C8H) RZ
5CBDH  (FEH) CPI 20H
5CBFH  (C8H) RZ
5CC0H  (FEH) CPI 4DH
5CC2H  (C8H) RZ
5CC3H  (FEH) CPI 43H
5CC5H  (C8H) RZ
5CC6H  (FEH) CPI 0DH
5CC8H  (C2H) JNZ 5CAEH
5CCBH  (C6H) ADI 36H
5CCDH  (C9H) RET

5CCEH  DB   "ADRS.DO",00H
5CD6H  DB   " not found",00H
5CE1H  DB   "Adrs: ",00H
5CE8H  DB   "Schd: ",00H

; ======================================================
; ADDRSS/SCHEDL instruction vector table
; ======================================================
5CEFH  DB   "FIND"
5CF3H  DW   5BF5H
5CF5H  DB   "LFND"
5CF9H  DW   5BF7H
5CFBH  DB   "MENU"
5CFFH  DW   5797H
5D01H  DB   FFH

5D02H  DB   "NOTE.DO",00H
5D0AH  DB   "Find",A0H
5D0FH  DB   80H
5D10H  DB   80H
5D11H  DB   80H
5D12H  DB   "Lfnd",A0H
5D17H  DB   80H
5D18H  DB   80H
5D19H  DB   "Menu",8DH
5D1EH  DB   80H
5D1FH  DB   80H
5D20H  DB   "Mor",E5H
5D24H  DB   "Qui",F4H
5D28H  DB   80H
5D29H  DB   80H
5D2AH  DB   80H
5D2BH  DB   80H
5D2CH  DB   "Call",A0H
5D31H  DB   "Mor",E5H
5D35H  DB   "Qui",F4H
5D39H  DB   80H
5D3AH  DB   80H
5D3BH  DB   80H
5D3CH  DB   80H
5D3DH  (C3H) JMP 5797H      ; MENU Program

5D40H  (11H) LXI D,0010H
5D43H  (19H) DAD D
5D44H  (0DH) DCR C
5D45H  (C9H) RET

5D46H  (7EH) MOV A,M
5D47H  (23H) INX H
5D48H  (FEH) CPI 20H
5D4AH  (C8H) RZ
5D4BH  (2BH) DCX H
5D4CH  (C9H) RET

; ======================================================
; Stop BASIC execution, Restore BASIC SP & clear SHIFT-PRINT Key
; ======================================================
5D4DH  (21H) LXI H,5B3CH    ; Point to a NULL key sequence
5D50H  (22H) SHLD F88AH     ; Save as key sequence for SHIFT-PRINT key
5D53H  (21H) LXI H,FFFFH    ; Load "BASIC not executing" line number
5D56H  (22H) SHLD F67AH     ; Save as current executing line number
5D59H  (23H) INX H          ; Set HL to zero
5D5AH  (22H) SHLD FAC2H
5D5DH  (C1H) POP B          ; Get return address from stack
5D5EH  (2AH) LHLD FB9DH     ; Load SP used by BASIC to reinitialize the stack
5D61H  (F9H) SPHL           ; Rewind stack to location for BASIC start
5D62H  (C5H) PUSH B         ; Push return address back to stack
5D63H  (C9H) RET

; ======================================================
; Wait for char from keyboard & convert to uppercase
; ======================================================
5D64H  (CDH) CALL 12CBH     ; Wait for key from keyboard
5D67H  (C3H) JMP 0FE9H      ; Convert A to uppercase

; ======================================================
; Home cursor
; ======================================================
5D6AH  (21H) LXI H,0101H    ; Load code for ROW 1, COL 1
5D6DH  (C3H) JMP 427CH      ; Set the current cursor position (H=Row,L=Col)

; ======================================================
; Print time on top line until key pressed
; ======================================================
5D70H  (E5H) PUSH H
5D71H  (2AH) LHLD F639H     ; Cursor row (1-8)
5D74H  (E5H) PUSH H
5D75H  (CDH) CALL 13DBH     ; Check keyboard queue for pending characters
5D78H  (F5H) PUSH PSW
5D79H  (CCH) CZ 5A15H       ; Print time,day,date on first line w/o CLS
5D7CH  (F1H) POP PSW
5D7DH  (E1H) POP H
5D7EH  (F5H) PUSH PSW
5D7FH  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
5D82H  (F1H) POP PSW
5D83H  (E1H) POP H
5D84H  (CAH) JZ 5D70H       ; Print time on top line until key pressed
5D87H  (C9H) RET

5D88H  (71H) MOV M,C
5D89H  (23H) INX H
5D8AH  (E5H) PUSH H
5D8BH  (21H) LXI H,FDEDH    ; Flag to indicate MENU entry location or command entry
5D8EH  (34H) INR M
5D8FH  (79H) MOV A,C
5D90H  (E7H) RST 4          ; Send character in A to screen/printer
5D91H  (21H) LXI H,5B3AH
5D94H  (CDH) CALL 5A58H     ; Print NULL terminated string at M
5D97H  (E1H) POP H
5D98H  (C9H) RET

5D99H  (3AH) LDA FDEDH      ; Flag to indicate MENU entry location or command entry
5D9CH  (B7H) ORA A
5D9DH  (C9H) RET

5D9EH  (CDH) CALL 5D99H
5DA1H  (C8H) RZ
5DA2H  (3DH) DCR A
5DA3H  (32H) STA FDEDH      ; Flag to indicate MENU entry location or command entry
5DA6H  (2BH) DCX H
5DA7H  (E5H) PUSH H
5DA8H  (21H) LXI H,5B37H
5DABH  (CDH) CALL 5A58H     ; Print NULL terminated string at M
5DAEH  (E1H) POP H
5DAFH  (3CH) INR A
5DB0H  (C9H) RET

5DB1H  (32H) STA FDEEH      ; Current MENU directory location
5DB4H  (CDH) CALL 5D46H
5DB7H  (EBH) XCHG
5DB8H  (2AH) LHLD FDD7H
5DBBH  (EBH) XCHG
5DBCH  (3AH) LDA F63BH      ; Active rows count (1-8)
5DBFH  (3DH) DCR A
5DC0H  (3DH) DCR A
5DC1H  (32H) STA FDEFH      ; Maximum MENU directory location
5DC4H  (C9H) RET

5DC5H  (21H) LXI H,F63CH    ; Active columns count (1-40)
5DC8H  (3EH) MVI A,FFH
5DCAH  (32H) STA F921H
5DCDH  (32H) STA F920H
5DD0H  (3AH) LDA FDEEH      ; Current MENU directory location
5DD3H  (B7H) ORA A
5DD4H  (CAH) JZ 5DDFH
5DD7H  (3EH) MVI A,01H
5DD9H  (32H) STA F920H
5DDCH  (21H) LXI H,F649H
5DDFH  (7EH) MOV A,M
5DE0H  (32H) STA F922H
5DE3H  (C9H) RET

5DE4H  (21H) LXI H,FDEFH    ; Maximum MENU directory location
5DE7H  (35H) DCR M
5DE8H  (CCH) CZ 5C98H
5DEBH  (FEH) CPI 51H
5DEDH  (C9H) RET

; ======================================================
; TEXT Entry point
; ======================================================
5DEEH  (21H) LXI H,5DFBH    ; Load address of Main TEXT loop ON ERROR Handler
5DF1H  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
5DF4H  (21H) LXI H,5E22H    ; TEXT Function key table - empty
5DF7H  (CDH) CALL 5A7CH     ; Set new function key table
5DFAH  (AFH) XRA A

; ======================================================
; Main TEXT ON ERROR handler
; ======================================================
5DFBH  (C4H) CNZ 4229H      ; BEEP statement
5DFEH  (CDH) CALL 5D53H
5E01H  (21H) LXI H,5E15H    ; Point to "File to edit" text
5E04H  (CDH) CALL 27B1H     ; Print buffer at M until NULL or '"'
5E07H  (CDH) CALL 463EH     ; Input and display line and store
5E0AH  (D7H) RST 2          ; Get next non-white char from M
5E0BH  (A7H) ANA A
5E0CH  (CAH) JZ 5797H       ; MENU Program
5E0FH  (CDH) CALL 2206H     ; Get .DO filename and locate in RAM directory
5E12H  (C3H) JMP 5F65H      ; Edit .DO files

5E15H  DB   "File to edit",00H

; ======================================================
; TEXT Function key table - empty
; ======================================================
5E22H  DB   80H,80H,80H,80H,80H,80H,80H,83H

; ======================================================
; TEXT Function key table - Normal FKeys
; ======================================================
5E2AH  DB   "Find",8EH
5E2FH  DB   "Load",96H
5E34H  DB   "Save",87H
5E39H  DB   80H
5E3AH  DB   "Copy",8FH
5E3FH  DB   "Cut ",95H
5E44H  DB   "Sel ",8CH

5E4EH  DB    9BH
5E4FH  DB    19H,00H        ; CTRL-Y Key string for SHIFT-PRINT injection

; ======================================================
; EDIT statement
; ======================================================
5E51H  (E5H) PUSH H
5E52H  (F5H) PUSH PSW
5E53H  (3EH) MVI A,01H
5E55H  (CAH) JZ 5E5AH
5E58H  (3EH) MVI A,FFH
5E5AH  (32H) STA F651H      ; In TEXT because of BASIC EDIT flag
5E5DH  (AFH) XRA A
5E5EH  (32H) STA FC95H
5E61H  (21H) LXI H,2020H
5E64H  (22H) SHLD FC99H
5E67H  (21H) LXI H,5EDAH    ; Load address of EDIT statement ON ERROR handler
5E6AH  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
5E6DH  (11H) LXI D,F802H
5E70H  (21H) LXI H,5F48H
5E73H  (CDH) CALL 4D12H
5E76H  (21H) LXI H,5ED5H    ; Load address of EDIT command ON ERROR handler
5E79H  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
5E7CH  (F1H) POP PSW
5E7DH  (E1H) POP H
5E7EH  (E5H) PUSH H
5E7FH  (C3H) JMP 1140H      ; LIST statement

5E82H  (CDH) CALL 4F45H
5E85H  (CDH) CALL 212DH
5E88H  (3AH) LDA F63DH      ; Label line protect status
5E8BH  (32H) STA FACCH
5E8EH  (21H) LXI H,0000H
5E91H  (22H) SHLD F6E7H

5E94H  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
5E97H  (CDH) CALL 4009H     ; Clear all COM, TIME, and KEY interrupt definitions
5E9AH  (2AH) LHLD F9B0H
5E9DH  (7EH) MOV A,M
5E9EH  (FEH) CPI 1AH
5EA0H  (CAH) JZ 5EBDH
5EA3H  (E5H) PUSH H
5EA4H  (AFH) XRA A
5EA5H  (21H) LXI H,5EABH
5EA8H  (C3H) JMP 5F71H

5EABH  (AFH) XRA A
5EACH  (21H) LXI H,5EEBH    ; Load ON ERROR handler for LIST Command???
5EAFH  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
5EB2H  (21H) LXI H,5F48H
5EB5H  (16H) MVI D,F8H
5EB7H  (C3H) JMP 4D9EH

5EBAH  (CDH) CALL 4231H     ; CLS statement
5EBDH  (AFH) XRA A
5EBEH  (32H) STA F651H      ; In TEXT because of BASIC EDIT flag
5EC1H  (6FH) MOV L,A        ; Prepare to clear the ON ERROR handler
5EC2H  (67H) MOV H,A        ; Clear the MSB too
5EC3H  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
5EC6H  (CDH) CALL 1FF8H
5EC9H  (CDH) CALL 3F6DH
5ECCH  (3AH) LDA FACCH
5ECFH  (32H) STA F63DH      ; Label line protect status
5ED2H  (C3H) JMP 6C5BH

; ======================================================
; EDIT command ON ERROR handler
; ======================================================
5ED5H  (D5H) PUSH D
5ED6H  (CDH) CALL 1FF8H
5ED9H  (D1H) POP D
5EDAH  (D5H) PUSH D
5EDBH  (AFH) XRA A          ; Prepare to zero out BASIC EDIT flag and ON ERROR vector
5EDCH  (32H) STA F651H      ; In TEXT because of BASIC EDIT flag
5EDFH  (6FH) MOV L,A        ; Prepare to zero out the ON ERROR handler
5EE0H  (67H) MOV H,A        ; Zero out MSB too
5EE1H  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
5EE4H  (CDH) CALL 4F45H
5EE7H  (D1H) POP D
5EE8H  (C3H) JMP 045DH      ; Generate error in E

; ======================================================
; ON ERROR Handler for something.  But for What???
; ======================================================
5EEBH  (7BH) MOV A,E
5EECH  (F5H) PUSH PSW
5EEDH  (2AH) LHLD FC87H
5EF0H  (2BH) DCX H
5EF1H  (46H) MOV B,M
5EF2H  (05H) DCR B
5EF3H  (2BH) DCX H
5EF4H  (4EH) MOV C,M
5EF5H  (2BH) DCX H
5EF6H  (6EH) MOV L,M
5EF7H  (AFH) XRA A
5EF8H  (67H) MOV H,A
5EF9H  (09H) DAD B
5EFAH  (01H) LXI B,FFFFH
5EFDH  (09H) DAD B
5EFEH  (DAH) JC 5F03H
5F01H  (6FH) MOV L,A
5F02H  (67H) MOV H,A
5F03H  (22H) SHLD F6E7H
5F06H  (CDH) CALL 4F45H
5F09H  (F1H) POP PSW
5F0AH  (FEH) CPI 07H
5F0CH  (21H) LXI H,60B1H    ; Load pointer to "Memory full" text
5F0FH  (CAH) JZ 5F15H
5F12H  (21H) LXI H,5F38H    ; Load pointer to "Text ill-formed" text
5F15H  (CDH) CALL 4231H     ; CLS statement
5F18H  (CDH) CALL 27B1H     ; Print buffer at M until NULL or '"'
5F1BH  (21H) LXI H,5F60H    ; Load pointer to "TEXT" text
5F1EH  (CDH) CALL 5F24H     ; Display "Press space bar for " (Text at HL)
5F21H  (C3H) JMP 5E94H

; ======================================================
; Display "Press space bar for " (Text at HL)
; ======================================================
5F24H  (E5H) PUSH H         ; Push pointer to "MENU" or "TEXT"
5F25H  (21H) LXI H,5F49H    ; Load pointer to "Press space bar for" text
5F28H  (CDH) CALL 27B1H     ; Print buffer at M until NULL or '"'
5F2BH  (E1H) POP H          ; Pop pointer to "MENU" or "TEXT"
5F2CH  (CDH) CALL 27B1H     ; Print buffer at M until NULL or '"'

; ======================================================
; Wait for a space to be entered on keyboard
; ======================================================
5F2FH  (CDH) CALL 12CBH     ; Wait for key from keyboard
5F32H  (FEH) CPI 20H        ; Test if SPACE pressed
5F34H  (C2H) JNZ 5F2FH      ; Jump to get key again if not space
5F37H  (C9H) RET

; ======================================================
; Strings used by TEXT
; ======================================================
5F38H  DB   "Text ill-formed",07H,00H
5F49H  DB   0DH,0AH,"Press space bar for ",00H
5F60H  DB   "TEXT",00H

; ======================================================
; Edit .DO files
; ======================================================
5F65H  (E5H) PUSH H
5F66H  (21H) LXI H,0000H
5F69H  (22H) SHLD F6E7H
5F6CH  (3EH) MVI A,01H
5F6EH  (21H) LXI H,5797H
5F71H  (32H) STA F921H
5F74H  (22H) SHLD F765H
5F77H  (CDH) CALL 426EH     ; Cancel inverse character mode
5F7AH  (CDH) CALL 428AH     ; Erase function key display
5F7DH  (CDH) CALL 423FH     ; Stop automatic scrolling
5F80H  (CDH) CALL 424EH     ; Turn the cursor off
5F83H  (CDH) CALL 65B9H
5F86H  (21H) LXI H,5E2AH    ; Load pointer to TEXT function key labels
5F89H  (CDH) CALL 5A7CH     ; Set new function key table
5F8CH  (3AH) LDA F651H      ; In TEXT because of BASIC EDIT flag
5F8FH  (A7H) ANA A
5F90H  (CAH) JZ 5F9FH
5F93H  (21H) LXI H,7845H
5F96H  (22H) SHLD F7F9H
5F99H  (21H) LXI H,7469H
5F9CH  (22H) SHLD F7FBH
5F9FH  (21H) LXI H,5E4FH    ; Point to CTRL-Y key string 
5FA2H  (22H) SHLD F88AH     ; Save as key sequence for SHIFT-PRINT key
5FA5H  (3AH) LDA F63CH      ; Active columns count (1-40)
5FA8H  (32H) STA F922H
5FABH  (3EH) MVI A,80H
5FADH  (32H) STA F650H
5FB0H  (AFH) XRA A
5FB1H  (6FH) MOV L,A
5FB2H  (67H) MOV H,A
5FB3H  (32H) STA F6DFH
5FB6H  (32H) STA F920H
5FB9H  (32H) STA F6E1H
5FBCH  (32H) STA F71FH
5FBFH  (22H) SHLD F6E2H
5FC2H  (E1H) POP H
5FC3H  (22H) SHLD F767H
5FC6H  (E5H) PUSH H
5FC7H  (CDH) CALL 6B2AH
5FCAH  (CDH) CALL 634AH
5FCDH  (D1H) POP D
5FCEH  (2AH) LHLD F6E7H
5FD1H  (19H) DAD D
5FD2H  (CDH) CALL 63CDH
5FD5H  (E5H) PUSH H
5FD6H  (CDH) CALL 6986H
5FD9H  (E1H) POP H
5FDAH  (CDH) CALL 630BH

; ======================================================
; Main TEXT edit loop
; ======================================================
5FDDH  (CDH) CALL 5D53H
5FE0H  (21H) LXI H,5FDDH    ; Make the ON ERROR handler the Main TEXT loop
5FE3H  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
5FE6H  (E5H) PUSH H
5FE7H  (3AH) LDA F6DFH
5FEAH  (32H) STA F6E0H
5FEDH  (CDH) CALL 63E5H     ; Get next byte for TEXT Program entry
5FF0H  (32H) STA F6DFH
5FF3H  (F5H) PUSH PSW
5FF4H  (CDH) CALL 65ECH
5FF7H  (F1H) POP PSW
5FF8H  (DAH) JC 6501H
5FFBH  (FEH) CPI 7FH
5FFDH  (CAH) JZ 6118H
6000H  (FEH) CPI 20H
6002H  (D2H) JNC 608AH      ; TEXT control I routine
6005H  (4FH) MOV C,A
6006H  (06H) MVI B,00H
6008H  (21H) LXI H,6016H
600BH  (09H) DAD B
600CH  (09H) DAD B
600DH  (4EH) MOV C,M
600EH  (23H) INX H
600FH  (66H) MOV H,M
6010H  (69H) MOV L,C
6011H  (E5H) PUSH H
6012H  (2AH) LHLD F639H     ; Cursor row (1-8)
6015H  (C9H) RET

; ======================================================
; TEXT control character vector table
; ======================================================
6016H  DW   6015H,618CH,61D7H,628FH
601EH  DW   60DEH,6155H,617AH,6713H
6026H  DW   610BH,608AH,6015H,6015H
602EH  DW   6242H,60BEH,6551H,6431H
6036H  DW   607CH,620BH,61FDH,6151H
603EH  DW   61C2H,6445H,6774H,6210H
6046H  DW   60E2H,6691H,621CH,6056H
604EH  DW   60DEH,6151H,6155H,60E2H

; ======================================================
; TEXT ESCape routine
; ======================================================
6056H  (3AH) LDA F6E0H
6059H  (D6H) SUI 1BH
605BH  (C0H) RNZ
605CH  (6FH) MOV L,A
605DH  (67H) MOV H,A
605EH  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
6061H  (FFH) RST 7          ; Jump to RST 38H Vector entry of following byte
6062H  DB   38H
6063H  (CDH) CALL 65B9H
6066H  (CDH) CALL 4244H     ; Resume automatic scrolling
6069H  (CDH) CALL 428AH     ; Erase function key display
606CH  (CDH) CALL 63DBH
606FH  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
6072H  (CDH) CALL 4222H     ; Send CRLF to screen or printer
6075H  (CDH) CALL 6383H
6078H  (2AH) LHLD F765H
607BH  (E9H) PCHL

; ======================================================
; TEXT control P routine
; ======================================================
607CH  (CDH) CALL 63E5H     ; Get next byte for TEXT Program entry
607FH  (DAH) JC 6501H
6082H  (A7H) ANA A
6083H  (C8H) RZ
6084H  (FEH) CPI 1AH
6086H  (C8H) RZ
6087H  (FEH) CPI 7FH
6089H  (C8H) RZ

; ======================================================
; TEXT control I routine
; ======================================================
608AH  (F5H) PUSH PSW
608BH  (CDH) CALL 628FH     ; TEXT control C routine
608EH  (CDH) CALL 6A9BH
6091H  (CDH) CALL 6AF9H
6094H  (F1H) POP PSW
6095H  (CDH) CALL 6396H
6098H  (DAH) JC 60A3H
609BH  (E5H) PUSH H
609CH  (CDH) CALL 6253H
609FH  (E1H) POP H
60A0H  (C3H) JMP 6146H

60A3H  (CDH) CALL 659BH
60A6H  (E5H) PUSH H
60A7H  (21H) LXI H,60B1H    ; Load pointer to "Memory full" text
60AAH  (CDH) CALL 65AEH
60ADH  (E1H) POP H
60AEH  (C3H) JMP 427CH      ; Set the current cursor position (H=Row,L=Col)

60B1H  DB   "Memory full",07H,00H

; ======================================================
; TEXT control M routine
; ======================================================
60BEH  (CDH) CALL 628FH     ; TEXT control C routine
60C1H  (CDH) CALL 6A9BH
60C4H  (2AH) LHLD FB62H
60C7H  (23H) INX H
60C8H  (7EH) MOV A,M
60C9H  (23H) INX H
60CAH  (B6H) ORA M
60CBH  (C2H) JNZ 60A3H
60CEH  (CDH) CALL 6253H
60D1H  (CDH) CALL 6AF9H
60D4H  (3EH) MVI A,0DH
60D6H  (CDH) CALL 6396H
60D9H  (3EH) MVI A,0AH
60DBH  (C3H) JMP 6095H

; ======================================================
; TEXT right arrow and control D routine
; ======================================================
60DEH  (CDH) CALL 60E8H
60E1H  (37H) STC

; ======================================================
; TEXT down arrow and control X routine
; ======================================================
60E2H  (D4H) CNC 60F5H
60E5H  (C3H) JMP 62A0H

60E8H  (2AH) LHLD F639H     ; Cursor row (1-8)
60EBH  (3AH) LDA F63CH      ; Active columns count (1-40)
60EEH  (24H) INR H
60EFH  (BCH) CMP H
60F0H  (D2H) JNC 6175H
60F3H  (26H) MVI H,01H
60F5H  (2CH) INR L
60F6H  (7DH) MOV A,L
60F7H  (E5H) PUSH H
60F8H  (CDH) CALL 6A48H
60FBH  (7BH) MOV A,E
60FCH  (A2H) ANA D
60FDH  (3CH) INR A
60FEH  (E1H) POP H
60FFH  (37H) STC
6100H  (C8H) RZ
6101H  (CDH) CALL 63CDH
6104H  (BDH) CMP L
6105H  (DCH) CC 6311H
6108H  (C3H) JMP 6175H

; ======================================================
; TEXT control H routine
; ======================================================
610BH  (CDH) CALL 628FH     ; TEXT control C routine
610EH  (CDH) CALL 6AF9H
6111H  (CDH) CALL 630BH
6114H  (CDH) CALL 615BH
6117H  (D8H) RC
6118H  (CDH) CALL 628FH     ; TEXT control C routine
611BH  (CDH) CALL 6AF9H
611EH  (E5H) PUSH H
611FH  (CDH) CALL 630BH
6122H  (E1H) POP H
6123H  (7EH) MOV A,M
6124H  (FEH) CPI 1AH
6126H  (C8H) RZ
6127H  (F5H) PUSH PSW
6128H  (E5H) PUSH H
6129H  (E5H) PUSH H
612AH  (CDH) CALL 6A9BH
612DH  (E1H) POP H
612EH  (CDH) CALL 63B6H
6131H  (CDH) CALL 6256H
6134H  (E1H) POP H
6135H  (F1H) POP PSW
6136H  (FEH) CPI 0DH
6138H  (C2H) JNZ 6146H
613BH  (7EH) MOV A,M
613CH  (FEH) CPI 0AH
613EH  (C2H) JNZ 6146H
6141H  (F5H) PUSH PSW
6142H  (E5H) PUSH H
6143H  (C3H) JMP 612EH

6146H  (E5H) PUSH H
6147H  (3AH) LDA F639H      ; Cursor row (1-8)
614AH  (CDH) CALL 699EH
614DH  (E1H) POP H
614EH  (C3H) JMP 62F6H

; ======================================================
; TEXT left arrow and control S routine
; ======================================================
6151H  (CDH) CALL 615BH
6154H  (37H) STC

; ======================================================
; TEXT up arrow and control E routine
; ======================================================
6155H  (D4H) CNC 6166H
6158H  (C3H) JMP 62A0H

615BH  (2AH) LHLD F639H     ; Cursor row (1-8)
615EH  (25H) DCR H
615FH  (C2H) JNZ 6175H
6162H  (3AH) LDA F63CH      ; Active columns count (1-40)
6165H  (67H) MOV H,A
6166H  (E5H) PUSH H
6167H  (CDH) CALL 6A45H
616AH  (2AH) LHLD F767H
616DH  (DFH) RST 3          ; Compare DE and HL
616EH  (E1H) POP H
616FH  (3FH) CMC
6170H  (D8H) RC
6171H  (2DH) DCR L
6172H  (CCH) CZ 631DH
6175H  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
6178H  (A7H) ANA A
6179H  (C9H) RET

; ======================================================
; TEXT control F routine
; ======================================================
617AH  (CDH) CALL 6AF9H
617DH  (CDH) CALL 61A4H
6180H  (C2H) JNZ 617DH
6183H  (CDH) CALL 61A4H
6186H  (CAH) JZ 6183H
6189H  (C3H) JMP 619EH

; ======================================================
; TEXT control A routine
; ======================================================
618CH  (CDH) CALL 6AF9H
618FH  (CDH) CALL 61AFH
6192H  (CAH) JZ 618FH
6195H  (CDH) CALL 61AFH
6198H  (C2H) JNZ 6195H
619BH  (CDH) CALL 61A4H
619EH  (CDH) CALL 62F6H
61A1H  (C3H) JMP 62A0H

61A4H  (7EH) MOV A,M
61A5H  (FEH) CPI 1AH
61A7H  (C1H) POP B
61A8H  (CAH) JZ 619EH
61ABH  (23H) INX H
61ACH  (C3H) JMP 61BAH

61AFH  (EBH) XCHG
61B0H  (2AH) LHLD F767H
61B3H  (EBH) XCHG
61B4H  (DFH) RST 3          ; Compare DE and HL
61B5H  (C1H) POP B
61B6H  (CAH) JZ 619EH
61B9H  (2BH) DCX H
61BAH  (C5H) PUSH B
61BBH  (E5H) PUSH H
61BCH  (7EH) MOV A,M
61BDH  (CDH) CALL 6965H
61C0H  (E1H) POP H
61C1H  (C9H) RET

; ======================================================
; TEXT control T routine
; ======================================================
61C2H  (2DH) DCR L
61C3H  (2EH) MVI L,01H
61C5H  (C2H) JNZ 61D1H
61C8H  (E5H) PUSH H
61C9H  (CDH) CALL 6A45H
61CCH  (EBH) XCHG
61CDH  (CDH) CALL 6230H
61D0H  (E1H) POP H
61D1H  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
61D4H  (C3H) JMP 62A0H

; ======================================================
; TEXT control B routine
; ======================================================
61D7H  (E5H) PUSH H
61D8H  (2CH) INR L
61D9H  (CDH) CALL 63CDH
61DCH  (3CH) INR A
61DDH  (BDH) CMP L
61DEH  (C2H) JNZ 61ECH
61E1H  (F5H) PUSH PSW
61E2H  (CDH) CALL 6A45H
61E5H  (EBH) XCHG
61E6H  (3EH) MVI A,01H
61E8H  (CDH) CALL 6233H
61EBH  (F1H) POP PSW
61ECH  (3DH) DCR A
61EDH  (CDH) CALL 6A48H
61F0H  (47H) MOV B,A
61F1H  (13H) INX D
61F2H  (7AH) MOV A,D
61F3H  (B3H) ORA E
61F4H  (78H) MOV A,B
61F5H  (CAH) JZ 61ECH
61F8H  (E1H) POP H
61F9H  (6FH) MOV L,A
61FAH  (C3H) JMP 61D1H

; ======================================================
; TEXT control R routine
; ======================================================
61FDH  (3AH) LDA F63CH      ; Active columns count (1-40)
6200H  (67H) MOV H,A
6201H  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
6204H  (CDH) CALL 6AF9H
6207H  (CDH) CALL 6AA3H
620AH  (01H) LXI B,0126H
620DH  (C3H) JMP 61D1H

; ======================================================
; TEXT control W routine
; ======================================================
6210H  (2AH) LHLD F767H
6213H  (CDH) CALL 6236H
6216H  (CDH) CALL 422DH     ; Home cursor
6219H  (C3H) JMP 62A0H

; ======================================================
; TEXT control Z routine
; ======================================================
621CH  (2AH) LHLD FB62H
621FH  (E5H) PUSH H
6220H  (CDH) CALL 6A3EH
6223H  (E1H) POP H
6224H  (DFH) RST 3          ; Compare DE and HL
6225H  (E5H) PUSH H
6226H  (D4H) CNC 6230H
6229H  (E1H) POP H
622AH  (CDH) CALL 630BH
622DH  (C3H) JMP 62A0H

6230H  (CDH) CALL 63CDH
6233H  (CDH) CALL 6B39H
6236H  (CDH) CALL 0013H     ; Load pointer to Storage of TEXT Line Starts in DE
6239H  (C8H) RZ
623AH  (22H) SHLD F6EBH     ; Storage of TEXT Line Starts
623DH  (3EH) MVI A,01H
623FH  (C3H) JMP 69CBH

; ======================================================
; TEXT control L routine
; ======================================================
6242H  (CDH) CALL 628FH     ; TEXT control C routine
6245H  (CDH) CALL 6AF9H
6248H  (22H) SHLD F6E2H
624BH  (22H) SHLD F6E4H
624EH  (5DH) MOV E,L
624FH  (54H) MOV D,H
6250H  (C3H) JMP 62B3H

6253H  (0EH) MVI C,00H
6255H  (21H) LXI H,800EH
6258H  (CDH) CALL 63CDH
625BH  (21H) LXI H,F639H    ; Cursor row (1-8)
625EH  (96H) SUB M
625FH  (47H) MOV B,A
6260H  (CDH) CALL 6A45H
6263H  (23H) INX H
6264H  (23H) INX H
6265H  (5EH) MOV E,M
6266H  (23H) INX H
6267H  (56H) MOV D,M
6268H  (13H) INX D
6269H  (7AH) MOV A,D
626AH  (B3H) ORA E
626BH  (C8H) RZ
626CH  (0DH) DCR C
626DH  (FAH) JM 6272H
6270H  (1BH) DCX D
6271H  (1BH) DCX D
6272H  (2BH) DCX H
6273H  (73H) MOV M,E
6274H  (23H) INX H
6275H  (72H) MOV M,D
6276H  (05H) DCR B
6277H  (F2H) JP 6264H
627AH  (C9H) RET

627BH  (CDH) CALL 422DH     ; Home cursor
627EH  (CDH) CALL 4253H     ; Delete current line on screen
6281H  (CDH) CALL 63CDH
6284H  (87H) ADD A
6285H  (47H) MOV B,A
6286H  (11H) LXI D,F6EBH    ; Storage of TEXT Line Starts
6289H  (21H) LXI H,F6EDH
628CH  (C3H) JMP 2542H      ; Move B bytes from M to (DE)

; ======================================================
; TEXT control C routine
; ======================================================
628FH  (CDH) CALL 62EEH
6292H  (E5H) PUSH H
6293H  (21H) LXI H,0000H
6296H  (22H) SHLD F6E2H
6299H  (CDH) CALL 6AF9H
629CH  (D1H) POP D
629DH  (C3H) JMP 62B0H

62A0H  (CDH) CALL 62EEH
62A3H  (CDH) CALL 6AF9H
62A6H  (EBH) XCHG
62A7H  (2AH) LHLD F6E4H
62AAH  (DFH) RST 3          ; Compare DE and HL
62ABH  (C8H) RZ
62ACH  (EBH) XCHG
62ADH  (22H) SHLD F6E4H
62B0H  (CDH) CALL 64B2H
62B3H  (E5H) PUSH H
62B4H  (D5H) PUSH D
62B5H  (CDH) CALL 6A3EH
62B8H  (E1H) POP H
62B9H  (DFH) RST 3          ; Compare DE and HL
62BAH  (DAH) JC 62C0H
62BDH  (CDH) CALL 63DBH
62C0H  (DCH) CC 6AA3H
62C3H  (65H) MOV H,L
62C4H  (E3H) XTHL
62C5H  (CDH) CALL 0013H     ; Load pointer to Storage of TEXT Line Starts in DE
62C8H  (D2H) JNC 62CDH
62CBH  (2EH) MVI L,01H
62CDH  (D4H) CNC 6AA3H
62D0H  (F1H) POP PSW
62D1H  (95H) SUB L
62D2H  (4FH) MOV C,A
62D3H  (EBH) XCHG
62D4H  (2AH) LHLD F639H     ; Cursor row (1-8)
62D7H  (EBH) XCHG
62D8H  (D5H) PUSH D
62D9H  (26H) MVI H,01H
62DBH  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
62DEH  (CDH) CALL 6A45H
62E1H  (79H) MOV A,C
62E2H  (F5H) PUSH PSW
62E3H  (CDH) CALL 6A0DH
62E6H  (F1H) POP PSW
62E7H  (3DH) DCR A
62E8H  (F2H) JP 62E2H
62EBH  (C3H) JMP 60ADH

62EEH  (2AH) LHLD F6E2H
62F1H  (7CH) MOV A,H
62F2H  (B5H) ORA L
62F3H  (C0H) RNZ
62F4H  (E1H) POP H
62F5H  (C9H) RET

62F6H  (CDH) CALL 0013H     ; Load pointer to Storage of TEXT Line Starts in DE
62F9H  (DCH) CC 631EH
62FCH  (DAH) JC 62F6H
62FFH  (E5H) PUSH H
6300H  (CDH) CALL 6A3EH
6303H  (E1H) POP H
6304H  (DFH) RST 3          ; Compare DE and HL
6305H  (D4H) CNC 6312H
6308H  (D2H) JNC 62FFH
630BH  (CDH) CALL 6AA3H
630EH  (C3H) JMP 427CH      ; Set the current cursor position (H=Row,L=Col)

6311H  (2DH) DCR L
6312H  (F5H) PUSH PSW
6313H  (E5H) PUSH H
6314H  (CDH) CALL 627BH
6317H  (CDH) CALL 63CDH
631AH  (C3H) JMP 6344H

631DH  (2CH) INR L
631EH  (F5H) PUSH PSW
631FH  (E5H) PUSH H
6320H  (CDH) CALL 65DFH
6323H  (CDH) CALL 422DH     ; Home cursor
6326H  (CDH) CALL 4258H     ; Insert line a current line
6329H  (CDH) CALL 6A55H
632CH  (D5H) PUSH D
632DH  (CDH) CALL 6A3EH
6330H  (23H) INX H
6331H  (5DH) MOV E,L
6332H  (54H) MOV D,H
6333H  (2BH) DCX H
6334H  (2BH) DCX H
6335H  (3DH) DCR A
6336H  (87H) ADD A
6337H  (4FH) MOV C,A
6338H  (06H) MVI B,00H
633AH  (CDH) CALL 6BE6H     ; Move BC bytes from M to (DE) with decrement
633DH  (EBH) XCHG
633EH  (D1H) POP D
633FH  (72H) MOV M,D
6340H  (2BH) DCX H
6341H  (73H) MOV M,E
6342H  (3EH) MVI A,01H
6344H  (CDH) CALL 69CBH
6347H  (E1H) POP H
6348H  (F1H) POP PSW
6349H  (C9H) RET

634AH  (2AH) LHLD FBB6H     ; Unused memory pointer
634DH  (01H) LXI B,00C8H
6350H  (09H) DAD B
6351H  (AFH) XRA A
6352H  (95H) SUB L
6353H  (6FH) MOV L,A
6354H  (9FH) SBB A
6355H  (94H) SUB H
6356H  (67H) MOV H,A
6357H  (39H) DAD SP
6358H  (D0H) RNC
6359H  (7CH) MOV A,H
635AH  (B5H) ORA L
635BH  (C8H) RZ
635CH  (44H) MOV B,H
635DH  (4DH) MOV C,L
635EH  (2AH) LHLD FB62H
6361H  (EBH) XCHG
6362H  (13H) INX D
6363H  (CDH) CALL 6B7FH
6366H  (36H) MVI M,00H
6368H  (23H) INX H
6369H  (0BH) DCX B
636AH  (78H) MOV A,B
636BH  (B1H) ORA C
636CH  (C2H) JNZ 6366H
636FH  (C9H) RET

6370H  (2AH) LHLD FBAEH     ; Start of DO files pointer
6373H  (CDH) CALL 6B2DH
6376H  (23H) INX H
6377H  (EBH) XCHG
6378H  (2AH) LHLD FBB0H     ; Start of CO files pointer
637BH  (EBH) XCHG
637CH  (DFH) RST 3          ; Compare DE and HL
637DH  (D0H) RNC
637EH  (7EH) MOV A,M
637FH  (A7H) ANA A
6380H  (C2H) JNZ 6373H
6383H  (2AH) LHLD FB62H
6386H  (E5H) PUSH H
6387H  (01H) LXI B,FFFFH
638AH  (AFH) XRA A
638BH  (23H) INX H
638CH  (03H) INX B
638DH  (BEH) CMP M
638EH  (CAH) JZ 638BH
6391H  (E1H) POP H
6392H  (23H) INX H
6393H  (C3H) JMP 6B9FH      ; Delete BC characters at M

6396H  (EBH) XCHG
6397H  (2AH) LHLD FB62H
639AH  (23H) INX H
639BH  (34H) INR M
639CH  (35H) DCR M
639DH  (37H) STC
639EH  (C0H) RNZ
639FH  (F5H) PUSH PSW
63A0H  (22H) SHLD FB62H
63A3H  (EBH) XCHG
63A4H  (7BH) MOV A,E
63A5H  (95H) SUB L
63A6H  (4FH) MOV C,A
63A7H  (7AH) MOV A,D
63A8H  (9CH) SUB H
63A9H  (47H) MOV B,A
63AAH  (6BH) MOV L,E
63ABH  (62H) MOV H,D
63ACH  (2BH) DCX H
63ADH  (CDH) CALL 6BE6H     ; Move BC bytes from M to (DE) with decrement
63B0H  (23H) INX H
63B1H  (F1H) POP PSW
63B2H  (77H) MOV M,A
63B3H  (23H) INX H
63B4H  (A7H) ANA A
63B5H  (C9H) RET

63B6H  (EBH) XCHG
63B7H  (2AH) LHLD FB62H
63BAH  (7DH) MOV A,L
63BBH  (93H) SUB E
63BCH  (4FH) MOV C,A
63BDH  (7CH) MOV A,H
63BEH  (9AH) SBB D
63BFH  (47H) MOV B,A
63C0H  (2BH) DCX H
63C1H  (22H) SHLD FB62H
63C4H  (6BH) MOV L,E
63C5H  (62H) MOV H,D
63C6H  (23H) INX H
63C7H  (CDH) CALL 6BDBH     ; Move BC bytes from M to (DE) with increment
63CAH  (AFH) XRA A
63CBH  (12H) STAX D
63CCH  (C9H) RET

63CDH  (E5H) PUSH H
63CEH  (F5H) PUSH PSW
63CFH  (21H) LXI H,F63DH    ; Label line protect status
63D2H  (3AH) LDA F63BH      ; Active rows count (1-8)
63D5H  (86H) ADD M
63D6H  (6FH) MOV L,A
63D7H  (F1H) POP PSW
63D8H  (7DH) MOV A,L
63D9H  (E1H) POP H
63DAH  (C9H) RET

63DBH  (F5H) PUSH PSW
63DCH  (2AH) LHLD F63BH     ; Active rows count (1-8)
63DFH  (CDH) CALL 63CDH
63E2H  (6FH) MOV L,A
63E3H  (F1H) POP PSW
63E4H  (C9H) RET

; ======================================================
; Get next byte for TEXT Program entry
; ======================================================
63E5H  (2AH) LHLD F639H     ; Cursor row (1-8)
63E8H  (E5H) PUSH H
63E9H  (7DH) MOV A,L
63EAH  (32H) STA FAADH      ; Label line enable flag
63EDH  (3AH) LDA F63DH      ; Label line protect status
63F0H  (F5H) PUSH PSW
63F1H  (CDH) CALL 12CBH     ; Wait for key from keyboard
63F4H  (C1H) POP B
63F5H  (E1H) POP H
63F6H  (F5H) PUSH PSW
63F7H  (AFH) XRA A
63F8H  (32H) STA FAADH      ; Label line enable flag
63FBH  (3AH) LDA F63DH      ; Label line protect status
63FEH  (B8H) CMP B
63FFH  (C2H) JNZ 6404H
6402H  (F1H) POP PSW
6403H  (C9H) RET

6404H  (A7H) ANA A
6405H  (CAH) JZ 6414H
6408H  (3AH) LDA F639H      ; Cursor row (1-8)
640BH  (BDH) CMP L
640CH  (3AH) LDA F63BH      ; Active rows count (1-8)
640FH  (C4H) CNZ 6284H
6412H  (F1H) POP PSW
6413H  (C9H) RET

6414H  (E5H) PUSH H
6415H  (3AH) LDA F63BH      ; Active rows count (1-8)
6418H  (3DH) DCR A
6419H  (CDH) CALL 6A48H
641CH  (23H) INX H
641DH  (36H) MVI M,FEH
641FH  (23H) INX H
6420H  (23H) INX H
6421H  (36H) MVI M,FEH
6423H  (3DH) DCR A
6424H  (CDH) CALL 69CBH
6427H  (AFH) XRA A
6428H  (32H) STA F6E1H
642BH  (E1H) POP H
642CH  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
642FH  (F1H) POP PSW
6430H  (C9H) RET

; ======================================================
; TEXT control O routine
; ======================================================
6431H  (CDH) CALL 62EEH
6434H  (CDH) CALL 6383H
6437H  (CDH) CALL 64B6H
643AH  (F5H) PUSH PSW
643BH  (CDH) CALL 634AH
643EH  (F1H) POP PSW
643FH  (D2H) JNC 628FH      ; TEXT control C routine
6442H  (C3H) JMP 60A3H

; ======================================================
; TEXT control U routine
; ======================================================
6445H  (CDH) CALL 62EEH
6448H  (CDH) CALL 6383H
644BH  (CDH) CALL 64B6H
644EH  (F5H) PUSH PSW
644FH  (D4H) CNC 6B9FH      ; Delete BC characters at M
6452H  (F1H) POP PSW
6453H  (D2H) JNC 646FH
6456H  (78H) MOV A,B
6457H  (A7H) ANA A
6458H  (CAH) JZ 646AH
645BH  (CDH) CALL 1BB1H     ; Renew automatic power-off counter
645EH  (C5H) PUSH B
645FH  (01H) LXI B,0100H
6462H  (CDH) CALL 6488H
6465H  (C1H) POP B
6466H  (05H) DCR B
6467H  (C2H) JNZ 645BH
646AH  (79H) MOV A,C
646BH  (A7H) ANA A
646CH  (C4H) CNZ 6488H
646FH  (11H) LXI D,0000H
6472H  (EBH) XCHG
6473H  (22H) SHLD F6E2H
6476H  (EBH) XCHG
6477H  (E5H) PUSH H
6478H  (3AH) LDA F639H      ; Cursor row (1-8)
647BH  (CDH) CALL 6986H
647EH  (E1H) POP H
647FH  (CDH) CALL 630BH
6482H  (CDH) CALL 6B2AH
6485H  (C3H) JMP 634AH

6488H  (E5H) PUSH H
6489H  (C5H) PUSH B
648AH  (EBH) XCHG
648BH  (2AH) LHLD FC87H
648EH  (EBH) XCHG
648FH  (CDH) CALL 6BDBH     ; Move BC bytes from M to (DE) with increment
6492H  (C1H) POP B
6493H  (E1H) POP H
6494H  (E5H) PUSH H
6495H  (C5H) PUSH B
6496H  (CDH) CALL 6B9FH     ; Delete BC characters at M
6499H  (2AH) LHLD F9A5H     ; Start of Paste Buffer
649CH  (09H) DAD B
649DH  (EBH) XCHG
649EH  (C1H) POP B
649FH  (CDH) CALL 6B7FH
64A2H  (EBH) XCHG
64A3H  (2AH) LHLD FC87H
64A6H  (CDH) CALL 6BDBH     ; Move BC bytes from M to (DE) with increment
64A9H  (E1H) POP H
64AAH  (C9H) RET

64ABH  (2AH) LHLD F6E2H
64AEH  (EBH) XCHG
64AFH  (2AH) LHLD F6E4H
64B2H  (DFH) RST 3          ; Compare DE and HL
64B3H  (D8H) RC
64B4H  (EBH) XCHG
64B5H  (C9H) RET

64B6H  (CDH) CALL 2262H
64B9H  (2AH) LHLD F9A5H     ; Start of Paste Buffer
64BCH  (22H) SHLD F88CH     ; End of RAM for file storage
64BFH  (AFH) XRA A
64C0H  (32H) STA F6E6H
64C3H  (CDH) CALL 64ABH
64C6H  (1BH) DCX D
64C7H  (7BH) MOV A,E
64C8H  (95H) SUB L
64C9H  (4FH) MOV C,A
64CAH  (7AH) MOV A,D
64CBH  (9CH) SUB H
64CCH  (47H) MOV B,A
64CDH  (DAH) JC 64E3H
64D0H  (1AH) LDAX D
64D1H  (FEH) CPI 1AH
64D3H  (CAH) JZ 64E4H
64D6H  (FEH) CPI 0DH
64D8H  (C2H) JNZ 64E3H
64DBH  (13H) INX D
64DCH  (1AH) LDAX D
64DDH  (FEH) CPI 0AH
64DFH  (C2H) JNZ 64E3H
64E2H  (03H) INX B
64E3H  (03H) INX B
64E4H  (78H) MOV A,B
64E5H  (B1H) ORA C
64E6H  (C8H) RZ
64E7H  (E5H) PUSH H
64E8H  (2AH) LHLD F88CH     ; End of RAM for file storage
64EBH  (CDH) CALL 6B6DH     ; Insert BC spaces at M
64EEH  (EBH) XCHG
64EFH  (E1H) POP H
64F0H  (D8H) RC
64F1H  (3AH) LDA F6E6H
64F4H  (A7H) ANA A
64F5H  (CAH) JZ 64F9H
64F8H  (09H) DAD B
64F9H  (E5H) PUSH H
64FAH  (C5H) PUSH B
64FBH  (CDH) CALL 6BDBH     ; Move BC bytes from M to (DE) with increment
64FEH  (C1H) POP B
64FFH  (E1H) POP H
6500H  (C9H) RET

6501H  (CDH) CALL 628FH     ; TEXT control C routine
6504H  (CDH) CALL 6383H
6507H  (CDH) CALL 2146H     ; Update line addresses for ALL BASIC programs
650AH  (CDH) CALL 6AF9H
650DH  (22H) SHLD F88CH     ; End of RAM for file storage
6510H  (7CH) MOV A,H
6511H  (32H) STA F6E6H
6514H  (2AH) LHLD F9A5H     ; Start of Paste Buffer
6517H  (7EH) MOV A,M
6518H  (FEH) CPI 1AH
651AH  (CAH) JZ 634AH
651DH  (5DH) MOV E,L
651EH  (54H) MOV D,H
651FH  (1BH) DCX D
6520H  (13H) INX D
6521H  (1AH) LDAX D
6522H  (FEH) CPI 1AH
6524H  (C2H) JNZ 6520H
6527H  (CDH) CALL 64C7H
652AH  (F5H) PUSH PSW
652BH  (D5H) PUSH D
652CH  (CDH) CALL 6B2AH
652FH  (CDH) CALL 634AH
6532H  (D1H) POP D
6533H  (F1H) POP PSW
6534H  (DAH) JC 60A3H
6537H  (D5H) PUSH D
6538H  (2AH) LHLD F88CH     ; End of RAM for file storage
653BH  (3AH) LDA F639H      ; Cursor row (1-8)
653EH  (CDH) CALL 6986H
6541H  (CDH) CALL 6A3EH
6544H  (E1H) POP H
6545H  (DFH) RST 3          ; Compare DE and HL
6546H  (CDH) CALL 63CDH
6549H  (E5H) PUSH H
654AH  (D4H) CNC 6986H
654DH  (E1H) POP H
654EH  (C3H) JMP 630BH

; ======================================================
; TEXT control N routine
; ======================================================
6551H  (CDH) CALL 659BH
6554H  (CDH) CALL 6AF9H
6557H  (E5H) PUSH H
6558H  (21H) LXI H,65D7H
655BH  (11H) LXI D,F71FH
655EH  (D5H) PUSH D
655FH  (CDH) CALL 6603H
6562H  (D1H) POP D
6563H  (23H) INX H
6564H  (7EH) MOV A,M
6565H  (A7H) ANA A
6566H  (37H) STC
6567H  (CAH) JZ 658BH
656AH  (CDH) CALL 65C3H     ; Copy NULL terminated string at M to (DE)
656DH  (D1H) POP D
656EH  (D5H) PUSH D
656FH  (1AH) LDAX D
6570H  (FEH) CPI 1AH
6572H  (CAH) JZ 658FH
6575H  (13H) INX D
6576H  (CDH) CALL 5C3FH     ; Find text at M in the file at (DE)
6579H  (D2H) JNC 658FH
657CH  (D1H) POP D
657DH  (C5H) PUSH B
657EH  (C5H) PUSH B
657FH  (CDH) CALL 6A3EH
6582H  (E1H) POP H
6583H  (DFH) RST 3          ; Compare DE and HL
6584H  (DAH) JC 658BH
6587H  (CDH) CALL 6981H
658AH  (A7H) ANA A
658BH  (DCH) CC 65F3H
658EH  (37H) STC
658FH  (21H) LXI H,65CEH
6592H  (D4H) CNC 65AEH
6595H  (C3H) JMP 6229H

6598H  (CDH) CALL 628FH     ; TEXT control C routine
659BH  (2AH) LHLD F639H     ; Cursor row (1-8)
659EH  (CDH) CALL 63CDH
65A1H  (BDH) CMP L
65A2H  (C0H) RNZ
65A3H  (2DH) DCR L
65A4H  (E5H) PUSH H
65A5H  (CDH) CALL 627BH
65A8H  (C3H) JMP 60ADH

65ABH  (21H) LXI H,5771H    ; Load pointer to "aborted" text
65AEH  (3EH) MVI A,01H
65B0H  (32H) STA F6E1H
65B3H  (CDH) CALL 65DFH
65B6H  (CDH) CALL 27B1H     ; Print buffer at M until NULL or '"'
65B9H  (CDH) CALL 13DBH     ; Check keyboard queue for pending characters
65BCH  (C8H) RZ
65BDH  (CDH) CALL 12CBH     ; Wait for key from keyboard
65C0H  (C3H) JMP 65B9H

; ======================================================
; Copy NULL terminated string at M to (DE)
; ======================================================
65C3H  (E5H) PUSH H
65C4H  (7EH) MOV A,M
65C5H  (12H) STAX D
65C6H  (23H) INX H
65C7H  (13H) INX D
65C8H  (A7H) ANA A
65C9H  (C2H) JNZ 65C4H
65CCH  (E1H) POP H
65CDH  (C9H) RET

65CEH  DB   "No match",00H
65D7H  DB   "String:",00H
65DFH  (E5H) PUSH H
65E0H  (CDH) CALL 63DBH
65E3H  (26H) MVI H,01H
65E5H  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
65E8H  (E1H) POP H
65E9H  (C3H) JMP 425DH      ; Erase from cursor to end of line

65ECH  (21H) LXI H,F6E1H
65EFH  (AFH) XRA A
65F0H  (BEH) CMP M
65F1H  (C8H) RZ
65F2H  (77H) MOV M,A
65F3H  (2AH) LHLD F639H     ; Cursor row (1-8)
65F6H  (E5H) PUSH H
65F7H  (CDH) CALL 63CDH
65FAH  (CDH) CALL 69CBH
65FDH  (C3H) JMP 60ADH

6600H  (11H) LXI D,5F48H
6603H  (D5H) PUSH D
6604H  (CDH) CALL 65B3H
6607H  (3AH) LDA F63AH      ; Cursor column (1-40)
660AH  (32H) STA FACAH
660DH  (E1H) POP H
660EH  (E5H) PUSH H
660FH  (CDH) CALL 27B1H     ; Print buffer at M until NULL or '"'
6612H  (CDH) CALL 12CBH     ; Wait for key from keyboard
6615H  (DAH) JC 6612H
6618H  (A7H) ANA A
6619H  (CAH) JZ 6612H
661CH  (E1H) POP H
661DH  (FEH) CPI 0DH
661FH  (CAH) JZ 6654H
6622H  (F5H) PUSH PSW
6623H  (CDH) CALL 63DBH
6626H  (3AH) LDA FACAH
6629H  (67H) MOV H,A
662AH  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
662DH  (CDH) CALL 425DH     ; Erase from cursor to end of line
6630H  (F1H) POP PSW
6631H  (11H) LXI D,F685H    ; Keyboard buffer
6634H  (06H) MVI B,01H
6636H  (A7H) ANA A
6637H  (C3H) JMP 663DH

663AH  (CDH) CALL 12CBH     ; Wait for key from keyboard
663DH  (21H) LXI H,663AH
6640H  (E5H) PUSH H
6641H  (D8H) RC
6642H  (FEH) CPI 7FH
6644H  (CAH) JZ 46A0H       ; Input routine backspace, left arrow, CTRL-H handler
6647H  (FEH) CPI 20H        ; Test for SPACE
6649H  (D2H) JNC 667EH
664CH  (21H) LXI H,665BH    ; Load pointer to Key vector mapping table
664FH  (0EH) MVI C,07H      ; Indicate 7 entries in table
6651H  (C3H) JMP 4378H      ; Key Vector table lookup

6654H  (11H) LXI D,F685H    ; Keyboard buffer
6657H  (CDH) CALL 65C3H     ; Copy NULL terminated string at M to (DE)
665AH  (C3H) JMP 6678H

665DH  DB   03H
665EH  DW   6672H
6660H  DB   08H
6661H  DW   46A0H
6663H  DB   09H
6664H  DW   667CH
6666H  DB   0DH
6667H  DW   6675H
6669H  DB   15H
666AH  DW   46C3H
666CH  DB   18H
666DH  DW   46C3H
666FH  DB   1DH
6670H  DW   46A0H

6672H  (11H) LXI D,F685H    ; Keyboard buffer
6675H  (E1H) POP H
6676H  (AFH) XRA A
6677H  (12H) STAX D
6678H  (21H) LXI H,F684H
667BH  (C9H) RET

667CH  (3EH) MVI A,09H
667EH  (4FH) MOV C,A
667FH  (3AH) LDA F63CH      ; Active columns count (1-40)
6682H  (D6H) SUI 09H
6684H  (21H) LXI H,F63AH    ; Cursor column (1-40)
6687H  (BEH) CMP M
6688H  (DAH) JC 4229H       ; BEEP statement
668BH  (79H) MOV A,C
668CH  (04H) INR B
668DH  (E7H) RST 4          ; Send character in A to screen/printer
668EH  (12H) STAX D
668FH  (13H) INX D
6690H  (C9H) RET

; ======================================================
; TEXT control Y routine
; ======================================================
6691H  (CDH) CALL 6598H
6694H  (21H) LXI H,66F2H
6697H  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
669AH  (E5H) PUSH H
669BH  (2AH) LHLD F639H     ; Cursor row (1-8)
669EH  (22H) SHLD F6E7H
66A1H  (21H) LXI H,670CH    ; Load pointer to "Width:" text
66A4H  (11H) LXI D,F64AH
66A7H  (CDH) CALL 6603H
66AAH  (D7H) RST 2          ; Get next non-white char from M
66ABH  (AFH) XRA A
66ACH  (BEH) CMP M
66ADH  (CAH) JZ 66E6H
66B0H  (32H) STA F688H
66B3H  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
66B6H  (FEH) CPI 0AH
66B8H  (D8H) RC
66B9H  (FEH) CPI 85H
66BBH  (D0H) RNC
66BCH  (D1H) POP D
66BDH  (32H) STA F649H
66C0H  (32H) STA F922H
66C3H  (32H) STA F675H      ; Output device for RST 20H (0=screen)
66C6H  (11H) LXI D,F64AH
66C9H  (21H) LXI H,F685H    ; Keyboard buffer
66CCH  (CDH) CALL 65C3H     ; Copy NULL terminated string at M to (DE)
66CFH  (3CH) INR A
66D0H  (32H) STA F920H
66D3H  (CDH) CALL 4222H     ; Send CRLF to screen or printer
66D6H  (2AH) LHLD F767H
66D9H  (EBH) XCHG
66DAH  (CDH) CALL 6A0DH
66DDH  (7AH) MOV A,D
66DEH  (A3H) ANA E
66DFH  (3CH) INR A
66E0H  (C2H) JNZ 66DAH
66E3H  (CDH) CALL 66FEH
66E6H  (CDH) CALL 65F3H
66E9H  (2AH) LHLD F6E7H
66ECH  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
66EFH  (C3H) JMP 5FDDH      ; Main TEXT edit loop

66F2H  (CDH) CALL 66FEH
66F5H  (CDH) CALL 4F45H
66F8H  (CDH) CALL 65ABH
66FBH  (C3H) JMP 66E9H

66FEH  (3AH) LDA F63CH      ; Active columns count (1-40)
6701H  (32H) STA F922H
6704H  (AFH) XRA A
6705H  (32H) STA F675H      ; Output device for RST 20H (0=screen)
6708H  (32H) STA F920H
670BH  (C9H) RET

670CH  DB   "Width:",00H

; ======================================================
; TEXT control G routine
; ======================================================
6713H  (11H) LXI D,6735H
6716H  (CDH) CALL 673EH
6719H  (DAH) JC 66F2H
671CH  (CAH) JZ 66E6H
671FH  (1EH) MVI E,02H
6721H  (CDH) CALL 4D12H
6724H  (2AH) LHLD F767H
6727H  (7EH) MOV A,M
6728H  (E7H) RST 4          ; Send character in A to screen/printer
6729H  (23H) INX H
672AH  (FEH) CPI 1AH
672CH  (C2H) JNZ 6727H
672FH  (CDH) CALL 4F45H
6732H  (C3H) JMP 66E6H

6735H  DB   "Save to:",00H
673EH  (D5H) PUSH D
673FH  (CDH) CALL 6598H
6742H  (21H) LXI H,66F2H
6745H  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
6748H  (2AH) LHLD F639H     ; Cursor row (1-8)
674BH  (22H) SHLD F6E7H
674EH  (E1H) POP H
674FH  (CDH) CALL 6600H
6752H  (D7H) RST 2          ; Get next non-white char from M
6753H  (A7H) ANA A
6754H  (C8H) RZ
6755H  (CDH) CALL 21FAH     ; Count length of string at M
6758H  (CDH) CALL 4C0BH
675BH  (C2H) JNZ 6760H
675EH  (16H) MVI D,FDH
6760H  (7AH) MOV A,D
6761H  (FEH) CPI F8H
6763H  (37H) STC
6764H  (C8H) RZ
6765H  (FEH) CPI FEH
6767H  (37H) STC
6768H  (C8H) RZ
6769H  (FEH) CPI FFH
676BH  (37H) STC
676CH  (C8H) RZ
676DH  (21H) LXI H,5F48H
6770H  (3FH) CMC
6771H  (3EH) MVI A,00H
6773H  (C9H) RET

; ======================================================
; TEXT control V routine
; ======================================================
6774H  (11H) LXI D,67D4H
6777H  (CDH) CALL 673EH
677AH  (DAH) JC 66F2H
677DH  (CAH) JZ 66E6H
6780H  (E5H) PUSH H
6781H  (21H) LXI H,67CBH
6784H  (22H) SHLD F652H     ; Save as active ON ERROR handler vector
6787H  (2AH) LHLD FB62H
678AH  (22H) SHLD F6E7H
678DH  (32H) STA FAC6H
6790H  (E3H) XTHL
6791H  (1EH) MVI E,01H
6793H  (CDH) CALL 4D12H
6796H  (E1H) POP H
6797H  (CDH) CALL 4E7AH
679AH  (DAH) JC 67B7H
679DH  (CDH) CALL 56FEH
67A0H  (CAH) JZ 6797H
67A3H  (D2H) JNC 67ABH
67A6H  (CDH) CALL 6396H
67A9H  (3EH) MVI A,0AH
67ABH  (D4H) CNC 6396H
67AEH  (D2H) JNC 6797H
67B1H  (CDH) CALL 4F45H
67B4H  (CDH) CALL 60A3H
67B7H  (CDH) CALL 4F45H
67BAH  (CDH) CALL 6B2AH
67BDH  (2AH) LHLD F6E7H
67C0H  (E5H) PUSH H
67C1H  (CDH) CALL 6981H
67C4H  (E1H) POP H
67C5H  (CDH) CALL 630BH
67C8H  (C3H) JMP 5FDDH      ; Main TEXT edit loop

67CBH  (CDH) CALL 4F45H
67CEH  (CDH) CALL 65ABH
67D1H  (C3H) JMP 67BAH

67D4H  (4CH) MOV C,H
67D5H  (6FH) MOV L,A
67D6H  (61H) MOV H,C
67D7H  (64H) MOV H,H
67D8H  (20H) RIM
67D9H  (66H) MOV H,M
67DAH  (72H) MOV M,D
67DBH  (6FH) MOV L,A
67DCH  (6DH) MOV L,L
67DDH  (3AH) LDA AF00H
67E0H  (32H) STA F890H
67E3H  (32H) STA F6E6H
67E6H  (21H) LXI H,F894H
67E9H  (22H) SHLD F892H
67ECH  (D5H) PUSH D
67EDH  (CDH) CALL 6912H
67F0H  (D1H) POP D
67F1H  (1AH) LDAX D
67F2H  (13H) INX D
67F3H  (FEH) CPI 1AH
67F5H  (CAH) JZ 6887H
67F8H  (FEH) CPI 0DH
67FAH  (CAH) JZ 6897H
67FDH  (FEH) CPI 09H
67FFH  (CAH) JZ 6807H
6802H  (FEH) CPI 20H
6804H  (DAH) JC 685DH
6807H  (CDH) CALL 68B2H
680AH  (D2H) JNC 67ECH
680DH  (1AH) LDAX D
680EH  (CDH) CALL 695EH
6811H  (C2H) JNZ 6827H
6814H  (CDH) CALL 6855H
6817H  (1AH) LDAX D
6818H  (FEH) CPI 20H
681AH  (C0H) RNZ
681BH  (3AH) LDA F920H
681EH  (A7H) ANA A
681FH  (C8H) RZ
6820H  (13H) INX D
6821H  (1AH) LDAX D
6822H  (FEH) CPI 20H
6824H  (C0H) RNZ
6825H  (1BH) DCX D
6826H  (C9H) RET

6827H  (EBH) XCHG
6828H  (22H) SHLD F88CH     ; End of RAM for file storage
682BH  (EBH) XCHG
682CH  (2AH) LHLD F892H
682FH  (22H) SHLD F88EH
6832H  (1BH) DCX D
6833H  (1AH) LDAX D
6834H  (13H) INX D
6835H  (CDH) CALL 695EH
6838H  (CAH) JZ 6855H
683BH  (1BH) DCX D
683CH  (1AH) LDAX D
683DH  (13H) INX D
683EH  (CDH) CALL 695EH
6841H  (CAH) JZ 68EFH
6844H  (1BH) DCX D
6845H  (CDH) CALL 68D9H
6848H  (C2H) JNZ 683BH
684BH  (2AH) LHLD F88EH
684EH  (22H) SHLD F892H
6851H  (2AH) LHLD F88CH     ; End of RAM for file storage
6854H  (EBH) XCHG
6855H  (3AH) LDA F920H
6858H  (3DH) DCR A
6859H  (CAH) JZ 6908H
685CH  (C9H) RET

685DH  (F5H) PUSH PSW
685EH  (3EH) MVI A,5EH
6860H  (CDH) CALL 68B2H
6863H  (DAH) JC 6877H
6866H  (F1H) POP PSW
6867H  (F6H) ORI 40H
6869H  (CDH) CALL 68B2H
686CH  (D2H) JNC 67ECH
686FH  (3AH) LDA F920H
6872H  (A7H) ANA A
6873H  (C2H) JNZ 6908H
6876H  (C9H) RET

6877H  (F1H) POP PSW
6878H  (1BH) DCX D
6879H  (2AH) LHLD F892H
687CH  (2BH) DCX H
687DH  (22H) SHLD F892H
6880H  (21H) LXI H,F890H
6883H  (35H) DCR M
6884H  (C3H) JMP 68EFH

6887H  (3AH) LDA F920H
688AH  (A7H) ANA A
688BH  (3EH) MVI A,9BH
688DH  (CCH) CZ 68B2H
6890H  (CDH) CALL 68EFH
6893H  (11H) LXI D,FFFFH
6896H  (C9H) RET

6897H  (1AH) LDAX D
6898H  (FEH) CPI 0AH
689AH  (3EH) MVI A,0DH
689CH  (C2H) JNZ 685DH
689FH  (D5H) PUSH D
68A0H  (CDH) CALL 6912H
68A3H  (D1H) POP D
68A4H  (3AH) LDA F920H
68A7H  (A7H) ANA A
68A8H  (3EH) MVI A,8FH
68AAH  (CCH) CZ 68B2H
68ADH  (CDH) CALL 68EFH
68B0H  (13H) INX D
68B1H  (C9H) RET

68B2H  (E5H) PUSH H
68B3H  (CDH) CALL 68D0H
68B6H  (21H) LXI H,F890H
68B9H  (FEH) CPI 09H
68BBH  (CAH) JZ 68C2H
68BEH  (34H) INR M
68BFH  (C3H) JMP 68C9H

68C2H  (34H) INR M
68C3H  (7EH) MOV A,M
68C4H  (E6H) ANI 07H
68C6H  (C2H) JNZ 68C2H
68C9H  (3AH) LDA F922H
68CCH  (3DH) DCR A
68CDH  (BEH) CMP M
68CEH  (E1H) POP H
68CFH  (C9H) RET

68D0H  (2AH) LHLD F892H
68D3H  (77H) MOV M,A
68D4H  (23H) INX H
68D5H  (22H) SHLD F892H
68D8H  (C9H) RET

68D9H  (2AH) LHLD F892H
68DCH  (2BH) DCX H
68DDH  (2BH) DCX H
68DEH  (2BH) DCX H
68DFH  (7EH) MOV A,M
68E0H  (FEH) CPI 1BH
68E2H  (CAH) JZ 68E7H
68E5H  (23H) INX H
68E6H  (23H) INX H
68E7H  (22H) SHLD F892H
68EAH  (21H) LXI H,F890H
68EDH  (35H) DCR M
68EEH  (C9H) RET

68EFH  (3AH) LDA F890H
68F2H  (21H) LXI H,F922H
68F5H  (BEH) CMP M
68F6H  (D0H) RNC
68F7H  (3AH) LDA F920H
68FAH  (A7H) ANA A
68FBH  (C2H) JNZ 6908H
68FEH  (3EH) MVI A,1BH
6900H  (CDH) CALL 68D0H
6903H  (3EH) MVI A,4BH
6905H  (CDH) CALL 68D0H
6908H  (3EH) MVI A,0DH
690AH  (CDH) CALL 68D0H
690DH  (3EH) MVI A,0AH
690FH  (C3H) JMP 68D0H

6912H  (CDH) CALL 62EEH
6915H  (3AH) LDA F920H
6918H  (A7H) ANA A
6919H  (C0H) RNZ
691AH  (01H) LXI B,F6E6H
691DH  (D5H) PUSH D
691EH  (EBH) XCHG
691FH  (2AH) LHLD F6E4H
6922H  (EBH) XCHG
6923H  (DFH) RST 3          ; Compare DE and HL
6924H  (D1H) POP D
6925H  (D2H) JNC 693FH
6928H  (EBH) XCHG
6929H  (DFH) RST 3          ; Compare DE and HL
692AH  (DAH) JC 694DH
692DH  (EBH) XCHG
692EH  (2AH) LHLD F6E4H
6931H  (EBH) XCHG
6932H  (DFH) RST 3          ; Compare DE and HL
6933H  (D2H) JNC 694DH
6936H  (0AH) LDAX B
6937H  (A7H) ANA A
6938H  (C0H) RNZ
6939H  (3CH) INR A
693AH  (26H) MVI H,70H
693CH  (C3H) JMP 6953H

693FH  (EBH) XCHG
6940H  (DFH) RST 3          ; Compare DE and HL
6941H  (D2H) JNC 694DH
6944H  (EBH) XCHG
6945H  (2AH) LHLD F6E4H
6948H  (EBH) XCHG
6949H  (DFH) RST 3          ; Compare DE and HL
694AH  (D2H) JNC 6936H
694DH  (0AH) LDAX B
694EH  (A7H) ANA A
694FH  (C8H) RZ
6950H  (AFH) XRA A
6951H  (26H) MVI H,71H
6953H  (E5H) PUSH H
6954H  (02H) STAX B
6955H  (3EH) MVI A,1BH
6957H  (CDH) CALL 68D0H
695AH  (F1H) POP PSW
695BH  (C3H) JMP 68D0H

695EH  (47H) MOV B,A
695FH  (3AH) LDA F921H
6962H  (A7H) ANA A
6963H  (78H) MOV A,B
6964H  (C8H) RZ
6965H  (21H) LXI H,6977H
6968H  (06H) MVI B,0AH
696AH  (BEH) CMP M
696BH  (C8H) RZ
696CH  (23H) INX H
696DH  (05H) DCR B
696EH  (C2H) JNZ 696AH
6971H  (FEH) CPI 21H
6973H  (04H) INR B
6974H  (D0H) RNC
6975H  (05H) DCR B
6976H  (C9H) RET

6977H  (28H) LDEH 29H
6979H  (3CH) INR A
697AH  (3EH) MVI A,5BH
697CH  (5DH) MOV E,L
697DH  (2BH) DCX H
697EH  (2DH) DCR L
697FH  (2AH) LHLD CD2FH
6982H  (CDH) CALL A763H
6985H  (1FH) RAR
6986H  (CDH) CALL 6B39H
6989H  (22H) SHLD F6EBH     ; Storage of TEXT Line Starts
698CH  (CDH) CALL 63CDH
698FH  (87H) ADD A
6990H  (21H) LXI H,F6EDH
6993H  (36H) MVI M,FEH
6995H  (23H) INX H
6996H  (3DH) DCR A
6997H  (C2H) JNZ 6993H
699AH  (3CH) INR A
699BH  (C3H) JMP 69CBH

699EH  (F5H) PUSH PSW
699FH  (2AH) LHLD F6E9H     ; Address of 1st byte on last line of TEXT
69A2H  (7CH) MOV A,H
69A3H  (B5H) ORA L
69A4H  (CAH) JZ 69CAH
69A7H  (EBH) XCHG
69A8H  (CDH) CALL 67DFH
69ABH  (F1H) POP PSW
69ACH  (47H) MOV B,A
69ADH  (CDH) CALL 6A27H
69B0H  (78H) MOV A,B
69B1H  (F5H) PUSH PSW
69B2H  (CAH) JZ 69CAH
69B5H  (3DH) DCR A
69B6H  (CAH) JZ 69CAH
69B9H  (6FH) MOV L,A
69BAH  (26H) MVI H,01H
69BCH  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
69BFH  (CDH) CALL 6A10H
69C2H  (7AH) MOV A,D
69C3H  (A3H) ANA E
69C4H  (3CH) INR A
69C5H  (C1H) POP B
69C6H  (CAH) JZ 425DH       ; Erase from cursor to end of line
69C9H  (C5H) PUSH B
69CAH  (F1H) POP PSW
69CBH  (6FH) MOV L,A
69CCH  (26H) MVI H,01H
69CEH  (CDH) CALL 427CH     ; Set the current cursor position (H=Row,L=Col)
69D1H  (CDH) CALL 6A45H
69D4H  (7BH) MOV A,E
69D5H  (A2H) ANA D
69D6H  (3CH) INR A
69D7H  (CAH) JZ 6A04H
69DAH  (CDH) CALL 6A45H
69DDH  (CDH) CALL 63DBH
69E0H  (BDH) CMP L
69E1H  (CAH) JZ 69F4H
69E4H  (CDH) CALL 6A0DH
69E7H  (7AH) MOV A,D
69E8H  (A3H) ANA E
69E9H  (3CH) INR A
69EAH  (CAH) JZ 69FEH
69EDH  (CDH) CALL 6A2EH
69F0H  (C2H) JNZ 69DDH
69F3H  (C9H) RET

69F4H  (CDH) CALL 6A0DH
69F7H  (CDH) CALL 63CDH
69FAH  (3CH) INR A
69FBH  (C3H) JMP 6A27H

69FEH  (CDH) CALL 6A2EH
6A01H  (CAH) JZ 69F7H
6A04H  (CDH) CALL 425DH     ; Erase from cursor to end of line
6A07H  (CDH) CALL 4222H     ; Send CRLF to screen or printer
6A0AH  (C3H) JMP 69FEH

6A0DH  (CDH) CALL 67DFH
6A10H  (D5H) PUSH D
6A11H  (2AH) LHLD F892H
6A14H  (11H) LXI D,F894H
6A17H  (1AH) LDAX D
6A18H  (E7H) RST 4          ; Send character in A to screen/printer
6A19H  (13H) INX D
6A1AH  (DFH) RST 3          ; Compare DE and HL
6A1BH  (C2H) JNZ 6A17H
6A1EH  (3AH) LDA F920H
6A21H  (A7H) ANA A
6A22H  (CCH) CZ 426EH       ; Cancel inverse character mode
6A25H  (D1H) POP D
6A26H  (C9H) RET

6A27H  (D5H) PUSH D
6A28H  (CDH) CALL 6A48H
6A2BH  (C3H) JMP 6A32H

6A2EH  (D5H) PUSH D
6A2FH  (CDH) CALL 6A45H
6A32H  (4FH) MOV C,A
6A33H  (E3H) XTHL
6A34H  (DFH) RST 3          ; Compare DE and HL
6A35H  (79H) MOV A,C
6A36H  (EBH) XCHG
6A37H  (E1H) POP H
6A38H  (C8H) RZ
6A39H  (73H) MOV M,E
6A3AH  (23H) INX H
6A3BH  (72H) MOV M,D
6A3CH  (79H) MOV A,C
6A3DH  (C9H) RET

6A3EH  (CDH) CALL 63CDH
6A41H  (3CH) INR A
6A42H  (C3H) JMP 6A48H

6A45H  (3AH) LDA F639H      ; Cursor row (1-8)
6A48H  (5FH) MOV E,A
6A49H  (16H) MVI D,00H
6A4BH  (21H) LXI H,F6E9H    ; Address of 1st byte on last line of TEXT
6A4EH  (19H) DAD D
6A4FH  (19H) DAD D
6A50H  (5EH) MOV E,M
6A51H  (23H) INX H
6A52H  (56H) MOV D,M
6A53H  (2BH) DCX H
6A54H  (C9H) RET

6A55H  (CDH) CALL 6A45H
6A58H  (3DH) DCR A
6A59H  (CAH) JZ 6A61H
6A5CH  (2BH) DCX H
6A5DH  (56H) MOV D,M
6A5EH  (2BH) DCX H
6A5FH  (5EH) MOV E,M
6A60H  (C9H) RET

6A61H  (2AH) LHLD F767H
6A64H  (DFH) RST 3          ; Compare DE and HL
6A65H  (DAH) JC 6A6CH
6A68H  (11H) LXI D,0000H
6A6BH  (C9H) RET

6A6CH  (D5H) PUSH D
6A6DH  (1BH) DCX D
6A6EH  (DFH) RST 3          ; Compare DE and HL
6A6FH  (D2H) JNC 6A8AH
6A72H  (1BH) DCX D
6A73H  (DFH) RST 3          ; Compare DE and HL
6A74H  (D2H) JNC 6A8AH
6A77H  (1AH) LDAX D
6A78H  (FEH) CPI 0AH
6A7AH  (C2H) JNZ 6A72H
6A7DH  (1BH) DCX D
6A7EH  (DFH) RST 3          ; Compare DE and HL
6A7FH  (D2H) JNC 6A8AH
6A82H  (1AH) LDAX D
6A83H  (13H) INX D
6A84H  (FEH) CPI 0DH
6A86H  (C2H) JNZ 6A72H
6A89H  (13H) INX D
6A8AH  (D5H) PUSH D
6A8BH  (CDH) CALL 67DFH
6A8EH  (C1H) POP B
6A8FH  (EBH) XCHG
6A90H  (D1H) POP D
6A91H  (D5H) PUSH D
6A92H  (DFH) RST 3          ; Compare DE and HL
6A93H  (EBH) XCHG
6A94H  (DAH) JC 6A8AH
6A97H  (D1H) POP D
6A98H  (59H) MOV E,C
6A99H  (50H) MOV D,B
6A9AH  (C9H) RET

6A9BH  (CDH) CALL 6A55H
6A9EH  (EBH) XCHG
6A9FH  (22H) SHLD F6E9H     ; Address of 1st byte on last line of TEXT
6AA2H  (C9H) RET

6AA3H  (22H) SHLD F6E7H
6AA6H  (E5H) PUSH H
6AA7H  (21H) LXI H,F6EBH    ; Storage of TEXT Line Starts
6AAAH  (CDH) CALL 63CDH
6AADH  (47H) MOV B,A
6AAEH  (5EH) MOV E,M
6AAFH  (23H) INX H
6AB0H  (56H) MOV D,M
6AB1H  (23H) INX H
6AB2H  (E5H) PUSH H
6AB3H  (2AH) LHLD F6E7H
6AB6H  (DFH) RST 3          ; Compare DE and HL
6AB7H  (DAH) JC 6AC4H
6ABAH  (E1H) POP H
6ABBH  (EBH) XCHG
6ABCH  (E3H) XTHL
6ABDH  (EBH) XCHG
6ABEH  (05H) DCR B
6ABFH  (F2H) JP 6AAEH
6AC2H  (F3H) DI
6AC3H  (76H) HLT
6AC4H  (EBH) XCHG
6AC5H  (E1H) POP H
6AC6H  (E1H) POP H
6AC7H  (E5H) PUSH H
6AC8H  (21H) LXI H,F894H
6ACBH  (22H) SHLD F892H
6ACEH  (AFH) XRA A
6ACFH  (32H) STA F890H
6AD2H  (E1H) POP H
6AD3H  (2BH) DCX H
6AD4H  (23H) INX H
6AD5H  (DFH) RST 3          ; Compare DE and HL
6AD6H  (D2H) JNC 6AEEH
6AD9H  (7EH) MOV A,M
6ADAH  (CDH) CALL 68B2H
6ADDH  (7EH) MOV A,M
6ADEH  (FEH) CPI 20H
6AE0H  (D2H) JNC 6AD4H
6AE3H  (FEH) CPI 09H
6AE5H  (CAH) JZ 6AD4H
6AE8H  (CDH) CALL 68B2H
6AEBH  (C3H) JMP 6AD4H

6AEEH  (3AH) LDA F890H
6AF1H  (3CH) INR A
6AF2H  (67H) MOV H,A
6AF3H  (CDH) CALL 63CDH
6AF6H  (90H) SUB B
6AF7H  (6FH) MOV L,A
6AF8H  (C9H) RET

6AF9H  (CDH) CALL 6A45H
6AFCH  (D5H) PUSH D
6AFDH  (3CH) INR A
6AFEH  (CDH) CALL 6A48H
6B01H  (7AH) MOV A,D
6B02H  (A3H) ANA E
6B03H  (3CH) INR A
6B04H  (C2H) JNZ 6B0CH
6B07H  (2AH) LHLD FB62H
6B0AH  (EBH) XCHG
6B0BH  (13H) INX D
6B0CH  (1BH) DCX D
6B0DH  (1AH) LDAX D
6B0EH  (FEH) CPI 0AH
6B10H  (C2H) JNZ 6B1BH
6B13H  (1BH) DCX D
6B14H  (1AH) LDAX D
6B15H  (FEH) CPI 0DH
6B17H  (CAH) JZ 6B1BH
6B1AH  (13H) INX D
6B1BH  (E1H) POP H
6B1CH  (E5H) PUSH H
6B1DH  (CDH) CALL 6AC7H
6B20H  (3AH) LDA F63AH      ; Cursor column (1-40)
6B23H  (BCH) CMP H
6B24H  (DAH) JC 6B0CH
6B27H  (E1H) POP H
6B28H  (EBH) XCHG
6B29H  (C9H) RET

6B2AH  (2AH) LHLD F767H
6B2DH  (3EH) MVI A,1AH
6B2FH  (BEH) CMP M
6B30H  (23H) INX H
6B31H  (C2H) JNZ 6B2FH
6B34H  (2BH) DCX H
6B35H  (22H) SHLD FB62H
6B38H  (C9H) RET

6B39H  (F5H) PUSH PSW
6B3AH  (EBH) XCHG
6B3BH  (2AH) LHLD F767H
6B3EH  (EBH) XCHG
6B3FH  (E5H) PUSH H
6B40H  (D5H) PUSH D
6B41H  (CDH) CALL 67DFH
6B44H  (C1H) POP B
6B45H  (E1H) POP H
6B46H  (DFH) RST 3          ; Compare DE and HL
6B47H  (D2H) JNC 6B3FH
6B4AH  (60H) MOV H,B
6B4BH  (69H) MOV L,C
6B4CH  (C1H) POP B
6B4DH  (05H) DCR B
6B4EH  (C8H) RZ
6B4FH  (EBH) XCHG
6B50H  (C5H) PUSH B
6B51H  (CDH) CALL 6A61H
6B54H  (C1H) POP B
6B55H  (7AH) MOV A,D
6B56H  (B3H) ORA E
6B57H  (2AH) LHLD F767H
6B5AH  (C8H) RZ
6B5BH  (05H) DCR B
6B5CH  (C2H) JNZ 6B50H
6B5FH  (EBH) XCHG
6B60H  (C9H) RET

; ======================================================
; Insert A into text file at M
; ======================================================
6B61H  (01H) LXI B,0001H
6B64H  (F5H) PUSH PSW
6B65H  (CDH) CALL 6B6DH     ; Insert BC spaces at M
6B68H  (C1H) POP B
6B69H  (D8H) RC
6B6AH  (70H) MOV M,B
6B6BH  (23H) INX H
6B6CH  (C9H) RET

; ======================================================
; Insert BC spaces at M
; ======================================================
6B6DH  (EBH) XCHG
6B6EH  (2AH) LHLD FBB6H     ; Unused memory pointer
6B71H  (09H) DAD B
6B72H  (D8H) RC
6B73H  (3EH) MVI A,88H
6B75H  (95H) SUB L
6B76H  (6FH) MOV L,A
6B77H  (3EH) MVI A,FFH
6B79H  (9CH) SUB H
6B7AH  (67H) MOV H,A
6B7BH  (D8H) RC
6B7CH  (39H) DAD SP
6B7DH  (3FH) CMC
6B7EH  (D8H) RC
6B7FH  (C5H) PUSH B
6B80H  (CDH) CALL 6BC3H
6B83H  (2AH) LHLD FBB6H     ; Unused memory pointer
6B86H  (7DH) MOV A,L
6B87H  (93H) SUB E
6B88H  (5FH) MOV E,A
6B89H  (7CH) MOV A,H
6B8AH  (9AH) SBB D
6B8BH  (57H) MOV D,A
6B8CH  (D5H) PUSH D
6B8DH  (5DH) MOV E,L
6B8EH  (54H) MOV D,H
6B8FH  (09H) DAD B
6B90H  (22H) SHLD FBB6H     ; Unused memory pointer
6B93H  (EBH) XCHG
6B94H  (1BH) DCX D
6B95H  (2BH) DCX H
6B96H  (C1H) POP B
6B97H  (78H) MOV A,B
6B98H  (B1H) ORA C
6B99H  (C4H) CNZ 6BE6H      ; Move BC bytes from M to (DE) with decrement
6B9CH  (23H) INX H
6B9DH  (C1H) POP B
6B9EH  (C9H) RET

; ======================================================
; Delete BC characters at M
; ======================================================
6B9FH  (78H) MOV A,B
6BA0H  (B1H) ORA C
6BA1H  (C8H) RZ
6BA2H  (E5H) PUSH H
6BA3H  (C5H) PUSH B
6BA4H  (E5H) PUSH H
6BA5H  (09H) DAD B
6BA6H  (EBH) XCHG
6BA7H  (2AH) LHLD FBB6H     ; Unused memory pointer
6BAAH  (EBH) XCHG
6BABH  (7BH) MOV A,E
6BACH  (95H) SUB L
6BADH  (4FH) MOV C,A
6BAEH  (7AH) MOV A,D
6BAFH  (9CH) SUB H
6BB0H  (47H) MOV B,A
6BB1H  (D1H) POP D
6BB2H  (78H) MOV A,B
6BB3H  (B1H) ORA C
6BB4H  (C4H) CNZ 6BDBH      ; Move BC bytes from M to (DE) with increment
6BB7H  (EBH) XCHG
6BB8H  (22H) SHLD FBB6H     ; Unused memory pointer
6BBBH  (C1H) POP B
6BBCH  (AFH) XRA A
6BBDH  (91H) SUB C
6BBEH  (4FH) MOV C,A
6BBFH  (9FH) SBB A
6BC0H  (90H) SUB B
6BC1H  (47H) MOV B,A
6BC2H  (E1H) POP H
6BC3H  (E5H) PUSH H
6BC4H  (2AH) LHLD FBB0H     ; Start of CO files pointer
6BC7H  (09H) DAD B
6BC8H  (22H) SHLD FBB0H     ; Start of CO files pointer
6BCBH  (2AH) LHLD FBB2H     ; Start of variable data pointer
6BCEH  (09H) DAD B
6BCFH  (22H) SHLD FBB2H     ; Start of variable data pointer
6BD2H  (2AH) LHLD FBB4H     ; Start of array table pointer
6BD5H  (09H) DAD B
6BD6H  (22H) SHLD FBB4H     ; Start of array table pointer
6BD9H  (E1H) POP H
6BDAH  (C9H) RET

; ======================================================
; Move BC bytes from M to (DE) with increment
; ======================================================
6BDBH  (7EH) MOV A,M
6BDCH  (12H) STAX D
6BDDH  (23H) INX H
6BDEH  (13H) INX D
6BDFH  (0BH) DCX B
6BE0H  (78H) MOV A,B
6BE1H  (B1H) ORA C
6BE2H  (C2H) JNZ 6BDBH      ; Move BC bytes from M to (DE) with increment
6BE5H  (C9H) RET

; ======================================================
; Move BC bytes from M to (DE) with decrement
; ======================================================
6BE6H  (7EH) MOV A,M
6BE7H  (12H) STAX D
6BE8H  (2BH) DCX H
6BE9H  (1BH) DCX D
6BEAH  (0BH) DCX B
6BEBH  (78H) MOV A,B
6BECH  (B1H) ORA C
6BEDH  (C2H) JNZ 6BE6H      ; Move BC bytes from M to (DE) with decrement
6BF0H  (C9H) RET

; ======================================================
; ROM programs catalog entries
; ======================================================
6BF1H  DB   B0H
6BF2H  DW   6C49H
6BF4H  DB   "BASIC  ",00H
6BFCH  DB   B0H
6BFDH  DW   5DEEH
6BFFH  DB   "TEXT   ",00H
6C07H  DB   B0H
6C08H  DW   5146H
6C0AH  DB   "TELCOM ",00H
6C12H  DB   B0H
6C13H  DW   5B68H
6C15H  DB   "ADDRSS ",00H
6C1DH  DB   B0H
6C1EH  DW   5B6FH
6C20H  DB   "SCHEDL ",00H
6C28H  DB   88H
6C29H  DW   0000H
6C2BH  DB   00H,"Suzuki",20H
6C33H  DB   C8H
6C34H  DW   0000H
6C36H  DB   00H,"Hayash",69H
6C3EH  DB   48H
6C3FH  DW   0000H
6C41H  DB   00H,"RickY ",20H

; ======================================================
; BASIC Entry point
; ======================================================
6C49H  (CDH) CALL 6C7FH
6C4CH  (CDH) CALL 7EA6H     ; Display TRS-80 Model number & Free bytes on LCD
6C4FH  (21H) LXI H,F999H
6C52H  (22H) SHLD FA8CH
6C55H  (2AH) LHLD F99AH     ; BASIC program not saved pointer
6C58H  (22H) SHLD F67CH     ; Start of BASIC program pointer
6C5BH  (CDH) CALL 6C9CH     ; Copy BASIC Function key table to key definition area
6C5EH  (CDH) CALL 5A9EH     ; Display function keys on 8th line
6C61H  (AFH) XRA A
6C62H  (32H) STA F650H
6C65H  (3CH) INR A
6C66H  (32H) STA FAADH      ; Label line enable flag
6C69H  (21H) LXI H,6C78H    ; Load pointer to "llist" text
6C6CH  (22H) SHLD F88AH     ; Save as key sequence for SHIFT-PRINT key
6C6FH  (CDH) CALL 05F0H     ; Update line addresses for current BASIC program
6C72H  (CDH) CALL 3F28H     ; Initialize BASIC Variables for new execution
6C75H  (C3H) JMP 0502H      ; Vector to BASIC ready - print Ok

6C78H  DB   "llist",0DH,00H

6C7FH  (2AH) LHLD FBB2H     ; Start of variable data pointer
6C82H  (01H) LXI B,0178H
6C85H  (09H) DAD B
6C86H  (EBH) XCHG
6C87H  (2AH) LHLD FB67H     ; File buffer area pointer
6C8AH  (DFH) RST 3          ; Compare DE and HL
6C8BH  (DAH) JC 6C8FH
6C8EH  (25H) DCR H
6C8FH  (22H) SHLD F678H     ; BASIC string buffer pointer
6C92H  (C9H) RET

; ======================================================
; Copy BASIC Function key table to key definition area
; ======================================================
6C93H  (21H) LXI H,F789H    ; Function key definition area
6C96H  (11H) LXI D,F80AH    ; Function key definition area (BASIC)
6C99H  (C3H) JMP 6CA2H

; ======================================================
; Copy BASIC Function key table to key definition area
; ======================================================
6C9CH  (21H) LXI H,F80AH    ; Function key definition area (BASIC)
6C9FH  (11H) LXI D,F789H    ; Function key definition area
6CA2H  (06H) MVI B,80H
6CA4H  (C3H) JMP 2542H      ; Move B bytes from M to (DE)

6CA7H  (2BH) DCX H
6CA8H  (D7H) RST 2          ; Get next non-white char from M
6CA9H  (1AH) LDAX D
6CAAH  (3CH) INR A
6CABH  (C8H) RZ
6CACH  (E5H) PUSH H
6CADH  (06H) MVI B,04H
6CAFH  (1AH) LDAX D
6CB0H  (4FH) MOV C,A
6CB1H  (CDH) CALL 0FE8H     ; Get char at M and convert to uppercase
6CB4H  (B9H) CMP C
6CB5H  (13H) INX D
6CB6H  (23H) INX H
6CB7H  (C2H) JNZ 6CCCH
6CBAH  (05H) DCR B
6CBBH  (C2H) JNZ 6CAFH
6CBEH  (F1H) POP PSW
6CBFH  (E5H) PUSH H
6CC0H  (EBH) XCHG
6CC1H  (5EH) MOV E,M
6CC2H  (23H) INX H
6CC3H  (56H) MOV D,M
6CC4H  (EBH) XCHG
6CC5H  (D1H) POP D
6CC6H  (E3H) XTHL
6CC7H  (E5H) PUSH H
6CC8H  (EBH) XCHG
6CC9H  (24H) INR H
6CCAH  (25H) DCR H
6CCBH  (C9H) RET

6CCCH  (13H) INX D
6CCDH  (05H) DCR B
6CCEH  (C2H) JNZ 6CCCH
6CD1H  (13H) INX D
6CD2H  (E1H) POP H
6CD3H  (C3H) JMP 6CA9H

; ======================================================
; Re-initialize system without destroying files
; ======================================================
6CD6H  (F3H) DI
6CD7H  (21H) LXI H,FF40H    ; XON/XOFF protocol control
6CDAH  (06H) MVI B,BDH
6CDCH  (CDH) CALL 4F0AH     ; Zero B bytes at M
6CDFH  (3CH) INR A

; ======================================================
; Warm start reset entry
; ======================================================
6CE0H  (F5H) PUSH PSW
6CE1H  (F3H) DI
6CE2H  (3EH) MVI A,19H
6CE4H  (30H) SIM
6CE5H  (DBH) IN C8H
6CE7H  (3EH) MVI A,43H
6CE9H  (D3H) OUT B8H
6CEBH  (3EH) MVI A,05H
6CEDH  (CDH) CALL 7383H     ; Set clock chip mode
6CF0H  (3EH) MVI A,EDH
6CF2H  (D3H) OUT BAH
6CF4H  (AFH) XRA A
6CF5H  (32H) STA FF45H      ; Contents of port E8H
6CF8H  (D3H) OUT E8H
6CFAH  (D3H) OUT A8H
6CFCH  (CDH) CALL 7682H     ; Check for optional external controller
6CFFH  (CDH) CALL 7533H     ; Enable LCD drivers after short delay
6D02H  (AFH) XRA A
6D03H  (D3H) OUT FEH
6D05H  (CDH) CALL 7533H     ; Enable LCD drivers after short delay
6D08H  (3EH) MVI A,3BH
6D0AH  (D3H) OUT FEH
6D0CH  (CDH) CALL 752BH     ; Set the display top line to zero for all LCD controllers
6D0FH  (CDH) CALL 7533H     ; Enable LCD drivers after short delay
6D12H  (3EH) MVI A,39H
6D14H  (D3H) OUT FEH
6D16H  (FBH) EI
6D17H  (CDH) CALL 76A0H     ; Call routine to test if DVI data available
6D1AH  (D2H) JNC 6D1EH      ; Jump if data available from DVI
6D1DH  (AFH) XRA A          ; Indicate no DVI present 
6D1EH  (32H) STA FC81H      ; Store flag indicating DVI present??
6D21H  (B7H) ORA A          ; Test if DVI present?
6D22H  (CAH) JZ 6D3DH       ; Branch to exit Warm Start if no DVI
6D25H  (3AH) LDA FFFCH	    ; Load DVI Disk BASIC code initializer value
6D28H  (B7H) ORA A          ; Test if DVI Disk BASIC already loaded
6D29H  (C2H) JNZ 6D3DH      ; Jump if already loaded
6D2CH  (F1H) POP PSW
6D2DH  (C8H) RZ
6D2EH  (2AH) LHLD FBB2H     ; Start of variable data pointer
6D31H  (11H) LXI D,E000H
6D34H  (DFH) RST 3          ; Compare DE and HL
6D35H  (D0H) RNC
6D36H  (CDH) CALL 76B6H
6D39H  (F5H) PUSH PSW
6D3AH  (DAH) JC 6D1DH
6D3DH  (F1H) POP PSW
6D3EH  (C9H) RET

; ======================================================
; Send character in A to the printer
; ======================================================
6D3FH  (C5H) PUSH B
6D40H  (4FH) MOV C,A
6D41H  (CDH) CALL 729FH     ; Check if SHIFT-BREAK is being pressed
6D44H  (DAH) JC 6D6AH
6D47H  (DBH) IN BBH
6D49H  (E6H) ANI 06H
6D4BH  (EEH) XRI 02H
6D4DH  (C2H) JNZ 6D41H
6D50H  (CDH) CALL 765CH     ; Disable Background task & barcode interrupts
6D53H  (79H) MOV A,C
6D54H  (D3H) OUT B9H
6D56H  (3AH) LDA FF45H      ; Contents of port E8H
6D59H  (47H) MOV B,A
6D5AH  (F6H) ORI 02H
6D5CH  (D3H) OUT E8H
6D5EH  (78H) MOV A,B
6D5FH  (D3H) OUT E8H
6D61H  (06H) MVI B,24H
6D63H  (05H) DCR B
6D64H  (C2H) JNZ 6D63H
6D67H  (3EH) MVI A,09H
6D69H  (30H) SIM
6D6AH  (79H) MOV A,C
6D6BH  (C1H) POP B
6D6CH  (C9H) RET

; ======================================================
; Check RS232 queue for pending characters
; ======================================================
6D6DH  (3AH) LDA FF42H      ; XON/XOFF enable flag
6D70H  (B7H) ORA A
6D71H  (CAH) JZ 6D79H
6D74H  (3AH) LDA FF41H      ; XON/XOFF protocol control
6D77H  (3CH) INR A
6D78H  (C8H) RZ
6D79H  (3AH) LDA FF86H      ; RS232 buffer count
6D7CH  (B7H) ORA A
6D7DH  (C9H) RET

; ======================================================
; Get a character from RS232 receive queue
; ======================================================
6D7EH  (E5H) PUSH H
6D7FH  (D5H) PUSH D
6D80H  (C5H) PUSH B
6D81H  (21H) LXI H,71F8H    ; Interrupt exit routine (pop all regs & RET)
6D84H  (E5H) PUSH H
6D85H  (21H) LXI H,FF86H    ; RS232 buffer count
6D88H  (CDH) CALL 729FH     ; Check if SHIFT-BREAK is being pressed
6D8BH  (D8H) RC
6D8CH  (CDH) CALL 6D6DH     ; Check RS232 queue for pending characters
6D8FH  (CAH) JZ 6D88H
6D92H  (FEH) CPI 03H
6D94H  (DCH) CC 6E0BH       ; Send XON (CTRL-Q) out RS232
6D97H  (F3H) DI
6D98H  (35H) DCR M
6D99H  (CDH) CALL 6DFCH     ; Calculate address to save next RS232 character
6D9CH  (7EH) MOV A,M
6D9DH  (EBH) XCHG
6D9EH  (23H) INX H
6D9FH  (23H) INX H
6DA0H  (34H) INR M
6DA1H  (35H) DCR M
6DA2H  (C8H) RZ
6DA3H  (35H) DCR M
6DA4H  (CAH) JZ 6DA9H
6DA7H  (BFH) CMP A
6DA8H  (C9H) RET

6DA9H  (F6H) ORI FFH
6DABH  (C9H) RET

; ======================================================
; RST 6.5 routine (RS232 receive interrupt)
; ======================================================
6DACH  (CDH) CALL F5FCH     ; RST 6.5 RAM Vector
6DAFH  (E5H) PUSH H
6DB0H  (D5H) PUSH D
6DB1H  (C5H) PUSH B
6DB2H  (F5H) PUSH PSW
6DB3H  (21H) LXI H,71F7H    ; Interrupt exit routine (pop all regs & RET)
6DB6H  (E5H) PUSH H
6DB7H  (DBH) IN C8H
6DB9H  (21H) LXI H,FF8DH    ; RS232 Parity Control byte
6DBCH  (A6H) ANA M
6DBDH  (4FH) MOV C,A
6DBEH  (DBH) IN D8H
6DC0H  (E6H) ANI 0EH
6DC2H  (47H) MOV B,A
6DC3H  (C2H) JNZ 6DDBH
6DC6H  (79H) MOV A,C
6DC7H  (FEH) CPI 11H
6DC9H  (CAH) JZ 6DD2H
6DCCH  (FEH) CPI 13H
6DCEH  (C2H) JNZ 6DDBH
6DD1H  (3EH) MVI A,AFH
6DD3H  (32H) STA FF40H      ; XON/XOFF protocol control
6DD6H  (3AH) LDA FF42H      ; XON/XOFF enable flag
6DD9H  (B7H) ORA A
6DDAH  (C0H) RNZ
6DDBH  (21H) LXI H,FF86H    ; RS232 buffer count
6DDEH  (7EH) MOV A,M
6DDFH  (FEH) CPI 40H
6DE1H  (C8H) RZ
6DE2H  (FEH) CPI 28H
6DE4H  (D4H) CNC 6E1EH      ; Turn off XON/XOFF protocol
6DE7H  (C5H) PUSH B
6DE8H  (34H) INR M
6DE9H  (23H) INX H
6DEAH  (CDH) CALL 6DFCH     ; Calculate address to save next RS232 character
6DEDH  (C1H) POP B
6DEEH  (71H) MOV M,C
6DEFH  (78H) MOV A,B
6DF0H  (B7H) ORA A
6DF1H  (C8H) RZ
6DF2H  (EBH) XCHG
6DF3H  (23H) INX H
6DF4H  (35H) DCR M
6DF5H  (34H) INR M
6DF6H  (C0H) RNZ
6DF7H  (3AH) LDA FF86H      ; RS232 buffer count
6DFAH  (77H) MOV M,A
6DFBH  (C9H) RET

; ======================================================
; Calculate address to save next RS232 character
; ======================================================
6DFCH  (23H) INX H
6DFDH  (4EH) MOV C,M
6DFEH  (79H) MOV A,C
6DFFH  (3CH) INR A
6E00H  (E6H) ANI 3FH
6E02H  (77H) MOV M,A
6E03H  (EBH) XCHG
6E04H  (21H) LXI H,FF46H    ; RS232 Character buffer
6E07H  (06H) MVI B,00H
6E09H  (09H) DAD B
6E0AH  (C9H) RET

; ======================================================
; Send XON (CTRL-Q) out RS232
; ======================================================
6E0BH  (3AH) LDA FF42H      ; XON/XOFF enable flag
6E0EH  (A7H) ANA A
6E0FH  (C8H) RZ
6E10H  (3AH) LDA FF8AH      ; Control-S status
6E13H  (3DH) DCR A
6E14H  (C0H) RNZ
6E15H  (32H) STA FF8AH      ; Control-S status
6E18H  (C5H) PUSH B
6E19H  (0EH) MVI C,11H
6E1BH  (C3H) JMP 6E3AH      ; Send character in C to serial port

; ======================================================
; Turn off XON/XOFF protocol
; ======================================================
6E1EH  (3AH) LDA FF42H      ; XON/XOFF enable flag
6E21H  (A7H) ANA A
6E22H  (C8H) RZ
6E23H  (3AH) LDA FF8AH      ; Control-S status
6E26H  (B7H) ORA A
6E27H  (C0H) RNZ
6E28H  (3CH) INR A
6E29H  (32H) STA FF8AH      ; Control-S status
6E2CH  (C5H) PUSH B
6E2DH  (0EH) MVI C,13H
6E2FH  (C3H) JMP 6E3AH      ; Send character in C to serial port

; ======================================================
; Send character in A to serial port using XON/XOFF
; ======================================================
6E32H  (C5H) PUSH B
6E33H  (4FH) MOV C,A
6E34H  (CDH) CALL 6E4DH     ; Handle XON/XOFF protocol
6E37H  (DAH) JC 6E4AH

; ======================================================
; Send character in C to serial port
; ======================================================
6E3AH  (CDH) CALL 729FH     ; Check if SHIFT-BREAK is being pressed
6E3DH  (DAH) JC 6E4AH
6E40H  (DBH) IN D8H
6E42H  (E6H) ANI 10H
6E44H  (CAH) JZ 6E3AH       ; Send character in C to serial port
6E47H  (79H) MOV A,C
6E48H  (D3H) OUT C8H
6E4AH  (79H) MOV A,C
6E4BH  (C1H) POP B
6E4CH  (C9H) RET

; ======================================================
; Handle XON/XOFF protocol
; ======================================================
6E4DH  (3AH) LDA FF42H      ; XON/XOFF enable flag
6E50H  (B7H) ORA A
6E51H  (C8H) RZ
6E52H  (79H) MOV A,C
6E53H  (FEH) CPI 11H
6E55H  (C2H) JNZ 6E5FH
6E58H  (AFH) XRA A
6E59H  (32H) STA FF8AH      ; Control-S status
6E5CH  (C3H) JMP 6E65H

6E5FH  (D6H) SUI 13H
6E61H  (C2H) JNZ 6E69H
6E64H  (3DH) DCR A
6E65H  (32H) STA FF41H      ; XON/XOFF protocol control
6E68H  (C9H) RET

6E69H  (CDH) CALL 729FH     ; Check if SHIFT-BREAK is being pressed
6E6CH  (D8H) RC
6E6DH  (3AH) LDA FF40H      ; XON/XOFF protocol control
6E70H  (B7H) ORA A
6E71H  (C2H) JNZ 6E69H
6E74H  (C9H) RET

; ======================================================
; Set RS232 baud rate stored in H
; ======================================================
6E75H  (E5H) PUSH H
6E76H  (7CH) MOV A,H
6E77H  (07H) RLC
6E78H  (21H) LXI H,6E92H
6E7BH  (16H) MVI D,00H
6E7DH  (5FH) MOV E,A
6E7EH  (19H) DAD D
6E7FH  (22H) SHLD FF8BH     ; UART baud rate timer value
6E82H  (E1H) POP H
6E83H  (E5H) PUSH H
6E84H  (2AH) LHLD FF8BH     ; UART baud rate timer value
6E87H  (7EH) MOV A,M
6E88H  (D3H) OUT BCH
6E8AH  (23H) INX H
6E8BH  (7EH) MOV A,M
6E8CH  (D3H) OUT BDH
6E8EH  (3EH) MVI A,C3H
6E90H  (D3H) OUT B8H
6E92H  (E1H) POP H
6E93H  (C9H) RET

; ======================================================
; RS232 baud rate timer values
; ======================================================
6E94H  DW   4800H,456BH,4200H,4100H
6E9CH  DW   4080H,4040H,4020H,4010H
6EA4H  DW   4008H

; ======================================================
; Initialize RS232 or modem
; ======================================================
6EA6H  (E5H) PUSH H
6EA7H  (D5H) PUSH D
6EA8H  (C5H) PUSH B
6EA9H  (F5H) PUSH PSW
6EAAH  (06H) MVI B,25H
6EACH  (DAH) JC 6EB3H
6EAFH  (26H) MVI H,03H
6EB1H  (06H) MVI B,2DH
6EB3H  (F3H) DI
6EB4H  (CDH) CALL 6E75H     ; Set RS232 baud rate stored in H
6EB7H  (78H) MOV A,B
6EB8H  (D3H) OUT BAH
6EBAH  (DBH) IN D8H
6EBCH  (7DH) MOV A,L
6EBDH  (E6H) ANI 1FH
6EBFH  (D3H) OUT D8H
6EC1H  (CDH) CALL 6F39H     ; Initialize serial buffer parameters
6EC4H  (3DH) DCR A
6EC5H  (32H) STA FF43H      ; RS232 initialization status
6EC8H  (C3H) JMP 71F7H      ; Interrupt exit routine (pop all regs & RET)

; ======================================================
; Deactivate RS232 or modem
; ======================================================
6ECBH  (DBH) IN BAH
6ECDH  (F6H) ORI C0H
6ECFH  (D3H) OUT BAH
6ED1H  (AFH) XRA A
6ED2H  (32H) STA FF43H      ; RS232 initialization status
6ED5H  (C9H) RET

6ED6H  (1EH) MVI E,00H
6ED8H  (DBH) IN D8H
6EDAH  (E6H) ANI 01H
6EDCH  (AAH) XRA D
6EDDH  (C2H) JNZ 6EE5H      ; Click sound port if sound enabled
6EE0H  (1CH) INR E
6EE1H  (F2H) JP 6ED8H
6EE4H  (C9H) RET

; ======================================================
; Click sound port if sound enabled
; ======================================================
6EE5H  (F5H) PUSH PSW
6EE6H  (3AH) LDA FF44H      ; Sound flag
6EE9H  (B7H) ORA A
6EEAH  (CCH) CZ 7676H       ; Click sound port
6EEDH  (F1H) POP PSW
6EEEH  (C9H) RET

; ======================================================
; Check for carrier detect
; ======================================================
6EEFH  (E5H) PUSH H
6EF0H  (D5H) PUSH D
6EF1H  (C5H) PUSH B
6EF2H  (21H) LXI H,6F2CH
6EF5H  (E5H) PUSH H
6EF6H  (DBH) IN BBH
6EF8H  (E6H) ANI 10H
6EFAH  (21H) LXI H,0249H
6EFDH  (01H) LXI B,1A0EH
6F00H  (C2H) JNZ 6F09H
6F03H  (21H) LXI H,0427H
6F06H  (01H) LXI B,0C07H
6F09H  (F3H) DI
6F0AH  (DBH) IN D8H
6F0CH  (E6H) ANI 01H
6F0EH  (57H) MOV D,A
6F0FH  (CDH) CALL 6ED6H
6F12H  (FAH) JM 6F1AH
6F15H  (AAH) XRA D
6F16H  (57H) MOV D,A
6F17H  (CDH) CALL 6ED6H
6F1AH  (FBH) EI
6F1BH  (F8H) RM
6F1CH  (7BH) MOV A,E
6F1DH  (B8H) CMP B
6F1EH  (D0H) RNC
6F1FH  (B9H) CMP C
6F20H  (D8H) RC
6F21H  (2BH) DCX H
6F22H  (7CH) MOV A,H
6F23H  (B5H) ORA L
6F24H  (C2H) JNZ 6F09H
6F27H  (CDH) CALL 6F39H     ; Initialize serial buffer parameters
6F2AH  (E1H) POP H
6F2BH  (C2H) JNZ FFF6H
6F2EH  (C3H) JMP 14EEH      ; POP BC, DE, HL from stack

; ======================================================
; Enable XON/OFF when CTRL-S / CTRL-Q sent
; ======================================================
6F31H  (3EH) MVI A,AFH
6F33H  (F3H) DI
6F34H  (32H) STA FF42H      ; XON/XOFF enable flag
6F37H  (FBH) EI
6F38H  (C9H) RET

; ======================================================
; Initialize serial buffer parameters
; ======================================================
6F39H  (AFH) XRA A
6F3AH  (6FH) MOV L,A
6F3BH  (67H) MOV H,A
6F3CH  (22H) SHLD FF40H     ; XON/XOFF protocol control
6F3FH  (22H) SHLD FF86H     ; RS232 buffer count
6F42H  (22H) SHLD FF88H     ; RS232 buffer input pointer
6F45H  (C9H) RET

; ======================================================
; Write cassette header and sync byte
; ======================================================
6F46H  (01H) LXI B,0200H
6F49H  (3EH) MVI A,55H
6F4BH  (C5H) PUSH B
6F4CH  (CDH) CALL 6F5EH
6F4FH  (C1H) POP B
6F50H  (0BH) DCX B
6F51H  (78H) MOV A,B
6F52H  (B1H) ORA C
6F53H  (C2H) JNZ 6F49H
6F56H  (3EH) MVI A,7FH
6F58H  (C3H) JMP 6F5EH

; ======================================================
; Write char in A to cassette w/o checksum
; ======================================================
6F5BH  (CDH) CALL 6F71H
6F5EH  (06H) MVI B,08H
6F60H  (CDH) CALL 6F6AH     ; Write bit 0 of A to cassette
6F63H  (05H) DCR B
6F64H  (C2H) JNZ 6F60H
6F67H  (C3H) JMP 729FH      ; Check if SHIFT-BREAK is being pressed

; ======================================================
; Write bit 0 of A to cassette
; ======================================================
6F6AH  (07H) RLC
6F6BH  (11H) LXI D,1F24H    ; Cassette frequency cycle count
6F6EH  (DAH) JC 6F74H
6F71H  (11H) LXI D,4349H    ; Cassette frequency cycle count
6F74H  (15H) DCR D
6F75H  (C2H) JNZ 6F74H
6F78H  (57H) MOV D,A
6F79H  (3EH) MVI A,D0H
6F7BH  (30H) SIM
6F7CH  (1DH) DCR E
6F7DH  (C2H) JNZ 6F7CH
6F80H  (3EH) MVI A,50H
6F82H  (30H) SIM
6F83H  (7AH) MOV A,D
6F84H  (C9H) RET

; ======================================================
; Read cassette header and sync byte
; ======================================================
6F85H  (06H) MVI B,80H
6F87H  (CDH) CALL 6FDBH     ; Read Cassette port data bit
6F8AH  (D8H) RC
6F8BH  (79H) MOV A,C
6F8CH  (FEH) CPI 08H
6F8EH  (DAH) JC 6F85H       ; Read cassette header and sync byte
6F91H  (FEH) CPI 40H
6F93H  (D2H) JNC 6F85H      ; Read cassette header and sync byte
6F96H  (05H) DCR B
6F97H  (C2H) JNZ 6F87H
6F9AH  (CDH) CALL 729FH     ; Check if SHIFT-BREAK is being pressed
6F9DH  (D8H) RC
6F9EH  (21H) LXI H,0000H
6FA1H  (06H) MVI B,40H
6FA3H  (CDH) CALL 7016H
6FA6H  (D8H) RC
6FA7H  (51H) MOV D,C
6FA8H  (CDH) CALL 7016H
6FABH  (D8H) RC
6FACH  (7AH) MOV A,D
6FADH  (91H) SUB C
6FAEH  (D2H) JNC 6FB3H
6FB1H  (2FH) CMA
6FB2H  (3CH) INR A
6FB3H  (FEH) CPI 0BH
6FB5H  (DAH) JC 6FBAH
6FB8H  (24H) INR H
6FB9H  (3EH) MVI A,2CH
6FBBH  (05H) DCR B
6FBCH  (C2H) JNZ 6FA3H
6FBFH  (3EH) MVI A,40H
6FC1H  (BDH) CMP L
6FC2H  (CAH) JZ 6FC9H
6FC5H  (94H) SUB H
6FC6H  (C2H) JNZ 6F9AH
6FC9H  (32H) STA FF8EH      ; Cassette port pulse control
6FCCH  (16H) MVI D,00H
6FCEH  (CDH) CALL 6FDBH     ; Read Cassette port data bit
6FD1H  (D8H) RC
6FD2H  (CDH) CALL 7023H     ; Count and pack cassette input bits
6FD5H  (FEH) CPI 7FH
6FD7H  (C2H) JNZ 6FCEH
6FDAH  (C9H) RET

; ======================================================
; Read Cassette port data bit
; ======================================================
6FDBH  (0EH) MVI C,00H
6FDDH  (3AH) LDA FF8EH      ; Cassette port pulse control
6FE0H  (A7H) ANA A
6FE1H  (CAH) JZ 6FFAH
6FE4H  (CDH) CALL 729FH     ; Check if SHIFT-BREAK is being pressed
6FE7H  (D8H) RC
6FE8H  (20H) RIM
6FE9H  (07H) RLC
6FEAH  (D2H) JNC 6FE4H
6FEDH  (0CH) INR C
6FEEH  (0CH) INR C
6FEFH  (CAH) JZ 6FE4H
6FF2H  (20H) RIM
6FF3H  (07H) RLC
6FF4H  (DAH) JC 6FEEH
6FF7H  (C3H) JMP 700DH

6FFAH  (CDH) CALL 729FH     ; Check if SHIFT-BREAK is being pressed
6FFDH  (D8H) RC
6FFEH  (20H) RIM
6FFFH  (07H) RLC
7000H  (DAH) JC 6FFAH
7003H  (0CH) INR C
7004H  (0CH) INR C
7005H  (CAH) JZ 6FFAH
7008H  (20H) RIM
7009H  (07H) RLC
700AH  (D2H) JNC 7004H
700DH  (3AH) LDA FF44H      ; Sound flag
7010H  (A7H) ANA A
7011H  (CCH) CZ 7676H       ; Click sound port
7014H  (AFH) XRA A
7015H  (C9H) RET

7016H  (CDH) CALL 7003H
7019H  (D8H) RC
701AH  (0EH) MVI C,00H
701CH  (CDH) CALL 6FEDH
701FH  (D8H) RC
7020H  (C3H) JMP 7003H

; ======================================================
; Count and pack cassette input bits
; ======================================================
7023H  (79H) MOV A,C
7024H  (FEH) CPI 15H
7026H  (7AH) MOV A,D
7027H  (17H) RAL
7028H  (57H) MOV D,A
7029H  (C9H) RET

; ======================================================
; Read character from cassette w/o checksum
; ======================================================
702AH  (CDH) CALL 6FDBH     ; Read Cassette port data bit
702DH  (D8H) RC
702EH  (79H) MOV A,C
702FH  (FEH) CPI 15H
7031H  (DAH) JC 702AH       ; Read character from cassette w/o checksum
7034H  (06H) MVI B,08H
7036H  (CDH) CALL 6FDBH     ; Read Cassette port data bit
7039H  (D8H) RC
703AH  (CDH) CALL 7023H     ; Count and pack cassette input bits
703DH  (05H) DCR B
703EH  (C2H) JNZ 7036H
7041H  (AFH) XRA A
7042H  (C9H) RET

; ======================================================
; Cassette REMOTE routine - turn motor on or off
; ======================================================
7043H  (3AH) LDA FF45H      ; Contents of port E8H
7046H  (E6H) ANI F1H
7048H  (1CH) INR E
7049H  (1DH) DCR E
704AH  (CAH) JZ 704FH
704DH  (F6H) ORI 08H
704FH  (D3H) OUT E8H
7051H  (32H) STA FF45H      ; Contents of port E8H
7054H  (C9H) RET

; ======================================================
; Keyboard scanning management routine
; ======================================================
7055H  (21H) LXI H,71F4H
7058H  (E5H) PUSH H
7059H  (21H) LXI H,FF8FH
705CH  (35H) DCR M
705DH  (C0H) RNZ
705EH  (36H) MVI M,03H

; ======================================================
; Key detection -- Determine which keys are pressed
; ======================================================
7060H  (21H) LXI H,FF99H    ; Keyboard scan column storage #1
7063H  (11H) LXI D,FFA2H    ; Keyboard scan column storage @2
7066H  (CDH) CALL 72B1H     ; Scan BREAK,CAPS,NUM,CODE,GRAPH,CTRL,SHIFT & set bits in A
7069H  (2FH) CMA
706AH  (BEH) CMP M
706BH  (77H) MOV M,A
706CH  (CCH) CZ 7101H
706FH  (AFH) XRA A
7070H  (D3H) OUT B9H
7072H  (DBH) IN E8H
7074H  (3CH) INR A
7075H  (3EH) MVI A,FFH
7077H  (D3H) OUT B9H
7079H  (CAH) JZ 71FDH
707CH  (3EH) MVI A,7FH
707EH  (0EH) MVI C,07H
7080H  (2BH) DCX H
7081H  (1BH) DCX D
7082H  (47H) MOV B,A
7083H  (D3H) OUT B9H
7085H  (DBH) IN E8H
7087H  (2FH) CMA
7088H  (BEH) CMP M
7089H  (77H) MOV M,A
708AH  (C2H) JNZ 7092H
708DH  (1AH) LDAX D
708EH  (BEH) CMP M
708FH  (C4H) CNZ 70C5H
7092H  (3EH) MVI A,FFH
7094H  (D3H) OUT B9H
7096H  (78H) MOV A,B
7097H  (0FH) RRC
7098H  (0DH) DCR C
7099H  (F2H) JP 7080H
709CH  (2BH) DCX H
709DH  (36H) MVI M,02H
709FH  (21H) LXI H,FFA5H
70A2H  (35H) DCR M
70A3H  (CAH) JZ 711AH
70A6H  (34H) INR M
70A7H  (F8H) RM
70A8H  (3AH) LDA FFA7H
70ABH  (2AH) LHLD FFA8H     ; Pointer to entry in 2nd Storage Buffer for key
70AEH  (A6H) ANA M
70AFH  (C8H) RZ

; ======================================================
; Key repeat detection
; ======================================================
70B0H  (3AH) LDA FFAAH      ; Keyboard buffer count
70B3H  (FEH) CPI 02H
70B5H  (D0H) RNC
70B6H  (21H) LXI H,FFA4H    ; Key repeat start delay counter
70B9H  (35H) DCR M
70BAH  (C0H) RNZ
70BBH  (36H) MVI M,06H
70BDH  (3EH) MVI A,01H
70BFH  (32H) STA FFF3H
70C2H  (C3H) JMP 7122H      ; Key decoding

70C5H  (C5H) PUSH B
70C6H  (E5H) PUSH H
70C7H  (D5H) PUSH D
70C8H  (47H) MOV B,A
70C9H  (3EH) MVI A,80H
70CBH  (1EH) MVI E,07H
70CDH  (57H) MOV D,A
70CEH  (A6H) ANA M
70CFH  (CAH) JZ 70D6H
70D2H  (A0H) ANA B
70D3H  (CAH) JZ 70E2H
70D6H  (7AH) MOV A,D
70D7H  (0FH) RRC
70D8H  (1DH) DCR E
70D9H  (F2H) JP 70CDH
70DCH  (D1H) POP D
70DDH  (E1H) POP H
70DEH  (7EH) MOV A,M
70DFH  (12H) STAX D
70E0H  (C1H) POP B
70E1H  (C9H) RET

70E2H  (21H) LXI H,FFA5H
70E5H  (3CH) INR A
70E6H  (BEH) CMP M
70E7H  (C2H) JNZ 70EEH
70EAH  (D1H) POP D
70EBH  (E1H) POP H
70ECH  (C1H) POP B
70EDH  (C9H) RET

70EEH  (77H) MOV M,A
70EFH  (79H) MOV A,C
70F0H  (07H) RLC
70F1H  (07H) RLC
70F2H  (07H) RLC
70F3H  (B3H) ORA E
70F4H  (23H) INX H
70F5H  (77H) MOV M,A
70F6H  (23H) INX H
70F7H  (72H) MOV M,D
70F8H  (D1H) POP D
70F9H  (EBH) XCHG
70FAH  (22H) SHLD FFA8H     ; Pointer to entry in 2nd Storage Buffer for key
70FDH  (EBH) XCHG
70FEH  (C3H) JMP 70DDH

7101H  (1AH) LDAX D
7102H  (47H) MOV B,A
7103H  (7EH) MOV A,M
7104H  (12H) STAX D
7105H  (07H) RLC
7106H  (D0H) RNC
7107H  (78H) MOV A,B
7108H  (07H) RLC
7109H  (D8H) RC
710AH  (E3H) XTHL
710BH  (21H) LXI H,71C4H
710EH  (E3H) XTHL
710FH  (06H) MVI B,00H
7111H  (50H) MOV D,B
7112H  (7EH) MOV A,M
7113H  (0FH) RRC
7114H  (3EH) MVI A,03H
7116H  (D8H) RC
7117H  (3EH) MVI A,13H
7119H  (C9H) RET

711AH  (2BH) DCX H
711BH  (36H) MVI M,54H
711DH  (2BH) DCX H
711EH  (3AH) LDA FFA2H      ; Keyboard scan column storage @2
7121H  (77H) MOV M,A

; ======================================================
; Key decoding
; ======================================================
7122H  (3AH) LDA FFA6H      ; Key position storage
7125H  (4FH) MOV C,A
7126H  (11H) LXI D,002CH
7129H  (42H) MOV B,D
712AH  (FEH) CPI 33H
712CH  (DAH) JC 7133H
712FH  (21H) LXI H,FFA7H
7132H  (70H) MOV M,B
7133H  (3AH) LDA FFA3H      ; Shift key status storage
7136H  (0FH) RRC
7137H  (F5H) PUSH PSW
7138H  (79H) MOV A,C
7139H  (BBH) CMP E
713AH  (DAH) JC 7184H
713DH  (FEH) CPI 30H
713FH  (D2H) JNC 7148H
7142H  (F1H) POP PSW
7143H  (F5H) PUSH PSW
7144H  (0FH) RRC
7145H  (DAH) JC 7184H
7148H  (21H) LXI H,7CEFH
714BH  (F1H) POP PSW
714CH  (D2H) JNC 7152H
714FH  (21H) LXI H,7CDBH
7152H  (09H) DAD B
7153H  (7EH) MOV A,M
7154H  (07H) RLC
7155H  (B7H) ORA A
7156H  (1FH) RAR
7157H  (4FH) MOV C,A
7158H  (D2H) JNC 71E4H      ; Keyboard buffer management - place subsequent key in buffer
715BH  (FEH) CPI 08H
715DH  (D2H) JNC 7180H
7160H  (3AH) LDA F650H
7163H  (E6H) ANI E0H
7165H  (C2H) JNZ 7180H
7168H  (2AH) LHLD F67AH     ; Current executing line number
716BH  (7CH) MOV A,H
716CH  (A5H) ANA L
716DH  (3CH) INR A
716EH  (CAH) JZ 7180H
7171H  (21H) LXI H,F630H    ; Function key status table (1 = on)
7174H  (09H) DAD B
7175H  (7EH) MOV A,M
7176H  (B7H) ORA A
7177H  (CAH) JZ 7180H
717AH  (79H) MOV A,C
717BH  (F6H) ORI 80H
717DH  (C3H) JMP 71D5H      ; Keyboard buffer management - place key in new buffer

7180H  (05H) DCR B
7181H  (C3H) JMP 71E4H      ; Keyboard buffer management - place subsequent key in buffer

7184H  (F1H) POP PSW
7185H  (DAH) JC 7189H
7188H  (58H) MOV E,B
7189H  (0FH) RRC
718AH  (F5H) PUSH PSW
718BH  (DAH) JC 720AH       ; Handle unshifted & non-CTRL key during key decoding
718EH  (21H) LXI H,7C49H
7191H  (0FH) RRC
7192H  (DAH) JC 71B5H
7195H  (21H) LXI H,7CA1H
7198H  (0FH) RRC
7199H  (DAH) JC 71B5H
719CH  (0FH) RRC
719DH  (D2H) JNC 71AEH
71A0H  (21H) LXI H,7BF1H
71A3H  (09H) DAD B
71A4H  (D5H) PUSH D
71A5H  (57H) MOV D,A
71A6H  (CDH) CALL 7233H     ; Handle NUM key during key decoding
71A9H  (7AH) MOV A,D
71AAH  (D1H) POP D
71ABH  (CAH) JZ 71B7H
71AEH  (0FH) RRC
71AFH  (DCH) CC 722CH       ; Handle CAPS LOCK key during key decoding
71B2H  (21H) LXI H,7BF1H
71B5H  (19H) DAD D
71B6H  (09H) DAD B
71B7H  (F1H) POP PSW
71B8H  (7EH) MOV A,M
71B9H  (D2H) JNC 71C2H
71BCH  (FEH) CPI 60H
71BEH  (D0H) RNC
71BFH  (E6H) ANI 3FH
71C1H  (DAH) JC C8B7H
71C4H  (4FH) MOV C,A
71C5H  (E6H) ANI EFH
71C7H  (FEH) CPI 03H
71C9H  (C2H) JNZ 71E4H      ; Keyboard buffer management - place subsequent key in buffer
71CCH  (3AH) LDA F650H
71CFH  (E6H) ANI C0H
71D1H  (C2H) JNZ 71E4H      ; Keyboard buffer management - place subsequent key in buffer
71D4H  (79H) MOV A,C

; ======================================================
; Keyboard buffer management - place key in new buffer
; ======================================================
71D5H  (32H) STA FFEBH      ; Holds CTRL-C or CTRL-S until it is processed
71D8H  (FEH) CPI 03H
71DAH  (C0H) RNZ
71DBH  (21H) LXI H,FFAAH    ; Keyboard buffer count
71DEH  (36H) MVI M,01H
71E0H  (23H) INX H
71E1H  (C3H) JMP 71F0H

; ======================================================
; Keyboard buffer management - place subsequent key in buffer
; ======================================================
71E4H  (21H) LXI H,FFAAH    ; Keyboard buffer count
71E7H  (7EH) MOV A,M
71E8H  (FEH) CPI 20H
71EAH  (C8H) RZ
71EBH  (34H) INR M
71ECH  (07H) RLC
71EDH  (23H) INX H
71EEH  (5FH) MOV E,A
71EFH  (19H) DAD D
71F0H  (71H) MOV M,C
71F1H  (23H) INX H
71F2H  (70H) MOV M,B
71F3H  (F1H) POP PSW

; ======================================================
; Set new interrupt mask and pop all regs & RET
; ======================================================
71F4H  (3EH) MVI A,09H
71F6H  (30H) SIM

; ======================================================
; Interrupt exit routine (pop all regs & RET)
; ======================================================
71F7H  (F1H) POP PSW
71F8H  (C1H) POP B
71F9H  (D1H) POP D
71FAH  (E1H) POP H
71FBH  (FBH) EI
71FCH  (C9H) RET

71FDH  (21H) LXI H,FF90H
7200H  (35H) DCR M
7201H  (C0H) RNZ
7202H  (21H) LXI H,FF91H
7205H  (06H) MVI B,11H
7207H  (C3H) JMP 4F0AH      ; Zero B bytes at M

; ======================================================
; Handle unshifted & non-CTRL key during key decoding
; ======================================================
720AH  (79H) MOV A,C
720BH  (FEH) CPI 1AH
720DH  (21H) LXI H,7C1DH
7210H  (DAH) JC 71B6H
7213H  (FEH) CPI 2CH
7215H  (DAH) JC 721DH
7218H  (FEH) CPI 30H
721AH  (DAH) JC 7222H       ; Handle Arrow keys during key decoding
721DH  (F1H) POP PSW
721EH  (F5H) PUSH PSW
721FH  (C3H) JMP 718EH

; ======================================================
; Handle Arrow keys during key decoding
; ======================================================
7222H  (D6H) SUI 2CH
7224H  (21H) LXI H,7D2FH
7227H  (4FH) MOV C,A
7228H  (09H) DAD B
7229H  (C3H) JMP 71B7H

; ======================================================
; Handle CAPS LOCK key during key decoding
; ======================================================
722CH  (79H) MOV A,C
722DH  (FEH) CPI 1AH
722FH  (D0H) RNC
7230H  (1EH) MVI E,2CH
7232H  (C9H) RET

; ======================================================
; Handle NUM key during key decoding
; ======================================================
7233H  (7EH) MOV A,M
7234H  (1EH) MVI E,06H
7236H  (21H) LXI H,7CF9H
7239H  (BEH) CMP M
723AH  (23H) INX H
723BH  (C8H) RZ
723CH  (23H) INX H
723DH  (1DH) DCR E
723EH  (F2H) JP 7239H
7241H  (C9H) RET

; ======================================================
; Scan keyboard for character (CTRL-BREAK ==> CTRL-C)
; ======================================================
7242H  (CDH) CALL 765CH     ; Disable Background task & barcode interrupts
7245H  (3AH) LDA FFAAH      ; Keyboard buffer count
7248H  (B7H) ORA A
7249H  (CAH) JZ 726AH       ; Enable interrupts as normal
724CH  (21H) LXI H,FFACH
724FH  (7EH) MOV A,M
7250H  (C6H) ADI 02H
7252H  (2BH) DCX H
7253H  (7EH) MOV A,M
7254H  (F5H) PUSH PSW
7255H  (2BH) DCX H
7256H  (35H) DCR M
7257H  (7EH) MOV A,M
7258H  (07H) RLC
7259H  (4FH) MOV C,A
725AH  (23H) INX H
725BH  (11H) LXI D,FFADH
725EH  (0DH) DCR C
725FH  (FAH) JM 7269H
7262H  (1AH) LDAX D
7263H  (77H) MOV M,A
7264H  (23H) INX H
7265H  (13H) INX D
7266H  (C3H) JMP 725EH

7269H  (F1H) POP PSW

; ======================================================
; Enable interrupts as normal
; ======================================================
726AH  (F5H) PUSH PSW
726BH  (3EH) MVI A,09H
726DH  (30H) SIM
726EH  (F1H) POP PSW
726FH  (C9H) RET

; ======================================================
; Check keyboard queue for pending characters
; ======================================================
7270H  (CDH) CALL 7283H     ; Check for break or wait (CTRL-S)
7273H  (CAH) JZ 727EH
7276H  (FEH) CPI 03H
7278H  (C2H) JNZ 727EH
727BH  (B7H) ORA A
727CH  (37H) STC
727DH  (C9H) RET

727EH  (3AH) LDA FFAAH      ; Keyboard buffer count
7281H  (B7H) ORA A
7282H  (C9H) RET

; ======================================================
; Check for break or wait (CTRL-S)
; ======================================================
7283H  (E5H) PUSH H         ; Preserve HL
7284H  (21H) LXI H,FFEBH    ; Holds CTRL-C or CTRL-S until it is processed
7287H  (7EH) MOV A,M        ; Test for pending CTRL-C or CTRL-S
7288H  (36H) MVI M,00H      ; Clear pending CTRL-C or CTRL-S
728AH  (E1H) POP H          ; Restore HL
728BH  (B7H) ORA A          ; Test if either was pending
728CH  (F0H) RP             ; Return if CTRL-C or CTRL-S pending
728DH  (E5H) PUSH H         ; Preserve HL again
728EH  (C5H) PUSH B         ; Preserve BC
728FH  (21H) LXI H,F7CAH
7292H  (4FH) MOV C,A
7293H  (06H) MVI B,00H
7295H  (09H) DAD B
7296H  (09H) DAD B
7297H  (09H) DAD B
7298H  (CDH) CALL 3FD2H     ; Trigger interrupt.  HL points to interrupt table
729BH  (C1H) POP B
729CH  (E1H) POP H
729DH  (AFH) XRA A
729EH  (C9H) RET

; ======================================================
; Check if SHIFT-BREAK is being pressed
; ======================================================
729FH  (C5H) PUSH B
72A0H  (DBH) IN B9H
72A2H  (4FH) MOV C,A
72A3H  (CDH) CALL 72B1H     ; Scan BREAK,CAPS,NUM,CODE,GRAPH,CTRL,SHIFT & set bits in A
72A6H  (F5H) PUSH PSW
72A7H  (79H) MOV A,C
72A8H  (D3H) OUT B9H
72AAH  (F1H) POP PSW
72ABH  (C1H) POP B
72ACH  (E6H) ANI 81H        ; Test for SHIFT-BREAK key combination
72AEH  (C0H) RNZ
72AFH  (37H) STC
72B0H  (C9H) RET

; ======================================================
; Scan BREAK,CAPS,NUM,CODE,GRAPH,CTRL,SHIFT & set bits in A
; ======================================================
72B1H  (3EH) MVI A,FFH
72B3H  (D3H) OUT B9H
72B5H  (DBH) IN BAH
72B7H  (E6H) ANI FEH
72B9H  (47H) MOV B,A
72BAH  (D3H) OUT BAH
72BCH  (DBH) IN E8H
72BEH  (F5H) PUSH PSW
72BFH  (78H) MOV A,B
72C0H  (3CH) INR A
72C1H  (D3H) OUT BAH
72C3H  (F1H) POP PSW
72C4H  (C9H) RET

; ======================================================
; Produce a tone of DE freq and B duration
; ======================================================
72C5H  (F3H) DI
72C6H  (7BH) MOV A,E
72C7H  (D3H) OUT BCH
72C9H  (7AH) MOV A,D
72CAH  (F6H) ORI 40H
72CCH  (D3H) OUT BDH
72CEH  (3EH) MVI A,C3H
72D0H  (D3H) OUT B8H
72D2H  (DBH) IN BAH
72D4H  (E6H) ANI F8H
72D6H  (F6H) ORI 20H
72D8H  (D3H) OUT BAH
72DAH  (CDH) CALL 729FH     ; Check if SHIFT-BREAK is being pressed
72DDH  (D2H) JNC 72E8H
72E0H  (3EH) MVI A,03H
72E2H  (32H) STA FFEBH      ; Holds CTRL-C or CTRL-S until it is processed
72E5H  (C3H) JMP 72F9H

72E8H  (0EH) MVI C,64H
72EAH  (C5H) PUSH B
72EBH  (0EH) MVI C,1EH
72EDH  (CDH) CALL 7657H     ; Delay routine - decrement C until zero
72F0H  (C1H) POP B
72F1H  (0DH) DCR C
72F2H  (C2H) JNZ 72EAH
72F5H  (05H) DCR B
72F6H  (C2H) JNZ 72DAH
72F9H  (DBH) IN BAH
72FBH  (F6H) ORI 04H
72FDH  (D3H) OUT BAH
72FFH  (CDH) CALL 6E83H
7302H  (FBH) EI
7303H  (C9H) RET

7304H  (E5H) PUSH H
7305H  (D5H) PUSH D
7306H  (C5H) PUSH B
7307H  (F5H) PUSH PSW
7308H  (5EH) MOV E,M
7309H  (23H) INX H
730AH  (56H) MOV D,M
730BH  (23H) INX H
730CH  (4EH) MOV C,M
730DH  (23H) INX H
730EH  (46H) MOV B,M
730FH  (23H) INX H
7310H  (7EH) MOV A,M
7311H  (D3H) OUT 70H
7313H  (F3H) DI
7314H  (23H) INX H
7315H  (7EH) MOV A,M
7316H  (D3H) OUT 71H
7318H  (23H) INX H
7319H  (7EH) MOV A,M
731AH  (D3H) OUT 72H
731CH  (78H) MOV A,B
731DH  (B1H) ORA C
731EH  (CAH) JZ 71F7H       ; Interrupt exit routine (pop all regs & RET)
7321H  (DBH) IN 73H
7323H  (12H) STAX D
7324H  (13H) INX D
7325H  (0BH) DCX B
7326H  (C3H) JMP 731CH

; ======================================================
; Copy clock chip regs to M
; ======================================================
7329H  (F6H) ORI AFH
732BH  (F5H) PUSH PSW
732CH  (CDH) CALL 765CH     ; Disable Background task & barcode interrupts
732FH  (3EH) MVI A,03H
7331H  (C4H) CNZ 7383H      ; Set clock chip mode
7334H  (3EH) MVI A,01H
7336H  (CDH) CALL 7383H     ; Set clock chip mode
7339H  (0EH) MVI C,07H
733BH  (CDH) CALL 7657H     ; Delay routine - decrement C until zero
733EH  (06H) MVI B,0AH
7340H  (0EH) MVI C,04H
7342H  (56H) MOV D,M
7343H  (F1H) POP PSW
7344H  (F5H) PUSH PSW
7345H  (CAH) JZ 7352H       ; Read next bit from Clock Chip
7348H  (DBH) IN BBH
734AH  (1FH) RAR
734BH  (7AH) MOV A,D
734CH  (1FH) RAR
734DH  (57H) MOV D,A
734EH  (AFH) XRA A
734FH  (C3H) JMP 735DH

; ======================================================
; Read next bit from Clock Chip
; ======================================================
7352H  (7AH) MOV A,D
7353H  (0FH) RRC
7354H  (57H) MOV D,A
7355H  (3EH) MVI A,10H
7357H  (1FH) RAR
7358H  (1FH) RAR
7359H  (1FH) RAR
735AH  (1FH) RAR
735BH  (D3H) OUT B9H
735DH  (F6H) ORI 09H
735FH  (D3H) OUT B9H
7361H  (E6H) ANI F7H
7363H  (D3H) OUT B9H
7365H  (0DH) DCR C
7366H  (C2H) JNZ 7343H
7369H  (7AH) MOV A,D
736AH  (0FH) RRC
736BH  (0FH) RRC
736CH  (0FH) RRC
736DH  (0FH) RRC
736EH  (E6H) ANI 0FH
7370H  (77H) MOV M,A
7371H  (23H) INX H
7372H  (05H) DCR B
7373H  (C2H) JNZ 7340H
7376H  (F1H) POP PSW
7377H  (3EH) MVI A,02H
7379H  (CCH) CZ 7383H       ; Set clock chip mode
737CH  (AFH) XRA A
737DH  (CDH) CALL 7383H     ; Set clock chip mode
7380H  (C3H) JMP 743CH

; ======================================================
; Set clock chip mode
; ======================================================
7383H  (D3H) OUT B9H
7385H  (3AH) LDA FF45H      ; Contents of port E8H
7388H  (F6H) ORI 04H
738AH  (D3H) OUT E8H
738CH  (E6H) ANI FBH
738EH  (D3H) OUT E8H
7390H  (C9H) RET

; ======================================================
; Cursor BLINK - Continuation of RST 7.5 Background hook
; ======================================================
7391H  (CDH) CALL 765CH     ; Disable Background task & barcode interrupts
7394H  (21H) LXI H,7055H    ; Load address of Keyboard scanning management routine
7397H  (E5H) PUSH H         ; Push return address to stack
7398H  (21H) LXI H,FFF3H    ; Load pointer to cursor blink count-down
739BH  (35H) DCR M          ; Decrement the cursor blink count-down
739CH  (C0H) RNZ            ; Return (to Keyboard scanning) if not time to blink
739DH  (36H) MVI M,7DH      ; Re-initialize cursor blink counter
739FH  (2BH) DCX H          ; Decrement to address of cursor blink on-off status
73A0H  (7EH) MOV A,M        ; Get current cursor blink blink on-off status
73A1H  (B7H) ORA A          ; Test if blink disabled
73A2H  (F2H) JP 73A6H       ; Jump to change blink state if not disabled
73A5H  (E0H) RPO            ; Return if blink on-off status Parity is odd (0x80)
73A6H  (EEH) XRI 01H        ; Toggle the cursor blink on-of state
73A8H  (77H) MOV M,A        ; Update the new cursor blink state

; ======================================================
; Blink the cursor
; ======================================================
73A9H  (E5H) PUSH H         ; Save HL on stack
73AAH  (21H) LXI H,FFECH    ; Cursor bit pattern storage
73ADH  (16H) MVI D,00H
73AFH  (CDH) CALL 74A2H     ; Byte Plot - Send bit pattern to LCD for character
73B2H  (06H) MVI B,06H      ; Prepare to compliment 6 bytes of Cursor pixels
73B4H  (2BH) DCX H          ; HL now points to end of cursor bit pattern
73B5H  (7EH) MOV A,M        ; Get next byte of cursor pattern
73B6H  (2FH) CMA            ; Compliment all bits in Cursor pattern
73B7H  (77H) MOV M,A        ; Save it back
73B8H  (2BH) DCX H          ; Decrement to next col of cursor bits
73B9H  (05H) DCR B          ; Decrement loop counter
73BAH  (C2H) JNZ 73B5H      ; Jump until count = 0
73BDH  (23H) INX H          ; Increment to cursor bit storage again
73BEH  (16H) MVI D,01H
73C0H  (CDH) CALL 74A2H     ; Byte Plot - Send bit pattern to LCD for character
73C3H  (E1H) POP H          ; Restore HL
73C4H  (C9H) RET            ; This will return to Keyscan routine for RST 7.5 hook from above

; ======================================================
; Turn off background task, blink & reinitialize cursor blink time
; ======================================================
73C5H  (E5H) PUSH H         ; Push registers to stack to preserve
73C6H  (D5H) PUSH D
73C7H  (C5H) PUSH B
73C8H  (F5H) PUSH PSW
73C9H  (CDH) CALL 765CH     ; Disable Background task & barcode interrupts
73CCH  (21H) LXI H,FFF2H    ; Load address of Cursor blink counter
73CFH  (7EH) MOV A,M        ; Load Cursor blink counter
73D0H  (0FH) RRC            ; Test if time to blink
73D1H  (DCH) CC 73A9H       ; Blink the cursor
73D4H  (36H) MVI M,80H      ; Initialize Cursor blink counter
73D6H  (C3H) JMP 71F4H      ; Set new interrupt mask and pop all regs & RET

; ======================================================
; Initialize Cursor Blink to start blinking
; ======================================================
73D9H  (F5H) PUSH PSW       ; Preserve PSW on stack
73DAH  (E5H) PUSH H         ; Preserve HL on stack
73DBH  (CDH) CALL 765CH     ; Disable Background task & barcode interrupts
73DEH  (21H) LXI H,FFF2H    ; Load address of Cursor blink counter
73E1H  (7EH) MOV A,M        ; Get current Cursor blink flag
73E2H  (E6H) ANI 7FH        ; Mask off upper bit
73E4H  (77H) MOV M,A        ; Save new cursor blink flag
73E5H  (23H) INX H          ; Point to LSB of cursor blink counter
73E6H  (36H) MVI M,01H      ; Set blink count to 1 maybe
73E8H  (3EH) MVI A,09H      ; Load new interrupt mask value
73EAH  (30H) SIM            ; Set new interrupt mask
73EBH  (E1H) POP H          ; Restore HL
73ECH  (F1H) POP PSW        ; Restore PSW
73EDH  (C9H) RET

; ======================================================
; Character plotting level 7.  Plot character in C on LCD at (H,L)
; ======================================================
73EEH  (CDH) CALL 765CH     ; Disable Background task & barcode interrupts
73F1H  (21H) LXI H,0000H
73F4H  (39H) DAD SP
73F5H  (22H) SHLD FFF8H
73F8H  (15H) DCR D
73F9H  (1DH) DCR E
73FAH  (EBH) XCHG
73FBH  (22H) SHLD FFF4H
73FEH  (79H) MOV A,C
73FFH  (11H) LXI D,7710H
7402H  (D6H) SUI 20H
7404H  (CAH) JZ 7410H
7407H  (13H) INX D
7408H  (FEH) CPI 60H
740AH  (DAH) JC 7410H
740DH  (11H) LXI D,76B1H
7410H  (F5H) PUSH PSW
7411H  (6FH) MOV L,A
7412H  (26H) MVI H,00H
7414H  (44H) MOV B,H
7415H  (4DH) MOV C,L
7416H  (29H) DAD H
7417H  (29H) DAD H
7418H  (09H) DAD B
7419H  (F1H) POP PSW
741AH  (F5H) PUSH PSW
741BH  (DAH) JC 741FH
741EH  (09H) DAD B
741FH  (19H) DAD D
7420H  (F1H) POP PSW
7421H  (D2H) JNC 7430H
7424H  (11H) LXI D,FFECH    ; Cursor bit pattern storage
7427H  (D5H) PUSH D
7428H  (06H) MVI B,05H
742AH  (CDH) CALL 2542H     ; Move B bytes from M to (DE)
742DH  (AFH) XRA A
742EH  (12H) STAX D
742FH  (E1H) POP H
7430H  (16H) MVI D,01H
7432H  (CDH) CALL 74A2H     ; Byte Plot - Send bit pattern to LCD for character
7435H  (AFH) XRA A
7436H  (32H) STA FFF9H
7439H  (CDH) CALL 752BH     ; Set the display top line to zero for all LCD controllers
743CH  (3EH) MVI A,09H
743EH  (30H) SIM
743FH  (C9H) RET

7440H  (CDH) CALL 765CH     ; Disable Background task & barcode interrupts
7443H  (15H) DCR D
7444H  (1DH) DCR E
7445H  (EBH) XCHG
7446H  (22H) SHLD FFF4H
7449H  (C3H) JMP 743CH

; ======================================================
; Plot (set) point (D,E) on the LCD
; ======================================================
744CH  (F6H) ORI AFH
744EH  (F5H) PUSH PSW
744FH  (CDH) CALL 765CH     ; Disable Background task & barcode interrupts
7452H  (D5H) PUSH D
7453H  (0EH) MVI C,FEH
7455H  (7AH) MOV A,D
7456H  (0CH) INR C
7457H  (0CH) INR C
7458H  (57H) MOV D,A
7459H  (D6H) SUI 32H
745BH  (D2H) JNC 7456H
745EH  (06H) MVI B,00H
7460H  (21H) LXI H,7643H    ; 8155 PIO chip bit patterns for Lower LCD drivers
7463H  (7BH) MOV A,E
7464H  (17H) RAL
7465H  (17H) RAL
7466H  (17H) RAL
7467H  (D2H) JNC 746DH
746AH  (21H) LXI H,764DH
746DH  (09H) DAD B
746EH  (47H) MOV B,A
746FH  (CDH) CALL 753BH     ; Enable LCD driver specified by HL
7472H  (78H) MOV A,B
7473H  (E6H) ANI C0H
7475H  (B2H) ORA D
7476H  (47H) MOV B,A
7477H  (1EH) MVI E,01H
7479H  (21H) LXI H,FFECH    ; Cursor bit pattern storage
747CH  (CDH) CALL 74F5H
747FH  (D1H) POP D
7480H  (50H) MOV D,B
7481H  (7BH) MOV A,E
7482H  (E6H) ANI 07H
7484H  (87H) ADD A
7485H  (4FH) MOV C,A
7486H  (06H) MVI B,00H
7488H  (21H) LXI H,7643H    ; 8155 PIO chip bit patterns for Lower LCD drivers
748BH  (09H) DAD B
748CH  (F1H) POP PSW
748DH  (7EH) MOV A,M
748EH  (21H) LXI H,FFECH    ; Cursor bit pattern storage
7491H  (C2H) JNZ 7497H
7494H  (2FH) CMA
7495H  (A6H) ANA M
7496H  (06H) MVI B,B6H
7498H  (77H) MOV M,A
7499H  (42H) MOV B,D
749AH  (1EH) MVI E,01H
749CH  (CDH) CALL 74F6H
749FH  (C3H) JMP 743CH

; ======================================================
; Byte Plot - Send bit pattern to LCD for character
; ======================================================
74A2H  (E5H) PUSH H
74A3H  (1EH) MVI E,06H
74A5H  (3AH) LDA FFF5H
74A8H  (FEH) CPI 08H
74AAH  (CAH) JZ 74B7H
74ADH  (FEH) CPI 10H
74AFH  (CAH) JZ 74B9H
74B2H  (FEH) CPI 21H
74B4H  (C2H) JNZ 74BBH
74B7H  (1DH) DCR E
74B8H  (1DH) DCR E
74B9H  (1DH) DCR E
74BAH  (1DH) DCR E
74BBH  (4FH) MOV C,A
74BCH  (81H) ADD C
74BDH  (81H) ADD C
74BEH  (4FH) MOV C,A
74BFH  (06H) MVI B,00H
74C1H  (3AH) LDA FFF4H
74C4H  (1FH) RAR
74C5H  (1FH) RAR
74C6H  (1FH) RAR
74C7H  (21H) LXI H,75C9H
74CAH  (DAH) JC 74D0H
74CDH  (21H) LXI H,7551H    ; 8155 PIO chip bit patterns for Upper LCD drivers
74D0H  (09H) DAD B
74D1H  (47H) MOV B,A
74D2H  (CDH) CALL 753BH     ; Enable LCD driver(s) specified by (HL)
74D5H  (22H) SHLD FFF6H
74D8H  (78H) MOV A,B
74D9H  (B6H) ORA M
74DAH  (47H) MOV B,A
74DBH  (E1H) POP H
74DCH  (15H) DCR D
74DDH  (CDH) CALL 74F7H
74E0H  (14H) INR D
74E1H  (3EH) MVI A,06H
74E3H  (93H) SUB E
74E4H  (C8H) RZ
74E5H  (5FH) MOV E,A
74E6H  (E5H) PUSH H
74E7H  (2AH) LHLD FFF6H
74EAH  (23H) INX H
74EBH  (CDH) CALL 753BH     ; Enable LCD driver(s) specified by (HL) 
74EEH  (E1H) POP H
74EFH  (78H) MOV A,B
74F0H  (E6H) ANI C0H
74F2H  (47H) MOV B,A
74F3H  (15H) DCR D
74F4H  DB    DAH            ; Make "ORI AFH" below look like "JC AFF6H" for pass-thru

74F5H  (F6H) ORI AFH 
74F7H  (D5H) PUSH D
74F8H  (F5H) PUSH PSW
74F9H  (78H) MOV A,B
74FAH  (CDH) CALL 7548H     ; Wait for LCD driver to be available
74FDH  (D3H) OUT FEH
74FFH  (CAH) JZ 7507H
7502H  (CDH) CALL 7548H     ; Wait for LCD driver to be available
7505H  (DBH) IN FFH
7507H  (F1H) POP PSW
7508H  (C2H) JNZ 751BH
750BH  (DBH) IN FEH
750DH  (17H) RAL
750EH  (DAH) JC 750BH
7511H  (7EH) MOV A,M
7512H  (D3H) OUT FFH
7514H  (23H) INX H
7515H  (1DH) DCR E
7516H  (C2H) JNZ 750BH
7519H  (D1H) POP D
751AH  (C9H) RET

751BH  (DBH) IN FEH
751DH  (17H) RAL
751EH  (DAH) JC 751BH
7521H  (DBH) IN FFH
7523H  (77H) MOV M,A
7524H  (23H) INX H
7525H  (1DH) DCR E
7526H  (C2H) JNZ 751BH
7529H  (D1H) POP D
752AH  (C9H) RET

; ======================================================
; Set the display top line to zero for all LCD controllers
; This configures the HW scrolling to start displaying
; from the natural ROW 0 (i.e. not scrolled).
; ======================================================
752BH  (CDH) CALL 7533H     ; Enable LCD drivers after short delay
752EH  (3EH) MVI A,3EH      ; Load command to set top line = 0
7530H  (D3H) OUT FEH        ; Send the command
7532H  (C9H) RET

; ======================================================
; Enable LCD drivers after short delay
; ======================================================
7533H  (0EH) MVI C,03H      ; Prepare for a short delay 
7535H  (CDH) CALL 7657H     ; Delay routine - decrement C until zero
7538H  (21H) LXI H,7641H    ; Point to LCD enable bits to enable all 

; ======================================================
; Enable LCD drivers specified by (HL)
; ======================================================
753BH  (7EH) MOV A,M        ; Get Bit pattern for 8 drivers
753CH  (D3H) OUT B9H        ; OUTput the bit pattern for 8 drivers
753EH  (23H) INX H          ; Increment to bit pattern for next 2 LCD drivers
753FH  (DBH) IN BAH         ; Get current value of I/O port with 2 LCD drivers
7541H  (E6H) ANI FCH        ; Mask off LCD driver bit positions
7543H  (B6H) ORA M          ; OR in selected LCD driver enable bits
7544H  (D3H) OUT BAH        ; OUTput selected LCD driver bits
7546H  (23H) INX H          ; Increment to next set of LCD driver enable bits
7547H  (C9H) RET

; ======================================================
; Wait for LCD driver to be available
; ======================================================
7548H  (F5H) PUSH PSW       ; Save A on stack
7549H  (DBH) IN FEH         ; Read the LCD driver input port
754BH  (17H) RAL            ; Rotate the busy bit into the C flag
754CH  (DAH) JC 7549H       ; Jump to keep waiting until not busy
754FH  (F1H) POP PSW        ; Restore A
7550H  (C9H) RET

; ======================================================
; 8155 PIO chip bit patterns for LCD drivers
; ======================================================
7551H  DB   01H,00H,00H,01H,00H,06H,01H,00H
7559H  DB   0CH,01H,00H,12H,01H,00H,18H,01H
7561H  DB   00H,1EH,01H,00H,24H,01H,00H,2AH
7569H  DB   01H,00H,30H,02H,00H,04H,02H,00H
7571H  DB   0AH,02H,00H,10H,02H,00H,16H,02H
7579H  DB   00H,1CH,02H,00H,22H,02H,00H,28H
7581H  DB   02H,00H,2EH,04H,00H,02H,04H,00H
7589H  DB   08H,04H,00H,0EH,04H,00H,14H,04H
7591H  DB   00H,1AH,04H,00H,20H,04H,00H,26H
7599H  DB   04H,00H,2CH,08H,00H,00H,08H,00H
75A1H  DB   06H,08H,00H,0CH,08H,00H,12H,08H
75A9H  DB   00H,18H,08H,00H,1EH,08H,00H,24H
75B1H  DB   08H,00H,2AH,08H,00H,30H,10H,00H
75B9H  DB   04H,10H,00H,0AH,10H,00H,10H,10H
75C1H  DB   00H,16H,10H,00H,1CH,10H,00H,22H
75C9H  DB   20H,00H,00H,20H,00H,06H,20H,00H
75D1H  DB   0CH,20H,00H,12H,20H,00H,18H,20H
75D9H  DB   00H,1EH,20H,00H,24H,20H,00H,2AH
75E1H  DB   20H,00H,30H,40H,00H,04H,40H,00H
75E9H  DB   0AH,40H,00H,10H,40H,00H,16H,40H
75F1H  DB   00H,1CH,40H,00H,22H,40H,00H,28H
75F9H  DB   40H,00H,2EH,80H,00H,02H,80H,00H
7601H  DB   08H,80H,00H,0EH,80H,00H,14H,80H
7609H  DB   00H,1AH,80H,00H,20H,80H,00H,26H
7611H  DB   80H,00H,2CH,00H,01H,00H,00H,01H
7619H  DB   06H,00H,01H,0CH,00H,01H,12H,00H
7621H  DB   01H,18H,00H,01H,1EH,00H,01H,24H
7629H  DB   00H,01H,2AH,00H,01H,30H,00H,02H
7631H  DB   04H,00H,02H,0AH,00H,02H,10H,00H
7639H  DB   02H,16H,00H,02H,1CH,00H,02H,22H

; ======================================================
; 8155 PIO chip bit patterns to enable all LCD drivers
; ======================================================
7641H  DB   FFH,03H

; ======================================================
; 8155 PIO chip bit patterns for LCD drivers
; ======================================================
7643H  DB   01H,00H,02H,00H,04H,00H,08H,00H
764BH  DB   10H,00H,20H,00H,40H,00H,80H,00H
7653H  DB   00H,01H,00H,02H

; ======================================================
; Delay routine - decrement C until zero
; ======================================================
7657H  (0DH) DCR C          ; Decrement C
7658H  (C2H) JNZ 7657H      ; Loop until C = 0
765BH  (C9H) RET

; ======================================================
; Disable Background task & barcode interrupts
; ======================================================
765CH  (F3H) DI             ; Disalbe interrupts
765DH  (3EH) MVI A,1DH      ; Load SIM mask to disable RST 5.5 & 7.5
765FH  (30H) SIM            ; Set new interrupt mask (disable Background & barcode)
7660H  (FBH) EI             ; Re-enable interrupts
7661H  (C9H) RET

; ======================================================
; Beep routine
; ======================================================
7662H  (CDH) CALL 765CH     ; Disable Background task & barcode interrupts
7665H  (06H) MVI B,00H
7667H  (CDH) CALL 7676H     ; Click sound port
766AH  (0EH) MVI C,50H
766CH  (CDH) CALL 7657H     ; Delay routine - decrement C until zero
766FH  (05H) DCR B
7670H  (C2H) JNZ 7667H
7673H  (C3H) JMP 743CH

; ======================================================
; Click sound port
; ======================================================
7676H  (DBH) IN BAH         ; Load current value of I/O port BAH
7678H  (EEH) XRI 20H        ; Toggle the speaker I/O bit
767AH  (D3H) OUT BAH        ; Write new value to speaker to cause a "click"
767CH  (C9H) RET

; ======================================================
; DVI Port Driver -- Get count of bytes received?
; ======================================================
767DH  (3AH) LDA FFFBH
7680H  (3CH) INR A
7681H  (C9H) RET

; ======================================================
; Check if bytes to receive from DVI??
; ======================================================
7682H  (21H) LXI H,FFFBH	; Pointer to bytes count received???
7685H  (DBH) IN 82H		; Read DVI STATUS byte
7687H  (E6H) ANI 07H		; Mask all but byte count???
7689H  (CAH) JZ 768FH       	; Jump to start transfer if data available???
768CH  (36H) MVI M,00H		; No bytes to read \C9 indicate Zero bytes transferred???
768EH  (C9H) RET

; ======================================================
; Optional external controller driver
; ======================================================
768FH  (B6H) ORA M		; Test if all bytes received?? (M = 0?)
7690H  (C0H) RNZ			; Return if M!=0 (all bytes not received?)
7691H  (36H) MVI M,FFH		; Prepare to receive 256 bytes?
7693H  (3EH) MVI A,C1H		; Prepare to send 0xC1 to DVI port 83H
7695H  (D3H) OUT 83H		; Send 0xC1 to DVI ort 83H
7697H  (DBH) IN 80H		; Get response from DVI
7699H  (3EH) MVI A,04H		; Prepare to send 04H to DVI port 81H
769BH  (D3H) OUT 81H		; Send 04H to DVI port 81H
769DH  (D3H) OUT 80H		; Send 04H to DVI port 80H
769FH  (C9H) RET

; ======================================================
; Send CMD 0 (??) to DVI
; ======================================================
76A0H  (CDH) CALL 767DH		; Get count of bytes received from DVI?
76A3H  (37H) STC			; Indicate more bytes to process
76A4H  (C0H) RNZ			; Return if in the middle of a transfer to/from DVI
76A5H  (3EH) MVI A,03H		; Load value of DVI CONTROl MAILBOX maybe??
76A7H  (32H) STA FFFAH		; Save in DVI MAILBOX SELECT area
76AAH  (AFH) XRA A		; Zero A
76ABH  (CDH) CALL 76DEH		; Send Zero to DVI CONTROL MAILBOX
76AEH  (CDH) CALL 76FBH		; Read response byte from DVI
76B1H  (07H) RLC			; Move upper 2 bits to lower
76B2H  (07H) RLC
76B3H  (E6H) AreaNI 03H		; Keep only the upper 2 bits
76B5H  (C9H) RET

76B6H  (3EH) MVI A,03H		; Load A with value to send to DVI Control port 81H
76B8H  (32H) STA FFFAH		; Save 03H as value to send to DVI Control port 81H
76BBH  (21H) LXI H,770BH	; Load address of Byte sequence to sent to DVI (2, 1, 0, 0, 1)
76BEH  (06H) MVI B,05H		; Prepare to send 5 bytes
76C0H  (7EH) MOV A,M		; Load next byte to send to DVI
76C1H  (CDH) CALL 76DEH		; Send byte to DVI
76C4H  (23H) INX H		; Increment to next byte in ROM table to send to DVI
76C5H  (05H) DCR B		; Decrement byte counter
76C6H  (C2H) JNZ 76C0H		; Loop until all bytes sent
76C9H  (CDH) CALL 76FBH		; Get response from DVI
76CCH  (B7H) ORA A		; Test if response is Zero
76CDH  (37H) STC
76CEH  (C0H) RNZ			; Return if the response is not zero
76CFH  (21H) LXI H,E000H	; Point to RAM address to receive hook routine from DVI
76D2H  (CDH) CALL 76FBH		; Read next byte from DVI
76D5H  (77H) MOV M,A		; Save next byte to RAM hook location
76D6H  (23H) INX H		; Increment to next RAM hook location
76D7H  (05H) DCR B		; Decrement byte counter
76D8H  (C2H) JNZ 76D2H		; Jump to read next byte if until all bytes read
76DBH  (C3H) JMP E000H


; ======================================================
; Wait for DVI TX EMPTY and send next byte???
; ======================================================
76DEH  (F5H) PUSH PSW		; Save the PSW
76DFH  (CDH) CALL 729FH     	; Check if SHIFT-BREAK is being pressed
76E2H  (DAH) JC 76F4H		; Jump to exit loop if SHIFT-BREAK pressed
76E5H  (DBH) IN 82H		; Get DVI status byte
76E7H  (07H) RLC			; Rotate DVI TX EMPTY bit (MSB) into C flag
76E8H  (D2H) JNC 76DFH		; Jump if not ready to keep waiting
76EBH  (3AH) LDA FFFAH		; Retrieve value to send to DVI port 81H
76EEH  (D3H) OUT 81H		; Send value in FFFAH (03H) to DVI port 81H
76F0H  (F1H) POP PSW		; Pop byte to be sent to DVI from stack
76F1H  (D3H) OUT 80H		; Send next byte to DVI
76F3H  (C9H) RET

; ======================================================
; SHIFT-BREAK Exit handler for DVI Read/Write loops
; ======================================================
76F4H  (F1H) POP PSW		; POP Write data from stack
76F5H  (F1H) POP PSW
76F6H  (CDH) CALL 7693H		; Re-initialize the DVI
76F9H  (37H) STC			; Indicate SHIFT-BREAK pressed
76FAH  (C9H) RET

; ======================================================
; Wait for DVI RX_FULL and read next byte from DVI??
; ======================================================
76FBH  (CDH) CALL 729FH		; Check if SHIFT-BREAK is being pressed
76FEH  (DAH) JC 76F5H		; Jump to exit if SHIFT-BREAK being pressed
7701H  (DBH) IN 82H		; Get DVI STATUS byte
7703H  (E6H) ANI 20H		; Test if RX_FULL bit is set
7705H  (CAH) JZ 76FBH		; Jump to keep waiting for RX_FULL to be set
7708H  (DBH) IN 80H		; Read data from DVI
770AH  (C9H) RET			; Return

770BH  DB   02H,01H,00H,00H,01H,00H

; ======================================================
; LCD char generator shape table (20H-7FH
; ======================================================
7711H  DB   00H,00H,00H,00H,00H,00H,00H,4FH
7719H  DB   00H,00H,00H,07H,00H,07H,00H,14H
7721H  DB   7FH,14H,7FH,14H,24H,2AH,7FH,2AH
7729H  DB   12H,23H,13H,08H,64H,62H,3AH,45H
7731H  DB   4AH,30H,28H,00H,04H,02H,01H,00H
7739H  DB   00H,1CH,22H,41H,00H,00H,41H,22H
7741H  DB   1CH,00H,22H,14H,7FH,14H,22H,08H
7749H  DB   08H,3EH,08H,08H,00H,80H,60H,00H
7751H  DB   00H,08H,08H,08H,08H,08H,00H,60H
7759H  DB   60H,00H,00H,40H,20H,10H,08H,04H
7761H  DB   3EH,51H,49H,45H,3EH,44H,42H,7FH
7769H  DB   40H,40H,62H,51H,51H,49H,46H,22H
7771H  DB   41H,49H,49H,36H,18H,14H,12H,7FH
7779H  DB   10H,47H,45H,45H,29H,11H,3CH,4AH
7781H  DB   49H,49H,30H,03H,01H,79H,05H,03H
7789H  DB   36H,49H,49H,49H,36H,06H,49H,49H
7791H  DB   29H,1EH,00H,00H,24H,00H,00H,00H
7799H  DB   80H,64H,00H,00H,08H,1CH,36H,63H
77A1H  DB   41H,14H,14H,14H,14H,14H,41H,63H
77A9H  DB   36H,1CH,08H,02H,01H,51H,09H,06H
77B1H  DB   32H,49H,79H,41H,3EH,7CH,12H,11H
77B9H  DB   12H,7CH,41H,7FH,49H,49H,36H,1CH
77C1H  DB   22H,41H,41H,22H,41H,7FH,41H,22H
77C9H  DB   1CH,7FH,49H,49H,49H,41H,7FH,09H
77D1H  DB   09H,09H,01H,3EH,41H,49H,49H,3AH
77D9H  DB   7FH,08H,08H,08H,7FH,00H,41H,7FH
77E1H  DB   41H,00H,30H,40H,41H,3FH,01H,7FH
77E9H  DB   08H,14H,22H,41H,7FH,40H,40H,40H
77F1H  DB   40H,7FH,02H,0CH,02H,7FH,7FH,06H
77F9H  DB   08H,30H,7FH,3EH,41H,41H,41H,3EH
7801H  DB   7FH,09H,09H,09H,06H,3EH,41H,51H
7809H  DB   21H,5EH,7FH,09H,19H,29H,46H,26H
7811H  DB   49H,49H,49H,32H,01H,01H,7FH,01H
7819H  DB   01H,3FH,40H,40H,40H,3FH,0FH,30H
7821H  DB   40H,30H,0FH,7FH,20H,18H,20H,7FH
7829H  DB   63H,14H,08H,14H,63H,07H,08H,78H
7831H  DB   08H,07H,61H,51H,49H,45H,43H,00H
7839H  DB   7FH,41H,41H,00H,04H,08H,10H,20H
7841H  DB   40H,00H,41H,41H,7FH,00H,04H,02H
7849H  DB   01H,02H,04H,40H,40H,40H,40H,40H
7851H  DB   00H,01H,02H,04H,00H,20H,54H,54H
7859H  DB   54H,78H,7FH,28H,44H,44H,38H,38H
7861H  DB   44H,44H,44H,28H,38H,44H,44H,28H
7869H  DB   7FH,38H,54H,54H,54H,18H,08H,08H
7871H  DB   7EH,09H,0AH,18H,A4H,A4H,98H,7CH
7879H  DB   7FH,04H,04H,04H,78H,00H,44H,7DH
7881H  DB   40H,00H,40H,80H,84H,7DH,00H,00H
7889H  DB   7FH,10H,28H,44H,00H,41H,7FH,40H
7891H  DB   00H,7CH,04H,78H,04H,78H,7CH,08H
7899H  DB   04H,04H,78H,38H,44H,44H,44H,38H
78A1H  DB   FCH,18H,24H,24H,18H,18H,24H,24H
78A9H  DB   18H,FCH,7CH,08H,04H,04H,08H,58H
78B1H  DB   54H,54H,54H,24H,04H,3FH,44H,44H
78B9H  DB   20H,3CH,40H,40H,3CH,40H,1CH,20H
78C1H  DB   40H,20H,1CH,3CH,40H,38H,40H,3CH
78C9H  DB   44H,28H,10H,28H,44H,1CH,A0H,A0H
78D1H  DB   90H,7CH,44H,64H,54H,4CH,44H,00H
78D9H  DB   08H,36H,41H,41H,00H,00H,77H,00H
78E1H  DB   00H,41H,41H,36H,08H,00H,02H,01H
78E9H  DB   02H,04H,02H,00H,00H,00H,00H,00H

; ======================================================
; LCD char generator shape table (80H-FFH)
; ======================================================
78F1H  DB   66H,77H,49H,49H,77H,66H,FCH,86H
78F9H  DB   D7H,EEH,FCH,00H,7FH,63H,14H,08H
7901H  DB   14H,00H,78H,76H,62H,4AH,0EH,00H
7909H  DB   EEH,44H,FFH,FFH,44H,EEH,0CH,4CH
7911H  DB   7FH,4CH,0CH,00H,7CH,56H,7FH,56H
7919H  DB   7CH,00H,7DH,77H,47H,77H,7FH,00H
7921H  DB   00H,00H,7DH,00H,00H,00H,10H,20H
7929H  DB   1CH,02H,02H,02H,54H,34H,1CH,16H
7931H  DB   15H,00H,41H,63H,55H,49H,63H,00H
7939H  DB   24H,12H,12H,24H,12H,00H,44H,44H
7941H  DB   5FH,44H,44H,00H,00H,40H,3EH,01H
7949H  DB   00H,00H,00H,08H,1CH,3EH,00H,00H
7951H  DB   98H,F4H,12H,12H,F4H,98H,F8H,94H
7959H  DB   12H,12H,94H,F8H,14H,22H,7FH,22H
7961H  DB   14H,00H,A0H,56H,3DH,56H,A0H,00H
7969H  DB   4CH,2AH,1DH,2AH,48H,00H,38H,28H
7971H  DB   39H,05H,03H,0FH,00H,16H,3DH,16H
7979H  DB   00H,00H,42H,25H,15H,28H,54H,22H
7981H  DB   04H,02H,3FH,02H,04H,00H,10H,20H
7989H  DB   7EH,20H,10H,00H,08H,08H,2AH,1CH
7991H  DB   08H,00H,08H,1CH,2AH,08H,08H,00H
7999H  DB   1CH,57H,61H,57H,1CH,00H,08H,14H
79A1H  DB   22H,14H,08H,00H,1EH,22H,44H,22H
79A9H  DB   1EH,00H,1CH,12H,71H,12H,1CH,00H
79B1H  DB   00H,04H,02H,01H,00H,00H,20H,55H
79B9H  DB   56H,54H,78H,00H,0EH,51H,31H,11H
79C1H  DB   0AH,00H,64H,7FH,45H,45H,20H,00H
79C9H  DB   00H,01H,02H,04H,00H,00H,7FH,10H
79D1H  DB   10H,0FH,10H,00H,00H,02H,05H,02H
79D9H  DB   00H,00H,04H,0CH,1CH,0CH,04H,00H
79E1H  DB   00H,04H,7FH,04H,00H,00H,18H,A7H
79E9H  DB   A5H,E5H,18H,00H,7FH,41H,65H,51H
79F1H  DB   7FH,00H,7FH,41H,5DH,49H,7FH,00H
79F9H  DB   17H,08H,34H,22H,71H,00H,55H,3FH
7A01H  DB   10H,68H,44H,E2H,17H,08H,04H,6AH
7A09H  DB   59H,00H,06H,09H,7FH,01H,7FH,01H
7A11H  DB   29H,2AH,7CH,2AH,29H,00H,70H,29H
7A19H  DB   24H,29H,70H,00H,38H,45H,44H,45H
7A21H  DB   38H,00H,3CH,41H,40H,41H,3CH,00H
7A29H  DB   1CH,22H,7FH,22H,14H,00H,08H,04H
7A31H  DB   04H,08H,04H,00H,20H,55H,54H,55H
7A39H  DB   78H,00H,30H,4AH,48H,4AH,30H,00H
7A41H  DB   3CH,41H,40H,21H,7CH,00H,40H,7FH
7A49H  DB   49H,49H,3EH,00H,71H,11H,67H,11H
7A51H  DB   71H,00H,38H,54H,56H,55H,18H,00H
7A59H  DB   3CH,41H,42H,20H,7CH,00H,38H,55H
7A61H  DB   56H,54H,18H,00H,00H,04H,00H,04H
7A69H  DB   00H,00H,48H,7EH,49H,01H,02H,00H
7A71H  DB   40H,AAH,A9H,AAH,F0H,00H,70H,AAH
7A79H  DB   A9H,AAH,30H,00H,00H,02H,E9H,02H
7A81H  DB   00H,00H,30H,4AH,49H,4AH,30H,00H
7A89H  DB   38H,42H,41H,22H,78H,00H,08H,04H
7A91H  DB   02H,04H,08H,00H,38H,55H,54H,55H
7A99H  DB   18H,00H,00H,02H,68H,02H,00H,00H
7AA1H  DB   20H,54H,56H,55H,7CH,00H,00H,00H
7AA9H  DB   6AH,01H,00H,00H,30H,48H,4AH,49H
7AB1H  DB   30H,00H,3CH,40H,42H,21H,7CH,00H
7AB9H  DB   0CH,50H,52H,51H,3CH,00H,7AH,11H
7AC1H  DB   09H,0AH,71H,00H,42H,A9H,A9H,AAH
7AC9H  DB   F1H,00H,32H,49H,49H,4AH,31H,00H
7AD1H  DB   E0H,52H,49H,52H,E0H,00H,F8H,AAH
7AD9H  DB   A9H,AAH,88H,00H,00H,8AH,F9H,8AH
7AE1H  DB   00H,00H,70H,8AH,89H,8AH,70H,00H
7AE9H  DB   78H,82H,81H,82H,78H,00H,00H,45H
7AF1H  DB   7CH,45H,00H,00H,7CH,55H,54H,55H
7AF9H  DB   44H,00H,7CH,54H,56H,55H,44H,00H
7B01H  DB   E0H,50H,4AH,51H,E0H,00H,00H,88H
7B09H  DB   FAH,89H,00H,00H,70H,88H,8AH,89H
7B11H  DB   70H,00H,3CH,40H,42H,41H,3CH,00H
7B19H  DB   0CH,10H,62H,11H,0CH,00H,3CH,41H
7B21H  DB   42H,40H,3CH,00H,7CH,55H,56H,54H
7B29H  DB   44H,00H,E0H,51H,4AH,50H,E0H,00H
7B31H  DB   00H,00H,00H,00H,00H,00H,0FH,0FH
7B39H  DB   0FH,00H,00H,00H,00H,00H,00H,0FH
7B41H  DB   0FH,0FH,F0H,F0H,F0H,00H,00H,00H
7B49H  DB   00H,00H,00H,F0H,F0H,F0H,0FH,0FH
7B51H  DB   0FH,F0H,F0H,F0H,F0H,F0H,F0H,0FH
7B59H  DB   0FH,0FH,0FH,0FH,0FH,0FH,0FH,0FH
7B61H  DB   F0H,F0H,F0H,F0H,F0H,F0H,FFH,FFH
7B69H  DB   FFH,00H,00H,00H,00H,00H,00H,FFH
7B71H  DB   FFH,FFH,FFH,FFH,FFH,0FH,0FH,0FH
7B79H  DB   0FH,0FH,0FH,FFH,FFH,FFH,FFH,FFH
7B81H  DB   FFH,F0H,F0H,F0H,F0H,F0H,F0H,FFH
7B89H  DB   FFH,FFH,FFH,FFH,FFH,FFH,FFH,FFH
7B91H  DB   00H,00H,F8H,08H,08H,08H,08H,08H
7B99H  DB   08H,08H,08H,08H,08H,08H,F8H,00H
7BA1H  DB   00H,00H,08H,08H,F8H,08H,08H,08H
7BA9H  DB   00H,00H,FFH,08H,08H,08H,00H,00H
7BB1H  DB   FFH,00H,00H,00H,00H,00H,0FH,08H
7BB9H  DB   08H,08H,08H,08H,0FH,00H,00H,00H
7BC1H  DB   08H,08H,0FH,08H,08H,08H,08H,08H
7BC9H  DB   FFH,00H,00H,00H,08H,08H,FFH,08H
7BD1H  DB   08H,08H,3FH,1FH,0FH,07H,03H,01H
7BD9H  DB   80H,C0H,E0H,F0H,F8H,FCH,01H,03H
7BE1H  DB   07H,0FH,1FH,3FH,FCH,F8H,F0H,E0H
7BE9H  DB   C0H,80H,55H,AAH,55H,AAH,55H,AAH

; ======================================================
; Keyboard conversion matrix
; ======================================================
7BF1H  DB   7AH,78H,63H,76H,62H,6EH,6DH,6CH
7BF9H  DB   61H,73H,64H,66H,67H,68H,6AH,6BH
7C01H  DB   71H,77H,65H,72H,74H,79H,75H,69H
7C09H  DB   6FH,70H,5BH,3BH,27H,2CH,2EH,2FH
7C11H  DB   31H,32H,33H,34H,35H,36H,37H,38H
7C19H  DB   39H,30H,2DH,3DH,5AH,58H,43H,56H
7C21H  DB   42H,4EH,4DH,4CH,41H,53H,44H,46H
7C29H  DB   47H,48H,4AH,4BH,51H,57H,45H,52H
7C31H  DB   54H,59H,55H,49H,4FH,50H,5DH,3AH
7C39H  DB   22H,3CH,3EH,3FH,21H,40H,23H,24H
7C41H  DB   25H,5EH,26H,2AH,28H,29H,5FH,2BH
7C49H  DB   00H,83H,84H,00H,95H,96H,81H,9AH
7C51H  DB   85H,8BH,00H,82H,00H,86H,00H,9BH
7C59H  DB   93H,94H,8FH,89H,87H,90H,91H,8EH
7C61H  DB   98H,80H,60H,92H,8CH,99H,97H,8AH
7C69H  DB   88H,9CH,9DH,9EH,9FH,B4H,B0H,A3H
7C71H  DB   7BH,7DH,5CH,8DH,E0H,EFH,FFH,00H
7C79H  DB   00H,00H,F6H,F9H,EBH,ECH,EDH,EEH
7C81H  DB   FDH,FBH,F4H,FAH,E7H,E8H,E9H,EAH
7C89H  DB   FCH,FEH,F0H,F3H,F2H,F1H,7EH,F5H
7C91H  DB   00H,F8H,F7H,00H,E1H,E2H,E3H,E4H
7C99H  DB   E5H,E6H,00H,00H,00H,00H,7CH,00H
7CA1H  DB   CEH,A1H,A2H,BDH,00H,CDH,00H,CAH
7CA9H  DB   B6H,A9H,BBH,00H,00H,00H,CBH,C9H
7CB1H  DB   C8H,00H,C6H,00H,00H,CCH,B8H,C7H
7CB9H  DB   B7H,ACH,B5H,ADH,A0H,BCH,CFH,AEH
7CC1H  DB   C0H,00H,C1H,00H,00H,00H,C4H,C2H
7CC9H  DB   C3H,AFH,C5H,BEH,00H,DFH,ABH,DEH
7CD1H  DB   00H,00H,A5H,DAH,B1H,B9H,D7H,BFH
7CD9H  DB   00H,00H,DBH,D9H,D8H,00H,D6H,AAH
7CE1H  DB   BAH,DCH,B3H,D5H,B2H,00H,00H,00H
7CE9H  DB   A4H,DDH,00H,00H,D0H,00H,D1H,00H
7CF1H  DB   00H,00H,D4H,D2H,D3H,A6H,A7H,A8H
7CF9H  DB   6DH,30H,6AH,31H,6BH,32H,6CH,33H
7D01H  DB   75H,34H,69H,35H,6FH,36H,01H,06H
7D09H  DB   14H,02H,20H,7FH,09H,1BH,8BH,88H
7D11H  DB   8AH,0DH,80H,81H,82H,83H,84H,85H
7D19H  DB   86H,87H,1DH,1CH,1EH,1FH,20H,08H
7D21H  DB   09H,1BH,8BH,88H,89H,0DH,80H,81H
7D29H  DB   82H,83H,84H,85H,86H,87H,51H,52H
7D31H  DB   57H,5AH

; ======================================================
; Boot routine
; ======================================================
7D33H  (F3H) DI             ; Disable interrupts during boot
7D34H  (31H) LXI SP,FCC0H   ; SP in a safe place - Start of Alt LCD character buffer
7D37H  (21H) LXI H,2710H    ; Load 16-bit delay factor
7D3AH  (2BH) DCX H          ; Decrement delay counter
7D3BH  (7CH) MOV A,H        ; Load H to A to test for zero
7D3CH  (B5H) ORA L          ; OR in LSB of count
7D3DH  (C2H) JNZ 7D3AH      ; Jump if not zero to delay upon power-up
7D40H  (3EH) MVI A,43H      ; Load configuration for PIO (A=OUT, B=OUT, C=IN, Stop Timer counter)
7D42H  (D3H) OUT B8H        ; Set PIO chip configuration
7D44H  (3EH) MVI A,ECH      ; PIO B configuration (RTS low, DTR low, SPKR=1, Serial=Modem, Keyscan col 9 enable)
7D46H  (D3H) OUT BAH        ; Set PIO chip port B configuration
7D48H  (3EH) MVI A,FFH      ; PIO A configuration (Used for Key scan, LCD data, etc.)
7D4AH  (D3H) OUT B9H        ; Initialize PIO chip port A
7D4CH  (DBH) IN E8H         ; Scan Keyboard to test for CTRL-BREAK (cold boot indicator)
7D4EH  (E6H) ANI 82H        ; Mask all but CTRL-BREAK keys
7D50H  (3EH) MVI A,EDH      ; Load code to disable key-scan col 9 (for CTRL-BREAK)
7D52H  (D3H) OUT BAH        ; Disable key-scan col 9
7D54H  (CAH) JZ 7DE7H       ; Jump to Cold boot routine if CTRL-BREAK pressed
7D57H  (2AH) LHLD F5F0H     ; Active system signature -- Warm vs Cold boot
7D5AH  (11H) LXI D,8A4DH    ; Compare value to test if cold boot needed
7D5DH  (DFH) RST 3          ; Compare DE and HL
7D5EH  (C2H) JNZ 7DE7H      ; Cold boot routine
7D61H  (3AH) LDA FAC1H      ; Load MSB of lowest known RAM address
7D64H  (57H) MOV D,A        ; Save value of last physical RAM
7D65H  (CDH) CALL 7EE1H     ; Calculate physical RAM available
7D68H  (BAH) CMP D          ; Test if more or less RAM than last boot-up
7D69H  (C2H) JNZ 7DE7H      ; Jump to Cold boot routine if RAM size changed
7D6CH  (CDH) CALL F605H     ; Call RAM routine to Detect Option ROM (copied to RAM by cold-boot)
7D6FH  (3EH) MVI A,00H      ; Indicate no Option ROM detected
7D71H  (C2H) JNZ 7D75H      ; Jump if it's really true to skip DEC
7D74H  (3DH) DCR A          ; Indicate OptROM detected
7D75H  (21H) LXI H,F62AH    ; Point to Option ROM flag
7D78H  (BEH) CMP M          ; Test if option ROM added or removed
7D79H  (C2H) JNZ 7DE7H      ; Cold boot routine
7D7CH  (2AH) LHLD F5F2H     ; Load signature for Auto Poweroff
7D7FH  (EBH) XCHG           ; Put signature in DE
7D80H  (21H) LXI H,0000H    ; Prepare to clear signature for Auto Poweroff
7D83H  (22H) SHLD F5F2H     ; Clear signature for Auto Poweroff
7D86H  (21H) LXI H,9C0BH    ; Load comparison signature saved by Auto Poweroff
7D89H  (DFH) RST 3          ; Compare DE and HL - Test if last power off was Auto Poweroff
7D8AH  (C2H) JNZ 7DA8H      ; 
7D8DH  (2AH) LHLD FABEH     ; SP save area for power up/down
7D90H  (F9H) SPHL
7D91H  (CDH) CALL F5F6H     ; Call Boot-up Hook
7D94H  (CDH) CALL 7DD0H
7D97H  (2AH) LHLD FFF8H
7D9AH  (E5H) PUSH H
7D9BH  (CDH) CALL 4601H
7D9EH  (E1H) POP H
7D9FH  (7CH) MOV A,H
7DA0H  (A7H) ANA A
7DA1H  (CAH) JZ 14EDH       ; Pop AF, BC, DE, HL from stack
7DA4H  (F9H) SPHL
7DA5H  (C3H) JMP 7435H

7DA8H  (3AH) LDA F651H      ; In TEXT because of BASIC EDIT flag
7DABH  (A7H) ANA A
7DACH  (CAH) JZ 7DBBH
7DAFH  (CDH) CALL 7DD0H
7DB2H  (CDH) CALL 5D53H
7DB5H  (CDH) CALL 4601H
7DB8H  (C3H) JMP 5FDDH      ; Main TEXT edit loop

7DBBH  (21H) LXI H,FAAFH    ; Start of IPL filename
7DBEH  (22H) SHLD F62CH     ; Save as simulated "FKey text" to be entered
7DC1H  (2AH) LHLD F678H     ; BASIC string buffer pointer
7DC4H  (F9H) SPHL
7DC5H  (CDH) CALL F5F6H     ; Call Boot-up Hook
7DC8H  (CDH) CALL 3F6DH
7DCBH  (21H) LXI H,5797H
7DCEH  (E5H) PUSH H
7DCFH  (F6H) ORI AFH
7DD1H  (CDH) CALL 6CE0H     ; Warm start reset entry
7DD4H  (AFH) XRA A
7DD5H  (32H) STA F656H      ; Power off exit condition switch
7DD8H  (3AH) LDA FF43H      ; RS232 initialization status
7DDBH  (A7H) ANA A
7DDCH  (C8H) RZ
7DDDH  (21H) LXI H,F65AH    ; RS232 auto linefeed switch
7DE0H  (D7H) RST 2          ; Get next non-white char from M
7DE1H  (D4H) CNC 3457H      ; Increment HL and return
7DE4H  (C3H) JMP 17E6H      ; Set RS232 parameters from string at M

; ======================================================
; Cold boot routine
; ======================================================
7DE7H  (31H) LXI SP,F5E6H   ; Load the SP with Cold Boot location
7DEAH  (CDH) CALL 7EE1H     ; Calculate physical RAM available
7DEDH  (06H) MVI B,90H      ; Prepare to copy 90H bytes of code to RAM
7DEFH  (11H) LXI D,F5F0H    ; Active system signature -- Warm vs Cold boot
7DF2H  (21H) LXI H,035AH    ; Initialization image loaded to F5F0H
7DF5H  (CDH) CALL 2542H     ; Move B bytes from M to (DE) - hooks & signatures
7DF8H  (CDH) CALL 7EC6H     ; Initialize RST 38H RAM vector table
7DFBH  (3EH) MVI A,0CH
7DFDH  (32H) STA F930H
7E00H  (3EH) MVI A,64H
7E02H  (32H) STA F931H
7E05H  (21H) LXI H,5B46H    ; Point to Function key labels for BASIC
7E08H  (CDH) CALL 5A7CH     ; Set new function key table
7E0BH  (CDH) CALL 6C93H     ; Copy BASIC Function key table to key definition area
7E0EH  (06H) MVI B,58H
7E10H  (11H) LXI D,6BF1H    ; ROM programs catalog entries
7E13H  (21H) LXI H,F962H    ; Start of RAM directory
7E16H  (CDH) CALL 3469H     ; Move B bytes from (DE) to M with increment
7E19H  (06H) MVI B,D1H      ; Length of RAM directory (19 entries x 11 bytes)
7E1BH  (AFH) XRA A          ; Prepare to zero out RAM directory
7E1CH  (77H) MOV M,A        ; Zero out next byte of RAM directory
7E1DH  (23H) INX H          ; Increment to next RAM directory location
7E1EH  (05H) DCR B          ; Decrement counter
7E1FH  (C2H) JNZ 7E1CH      ; Loop until all bytes zeroed
7E22H  (36H) MVI M,FFH
7E24H  (CDH) CALL F605H     ; Detect Option ROM
7E27H  (C2H) JNZ 7E43H
7E2AH  (3DH) DCR A
7E2BH  (32H) STA F62AH      ; Option ROM flag
7E2EH  (21H) LXI H,F9BAH
7E31H  (36H) MVI M,F0H
7E33H  (23H) INX H
7E34H  (23H) INX H
7E35H  (23H) INX H
7E36H  (11H) LXI D,FAA6H
7E39H  (06H) MVI B,06H
7E3BH  (CDH) CALL 3469H     ; Move B bytes from (DE) to M with increment
7E3EH  (36H) MVI M,20H
7E40H  (23H) INX H
7E41H  (36H) MVI M,00H
7E43H  (AFH) XRA A
7E44H  (32H) STA F787H
7E47H  (32H) STA FCA7H
7E4AH  (CDH) CALL 1A96H     ; Erase current IPL program
7E4DH  (32H) STA F932H
7E50H  (3EH) MVI A,3AH
7E52H  (32H) STA F680H      ; End of statement marker
7E55H  (21H) LXI H,FBD4H
7E58H  (22H) SHLD FBD9H
7E5BH  (22H) SHLD F678H     ; BASIC string buffer pointer
7E5EH  (22H) SHLD FB67H     ; File buffer area pointer
7E61H  (3EH) MVI A,01H
7E63H  (32H) STA FBB3H
7E66H  (CDH) CALL 7F2BH
7E69H  (CDH) CALL 3F6DH
7E6CH  (2AH) LHLD FAC0H     ; Lowest RAM address used by system
7E6FH  (AFH) XRA A
7E70H  (77H) MOV M,A
7E71H  (23H) INX H
7E72H  (22H) SHLD F67CH     ; Start of BASIC program pointer
7E75H  (22H) SHLD F99AH     ; BASIC program not saved pointer
7E78H  (77H) MOV M,A
7E79H  (23H) INX H
7E7AH  (77H) MOV M,A
7E7BH  (23H) INX H
7E7CH  (22H) SHLD FBAEH     ; Start of DO files pointer
7E7FH  (22H) SHLD F9A5H     ; Start of Paste Buffer
7E82H  (36H) MVI M,1AH
7E84H  (23H) INX H
7E85H  (22H) SHLD FBB0H     ; Start of CO files pointer
7E88H  (22H) SHLD FBB2H     ; Start of variable data pointer
7E8BH  (21H) LXI H,F999H
7E8EH  (22H) SHLD FA8CH
7E91H  (CDH) CALL 20FFH     ; NEW statement
7E94H  (CDH) CALL 6CD6H     ; Re-initialize system without destroying files
7E97H  (21H) LXI H,0000H
7E9AH  (22H) SHLD F92DH     ; Year (ones)
7E9DH  (21H) LXI H,7F01H    ; Initial clock chip register values
7EA0H  (CDH) CALL 732AH     ; Update clock chip regs from M
7EA3H  (C3H) JMP 5797H      ; MENU Program

; ======================================================
; Display TRS-80 Model number & Free bytes on LCD
; ======================================================
7EA6H  (21H) LXI H,7FA4H    ; TRS-80 model number string
7EA9H  (CDH) CALL 27B1H     ; Print buffer at M until NULL or '"'

; ======================================================
; Display number of free bytes on LCD
; ======================================================
7EACH  (2AH) LHLD FBB2H     ; Start of variable data pointer
7EAFH  (EBH) XCHG
7EB0H  (2AH) LHLD F678H     ; BASIC string buffer pointer
7EB3H  (7DH) MOV A,L        ;
7EB4H  (93H) SUB E          ;
7EB5H  (6FH) MOV L,A        ;   Calculate difference between BASIC String
7EB6H  (7CH) MOV A,H        ;     buffer area and Start of Variable data
7EB7H  (9AH) SBB D          ;     area.  This is the free space.
7EB8H  (67H) MOV H,A        ;
7EB9H  (01H) LXI B,FFF2H    ; Load value for (-14)
7EBCH  (09H) DAD B          ; Subtract 14 from reported Free space
7EBDH  (CDH) CALL 39D4H     ; Print binary number in HL at current position
7EC0H  (21H) LXI H,7F98H    ; MENU Text Strings
7EC3H  (C3H) JMP 27B1H      ; Print buffer at M until NULL or '"'

; ======================================================
; Initialize RST 38H RAM vector table
; ======================================================
7EC6H  (21H) LXI H,FADAH    ; Start of RST 38H vector table
7EC9H  (01H) LXI B,1D02H
7ECCH  (11H) LXI D,7FF3H
7ECFH  (73H) MOV M,E
7ED0H  (23H) INX H
7ED1H  (72H) MOV M,D
7ED2H  (23H) INX H
7ED3H  (05H) DCR B
7ED4H  (C2H) JNZ 7ECFH
7ED7H  (06H) MVI B,13H
7ED9H  (11H) LXI D,08DBH
7EDCH  (0DH) DCR C
7EDDH  (C2H) JNZ 7ECFH
7EE0H  (C9H) RET

; ======================================================
; Calculate physical RAM available
; ======================================================
7EE1H  (21H) LXI H,C000H    ; Ram modules start at High memory (8K chunks)
7EE4H  (7EH) MOV A,M        ; Load current value at this address
7EE5H  (2FH) CMA            ; Compliment the value
7EE6H  (77H) MOV M,A        ; And write it back (non-destructive test)
7EE7H  (BEH) CMP M          ; Compare if the value "took" (i.e. there's RAM there)
7EE8H  (2FH) CMA            ; Compliment data back to original value
7EE9H  (77H) MOV M,A        ; Save original value (in case there IS RAM there)
7EEAH  (7CH) MOV A,H        ; Load MSB of current RAM bank to A
7EEBH  (C2H) JNZ 7EF8H      ; Jump if no RAM present in this bank
7EEEH  (2CH) INR L          ; Increment LSB of RAM (test 256 bytes per 8K)
7EEFH  (C2H) JNZ 7EE4H      ; Jump to test next byte of this RAM
7EF2H  (D6H) SUI 20H        ; Decrement to next lower 8K memory range
7EF4H  (67H) MOV H,A        ; Save the new MSB of this 8K range
7EF5H  (FAH) JM 7EE4H       ; Jump back to test if RAM in this memory range

; ======================================================
; Lowest RAM location found
; ======================================================
7EF8H  (2EH) MVI L,00H      ; Clear LSB of lowest RAM address
7EFAH  (C6H) ADI 20H        ; Add 8K back to address (we over shot)
7EFCH  (67H) MOV H,A        ; Save MSB of lowest RAM address with RAM in it
7EFDH  (22H) SHLD FAC0H     ; Save as Lowest RAM address used by system
7F00H  (C9H) RET

; ======================================================
; Initial clock chip register values
; ======================================================
7F01H  DB   00H,00H,00H,00H,00H,00H,01H,00H
7F09H  DB   00H,01H,CFH,9DH,CFH,DDH

7F0FH  (CDH) CALL 112EH     ; Evaluate expression (0-255) at M-1
7F12H  (C2H) JNZ 0446H      ; Generate Syntax error
7F15H  (FEH) CPI 10H
7F17H  (D2H) JNC 08DBH      ; Generate FC error
7F1AH  (22H) SHLD FB99H     ; Address of last variable assigned
7F1DH  (F5H) PUSH PSW
7F1EH  (CDH) CALL 4E22H
7F21H  (F1H) POP PSW
7F22H  (CDH) CALL 7F2BH
7F25H  (CDH) CALL 3F2FH
7F28H  (C3H) JMP 0804H      ; Execute BASIC program

7F2BH  (F5H) PUSH PSW
7F2CH  (2AH) LHLD F5F4H     ; HIMEM
7F2FH  (11H) LXI D,FEF5H
7F32H  (19H) DAD D
7F33H  (3DH) DCR A
7F34H  (F2H) JP 7F32H
7F37H  (EBH) XCHG
7F38H  (2AH) LHLD F678H     ; BASIC string buffer pointer
7F3BH  (44H) MOV B,H
7F3CH  (4DH) MOV C,L
7F3DH  (2AH) LHLD FB67H     ; File buffer area pointer
7F40H  (7DH) MOV A,L
7F41H  (91H) SUB C
7F42H  (6FH) MOV L,A
7F43H  (7CH) MOV A,H
7F44H  (98H) SBB B
7F45H  (67H) MOV H,A
7F46H  (F1H) POP PSW
7F47H  (E5H) PUSH H
7F48H  (F5H) PUSH PSW
7F49H  (01H) LXI B,008CH
7F4CH  (09H) DAD B
7F4DH  (44H) MOV B,H
7F4EH  (4DH) MOV C,L
7F4FH  (2AH) LHLD FBB2H     ; Start of variable data pointer
7F52H  (09H) DAD B
7F53H  (DFH) RST 3          ; Compare DE and HL
7F54H  (D2H) JNC 3F17H
7F57H  (F1H) POP PSW
7F58H  (32H) STA FC82H      ; Maxfiles
7F5BH  (6BH) MOV L,E
7F5CH  (62H) MOV H,D
7F5DH  (22H) SHLD FC83H     ; File number description table pointer
7F60H  (2BH) DCX H
7F61H  (2BH) DCX H
7F62H  (22H) SHLD FB67H     ; File buffer area pointer
7F65H  (C1H) POP B
7F66H  (7DH) MOV A,L
7F67H  (91H) SUB C
7F68H  (6FH) MOV L,A
7F69H  (7CH) MOV A,H
7F6AH  (98H) SBB B
7F6BH  (67H) MOV H,A
7F6CH  (22H) SHLD F678H     ; BASIC string buffer pointer
7F6FH  (2BH) DCX H
7F70H  (2BH) DCX H
7F71H  (C1H) POP B
7F72H  (F9H) SPHL
7F73H  (C5H) PUSH B
7F74H  (3AH) LDA FC82H      ; Maxfiles
7F77H  (6FH) MOV L,A
7F78H  (2CH) INR L
7F79H  (26H) MVI H,00H
7F7BH  (29H) DAD H
7F7CH  (19H) DAD D
7F7DH  (EBH) XCHG
7F7EH  (D5H) PUSH D
7F7FH  (01H) LXI B,0109H
7F82H  (73H) MOV M,E
7F83H  (23H) INX H
7F84H  (72H) MOV M,D
7F85H  (23H) INX H
7F86H  (EBH) XCHG
7F87H  (36H) MVI M,00H
7F89H  (09H) DAD B
7F8AH  (EBH) XCHG
7F8BH  (3DH) DCR A
7F8CH  (F2H) JP 7F82H
7F8FH  (E1H) POP H
7F90H  (01H) LXI B,0009H
7F93H  (09H) DAD B
7F94H  (22H) SHLD FC87H
7F97H  (C9H) RET

; ======================================================
; MENU Text Strings
; ======================================================
7F98H  DB   " Bytes free",00H
7FA4H  DB   "TRS-80 Model 100 Software",0DH,0AH
7FBFH  DB   "Copr. 1983 Microsoft",0DH,0AH,00H

; ======================================================
; RST 38H RAM vector driver routine
; ======================================================
7FD6H  (E3H) XTHL
7FD7H  (F5H) PUSH PSW
7FD8H  (7EH) MOV A,M
7FD9H  (32H) STA FAC9H      ; Offset of last RST 38H call
7FDCH  (F1H) POP PSW
7FDDH  (23H) INX H
7FDEH  (E3H) XTHL
7FDFH  (E5H) PUSH H
7FE0H  (C5H) PUSH B
7FE1H  (F5H) PUSH PSW
7FE2H  (21H) LXI H,FADAH    ; Start of RST 38H vector table
7FE5H  (3AH) LDA FAC9H      ; Offset of last RST 38H call
7FE8H  (4FH) MOV C,A
7FE9H  (06H) MVI B,00H
7FEBH  (09H) DAD B
7FECH  (7EH) MOV A,M
7FEDH  (23H) INX H
7FEEH  (66H) MOV H,M
7FEFH  (6FH) MOV L,A
7FF0H  (F1H) POP PSW
7FF1H  (C1H) POP B
7FF2H  (E3H) XTHL
7FF3H  (C9H) RET

7FF4H  (CDH) CALL 35BAH     ; CDBL function
7FF7H  (C3H) JMP 31B5H      ; Move FAC1 to FAC2

7FFAH  (00H) NOP
7FFBH  (00H) NOP
7FFCH  (00H) NOP
7FFDH  (00H) NOP
7FFEH  (00H) NOP
7FFFH  (00H) NOP