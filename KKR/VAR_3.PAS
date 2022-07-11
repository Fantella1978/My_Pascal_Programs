USES
   CRT;
CONST
   E = 0.0001;
   MIN = -50;
   MAX = 50;
   S = 0.1;
VAR
   A, B, C, D : REAL;
   N, M : REAL;
   C1, C2, H : REAL;
   K : CHAR;
  FUNCTION F(X : REAL) : REAL;
  begin
     f := a*x*x*x+b*x*x+c*x+d;
  end;
  FUNCTION SGN(X : REAL) : SHORTINT;
  begin
     if x = 0
     then sgn := 0
     else sgn := round(x/abs(x))
  end;
BEGIN
   K := ' ';
   REPEAT
      CLRSCR;
      WRITELN('Выберете:');
      WRITELN('1-решение кубического уравнения');
      WRITELN('2-выход');
      IF K = '1' THEN
      BEGIN
         CLRSCR;
         WRITELN('Введите коэффициенты a,b,c,d:');
         READLN(A, B, C, D);
         N := MIN;
         REPEAT
            M := N;
            N := N+S;
            IF (SGN(F(M)) <> SGN(F(N))) THEN
              BEGIN
                 C1 := M;
                 REPEAT
                    C2 := C1;
                    C1 := (M+N)/2;
                    IF SGN(F(C1)) = SGN(F(M))
                    THEN M := C1
                    ELSE N := C1;
                    H := C1;
                 UNTIL ABS(C1-C2) < E;
                 WRITE('Найден корень:', H:7:3);
                 IF ABS(F(H)) < 0.05 THEN WRITELN('   Решение верно')
                 ELSE WRITELN('   Решение неверно');
                 N := H+S/2;
              END;
         UNTIL N > MAX;
      END;
      K := READKEY;
   UNTIL (K = '2') OR (K = #27);
END.
