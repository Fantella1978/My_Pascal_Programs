Program var3;
uses crt;
const e=1e-6;
var a,b,x,g1,g2,g:real;

function ff(x:real):real;
begin
  ff:=x*x+exp(-x)-2;
end;

begin
  clrscr;
  a:=1;
  b:=2;
  g1:=ff(a);g2:=ff(b);
  if g1*g2>0 then 
		begin
                  writeln('Выберите другой интервал');
		  readln;
		  exit;
		end;
  while abs(a-b)>e do
    begin
      x:=(a+b)/2;g:=ff(x);
      if g*g2>0 then begin b:=x;g2:=g end
		else begin a:=x;g1:=g end;
    end;
  writeln('Корень уравнения X=',a:10:5);
  readln;
end.  