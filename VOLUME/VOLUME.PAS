Program VolumeSB;

uses crt,getput;

var
     kod,cursor,size,sb1,sb2:word;
     i,Nvol:integer;
     Volume,vr,vl,p:byte;
     poi:pointer;
     SB_Present  : Boolean;
     SB_Address  : Word;

Procedure SB_Detect(Var _SB_Present:Boolean;Var _SB_Address:Word);
  Var
    i         : Boolean;
    j         : Word;
  Begin
    Asm
        mov     bx,200h
        mov     cx,10
      @SBD1:
        push    cx
        mov     dx,bx
        add     dx,06h
        mov     al,1
        out     dx,al
        in      al,dx
        in      al,dx
        in      al,dx
        in      al,dx
        mov     al,0
        out     dx,al
        mov     cx,100
        mov     dx,bx
        add     dx,0Ah
      @SBD2:
        in      al,dx
        cmp     al,0AAh
        loopnz  @SBD2
        pop     cx
        jz      @SBD_Found
        add     bx,10h
        loop    @SBD1
      @SBD_Not_Found:
        mov     i,0
        jmp     @SBD_Quit
      @SBD_Found:
        mov     i,1
        mov     j,bx
      @SBD_Quit:
    End;
    _SB_Present:=i;
    _SB_Address:=j;
  End;

Function Word2HEX(i:Word):String;
  Const
    HEX       : Array[$00..$0F] of Char = '0123456789ABCDEF';
  Var
    j         : String[4];
  Begin
    j[0]:=#4;
    j[1]:=HEX[i shr 12];
    j[2]:=HEX[i and $0FFF shr 8];
    j[3]:=HEX[i and $00FF shr 4];
    j[4]:=HEX[i and $000F];
    Word2HEX:=j;
  End;

function extended_readkey:word; assembler;
 asm
  mov ah,$10
  int $16
 end;

Function GetCursor:word;
var Cursor_Shade:word;
Begin
 ASM
   mov     ah,3
   xor     bh,bh
   int     10h
   mov     [Cursor_Shade],cx
 end;
 GetCursor:=Cursor_shade;
End;

PROCEDURE HideCursor; ASSEMBLER;
ASM
  mov     ah,1
  mov     cx,2020h
  int     10h
end;

PROCEDURE RestoreCursor(Cursor_Shade:word); ASSEMBLER;
ASM
  mov     ah,1
  mov     cx,[Cursor_Shade]
  int     10h
END;

Function GetVolumeLeft(num:byte):byte;assembler;
 asm
  mov al,num
  mov dx,sb1
  out dx,al
  mov dx,sb2
  in  al,dx
  and al,11110000b
  shr al,4
 end;

Function GetVolumeRight(num:byte):byte;assembler;
 asm
  mov al,num
  mov dx,sb1
  out dx,al
  mov dx,sb2
  in  al,dx
  and al,00001111b
 end;

Procedure SetVolumeLeft(num:byte;vol:byte);assembler;
 asm
  mov al,num
  mov dx,sb1
  out dx,al
  mov dx,sb2
  in  al,dx
  and al,00001111b
  push ax
  mov al,num
  mov dx,sb1
  out dx,al
  inc dx
  mov al,vol
  shl al,4
  and al,11110000b
  pop bx
  add al,bl
  out dx,al
 end;

Procedure SetVolumeRight(num:byte;vol:byte);assembler;
 asm
  mov al,num
  mov dx,sb1
  out dx,al
  inc dx
  in  al,dx
  and al,11110000b
  push ax
  mov al,num
  mov dx,sb1
  out dx,al
  inc dx
  pop ax
  add al,vol
  out dx,al
 end;

Procedure ShowVol(N:byte);
var p,x,y,b:byte;
begin
  case n of
   1:begin p:=$22;x:=4;y:=6;end;
   2:begin p:=$04;x:=12;y:=14;end;
   3:begin p:=$28;x:=20;y:=22;end;
   4:begin p:=$26;x:=28;y:=30;end;
   5:begin p:=$2e;x:=36;y:=38;end;
  end;
  b:=GetVolumeLeft(p);
  for i:=1 to 7 do
  begin
   gotoxy (x,9-i);
   write('°');
   gotoxy (y,9-i);
   write('°');
  end;
  for i:=0 to (b div 2)-1 do
  begin
   gotoxy (x,8-i);
   write('²');
  end;
  b:=GetVolumeRight(p);
  for i:=0 to (b div 2)-1 do
  begin
  gotoxy (y,8-i);
  write('²');
  end;
end;

Procedure winop(cox,coy,cox1,coy1:integer;cl,cl1:byte);
var
   nk:integer;
begin
   window(cox,coy,cox1,coy1);
   textbackground(cl);
   textcolor(cl1);
   clrscr;
   write('É');
   for nk:=0 to (cox1-cox-2) do write('Í');
   write('»');
   for nk:=1 to (coy1-coy-1) do
    begin
     gotoxy(1,1+nk);
     write('º');
     gotoxy(cox1-cox+1,1+nk);
     write('º');
    end;
   gotoxy(1,coy1-coy+1);
   write('È');
   for nk:=0 to (cox1-cox-2) do write('Í');
   window(cox,coy,cox1+1,coy1+1);
   gotoxy(cox1-cox+1,coy1-coy+1);
   write('¼');
   window(cox,coy,cox1+3,coy1+2);
   gotoxy(3,coy1-coy+2);
   textbackground(black);
   for nk:=0 to (cox1-cox) do write(' ');
   for nk:=0 to (coy1-coy) do
    begin
     gotoxy(cox1-cox+2,2+nk);
     write('  ');
    end;
   window(cox+1,coy+1,cox1-1,coy1-1);
   textcolor(cl1);
   textbackground(cl);
end;

Begin
 size:=TextImageSize(1,1,80,25);
 GetMem(poi,size);
 Get_Text(poi^,1,1,80,25);
 cursor:=GetCursor;
 HideCursor;
 SB_Detect(SB_Present,SB_Address);
 sb1:=SB_Address+4;sb2:=SB_Address+5;
 if SB_Present then
   begin
     winop(19,6,61,17,15,0);
     textcolor(black);
     textbackground(white);
     Write('SoundBlaster Volume Changer from Fantomas');
     gotoxy(9,10);
     Write('Sound Blaster port ',Word2HEX(SB_Address),'h');
     gotoxy(1,9);
     write('[Master ] Wave   CD-ROM  Syntez  Line-In');
     Nvol:=1;
     ShowVol(1);
     ShowVol(2);
     ShowVol(3);
     ShowVol(4);
     ShowVol(5);
     repeat
      kod:=Extended_Readkey;
      if (kod=19424)then
        begin
          gotoxy(-7+Nvol*8,9);
          write(' ');
          gotoxy(1+Nvol*8,9);
          write(' ');
          if Nvol>1 then dec(Nvol) else Nvol:=5;
          gotoxy(-7+Nvol*8,9);
          write('[');
          gotoxy(1+Nvol*8,9);
          write(']');
        end;
      if (kod=19936)then
        begin
          gotoxy(-7+Nvol*8,9);
          write(' ');
          gotoxy(1+Nvol*8,9);
          write(' ');
          if Nvol<5 then inc(Nvol) else Nvol:=1;
          gotoxy(-7+Nvol*8,9);
          write('[');
          gotoxy(1+Nvol*8,9);
          write(']');
        end;
      if (kod=18656)or(kod=20704)then
        begin
         case Nvol of
          1:p:=$22;
          2:p:=$04;
          3:p:=$28;
          4:p:=$26;
          5:p:=$2e
          end;
          if (kod=18656) and (GetVolumeLeft(p)<15)
           then SetVolumeLeft(p,GetVolumeLeft(p)+1);
          if (kod=18656) and (GetVolumeRight(p)<15)
           then SetVolumeRight(p,GetVolumeRight(p)+1);
          if (kod=20704) and (GetVolumeLeft(p)>1)
           then SetVolumeLeft(p,GetVolumeLeft(p)-2);
          if (kod=20704) and (GetVolumeRight(p)>1)
           then SetVolumeRight(p,GetVolumeRight(p)-2);
          ShowVol(Nvol);
        end;
     until (kod<>18656)and(kod<>20704)and(kod<>19424)and(kod<>19936);
   end
   else WriteLn('Sound Blaster not found');
 window(1,1,80,25);
 textcolor(white);
 textbackground(black);
 Put_Text(poi^,1,1);
 RestoreCursor(Cursor);
End.