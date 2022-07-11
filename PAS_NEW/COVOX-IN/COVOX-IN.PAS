{$G+,R-,S-,Q-,I+,N-,E-}
uses
   Objects;

const
   VStr =          '1.0';

var
   Val             :Byte;
   Timer           :LongInt absolute $0040:$006C;
   LTimer          :LongInt;
   M               :TEmsStream;
   F               :TBufStream;

   Cfg             :Text;

   SndPort         :Word;
   Mask            :Byte;
   MaxVal          :Word;
   Shift           :Byte;
   Delay           :Word;

const
   SineTable    :Array [0..$FF] of Byte=
   (1,  1,  1,  1,  1,  1,  2,  2,  2,  2,  2,  2,  2,  2,
    2,  2,  2,  2,  2,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,
    3,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  5,
    5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  6,  6,  6,  6,  6,
    6,  6,  6,  6,  6,  6,  6,  6,  7,  7,  7,  7,  7,  7,  7,
    7,  7,  7,  7,  8,  8,  8,  8,  8,  8,  8,  8,  8,  8,  8,
    8,  8,  9,  9,  9,  9,  9,  9,  9, 10, 10, 10, 10, 11, 11,
   12, 12, 13, 14, 14, 15, 16, 17, 17, 18, 19, 20, 21, 22, 23,
   24, 26, 27, 28, 29, 30, 31, 33, 34, 35, 36, 38, 39, 40, 41,
   43, 44, 45, 46, 48, 49, 50, 51, 52, 53, 54, 55, 57, 58, 58,
   59, 60, 61, 62, 63, 64, 64, 65, 66, 66, 67, 67, 67, 67, 67,
   67, 68, 68, 68, 68, 68, 68, 68, 68, 68, 68, 68, 68, 68, 69,
   69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 70, 70, 70, 70, 70,
   70, 70, 70, 70, 70, 70, 70, 70, 71, 71, 71, 71, 71, 71, 71,
   71, 71, 71, 71, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72,
   72, 72, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 74, 74,
   74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 75, 75, 75, 75,
   75, 75);

type
   TSoundHeader=
   record
      IdRIFF       :Array [1..4] of Char;
      FileSize     :LongInt;
      IdWAVEfmt    :Array [1..8] of Char;
      Unknown1     :LongInt;
      Unknown2     :LongInt;
      Frequency1   :LongInt;
      Frequency2   :LongInt;
      Unknown3     :LongInt;
      IdData       :Array [1..4] of Char;
      DataSize     :LongInt;
   end;

const
   Header          :TSoundHeader=
   (idRIFF:'RIFF'; FileSize:0; IdWAVEfmt:'WAVEfmt ';
    Unknown1:$10; Unknown2:$10001; Frequency1:0; Frequency2:0;
    Unknown3:$80001; IdData:'data'; DataSize:0);

procedure InitSpeaker;
assembler;
asm
   mov  al,0B0h
   out  43h,al
   mov  al,1
   out  42h,al
   dec  al
   out  42h,al

   in   al,61h
   or   al,3
   out  61h,al

   mov  al,90h
   out  43h,al
end;

{
const
   ValNum          :Boolean= False;
var
   LVal            :Byte;
}

function  WriteVal                     :Boolean;
begin
{
   if ValNum then
   begin
      Val:=(Word(Val)+LVal) shr 1;
      M.Write(Val, 1);
   end else LVal:=Val;
   asm not ValNum end;
}

   M.Write(Val, 1);

   WriteVal:=False;
   if M.Status<>stOk then
   begin
      WriteLn('Out of memory'); WriteVal:=True;
   end;
end;

procedure ShowVal;
begin
   WriteLn(Val);
end;

begin
   WriteLn(
      #13#10+'CoVoX-IN  Version '+VStr+
      '  Copyright (c) 1995 by Solar Designer \ TorNad0'#13#10+
      #13#10+
      'Now digitizing ...'#13#10+
      #13#10+
      'Press'#13#10+
      ' Esc'#9'to save & exit'#13#10+
      ' Space'#9'to show digitized values');

   Assign(Cfg, 'COVOX-IN.CFG');
   Reset(Cfg);
   ReadLn(Cfg, SndPort);
   ReadLn(Cfg, Mask);
   ReadLn(Cfg, Shift);
   ReadLn(Cfg, Delay);
   Close(Cfg);

   if SndPort=1 then SndPort:=$378 else SndPort:=$278;
   if Mask=12 then Mask:=$20 else Mask:=$10;
   MaxVal:=1 shl Shift;
   if MaxVal>$FF then MaxVal:=$FF;
   Shift:=8-Shift;

   M.Init(1024, 1024);

   InitSpeaker;
   LTimer:=Timer; Val:=$80;
   asm
      mov  ax,SndPort
      mov  word ptr @@SndPort-2,ax
      mov  al,Mask
      mov  byte ptr @@Mask-1,al
      mov  al,Shift
      mov  byte ptr @@Shift1-1,al
      mov  byte ptr @@Shift2-1,al
      mov  ax,MaxVal
      mov  word ptr @@MaxVal-2,ax

      cmp  Delay,0
      jnz  @@LeaveDelay
      mov  ax,0FEEBh
      mov  cx,offset @@DelayEnd
      sub  cx,offset @@DelayStart
      add  ah,cl
      mov  word ptr @@DelayStart,ax
@@LeaveDelay:

@@NextByte:
      mov  cx,0
@@MaxVal:
      xor  ax,ax
@@Loop:
      mov  bl,al
      xor  ax,ax
      mov  al,cl
      xor  dx,dx
      mov  dl,ch
      add  ax,dx
      shr  ax,1

      push ax

      shl  ax,2
@@Shift1:
      mov  dx,0
@@SndPort:
      out  dx,al

@@DelayStart:
      push cx
      mov  cx,Delay
@@Delay:
      loop @@Delay
      pop  cx
@@DelayEnd:

      inc  dx
      in   al,dx
      test al,0
@@Mask:

      pop  ax

      jz   @@Lower
      mov  ch,al
      jmp  @@Next
@@Lower:
      mov  cl,al
@@Next:
      cmp  al,bl
      jne  @@Loop

      shl  ax,2
@@Shift2:
      mov  Val,al

      pusha
      call WriteVal
      or   al,al
      popa
      jnz  @@Error

      mov  bx,offset SineTable
      xlat
      out  42h,al

      in   al,60h

      cmp  al,39h
      jne  @@SkipShow
      pusha
      call ShowVal
      popa
@@SkipShow:

      cmp  al,1
      jne  @@NextByte

@@Error:
   end;

   M.Reset;

   if Timer=LTimer then Header.Frequency1:=10000 else
   Header.Frequency1:=M.GetSize*91 div 5 div (Timer-LTimer);
   Header.Frequency2:=Header.Frequency1;

   WriteLn(#13#10, Header.Frequency1, ' Hz');

   Port[SndPort]:=0;

   F.Init('COVOX-IN.WAV', stCreate, 16384);

   Header.DataSize:=M.GetSize;
   Header.FileSize:=Header.DataSize+SizeOf(Header)-8;

   M.Seek(0);
   F.Write(Header, SizeOf(Header));
   F.CopyFrom(M, M.GetSize);
   M.Done;

   F.Done;
end.
