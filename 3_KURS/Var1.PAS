Uses Crt;

Var
   x, y, Xnach, Xkon, y1, h,
   k1, k2, k3, k4 : real;
Begin
     Clrscr;
     Writeln( '������ �ணࠬ�� �����⢫�� �襭�� ����७樠�쭮��');
     Writeln( '           �ࠢ����� ��⮤�� �㭣� - ����');
     {�뢮� ��砫��� ���祭��}
     Writeln( '��砫�� ���祭�� :');
     Write('X = ');
     Read(x);
     Write('Y = ');
     Read(y);
     Writeln('�������� �襭��:');
     {�������� ��砫�� �����}
     Xnach:= 0.1; Xkon:= 0.3; h:=0.02; y1:= 0.05; y:= 0.05;

     x:= Xnach;
     while (x<Xkon) do
     begin
          {����� �����樥�⮢ Ki}
          k1:= h * (2 * EXP(-x) - COS(x) + x * y1);
          k2:= h * (2 * EXP(-(x+h/2)) - COS(x+h/2) + (x+h/2) * (y1+k1/2));
          k3:= h * (2 * EXP(-(x+h/2)) - COS(x+h/2) + (x+h/2) * (y1+k2/2));
          k4:= h * (2 * EXP(-(x + h)) - COS(x + h) + (x + h) * (y1 + k3));
          {����� ⥪�饣� ���祭�� �襭�� �ࠢ�����}
          y:= y + h * (y1 + (k1 + k2 + k3) / 6);
          y1:= y1 + (k1 + 2 * k2 + 2 * k3 + k4) / 6;
          {�뢮� १���⮢ ����}
          Writeln('X = ', X:6:2, ';   Y = ', Y:6:2);
          x:=x+h
     end
End.
