{��ਠ�� 24}
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
     writeln('�஢�ઠ ');
     for i:=1 to n do
       writeln(c1[i]:6:5,'=',cc[i,n+1]:6:5);
     readln;
  end;
  PROCEDURE GENERY;
  begin
     write('������ �᫮ �ࠢ����� ');readln(n);
     write('������ �᫮ ���権 ');readln(m);
     randomize;
     for i:=1 to n do
       for j:=1 to n+1 do
       cc[i,j]:=random(10);
  end;
  PROCEDURE VVOD;
  begin
     write('������ �᫮ �ࠢ����� ');readln(n);
     write('������ �᫮ ���権 ');readln(m);
     writeln('������ �����樥��� ��⥬�');
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
     if l<>0 then writeln('�஢�����',l:6,'���権')
     else writeln('�஢����� �� ���樨 ');
     for i:=1 to n do
       writeln('x[',i,']=',x[i]:6:5);
  end;
  PROCEDURE VIBOR1;
  begin
     clrscr;
     writeln('1.������� �ᥫ ');
     writeln('2.���� ������⮢  ');
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
   WRITELN('1.��襭�� ���
   �� ');
   WRITELN('2.��室          ');
   CH:=READKEY;
   CASE CH OF
      '1':VIBOR1;
      '2':HALT;
      #27:HALT;
   END;
END.
