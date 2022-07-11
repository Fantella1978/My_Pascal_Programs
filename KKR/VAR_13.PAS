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
     gotoxy(5,5);writeln('Формирование файла..1');
     gotoxy(5,10);writeln('Запрос..2');
     gotoxy(5,15);writeln('Выход..3');
  end;
  PROCEDURE FORM;
  var
     a,b,c:integer;st:string;
  begin
     {$i-}reset(n);{$i+}
     if ioresult=0 then
       begin
          writeln('Файл существует');
          close(n);readln;menu;exit;
       end;
     clrscr;rewrite(n);
     repeat
        writeln('Введите номер рейса');
        readln(st);
        if st ='       'then
          begin
             close(n);menu;exit;
          end;
        with fly1 do
          begin
             val(st,number.b);
             writeln('Введите пункт назначения');
             read(city);
             writeln('Введите время вылета,ч');
             read(timeout.h);
             writeln('Введите время вылета,мин');
             read(timeout.m);
             writeln('Введите время прибытия,ч');
             read(timein.h);
             writeln('Введите время прибытия,мин');
             read(timein.m);
             writeln('Введите кол-во свободных мест');
             read(place);write(h,fly1);
          end;
     until false;
  end;
  PROCEDURE ZAPROS;
  a,b:integer;
    procedure menu1;
    clrscr;
    writeln('1 время вылета в город N');
    writeln('2 кол-во свободных мест в город N');
    writeln('3 все рейсы после Xчасов Yмин');
    writeln('4 выход');
    end;
    procedure ptime;
    t:boolean;city1:string;
    begin
       reset(n);
       writeln('Введите пункт назначения');
       readln(city1);
       repeat
          read(n,fly1);
          with fly1 do
            begin
               if city=city1 then
                 begin
                    writeln('время вылета',timeout.h,'ч',timeout.m,'мин');
                    t:=false;
                 end;
            end;
       until eof(n);close(n);
       if t then
         writeln('таких рейсов нет');
       readln;menu1;
    end;
    procedure place;
    var
       t:boolean;a,b:integer;city1:string;
    begin
       t:=true;reset(n);
       writeln('Введите пункт назначения');
       readln(city1);
       writeln('Введите время вылета ч');
       readln(a);
       writeln('Введите время вылета мин');
       readln(b);
       repeat
          read(n,fly1);
          with fly1 do
            begin
               if (city=city1)and(timeout.h=a)and(timeout.m=b)
               then begin
                    writeln(' кол-во свободных мест ',place);
                    t:=false; end;
            end;
       until eof(n); close(n);
       if t then
         writeln('таких рейсов нет');
       readln; menu1;
    end;
    procedure afterxy;
    var
       t:boolean;a,b:integer;
    begin
       reset(n);t:=true;
       writeln('Введите время вылета ч');
       readln(a);
       writeln('Введите время вылета мин');
       readln(b);
       repeat
          read(n,fly1);
          with fly1 do
            begin
               if (timeout.h>=a)and(timeout.m>b)
               then begin
                    writeln('номер рейса',number);
                    writeln('пункт назначения',city);
                    writeln('время вылета',timeout.h,'ч',timeout.m,'мин');
                    t:=false; end;
            end;
       until eof(n); close(n);
       if t then
         writeln('таких рейсов нет');
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














