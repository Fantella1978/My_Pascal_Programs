Program var5;
{��� ⮣�, �⮡� �襭�� �室����� ����室��� �믮������ ᫥���饣�
  �᫮���
     |F'(x)<1|<1 �� ��� � �� ࠡ�祣� ���ࢠ��
  ࠧ㬥����, �� ࠡ�稩 ���ࢠ� ������ �� ��砫쭮�� ���祭��.
  � ������ ��砥 � ����⢥ ��砫쭮�� ���祭�� ������
  �0=1.2}
uses crt;
const x0=1.2;
      e=1e-6;
      n=1000; {���ᨬ��쭮� �᫮ ���権}
var x:real;
    s:boolean;
    i:integer;

function ff(x:real):real;
begin
  ff:=cos(x)+0.5;
end;

begin
  clrscr;
  s:=false;
  x:=x0;
  for i:=1 to n do
    begin
      if abs(ff(x)-x)<e*abs(x) then begin s:=true;break end;
      x:=ff(x);
    end;
  if s then writeln('��७� �ࠢ����� X=',x:10:5)
       else writeln('������� ��砫쭮� ���祭��');
  readln;
end.