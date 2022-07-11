Program B_1_20; {решение диф. уравнения методом Рунге-Кутта}
const Xnach=0.1; Xkon=0.3; h=0.02;
Var x,y,y1,k1,k2,k3,k4:real;
BEGIN
 y1:= 0.05; y:= 0.05;
 Writeln('Начальные значения :'); {Вывод начальных значений}
 Writeln('Xнач     = ',Xnach:6:2);
 Writeln('Xкон     = ',Xkon:6:2);
 Writeln('h        = ',h:6:2);
 Writeln('Y``(0.1) = ',y1:6:2);
 Writeln('Y`(0.1)  = ',y:6:2);
 Writeln('Результаты решения:');
 x:= Xnach;
 while (x<Xkon+h) do
 begin {Расчет коэффициентов Ki}
   k1:=h*(2*EXP(-x)-COS(x)+x*y1);
   k2:=h*(2*EXP(-(x+h/2))-COS(x+h/2)+(x+h/2)*(y1+k1/2));
   k3:=h*(2*EXP(-(x+h/2))-COS(x+h/2)+(x+h/2)*(y1+k2/2));
   k4:=h*(2*EXP(-(x+h))-COS(x+h)+(x+h)*(y1+k3));
   {Расчет текущего значения решения уравнения}
   y:= y + h * (y1 + (k1 + k2 + k3) / 6);
   y1:= y1 + (k1 + 2 * k2 + 2 * k3 + k4) / 6;
   {Вывод результатов расчета}
   Writeln('X = ', X:6:2, ';   Y = ', Y:6:2);
   x:=x+h
 end
End.
