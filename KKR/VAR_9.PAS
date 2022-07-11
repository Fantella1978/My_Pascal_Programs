{9вариант}
USES
   CRT;
CONST
   M=8;
   N=7;
VAR
   MENU:CHAR;
   I,J:BYTE;
   MATR:ARRAY[1..M,1..N]OF REAL;
   MAS:ARRAY[1..M,1..N]OF REAL;
   X:REAL;
   XMIN,YMIN:INTEGER;
  FUNCTION MIN(I,J:INTEGER):REAL;
  var
     k,l:integer;
     min1:real;
  begin
     min1:=mas[i,j];
     for k:=i to m do
       begin
          if k>i then j:=1;
          for l:=j to n do
            if mas[k,l]<min1 then
            begin
               min1:=mas[k,l];
               xmin:=k;
               ymin:=l;
            end
       end;
     min:=min1;
  end;
BEGIN
   CLRSCR;
   WRITELN(' F1 - Ввод значений и расчет');
   WRITELN(' F2 - Обработка данных');
   WRITELN('ESC - Exit');
   REPEAT
      MENU:=READKEY;
      CASE MENU OF
         #59:
           BEGIN
              WRITELN('Исходный массив:');
              RANDOMIZE;
              FOR I := 1 TO M DO
                BEGIN
                   FOR J := 1 TO N DO
                     BEGIN
                        MATR[I,J] := RANDOM(29)-5.29;
                        WRITE(MATR[I,J]:8:2);
                     END;
                   WRITELN;
                END;
           END;
         #60:
           BEGIN
              WRITELN('Исходный массив COS:');
              FOR I := 1 TO M DO
                BEGIN
                   FOR J := 1 TO N DO
                     BEGIN
                        MAS[I,J]:=COS(MATR[I,J]);
                        WRITE(MAS[I,J]:8:2);
                     END;
                   WRITELN;
                END;
              WRITELN('Отсортированный массив:');
              FOR I:=1 TO M DO
                FOR J:=1 TO N DO
                BEGIN
                   X:=MAS[I,J];
                   MAS[I,J]:=MIN(I,J);
                   MAS[XMIN,YMIN]:=X;
                END;
              FOR I:=1 TO M DO
                BEGIN
                   FOR J:=1 TO N DO
                     BEGIN
                        WRITE(MAS[I,J]:8:2);
                     END;
                   WRITELN;
                END;
           END;
         #27: HALT;
      END;
   UNTIL FALSE;
END.
