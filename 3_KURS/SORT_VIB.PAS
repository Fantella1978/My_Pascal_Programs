Program SORTIR_VIBOR;
Uses Crt;
Var a:array[1..15] of Integer;
    i,j,max,imin,min:Integer;
BEGIN
ClrScr;
Writeln('VIBOR...���� ������� ���ᨢ� ��砩��� �ᥫ [0..50],');
Writeln('����� �㤥� �����஢�� �� �����⠭��...');
Randomize;
For i:=1 to 15 do
Begin
   a[i]:=Random(50);
End;
Writeln('--------------Ok!----------------');
For i:=1 to 15 do Write('a[',i,']=',a[i]:0,'  ');
Writeln;

For i:=1 to 14 do
Begin
min:=a[i];
imin:=i;
For j:=i+1 to 15 do
   If a[j] < min Then
   Begin
      min:=a[j];
      imin:=j;
   End;
a[imin]:=a[i];
a[i]:=min;
End;

Writeln('************�����஢���� ���ᨢ:************');
For i:=1 to 15 do Writeln('a[',i,']=',a[i]:0,'  ');
Readkey;
END.