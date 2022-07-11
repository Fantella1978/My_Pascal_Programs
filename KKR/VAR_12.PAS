{вариант 12}
PROGRAM SORT;
USES
   CRT;
CONST
   N=3;
   M=3;
VAR
   I,J,B:INTEGER;
   A:ARRAY[1..M,1..N] OF REAL ;
   T:REAL;
FUNCTION C(K:INTEGER):INTEGER;
  begin
     if k mod n=0 then c:=k div n
     else c:=k div n+1;
  end;
FUNCTION F(K:INTEGER):INTEGER;
  begin
     f:=n-(c(k)*n-k);
  end;
BEGIN
   CLRSCR;
   RANDOMIZE;
   FOR I:=1 TO M DO
     BEGIN
        FOR J:=1 TO N DO
          BEGIN
             A[I,J]:=RANDOM*32.41-9.3;
             WRITE(A[I,J]:6:2);
          END;
        WRITELN;
     END;
   WRITELN;READKEY;
   FOR I:=2 TO M*N DO
     FOR J:=1 TO I-1 DO
     IF A[C(I),F(I)]<A[C(J),F(J)] THEN
     BEGIN
        T:=A[C(I),F(I)];
        FOR B:=I-1 DOWNTO J DO
          A[C(B+1),F(B+1)]:=A[C(B),F(B)];
        A[C(J),F(J)]:=T;
     END;
   FOR I:=1 TO M DO
     BEGIN
        FOR J:=1 TO N DO
          WRITE(A[I,J]:6:2);
        WRITELN;
     END;
   READKEY;
END.
