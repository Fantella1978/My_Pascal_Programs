Unit GetPut;


Interface

uses DOS;

Function TextImageSize( X1, Y1, X2, Y2 : byte ): word;
   (******************************************************************)
   (*  Syntax: Word := TextImageSize( X1, Y1, X2, Y2 );              *)
   (*     Returns the Size needed for the Buffer for Get/Put_Text    *)
   (******************************************************************)

Procedure Get_Text( Var Buffer; X1, Y1, X2, Y2: byte );
   (******************************************************************)
   (*  Syntax: Get_Text( Buffer, X1, Y1, X2, Y2 );                   *)
   (*     Copies the contents of a rectangular area defined by the   *)
   (*     byte expressions X1, Y1, X2, Y2 into the variable Buffer,  *)
   (*     which may be of any type.                                  *)
   (*     The minimum buffer size in bytes required to store the     *)
   (*     area is calculated as:                                     *)
   (*     Size = ((Y2-Y1+1)*(X2-X1+1)+1)*2                           *)
   (*        Y1 = Upper Left Row                                     *)
   (*        X1 = Upper Left Column                                  *)
   (*        Y2 = Lower Right Row                                    *)
   (*        X2 = Lower Right Column                                 *)
   (******************************************************************)



Procedure Put_Text( Var Buffer; X1, Y1: byte );
   (******************************************************************)
   (*  Syntax: Put_Text( Buffer, X1, Y1 );                           *)
   (*     Copies the contents of the variable onto a rectangular     *)
   (*     area of the screen. the byte expressions Y1, X1 define the *)
   (*     Upper Left corner of the region. Buffer is a variable of   *)
   (*     any type, in which an area of the screen has been          *)
   (*     previously stored.                                         *)
   (******************************************************************)



Implementation

Type
  BufTyp  = Array[0..32767] of byte;
  BufPtr  = ^BufTyp;

Function TextImageSize( X1, Y1, X2, Y2 : byte ): word;
Begin
  TextImageSize := ((Y2-Y1+1)*(X2-X1+1)+1)*2
end;


Procedure CurrentVideo( Var Width: Word; Var Address: BufPtr );
   (******************************************************************)
   (*  Syntax: CurrentVideo( Width, ScreenAddress );                 *)
   (*     Polls the BIOS and returns the width of the screen and     *)
   (*     the address of the beginning of screen memory.             *)
   (******************************************************************)
 Var
   R : Registers;
Begin
  R.AH := $0F;
  Intr( $10, R );
  Width := R.AH*2;
  if (R.AL = 7) or (R.AL=15) then
    Address := Ptr( $B000, 0000 )       {Monochrome Screen}
   else
    if (R.AL >-1) and (R.AL < 4 ) then
      Address := Ptr( $B800, 0000 )     {CGA}
     else
       Begin
         Writeln( 'Bad Mode' );
         halt(1);
       End;
end;


Procedure Get_Text( Var Buffer; X1, Y1, X2, Y2: byte );
Var
  VBuff   : BufTyp absolute Buffer;
  Screen  : BufPtr;
  Width   : Word;
  K,Yoff  : Word;
  I       : Byte;

Begin
  CurrentVideo( Width, Screen );
  VBuff[0] := ((X2-X1)*2)+2;
  VBuff[1] := Y2-Y1+1;
  K := 2;
  if ( Y1 > Y2 ) or ( X1 > X2 ) then Writeln( 'Parameters in wrong order' );
  Yoff := ((Y1-1) * Width) + ((X1-1) * 2);
  for I := Y1 to Y2 do
    begin
      Move( Screen^[Yoff],VBuff[K], VBuff[0] );
      inc(K,Vbuff[0]);
      inc(Yoff,Width);
    end;
End;


Procedure Put_Text( Var Buffer; X1, Y1: byte );
Var
  VBuff   : BufTyp absolute Buffer;
  Screen  : BufPtr;
  Width   : Word;
  K,Yoff  : integer;
  I       : Byte;

Begin
  CurrentVideo( Width, Screen );
  K := 2;
  Yoff := ((Y1-1) * Width) + ((X1-1) * 2);
  for I := 0 to VBuff[1]-1 do
      begin
        Move( VBuff[K], Screen^[Yoff] , VBuff[0] );
        K := K + VBuff[0];
        inc( Yoff, Width );
      end;
end;

end.
