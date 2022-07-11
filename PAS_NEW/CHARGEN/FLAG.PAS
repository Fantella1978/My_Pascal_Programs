(********************************************************************)
(*          Example for Turbo Pascal CharGen Unit Version 1.1       *)
(*                 Written by (C) Boris Konoplev 1993               *)
(*                                                                  *)
(*         This DEMO is not optimized, and not fully tested         *)
(*  You can change anything and use this stuff for your own needs   *)
(********************************************************************)

Program Russian_Flag;

uses Dos,Crt,CharGen;

const     Code : Array[0..3] of Byte = ( 220, 221, 222, 223); (* мноп *)
	 Stick = 219;                                         (* л    *)
     StickHead = 190;                                         (* О    *)
	 Xbase = 60;
	 Ybase = 2;

type      Symbol = Record
	       Ch:Char;
	       At:Byte;
	  end;

     Screen80x25 = Array[1..25,1..80] of Symbol;
      TFlagState = Array[0..3] of TChar;

var          Scr : ^Screen80x25;
       FlagTable : Array[0..31] of TFlagState;
	  PicPtr : Integer;
       OldInt1Ch : Pointer;
	FlagLine : String;


function CGADetect:Boolean;            (*  This is CharGen DEMO !  *)
 var TestChar1,TestChar2: TChar;       (* You can use other method *)
 begin                    
  GetChar(0,TestChar1);
  GetChar(0,TestChar2);
  Inc(TestChar1[0]);
  SetChar(0,TestChar1);
  GetChar(0,TestChar1);
  if TestChar1[0]=TestChar2[0] then CGADetect := True
                               else CGADetect := False;
  SetChar(0,TestChar2);
 end;

procedure InitScreen;
 var x,y: Integer;
 begin
  if CGADetect then
   begin
    WriteLn(#$D+#$A+'CGA not supported'+#$7+#$A);
    Halt(1);
   end;
      asm;                              (* Set Video Mode 3 *)
	mov ax,0003h
	int 10h
      end;
  Scr:=@Mem[$B800:0];
  ClrScr;
  WriteLn('Flag of Russia in Text Mode:');
 end;

procedure OutTextXY(X,Y: Integer; Attr: Byte; St: String);
 var i: Integer;
 begin
  for i:=1 to Length(St) do
   begin
    Scr^[Y][X+i-1].Ch:=St[i];
    Scr^[Y][X+i-1].At:=Attr;
   end;
 end;

procedure Flag; Interrupt;
 var i: Integer;
 begin
  for i:=0 to 3 do
   SetChar(Code[i],FlagTable[PicPtr][i]);
  Inc(PicPtr);
  if PicPtr>31 then PicPtr:=0;
 end;

procedure Shift4Byte(K:Integer; S1,S2,S3,S4:Byte; var D1,D2,D3,D4: Byte);
 var DD1,DD2: Word;
 begin
	      asm;
		mov al,S1
		mov ah,S2
		mov bl,S3
		mov bh,S4
		mov cx,K
		push bx
		rcr bx,1
		pop bx
@@1:            rcr ax,1
		rcr bx,1
		loop @@1
		mov DD1,ax
		mov DD2,bx
	      end;
  D1:=Lo(DD1);
  D2:=Hi(DD1);
  D3:=Lo(DD2);
  D4:=Hi(DD2);
 end;

procedure CalculateFlag;
 var i,j,k,l,m : Integer;
 begin
  for j:=0 to 3 do
   for i:=0 to 7 do
    begin
     l:=9+Round(2*Sin(2*PI*(J*8+i+k)/(8*4)));
     for m:=0 to l  do FlagTable[0][j][m]:=FlagTable[0][j][m] or      (1 shl i);
     for m:=l to $F do FlagTable[0][j][m]:=FlagTable[0][j][m] and Not (1 shl i);
    end;
  for k:=1 to 31 do
   for i:=0 to $F do
    Shift4Byte(K,FlagTable[0][0][i],FlagTable[0][1][i],
  		 FlagTable[0][2][i],FlagTable[0][3][i],
		 FlagTable[k][0][i],FlagTable[k][1][i],
		 FlagTable[k][2][i],FlagTable[k][3][i]);
 end;

procedure PrepareStick;
 var C: TChar;
    i,j,k,l,m : Integer;
 begin
  FlagLine:='';
  for j:=1 to 4 do
   for i:=3 downto 0 do
    FlagLine:=FlagLine+Chr(Code[i]);
  for i:=0 to $F do C[i]:=6;
  SetChar(Stick,C);
  for i:=0 to 3 do C[i]:=0;
  C[4]:=$F;
  C[5]:=$F;
  SetChar(StickHead,C);
 end;

procedure StartFlag;
 begin
  PicPtr:=0;
  GetIntVec($1C,OldInt1Ch);
  SetIntVec($1C,@Flag);
  Delay(100);
 end;

procedure DrawFlag;
 var i : Integer;
 begin
  OutTextXY(Xbase,YBase,$07,Chr(StickHead));
  for i:=1 to 5 do
   OutTextXY(Xbase,YBase+i,$07,Chr(Stick));
  OutTextXY(Xbase+1,Ybase  ,$70,FlagLine);
  OutTextXY(Xbase+1,Ybase+1,$17,FlagLine);
  OutTextXY(Xbase+1,Ybase+2,$41,FlagLine);
  OutTextXY(Xbase+1,Ybase+3,$04,FlagLine);
 end;

procedure Pause;
 begin
  asm;
	xor ax,ax
	int 16h
  end;
 end;

procedure StopFlag;
 begin
  SetIntVec($1C,OldInt1Ch);
 end;

procedure CloseScreen;
 begin
  asm;
      mov ax,0003h
      int 10h
  end;
  WriteLn('Oakie, Doakie Meester !'+#$A);
 end;

Begin
 InitScreen;
 CalculateFlag;
 PrepareStick;
 StartFlag;
 DrawFlag;
 Pause;
 StopFlag;
 CloseScreen;
End.
