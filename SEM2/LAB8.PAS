uses crt;
const
 a:array[1..4] of string=('      �㬬�     ',
                          '    ��������    ',
                          '  �ந��������  ',
                          '     ���⭮�  ');
var
 ch:char;i,n:integer;c,b,y:real;
Procedure menu2;
 Begin
  textbackground(0);clrscr;
  window(32,9,48,14);textbackground(2);clrscr;
  textcolor(4);clrscr;
  writeln;
  for i:=1 to 4 do
   Begin
   write(a[i]);write(' ');
   End;
 End;
Procedure vbyte;
 var x1,x2:byte;y:real;
Begin
 window(1,1,80,25);textbackground(0);clrscr;
 window(20,1,60,3);textbackground(red);clrscr;
 writeln(' �������������������������������������ͻ');
 writeln(' �         ��p��� ���� #1            �');
 write(' �������������������������������������ͼ');
 window(20,7,60,9);textbackground(13);clrscr;
 write(' ������ ��p��� �᫮ ');
 readln(x1);
 write(' ������ ��p�� �᫮ ');
 readln(x2);
 clrscr;
  menu2;
  window(32,10,48,10);textbackground(0);clrscr;textcolor(13);
  write(a[1]);
  n:=1;
 repeat
  if keypressed then
    ch:=readkey
  else ch:=#1;
  if ch=#80 then
   Begin
     menu2;
    if n=4 then
     n:=0;
     n:=n+1;
     window(32,n+9,48,n+9);textbackground(0);clrscr;
     textcolor(13);
     write(a[n]);
    End;
  if ch=#72 then
   Begin
     menu2;
    if n<2 then n:=5;
    n:=n-1;
    window(32,n+9,48,n+9);textbackground(0);clrscr;
    textcolor(13);
    write(a[n]);
  End;
 until ch=#13;
 window(29,20,51,21);textbackground(2);clrscr;
  case n of
   1:y:=x1+x2;
   2:y:=x1-x2;
   3:y:=x1*x2;
   4:y:=x1/x2;
  End;
   textcolor(4);
   writeln(' ������� ���᫥���');
   write('        ',y:6:4);
   readln;
End;
Procedure vinteger;
 var x1,x2:integer;y:real;
Begin
 window(1,1,80,25);textbackground(0);clrscr;
 window(20,1,60,3);textbackground(13);clrscr;
 writeln(' �������������������������������������ͻ');
 writeln(' �         ��p��� ���� #2            �');
 write(' �������������������������������������ͼ');
 window(20,7,60,9);textbackground(13);clrscr;
 write(' ������ ��p��� �᫮ ');
 readln(x1);
 write(' ������ ��p�� �᫮ ');
 readln(x2);
 clrscr;
  menu2;
  window(32,10,48,10);textbackground(0);clrscr;textcolor(13);
  write(a[1]);
  n:=1;
 repeat
  if keypressed then
    ch:=readkey
  else ch:=#1;
  if ch=#80 then
   Begin
     menu2;
    if n=4 then
     n:=0;
     n:=n+1;
     window(32,n+9,48,n+9);textbackground(0);clrscr;
     textcolor(13);
     write(a[n]);
    End;
  if ch=#72 then
   Begin
     menu2;
    if n<2 then n:=5;
    n:=n-1;
    window(32,n+9,48,n+9);textbackground(0);clrscr;
    textcolor(13);
    write(a[n]);
  End;
 until ch=#13;
 window(29,20,51,21);textbackground(2);clrscr;
  case n of
   1:y:=x1+x2;
   2:y:=x1-x2;
   3:y:=x1*x2;
   4:y:=x1/x2;
  End;
   textcolor(4);
   writeln(' ������� ���᫥���');
   write('        ',y:6:4);
   readln;
End;
Procedure vlongint;
 var x1,x2:longint;y:real;
Begin
 window(1,1,80,25);textbackground(0);clrscr;
 window(20,1,60,3);textbackground(13);clrscr;
 writeln(' �������������������������������������ͻ');
 writeln(' �         ��p��� ���� #3            �');
 write(' �������������������������������������ͼ');
 window(20,7,60,9);textbackground(13);clrscr;
 write(' ������ ��p��� �᫮ ');
 readln(x1);
 write(' ������ ��p�� �᫮ ');
 readln(x2);
 clrscr;
  menu2;
  window(32,10,48,10);textbackground(0);clrscr;textcolor(13);
  write(a[1]);
  n:=1;
 repeat
  if keypressed then
    ch:=readkey
  else ch:=#1;
  if ch=#80 then
   Begin
     menu2;
    if n=4 then
     n:=0;
     n:=n+1;
     window(32,n+9,48,n+9);textbackground(0);clrscr;
     textcolor(13);
     write(a[n]);
    End;
  if ch=#72 then
   Begin
     menu2;
    if n<2 then n:=5;
    n:=n-1;
    window(32,n+9,48,n+9);textbackground(0);clrscr;
    textcolor(13);
    write(a[n]);
  End;
 until ch=#13;
 window(29,20,51,21);textbackground(2);clrscr;
  case n of
   1:y:=x1+x2;
   2:y:=x1-x2;
   3:y:=x1*x2;
   4:y:=x1/x2;
  End;
   textcolor(4);
   write(' ������� ���᫥���');
   write('     ',y:10:9);
   readln;
End;
 Procedure vreal;
 var x1,x2:real;y:real;
Begin
 window(1,1,80,25);textbackground(0);clrscr;
 window(20,1,60,3);textbackground(red);clrscr;
 writeln(' �������������������������������������ͻ');
 writeln(' �         ��p��� ���� #4            �');
 write(' �������������������������������������ͼ');
 window(10,7,70,9);textbackground(13);clrscr;
 write(' ������ ��p��� �᫮ ');
 readln(x1);
 write(' ������ ��p�� �᫮ ');
 readln(x2);
 clrscr;
  menu2;
  window(32,10,48,10);textbackground(0);clrscr;textcolor(13);
  write(a[1]);
  n:=1;
 repeat
  if keypressed then
    ch:=readkey
  else ch:=#1;
  if ch=#80 then
   Begin
     menu2;
    if n=4 then
     n:=0;
     n:=n+1;
     window(32,n+9,48,n+9);textbackground(0);clrscr;
     textcolor(13);
     write(a[n]);
    End;
  if ch=#72 then
   Begin
     menu2;
    if n<2 then n:=5;
    n:=n-1;
    window(32,n+9,48,n+9);textbackground(0);clrscr;
    textcolor(13);
    write(a[n]);
  End;
 until ch=#13;
 window(20,20,60,21);textbackground(2);clrscr;
  case n of
   1:y:=x1+x2;
   2:y:=x1-x2;
   3:y:=x1*x2;
   4:y:=x1/x2;
  End;
   textcolor(4);
   writeln('           ������� ���᫥���');
   write('         ',y);
   readln;
End;
Procedure vdouble;
 var x1,x2:double;y:double;
Begin
 window(1,1,80,25);textbackground(0);clrscr;
 window(20,1,60,3);textbackground(red);clrscr;
 writeln(' �������������������������������������ͻ');
 writeln(' �         ��p��� ���� #5            �');
 write(' �������������������������������������ͼ');
 window(10,7,70,9);textbackground(13);clrscr;
 write(' ������ ��p��� �᫮ ');
 readln(x1);
 write(' ������ ��p�� �᫮ ');
 readln(x2);
 clrscr;
  menu2;
  window(32,10,48,10);textbackground(0);clrscr;textcolor(13);
  write(a[1]);
  n:=1;
 repeat
  if keypressed then
    ch:=readkey
  else ch:=#1;
  if ch=#80 then
   Begin
     menu2;
    if n=4 then
     n:=0;
     n:=n+1;
     window(32,n+9,48,n+9);textbackground(0);clrscr;
     textcolor(13);
     write(a[n]);
    End;
  if ch=#72 then
   Begin
     menu2;
    if n<2 then n:=5;
    n:=n-1;
    window(32,n+9,48,n+9);textbackground(0);clrscr;
    textcolor(13);
    write(a[n]);
  End;
 until ch=#13;
 window(20,20,60,21);textbackground(2);clrscr;
  case n of
   1:y:=x1+x2;
   2:y:=x1-x2;
   3:y:=x1*x2;
   4:y:=x1/x2;
  End;
   textcolor(4);
   writeln('           ������� ���᫥���');
   write('         ',y);
   readln;
End;
 Procedure vextended;
 var x1,x2:extended;y:extended;
Begin
 window(1,1,80,25);textbackground(0);clrscr;
 window(20,1,60,3);textbackground(red);clrscr;
 writeln(' �������������������������������������ͻ');
 writeln(' �         ��p��� ���� #6            �');
 write(' �������������������������������������ͼ');
 window(1,7,80,10);textbackground(13);clrscr;
 write(' ������ ��p��� �᫮ ');
 readln(x1);
 write(' ������ ��p�� �᫮ ');
 readln(x2);
 clrscr;
  menu2;
  window(32,10,48,10);textbackground(0);clrscr;textcolor(13);
  write(a[1]);
  n:=1;
 repeat
  if keypressed then
    ch:=readkey
  else ch:=#1;
  if ch=#80 then
   Begin
     menu2;
    if n=4 then
     n:=0;
     n:=n+1;
     window(32,n+9,48,n+9);textbackground(0);clrscr;
     textcolor(13);
     write(a[n]);
    End;
  if ch=#72 then
   Begin
     menu2;
    if n<2 then n:=5;
    n:=n-1;
    window(32,n+9,48,n+9);textbackground(0);clrscr;
    textcolor(13);
    write(a[n]);
  End;
 until ch=#13;
 window(20,20,60,21);textbackground(2);clrscr;
  case n of
   1:y:=x1+x2;
   2:y:=x1-x2;
   3:y:=x1*x2;
   4:y:=x1/x2;
  End;
   textcolor(4);
   writeln('           ������� ���᫥���');
   write('         ',y);
   readln;
End;
procedure vcomplex;
 var d1,d2,m1,m2,x1,x2:real;
Begin
 window(1,1,80,25);textbackground(0);clrscr;
 window(20,1,60,3);textbackground(red);clrscr;
 writeln(' �������������������������������������ͻ');
 writeln(' �         ��p��� ���� #7            �');
 write(' �������������������������������������ͼ');
 window(5,7,75,11);textbackground(13);clrscr;
 write(' ������ ����⢨⥫��� ���� ��p���� �᫠ ');
 readln(d1);
 write(' ������ ������ ���� ��p���� �᫠ ');
 readln(m1);
 write(' ������ ����⢨⥫��� ���� ��p��� �᫠ ');
 readln(d2);
 write(' ������ ������ ���� ��p��� �᫠ ');
 readln(m2);
 clrscr;
  menu2;
  window(32,10,48,10);textbackground(0);clrscr;textcolor(13);
  write(a[1]);
  n:=1;
 repeat
  if keypressed then
    ch:=readkey
  else ch:=#1;
  if ch=#80 then
   Begin
     menu2;
    if n=4 then
     n:=0;
     n:=n+1;
     window(32,n+9,48,n+9);textbackground(0);clrscr;
     textcolor(13);
     write(a[n]);
    End;
  if ch=#72 then
   Begin
     menu2;
    if n<2 then n:=5;
    n:=n-1;
    window(32,n+9,48,n+9);textbackground(0);clrscr;
    textcolor(13);
    write(a[n]);
  End;
 until ch=#13;
 window(20,20,60,21);textbackground(2);clrscr;
  case n of
   1:Begin
      x1:=d1+d2;x2:=m1+m2;
     End;
   2:Begin
      x1:=d1-d2;x2:=m1-m2;
     End;
   3:Begin
      x1:=d1*d2-m1*m2;x2:=d1*m2+d2*m1;
     End;
   4:Begin
      if (round(d2*100000000)<>0) and (round(m2*100000000)<>0) then
       Begin
        x1:=(d1*d2+m1*m2)/(d2*d2+m2*m2);
        x2:=(d2*m1-d1*m2)/(d2*d2+m2*m2);
       End;
     End;
  End;
   if (round(d2*100000000)=0) and (round(m2*1000000000)=0) then
    Begin
     textcolor(4);
     writeln('           ������� ���᫥���');
     write('             �訡�� ���᫥���');
     readln;
    End
   else
    Begin
     textcolor(4);
     writeln('           ������� ���᫥���');
     write('             ',x1:6:4,'+',x2:6:4,'i');
     readln;
    End;
 End;
procedure menu1;
Begin
  window(1,1,80,25);textbackground(0);clrscr;
  window(10,7,70,16);textbackground(red);clrscr;textcolor(7);
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
  window(10,18,70,20);textbackground(red);clrscr;
  textcolor(lightgreen);
  write('     H����� ������� ᮮ⢥�������� ��p����� ��樨');
  gotoxy(1,3);
  write('                       H����� ENTER                ');
  gotoxy(30,2);
  readln(ch);
  case ch of
   '1':vbyte;
   '2':vinteger;
   '3':vlongint;
   '4':vreal;
   '5':vdouble;
   '6':vextended;
   '7':vcomplex;
   '8':exit;
  End;
   menu1;
End;
BEGIN
 window(1,1,80,25);textbackground(0);
 clrscr;
 menu1;
END.
