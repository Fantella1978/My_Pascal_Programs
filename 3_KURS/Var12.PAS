Program var12;
uses crt;
{���� ��⮤�:
��।. 蠣 dx=(a-b)/n,a � b -�।��� ��⥣�஢����,
n- ���-�� ࠧ������;
�஢���� ����� � �窠� ࠧ������;
��ந� �� ��� ������ ��אַ㣮�쭨��, �ᯮ���� �����
��� ��஭�.�᫨ �� �⮬ ��אַ㣮�쭨� �ᮢ���
��ࠢ� �� ����祭�� ����� � ��אַ� - ��⮤
����� ��אַ㣮�쭨���(��� ᫥�� �� ��אַ�.,� �����)
�᫨ ����� - � �ࠢ�� ��אַ㣮�쭨��� (��ࠤ���)
}
const a=1;b=0;
      n=20;
var IR,IL,dx,DI:real;
    i:integer;
begin
  clrscr;
  writeln('O�।������ ��⥣ࠫ f(x)=e^(-(x^2))');
  writeln('��⮤��� ����� � �ࠢ�� ��אַ㣮�쭨���');
  writeln('� ���ࢠ�� 0 - 1');
  dx:=(a-b)/n;
  IR:=0;
  IL:=0;
  for i:=1 to n do
    begin
      IL:=IL+dx*exp(-(sqr(0+dx*(n-1))));
      IR:=IR+dx*exp(-(sqr(0+dx*n)));
    end;
  writeln('��������:');
  writeln('�� ��⮤� �����  I=',IL:7:4);
  writeln('�� ��⮤� �ࠢ�� I=',IR:7:4);
  DI:=abs(IL-IR);
  writeln('�������� ���祭�� = ',DI:8:5);
  readln;
end.