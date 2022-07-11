{22Вариант}
USES
   CRT,DOS;
TYPE
   STUDENT=RECORD
      INDEX:STRING[7];
      FIO:STRING[15];
      EXAM:ARRAY[1..4] OF STRING[10];
      OCEN:ARRAY[1..4] OF INTEGER;
      ZACH:ARRAY[1..5] OF STRING[10];
      ZN:ARRAY[1..5] OF CHAR;
   END;
VAR
   CH:CHAR;
   F:FILE OF STUDENT;
   I:INTEGER;
   IMA:STUDENT;
  PROCEDURE OKNO;
  begin
     clrscr;
     gotoxy(5,5);writeln('Формирование файла..1');
     gotoxy(5,10);writeln('Запрос..2');
     gotoxy(5,15);writeln('Выход..3');
  end;
  PROCEDURE OPC1;
  begin
     clrscr;
     {$I-}reset(f);{$I+}
     if ioresult=0
     then
       begin
          writeln('Файл существует');
          close(f);
          readln;
          okno;
          exit;
       end;
     begin
        clrscr;
        rewrite(f);
        repeat
           writeln('Введите индекс группы');
           readln(ima.index);
           if ima.index ='       '
           then
             begin
                close(f);
                okno;
                exit;
             end;
           writeln('Введите ФИО студента');
           readln(ima.fio);
           for i:=1 to 4 do
             begin
                writeln('Введите экзамен');
                readln(ima.exam[i]);
                writeln('Введите оценку');
                readln(ima.ocen[i]);
             end;
           for i:=1 to 5 do
             begin
                writeln('Введите зач');
                readln(ima.zach[i]);
                writeln('Введите оценка');
                readln(ima.zn[i]);
             end;
           write(f,ima);
        until false;
     end;
  end;
  PROCEDURE OPC2;
  var
     who:string[15];
     gr:string[7];
     hor,dva,tri:boolean;
     s_dva,s_hor:integer;
  begin
     clrscr;
     s_dva:=0;
     s_hor:=0;
     dva:=false;
     tri:=false;
     hor:=false;
     writeln('Введите ФИО студента');
     readln(who);
     reset(f);
     while not(eof(f)) do
       begin
          read(f,ima);
          if ima.fio=who
          then
            gr:=ima.index
          else
            begin
               writeln('Такой ФИО нет');
               readln;
            end;
       end;
     seek(f,1);
     while not(eof(f)) do
       begin
          read(f,ima);
          if ima.index=gr
          then
            begin
               for i:=1 to 4 do
                 begin
                    if (ima.ocen[i]=5)or(ima.ocen[i]=4)
                    then
                      hor:=true;
                    if (ima.ocen[i]=3)
                    then
                      tri:=true;
                    if (ima.ocen[i]=2)
                    then
                      dva:=true;
                 end;
               if dva
               then
                 s_dva:=s_dva+1
               else
                 if tri
               then
                 tri:=false
               else
                 begin
                    for i:=1 to 5 do
                      begin
                         if ima.zn[i]='з'
                         then
                           hor:=true
                         else
                           tri:=true;
                      end;
                    if tri
                    then
                      s_dva:=s_dva+1
                    else
                      s_hor:=s_hor+1;
                 end;
            end;
       end;
     writeln('Студенты, сдавшие все зачеты и экзамены на 4,5 ',s_hor);
     writeln('Неуспевающие студенты, не сдавшие хотябы один зачет или экзамен ',s_dva);
     close(f);
     okno;
     readln;
  end;
  PROCEDURE MENU;
  begin
     repeat
        ch:=readkey;
        if ch=#49
        then
          opc1
        else
          if ch=#50
        then
          opc2
        else
          if (ch=#51) or(ch=#27)
        then
          halt(1)
        else
          writeln('no2 !!!');
     until false;
  end;
BEGIN
   ASSIGN(F,'c:\sessia.dat');
   OKNO;
   WHILE NOT((CH=#51)OR(CH=#27)) DO
     MENU;
END.
