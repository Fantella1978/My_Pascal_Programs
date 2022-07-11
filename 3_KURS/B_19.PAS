Program B_19;{программа статистической обработки}
const n=20;  {массивов}
var x,y:array[1..n]of real;
    i:integer;
    Mx,My,Dx,Dy,Qx,Qy,K:real;
BEGIN
 Randomize;
 For i:=1 to n do
  begin
   x[i]:=random-0.5;
   y[i]:=12*x[i]+21
  end;
 Mx:=0; My:=0;
 For i:=1 to n do
  begin
   Mx:=Mx+x[i]/n; {среднee значения функции Х}
   My:=My+y[i]/n; {среднee значения функции Y}
  end;
 Dx:=0; Dy:=0;
 For i:=1 to n do
  begin
   Dx:=Dx+sqr(x[i]-Mx)/(n-1); {дисперсия функции Х}
   Dy:=Dy+sqr(y[i]-My)/(n-1); {дисперсия функции Y}
   K:=K+(x[i]-Mx)*(y[i]-My)/(n-1); {Коэф. коррел.}
  end;
 Qx:=sqrt(Dx); {среднеквадратичное отклонение Х}
 Qy:=sqrt(Dy); {среднеквадратичное отклонение Y}
 Writeln('Cреднee значения функции Х : ',Mx:10:4);
 Writeln('Cреднee значения функции Y : ',My:10:4);
 Writeln('Дисперсия функции Х : ',Dx:10:4);
 Writeln('Дисперсия функции Y : ',Dy:10:4);
 Writeln('Cреднеквадратичное отклонение X : ',Qx:10:4);
 Writeln('Cреднеквадратичное отклонение Y : ',Qy:10:4);
 Writeln('Коэффициент корреляции : ',K:10:4);
END.
