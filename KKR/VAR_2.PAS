{��ਠ�� 2}
USES
   CRT,DOS;
VAR
   C:CHAR;
   N,I:LONGINT;
   ZN:REAL;
   X,XN,XK,H,E:REAL;
   S,S1,Q:REAL;
   P:EXTENDED;
  FUNCTION STEP(X1,ST:REAL):DOUBLE;
  begin
     step:=exp(ln(abs(x1))*st);
  end;
  FUNCTION FACT(N1:LONGINT):DOUBLE;
  var
     f:double;
     j:longint;
  begin
     f:=1;
     if n1 > 1 then
       for j:=2 to n1 do
       f:=f*j;
     fact:=f
  end;
BEGIN
   WHILE C<>CHR(27) DO
     BEGIN
        CLRSCR;
        WRITELN('1 - �㬬� �鸞');
        WRITELN('2 - ��室');
        C:=READKEY;
        IF (C=CHR(50)) OR (C=CHR(27)) THEN
          EXIT;
        IF C=CHR(49) THEN
          BEGIN
             CLRSCR;
             WRITE('������ X���, X��� � 蠣 h');
             READ(XN,XK,H);
             WRITE('������ �筮��� E=');
             READLN(E);
             X:=XN;
             S:=0;
             S1:=0;
             P:=1;
             WHILE X <= XK DO
               BEGIN
                  N:=20;
                  REPEAT
                     N:=N*2;
                     S1:=S;
                     P:=1;
                     FOR I:= 1 TO N DO
                       BEGIN
                          IF ODD(I)=TRUE THEN
                            ZN:=-1
                          ELSE
                            ZN:=1;
                          Q:=(ZN*STEP(X,(I-1))-ZN*STEP(X,(I+1)))/(STEP(ABS(X),EXP(1))*FACT(I));
                          S:=S+Q;
                          IF I>=N-2 THEN
                            P:=P*Q;
                       END;
                  UNTIL ABS(S-S1)<= E;
                  WRITELN('�� X=',X:8:4);
                  WRITELN(' �㬬� �鸞 S= ',S:10:6) ;
                  WRITELN(' �ந�������� ��᫥���� 3-� 童��� �鸞 P= ',P:10:6);
                  C:=READKEY;
                  X:=X+H;
                  S:=0;
                  S1:=0;
                  P:=1;
               END;
          END;
     END;
END.
