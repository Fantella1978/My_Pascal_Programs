Program var11_1;
uses crt;
var a:array[1..50,1..51] of real;
    x,b,z:array[1..50] of real;
    i,j,m,n,k:integer;
    s,e:real;
begin
  clrscr;
  writeln('��襭�� ��⥬ �ࠢ����� ��⮤�� ������ ���権');
  write('������ ������⢮ �ࠢ����� � ��⥬� n= ');
  readln(n);

  write('����譮��� ���᫥��� �= ');
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
  {������ ��୥� ��⥬� �ࠢ�����}
  m:=0;
  for i:=1 to n do { 横� � ���஬ �� ������� �㫥�� �ਡ��������}
      z[i]:=b[i]/a[i,i];
  repeat
    k:=0; {䫠� ��室� �� 横�� (�᫨ k=1, � ��室�� �� 横��)}
    for i:=1 to n do
      begin
           {                             n
             ���᫥��� ���� Xi=-bi+ sum (Aij*Xj)
                                        j=1
           }
        x[i]:=-b[i];
        for j:=1 to n do x[i]:=x[i]+a[i,j]*z[j];
        {�஢�ઠ �筮�� �ਡ�������}
        if ABS(x[i]/a[i,i])>=e then k:=1;
        {���᫥��� s-�� �ਡ������� i-�� �������⭮�}
        x[i]:=z[i]-x[i]/a[i,i];
      end;
    {横� � ���஬ ᫥���騬 �ਡ�������� �⠭������ ����祭��
    ���祭��}
    for i:=1 to n do z[i]:=x[i];
    m:=m+1;
  until k<>1;
  {�뤠� ��୥� �ࠢ�����}
  writeln('�������� �襭��:');
  for i:=1 to n do writeln('x[',i,']= ',x[i]:7:4);
  writeln('��᫮ ���権= ',m);
  writeln; writeln('�஢�ઠ ���᫥���');
  writeln('sum(a(i,j)*x(i))      b(i)');
  for i:=1 to n do
    begin
      s:=0;
      for j:=1 to n do s:=s+a[i,j]*x[j];
      writeln(s:8:4,'     =      ',b[i]:8:4);
    end;
  readln;
end.