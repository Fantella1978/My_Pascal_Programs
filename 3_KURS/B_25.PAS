Program B_25; {���᫥��� �㬬� �鸞}
Uses Crt;
Const e = 0.00001; {����譮��� ���᫥���}
      h = 0.2;
      Xn= -1;
      Xk= 1;
Var s,t,x,en:real;
    n:integer;

function fackt(x:integer):longint;
begin
 if x=0
  then fackt := 1
  else fackt:=x*fackt(x-1);
end;

BEGIN
 ClrScr;
 x:=Xn;
 while x<Xk do  { 横� ��������� x}
  begin
   s:=0; n:=0;
   repeat
    t:=(abs(x)/x*exp(n*ln(abs(x))))/fackt(n);
    s:=s+t;
    inc(n)
   until abs(t)<e;
   Write('�� �=',x:4:2,'   S=',s:8:4);
   Writeln('   �஢�ઠ: E^X=',exp(x):8:4);
   x:=x+h;
  end;
END.

