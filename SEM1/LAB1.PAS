program alex1;
 uses crt;
 var
  x,y,p,f:real;
 BEGIN
  clrscr;
  write('������ x=');
  readln(x);
   p:=sin(x)-exp(x*ln(2));
   f:=exp(cos(x)*ln(3));
    if p<>0 then
     Begin
      y:=f-7.5*x-p/abs(p)*exp(ln(abs(p))/3);
      writeln('������� ���᫥��� y=',y:4:2);
     End
   else writeln('y ����p�������');
 END.
