program alex2;
 var
  x1,x2,h,y,x,p,a:real;
BEGIN
 write('������ x1=');
 readln(x1);
 write('������ x2=');
 readln(x2);
 write('������ 蠣 h=');
 readln(h);
 x:=x1;
  while x<=x2 do
   BEGIN
    if x>0 then
     BEGIN
      a:=1/exp(x*ln(x))+sin(x);
      p:=0.64-exp(x);
       if p<>0 then
        BEGIN
         y:=a/(p/abs(p)*exp(ln(abs(p))/3));
         writeln('�p� x=',x:4:2,'          y=',y:4:2);
        END
       else writeln('�p� x=',x:4:2,' y ����p�������');
     END
    else writeln('�p� x=',x:4:2,' y ����p�������');
   x:=x+h
  END
END.