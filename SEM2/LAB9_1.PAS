uses crt;
const
 a:array[1..5] of string=('      �㬬�     ',
                          '    ��������    ',
                          '  �ந��������  ',
                          '     ���⭮�    ',
                          '      ��室    ');
var
 ch,ch1:char;i,n:integer;c,b:real;z:byte;x1,x2,y:extended;
Procedure menu2(n:byte);
 Begin
   window(1,1,80,25);textbackground(1);clrscr;textcolor(14+blink);
  window(22,1,58,3);textbackground(2);clrscr;
  write(' ���������������������������������ͻ ');
  writeln(' �  ����樨 � �������묨 �᫠��  �');
  write(' ���������������������������������ͼ');
  window(30,9-n,50,15-n);textbackground(2);clrscr;textcolor(0);
  write(' �����������������ͻ ');
  writeln(' �                 �');
  writeln(' �                 �');
  writeln(' �                 �');
  writeln(' �                 �');
  writeln(' �                 �');
  write(' �����������������ͼ');
  window(32,10-n,48,14-n);textbackground(2);clrscr;
  textcolor(5);clrscr;
  for z:=1 to 5 do
  Begin
  write(a[z]);write(' ');
  End;
  window(32,11,48,11);textbackground(0);clrscr;textcolor(13);
  write(a[n+2]);
  End;
Procedure zast(ch1:char);
  Begin
   textcolor(lightgreen);
   window(1,1,80,25);textbackground(0);clrscr;
   window(20,1,60,3);textbackground(red);clrscr;
   writeln(' �������������������������������������ͻ');
   writeln(' �         ��p��� ���� #',ch1,'            �');
   write(' �������������������������������������ͼ');
  End;
procedure move;
 Begin
  zast(ch1);
  menu2(n);
 repeat
  if keypressed then
    ch:=readkey
  else ch:=#1;
  if ch=#80 then
   Begin
     n:=n+1;
     if n=4 then
      n:=-1;
      menu2(n);
    End;
    if ch=#72 then
     Begin
      n:=n-1;
      if n=-2 then
        n:=3;
       menu2(n);
    End;
    until ch=#13;
 End;
Procedure vbyte(var n:integer);
 var x1,x2:byte;y:real;
   Begin
 zast(ch1);
 window(20,7,60,9);textbackground(13);clrscr;textcolor(lightgreen);
 write(' ������ ��p��� �᫮ ');
 readln(x1);
 write(' ������ ��p�� �᫮ ');
 readln(x2);
 repeat
    move;
    case n of
     -1:y:=x1+x2;
     0:y:=x1-x2;
     1:y:=x1*x2;
     2:begin if x2=0 then exit; y:=x1/x2;end;
     3:exit
    End;
   window(25,20,55,23);textbackground(4);clrscr;
   textcolor(10);
   write(' ���������������������������ͻ ');
   write(' �    ������� ���᫥���   � ');
   write(' �         ',y:8:4,'          � ');
   write(' ���������������������������ͼ');
   readln;
   until false;
End;
Procedure vinteger(var n:integer);
 var x1,x2:integer;y:real;
Begin
 zast(ch1);
 window(20,7,60,9);textbackground(13);clrscr;
 write(' ������ ��p��� �᫮ ');
 readln(x1);
 write(' ������ ��p�� �᫮ ');
 readln(x2);
 repeat
   move;
   case n of
     -1:y:=x1+x2;
     0:y:=x1-x2;
     1:y:=x1*x2;
     2:begin if x2=0 then exit; y:=x1/x2;end;
     3:exit
    End;
  window(25,20,55,23);textbackground(4);clrscr;
   textcolor(10);
   write(' ���������������������������ͻ ');
   write(' �    ������� ���᫥���   � ');
   write(' �         ',y:8:4,'          � ');
   write(' ���������������������������ͼ');
   readln;
   until false;
End;
Procedure vlongint(var n:integer);
 var x1,x2:longint;y:real;
Begin
 zast(ch1);
 window(20,7,60,9);textbackground(13);clrscr;
 write(' ������ ��p��� �᫮ ');
 readln(x1);
 write(' ������ ��p�� �᫮ ');
 readln(x2);
 repeat
   move;
   case n of
     -1:y:=x1+x2;
     0:y:=x1-x2;
     1:y:=x1*x2;
     2:begin if x2=0 then exit; y:=x1/x2;end;
     3:exit
    End;
   window(25,20,55,23);textbackground(4);clrscr;
   textcolor(10);
   write(' ���������������������������ͻ ');
   write(' �    ������� ���᫥���   � ');
   write(' �',y:20:7,'       � ');
   write(' ���������������������������ͼ');
   readln;
   until false;
End;
 Procedure vreal(var n:integer);
 var x1,x2:real;y:real;
Begin
 zast(ch1);
 window(10,7,70,9);textbackground(13);clrscr;
 write(' ������ ��p��� �᫮ ');
 readln(x1);
 write(' ������ ��p�� �᫮ ');
 readln(x2);
 repeat
   move;
   case n of
     -1:y:=x1+x2;
     0:y:=x1-x2;
     1:y:=x1*x2;
     2:begin if x2=0 then exit; y:=x1/x2;end;
     3:exit
    End;
   window(20,20,60,23);textbackground(4);clrscr;
   textcolor(10);
   write(' �������������������������������������ͻ ');
   write(' �          ������� ���᫥���       � ');
   write(' �        ',y,'      � ');
   write(' �������������������������������������ͼ');
   readln;
   until false;
End;
Procedure vdouble(var n:integer);
 var x1,x2:double;y:double;
Begin
 zast(ch1);
 window(10,7,70,9);textbackground(13);clrscr;
 write(' ������ ��p��� �᫮ ');
 readln(x1);
 write(' ������ ��p�� �᫮ ');
 readln(x2);
 repeat
   move;
   case n of
     -1:y:=x1+x2;
     0:y:=x1-x2;
     1:y:=x1*x2;
     2:begin if x2=0 then exit; y:=x1/x2;end;
     3:exit
    End;
   window(20,20,60,23);textbackground(4);clrscr;
   textcolor(10);
   write(' �������������������������������������ͻ ');
   write(' �          ������� ���᫥���       � ');
   write(' �        ',y,'      � ');
   write(' �������������������������������������ͼ');
   readln;
   until false;
End;
 Procedure vextended(var n:integer);
 var x1,x2:extended;y:extended;
Begin
 zast(ch1);
 window(1,7,80,10);textbackground(13);clrscr;
 write(' ������ ��p��� �᫮ ');
 readln(x1);
 write(' ������ ��p�� �᫮ ');
 readln(x2);
 repeat
   move;
   case n of
     -1:y:=x1+x2;
     0:y:=x1-x2;
     1:y:=x1*x2;
     2:begin if x2=0 then exit; y:=x1/x2;end;
     3:exit
    End;
   window(20,20,60,23);textbackground(4);clrscr;
   textcolor(10);
   write(' �������������������������������������ͻ ');
   write(' �          ������� ���᫥���       � ');
   write(' �        ',y,'      � ');
   write(' �������������������������������������ͼ');
   readln;
   until false;
End;
procedure vcomplex(var n:integer);
 var d1,d2,m1,m2,x1,x2:real;
Begin
 zast(ch1);
 window(5,7,75,11);textbackground(13);clrscr;
 write(' ������ ����⢨⥫��� ���� ��p���� �᫠ ');
 readln(d1);
 write(' ������ ������ ���� ��p���� �᫠ ');
 readln(m1);
 write(' ������ ����⢨⥫��� ���� ��p��� �᫠ ');
 readln(d2);
 write(' ������ ������ ���� ��p��� �᫠ ');
 readln(m2);
 repeat
  move;
  window(20,20,60,23);textbackground(4);clrscr;
  case n of
   -1:Begin
      x1:=d1+d2;x2:=m1+m2;
     End;
   0:Begin
      x1:=d1-d2;x2:=m1-m2;
     End;
   1:Begin
      x1:=d1*d2-m1*m2;x2:=d1*m2+d2*m1;
     End;
   2:Begin
      if (round(d2*100000000)<>0) and (round(m2*100000000)<>0) then
       Begin
        x1:=(d1*d2+m1*m2)/(d2*d2+m2*m2);
        x2:=(d2*m1-d1*m2)/(d2*d2+m2*m2);
        textcolor(10);
        write(' �������������������������������������ͻ ');
        write(' �          ������� ���᫥���       � ');
        write(' �        ',x1:10:4,'+',x2:10:4,'i       � ');
        write(' �������������������������������������ͼ');
        readln;
       End
      else
       Begin
        textcolor(10);
        write(' �������������������������������������ͻ ');
        write(' �          ������� ���᫥���       � ');
        write(' �           �訡�� ���᫥���         � ');
        write(' �������������������������������������ͼ');
        readln;
       End
     End;
   3:exit;
  End;
   if n<>2 then
    Begin
     textcolor(10);
     write(' �������������������������������������ͻ ');
     write(' �          ������� ���᫥���       � ');
     write(' �        ',x1:10:4,'+',x2:10:4,'i       � ');
     write(' �������������������������������������ͼ');
     readln;
    End;
    until false;
 End;
procedure menu1;
Begin
  window(1,1,80,25);textbackground(0);clrscr;
  window(10,7,70,16);textbackground(4);clrscr;textcolor(14);
  writeln(' ���������������������������������������������������������ͻ');
  writeln(' �  1.   ���� ���� 楫�� �ᥫ, �� �p������� 255.        �');
  writeln(' �  2.   ���� ���� 楫�� �ᥫ ���筮� �筮��.           �');
  writeln(' �  3.   ���� ���� 楫�� �ᥫ ����襭��� �筮��.        �');
  writeln(' �  4.   ���� ���� ����⢥���� �ᥫ ���筮� �筮��.    �');
  writeln(' �  5.   ���� ���� ����⢥���� �ᥫ ������� �筮��.    �');
  writeln(' �  6.   ���� ���� ����⢥���� �ᥫ ����襭��� �筮��. �');
  writeln(' �  7.   ���� ���� ���������� �ᥫ.                      �');
  writeln(' �  8.   ��室.                                            �');
  write(' ���������������������������������������������������������ͼ');
  window(10,18,70,22);textbackground(red);clrscr;
  textcolor(lightgreen);
  write(' ���������������������������������������������������������ͻ ');
  write(' �     H����� ������� ᮮ⢥�������� ��p����� ��樨     � ');
  write(' �                                                         � ');
  gotoxy(1,4);
  write(' �                     H����� ENTER                       � ');
  write(' ���������������������������������������������������������ͼ');
  gotoxy(30,3);
  readln(ch1);
  case ch1 of
   '1':vbyte(n);
   '2':vinteger(n);
   '3':vlongint(n);
   '4':vreal(n);
   '5':vdouble(n);
   '6':vextended(n);
   '7':vcomplex(n);
   '8':halt;
  End;
End;
BEGIN
 window(1,1,80,25);textbackground(0);
 clrscr;
  repeat
   menu1;
  until false;
END.
