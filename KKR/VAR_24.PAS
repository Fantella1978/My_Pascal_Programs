{Вариант 24}
USES
   CRT;
CONST
   E1=0.000001;
VAR
   CC:ARRAY[2..11,2..11] OF REAL;
   X:ARRAY[2..10] OF REAL;
   C1:ARRAY[2..10] OF REAL;
   I,J,K,N,M,L:INTEGER;
   SS:REAL;
   CH:CHAR;
  PROCEDURE PROVERKA;
  begin
     for i:=1 to n do
       for j:=1 to n do
       c1[i]:=c1[i]+cc[i,j]*x[j];
     writeln('Проверка ');
     for i:=1 to n do
       writeln(c1[i]:6:5,'=',cc[i,n+1]:6:5);
     readln;
  end;
  PROCEDURE GENERY;
  begin
     write('Введите число уравнений ');readln(n);
     write('Введите число итераций ');readln(m);
     randomize;
     for i:=1 to n do
       for j:=1 to n+1 do
       cc[i,j]:=random(10);
  end;
  PROCEDURE VVOD;
  begin
     write('Введите число уравнений ');readln(n);
     write('Введите число итераций ');readln(m);
     writeln('Введите коэффициенты системы');
     for i:=1 to n do
       for j:=1 to n+1 do
       if j<>n+1 then
       begin
          write('a[',i,j,']= ');
          readln(cc[i,j]);
       end
     else
       begin
          write('k[',i,j,']= ');
          readln(cc[i,j]);
       end;
  end;
  PROCEDURE ITERACIA;
  begin
     for k:=1 to m do
       begin
          l:=k;
          for i:=1 to n do
            begin
               ss:=cc[i,n+1];
               for j:=1 to n do
                 ss:=ss-cc[i,j]*x[j];
               ss:=ss/cc[i,j];
               x[i]:=x[i]+ss;
               if abs(ss)>e1 then i:=0;
            end;
       end;
     if l<>0 then writeln('Проведено',l:6,'итераций')
     else writeln('Проведены все итерации ');
     for i:=1 to n do
       writeln('x[',i,']=',x[i]:6:5);
  end;
  PROCEDURE VIBOR1;
  begin
     clrscr;
     writeln('1.Генерация чисел ');
     writeln('2.Ввод элементов  ');
     ch:=readkey;
     case ch of
        '1':
          begin
             genery;iteracia;proverka;
          end;
        '2':
          begin
             vvod;iteracia;proverka;
          end;
     end;
  end;
BEGIN
   CLRSCR;
   WRITELN('1.Решение систе
   мы ');
   WRITELN('2.Выход          ');
   CH:=READKEY;
   CASE CH OF
      '1':VIBOR1;
      '2':HALT;
      #27:HALT;
   END;
END.
