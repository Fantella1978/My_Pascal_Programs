USES CRT;
TYPE FLY=RECORD
      NUMBER:INTEGER;
      SITY:STRING;
      TIMEOUT:RECORD
         H,M:INTEGER; END;
      TIMEIN:RECORD
      H,M:INTEGER; END;
   PLASE:INTEGER;
END;
VAR P:CHAR;
    N:FILE OF FLY;
    FLY1:FLY;
  PROCEDURE MENU;
  begin
     clrscr;
     gotoxy(5,5);writeln('��ନ஢���� 䠩��..1');
     gotoxy(5,10);writeln('�����..2');
     gotoxy(5,15);writeln('��室..3');
  end;
  PROCEDURE FORM;
  var
     a,b,c:integer;st:string;
  begin
     {$i-}reset(n);{$i+}
     if ioresult=0 then
       begin
          writeln('���� �������');
          close(n);readln;menu;exit;
       end;
     clrscr;rewrite(n);
     repeat
        writeln('������ ����� ३�');
        readln(st);
        if st ='       'then
          begin
             close(n);menu;exit;
          end;
        with fly1 do
          begin
             val(st,number.b);
             writeln('������ �㭪� �����祭��');
             read(city);
             writeln('������ �६� �뫥�,�');
             read(timeout.h);
             writeln('������ �६� �뫥�,���');
             read(timeout.m);
             writeln('������ �६� �ਡ���,�');
             read(timein.h);
             writeln('������ �६� �ਡ���,���');
             read(timein.m);
             writeln('������ ���-�� ᢮������ ����');
             read(place);write(h,fly1);
          end;
     until false;
  end;
  PROCEDURE ZAPROS;
  a,b:integer;
    procedure menu1;
    clrscr;
    writeln('1 �६� �뫥� � ��த N');
    writeln('2 ���-�� ᢮������ ���� � ��த N');
    writeln('3 �� ३�� ��᫥ X�ᮢ Y���');
    writeln('4 ��室');
    end;
    procedure ptime;
    t:boolean;city1:string;
    begin
       reset(n);
       writeln('������ �㭪� �����祭��');
       readln(city1);
       repeat
          read(n,fly1);
          with fly1 do
            begin
               if city=city1 then
                 begin
                    writeln('�६� �뫥�',timeout.h,'�',timeout.m,'���');
                    t:=false;
                 end;
            end;
       until eof(n);close(n);
       if t then
         writeln('⠪�� ३ᮢ ���');
       readln;menu1;
    end;
    procedure place;
    var
       t:boolean;a,b:integer;city1:string;
    begin
       t:=true;reset(n);
       writeln('������ �㭪� �����祭��');
       readln(city1);
       writeln('������ �६� �뫥� �');
       readln(a);
       writeln('������ �६� �뫥� ���');
       readln(b);
       repeat
          read(n,fly1);
          with fly1 do
            begin
               if (city=city1)and(timeout.h=a)and(timeout.m=b)
               then begin
                    writeln(' ���-�� ᢮������ ���� ',place);
                    t:=false; end;
            end;
       until eof(n); close(n);
       if t then
         writeln('⠪�� ३ᮢ ���');
       readln; menu1;
    end;
    procedure afterxy;
    var
       t:boolean;a,b:integer;
    begin
       reset(n);t:=true;
       writeln('������ �६� �뫥� �');
       readln(a);
       writeln('������ �६� �뫥� ���');
       readln(b);
       repeat
          read(n,fly1);
          with fly1 do
            begin
               if (timeout.h>=a)and(timeout.m>b)
               then begin
                    writeln('����� ३�',number);
                    writeln('�㭪� �����祭��',city);
                    writeln('�६� �뫥�',timeout.h,'�',timeout.m,'���');
                    t:=false; end;
            end;
       until eof(n); close(n);
       if t then
         writeln('⠪�� ३ᮢ ���');
       readln; menu1;
    end;
  begin
     menu1;
     repeat
        p:=readkey;
        case p of
           '1':ptime;
           '2':plase;
           '3':afterxy;
           '4',#27:
             begin
                menu;exit;
             end;
        end;
     until false;
  end;
BEGIN
   ASSIGN(N,'c:\aeroport.dat');MENU;
   REPEAT
      P:=READKEY;
      CASE P OF
         '1':FORM;
         '2':ZAPROS;
         '3',#27:HALT;
      END;
   UNTIL FALSE;
END.














