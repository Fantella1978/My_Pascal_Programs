Program SORTIR_VSTAVKA;
Uses Crt;
Var a:array[1..15] of Integer;
    i,k,z,buf,j:Integer;

BEGIN
ClrScr;
Writeln('VSTAVKA...Идёт генерация массива случайных чисел [0..50],');
Writeln('который будет отсортирован по возрастанию...');
Randomize;
For i:=1 to 15 do   a[i]:=Random(50);
Writeln('--------------Ok!----------------');
For i:=1 to 15 do Write('a[',i,']=',a[i],'   ');
Writeln;

For k:=1 to 15 do Write(a[k]:4);writeln('');

For i:=2 to 15 do
Begin
buf:=a[i];
   z:=1;
   While buf > a[z] do z:=z+1;
   For j:=i-1 downto z do a[j+1]:=a[j];
   a[z]:=buf;
For k:=1 to 15 do Write(a[k]:4);writeln('');

End;
Writeln('************Отсортированный массив:************');
For i:=1 to 15 do Write('a[',i,']=',a[i],'  ');
Readkey;
    END.