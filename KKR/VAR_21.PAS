{Вариант 21}
USES
   CRT;
VAR
   A:CHAR;
   M1:ARRAY [1..8,1..7] OF REAL;
   M,N,S,I,IMIN:BYTE;
   MIN:REAL;
  PROCEDURE F(EKRAN:BOOLEAN);
  begin
     for m:=1 to 8 do
       for n:=1 to 7 do
       begin
          if ekran
          then
            m1[m,n]:=random(4088)/100-15.12;
          gotoxy(n*7,m);write(m1[m,n]:6:2);
       end;
     readln;
  end;
  FUNCTION X(A:BYTE):BYTE;
  begin
     x:=((a-1)div n)+1;
  end;
  FUNCTION Y(A:BYTE):BYTE;
  begin
     y:=((a-1)mod n)+1;
  end;
BEGIN
   REPEAT
      CLRSCR;
      WRITELN('1- Генерация');
      WRITELN('2- Обработка');
      WRITELN('3- Выход');
      A:=READKEY;
      WRITE(A);
      DELAY(500);
      CLRSCR;
      CASE A OF
         '1':F(TRUE);
         '2':
           BEGIN
              FOR S:=1 TO 55 DO
                BEGIN
                   MIN:=M1[X(S),Y(S)];
                   IMIN:=S;
                   FOR I:=S+1 TO 56 DO
                     IF SIN(M1[X(I),Y(I)])<SIN(MIN)
                   THEN
                     BEGIN
                        MIN:=M1[X(I),Y(I)];
                        IMIN:=I;
                     END;
                   M1[X(IMIN),Y(IMIN)]:=M1[X(S),Y(S)];
                   M1[X(S),Y(S)]:=MIN;
                END;
              F(FALSE);
           END;
      END;
   UNTIL(A='3') OR (A=CHR(27));
END.
