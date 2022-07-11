{26Вариант}
USES CRT;
CONST SOG1:SET OF CHAR=['Й','Ц','К','Н','Г','Ш','Щ','З',
   'Х','Ъ','Ф','В','П','Р','Л','Д','Ж','Ч','С','М','Т',
   'Б','Ь','й','ц','к','н','г','ш','щ','з','х','ъ','ф',
   'в','п','р','л','д','ж','ч','с','м','т','ь','б'];
VAR P:CHAR;
  PROCEDURE MENU;
  begin clrscr;
     gotoxy(5,5);writeln('Формирование файла..1');
     gotoxy(5,15);writeln('Выход..3');
  end;
  PROCEDURE P1;
  var a,b,c,d,l,i,l1:integer;
      st1,st:string;
      f,n:text;
      t,k:boolean;
  begin
     assign(n,'readme.dat');reset(n);
     assign(f,'writeme.dat');reset(f);
     repeat
        t:=false;k:=true;b:=0;c:=0;
        readln(n,st);l:=length(st);
        for i:=1 to l do begin
             if ((st[i]>='А')and(st[i]<='п'))or((st[i]>='р')and(st[i]<='я'))
             then begin
                  if(st[i] in sog1)then b:=b+1
                  else c:=c+1; end;
             if(st[i] in[',','.','!','-',':',';','?'])then t:=true;
             if st<>' ' then k:=false;
          end; i:=1;l1:=1;
        repeat if st[i]='$' then
           begin delete(st,i,1);
              i:=i-1;l1:=l1-1;
              repeat i:=i+1;
              until not(st[i] in['0'..'9']);
              insert('DM',st,i);
              i:=i+1;l1:=l1+2;
           end;i:=i+1;
        until i>=l1;
        if t then st:='!'+st;
        if t then for i:=1 to l do st:=' ';
        str(l,st1);st:=st+st1;str(b,st1);
        st:=st+st1;writeln(f,st);
     until eof(n);close(n);close(f);
  end;
BEGIN MENU;
   REPEAT P:=READKEY;
      CASE P OF
         '1':P1;
         '2',#27:HALT;
      END; UNTIL FALSE;
END.

