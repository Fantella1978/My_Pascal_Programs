Program SORTIR_PUZIROK;
Uses Crt;
Var a:array[1..15] of Integer;
    i,max,cur:Integer;
BEGIN
ClrScr;
Writeln('PUZIROK...Идёт генерация массива случайных чисел [0..50],');
Writeln('который будет отсортирован по возрастанию...');
Randomize;
For i:=1 to 15 do
Begin
   a[i]:=Random(50);
End;
Writeln('--------------Ok!----------------');
For i:=1 to 15 do Write('a[',i,']=',a[i]:0,'  ');
Writeln;

i:=2;
While i <= 15 do
Begin
   If a[i] < a[i-1] Then
    Begin
       cur:=a[i-1];
       a[i-1]:=a[i];
       a[i]:=cur;
       i:=1;
    End;
i:=i+1;
End;
Writeln('************Отсортированный массив:************');
For i:=1 to 15 do Writeln('a[',i,']=',a[i]:0,'  ');
Readkey;
END.