Uses Crt;
Var
   x, Xbeg, Xend, h, Xn, y, y1, k1, k2, k3, k4 : real;
Begin
     Clrscr;
     Writeln( '��襭�� ����७樠�쭮�� �ࠢ����� ��⮤�� �㭣� - ����');
     Writeln( '�������� �襭��:');

     {�������� ��砫�� �����}
     Xbeg:= 0.2; Xend:=0.4; h:=0.01; xn:=0.1; y:=0.02; y1:=0.02;

     x:= xn;
     while (x < Xend) do
       begin
           {����� �����樥�⮢ Kj}
           k1:= h * (2 * EXP(-0.5 * x) - SIN(x) + y1);
           k2:= h * (2 * EXP(-0.5 * (x + h / 2)) - SIN(x + h / 2) + (y1 + k1 / 2));
           k3:= h * (2 * EXP(-0.5 * (x + h / 2)) - SIN(x + h / 2) + (y1 + k2 / 2));
           k4:= h * (2 * EXP(-0.5 * (x + h)) - SIN(x + h) + (y1 + k3));
           {����� ⥪�饣� ���祭�� �襭�� �ࠢ�����}
           y:= y + h * (y1 + (k1 + k2 + k3) / 6);
           y1:= y1 + (k1 + 2 * k2 + 2 * k3 + k4) / 6;
           x:=x+h;
           {�뢮� १���⮢ ����}
           if (x >= Xbeg) then
           Writeln('X = ', X:6:2, ';   Y = ', Y:6:2)
     end
End.

