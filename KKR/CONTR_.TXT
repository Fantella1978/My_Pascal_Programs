{18 вариант}
USES
   CRT,DOS;
VAR
   CH:CHAR;
   X,XN,XK,H:REAL;
   SEC,CTG,S,Y:DOUBLE;
   FILE1:TEXT;
BEGIN
   WHILE CH<>CHR(27) DO
     BEGIN
        CLRSCR;
        WRITELN('1 - Табуляция ');
        WRITELN('2 - Выход');
        CH:=READKEY;
        IF (CH=CHR(50)) OR (CH=CHR(27)) THEN
          EXIT;
        IF CH=CHR(49) THEN
          BEGIN
             CLRSCR;
             WRITE('Введите Xнач, Xкон и шаг h');
             READ(XN,XK,H);
             ASSIGN(FILE1,'output.dat');
             REWRITE(FILE1);
             X:=XN;
             WHILE X<=XK DO
               BEGIN
                  Y:=0;
                  IF X<-5 THEN
                    BEGIN
                       CTG:=COS(X)/SIN(X);
                       IF CTG>=0 THEN
                         S:=EXP(LN(ABS(-X))*CTG)
                       ELSE
                         S:=1/EXP(LN(ABS(-X))*ABS(CTG));
                       Y:=S+ABS(SIN(X))/SIN(X)*EXP(LN(ABS(SIN(X)))/3)*LN(ABS(2*X));
                    END;
                  IF (X>-3) AND (X<=0.5) THEN
                    BEGIN
                       IF COS(X)<>0 THEN
                         BEGIN
                            S:=X-21/COS(X);
                            IF S >0 THEN
                              Y:=SIN(2*X)/SQRT(S);
                         END;
                    END;
                  IF (X>1) AND (X<=4) THEN
                    BEGIN
                       IF X>1.5 THEN
                         BEGIN
                            SEC:=(EXP(X/2)-EXP(-X/2))/2;
                            Y:=SEC-LN(X-1.5)+X;
                         END;
                    END;
                  IF X>5 THEN
                    BEGIN
                       Y:=EXP(LN(ABS(4*X-0.5))*6)-SQRT(PI*EXP(1)*X);
                    END;
                  IF Y<>0 THEN
                    BEGIN
                       WRITELN('При Х= ',X:8:5,'   Y= ',Y:10:5);
                       WRITELN(FILE1,'Х= ',X:8:5,' Y= ',Y:10:5);
                    END
                  ELSE
                    BEGIN
                       WRITELN('При Х= ',X:8:5,'   Y не существует ');
                       WRITELN(FILE1,'Х= ',X:8:5,' Y не существует ');
                    END;
                  X:=X+H;
               END;
             CH:=READKEY;
             CLOSE(FILE1);
          END;
     END;
END.
