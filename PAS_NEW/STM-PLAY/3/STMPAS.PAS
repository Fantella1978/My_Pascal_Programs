(*************************************************)
(*     STMPAS.PAS - Unit for Pascal 6.0 & 7.0    *)
(*   Loading and playing Scream Tracker module   *)
(*  Disassembled and adapted for Borland Pascal  *)
(*              Leha Suslov 1993                 *)
(*  Other copyrights see in Copyright variable.  *)
(*************************************************)
Unit   stmPas;
Interface
{$undef DEBUG}
type
  STMheader = record
    Name   : Array[0..19] of Char;
    Zagol  : Array[0..7] of Char;
    ESC    : Char;
    ModType: Byte;
    Vers_LO: Byte;
    Vers_HI: Byte;
    GLTempo: Byte;
    NPatterns: Byte;
    GLVolume : Byte;
  {  Pad    : Array[0..12] of Char;}
  end;

{$ifdef VER60}
type
  FNameStr = String[80];

function  _load_music(FileName: FNameStr; Speed, Device: Integer):Integer;
{$else}
function  _load_music(FileName: PChar; Speed, Device: Integer):Integer;
{$endif}
procedure _unload_music;
procedure _start_music;
procedure _stop_music;


type
  PtrRec = record
    Ofs, Seg: Word;
  end;

const
{;===========================================;
;          >>>  D A T A   <<<               ;
;===========================================;}
unknown   : Word = 0;
fHandle : Word = 0;
HeapSeg : Word = 0;
data_02B4 : Word = 0;
data_02B6 : Array[0..1] of Pointer =(nil,nil);
_ready_char    : Word = 0;
_scan_code     : Word = 0;


Head : StmHeader=(
Name      : '                    ';
Zagol     : '        ';
ESC       : #$1B;
ModType   : $02;
Vers_LO   : $02;
Vers_HI   : $15;
GLTempo   :  $60;
NPatterns : $0c;
GLVolume  : $40);
{Pad       : '             ');}

data_02C9 : Byte = $00;
data_02CA : Word = $03e7;
SpeedTable : Array [0..2] of Word =($26d7, $2e9c, $3e25);
data_02D2 : Word = $26d7;
data_02D4 : Word = 0{ofs(CoeffTable)};
data_02D6 : Word = $0006;
data_02D8 : Byte = $00;
data_02D9 : Word = $0000;
data_02DB : Byte = $0a;
data_02DC : Byte = $01;
data_02DD : Byte = $01;
data_02DE : Byte = $00;
data_02DF : Word = $0000;
data_02E1 : Word = $0000;
data_02E3 : Word = $0000;
data_02E5 : Word = $0144;
data_02E7 : Word = $0144;
data_02E9 : Word = $0101;
data_02EB : Word = $0100;
data_02ED : Word = $0100;
data_02EF : Word = $0100;
data_02F1 : Word = 0{offset data_4C03};
data_02F3 : Word = 0{offset data_4C03};
data_02F5 : Word = $0000;
data_02F7 : Word = $0000;
data_02F9 : Word = $0000;
{Portions Copyright}
CopyRight : Array[0..83] of Char =
'Scream Tracker library. 1992-10-11. '+
'Alex Kicelew and Anthony Labunsky. Beta version.';
data_034F : Array[0..31] of Byte =
          ($b8,$42,$8c,$3e,$50,$3b,$9c,
           $37,$60,$35,$08,$32,$e8,$2e,$7c,
           $2c,$b4,$29,$08,$28,$88,$25,$94,
           $23,$00,$00,$00,$00,$00,$00,$00,
           $00);
CoeffTable : Array[0..2,0..255] of Byte =
            (($02,$02,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$03,$03,$03,
          $04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$06,
          $06,$06,$06,$06,$06,$06,$07,$07,$07,$07,$07,$07,$07,$07,$08,$08,
          $08,$08,$08,$08,$08,$09,$09,$09,$09,$09,$09,$09,$09,$0a,$0a,$0a,
          $0a,$0a,$0a,$0a,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0c,$0c,$0c,$0c,
          $0c,$0c,$0c,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0e,$0e,$0e,$0e,$0e,
          $0e,$0f,$0f,$0f,$10,$10,$11,$11,$12,$13,$14,$15,$16,$17,$18,$19,
          $1b,$1c,$1d,$1f,$20,$22,$24,$25,$27,$29,$2b,$2d,$2e,$30,$32,$34,
          $36,$38,$3a,$3c,$3e,$40,$42,$44,$46,$48,$4a,$4c,$4e,$50,$52,$54,
          $55,$57,$59,$5a,$5c,$5e,$5f,$61,$62,$63,$64,$66,$67,$68,$69,$6a,
          $6b,$6b,$6b,$6c,$6c,$6c,$6c,$6c,$6c,$6c,$6d,$6d,$6d,$6d,$6d,$6d,
          $6d,$6d,$6e,$6e,$6e,$6e,$6e,$6e,$6e,$6f,$6f,$6f,$6f,$6f,$6f,$6f,
          $6f,$70,$70,$70,$70,$70,$70,$70,$71,$71,$71,$71,$71,$71,$71,$71,
          $72,$72,$72,$72,$72,$72,$72,$73,$73,$73,$73,$73,$73,$73,$73,$74,
          $74,$74,$74,$74,$74,$74,$75,$75,$75,$75,$75,$75,$75,$75,$76,$76,
          $76,$76,$76,$76,$76,$77,$77,$77,$77,$77,$77,$77,$77,$78,$78,$78,
          $78),
{data_046F}  ($01,$01,$02,$02,$02,$02,$02,$02,$02,$02,$02,$03,$03,$03,$03,
          $03,$03,$03,$03,$03,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,
          $05,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06,$06,$06,$06,$06,
          $07,$07,$07,$07,$07,$07,$07,$07,$07,$08,$08,$08,$08,$08,$08,$08,
          $08,$08,$09,$09,$09,$09,$09,$09,$09,$09,$09,$0a,$0a,$0a,$0a,$0a,
          $0a,$0a,$0a,$0a,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0c,$0c,$0c,
          $0c,$0c,$0c,$0d,$0d,$0d,$0e,$0e,$0f,$10,$10,$11,$12,$13,$14,$15,
          $16,$17,$18,$1a,$1b,$1c,$1e,$1f,$21,$22,$24,$25,$27,$28,$2a,$2b,
          $2d,$2f,$30,$32,$34,$35,$37,$39,$3a,$3c,$3e,$3f,$41,$43,$44,$46,
          $47,$49,$4a,$4b,$4d,$4e,$4f,$50,$52,$53,$54,$55,$56,$57,$57,$58,
          $59,$59,$5a,$5a,$5a,$5a,$5a,$5a,$5a,$5a,$5a,$5b,$5b,$5b,$5b,$5b,
          $5b,$5b,$5b,$5b,$5c,$5c,$5c,$5c,$5c,$5c,$5c,$5c,$5c,$5d,$5d,$5d,
          $5d,$5d,$5d,$5d,$5d,$5d,$5e,$5e,$5e,$5e,$5e,$5e,$5e,$5e,$5e,$5f,
          $5f,$5f,$5f,$5f,$5f,$5f,$5f,$5f,$60,$60,$60,$60,$60,$60,$60,$60,
          $60,$61,$61,$61,$61,$61,$61,$61,$61,$61,$62,$62,$62,$62,$62,$62,
          $62,$62,$62,$63,$63,$63,$63,$63,$63,$63,$63,$63,$64,$64,$64,$64,
          $64),
{data_056F}  ($01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$02,$02,
          $02,$02,$02,$02,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$04,
          $04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,
          $05,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06,$06,$06,$06,$06,
          $06,$06,$06,$06,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$08,
          $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$09,$09,$09,$09,
          $09,$09,$09,$0a,$0a,$0a,$0a,$0b,$0b,$0c,$0c,$0d,$0e,$0e,$0f,$10,
          $11,$11,$12,$13,$14,$15,$16,$17,$18,$1a,$1b,$1c,$1d,$1e,$1f,$21,
          $22,$23,$24,$26,$27,$28,$29,$2b,$2c,$2d,$2e,$30,$31,$32,$33,$34,
          $35,$36,$37,$39,$3a,$3a,$3b,$3c,$3d,$3e,$3f,$40,$40,$41,$42,$42,
          $43,$43,$43,$43,$43,$43,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,
          $44,$44,$44,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$46,$46,
          $46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$47,$47,$47,$47,$47,
          $47,$47,$47,$47,$47,$47,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,
          $48,$48,$48,$49,$49,$49,$49,$49,$49,$49,$49,$49,$49,$49,$4a,$4a,
          $4a,$4a,$4a,$4a,$4a,$4a,$4a,$4a,$4a,$4a,$4a,$4b,$4b,$4b,$4b,$4b,
          $4b));
data_066F : Array [0..7] of Byte =($01,$00,$01,$00,$01,$00,$01,$00);
data_0677 : Array [0..7] of Byte =($ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff);
data_067F : Array [0..127] of Byte =
         ($00,$00,$18,$00,$31,$00,$4a,$00,$61,$00,$78,$00,$8d,$00,$0a1,
          $00,$0b4,$00,$0c5,$00,$0d4,$00,$0e0,$00,$0eb,$00,$0f4,$00,$0fa,$00,$0fd,
          $00,$0ff,$00,$0fd,$00,$0fa,$00,$0f4,$00,$0eb,$00,$0e0,$00,$0d4,$00,$0c5,
          $00,$0b4,$00,$0a1,$00,$8d,$00,$78,$00,$61,$00,$4a,$00,$31,$00,$18,
          $00,$00,$00,$0e8,$0ff,$0cf,$0ff,$0b6,$0ff,$9f,$0ff,$88,$0ff,$73,$0ff,$5f,
          $0ff,$4c,$0ff,$3b,$0ff,$2c,$0ff,$20,$0ff,$15,$0ff,$0c,$0ff,$06,$0ff,$03,
          $0ff,$01,$0ff,$03,$0ff,$06,$0ff,$0c,$0ff,$15,$0ff,$20,$0ff,$2c,$0ff,$3b,
          $0ff,$4c,$0ff,$5f,$0ff,$73,$0ff,$88,$0ff,$9f,$0ff,$0b6,$0ff,$0cf,$0ff,$0e8,
          $0ff);

{var
  _loud : Word absolute Head.GLVolume;}

Implementation
{;===========================================;
;    >>>  UnInitialised  D A T A   <<<      ;
;===========================================;}
var
data_06FF    : Array[0..3] of Byte;
data_0703    : Array[0..16607] of Byte;
data_47E3    : Array[0..31] of Byte;
data_4803    : Array[0..1023] of Byte;
data_4C03    : Array[0..127] of Byte;
data_4C83    : Word;
data_4C85    : Word;
data_4C87    : Word;
data_4C89    : Word;
data_4C8B    : Word;
data_4C8D    : Word;
data_4C8F    : Word;
data_4C91    : Word;
data_4C93    : Word;
data_4C95    : Word;
data_4C97    : Word;
data_4C99    : Word;
data_4C9B    : Word;
data_4C9D    : Word;
data_4C9F    : Word;
data_4CA1    : Word;
data_4CA3    : Word;
data_4CA5    : Word;
data_4CA7    : Word;
data_4CA9    : Word;
data_4CAB    : Array[0..3] of Word;
data_4CB3    : Word;
data_4CB5    : Word;
data_4CB7    : Word;
data_4CB9    : Word;
data_4CBB    : Word;
data_4CBD    : Word;
data_4CBF    : Word;
data_4CC1    : Word;
data_4CC3    : Word;
data_4CC5    : Word;
data_4CC7    : Word;
data_4CC9    : Word;
data_4CCB    : Word;
data_4CCD    : Word;
data_4CCF    : Word;
data_4CD1    : Word;
data_4CD3    : Array[0..3] of Word;
data_4CDB    : Pointer;
data_4CDF    : Pointer;
data_4CE3    : Pointer;
data_4CE7    : Pointer;
data_4CEB    : Array[0..3] of Word;
data_4CF3    : Array[0..3] of Word;
data_4CFB    : Array[0..3] of Word;
data_4D03    : Array[0..3] of Word;
data_4D0B    : Array[0..3] of Word;
data_4D13    : Array[0..15] of Word;
data_4D33    : Array[0..127] of Byte;
data_4DB3    : Array[0..3] of Word;
data_4DBB    : Array[0..3] of Word;
data_4DC3    : Array[0..3] of Word;
data_4DCB    : Array[0..3] of Word;
data_4DD3    : Array[0..3] of Word;
data_4DDB    : Array[0..71] of Byte;


OldHeapEnd: Pointer;


procedure _unload_music;
begin
  if OldHeapEnd <> nil then HeapEnd:=OldHeapEnd;
  OldHeapEnd:=nil;
end;

function _farmalloc(nbytes: Longint):pointer;far;
var NewHeapEnd: Pointer;
begin
  _unload_music;
{$ifdef DEBUG}
  writeln('requred: ',(nbytes div 16)+1);
  writeln('free   : ',PtrRec(NewHeapEnd).Seg - PtrRec(HeapPtr).Seg );
{$endif}
  OldHeapEnd:=HeapEnd;
  NewHeapEnd:= HeapEnd;
  Dec(PtrRec(NewHeapEnd).Seg, (nbytes div 16)+1);
  if PtrRec(NewHeapEnd).Seg  < PtrRec(HeapPtr).Seg then
    _farmalloc:=nil
  else begin
    HeapEnd:=NewHeapEnd;
    _farmalloc:=HeapEnd;
  end;
end;


procedure CS_data;far;assembler;
asm
  DW      0     {d_0998}
  DW      0     {d_099A}
  DW      0     {d_099C}
  DW      0     {d_099E}
  DW      0     {d_09A0}
  DW      0     {d_09A2}
end;


procedure timer_proc;FAR;forward;
procedure keyboard_proc;FAR;forward;
procedure onemore_proc; FAR;forward;
procedure L5B0;NEAR;forward;
procedure L623;NEAR;forward;
procedure L6FA;NEAR;forward;
procedure L733;NEAR;forward;
procedure L8CF;NEAR;forward;
procedure L93F;NEAR;forward;
procedure L956;NEAR;forward;


{$ifdef VER60}
function  _load_music(FileName: FNameStr; Speed, Device: Integer):Integer;
{$else}
function  _load_music(FileName: PChar; Speed, Device: Integer):Integer;
{$endif}
assembler;
asm
		push	SI
		push	DI
		push	DS
		push	ES
		mov	AX,SEG @Data
		mov	DS,AX
		mov	ES,AX
                mov     BX,[Device]
		or	BX,BX
		je	@L2B
		dec	BX
		shl	BX,1
		push	ES
		xor	AX,AX
		mov	ES,AX
		add	BX,0408h
                mov     AX,ES:[BX]
		pop	ES
                mov     word ptr CS:[offset CS_data+10],AX
		jmp 	@L32
@L2B: { Device = PC Speaker}
                mov     word ptr CS:[offset CS_data+10],042h
@L32:           mov     SI,offset SpeedTable
                mov     AX,[Speed]
		shl	AX,1
		add	SI,AX
		lodsw
                mov     data_02D2,AX
                mov     AX,[Speed]
		xchg	AH,AL
                mov     SI,offset CoeffTable
		add	AX,SI
                mov     data_02D4,AX
		mov	AX,03D00h
                push    DS
          {$ifdef VER60}
                mov     DX, SS
                mov     DS, DX
                lea     DX, FileName
                inc     DX
                mov     SI,word ptr [FileName]
                and     SI,$ff
                mov     byte ptr FileName[SI+1], 0
          {$else}
                lds     DX,[FileName]
          {$endif}
		int	021h
                pop     DS
		jae	@L5C
		sub	AX,AX
		jmp	@L2AB
@L5C:           mov     fHandle,AX
		mov	BX,AX
		mov	AX,04200h
		sub	CX,CX
		mov	DX,CX {01Dh}
		int	021h
		jae	@L70
		jmp	@L29F
@L70:		mov	AH,03Fh
		mov	CX,35{sizeof(Head)}
                mov     DX,offset Head
		int	021h
		jae	@L7F
		jmp	@L29F
@L7F:           cmp     byte ptr Head.ModType,2
		je	@L89
		jmp	@L29F
@L89:           mov     AL,Head.Vers_LO
		mov	CL,064h
		mul	CL
                add     AL,Head.Vers_HI
		cmp	AL,0DDh
		je	@L9B
		jmp	@L29F
@L9B:           mov     DI,offset data_06FF { data_0}
		mov	CX,046DCh
		sub	AL,AL
                rep stosb
                mov     AX,offset onemore_proc
                mov     word ptr CS:[offset CS_data+6],AX
		mov	CX,041h
		sub	BX,BX
                mov     DI,offset data_0703
@LB4:		push	CX
		push	BX
		mov	CX,0100h
		sub	AX,AX
@LBB:		push	AX
		imul	BL
		mov	AL,AH
		cbw
		push	BX
		push	CX
		mov	BX,040h
		imul	BL
		mov	CL,6
		sar	AX,CL
		pop	CX
		pop	BX
		stosb
		pop	AX
		inc	AL
		loop	@LBB
		pop	BX
		pop	CX
		inc	BL
		loop	@LB4
                mov     DI,offset data_4C9B
		mov	AX,055F0h
		mov	CX,4
		rep
		stosw
                mov     AX,offset data_0677
		mov	CX,4
                mov     DI,offset data_4CAB
		rep
		stosw
		mov	AX,040h
		mov	CX,8
                mov     DI,offset data_4CB3
		rep
		stosw
		mov	AX,0FFFFh
		mov	CX,4
                mov     DI,offset data_4CCB
		rep
		stosw
		mov	CX,010h
                mov     SI,offset data_034F
                mov     DI,offset data_4D13
		rep
		movsw
		mov	CX,040h
                mov     SI,offset data_4D13
                mov     DI,offset data_4D33
@L11A:		lodsw
		shr	AX,1
		stosw
		loop	@L11A
                mov     AL,Head.GLTempo
		and	AX,0Fh
		mov	CL,018h
		mul	CL
		mov	CL,4
		shr	AX,CL
		mov	CL,031h
		sub	CL,AL
                mov     AX,data_02D2
		sub	DX,DX
		mov	CH,DH
		div	CX
                mov     data_02E7,AX
                mov     data_02E5,AX
                mov     AL,Head.GLTempo
		sub	AH,AH
		mov	CL,4
		shr	AX,CL
                mov     data_02D6,AX
		mov	AX,04200h
                mov     BX,[fHandle]
		sub	CX,CX
		mov	DX,030h
		int	021h
		jae	@L160
		jmp	@L29F
@L160:		mov	AH,03Fh
                mov     BX,[fHandle]
		mov	CX,03E0h
                mov     DX,offset data_4803
		int	021h
		jae	@L173
		jmp	@L29F
@L173:		mov	AH,03Fh
                mov     BX,[fHandle]
		mov	CX,080h
                mov     DX,offset data_4C03 { [+4955h]}
		int	021h
		jae	@L186
		jmp	@L29F
@L186:		mov	AX,04202h
                mov     BX,[fHandle]
		sub	CX,CX
		mov	DX,CX
		int	021h
		jae	@L198
		jmp	@L29F
@L198:           push    ES
		add	AX,02710h
		jae	@L19F
		inc	DX
@L19F:
{ allocate the great buffer with call to     }
{ void far *farmalloc(unsigned long nbytes); }
		push    DX
		push	AX
                call   _farmalloc
{---------------------------------------------}
                pop     ES
		cmp	DX,0
		jne	@L1B2
		jmp	@L29F
@L1B2:		inc	DX
                mov     [HeapSeg],DX
		mov	AX,04200h
                mov     BX,[fHandle]
		sub	CX,CX
		mov	DX,0490h
		int	021h
		jae	@L1CA
		jmp	@L29F
@L1CA:		push	DS
                mov     DS,[HeapSeg]
                mov     AL,ES:[Head.NPatterns]
		mov	CL,0Ah
		shl	AX,CL
		cmp	AX,0
		jne	@L1DD
		dec	AX
@L1DD:		mov	CX,AX
		mov	AH,03Fh
                mov     BX,ES:[fHandle]
		sub	DX,DX
		int	021h
		pop	DS
		jae	@L1F0
		jmp	@L29F
@L1F0:		push	DS
                mov     DS,[HeapSeg]
                mov     CH,ES:[Head.NPatterns]
		sub	CL,CL
		sub	BX,BX
		push	CX
@L1FF:		mov	AL,[BX]
		cmp	AL,0FBh
		jne	@L20A
                mov     byte ptr [BX],0
		jmp 	@L21A
@L20A:		cmp	AL,0FDh
		jne	@L213
                mov     byte ptr [BX],0FEh
		jmp 	@L21A
@L213:		cmp	AL,0FCh
		jne	@L21A
                mov     byte ptr [BX],0FFh
@L21A:		add	BX,4
		loop	@L1FF
		pop	AX
		pop	DS
		shr	AX,1
		shr	AX,1
		inc	AX
                add     AX,[HeapSeg]
                mov     [data_02B4],AX
		mov	CX,01Fh
                mov     SI,offset data_4803
@L233:		push	CX
		mov	AL,[SI+16h]
		and	AL,AL
		je	@L294
		mov	AX,[SI+10h]
		and	AX,AX
		je	@L294
		sub	AX,AX
		mov	CX,4
		mov	DX,[SI+0Eh]
@L24A:		shl	DX,1
		rcl	AX,1
		loop	@L24A
		mov	CX,AX
		mov	AX,04200h
                mov     BX,fHandle
		int	021h
		jae	@L260
		pop	CX
		jmp 	@L29F
@L260:           mov     AX,data_02B4
		mov	CX,[SI+10h]
		push	DS
		mov	DS,AX
		push	CX
		push	ES
		mov	ES,AX
		sub	AL,AL
		sub	DI,DI
		rep
		stosb
		pop	ES
		pop	CX
		mov	AH,03Fh
		sub	DX,DX
		int	021h
		pop	DS
		jae	@L281
		pop	CX
		jmp 	@L29F
@L281:           mov     AX,data_02B4
		mov	[SI+0Eh],AX
		mov	DX,[SI+10h]
		mov	CL,4
		shr	DX,CL
		add	AX,DX
		inc	AX
                mov     data_02B4,AX
@L294:		pop	CX
		add	SI,020h
		loop	@L233
		mov	AX,1
		jmp 	@L2A1
@L29F:		sub	AX,AX
@L2A1:		push	AX
		mov	AH,03Eh
                mov     BX,fHandle
		int	021h
		pop	AX
@L2AB:		pop	ES
		pop	DS
		pop	DI
		pop	SI
end;
{===========================================}
procedure _start_music;assembler;
asm
		push	SI
		push	DI
		push	DS
		push	ES
		mov	AX,SEG @Data
		mov	DS,AX
		mov	ES,AX
		mov	AL,0B0h
		out	043h,AL
		mov	AL,1
		out	042h,AL
		dec	AL
		out	042h,AL
		in	AL,061h
		or	AL,3
		out	061h,AL
		mov	AL,090h
		out	043h,AL
		mov	SI,020h
                mov     DI,offset data_02B6 {; data_02B6}
		sub	AX,AX
		push	DS
		mov	DS,AX
		mov	CX,4
		rep
		movsw
		pop	DS
		mov	ES,AX
		mov	DI,020h
                mov     AX,offset timer_proc
		cli
		stosw
		mov	AX,CS
		stosw
                mov     AX,offset keyboard_proc
		stosw
		mov	AX,CS
		stosw
		sti
		mov	AL,036h
		out	043h,AL
                mov     CX,[data_02D2]
		mov	DX,012h
		mov	AX,034DCh
		div	CX
		out	040h,AL
		mov	AL,AH
		out	040h,AL
                mov     byte ptr data_02C9,1
                call    L8CF
		pop	ES
		pop	DS
		pop	DI
		pop	SI
end;
{===========================================}
procedure _stop_music;assembler;
asm
		push	SI
		push	DI
		push	DS
		push	ES
		mov	AX,SEG @Data
		mov	DS,AX
		mov	ES,AX
		mov	AL,036h
		out	043h,AL
		sub	AL,AL
		out	040h,AL
		out	040h,AL
		in	AL,061h
		and	AL,0FCh
		out	061h,AL
		mov	DI,020h
                mov     SI,offset data_02B6 {; data_02B6}
		sub	AX,AX
		mov	ES,AX
		mov	CX,4
		cli
		rep
		movsw
		sti
		pop	ES
		pop	DS
		pop	DI
		pop	SI
end;
{===========================================}
procedure keyboard_proc;assembler;
asm
		sti
		pushf
		push	AX
		push	DS
		mov	AX,SEG @Data
		mov	DS,AX
		sub	AH,AH
		in	AL,060h
		cmp	AL,1
		je	@L384
		cmp	AL,01Ch
		je	@L384
		cmp	AL,04Ah
		jne	@L372
                mov     AL, Head.GLVolume
		cmp	AL,0
		je	@L38D
		sub	AL,8
		jmp 	@L37F
@L372:		cmp	AL,04Eh
		jne	@L38D
                mov     AL, Head.GLVolume
		cmp	AL,040h
		je	@L38D
		add	AL,8
@L37F:          mov     Head.GLVolume,AL
		jmp 	@L38D
@L384:          mov     _scan_code,AX
                mov     word ptr _ready_char,1
@L38D:		mov	AL,020h
		out	020h,AL
		pop	DS
		pop	AX
		popf
		iret
end;
{===========================================}
procedure timer_proc;assembler;
asm
		push	AX
		push	BX
		push	CX
		push	DX
		push	ES
		push	DS
		mov	AX,SEG @Data
		mov	DS,AX
		mov	DX,0FFFFh
		xor	CL,CL
                les     BX,[data_4CDB] {    [04A14h]}
                cmp     BX,[data_4CC3] {    [049FCh]}
		jb	@L3C7
                cmp     [data_4CCB],DX {  [04A04h]}
		je	@L3BF
                mov     BX,[data_4CCB]
                mov     word ptr [data_4CDB],BX
		jmp 	@L3C7
@L3BF:           mov     word ptr [data_02E9],1
		jmp 	@L3E1
@L3C7:           mov     AX,[data_4C9B]
                add     [data_4C93],AX
                adc     BX,[data_4CA3]
                mov     word ptr [data_4CDB],BX
                mov     BL,ES:[BX]
                mov     BH,byte ptr [data_4CB3]
                add     CL,Byte Ptr data_0703[BX]
@L3E1:           les     BX,[data_4CDF]
                cmp     BX,[data_4CC5]
		jb	@L403
                cmp     [data_4CCD],DX
		je	@L3FB
                mov     BX,[data_4CCD]
                mov     word ptr [data_4CDF],BX
		jmp 	@L403
@L3FB:           mov     WORD PTR [data_02EB],1
		jmp 	@L41D
@L403:           mov     AX,[data_4C9D]
                add     [data_4C95],AX
                adc     BX,[data_4CA5]
                mov     word ptr [data_4CDF],BX
                mov     BL,ES:[BX]
                mov     BH,byte ptr [data_4CB5]
                add     CL,Byte Ptr data_0703[BX]
@L41D:           les     BX,[data_4CE3]
                cmp     BX,[data_4CC7]
		jb	@L43F
                cmp     [data_4CCF],DX
		je	@L437
                mov     BX,[data_4CCF]
                mov     word ptr [data_4CE3],BX
		jmp 	@L43F
@L437:           mov     word ptr [data_02ED],1
		jmp 	@L459
@L43F:           mov     AX,[data_4C9F]
                add     [data_4C97],AX
                adc     BX,[data_4CA7]
                mov     word ptr [data_4CE3],BX
                mov     BL,ES:[BX]
                mov     BH,byte ptr [data_4CB7]
                add     CL,Byte Ptr data_0703[BX]
@L459:           les     BX,[data_4CE7]
                cmp     BX,[data_4CC9]
		jb	@L47B
                cmp     [data_4CD1],DX
		je	@L473
                mov     BX,[data_4CD1]
                mov     word ptr [data_4CE7],BX
		jmp 	@L47B
@L473:           mov     WORD PTR [data_02EF],1
		jmp 	@L495
@L47B:           mov     AX,[data_4CA1]
                add     [data_4C99],AX
                adc     BX,[data_4CA9]
                mov     word ptr [data_4CE7],BX
                mov     BL,ES:[BX]
                mov     BH,byte ptr [data_4CB9]
                add     CL,Byte Ptr data_0703[BX]
@L495:		mov	AL,CL
		add	AL,080h
                mov     BX,[data_02D4]
		xlat
		push	DX
                mov     DX,CS:[offset CS_data+10]
		out	DX,AL
		pop	DX
                mov     word ptr CS:[offset CS_data+8],0
                mov     AX,[data_02E5]
		dec	AX
		jne	@L4BD
		mov     word ptr CS:[offset CS_data+8],1
                mov     AX,[data_02E7]
@L4BD:           mov     [data_02E5],AX
                inc     word ptr [data_02CA]
		mov	AL,020h
		out	020h,AL
		pop	DS
		pop	ES
		pop	DX
		pop	CX
		pop	BX
		pop	AX
                cmp     word ptr CS:[offset CS_data+8],0
		je	@L4F0
                pop     word ptr CS:[offset CS_data+2]
                pop     word ptr CS:[offset CS_data]
                pop     word ptr CS:[offset CS_data+4]
                push    word ptr CS:[offset CS_data+4]
		push	CS
		push    word ptr CS:[offset CS_data+6]
@L4F0:		iret
end;
{===========================================}
procedure onemore_proc; assembler;
asm
                pushf
		push	AX
		push	BX
		push	CX
		push	DX
		push	ES
		push	DS
		push	SI
		push	DI
		push	BP
		mov	AX, SEG @Data
		mov	DS,AX
                mov     AX,[data_02D9]
		cmp	AX,0
		je	@L526
		dec	AX
                mov     [data_02D9],AX
		mov	SI,0
                call   L733
		mov	SI,2
                call   L733
		mov	SI,4
                call   L733
		mov	SI,6
                call   L733
		jmp 	@L563
@L526:           cmp     byte ptr [data_02C9],0
		je	@L563
                mov     AX,[data_02D6]
		cmp	AX,0
		je	@L536
		dec	AX
@L536:           mov     [data_02D9],AX
                cmp     byte ptr [data_02D8],1
		jne	@L548
                mov     byte ptr [data_02D8],0
                call   L8CF
@L548:		mov	SI,0
                call   L5B0
		mov	SI,2
                call   L5B0
		mov	SI,4
                call   L5B0
		mov	SI,6
                call   L5B0
                call   L93F
@L563:           mov     AX,[data_4CBB]
                mul     byte ptr [Head.GLVolume]
		mov	CL,6
		shr	AX,CL
                mov     [data_4CB3],AX
                mov     AX,[data_4CBD]
                mul     byte ptr [Head.GLVolume]
		mov	CL,6
		shr	AX,CL
                mov     [data_4CB5],AX
                mov     AX,[data_4CBF]
                mul     byte ptr [Head.GLVolume]
		mov	CL,6
		shr	AX,CL
                mov     [data_4CB7],AX
                mov     AX,[data_4CC1]
                mul     byte ptr [Head.GLVolume]
		mov	CL,6
		shr	AX,CL
                mov     [data_4CB9],AX
		pop	BP
		pop	DI
		pop	SI
		pop	DS
		pop	ES
		pop	DX
		pop	CX
		pop	BX
		pop	AX
		popf
                push    word ptr CS:[offset CS_data]
                push    word ptr CS:[offset CS_data+2]
end;
{============================================}

procedure L5B0; assembler;
asm
                mov     AX,[HeapSeg]
		mov	ES,AX
                inc     word ptr data_4C83[SI]
                cmp     word ptr data_4C83[SI],040h
		jb	@L5C5
                mov     byte ptr [data_02D8],1
@L5C5:           cmp     word ptr data_066F[SI],0
		je	@L622
                mov     BX, data_4C8B[SI]
		xor	AH,AH
                mov     AL,ES:[BX]
                mov     word ptr data_4DC3[SI],AX
                mov     AL,ES:[BX+01]
		shr	AL,1
		shr	AL,1
		shr	AL,1
                mov     word ptr data_4DCB[SI],AX
                mov     AL,ES:[BX+01]
		and	AL,7
                mov     DL,ES:[BX+02]
		shr	DL,1
		and	DL,078h
		or	AL,DL
                mov     word ptr data_4DBB[SI],AX
                mov     AL,ES:[BX+02]
		and	AL,0Fh
                mov     word ptr data_4DB3[SI],AX
                mov     AL,ES:[BX+03]
                mov     word ptr data_4DD3[SI],AX
		add	BX,010h
                mov     data_4C8B[SI],BX
                call   L623
                cmp     word ptr data_4DB3[SI],9
		jne	@L622
                call   L733
@L622:
end;
{;===========================================}
procedure L623;  assembler;
asm
                mov     DI,SI
		shl	DI,1
                mov     AX,Word Ptr data_4DBB[SI]
		cmp	AX,041h
		je	@L638
                mov     data_4CBB[SI],AX
                mov     Word Ptr data_4D0B[SI],AX
@L638:           cmp     word ptr data_4DB3[SI],7
		jne	@L642
		jmp	@L6E5
@L642:           mov     BX,Word Ptr data_4DCB[SI]
		cmp	BX,0
		je	@L692
		mov	CL,5
		shl	BX,CL
                add     BX,offset data_47E3
                mov     Word Ptr data_4CAB[SI],BX
                cmp     word ptr data_4DBB[SI],041h
		jne	@L66B
                mov     AL,[BX+16h]
		xor	AH,AH
                mov     data_4CBB[SI],AX
                mov     Word Ptr data_4D0B[SI],AX
@L66B:           mov     AX,[BX+0Eh]
                mov     word ptr data_4CDB[DI+2],AX
                mov     AX,[BX+14h]
		cmp	AX,0FFFFh
		je	@L687
                mov     data_4CC3[SI],AX
                mov     AX,[BX+12h]
                mov     data_4CCB[SI],AX
		jmp 	@L692
@L687:           mov     data_4CCB[SI],AX
                mov     AX,[BX+10h]
                mov     data_4CC3[SI],AX
@L692:           mov     BX,Word Ptr data_4DC3[SI]
		cmp	BX,0FEh
		jne	@L6B2
		xor	AX,AX
                mov     data_4C93[SI],AX
                mov     word ptr data_4CDB[DI],AX
                mov     data_4CC3[SI],AX
                mov     word ptr data_4CCB[SI],0FFFFh
		jmp 	@L6E1
@L6B2:		cmp	BX,0FFh
		je	@L6E1
                mov     AX,data_4CBB[SI]
		shr	SI,1
		shr	AL,1
                mov     Byte Ptr data_06FF[SI],AL
		shl	SI,1
		shl	BX,1
                mov     AX,Word Ptr data_4D13[BX]
                mov     word ptr data_4CD3[SI],AX
                mov     Word Ptr data_4CEB[SI],AX
                call   L956
		xor	AX,AX
                mov     data_4C93[SI],AX
                mov     word ptr data_4CDB[DI],AX
@L6E1:           call   L6FA
		ret
@L6E5:           mov     BX,Word Ptr data_4DC3[SI]
		cmp	BX,0FFh
		je	@L6F9
		shl	BX,1
                mov     AX,Word Ptr data_4D13[BX]
                mov     Word Ptr data_4CEB[SI],AX
@L6F9:
end;
{;===========================================}
procedure L6FA;assembler;
asm
                mov     AH,byte ptr data_4DB3[SI]
                mov     AL,byte ptr data_4DD3[SI]
		cmp	AH,1
		je	@L712
		cmp	AH,2
		je	@L724
		cmp	AH,3
		je	@L72D
@L711:		ret
@L712:		cmp	AL,0
		je	@L711
		xor	AH,AH
		shr	AL,1
		shr	AL,1
		shr	AL,1
		shr	AL,1
                mov     [data_02D6],AX
		ret
@L724:		xor	AH,AH
                add     AX,offset data_4C03
                mov     [data_02F1],AX
		ret
@L72D:           mov     byte ptr [data_02D8],1
end;
{;===========================================}
procedure L733;assembler;
asm
                mov     AH,byte ptr data_4DB3[SI]
                mov     AL,byte ptr data_4DD3[SI]
		cmp	AH,5
		je	@L782
		cmp	AH,6
		je	@L774
		cmp	AH,4
		je	@L790
		cmp	AH,9
		je	@L76C
                mov     word ptr data_4CFB[SI],0
                mov     word ptr data_4D03[SI],1
		cmp	AH,7
		je	@L772
		cmp	AH,8
		je	@L76F
                mov     word ptr data_4CF3[SI],0
		ret
@L76C:		jmp	@L87F
@L76F:		jmp	@L847
@L772:		jmp 	@L7C6
@L774:		xor	AH,AH
                mul     byte ptr data_02DB
                sub     Word Ptr data_4CD3[SI],AX
                call   L956
		ret
@L782:		xor	AH,AH
                mul     byte ptr data_02DB
                add     Word Ptr data_4CD3[SI],AX
                call   L956
		ret
@L790:		mov	DL,AL
		and	DL,0Fh
		cmp	DL,0
		je	@L7AE
		xor	DH,DH
                sub     data_4CBB[SI],DX
                cmp     word ptr data_4CBB[SI],0FFFFh
		jg	@L7C5
                mov     word ptr data_4CBB[SI],0
		ret
@L7AE:		xor	AH,AH
		mov	CL,4
		shr	AL,CL
                add     data_4CBB[SI],AX
                cmp     word ptr data_4CBB[SI],041h
		jb	@L7C5
                mov     word ptr data_4CBB[SI],040h
@L7C5:		ret
@L7C6:           mov     AX,Word Ptr data_4CD3[SI]
                cmp     AX,Word Ptr data_4CEB[SI]
		jne	@L7D1
		ret
@L7D1:		ja	@L80D
                add     AX,Word Ptr data_4DD3[SI]
                add     AX,Word Ptr data_4DD3[SI]
                add     AX,Word Ptr data_4DD3[SI]
                add     AX,Word Ptr data_4DD3[SI]
                add     AX,Word Ptr data_4DD3[SI]
                add     AX,Word Ptr data_4DD3[SI]
                add     AX,Word Ptr data_4DD3[SI]
                add     AX,Word Ptr data_4DD3[SI]
                add     AX,Word Ptr data_4DD3[SI]
                add     AX,Word Ptr data_4DD3[SI]
                cmp     AX,Word Ptr data_4CEB[SI]
		jbe	@L805
                mov     AX,Word Ptr data_4CEB[SI]
@L805:           mov     Word Ptr data_4CD3[SI],AX
                call   L956
		ret
@L80D:          sub     AX,Word Ptr data_4DD3[SI]
                sub     AX,Word Ptr data_4DD3[SI]
                sub     AX,Word Ptr data_4DD3[SI]
                sub     AX,Word Ptr data_4DD3[SI]
                sub     AX,Word Ptr data_4DD3[SI]
                sub     AX,Word Ptr data_4DD3[SI]
                sub     AX,Word Ptr data_4DD3[SI]
                sub     AX,Word Ptr data_4DD3[SI]
                sub     AX,Word Ptr data_4DD3[SI]
                sub     AX,Word Ptr data_4DD3[SI]
                cmp     AX,Word Ptr data_4CEB[SI]
		jae	@L83F
                mov     AX,Word Ptr data_4CEB[SI]
@L83F:           mov     Word Ptr data_4CD3[SI],AX
                call   L956
		ret
@L847:		mov	CL,AL
		mov	CH,AL
		and	CL,0Fh
                mov     BX,Word Ptr data_4CF3[SI]
                mov     AX,word ptr data_067F[BX]
		push	CX
		xor	CH,CH
		imul	CX
		pop	CX
		mov	CL,6
		sar	AX,CL
                imul    byte ptr data_02DB
                add     AX,Word Ptr data_4CEB[SI]
                mov     Word Ptr data_4CD3[SI],AX
                call   L956
		mov	CL,4
		shr	CH,CL
		shl	CH,1
		add	BL,CH
		and	BL,07Eh
                mov     Word Ptr data_4CF3[SI],BX
		ret
@L87F:          mov     AX,Word Ptr data_4CFB[SI]
		cmp	AX,0
		je	@L88E
		dec	AX
                mov     Word Ptr data_4CFB[SI],AX
		ret
@L88E:          mov     AX,Word Ptr data_4D03[SI]
		cmp	AX,1
		je	@L8B6
                mov     word ptr data_4D03[SI],1
                mov     AX,Word Ptr data_4D0B[SI]
                mov     data_4CBB[SI],AX
                mov     AX,Word Ptr data_4DD3[SI]
		shr	AL,1
		shr	AL,1
		shr	AL,1
		shr	AL,1
                mov     Word Ptr data_4CFB[SI],AX
		ret
@L8B6:           mov     word ptr data_4D03[SI],0
		mov	AX,0
                mov     Word Ptr data_4CBB[SI],AX
                mov     AX,Word Ptr data_4DD3[SI]
		and	AX,0Fh
                mov     Word Ptr data_4CFB[SI],AX
end;
{;===========================================}
procedure L8CF;assembler;
asm
                xor     AH,AH
                mov     BX,data_02F1
		mov	AL,[BX]
		inc	BX
		cmp	AX,063h
		jne	@L8E8
                inc     word ptr data_02E1
                mov     BX,data_02F3
		mov	AL,[BX]
		inc	BX
@L8E8:		dec	BX
                mov     data_02F9,BX
		inc	BX
		cmp	AX,062h
		jne	@L90C
                inc     word ptr data_02E1
                mov     BX,offset data_4C03
		mov	AL,[BX]
		inc	BX
                mov     byte ptr data_02DE,1
                mov     byte ptr data_02DC,0
                mov     byte ptr data_02DD,0
@L90C:          mov     data_02F1,BX
                mov     data_02F5,AX
		mov	AH,AL
		xor	AL,AL
		shl	AX,1
		shl	AX,1
                mov     data_4C8B,AX
		add	AX,4
                mov     data_4C8D,AX
		add	AX,4
                mov     data_4C8F,AX
		add	AX,4
                mov     data_4C91,AX
		xor	AX,AX
                mov     data_4C83,AX
                mov     data_4C85,AX
                mov     data_4C87,AX
                mov     data_4C89,AX
end;
{;===========================================}
procedure L93F;assembler;
asm
                mov     AX,data_4C89
		xor	AH,AH
                mov     data_02DF,AX
                mov     AX,data_02F5
		xor	AH,AH
                mov     data_02F7,AX
                mov     AX,data_02F9
                mov     data_02E3,AX
end;
{;===========================================}
procedure L956;assembler;
asm
                push    AX
		push	BX
		push	CX
		push	DX
                mov     CX,Word Ptr data_4CD3[SI]
		cmp	CX,0227h
		jae	@L973
		xor	AX,AX
                mov     data_4C9B[SI],AX
                mov     data_4CA3[SI],AX
		pop	DX
		pop	CX
		pop	BX
		pop	AX
		ret
@L973:		mov	DX,0226h
		mov	AX,06C34h
		div	CX
		xor	DX,DX
                div     word ptr data_02D2
		mov	CX,AX
		xor	AX,AX
                div     word ptr data_02D2
		mov	DX,CX
                mov     data_4C9B[SI],AX
                mov     data_4CA3[SI],DX
		pop	DX
		pop	CX
		pop	BX
		pop	AX
end;
begin
  data_02F1 := ofs(data_4C03);
  data_02F3 := ofs(data_4C03);
  OldHeapEnd:=nil;
end.