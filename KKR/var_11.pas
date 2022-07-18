{11 Вариант}
USES
   CRT;
VAR
   CH:CHAR;
   F:TEXT;
   XB,XE,ST,TMP,Y:REAL;
   ERROR:BOOLEAN;
  FUNCTION A(X:REAL):REAL;
  begin
     if cos(x)<>0 then
       a:=exp(sin(x)/cos(x)*ln(0.5))-exp(1/3*ln(abs(x)))*ln(abs(2*x*exp(1)))
     else
       error:=true;
  end;
  FUNCTION B(X:REAL):REAL;
  begin
     b:=cos(x/exp(1/3*ln(1-x)))
  end;
  FUNCTION C(X:REAL):REAL;
  begin
     if cos(2*x)<>0 then
       c:=sin(2*x)/cos(2*x)-ln(2*(x-1.5))/ln(10)
     else
       error:=true;
  end;
  FUNCTION D(X:REAL):REAL;
  begin
     d:=exp(5*ln(x-4.5))-exp(1/4*ln(pi*x))
  end;
BEGIN
   REPEAT
      CLRSCR;
      WRITELN('1..Расчет');
      WRITELN('2..Выход ');
      CH:=READKEY;
      IF CH=#27
      THEN
        HALT;
      CASE CH OF
         '1':
           BEGIN
              ASSIGN(F,'output.dat');
              REWRITE(F);
              WRITELN('Введите нач кон шаг');
              READLN(XB,XE,ST);
              TMP:=XB;
              WHILE TMP<=XE+1E-9 DO
                BEGIN
                   ERROR:=FALSE;
                   IF TMP<-3 THEN Y:=A(TMP);
                   IF (TMP>=-3) AND (TMP<1) THEN Y:=B(TMP);
                   IF (TMP>1.5) AND (TMP<4) THEN Y:=C(TMP);
                   IF TMP>=5 THEN Y:=D(TMP);
                   IF (TMP<1) AND (TMP>1.5) AND (TMP<4) AND (TMP>=5) THEN
                     IF  ERROR=FALSE THEN WRITELN(F,'x=',TMP:5:2,'  y=',Y:4:2)
                   ELSE WRITELN(F,'x=',TMP:5:2,'tg(x) не сущ');
                   TMP:=TMP+ST
                END;
              CLOSE(F);
           END;
         '2':EXIT;
      END;
   UNTIL FALSE
END.