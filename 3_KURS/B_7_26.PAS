program B_7_26;  {�襭�� ��⥬� �ࠢ����� ��⮤�� ������}
const n=2;       {������⢮ �p�������}
      e=0.00001; {�筮���}
var a,a1:array [1..n,1..n+1] of real;
    x:array[1..n]of real;
    i,j,k:integer;
    y:real;  {y-���祭�� ����饣� �������}
    s,w:real;
BEGIN
 Randomize;
 for i:=1 to n do
  for j:=1 to n+1 do
   begin
    a[i,j]:=10*random;{��砩�� ��ࠧ�� ������ �����樥���}
    a1[i,j]:=a[i,j];
   end;
 for i:=1 to n do {���祭�� ���ᨬ��쭮�� ����樥�� �� x[i]}
  begin
    k:=i;
    y:=a[i,i];{����饬� ��������:=a[i,i]- ����. ������� ���������}
    for j:=i+1 to n do
     begin
      w:=a[j,i];
       if abs(w)<abs(y) then  {����. �� ������� ���u. ����.}
         begin                {���� ����� ��᫥����. ����.}
          k:=j;   {���� �ந�室�� ᬥ�� ����饣� �������}
          y:=w
         end;
     end;
    if abs(y)<e then {����騩 ������� ����� �筮��}
     begin      {����� ��஦���� � �� ����� �襭��}
      Writeln('�� ������ �����. ���� ����������.');
      exit;
     end;
    for j:=i to n+1 do {横� ����⠭���� ����. � �ࠢ�.}
     begin             {������� ��᫥����� �� Y }
      w:=a[k,j];
      a[k,j]:=a[i,j];
      a[i,j]:=w/y;
     end;
     for k:=i+1 to n do {��।��. �������. ������⮢}
      for j:=n+1 downto i+1 do a[k,j]:=a[k,j]-a[i,j]*a[k,i];
   end;
  for i:=n downto 1 do
   begin w:=0;
    for j:=i+1 to n do w:=w+a[i,j]*x[j];
    x[i]:=a[i,n+1]-w;
   end;
 Writeln('��୨:_______________�஢�ઠ:_________________');
 For i:=1 to n do
  begin
   Write('��७� ',i:2,' :',x[i]:8:4,' |       ');
   s:=0;
   For j:=1 to n do s:=s+a1[i,j]*x[j];
   Writeln(S:8:4,' = ',a1[i,n+1]:8:4);
  end;
END.