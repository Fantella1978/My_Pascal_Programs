Program B_6; {Вычисление определителя}
const n=2; {порядок определителя}
var i,j,k:byte;
    d:real;
    a:array[1..n,1..n]of real;
BEGIN
 d:=1;
 For i:=1 to n do   {генерация злементов матрицы}
  For j:=1 to n do
   begin
    a[i,j]:=-51+random*(int(-51)+72);
    Writeln('a[',i:2,',',j:2,']=',a[i,j]:10:6);
   end;
 For i:=1 to n-1 do {вычисление определителя}
  begin
   For j:=i+1 to n do
    begin
     a[j,i]:=a[j,i]/a[i,i];
     For k:=i+1 to n do a[j,k]:=a[j,k]-a[j,i]*a[i,k];
    end;
   D:=D*a[i,i];
  end;
 D:=D*a[n,n];
 Writeln('Определитель равен : ',D:10:6);
END.