Program B_23_30;      {вычисление интеграла методами
                      левых и правых прямоугольников}
var   dx,Sl,Sp:real;
      m:integer;
const n=10; a=0; b=2;

Function f(x:real):real;
Begin
 f:=x*exp(-x);        {задаем функцию}
end;

BEGIN
 Sl:=0; Sp:=0;
 dx:=(b-a)/n;
 for m:=1 to n do        {метод левых пряпоугольников}
  Sl:=Sl+F(dx*m+a)*dx;
 for m:=0 to n-1 do      {метод правых пряпоугольников}
  Sp:=Sp+F(dx*m+a)*dx;
 writeln('По методу левых прямоугольников: ',Sl:10:7);
 writeln('По методу правых прямоугольников: ',Sp:10:7);
 if Sp>Sl
  then
   writeln('Метод правых прямоуг. дал больший результат.')
  else
   writeln('Метод левых прямоуг. дал больший результат.');
END.
