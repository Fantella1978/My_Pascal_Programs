Program INTEGRAL1;
uses
   crt;
var
  a,b,plo,y:real;
const
 n=1000;
Function f(x:real):real;
 Begin
  f:=x*arctan(x);
 end;
Function PRIAM(a,b:real;n:integer):real;
 var
   dx,s,x1:real;
   m:integer;
 Begin
  s:=0;
  dx:=(b-a)/n;
  for m:=0 to n-1 do
   begin
    x1:=a+m*dx;
    s:=s+f(x1);
   end;
  priam:=s*dx;
 end;
Function TRAP(a,b:real;n:integer):real;
 var
  dx,s,x1:real;
  m:integer;
 begin
  s:=0;
  dx:=(b-a)/n;
  for m:=1 to n-1 do
   begin
    x1:=a+m*dx;
    s:=s+f(x1);
   end;
  trap:=dx*((f(a)+f(b))/2+s);
 end;
Function SIMPS(a,b:real;n:integer):real;
 var
  dx,s1,s2,x1:real;
  k:integer;
 begin
  s1:=0;
  s2:=0;
  dx:=(b-a)/n;
  k:=1;
  repeat
    x1:=a+k*dx;
    s1:=s1+f(x1);
    k:=k+2;
  until k>n-1;
  k:=2;
  repeat
    x1:=a+k*dx;
    s2:=s2+f(x1);
    k:=k+2;
  until k>n-2;
  simps:=(b-a)/(3*n)*(f(a)+f(b)+2*s1+4*s2);
 end;

BEGIN
 clrscr;
 a:=0;
 b:=sqrt(3);
 plo:=priam(a,b,n);
 writeln('Метод прямоугольников дает площадь : ',plo:10:7);
 plo:=trap(a,b,n);
 writeln('Метод трапеций дает площадь : ',plo:10:7);
 plo:=simps(a,b,n);
 writeln('Метод Симпсона дает площадь : ',plo:10:7);
 y:=9*arctan(3)/2-3/2-arctan(3)/2;
 writeln('Значение контрольной функции:',y:10:7);
 readkey;
END.
