program lab4;
 uses crt,zast;
 function sinus(x,e:real):real;
  var
   a,d,s:real;
   n,k,p:integer;
   Begin
   n:=0;
   s:=0;
   k:=1;
   p:=1;
   if x<>0 then
    Begin
     REPEAT
      a:=(2*n+1);
      for i:=1 to (2*n) do
       a:=a*i;
       d:=k*x/abs(x)*(exp((2*n+1)*ln(abs(x))))/a;
       s:=s+d;
       n:=n+1;
       k:=-k;
     UNTIL abs(d)<e;
      sinus:=s;
    end;
   end;
  function arctangens(x,e:real):real;
   var s1,k,n,p:real;
    begin
      s1:=0;k:=1;n:=0;p:=0;
       repeat
           p:=k*(x/abs(x))*exp(ln(abs(x))*(2*n+1))/(2*n+1);
           s1:=s1+p;
           n:=n+1;
           k:=-k;
       until abs(p)<e;
      arctangens:=s1;
    end;
  function kor(x:real):real;
   var
    l:real;
   Begin
    l:=sqrt((sqr(sqr(x))+2)/x);
    kor:=l;
   End;
 var  x,x1,x2,h,r,p,e,s,m,f:real;
      n:longint;
      z:extended;
  Begin
   titl;
   clrscr;
   textbackground(13);clrscr;
   window(16,2,68,24);textbackground(0);clrscr;
   window(14,1,66,22);textbackground(blue);clrscr;
   textcolor(10);clrscr;
   writeln('                Таблица ввода данных');
   window(14,2,66,23);textbackground(red);clrscr;
   writeln('         Введите начальное значение переменной');
   gotoxy(25,2);
   readln(x1);
   writeln('          Введите конечное значение переменной');
   gotoxy(25,4);
   readln(x2);
   writeln('                 Введите шаг переменной');
   gotoxy(24,6);
   readln(h);
   writeln('               Введите точность вычислений');
   gotoxy(23,8);
   readln(e);
   window(16,2,68,24);textbackground(0);clrscr;
   window(15,1,66,22);textbackground(blue);clrscr;
   textcolor(10);clrscr;
   writeln('           Таблица результатов вычислений');
   window(14,2,66,23);textbackground(red);clrscr;
    x:=x1;
   while x<=x2+0.0000001 do
    Begin
     if (round(x*1000)>0) and (round(x*10)<=10) then
      Begin
       r:=sinus(x,e)-arctangens(x,e);
       z:=r/abs(r)*exp(ln(abs(r))/3);
       m:=kor(x);
       f:=r+z+m;
       writeln('          При x=',x:3:2,' значение функции ',f:6:5);
       readln;
      End
     else
       Begin
        writeln('       При x=',x:3:2,' значение функции не существует');
        readln;
       End;
      x:=x+h;
    End;
    con;
END.

