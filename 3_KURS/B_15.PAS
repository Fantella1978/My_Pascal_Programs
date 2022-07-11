Program B_15;{Сглаживание}
Uses crt;
Var x,y,ys:array [0..19] of real;
    i: integer;
BEGIN
 clrscr;
 for i:=0 to 19 do
  begin
   x[i]:= 0.1 + 0.05 * i; {массив аргументов}
   ys[i]:= (EXP(x[i]) + EXP(-x[i])) / 2;
   y[i]:= ys[i]
  end;
    {производим усреднение ряда y(i) на основании
     интерполяционных полиномов}
  ys[0]:=(3*ys[0]+2*ys[1]+ys[2]-ys[4])/5;
  ys[1]:=(4*ys[0]+3*ys[1]+2*ys[2]+ys[3])/10;
  for i:= 2 to 17 do
    ys[i]:=(ys[i-2]+ys[i-1]+ys[i]+ys[i+1]+ys[i+2])/5;
  ys[18]:=(ys[16]+2*ys[17]+3*ys[18]+4*ys[19])/10;
  ys[19]:=(3*ys[19]+2*ys[18]+ys[17]-ys[16])/5;
  for i:= 0 to 19 do
   begin   {Выводим результаты  и исходные данные}
    write('X(',i,')=',X[i]:6:4,'  Y(',i,')=',Y[i]:6:4);
    writeln('  Ys(',i,')',Ys[i]:6:4);
   end;
End.