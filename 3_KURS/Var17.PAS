Uses crt;
Var
   x,xn,xk,h,y,
   k1, k2, k3, k4 : real;
   i: integer;
Begin
     clrscr;
     writeln('�ணࠬ�� �襭�� ����७樠�쭮�� �ࠢ����� ��⮤�� �㭣� - ����');
     writeln( '�������� �襭��:');
{�������� ��砫�� �����}
     xn:= -0.1; xk:=0.2; h:=0.05;
{��।������� ��砫�� ���祭�� ��६�����}
     x:= xn; y:= 0.02; i:= 0;
     repeat
           x:= x+h; i:=i+1;
           {����� �����樥�⮢ Ki}
           k1:= h * (x + SIN(x));
           k2:= h * ((x + h / 2) + SIN(x + h / 2));
           k3:= h * ((x + h / 2) + SIN(x + h / 2));
           k4:= h * ((x + h) + SIN(x + h));
           {����� ⥪�饣� ���祭�� �襭�� �ࠢ�����}
           y:= y + (k1 + 2 * k2 + 2 * k3 + k4) / 6;
           {�뢮� १���⮢ ����}
           writeln('X = ', x:6:2, ';   Y(', i, ')=', y:6:2);
           {��室 �� 横�� � ��砥 ���⨦���� ��६����� x ���� ���������}
     until (x > xk)
End.

