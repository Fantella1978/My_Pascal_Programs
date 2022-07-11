Program var10;
uses crt;
const e=0.00001;
var a1,a,s,x:real;
    n,f:integer;
begin
  clrscr;
  {Вычиселние суммы ряда}
  x:=-1;
  while x<=1 do
    begin
      n:=1;
      f:=1;
      s:=1;
      repeat
        a1:=a;
        f:=f*n;
        a:=exp((n-1)*ln(abs(x))*abs(x)/x)/f;
        s:=s+a;
        n:=n+1;
      until ABS(a-a1)>e;
      writeln('Сумма ряда равна S=',s:7:3);
      x:=x+0.2;
    end;
  readln;
end.