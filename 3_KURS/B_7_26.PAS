program B_7_26;  {решение системы уравнений методом ГАУССА}
const n=2;       {количество уpавнений}
      e=0.00001; {точность}
var a,a1:array [1..n,1..n+1] of real;
    x:array[1..n]of real;
    i,j,k:integer;
    y:real;  {y-значение ведущего элемента}
    s,w:real;
BEGIN
 Randomize;
 for i:=1 to n do
  for j:=1 to n+1 do
   begin
    a[i,j]:=10*random;{случайным образом задаем коэффициенты}
    a1[i,j]:=a[i,j];
   end;
 for i:=1 to n do {изучение максимального коофициента при x[i]}
  begin
    k:=i;
    y:=a[i,i];{ведущему элементу:=a[i,i]- кооф. главной диагонали}
    for j:=i+1 to n do
     begin
      w:=a[j,i];
       if abs(w)<abs(y) then  {кооф. на главной диаu. долж.}
         begin                {быть больше последующ. элем.}
          k:=j;   {иначе происходит смена ведущего элемента}
          y:=w
         end;
     end;
    if abs(y)<e then {ведущий элемент меньше точности}
     begin      {матрица вырождена и не имеет решений}
      Writeln('При данных коэфф. решить невозможно.');
      exit;
     end;
    for j:=i to n+1 do {цикл перестановки кооф. и уравн.}
     begin             {деление последнего на Y }
      w:=a[k,j];
      a[k,j]:=a[i,j];
      a[i,j]:=w/y;
     end;
     for k:=i+1 to n do {определ. наддиаг. элементов}
      for j:=n+1 downto i+1 do a[k,j]:=a[k,j]-a[i,j]*a[k,i];
   end;
  for i:=n downto 1 do
   begin w:=0;
    for j:=i+1 to n do w:=w+a[i,j]*x[j];
    x[i]:=a[i,n+1]-w;
   end;
 Writeln('Корни:_______________Проверка:_________________');
 For i:=1 to n do
  begin
   Write('Корень ',i:2,' :',x[i]:8:4,' |       ');
   s:=0;
   For j:=1 to n do s:=s+a1[i,j]*x[j];
   Writeln(S:8:4,' = ',a1[i,n+1]:8:4);
  end;
END.