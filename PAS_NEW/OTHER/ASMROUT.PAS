
{ Assembler Routines For Turbo Pascal 6.0 By Dictator / Humanity 1993 }
{ ASM Routines Release #1 }

 Unit ASMRout;

    Interface


 Procedure YLine (Horizt : integer; Col_Byte : Byte);
 Procedure DrawPixel (Horizt : integer; Vertict : integer; col : byte);
 Procedure QuickWrite (AsciiWord : Byte);
 Procedure TurnVideoOff;
 Procedure TurnVideoOn;
 Function DosMajorVersion : Byte;
 Function DosMinorVersion : Byte;
 Procedure TurnVideoMode (ModeNumber : Byte);
 Function Pixel (X : Integer; Y : Integer; pagenum : byte) : Byte;
 Function DrivesCount : Integer;
 Procedure DriveSelect( Drive : Byte );
 Procedure SelectVideoPage ( Page : Byte );
 Procedure ScrUpWin (Rows : byte; Attri : byte; x1 : byte; y1 : byte; x2 : byte; y2 : byte);
 Procedure ScrDownWin (Rows : byte; Attri : byte; x1 : byte; y1 : byte; x2 : byte; y2 : byte);
 Procedure WaitForKey;
 Procedure Wait ( Time : Integer );

   Implementation

(****************************************************************************){

  YLine = Paints one row in grapichs mode. eg. Yline (40,15);

(****************************************************************************)}

Procedure YLine (Horizt : integer; col_byte : byte); Assembler;
     asm
       mov ax,1
       mov cx,319
 @@3:
      add cx,-1
      add ax,1
      mov ah,14;
      mov al,col_byte;
      mov cx,ax;
      mov dx,Horizt;
      int $10;
 loop @@3
    end;


(****************************************************************************){

  Drawpixel = Puts a pixel in X,Y point. eg. Drawpixel(10,200,15);

(****************************************************************************)}

Procedure DrawPixel (Horizt : integer; Vertict : integer; col : byte); Assembler;
     asm
      mov ah,14;
      mov al,col;
      mov cx,Horizt;
      mov dx,vertict;
      int $10;
    end;

(****************************************************************************){

  QuickWrite = Same as TP:s Write routine but 50 % faster! eg.
               QuickWrite(65); (Writes letter A)

(****************************************************************************)}

Procedure QuickWrite (AsciiWord : Byte); Assembler;
   asm
      mov al,AsciiWord
      Int 29h
   end;


(****************************************************************************){

  TurnVideo??? = Turns video-adapter on/off

(****************************************************************************)}


Procedure TurnVideoOff; Assembler;
  Asm
    mov ah,$12
    mov bl,$36
    mov al,$01
    int 10h
  end;

Procedure TurnVideoOn; Assembler;
  Asm
    mov ah,$12
    mov bl,$36
    mov al,$00
    int 10h
  end;

(****************************************************************************){

  Dos?????Version = Returns DOS version number. Format : MAJOR.MINOR
  eg. 6.10 (6 = Major , 10 = Minor)

(****************************************************************************)}


Function DosMajorVersion : Byte;
     Var a : byte;
begin
  asm
     mov ah,30
     int 21h
     mov a,al
  end;
 DosMajorVersion:=a;
 end;

Function DosMinorVersion : Byte;
     Var a : byte;
begin
  asm
     mov ah,30
     int 21h
     mov a,ah
  end;
 DosMinorVersion:=a;
 end;

(****************************************************************************){

  TurnVideoMode = Changes VideoMode. eg. TurnVideoMode($13);
                  (Changes to 320x200x256 mode)

(****************************************************************************)}


Procedure TurnVideoMode (ModeNumber : Byte); Assembler;
   Asm
      mov ah,0
      mov al,ModeNumber
        int 10h
     end;

(****************************************************************************){

  Pixel = Returns color of pixel in point X,Y. Eg. Color:=Pixel(100,100);

(****************************************************************************)}

Function Pixel (X : Integer; Y : Integer; pagenum : byte) : Byte;
       var a : byte;
  begin
      Asm
        mov ah,0d
        mov bh,pagenum
        mov cx,x
        mov dx,y
        int 10h
        mov a,al
      end;
  Pixel:=A;
end;

(****************************************************************************){

  DrivesCount = Returns amount of logical diskette drives (Floppy and HD)
                (1-26, A: - Z:) eg. HowMany:=DrivesCount;
(****************************************************************************)}


Function DrivesCount : Integer;
    Var a : byte;
    begin
     Asm
       mov ah,$0E
       int 21h
       mov a,al
     end;
  DrivesCount:=A;
end;

(****************************************************************************){

  DriveSelect = Changes current drive. (0-26, A: - Z:) eg.
                DriveSelect(0); (Changes to Drive A:)

(****************************************************************************)}


Procedure DriveSelect( Drive : Byte ); Assembler;
    Asm
      mov ah,$0E
      mov dl,Drive
      int 21h
   end;

(****************************************************************************){

  SelectVideoPage = Select VideoPage. Handy when using Tweaked mode.

(****************************************************************************)}

Procedure SelectVideoPage ( Page : Byte ); Assembler;
   Asm
      mov ah,5
      mov al,page
       int 10h
   end;

(****************************************************************************){

  Scr??Win = Scrolls text in TEXTMODE (co80,co40) (Up/Down). Syntax :
  ScrUpWin(#1,#2,#3,#4,#5,#6);

           #1 = Scroll how many rows. (When 0 the window will be blanked)
           #2 = Attribute to be used on blank line.
           #3 = Upper Left Corner (X)
           #4 = Upper Left Corner (Y)
           #5 = Lower Right Corner (X)
           #6 = Lower Right Corner (Y)

(****************************************************************************)}

Procedure ScrUpWin (Rows : byte; Attri : byte; x1 : byte; y1 : byte; x2 : byte; y2 : byte); Assembler;
   Asm
       mov ah,6
       mov al,rows
       mov bh,attri
       mov ch,y1
       mov cl,x1
       mov dh,y2
       mov dl,x2
        int 10h
   end;

Procedure ScrDownWin (Rows : byte; Attri : byte; x1 : byte; y1 : byte; x2 : byte; y2 : byte); Assembler;
   Asm
       mov ah,7
       mov al,rows
       mov bh,attri
       mov ch,y1
       mov cl,x1
       mov dh,y2
       mov dl,x2
        int 10h
   end;

(****************************************************************************){

  WaitForKey = Waits until key if pressed.

(****************************************************************************)}

Procedure WaitForKey; Assembler;
     asm
      mov ah,0
      int 16h
     end;

(****************************************************************************){

  Wait = Waits for a X microseconds

(****************************************************************************)}


Procedure Wait ( Time : Integer ); Assembler;
  asm
    mov ah,86
    mov cx,time
    int 15h
  end;

end.