{��ਠ�� 5}
USES
   CRT;
CONST
   A:ARRAY[1..46] OF CHAR=('�','�','�','�','�','�','�','�','�','�','�',
   '�','�','�','�','�','�','�','�','�','�','�','�',
   '�','�','�','�','�','�','�','�','�','�','�',
   '�','�','�','�','�','�','�','�','�','�','�','�');
VAR
   CH     :CHAR;
   F      :TEXT;
   I,J    :INTEGER;
   KOLSOGL:INTEGER:
   KOLSTR :INTEGER;
   LENG   :INTEGER;
   LENGALL:INTEGER;
   STR40  :INTEGER;
   STR3   :INTEGER;
   SREDNDL:REAL;
   S,S1:STRING;
  PROCEDURE CHOUSE1;
  begin
     clrscr;
     while not eof(f) do
       begin
          readln(f,s);
          leng:=length(s);
          kolstr:=kolstr+1;
          if leng>40 then
            str40:=str40+1;
          lengall:=lengall+leng;
          for i:=1 to leng do
            for j:=1 to 46 do
            if s[i]=a[j] then
            kolsogl:=kolsogl+1;
          for i:=0 to leng do
            if (s[i]=' ') or (s[i]=',') or (s[i]=';') or (s[i]=':') or (s[i]='.') then
            begin
               if length(s1)<3 then str3:=str3+1;
               s1:='';
            end
          else
            if s[i]='-' then s1:=s1
          else s1:=s1+s[i];
       end;
     sredndl:=lengall/kolstr;
     writeln('������⢮ ᮣ����� �㪢               ',kolsogl:7);
     writeln('�����⢮ ��ப ������ ����� 40 ᨬ�����',str40:7);
     writeln('������⢮ ᫮� ������ ����� 3 ᨬ����  ',str3:7);
     writeln('��饥 ������⢮ ᨬ����� � ⥪��      ',lengall:7);
     writeln('�।��� ����� ��ப�                    ',sredndl:7:4);
     readln;
  end;
BEGIN
   ASSIGN(F,'input.dat');
   RESET(F);
   REPEAT
      CLRSCR;
      WRITELN('1. ��ࠡ�⪠ 䠩��.');
      WRITELN('2. ��室.          ');
      CH:=READKEY;
      CASE CH OF
         '1':CHOUSE1;
         '2':HALT;
         #27:HALT;
      END;
   UNTIL FALSE;
END.
