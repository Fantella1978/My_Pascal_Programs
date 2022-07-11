unit vadim;

interface


Procedure WaitRetrace    ;
Function  GetCursor      :word;
PROCEDURE HideCursor     ;
PROCEDURE RestoreCursor  (Cursor_Shade:word);
Procedure winop          (cox,coy,cox1,coy1:integer;cl,cl1:byte);
Function  factorial      (fan:integer):double;
Function  lg             (logic:real):real;
Procedure pause          ;

implementation

uses
 crt,dos;

{****************************************************************************}

Procedure WaitRetrace;assembler;
asm
   push   dx
   push   ax
   mov    dx,3dah
@VRT:
   in     al,dx
   test   al,8
   jnz    @VRT
@NoVRT:
   in     al,dx
   test   al,8
   jz     @NoVRT
   pop    ax
   pop    dx
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


Procedure pause;
begin
  textcolor(cyan);
  writeln;
  writeln;
  writeln;
  write('                         PRESS');
  textcolor(yellow);
  write(' <ENTER> ');
  textcolor(cyan);
  write('TO CONTINUE');
  repeat until readkey=#13;
end;
{****************************************************************************}
Function lg(logic:real):real;
begin
  lg:=ln(logic)/ln(10);
end;
{****************************************************************************}
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
{****************************************************************************}
Function factorial(fan:integer):double;
var
  fact:double;
  fai:integer;
begin
  fact:=fan;
  for fai:=fan-1 downto 2 do fact:=fact*fai;
  factorial:=fact;
end;
end.