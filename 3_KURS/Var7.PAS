Program var7;
uses crt;
var a,aa:array[1..50,1..51] of real;
    x:array[1..50] of real;
    i,j,k,n:integer;
    s,h:real;
begin
  clrscr;
  writeln('Решение систем уравнений методом Гаусса');
  write('Введите количество уравнений в системе n= ');
  readln(n);
  randomize;
  for i:=1 to n do
    begin
      for j:=1 to n do
        begin
          a[i,j]:=random*40-20;
          aa[i, j]:=a[i, j];
          write('a[',i,',',j,']= ',a[i,j]:5:2,'  ');
        end;
      a[i,n+1]:=random*10-5;
      aa[i,n+1]:=a[i,n+1];
      writeln('b[',i,',',j,']= ',a[i,n+1]:5:2);
    end;
  {Расчёт корней системы уравнений}
  for i:=1 to n do
    begin
      for j:=n+1 downto i do
        begin
          a[i,j]:=a[i,j]/a[i,i];
          for k:=i+1 to n do
              a[k,j]:=a[k,j]-a[i,j]*a[k,i]
        end;
    end;
  {Корни уравнения находятся в обратном порядке (начиная с n-го)}
  x[n]:=a[n,n+1];
  for i:=n-1 downto 1 do
    begin
      h:=a[i,n+1];
      for j:=i+1 to n do
          h:=h-x[j]*a[i,j];
      x[i]:=h
    end;
  writeln;
  writeln('Корни уравнения');
  for i:=1 to n do writeln('X[',i,']= ',x[i]:5:2);
  writeln;
  writeln('Проверка вычислений');
  writeln('sum(a[i,j]*x[i])      b(i)');
  for i:=1 to n do
    begin
      s:=0;
      for j:=1 to n do s:=s+aa[i,j]*x[j];
      writeln(s:7:4,'    =     ',aa[i,n+1]:7:4);
    end;
  readln;
end.