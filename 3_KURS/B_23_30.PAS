Program B_23_30;      {���᫥��� ��⥣ࠫ� ��⮤���
                      ����� � �ࠢ�� ��אַ㣮�쭨���}
var   dx,Sl,Sp:real;
      m:integer;
const n=10; a=0; b=2;

Function f(x:real):real;
Begin
 f:=x*exp(-x);        {������ �㭪��}
end;

BEGIN
 Sl:=0; Sp:=0;
 dx:=(b-a)/n;
 for m:=1 to n do        {��⮤ ����� ��ﯮ㣮�쭨���}
  Sl:=Sl+F(dx*m+a)*dx;
 for m:=0 to n-1 do      {��⮤ �ࠢ�� ��ﯮ㣮�쭨���}
  Sp:=Sp+F(dx*m+a)*dx;
 writeln('�� ��⮤� ����� ��אַ㣮�쭨���: ',Sl:10:7);
 writeln('�� ��⮤� �ࠢ�� ��אַ㣮�쭨���: ',Sp:10:7);
 if Sp>Sl
  then
   writeln('��⮤ �ࠢ�� ��אַ�. ��� ����訩 १����.')
  else
   writeln('��⮤ ����� ��אַ�. ��� ����訩 १����.');
END.
