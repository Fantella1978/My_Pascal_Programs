uses crt;
const
 a:array[1..4] of string=('      ‘ใฌฌ      ',
                          '     งญฎแโ์    ',
                          '  เฎจงขฅคฅญจฅ  ',
                          '     — แโญฎฅ  ');
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
 writeln(' ษอออออออออออออออออออออออออออออออออออออป');
 writeln(' บ         ๋กp ญ  ฎฏๆจ๏ #1            บ');
 write(' ศอออออออออออออออออออออออออออออออออออออผ');
 window(20,7,60,9);textbackground(13);clrscr;
 write(' ขฅคจโฅ ฏฅpขฎฅ ็จแซฎ ');
 readln(x1);
 write(' ขฅคจโฅ ขโฎpฎฅ ็จแซฎ ');
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
   writeln(' ฅงใซ์โ โ ข๋็จแซฅญจฉ');
   write('        ',y:6:4);
   readln;
End;
Procedure vinteger;
 var x1,x2:integer;y:real;
Begin
 window(1,1,80,25);textbackground(0);clrscr;
 window(20,1,60,3);textbackground(13);clrscr;
 writeln(' ษอออออออออออออออออออออออออออออออออออออป');
 writeln(' บ         ๋กp ญ  ฎฏๆจ๏ #2            บ');
 write(' ศอออออออออออออออออออออออออออออออออออออผ');
 window(20,7,60,9);textbackground(13);clrscr;
 write(' ขฅคจโฅ ฏฅpขฎฅ ็จแซฎ ');
 readln(x1);
 write(' ขฅคจโฅ ขโฎpฎฅ ็จแซฎ ');
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
   writeln(' ฅงใซ์โ โ ข๋็จแซฅญจฉ');
   write('        ',y:6:4);
   readln;
End;
Procedure vlongint;
 var x1,x2:longint;y:real;
Begin
 window(1,1,80,25);textbackground(0);clrscr;
 window(20,1,60,3);textbackground(13);clrscr;
 writeln(' ษอออออออออออออออออออออออออออออออออออออป');
 writeln(' บ         ๋กp ญ  ฎฏๆจ๏ #3            บ');
 write(' ศอออออออออออออออออออออออออออออออออออออผ');
 window(20,7,60,9);textbackground(13);clrscr;
 write(' ขฅคจโฅ ฏฅpขฎฅ ็จแซฎ ');
 readln(x1);
 write(' ขฅคจโฅ ขโฎpฎฅ ็จแซฎ ');
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
   write(' ฅงใซ์โ โ ข๋็จแซฅญจฉ');
   write('     ',y:10:9);
   readln;
End;
 Procedure vreal;
 var x1,x2:real;y:real;
Begin
 window(1,1,80,25);textbackground(0);clrscr;
 window(20,1,60,3);textbackground(red);clrscr;
 writeln(' ษอออออออออออออออออออออออออออออออออออออป');
 writeln(' บ         ๋กp ญ  ฎฏๆจ๏ #4            บ');
 write(' ศอออออออออออออออออออออออออออออออออออออผ');
 window(10,7,70,9);textbackground(13);clrscr;
 write(' ขฅคจโฅ ฏฅpขฎฅ ็จแซฎ ');
 readln(x1);
 write(' ขฅคจโฅ ขโฎpฎฅ ็จแซฎ ');
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
   writeln('           ฅงใซ์โ โ ข๋็จแซฅญจฉ');
   write('         ',y);
   readln;
End;
Procedure vdouble;
 var x1,x2:double;y:double;
Begin
 window(1,1,80,25);textbackground(0);clrscr;
 window(20,1,60,3);textbackground(red);clrscr;
 writeln(' ษอออออออออออออออออออออออออออออออออออออป');
 writeln(' บ         ๋กp ญ  ฎฏๆจ๏ #5            บ');
 write(' ศอออออออออออออออออออออออออออออออออออออผ');
 window(10,7,70,9);textbackground(13);clrscr;
 write(' ขฅคจโฅ ฏฅpขฎฅ ็จแซฎ ');
 readln(x1);
 write(' ขฅคจโฅ ขโฎpฎฅ ็จแซฎ ');
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
   writeln('           ฅงใซ์โ โ ข๋็จแซฅญจฉ');
   write('         ',y);
   readln;
End;
 Procedure vextended;
 var x1,x2:extended;y:extended;
Begin
 window(1,1,80,25);textbackground(0);clrscr;
 window(20,1,60,3);textbackground(red);clrscr;
 writeln(' ษอออออออออออออออออออออออออออออออออออออป');
 writeln(' บ         ๋กp ญ  ฎฏๆจ๏ #6            บ');
 write(' ศอออออออออออออออออออออออออออออออออออออผ');
 window(1,7,80,10);textbackground(13);clrscr;
 write(' ขฅคจโฅ ฏฅpขฎฅ ็จแซฎ ');
 readln(x1);
 write(' ขฅคจโฅ ขโฎpฎฅ ็จแซฎ ');
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
   writeln('           ฅงใซ์โ โ ข๋็จแซฅญจฉ');
   write('         ',y);
   readln;
End;
procedure vcomplex;
 var d1,d2,m1,m2,x1,x2:real;
Begin
 window(1,1,80,25);textbackground(0);clrscr;
 window(20,1,60,3);textbackground(red);clrscr;
 writeln(' ษอออออออออออออออออออออออออออออออออออออป');
 writeln(' บ         ๋กp ญ  ฎฏๆจ๏ #7            บ');
 write(' ศอออออออออออออออออออออออออออออออออออออผ');
 window(5,7,75,11);textbackground(13);clrscr;
 write(' ขฅคจโฅ คฅฉแโขจโฅซ์ญใ๎ ็ แโ์ ฏฅpขฎฃฎ ็จแซ  ');
 readln(d1);
 write(' ขฅคจโฅ ฌญจฌใ๎ ็ แโ์ ฏฅpขฎฃฎ ็จแซ  ');
 readln(m1);
 write(' ขฅคจโฅ คฅฉแโขจโฅซ์ญใ๎ ็ แโ์ ขโฎpฎฃฎ ็จแซ  ');
 readln(d2);
 write(' ขฅคจโฅ ฌญจฌใ๎ ็ แโ์ ขโฎpฎฃฎ ็จแซ  ');
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
     writeln('           ฅงใซ์โ โ ข๋็จแซฅญจฉ');
     write('             ่จกช  ข๋็จแซฅญจ๏');
     readln;
    End
   else
    Begin
     textcolor(4);
     writeln('           ฅงใซ์โ โ ข๋็จแซฅญจฉ');
     write('             ',x1:6:4,'+',x2:6:4,'i');
     readln;
    End;
 End;
procedure menu1;
Begin
  window(1,1,80,25);textbackground(0);clrscr;
  window(10,7,70,16);textbackground(red);clrscr;textcolor(7);
  writeln(' ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
  writeln(' บ  1.   ขฎค คขใๅ ๆฅซ๋ๅ ็จแฅซ, ญฅ ฏpฅข๋่ ๎้จๅ 255.        บ');
  writeln(' บ  2.   ขฎค คขใๅ ๆฅซ๋ๅ ็จแฅซ ฎก๋็ญฎฉ โฎ็ญฎแโจ.           บ');
  writeln(' บ  3.   ขฎค คขใๅ ๆฅซ๋ๅ ็จแฅซ ฏฎข๋่ฅญญฎฉ โฎ็ญฎแโจ.        บ');
  writeln(' บ  4.   ขฎค คขใๅ ขฅ้ฅแโขฅญญ๋ๅ ็จแฅซ ฎก๋็ญฎฉ โฎ็ญฎแโจ.    บ');
  writeln(' บ  5.   ขฎค คขใๅ ขฅ้ฅแโขฅญญ๋ๅ ็จแฅซ คขฎฉญฎฉ โฎ็ญฎแโจ.    บ');
  writeln(' บ  6.   ขฎค คขใๅ ขฅ้ฅแโขฅญญ๋ๅ ็จแฅซ ฏฎข๋่ฅญญฎฉ โฎ็ญฎแโจ. บ');
  writeln(' บ  7.   ขฎค คขใๅ ชฎฌฏซฅชแญ๋ๅ ็จแฅซ.                      บ');
  writeln(' บ  8.   ๋ๅฎค.                                            บ');
  write(' ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
  window(10,18,70,20);textbackground(red);clrscr;
  textcolor(lightgreen);
  write('     H ฆฌจโฅ ชซ ขจ่ใ แฎฎโขฅโแโขใ๎้ใ๎ ข๋กp ญญฎฉ ฎฏๆจจ');
  gotoxy(1,3);
  write('                       H ฆฌจโฅ ENTER                ');
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
