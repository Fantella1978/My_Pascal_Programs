{��ਠ�� 6}
USES
   CRT;
CONST
   M = 8;
VAR
   KEY : CHAR;
   A : ARRAY[1..M, 1..M] OF REAL;
   I, J : 1..M;
   AV, MUL, T : REAL;
   MIN, MAX : REAL;
BEGIN
   RANDOMIZE;
   REPEAT
      CLRSCR;
      WRITELN('�롥��:');
      WRITELN('1-�������');
      WRITELN('2-��ࠡ�⪠');
      WRITELN('3-��室');
      IF KEY = '1' THEN
      BEGIN
         FOR I := 1 TO M DO
           BEGIN
              FOR J := 1 TO M DO
                BEGIN
                   A[I, J] := RANDOM*(17.23+5.3)-5.3;
                   WRITE(A[I, J]:8:3)
                END;
              WRITELN
           END
      END
      ELSE
        IF KEY = '2' THEN
        BEGIN
           CLRSCR;
           AV := 0;
           MUL := 1;
           FOR I := 2 TO M DO
             BEGIN
                AV := AV+A[I-1, I];
                T := A[I, I-1];
                IF (T >= -1) AND (T <= 1) THEN MUL := MUL*T
             END;
           WRITELN('��室��� �����');
           FOR I := 1 TO M DO
             BEGIN
                FOR J := 1 TO M DO
                  BEGIN
                     WRITE(A[I, J]:8:3)
                  END;
                WRITELN
             END;
           AV := AV/(M-1);
           WRITELN('�।���:', AV);
           WRITELN('��-�:', MUL);
           WRITELN('P���������� �����:');
           FOR I := 1 TO M DO
             BEGIN
                MIN := A[I, 1];
                MAX := MIN;
                FOR J := 1 TO M DO
                  BEGIN
                     T := A[I, J];
                     IF T < MIN THEN MIN := T;
                     IF T > MAX THEN MAX := T
                  END;
                A[I, 1] := MAX;
                A[I, M] := MIN;
                FOR J := 1 TO M DO
                  WRITE(A[I, J]:8:3);
                WRITELN
             END
        END;
      KEY := READKEY;
   UNTIL (KEY = '3') OR (KEY = #27)
END.
