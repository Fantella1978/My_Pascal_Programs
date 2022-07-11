program B_9; {Решение системы уpавнений методом ИТЕРАЦИЙ}
const n=2;       {количество уpавнений}
      e=0.00001; {точность}
var a,a1:array [1..n,1..n+1] of real;
    x,xt:array[1..n]of real;
    i,j:integer;
    Error,EndSearch:boolean;
    s:real;
BEGIN
 Randomize;
 for i:=1 to n do
  for j:=1 to n+1 do
   begin
    a[i,j]:=10*random;{случайным образом задаем коэфф.}
    a1[i,j]:=a[i,j];
   end;
 For i:=1 to n do
  begin
   for j:=i+1 to n do if a[i,j]>=a[i,i] then error:=true;
   for j:=i-1 downto 1 do if a[i,j]>=a[i,i] then error:=true;
  end;          {на главной диагонали должны быть}
 if error then  {максимальные коэффициенты}
  begin
   Writeln('При данных коэффициентах решить невозможно.');
   exit;
  end;
 repeat
  for j:=1 to n do x[j]:=xt[j];
  for j:=1 to n do xt[j] := a[j,n+1];
  for j := 1 to n do
   begin
    for i := 1 to n do if j<>i then xt[j]:=xt[j]-a[j,i]*x[i];
    xt[j] := xt[j]/a[j,j];
   end;
  EndSearch:=True;
  for j:=1 to n do if abs(xt[j]-x[j])>e then EndSearch:=False;
 until EndSearch;
 Writeln('Корни:_______________Проверка:_________________');
 For i:=1 to n do
  begin
   Write('Корень ',i:2,' :',x[i]:8:4,' |       ');
   s:=0;
   For j:=1 to n do s:=s+a1[i,j]*x[j];
   Writeln(S:8:4,' = ',a1[i,n+1]:8:4);
  end;
END.

