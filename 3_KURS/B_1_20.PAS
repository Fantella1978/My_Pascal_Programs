Program B_1_20; {�襭�� ���. �ࠢ����� ��⮤�� �㭣�-����}
const Xnach=0.1; Xkon=0.3; h=0.02;
Var x,y,y1,k1,k2,k3,k4:real;
BEGIN
 y1:= 0.05; y:= 0.05;
 Writeln('��砫�� ���祭�� :'); {�뢮� ��砫��� ���祭��}
 Writeln('X���     = ',Xnach:6:2);
 Writeln('X���     = ',Xkon:6:2);
 Writeln('h        = ',h:6:2);
 Writeln('Y``(0.1) = ',y1:6:2);
 Writeln('Y`(0.1)  = ',y:6:2);
 Writeln('�������� �襭��:');
 x:= Xnach;
 while (x<Xkon+h) do
 begin {����� �����樥�⮢ Ki}
   k1:=h*(2*EXP(-x)-COS(x)+x*y1);
   k2:=h*(2*EXP(-(x+h/2))-COS(x+h/2)+(x+h/2)*(y1+k1/2));
   k3:=h*(2*EXP(-(x+h/2))-COS(x+h/2)+(x+h/2)*(y1+k2/2));
   k4:=h*(2*EXP(-(x+h))-COS(x+h)+(x+h)*(y1+k3));
   {����� ⥪�饣� ���祭�� �襭�� �ࠢ�����}
   y:= y + h * (y1 + (k1 + k2 + k3) / 6);
   y1:= y1 + (k1 + 2 * k2 + 2 * k3 + k4) / 6;
   {�뢮� १���⮢ ����}
   Writeln('X = ', X:6:2, ';   Y = ', Y:6:2);
   x:=x+h
 end
End.
