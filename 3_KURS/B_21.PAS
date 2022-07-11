Program B_21;{Реш диф. ур-я методом Рунге-Кутта}
Uses Crt;
Const Xn=0.2; Xk=0.4; h=0.01;
Var x,y,y1,k1,k2,k3,k4:real;
BEGIN
 Clrscr;
 y:=0.02; y1:=0.02;
 Writeln( 'Результаты решения:');
 x:=Xn;
 while x<=Xk+h do
  begin
   {Расчет коэффициентов Kj}
   k1:=h*(2*EXP(-0.5*x)-SIN(x)+y1);
   k2:=h*(2*EXP(-0.5*(x+h/2))-SIN(x+h/2)+(y1+k1/2));
   k3:=h*(2*EXP(-0.5*(x+h/2))-SIN(x+h/2)+(y1+k2/2));
   k4:=h*(2*EXP(-0.5*(x+h))-SIN(x+h)+(y1+k3));
   {Расчет текущего значения решения уравнения}
   y:=y+h*(y1+(k1+k2+k3)/6);
   y1:=y1+(k1+2*k2+2*k3+k4)/6;
   Writeln('X = ',X:6:4,'  Y = ',Y:6:4);
   x:=x+h;
  end;
End.

