program interval;
uses crt;
const t=1e-8;
var x,xn,xk,h:real;
    y1,y2:real;
function f(x:real):real;
begin
  f:=sqr(x)-sqr(sin(x))-5*ln(x);
end;

BEGIN
  clrscr;
  WRITE('Vvedite xn,xk,h=');
  readln(xn,xk,h);
  x:=xn+h;
  y2:=f(xn);
  while x < xk + t do
   begin
   y1:=y2;
   y2:=f(x);
   if y1*y2 < -t then
     writeln(' Interval: [',(x-h):9:6,' ',x:9:6,']');
   writeln(' y1=',y1:9:6,'  y=',y2:9:6);
   readln;
   x:=x+h
   end;
   writeln(' x=',x:8:6,'  y=',y2:9:6);
  readkey
END.