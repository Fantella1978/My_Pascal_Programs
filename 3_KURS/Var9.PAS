Program var8;
uses crt;
var a:array[1..50,1..51] of real;
    x,b,z:array[1..50] of real;
    i,j,m,n,k:integer;
    s,e:real;
begin
  clrscr;
  writeln('Решение систем уравнений методом простых итераций');
  write('Введите количество уравнений в системе n= ');
  readln(n);

  write('Погрешность вычислений е= ');
  readln(e);
  randomize;
  for i:=1 to n do
    begin
      for j:=1 to n do
        begin
          a[i,j]:=random*5-10;
          write('a[',i,',',j,']= ',a[i,j]:5:2,'  ');
        end;
      b[i]:=random*10-30;
      writeln('b[',i,']= ',b[i]:5:2);
    end;
  {Расчёт корней системы уравнений}
  m:=0;
  for i:=1 to n do { цикл в котором мы задаёмся нулевым приближением}
      z[i]:=b[i]/a[i,i];
  repeat
    k:=0; {флаг выхода из цикла (если k=1, то выходим из цикла)}
    for i:=1 to n do
      begin
           {                             n
             вычисление формулы Xi=-bi+ sum (Aij*Xj)
                                        j=1
           }
        x[i]:=-b[i];
        for j:=1 to n do x[i]:=x[i]+a[i,j]*z[j];
        {проверка точности приближения}
        if ABS(x[i]/a[i,i])>=e then k:=1;
        {Вычисление s-го приближения i-ой неизвестной}
        x[i]:=z[i]-x[i]/a[i,i];
      end;
    {цикл в котором следующим приближением становятся полученные
    значения}
    for i:=1 to n do z[i]:=x[i];
    m:=m+1;
  until k<>1;
  {Выдача корней уравнения}
  writeln('Результаты решения:');
  for i:=1 to n do writeln('x[',i,']= ',x[i]:7:4);
  writeln('Число итераций= ',m);
  writeln; writeln('Проверка вычислений');
  writeln('sum(a(i,j)*x(i))      b(i)');
  for i:=1 to n do
    begin
      s:=0;
      for j:=1 to n do s:=s+a[i,j]*x[j];
      writeln(s:8:4,'     =      ',b[i]:8:4);
    end;
  readln;
end.