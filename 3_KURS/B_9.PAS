program B_9; {��襭�� ��⥬� �p������� ��⮤�� ��������}
const n=2;       {������⢮ �p�������}
      e=0.00001; {�筮���}
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
    a[i,j]:=10*random;{��砩�� ��ࠧ�� ������ �����.}
    a1[i,j]:=a[i,j];
   end;
 For i:=1 to n do
  begin
   for j:=i+1 to n do if a[i,j]>=a[i,i] then error:=true;
   for j:=i-1 downto 1 do if a[i,j]>=a[i,i] then error:=true;
  end;          {�� ������� ��������� ������ ����}
 if error then  {���ᨬ���� �����樥���}
  begin
   Writeln('�� ������ �����樥��� ���� ����������.');
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
 Writeln('��୨:_______________�஢�ઠ:_________________');
 For i:=1 to n do
  begin
   Write('��७� ',i:2,' :',x[i]:8:4,' |       ');
   s:=0;
   For j:=1 to n do s:=s+a1[i,j]*x[j];
   Writeln(S:8:4,' = ',a1[i,n+1]:8:4);
  end;
END.

