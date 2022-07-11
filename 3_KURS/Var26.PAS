Program var8;
uses crt;
var a,aa:array[1..50,1..51] of real;
    x:array[1..50] of real;
    isp:array[1..50] of integer;
    { a[n,n+1] - двумерный массив, в котором находятся коэффицициенты
         при переменных и свободные члены;
      aa[n,n+1] - дублирует массив a[n,n+1];
      x[n] - одномерный массив, в который будут заноситься решения
       данной системы уравнений;
      isp[n] - т.к. в данной программе возможно будут переставлены местами
        столбцы, то и найденные корни системы тоже окажутся не в том
        порядке, что надо. Поэтому в данном массиве содержатся номера
        столбцов которые были перемещены. }
    i,j,k,ii,jj,n:integer;
    s,f,h:real;
begin
  clrscr;
  writeln('Решение систем уравнений методом Гаусса с выбором главного элемента');
  write('Введите количество уравнений в системе n= ');
  readln(n);
  randomize;
  {Ввод коэффициентов и своюодных членов системы уравнений}
  for i:=1 to n do
    begin
      for j:=1 to n do
        begin
          a[i,j]:=random*20-10;
          aa[i,j]:=a[i,j];
          write('a[',i,',',j,']= ',a[i,j]:5:2,'  ');
        end;
      a[i,n+1]:=random*20-10;
      aa[i,n+1]:=a[i,n+1];
      writeln('b[',i,',',j,']= ',a[i,n+1]:5:2);
    end;
  {Расчёт корней системы уравнений}
  for i:=1 to n do
      {цикл перебора элементов в главной диагонали матрицы
       нахoждение максимального элемента матрицы a[i,n]}
    begin
      k:=i; isp[i]:=i;
      for ii:=i to n do
        for jj:=i to n do
          if ABS(a[ii,jj])>ABS(a[k,isp[i]]) then
                                              begin
                                              k:=ii;
                                              isp[i]:=jj;
                                              end;
      {Условие верно, когда надо поменять местами строки(уравнения)}
      if k<>i then
                begin
                  for jj:=i to n do
                    begin
                      f:=a[i,jj];a[i,jj]:=a[k,jj];a[k,jj]:=f;
                    end;
                  f:=a[k,n+1];a[k,n+1]:=a[i,n+1];a[i,n+1]:=f;
                end;
      {Условие верно, когда надо поменять местами столбцы}
      if isp[i]<>i then
                     begin
                       for ii:=1 to n do
                         begin
                           f:=a[ii,i];a[ii,i]:=a[ii,isp[i]];a[ii,isp[i]]:=f;
                         end;
                     end;
      for j:=n+1 downto i do
        begin
          a[i,j]:=a[i,j]/a[i,i];
          for k:=i+1 to n do
              a[k,j]:=a[k,j]-a[i,j]*a[k,i];
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
  for i:=n downto 1 do {цикл ставит в правильное соответствие корни уравнения}
    begin
      f:=x[i];x[i]:=x[isp[i]];x[isp[i]]:=f;
    end;
  writeln;
  writeln('Корни системы уравнений');
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
