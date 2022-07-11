program alex2;
 var
  x1,x2,h,y,x,p,a:real;
BEGIN
 write('Введите x1=');
 readln(x1);
 write('Введите x2=');
 readln(x2);
 write('Введите шаг h=');
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
         writeln('Пpи x=',x:4:2,'          y=',y:4:2);
        END
       else writeln('Пpи x=',x:4:2,' y неопpеделено');
     END
    else writeln('Пpи x=',x:4:2,' y неопpеделено');
   x:=x+h
  END
END.