{$S-,R-,V-,I-,B-,F+,X+,G-,A+}
{$M $4000,$20000,$A0000}

unit
  STMPlay;

interface

USES
  Crt, Dos;

CONST
  SpTab : Array[0..255] of Byte = (
	$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,
	$02,$02,$02,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$04,$04,
	$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,
	$05,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,
	$06,$06,$06,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$08,$08,
	$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$09,$09,$09,$09,$09,
	$09,$09,$0A,$0A,$0A,$0A,$0B,$0B,$0C,$0C,$0D,$0E,$0E,$0F,$10,$11,
	$11,$12,$13,$14,$15,$16,$17,$18,$1A,$1B,$1C,$1D,$1E,$1F,$21,$22,
	$23,$24,$26,$27,$28,$29,$2B,$2C,$2D,$2E,$30,$31,$32,$33,$34,$35,
	$36,$37,$39,$3A,$3A,$3B,$3C,$3D,$3E,$3F,$40,$40,$41,$42,$42,$43,
	$43,$43,$43,$43,$43,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,
	$44,$44,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$46,$46,$46,
	$46,$46,$46,$46,$46,$46,$46,$46,$46,$46,$47,$47,$47,$47,$47,$47,
	$47,$47,$47,$47,$47,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,
	$48,$48,$49,$49,$49,$49,$49,$49,$49,$49,$49,$49,$49,$4A,$4A,$4A,
	$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4B,$4B,$4B,$4B,$4B,$4B );

  TempoMul : Array[0..17] of Byte = (
	$8C,$32,$19,$0F,$0A,$07,$06,$04,$03,$03,$02,$02,$02,$02,$01,$01,
	$01,$01 );

  VibratoTab : Array[0..63] of Word = (
	$0000,$0018,$0031,$004A,$0061,$0078,$008D,$00A1,
	$00B4,$00C5,$00D4,$00E0,$00EB,$00F4,$00FA,$00FD,
	$00FF,$00FD,$00FA,$00F4,$00EB,$00E0,$00D4,$00C5,
	$00B4,$00A1,$008D,$0078,$0061,$004A,$0031,$0018,
	$0000,$FFE8,$FFCF,$FFB6,$FF9F,$FF88,$FF73,$FF5F,
	$FF4C,$FF3B,$FF2C,$FF20,$FF15,$FF0C,$FF06,$FF03,
	$FF01,$FF03,$FF06,$FF0C,$FF15,$FF20,$FF2C,$FF3B,
	$FF4C,$FF5F,$FF73,$FF88,$FF9F,$FFB6,$FFCF,$FFE8);

  ComVar : Byte = $0A;

  SmBut  : Array[0..1]  OF Char = (#138,#15);
  SmBut1 : Array[0..1]  OF Char = (#11,#12);
  PianP  : Array[0..11] OF Byte = (0,1,2,3,4,6,7,8,9,10,11,12);

TYPE
  OnePat  = Array[0..63,0..4,0..4] of Byte;
  Buffer  = Array[0..65534] of Byte;
  BufPtr  = ^Buffer;

  InsType = RECORD
              Name : String[12];
              Tran : Word;
              Volm : Byte;
              LopS : Word;
              LopE : Word;
              Leng : Word;
              Inst : BufPtr;
              W1   : Word;
              W2   : Word;
              Res1 : Word;
            END;

  SetupTp = RECORD
              PSpeed  : Word;
              Res1    : Byte;
              TimerOn : Boolean;
              Lpt     : Word;
              Sb      : Word;
            END;

  ChnType = RECORD
              OnV     : WORD;
              On      : WORD;
              InsOfs  : Word;
              InsSeg  : Word;
              InsEnd  : Word;
              Loop    : Word;
              Free    : WORD;
              Trans1  : Word;
              Trans2  : Word;
              TAdd    : Word;
              Res1    : Byte;
              Volume  : Byte;
              LstNote : Word;
              LstIns  : Word;
              LstPVol : Word;
              LstCmd  : Word;
              LstInfo : Word;
              NInsOfs : Word;
              InsTrns : Word;
              Row     : Word;
              PatOfs  : Word;
              CVol    : Word;
              IVol    : Word;
              TmpNote : Word;
              TmpTrn1 : Word;
              TmpTrn2 : Word;
              TremVar : Word;
              ArpeVar : Word;
              VibrVar : Word;
              LevVol  : Word;
              LevVol1 : Word;
              Color   : Word;
            END;

VAR
  Cw,Cw1,W  : Word;
  Cb        : Byte;
  Cr        : Real;
  Cl        : LongInt;
  F         : File;
  SName     : Array[1..20] of Char;
  VTab      : Array[0..64,0..255] of Byte;
  NTab      : Array[0..4,0..15] of Word;
  OrdB      : Array[0..127] of Byte;
  InsB      : Array[1..31] of InsType;
  PatB      : BufPtr;
  Ov08      : Procedure;
  GTempo    : Byte;
  GOctave   : Byte;
  GVolume1  : Byte;
  GVolume2  : Byte;
  GVolume3  : Byte;
  GVolume4  : Byte;
  Lpt1      : Word ABSOLUTE $0000:$0408;
  Lpt2      : Word ABSOLUTE $0000:$040A;
  Setup     : SetupTp;
  Ch1       : ChnType;
  Ch2       : ChnType;
  Ch3       : ChnType;
  Ch4       : ChnType;
  FastTime  : Word;
  AddWCur   : Word;
  AddWBegin : Word;
  TempoD16  : Word;
  TempoD16S : Word;
  Play1Note : Boolean;
  ChangePat : Boolean;
  TimerC    : Word;
  TimerA    : Word;
  CTempo    : Word;
  NextPatO  : Word;
  LoopCount : Word;
  FirstOrd  : Word;
  CurOrder  : Word;
  CurPat    : Word;
  NextPat   : Boolean;
  Port40    : Word;
  TotPat    : word;
  SpTabOfs,
  SpTabSeg  : Word;

PROCEDURE SetDefaultSetup;
FUNCTION  ReadSTM(Name:String):Boolean;
PROCEDURE PlayAllPatterns(Device:byte);
procedure Stop;
procedure InitPlayer;

implementation

PROCEDURE InitTabs;
BEGIN
  FillChar(VTab,256,0);
  FOR Cw:= 1 TO 64 DO
  BEGIN
    FOR Cb:=0 TO 127 DO
    BEGIN
      VTab[Cw,Cb]:=Trunc(Cw*cb/256);
      VTab[Cw,255-Cb]:=not VTab[Cw,Cb];
    END;
  END;
  FOR Cw:=0 TO 59 DO
    NTab[Cw DIV 12,Cw MOD 12]:=Round($42B8/(Exp(Ln(2)*Cw/12)));
END;

PROCEDURE SetDefaultSetup;
BEGIN
  Setup.Lpt:=Lpt1;
  Setup.Sb:=$220;
  Setup.TimerOn:=False;
  Setup.PSpeed:=19889;
END;

{
PROCEDURE ClearIns(Num:Byte);
BEGIN
    InsB[Num].Name:='';
    InsB[Num].Tran:=$2100;
    InsB[Num].Volm:=$40;
    InsB[Num].LopS:=0;
    InsB[Num].LopE:=$FFFF;
    InsB[Num].Leng:=0;
    InsB[Num].Inst:=NIL;
    InsB[Num].W1:=0;
    InsB[Num].W2:=0;
END;
}

PROCEDURE ResetTempoVars;NEAR;ASSEMBLER;
ASM
  MOV  CTempo,AX
  MOV  BX,AX
  SHR  BX,1
  SHR  BX,1
  SHR  BX,1
  SHR  BX,1
  MOV  TempoD16S,BX
  AND  AX,0FH
  MOV  CX,AX
  MOV  AL,TempoMul[BX].Byte
  MUL  CX
  SHR  AX,1
  SHR  AX,1
  SHR  AX,1
  SHR  AX,1
  MOV  BX,AX
  MOV  AX,Setup.PSpeed
  MOV  CX,31H
  SUB  CX,BX
  XOR  DX,DX
  DIV  CX
  MOV  AddWBegin,AX
  RET
END;

PROCEDURE MulTran;NEAR;ASSEMBLER;
ASM
  PUSH BX
  PUSH CX
  MOV  CX,ChnType([SI]).TmpTrn1
  CMP  CX,227H
  JNC  @OkCX
  XOR  AX,AX
  MOV  ChnType([SI]).Trans2,AX
  MOV  ChnType([SI]).Trans1,AX
  POP  CX
  POP  BX
  RET
 @OkCX:
  MOV  DX,226H
  MOV  AX,6C34H
  DIV  CX
  XOR  DX,DX
  DIV  Setup.PSpeed
  MOV  CX,AX
  XOR  AX,AX
  DIV  Setup.PSpeed
  MOV  ChnType([SI]).Trans2,AX
  MOV  ChnType([SI]).Trans1,CX
  POP  CX
  POP  BX
  RET
END;

PROCEDURE DoCommand;NEAR;ASSEMBLER;
ASM
  MOV  AH,ChnType([SI]).LstCmd.Byte
  MOV  AL,ChnType([SI]).LstInfo.Byte
  CMP  AH,5
  JZ   @PortUp
  CMP  AH,6
  JZ   @PortDown
  CMP  AH,4
  JZ   @VolSlide
  CMP  AH,9
  JNZ  @C1
  JMP  @Tremor
@C1:
  CMP  AH,0AH
  JNZ  @C2
  JMP  @Arped
@C2:
  MOV  ChnType([SI]).TremVar,0
  MOV  ChnType([SI]).ArpeVar,1
  CMP  AH,7
  JNZ  @C3
  JMP  @GNop
@C3:
  CMP  AH,8
  JNZ  @C4
  JMP  @Vibrato
@C4:
  MOV  ChnType([SI]).VibrVar,0
  RET
 @PortDown:
  XOR  AH,AH
  MUL  ComVar
  SUB  ChnType([SI]).TmpTrn1,AX
  CALL MulTran
  RET
 @PortUp:
  XOR  AH,AH
  MUL  ComVar
  ADD  ChnType([SI]).TmpTrn1,AX
  CALL MulTran
  RET
 @VolSlide:
  MOV  DL,AL
  AND  DL,0FH
  CMP  DL,0
  JZ   @UpVol
  XOR  DH,DH
  SUB  ChnType([SI]).CVol,DX
  CMP  ChnType([SI]).CVol,0FFFFH
  JG   @OkRet
  MOV  ChnType([SI]).CVol,0
 @OkRet:
  RET
 @UpVol:
  XOR  AH,AH
  MOV  CL,4
  SHR  AL,CL
  ADD  ChnType([SI]).CVol,AX
  CMP  ChnType([SI]).CVol,041H
  JC   @OkRet
  MOV  ChnType([SI]).CVol,040H
  RET
 @GNop:
  MOV  AX,ChnType([SI]).TmpTrn1
  CMP  AX,ChnType([SI]).TmpTrn2
  JNZ  @Differ
  RET
 @Differ:
  JA   @SetDown
  ADD  AX,ChnType([SI]).LstInfo
  ADD  AX,ChnType([SI]).LstInfo
  ADD  AX,ChnType([SI]).LstInfo
  ADD  AX,ChnType([SI]).LstInfo
  ADD  AX,ChnType([SI]).LstInfo
  ADD  AX,ChnType([SI]).LstInfo
  ADD  AX,ChnType([SI]).LstInfo
  ADD  AX,ChnType([SI]).LstInfo
  ADD  AX,ChnType([SI]).LstInfo
  ADD  AX,ChnType([SI]).LstInfo
  CMP  AX,ChnType([SI]).TmpTrn2
  JNA  @NoAbove
  MOV  AX,ChnType([SI]).TmpTrn2
 @NoAbove:
  MOV  ChnType([SI]).TmpTrn1,AX
  CALL MulTran
  RET
 @SetDown:
  SUB  AX,ChnType([SI]).LstInfo
  SUB  AX,ChnType([SI]).LstInfo
  SUB  AX,ChnType([SI]).LstInfo
  SUB  AX,ChnType([SI]).LstInfo
  SUB  AX,ChnType([SI]).LstInfo
  SUB  AX,ChnType([SI]).LstInfo
  SUB  AX,ChnType([SI]).LstInfo
  SUB  AX,ChnType([SI]).LstInfo
  SUB  AX,ChnType([SI]).LstInfo
  SUB  AX,ChnType([SI]).LstInfo
  CMP  AX,ChnType([SI]).TmpTrn2
  JNC  @NoAbove1
  MOV  AX,ChnType([SI]).TmpTrn2
 @NoAbove1:
  MOV  ChnType([SI]).TmpTrn1,AX
  CALL MulTran
  RET
 @Vibrato:
  MOV  CL,AL
  MOV  CH,AL
  AND  CL,0FH
  MOV  BX,ChnType([SI]).VibrVar
  MOV  AX,VibratoTab[BX].WORD
  PUSH CX
  XOR  CH,CH
  IMUL CX
  POP  CX
  MOV  CL,6
  SAR  AX,CL
  IMUL ComVar
  ADD  AX,ChnType([SI]).TmpTrn2
  MOV  ChnType([SI]).TmpTrn1,AX
  CALL MulTran
  MOV  CL,4
  SHR  CH,CL
  SHL  CH,1
  ADD  BL,CH
  AND  BL,7EH
  MOV  ChnType([SI]).VibrVar,BX
  RET
 @Tremor:
  MOV  AX,ChnType([SI]).TremVar
  CMP  AX,0
  JZ   @InTrem
  DEC  AX
  MOV  ChnType([SI]).TremVar,AX
  RET
 @InTrem:
  MOV  AX,ChnType([SI]).ArpeVar
  CMP  AX,1
  JZ   @InTrem1
  MOV  ChnType([SI]).ArpeVar,1
  MOV  AX,ChnType([SI]).IVol
  MOV  ChnType([SI]).CVol,AX
  MOV  AX,ChnType([SI]).LstInfo
  SHR  AL,1
  SHR  AL,1
  SHR  AL,1
  SHR  AL,1
  MOV  ChnType([SI]).TremVar,AX
  RET
 @InTrem1:
  MOV  ChnType([SI]).ArpeVar,0
  MOV  AX,0
  MOV  ChnType([SI]).CVol,AX
  MOV  AX,ChnType([SI]).LstInfo
  AND  AX,0FH
  MOV  ChnType([SI]).TremVar,AX
  RET
 @Arped:
  MOV  AX,TempoD16
  MOV  CL,3
  DIV  CL
  MOV  DL,AL
  XOR  AL,AL
  MOV  BL,ChnType([SI]).TmpNote.Byte
  CMP  DL,2
  JZ   @It2
  CMP  DL,1
  JZ   @It1
  MOV  AL,ChnType([SI]).LstInfo.Byte
  AND  AL,0FH
  JMP  @It2
 @It1:
  INC   CL
  SHR   AL,CL
 @It2:
  MOV   BH,BL
  AND   BL,0F0H
  AND   BH,00FH
  ADD   BH,AL
  CMP   BH,0BH
  JBE   @Caron
  SUB   BH,0CH
  ADD   BL,10H
 @Caron:
  OR    BL,BH
  XOR   BH,BH
  SHL   BX,1
  MOV   AX,NTab[BX].WORD
  MOV   CX,2100H
  MUL   CX
  MOV   CX,ChnType([SI]).InsTrns
  CMP   CX,0
  JNZ   @NoZTr
  MOV   CX,22B8H
 @NoZTr:
  DIV   CX
  MOV  ChnType([SI]).TmpTrn1,AX
  MOV  ChnType([SI]).TmpTrn2,AX
  CALL MulTran
  RET
END;

PROCEDURE ChangePattern;NEAR;ASSEMBLER;
ASM
  XOR  AH,AH
  MOV  BX,NextPatO
  MOV  AL,[BX]
  CMP  AX,63H
  JNZ  @NoPlayEnd
  INC  LoopCount
  MOV  BX,FirstOrd
  MOV  AL,[BX]
 @NoPlayEnd:
  MOV  CurOrder,BX
  INC  BX
  CMP  AX,62H
  JNZ  @No62
  INC  LoopCount
  MOV  BX,OFFSET OrdB
  MOV  AL,[BX]
  INC  BX
  MOV  NextPat,True
 @No62:
  MOV  NextPatO,BX
  MOV  CurPat,AX
  MOV  AH,AL
  XOR  AL,AL
  SHL  AX,1
  SHL  AX,1
  ADD  AX,0
  MOV  Ch1.PatOfs,AX
  ADD  AX,4
  MOV  Ch2.PatOfs,AX
  ADD  AX,4
  MOV  Ch3.PatOfs,AX
  ADD  AX,4
  MOV  Ch4.PatOfs,AX
  XOR  AX,AX
  MOV  Ch1.Row,AX
  MOV  Ch2.Row,AX
  MOV  Ch3.Row,AX
  MOV  Ch4.Row,AX
END;

PROCEDURE CheckOptions;NEAR;ASSEMBLER;
ASM
  MOV  AH,ChnType([SI]).LstCmd.Byte
  MOV  AL,ChnType([SI]).LstInfo.Byte
  CMP  AH,1
  JZ   @ChgTempo
  CMP  AH,2
  JZ   @GotoPat
  CMP  AH,3
  JZ   @BreakPat
 @RetFromChk:
  RET
 @ChgTempo:
  CMP  AL,0
  JZ   @RetFromChk
  XOR  AH,AH
  CALL ResetTempoVars
  RET
 @GotoPat:
  XOR  AH,AH
  ADD  AX,OFFSET OrdB
  MOV  NextPatO,AX
  RET
 @BreakPat:
  MOV  ChangePat,True
END;

PROCEDURE SetNoteTrans;NEAR;ASSEMBLER;
ASM
  MOV  AX,ChnType([SI]).LstPVol
  CMP  AX,41H
  JZ   @NoPVol
  MOV  ChnType([SI]).CVol,AX
  MOV  ChnType([SI]).IVol,AX
 @NoPVol:
  CMP  ChnType([SI]).LstCmd,7
  JNZ  @NoGOption
  JMP  @GOption
 @NoGOption:
  MOV  BX,ChnType([SI]).LstIns
  CMP  BX,0
  JZ   @NoInsInPat
  MOV  ChnType([SI]).Color,BX
  SHL  BX,1
  SHL  BX,1
  SHL  BX,1
  SHL  BX,1
  SHL  BX,1
  ADD  BX,(OFFSET InsB)-32
  MOV  ChnType([SI]).NInsOfs,BX
  CMP  ChnType([SI]).LstPVol,41H
  JNZ  @LstPVolNo41
  MOV  AL,InsType([BX]).Volm
  XOR  AH,AH
  MOV  ChnType([SI]).CVol,AX
  MOV  ChnType([SI]).IVol,AX
 @LstPVolNo41:
  MOV  AX,InsType([BX]).Tran
  MOV  ChnType([SI]).InsTrns,AX
  MOV  AX,InsType([BX+2]).Inst.WORD
  CMP  AX,0
  JNZ  @ItIns
  MOV  ChnType([SI]).LstNote,0FEH
 @ItIns:
  MOV  ChnType([SI]).InsSeg,AX
  MOV  AX,InsType([BX]).LopE
  CMP  AX,0FFFFH
  JZ   @NoLoop
  MOV  ChnType([SI]).InsEnd,AX
  MOV  AX,InsType([BX]).LopS
  MOV  ChnType([SI]).Loop,AX
  JMP  @NoInsInPat
 @NoLoop:
  MOV  ChnType([SI]).Loop,AX
  MOV  AX,InsType([BX]).Leng
  MOV  ChnType([SI]).InsEnd,AX
 @NoInsInPat:
  MOV  BX,ChnType([SI]).LstNote
  CMP  BX,0FEH
  JNZ  @ItNote
  XOR  AX,AX
  MOV  ChnType([SI]).TAdd,AX
  MOV  ChnType([SI]).InsOfs,AX
  MOV  ChnType([SI]).InsEnd,AX
  MOV  ChnType([SI]).Loop,0FFFFH
  JMP  @CheckOpt
 @ItNote:
  CMP  BX,0FFH
  JZ   @CheckOpt
  MOV  ChnType([SI]).TmpNote,BX
  MOV  AX,ChnType([SI]).CVol
  SHR  AL,1
  MOV  ChnType([SI]).LevVol,AX
  MOV  ChnType([SI]).LevVol1,AX
  SHL  BX,1
  MOV  AX,NTab[BX].WORD
  MOV  CX,2100H
  MUL  CX
  MOV  CX,ChnType([SI]).InsTrns
  CMP  CX,0
  JNZ  @NoZeroTrans
  MOV  CX,22B8H
 @NoZeroTrans:
  DIV  CX
  MOV  ChnType([SI]).TmpTrn1,AX
  MOV  ChnType([SI]).TmpTrn2,AX
  CALL MulTran
  XOR  AX,AX
  MOV  ChnType([SI]).TAdd,AX
  MOV  ChnType([SI]).InsOfs,AX
 @CheckOpt:
  CALL CheckOptions
  RET
 @GOption:
  MOV  BX,ChnType([SI]).LstNote
  CMP  BX,0FFH
  JZ   @DoneGOp
  SHL  BX,1
  MOV  AX,NTab[BX].WORD
  MOV  ChnType([SI]).TmpTrn2,AX
 @DoneGOp:
END;

PROCEDURE ResetVars;NEAR;ASSEMBLER;
ASM
  MOV  ES,[PatB+2].WORD
  INC  ChnType([SI]).Row
  CMP  ChnType([SI]).Row,40H
  JC   @NoOverPat
  MOV  ChangePat,True
 @NoOverPat:
  CMP  ChnType([SI]).On,0
  JZ   @OFF
  MOV  BX,ChnType([SI]).PatOfs
  XOR  AH,AH
  MOV  AL,ES:[BX]
  MOV  ChnType([SI]).LstNote,AX
  MOV  AL,ES:[BX+1]
  SHR  AL,1
  SHR  AL,1
  SHR  AL,1
  MOV  ChnType([SI]).LstIns,AX
  MOV  AL,ES:[BX+1]
  AND  AL,7
  MOV  DL,ES:[BX+2]
  SHR  DL,1
  AND  DL,78H
  OR   AL,DL
  MOV  ChnType([SI]).LstPVol,AX
  MOV  AL,ES:[BX+2]
  AND  AL,0FH
  MOV  ChnType([SI]).LstCmd,AX
  MOV  AL,ES:[BX+3]
  MOV  ChnType([SI]).LstInfo,AX
  ADD  BX,10H
  MOV  ChnType([SI]).PatOfs,BX
  CALL SetNoteTrans
  CMP  ChnType([SI]).LstCmd,9
  JNZ  @DoneResetVars
  CALL DoCommand
 @DoneResetVars:
  RET
 @OFF:
  ADD  CHNTYPE([SI]).PATOFS,10H
END;

PROCEDURE Stack08;NEAR;ASSEMBLER;
ASM
  DW 0 { For CS IP and FLAGS   }
  DW 0
  DW 0
  DW 0 { Add Play Proc Segment }
  DW 0 { Add Play Proc Offset  }
  DW 0
END;

PROCEDURE SetAddProcAddr(P:Pointer);NEAR;
TYPE
  SO =RECORD
        O,S:Word;
      END;
BEGIN
  MemW[Seg(Stack08):Ofs(Stack08)+6]:=SO(P).O;
  MemW[Seg(Stack08):Ofs(Stack08)+8]:=SO(P).S;
END;

PROCEDURE AddPlay;NEAR;ASSEMBLER;
ASM
  PUSHF
  PUSH   AX
  PUSH   BX
  PUSH   CX
  PUSH   DX
  PUSH   ES
  PUSH   DS
  PUSH   SI
  MOV    AX,SEG Cw
  MOV    DS,AX
  MOV    AX,TempoD16
  CMP    AX,0
  JZ     @Td16z
  DEC    AX
  MOV    TempoD16,AX
  MOV    SI,OFFSET Ch1
  CALL   DoCommand
  MOV    SI,OFFSET Ch2
  CALL   DoCommand
  MOV    SI,OFFSET Ch3
  CALL   DoCommand
  MOV    SI,OFFSET Ch4
  CALL   DoCommand
  JMP    @ResetVol
 @Td16z:
  CMP    Play1Note,False
  JZ     @ResetVol
  CMP    ChangePat,True
  JNZ    @NoChgPat
  MOV    ChangePat,False
  CALL   ChangePattern
 @NoChgPat:
  MOV    SI,OFFSET Ch1
  CALL   ResetVars
  MOV    SI,OFFSET Ch2
  CALL   ResetVars
  MOV    SI,OFFSET Ch3
  CALL   ResetVars
  MOV    SI,OFFSET Ch4
  CALL   ResetVars
  MOV    AX,TempoD16S
  CMP    AX,0
  JZ     @ZeroTempo
  DEC    AX
 @ZeroTempo:
  MOV    TempoD16,AX
 @ResetVol:
  MOV    AX,Ch1.CVol
  MUL    GVolume1
  MOV    CL,6
  SHR    AX,CL
  MOV    Ch1.Volume,AL
  MOV    AX,Ch2.CVol
  MUL    GVolume2
  SHR    AX,CL
  MOV    Ch2.Volume,AL
  MOV    AX,Ch3.CVol
  MUL    GVolume3
  SHR    AX,CL
  MOV    Ch3.Volume,AL
  MOV    AX,Ch4.CVol
  MUL    GVolume4
  SHR    AX,CL
  MOV    Ch4.Volume,AL
  CMP    Setup.TimerOn,False
  JZ     @DoneAddPlay
  MOV    AX,TimerA
  ADD    AX,TimerC
  MOV    TimerA,AX
  JNC    @DoneAddPlay
  PUSHF
  CALL   Ov08
 @DoneAddPlay:
  POP    SI
  POP    DS
  POP    ES
  POP    DX
  POP    CX
  POP    BX
  POP    AX
  POPF
  PUSH   CS:[Stack08+2].WORD
  PUSH   CS:[Stack08+0].WORD
  RETF
END;

PROCEDURE NulInt08;NEAR;ASSEMBLER;
ASM
  PUSH  AX
  PUSH  BX
  PUSH  CX
  PUSH  DX
  PUSH  ES
  PUSH  DS
  MOV   AX,SEG Cw
  MOV   DS,AX
  MOV   DX,0FFFFH
  XOR   CL,CL
  LES   BX,Ch1.InsOfs.Pointer
  CMP   BX,Ch1.InsEnd
  JC    @Calc1
  CMP   Ch1.Loop,DX
  JZ    @ChDone1
  MOV   BX,Ch1.Loop
  MOV   Ch1.InsOfs,BX
  JMP   @Calc1
 @ChDone1:
  MOV   Ch1.Free,1
  JMP   @Ch2
 @Calc1:
  MOV   AX,Ch1.Trans2
  ADD   Ch1.TAdd,AX
  ADC   BX,Ch1.Trans1
  MOV   Ch1.InsOfs,BX
  MOV   BL,ES:[BX]
  MOV   BH,Ch1.Volume
  ADD   CL,VTab[BX].Byte
 @Ch2:
  LES   BX,Ch2.InsOfs.Pointer
  CMP   BX,Ch2.InsEnd
  JC    @Calc2
  CMP   Ch2.Loop,DX
  JZ    @ChDone2
  MOV   BX,Ch2.Loop
  MOV   Ch2.InsOfs,BX
  JMP   @Calc2
 @ChDone2:
  MOV   Ch2.Free,1
  JMP   @Ch3
 @Calc2:
  MOV   AX,Ch2.Trans2
  ADD   Ch2.TAdd,AX
  ADC   BX,Ch2.Trans1
  MOV   Ch2.InsOfs,BX
  MOV   BL,ES:[BX]
  MOV   BH,Ch2.Volume
  ADD   CL,VTab[BX].Byte
 @Ch3:
  LES   BX,Ch3.InsOfs.Pointer
  CMP   BX,Ch3.InsEnd
  JC    @Calc3
  CMP   Ch3.Loop,DX
  JZ    @ChDone3
  MOV   BX,Ch3.Loop
  MOV   Ch3.InsOfs,BX
  JMP   @Calc3
 @ChDone3:
  MOV   Ch3.Free,1
  JMP   @Ch4
 @Calc3:
  MOV   AX,Ch3.Trans2
  ADD   Ch3.TAdd,AX
  ADC   BX,Ch3.Trans1
  MOV   Ch3.InsOfs,BX
  MOV   BL,ES:[BX]
  MOV   BH,Ch3.Volume
  ADD   CL,VTab[BX].Byte
 @Ch4:
  LES   BX,Ch4.InsOfs.Pointer
  CMP   BX,Ch4.InsEnd
  JC    @Calc4
  CMP   Ch4.Loop,DX
  JZ    @ChDone4
  MOV   BX,Ch4.Loop
  MOV   Ch4.InsOfs,BX
  JMP   @Calc4
 @ChDone4:
  MOV   Ch4.Free,1
  JMP   @Ch5
 @Calc4:
  MOV   AX,Ch4.Trans2
  ADD   Ch4.TAdd,AX
  ADC   BX,Ch4.Trans1
  MOV   Ch4.InsOfs,BX
  MOV   BL,ES:[BX]
  MOV   BH,Ch4.Volume
  ADD   CL,VTab[BX].Byte
 @Ch5:
  MOV   AL,CL
  ADD   AL,80H
  PUSH  BX
  PUSH  ES
  MOV   BX,SpTabSeg
  MOV   ES,BX
  MOV   BX,SpTabOfs
  XLAT
  POP   ES
  POP   BX
  DEC   AddWCur
  JZ    @Trouble
  INC   FastTime
  MOV   AL,20H
  OUT   20H,AL
  POP   DS
  POP   ES
  POP   DX
  POP   CX
  POP   BX
  POP   AX
  IRET
@Trouble:
  MOV   AX,AddWBegin
  MOV   AddWCur,AX
  INC   FastTime
  MOV   AL,20H
  OUT   20h,AL
  POP   DS
  POP   ES
  POP   DX
  POP   CX
  POP   BX
  POP   AX
  POP   CS:[Stack08+0].Word
  POP   CS:[Stack08+2].Word
  PUSH  CS
  PUSH  CS:[Stack08+6].Word
  IRET
END;

PROCEDURE SpeakerInt08;NEAR;ASSEMBLER;
ASM
  PUSH  AX
  PUSH  BX
  PUSH  CX
  PUSH  DX
  PUSH  ES
  PUSH  DS
  MOV   AX,SEG Cw
  MOV   DS,AX
  MOV   DX,0FFFFH
  XOR   CL,CL
  LES   BX,Ch1.InsOfs.Pointer
  CMP   BX,Ch1.InsEnd
  JC    @Calc1
  CMP   Ch1.Loop,DX
  JZ    @ChDone1
  MOV   BX,Ch1.Loop
  MOV   Ch1.InsOfs,BX
  JMP   @Calc1
 @ChDone1:
  MOV   Ch1.Free,1
  JMP   @Ch2
 @Calc1:
  MOV   AX,Ch1.Trans2
  ADD   Ch1.TAdd,AX
  ADC   BX,Ch1.Trans1
  MOV   Ch1.InsOfs,BX
  MOV   BL,ES:[BX]
  MOV   BH,Ch1.Volume
  ADD   CL,VTab[BX].Byte
 @Ch2:
  LES   BX,Ch2.InsOfs.Pointer
  CMP   BX,Ch2.InsEnd
  JC    @Calc2
  CMP   Ch2.Loop,DX
  JZ    @ChDone2
  MOV   BX,Ch2.Loop
  MOV   Ch2.InsOfs,BX
  JMP   @Calc2
 @ChDone2:
  MOV   Ch2.Free,1
  JMP   @Ch3
 @Calc2:
  MOV   AX,Ch2.Trans2
  ADD   Ch2.TAdd,AX
  ADC   BX,Ch2.Trans1
  MOV   Ch2.InsOfs,BX
  MOV   BL,ES:[BX]
  MOV   BH,Ch2.Volume
  ADD   CL,VTab[BX].Byte
 @Ch3:
  LES   BX,Ch3.InsOfs.Pointer
  CMP   BX,Ch3.InsEnd
  JC    @Calc3
  CMP   Ch3.Loop,DX
  JZ    @ChDone3
  MOV   BX,Ch3.Loop
  MOV   Ch3.InsOfs,BX
  JMP   @Calc3
 @ChDone3:
  MOV   Ch3.Free,1
  JMP   @Ch4
 @Calc3:
  MOV   AX,Ch3.Trans2
  ADD   Ch3.TAdd,AX
  ADC   BX,Ch3.Trans1
  MOV   Ch3.InsOfs,BX
  MOV   BL,ES:[BX]
  MOV   BH,Ch3.Volume
  ADD   CL,VTab[BX].Byte
 @Ch4:
  LES   BX,Ch4.InsOfs.Pointer
  CMP   BX,Ch4.InsEnd
  JC    @Calc4
  CMP   Ch4.Loop,DX
  JZ    @ChDone4
  MOV   BX,Ch4.Loop
  MOV   Ch4.InsOfs,BX
  JMP   @Calc4
 @ChDone4:
  MOV   Ch4.Free,1
  JMP   @Ch5
 @Calc4:
  MOV   AX,Ch4.Trans2
  ADD   Ch4.TAdd,AX
  ADC   BX,Ch4.Trans1
  MOV   Ch4.InsOfs,BX
  MOV   BL,ES:[BX]
  MOV   BH,Ch4.Volume
  ADD   CL,VTab[BX].Byte
 @Ch5:
  MOV   AL,CL
  ADD   AL,80H
  PUSH  BX
  PUSH  ES
  MOV   BX,SpTabSeg
  MOV   ES,BX
  MOV   BX,SpTabOfs
  XLAT
  POP   ES
  POP   BX
  OUT   42H,AL
  DEC   AddWCur
  JZ    @Trouble
  INC   FastTime
  MOV   AL,20H
  OUT   20H,AL
  POP   DS
  POP   ES
  POP   DX
  POP   CX
  POP   BX
  POP   AX
  IRET
@Trouble:
  MOV   AX,AddWBegin
  MOV   AddWCur,AX
  INC   FastTime
  MOV   AL,20H
  OUT   20h,AL
  POP   DS
  POP   ES
  POP   DX
  POP   CX
  POP   BX
  POP   AX
  POP   CS:[Stack08+0].Word
  POP   CS:[Stack08+2].Word
  PUSH  CS
  PUSH  CS:[Stack08+6].Word
  IRET
END;

PROCEDURE CovoxInt08;NEAR;ASSEMBLER;
ASM
  PUSH  AX
  PUSH  BX
  PUSH  CX
  PUSH  DX
  PUSH  ES
  PUSH  DS
  MOV   AX,SEG Cw
  MOV   DS,AX
  MOV   DX,0FFFFH
  XOR   CL,CL
  LES   BX,Ch1.InsOfs.Pointer
  CMP   BX,Ch1.InsEnd
  JC    @Calc1
  CMP   Ch1.Loop,DX
  JZ    @ChDone1
  MOV   BX,Ch1.Loop
  MOV   Ch1.InsOfs,BX
  JMP   @Calc1
 @ChDone1:
  MOV   Ch1.Free,1
  JMP   @Ch2
 @Calc1:
  MOV   AX,Ch1.Trans2
  ADD   Ch1.TAdd,AX
  ADC   BX,Ch1.Trans1
  MOV   Ch1.InsOfs,BX
  MOV   BL,ES:[BX]
  MOV   BH,Ch1.Volume
  ADD   CL,VTab[BX].Byte
 @Ch2:
  LES   BX,Ch2.InsOfs.Pointer
  CMP   BX,Ch2.InsEnd
  JC    @Calc2
  CMP   Ch2.Loop,DX
  JZ    @ChDone2
  MOV   BX,Ch2.Loop
  MOV   Ch2.InsOfs,BX
  JMP   @Calc2
 @ChDone2:
  MOV   Ch2.Free,1
  JMP   @Ch3
 @Calc2:
  MOV   AX,Ch2.Trans2
  ADD   Ch2.TAdd,AX
  ADC   BX,Ch2.Trans1
  MOV   Ch2.InsOfs,BX
  MOV   BL,ES:[BX]
  MOV   BH,Ch2.Volume
  ADD   CL,VTab[BX].Byte
 @Ch3:
  LES   BX,Ch3.InsOfs.Pointer
  CMP   BX,Ch3.InsEnd
  JC    @Calc3
  CMP   Ch3.Loop,DX
  JZ    @ChDone3
  MOV   BX,Ch3.Loop
  MOV   Ch3.InsOfs,BX
  JMP   @Calc3
 @ChDone3:
  MOV   Ch3.Free,1
  JMP   @Ch4
 @Calc3:
  MOV   AX,Ch3.Trans2
  ADD   Ch3.TAdd,AX
  ADC   BX,Ch3.Trans1
  MOV   Ch3.InsOfs,BX
  MOV   BL,ES:[BX]
  MOV   BH,Ch3.Volume
  ADD   CL,VTab[BX].Byte
 @Ch4:
  LES   BX,Ch4.InsOfs.Pointer
  CMP   BX,Ch4.InsEnd
  JC    @Calc4
  CMP   Ch4.Loop,DX
  JZ    @ChDone4
  MOV   BX,Ch4.Loop
  MOV   Ch4.InsOfs,BX
  JMP   @Calc4
 @ChDone4:
  MOV   Ch4.Free,1
  JMP   @Ch5
 @Calc4:
  MOV   AX,Ch4.Trans2
  ADD   Ch4.TAdd,AX
  ADC   BX,Ch4.Trans1
  MOV   Ch4.InsOfs,BX
  MOV   BL,ES:[BX]
  MOV   BH,Ch4.Volume
  ADD   CL,VTab[BX].Byte
 @Ch5:
  MOV   AL,CL
  ADD   AL,80H
  MOV   DX,Setup.Lpt
  OUT   DX,AL
  DEC   AddWCur
  JZ    @Trouble
  INC   FastTime
  MOV   AL,20H
  OUT   20H,AL
  POP   DS
  POP   ES
  POP   DX
  POP   CX
  POP   BX
  POP   AX
  IRET
@Trouble:
  MOV   AX,AddWBegin
  MOV   AddWCur,AX
  INC   FastTime
  MOV   AL,20H
  OUT   20h,AL
  POP   DS
  POP   ES
  POP   DX
  POP   CX
  POP   BX
  POP   AX
  POP   CS:[Stack08+0].Word
  POP   CS:[Stack08+2].Word
  PUSH  CS
  PUSH  CS:[Stack08+6].Word
  IRET
END;

PROCEDURE BlasterInt08;NEAR;ASSEMBLER;
ASM
  PUSH  AX
  PUSH  BX
  PUSH  CX
  PUSH  DX
  PUSH  ES
  PUSH  DS
  MOV   AX,SEG Cw
  MOV   DS,AX
  MOV   DX,0FFFFH
  XOR   CL,CL
  LES   BX,Ch1.InsOfs.Pointer
  CMP   BX,Ch1.InsEnd
  JC    @Calc1
  CMP   Ch1.Loop,DX
  JZ    @ChDone1
  MOV   BX,Ch1.Loop
  MOV   Ch1.InsOfs,BX
  JMP   @Calc1
 @ChDone1:
  MOV   Ch1.Free,1
  JMP   @Ch2
 @Calc1:
  MOV   AX,Ch1.Trans2
  ADD   Ch1.TAdd,AX
  ADC   BX,Ch1.Trans1
  MOV   Ch1.InsOfs,BX
  MOV   BL,ES:[BX]
  MOV   BH,Ch1.Volume
  ADD   CL,VTab[BX].Byte
 @Ch2:
  LES   BX,Ch2.InsOfs.Pointer
  CMP   BX,Ch2.InsEnd
  JC    @Calc2
  CMP   Ch2.Loop,DX
  JZ    @ChDone2
  MOV   BX,Ch2.Loop
  MOV   Ch2.InsOfs,BX
  JMP   @Calc2
 @ChDone2:
  MOV   Ch2.Free,1
  JMP   @Ch3
 @Calc2:
  MOV   AX,Ch2.Trans2
  ADD   Ch2.TAdd,AX
  ADC   BX,Ch2.Trans1
  MOV   Ch2.InsOfs,BX
  MOV   BL,ES:[BX]
  MOV   BH,Ch2.Volume
  ADD   CL,VTab[BX].Byte
 @Ch3:
  LES   BX,Ch3.InsOfs.Pointer
  CMP   BX,Ch3.InsEnd
  JC    @Calc3
  CMP   Ch3.Loop,DX
  JZ    @ChDone3
  MOV   BX,Ch3.Loop
  MOV   Ch3.InsOfs,BX
  JMP   @Calc3
 @ChDone3:
  MOV   Ch3.Free,1
  JMP   @Ch4
 @Calc3:
  MOV   AX,Ch3.Trans2
  ADD   Ch3.TAdd,AX
  ADC   BX,Ch3.Trans1
  MOV   Ch3.InsOfs,BX
  MOV   BL,ES:[BX]
  MOV   BH,Ch3.Volume
  ADD   CL,VTab[BX].Byte
 @Ch4:
  LES   BX,Ch4.InsOfs.Pointer
  CMP   BX,Ch4.InsEnd
  JC    @Calc4
  CMP   Ch4.Loop,DX
  JZ    @ChDone4
  MOV   BX,Ch4.Loop
  MOV   Ch4.InsOfs,BX
  JMP   @Calc4
 @ChDone4:
  MOV   Ch4.Free,1
  JMP   @Ch5
 @Calc4:
  MOV   AX,Ch4.Trans2
  ADD   Ch4.TAdd,AX
  ADC   BX,Ch4.Trans1
  MOV   Ch4.InsOfs,BX
  MOV   BL,ES:[BX]
  MOV   BH,Ch4.Volume
  ADD   CL,VTab[BX].Byte
 @Ch5:
  MOV   DX,Setup.sb
	add		DX,0ch

@PL0:
	in    al,dx
	and		al,al
	js    @PL0
	mov   al,10h
	out   dx,al

@IL1:
	in    al,dx
	and		al,al
	js    @IL1

  MOV   AL,CL
  ADD   AL,80H
	OUT   DX,AL
  DEC   AddWCur
  JZ    @Trouble
  INC   FastTime
  MOV   AL,20H
  OUT   20H,AL
  POP   DS
  POP   ES
  POP   DX
  POP   CX
  POP   BX
  POP   AX
  IRET
@Trouble:
  MOV   AX,AddWBegin
  MOV   AddWCur,AX
  INC   FastTime
  MOV   AL,20H
  OUT   20h,AL
  POP   DS
  POP   ES
  POP   DX
  POP   CX
  POP   BX
  POP   AX
  POP   CS:[Stack08+0].Word
  POP   CS:[Stack08+2].Word
  PUSH  CS
  PUSH  CS:[Stack08+6].Word
  IRET
END;

FUNCTION ReadSTM(Name:String):Boolean;
TYPE
  STMIns = RECORD
            Name  : Array[1..13] of char;
            Dsk   : Byte;
            Res1  : Word;
            Len   : Word;
            LoopS : Word;
            LoopE : Word;
            Vol   : Byte;
            Res2  : Byte;
            Tran  : Word;
            Res3  : Word;
            Res4  : Word;
            Sef   : Word;
           END;
VAR
  F : file;
  I : STMIns;
  A : word;
  L : longint;

BEGIN
  ReadSTM:=False;
  Assign(F,name);
  Reset(F,1);
  IF IOResult<>0 THEN Exit;
  BlockRead(F,SName,20);
  Seek(F,32);
  BlockRead(F,Gtempo,1);
  BlockRead(F,Cb,1);
  TotPat:=Cb;
  BlockRead(F,GVolume1,1);
  GVolume2:=GVolume1;
  GVolume3:=GVolume1;
  GVolume4:=GVolume1;
  Seek(F,48);
  FOR CW:=1 TO 31 DO
  BEGIN
    BlockRead(f,I,SizeOf(I));
    InsB[cw].Name:='';
    FOR A:=1 TO 13 DO IF I.Name[A]<>#0 THEN
      InsB[Cw].Name:=InsB[Cw].Name+I.Name[A] ELSE InsB[Cw].Name:=InsB[Cw].Name+' ';
    InsB[cw].leng:=I.Len;
    InsB[cw].lops:=I.LoopS;
    InsB[cw].lope:=I.LoopE;
    InsB[cw].volm:=I.Vol;
    InsB[cw].tran:=I.Tran;
    insb[cw].res1:=I.Res1;
  END;
  FOR Cw1:=1 to 31 DO
  BEGIN
    IF InsB[Cw1].Leng<>0 THEN
    BEGIN
      L:=InsB[Cw1].Res1;
      L:=L*16;
      Seek(F,L);
      GetMem(InsB[Cw1].Inst,InsB[Cw1].Leng+4);
      FillChar(InsB[Cw1].Inst^,InsB[Cw1].Leng+4,0);
      IF Word(InsB[Cw1].Inst)<>0 THEN
      BEGIN
        W:=Word(InsB[Cw1].Inst);
        FreeMem(InsB[Cw1].Inst,InsB[Cw1].Leng+4);
        GetMem(InsB[Cw1].Inst,W);
        GetMem(InsB[Cw1].Inst,InsB[Cw1].Leng+4);
        FillChar(InsB[Cw1].Inst^,InsB[Cw1].Leng+4,0);
        IF Word(InsB[Cw1].Inst)<>0 THEN
        BEGIN
          WriteLn('Pointer error');
          Halt(1);
        END;
      END;
      BlockRead(F,InsB[cw1].Inst^,InsB[Cw1].Leng);
    END ELSE InsB[Cw1].Inst:=NIL;
  END;
  Seek(F,$410);
  BlockRead(F,OrdB,SizeOf(OrdB));
  L:=Cb;
  L:=L*1024;
  IF L>=65536 THEN L:=65535;
  BlockRead(F,PatB^,L);
  ReadSTM:=True;
  Close(F);
END;

PROCEDURE PlayAllPatterns(Device:byte);
BEGIN
  SpTabSeg:=Seg(SpTab);
  SpTabOfs:=Ofs(SpTab);
  IF OrdB[0]>=99 THEN Exit;
  FastTime  :=0;
  ASM
    MOV  AL,GTempo
    XOR  AH,AH
    CALL ResetTempoVars
  END;
  AddWCur   :=AddWBegin;
  TempoD16  :=TempoD16S;
  Play1Note :=True;
  ChangePat :=True;
  ASM
    MOV  DX,12H
    MOV  AX,34DCH
    DIV  Setup.PSpeed
    MOV  Port40,AX
  END;
  TimerC    :=Port40*AddWBegin;
  TimerA    :=0;
  CTempo    :=GTempo;
  NextPatO  :=Ofs(OrdB);
  CurOrder  :=Ofs(OrdB);
  LoopCount :=0;
  CurPat    :=OrdB[0];
  FirstOrd  :=Ofs(OrdB);
  NextPat   :=False;
  Ch1.PatOfs:=$00;
  Ch2.PatOfs:=$10;
  Ch3.PatOfs:=$20;
  Ch4.PatOfs:=$30;
  SetAddProcAddr(@AddPlay);
  if Device=1 then
    SetIntVec($08,@SpeakerInt08)
  else
  if Device=2 then
    SetIntVec($08,@CovoxInt08)
  else
  if Device=3 then
    SetIntVec($08,@BlasterInt08)
	else
		SetIntVec($08,@NulInt08);
  if Device=1 then
    begin
      Port[$61]:=Port[$61] OR 3;
      Port[$43]:=$90;
    end;
  if Device=3 then
    begin
			asm
				mov		dx,Setup.SB
				add		dx,6
				mov		al,1
				out		dx,al
				push	ax
				pop		ax
				mov		al,0
				out		dx,al
				mov   dx,Setup.SB

			@NL1:
				in    al,dx
				rol		al,1
				jc    @NL1
				mov   al,0D1h
				out		dx,al
			end;
    end;
  Port[$43] :=$36;
  Port[$40] :=Lo(Port40);
  Port[$40] :=Hi(Port40);
END;

procedure Stop;
  begin
    Port[$43]:=$36;
    SetIntVec($08,@Ov08);
    Port[$40]:=0;
    Port[$40]:=0;
  end;

procedure InitPlayer;
BEGIN
  Write('Wait preparate music ... ');
  SetDefaultSetup;
  GetIntVec($08,@Ov08);
  GTempo :=$60;
  GOctave:=$01;
  GVolume1:=$40;
  GVolume2:=$40;
  GVolume3:=$40;
  GVolume4:=$40;
  FillChar(OrdB,128,99);
  InsB[1].Name:='';
  InsB[1].Tran:=$2100;
  InsB[1].Volm:=$40;
  InsB[1].LopS:=0;
  InsB[1].LopE:=$FFFF;
  InsB[1].Leng:=0;
  InsB[1].Inst:=NIL;
  InsB[1].W1:=0;
  InsB[1].W2:=0;
  FOR Cb:=2 TO 31 DO
    InsB[Cb]:=InsB[1];
  GetMem(PatB,65535);
  ASM
    PUSH ES
    LES  DI,PatB
    MOV  CX,0FFFFH
  @Again:
    MOV  WORD PTR ES:[DI+0],01FFH
    MOV  WORD PTR ES:[DI+2],0080H
    ADD  DI,4
    LOOP @Again
    POP  ES
  END;
  InitTabs;
  FillChar(Ch1,SizeOf(Ch1),0);
  FillChar(Ch2,SizeOf(Ch1),0);
  FillChar(Ch3,SizeOf(Ch1),0);
  FillChar(Ch4,SizeOf(Ch1),0);
  Ch1.On:=$1;
  Ch2.On:=$1;
  Ch3.On:=$1;
  Ch4.On:=$1;
  Ch1.OnV:=$1;
  Ch2.OnV:=$1;
  Ch3.OnV:=$1;
  Ch4.OnV:=$1;
  Ch1.Loop:=$FFFF;
  Ch2.Loop:=$FFFF;
  Ch3.Loop:=$FFFF;
  Ch4.Loop:=$FFFF;
  Writeln('Ok');
END;
end.
