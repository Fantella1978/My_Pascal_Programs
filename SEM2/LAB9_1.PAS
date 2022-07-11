uses crt;
const
 a:array[1..5] of string=('      ‘ใฌฌ      ',
                          '     งญฎแโ์    ',
                          '  เฎจงขฅคฅญจฅ  ',
                          '     — แโญฎฅ    ',
                          '      ๋ๅฎค    ');
var
 ch,ch1:char;i,n:integer;c,b:real;z:byte;x1,x2,y:extended;
Procedure menu2(n:byte);
 Begin
   window(1,1,80,25);textbackground(1);clrscr;textcolor(14+blink);
  window(22,1,58,3);textbackground(2);clrscr;
  write(' ษอออออออออออออออออออออออออออออออออป ');
  writeln(' บ  ฏฅเ ๆจจ แ ขขฅคฅญญ๋ฌจ ็จแซ ฌจ  บ');
  write(' ศอออออออออออออออออออออออออออออออออผ');
  window(30,9-n,50,15-n);textbackground(2);clrscr;textcolor(0);
  write(' ษอออออออออออออออออป ');
  writeln(' บ                 บ');
  writeln(' บ                 บ');
  writeln(' บ                 บ');
  writeln(' บ                 บ');
  writeln(' บ                 บ');
  write(' ศอออออออออออออออออผ');
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
   writeln(' ษอออออออออออออออออออออออออออออออออออออป');
   writeln(' บ         ๋กp ญ  ฎฏๆจ๏ #',ch1,'            บ');
   write(' ศอออออออออออออออออออออออออออออออออออออผ');
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
 write(' ขฅคจโฅ ฏฅpขฎฅ ็จแซฎ ');
 readln(x1);
 write(' ขฅคจโฅ ขโฎpฎฅ ็จแซฎ ');
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
   write(' ษอออออออออออออออออออออออออออป ');
   write(' บ    ฅงใซ์โ โ ข๋็จแซฅญจฉ   บ ');
   write(' บ         ',y:8:4,'          บ ');
   write(' ศอออออออออออออออออออออออออออผ');
   readln;
   until false;
End;
Procedure vinteger(var n:integer);
 var x1,x2:integer;y:real;
Begin
 zast(ch1);
 window(20,7,60,9);textbackground(13);clrscr;
 write(' ขฅคจโฅ ฏฅpขฎฅ ็จแซฎ ');
 readln(x1);
 write(' ขฅคจโฅ ขโฎpฎฅ ็จแซฎ ');
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
   write(' ษอออออออออออออออออออออออออออป ');
   write(' บ    ฅงใซ์โ โ ข๋็จแซฅญจฉ   บ ');
   write(' บ         ',y:8:4,'          บ ');
   write(' ศอออออออออออออออออออออออออออผ');
   readln;
   until false;
End;
Procedure vlongint(var n:integer);
 var x1,x2:longint;y:real;
Begin
 zast(ch1);
 window(20,7,60,9);textbackground(13);clrscr;
 write(' ขฅคจโฅ ฏฅpขฎฅ ็จแซฎ ');
 readln(x1);
 write(' ขฅคจโฅ ขโฎpฎฅ ็จแซฎ ');
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
   write(' ษอออออออออออออออออออออออออออป ');
   write(' บ    ฅงใซ์โ โ ข๋็จแซฅญจฉ   บ ');
   write(' บ',y:20:7,'       บ ');
   write(' ศอออออออออออออออออออออออออออผ');
   readln;
   until false;
End;
 Procedure vreal(var n:integer);
 var x1,x2:real;y:real;
Begin
 zast(ch1);
 window(10,7,70,9);textbackground(13);clrscr;
 write(' ขฅคจโฅ ฏฅpขฎฅ ็จแซฎ ');
 readln(x1);
 write(' ขฅคจโฅ ขโฎpฎฅ ็จแซฎ ');
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
   write(' ษอออออออออออออออออออออออออออออออออออออป ');
   write(' บ          ฅงใซ์โ โ ข๋็จแซฅญจฉ       บ ');
   write(' บ        ',y,'      บ ');
   write(' ศอออออออออออออออออออออออออออออออออออออผ');
   readln;
   until false;
End;
Procedure vdouble(var n:integer);
 var x1,x2:double;y:double;
Begin
 zast(ch1);
 window(10,7,70,9);textbackground(13);clrscr;
 write(' ขฅคจโฅ ฏฅpขฎฅ ็จแซฎ ');
 readln(x1);
 write(' ขฅคจโฅ ขโฎpฎฅ ็จแซฎ ');
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
   write(' ษอออออออออออออออออออออออออออออออออออออป ');
   write(' บ          ฅงใซ์โ โ ข๋็จแซฅญจฉ       บ ');
   write(' บ        ',y,'      บ ');
   write(' ศอออออออออออออออออออออออออออออออออออออผ');
   readln;
   until false;
End;
 Procedure vextended(var n:integer);
 var x1,x2:extended;y:extended;
Begin
 zast(ch1);
 window(1,7,80,10);textbackground(13);clrscr;
 write(' ขฅคจโฅ ฏฅpขฎฅ ็จแซฎ ');
 readln(x1);
 write(' ขฅคจโฅ ขโฎpฎฅ ็จแซฎ ');
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
   write(' ษอออออออออออออออออออออออออออออออออออออป ');
   write(' บ          ฅงใซ์โ โ ข๋็จแซฅญจฉ       บ ');
   write(' บ        ',y,'      บ ');
   write(' ศอออออออออออออออออออออออออออออออออออออผ');
   readln;
   until false;
End;
procedure vcomplex(var n:integer);
 var d1,d2,m1,m2,x1,x2:real;
Begin
 zast(ch1);
 window(5,7,75,11);textbackground(13);clrscr;
 write(' ขฅคจโฅ คฅฉแโขจโฅซ์ญใ๎ ็ แโ์ ฏฅpขฎฃฎ ็จแซ  ');
 readln(d1);
 write(' ขฅคจโฅ ฌญจฌใ๎ ็ แโ์ ฏฅpขฎฃฎ ็จแซ  ');
 readln(m1);
 write(' ขฅคจโฅ คฅฉแโขจโฅซ์ญใ๎ ็ แโ์ ขโฎpฎฃฎ ็จแซ  ');
 readln(d2);
 write(' ขฅคจโฅ ฌญจฌใ๎ ็ แโ์ ขโฎpฎฃฎ ็จแซ  ');
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
        write(' ษอออออออออออออออออออออออออออออออออออออป ');
        write(' บ          ฅงใซ์โ โ ข๋็จแซฅญจฉ       บ ');
        write(' บ        ',x1:10:4,'+',x2:10:4,'i       บ ');
        write(' ศอออออออออออออออออออออออออออออออออออออผ');
        readln;
       End
      else
       Begin
        textcolor(10);
        write(' ษอออออออออออออออออออออออออออออออออออออป ');
        write(' บ          ฅงใซ์โ โ ข๋็จแซฅญจฉ       บ ');
        write(' บ           ่จกช  ข๋็จแซฅญจฉ         บ ');
        write(' ศอออออออออออออออออออออออออออออออออออออผ');
        readln;
       End
     End;
   3:exit;
  End;
   if n<>2 then
    Begin
     textcolor(10);
     write(' ษอออออออออออออออออออออออออออออออออออออป ');
     write(' บ          ฅงใซ์โ โ ข๋็จแซฅญจฉ       บ ');
     write(' บ        ',x1:10:4,'+',x2:10:4,'i       บ ');
     write(' ศอออออออออออออออออออออออออออออออออออออผ');
     readln;
    End;
    until false;
 End;
procedure menu1;
Begin
  window(1,1,80,25);textbackground(0);clrscr;
  window(10,7,70,16);textbackground(4);clrscr;textcolor(14);
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
  window(10,18,70,22);textbackground(red);clrscr;
  textcolor(lightgreen);
  write(' ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออป ');
  write(' บ     H ฆฌจโฅ ชซ ขจ่ใ แฎฎโขฅโแโขใ๎้ใ๎ ข๋กp ญญฎฉ ฎฏๆจจ     บ ');
  write(' บ                                                         บ ');
  gotoxy(1,4);
  write(' บ                     H ฆฌจโฅ ENTER                       บ ');
  write(' ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
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
