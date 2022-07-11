Program var6;
uses crt;
var a:array[1..100,1..100] of real;
    n,i,j,k:integer;
    d:real;
begin
  clrscr;
  d:=1;
  randomize;
  write('Введите порядок определителя: ');
  readln(n);
  for i:=1 to n do
    for j:=1 to n do
      begin
	a[i,j]:=int(random*122)-50;
	writeln('Элемент a[',i,',',j,']= ',a[i,j]:5:2);
      end;
  for i:=1 to n-1 do
   begin
    for j:=i+1 to n do
      begin
	a[j,i]:=a[j,i]/a[i,i];
	for k:=i+1 to n do a[j,k]:=a[j,k]-a[j,i]*a[i,k];
      end;
   d:=d*a[i,i];
   end;
  d:=d*a[n,n];
  writeln('Определитель равен D= ',d:10:2);
  readln;
end.