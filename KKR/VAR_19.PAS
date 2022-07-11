{19Ватиант}
USES
   CRT,DOS;
TYPE
   MOPC = ARRAY[1..2] OF STRING;
CONST
   N=2000;
   V=12+1;
VAR
   X,Y :ARRAY[1..N] OF INTEGER;
   MIN,I,J,K,L : INTEGER;
   WKEY    : CHAR;
   H,M,S,SS:WORD;
   TIME1,TIME2:REAL;
BEGIN
   CLRSCR;
   WHILE WKEY<>(#27) DO
     BEGIN
        CLRSCR;
        WRITELN('    1.ТАБУЛЯЦИЯ ');
        WRITELN('    2.ВЫХОД     ');
        WKEY:=READKEY;
        IF (WKEY =#27) OR (WKEY =#50)THEN
          HALT;
        IF WKEY =#49 THEN
          BEGIN
             WRITELN('Cгенерирированы массивы X,Y');
             FOR I:=1 TO N DO
               BEGIN
                  X[I]:=20+RANDOM(V);
                  Y[I]:=X[I];
               END;
             READLN;
             GETTIME (H,M,S,SS);
             TIME1:=H*3600+M*60+S+SS/100;
             FOR I:=1 TO N-1 DO
               BEGIN
                  MIN:=X[I];
                  K:=I;
                  FOR J:=I+1 TO N DO
                    BEGIN
                       IF X[J]<MIN THEN
                         BEGIN
                            MIN:=X[J];
                            K:=J;
                         END;
                    END;
                  X[K]:=X[I];
                  X[I]:=MIN;
               END;
             GETTIME (H,M,S,SS);
             TIME2:=H*3600+M*60+S+SS/100;
             WRITELN('Массив X :');
             FOR J:=1 TO N DO
               WRITE('  ',X[J]);
             WRITELN('Время сортировки массива X :',TIME2-TIME1:10:8,' cек');
             READLN;
             GETTIME (H,M,S,SS);
             TIME1:=H*3600+M*60+S+SS/100;
             FOR K:=N DOWNTO 2 DO
               FOR I:=1 TO K-1 DO
               IF Y[I]>Y[I+1] THEN
               BEGIN
                  L:=Y[I];
                  Y[I]:=Y[I+1];
                  Y[I+1]:=L;
               END;
             GETTIME (H,M,S,SS);
             TIME2:=H*3600+M*60+S+SS/100;
             WRITELN('Массив Y :');
             FOR I:=1 TO N DO
               WRITE('  ',Y[I]);
             WRITELN('Время сортировки массива Y :',TIME2-TIME1:10:8,' cек');
             READLN;
          END;
        WKEY:=READKEY;
     END;
END.
