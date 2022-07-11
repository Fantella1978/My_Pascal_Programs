Program BISTRAIA_SORTIROVKA;
Uses Crt;
Var a:array[1..15] of Integer;
    i:Word;

Procedure SORT(l,r:Word);
Var b,t:Integer;
    i,j:Word;
Begin
b:=a[(l+r) div 2];
i:=l;
j:=r;
While i<=j do
Begin
   While a[i] < b do i:=i+1;
     While a[j] > b do j:=j-1;
If i <= j Then
Begin
   t:=a[i];
   a[i]:=a[j];
   a[j]:=t;
   i:=i+1;
   j:=j-1;
End;
End;
If l < j Then SORT(l,j);
If i < r Then SORT(i,r);
End;

BEGIN
ClrScr;
Writeln('BISTRAIA       ...Идёт генерация массива случайных чисел [0..50],');
Writeln('который будет отсортирован по возрастанию...');
Randomize;
For i:=1 to 15 do
Begin
   a[i]:=Random(50);
End;
Writeln('--------------Ok!----------------');
For i:=1 to 15 do Write('a[',i,']=',a[i]:0,'  ');
Writeln;
SORT(1,15);
Writeln('************Отсортированный массив:************');
For i:=1 to 15 do Writeln('a[',i,']=',a[i]:0,'  ');
Readkey;
END.

