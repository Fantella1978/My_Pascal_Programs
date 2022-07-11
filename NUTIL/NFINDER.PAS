Program find;
uses dos,crt,vadim;
var zan,cx,cy,soun,b,c,d,e,n,n1,s,sp,ndir,ds:integer;
    coldisk,len,k,nd:byte;
    dd:longint;
    way:string;
    r:registers;
    dirinfo:searchrec;
    rk,zup,named:char;
    mas:array[1..30] of integer;
    a:array[1..200] of string;
    file01:text;
    dis:array[3..31] of byte;
Procedure seefile(fname:string);
begin
 if (fname='LINES.EXE')or
    (fname='MYTH.EXE')or
    (fname='WAR.EXE')or
    (fname='XWING.EXE')or
    (fname='DESERT.EXE')or
    (fname='VETETRIS.EXE')or
    (fname='BTHORNE.EXE')or
    (fname='TETRIS.EXE')or
    (fname='SCORCH.EXE')or
    (fname='COM.EXE')or
    (fname='KE.EXE')or
    (fname='WOLF.EXE')or
    (fname='WOLF3D.EXE')or
    (fname='DUKE3D.EXE')or
    (fname='DOOM2.EXE')or
    (fname='MK2.EXE')or
    (fname='GREGA.EXE')or
    (fname='MK.EXE')or
    (fname='DUNE2.EXE')or
    (fname='DD.EXE')or
    (fname='NETWARS.EXE')or
    (fname='UGH.EXE')or
    (fname='BTET.EXE')or
    (FNAME='DOS4GW.EXE')OR
    (fname='ANI.EXE')or
    (fname='3DS.EXE')or
    (fname='XIXIT.EXE')or
    (fname='DESCENT.EXE')or
    (fname='WORMS.EXE')or
    (fname='MK3.EXE')or
    (fname='MK.EXE')or
    (fname='CD-MAN.EXE')or
    (fname='FORMULA1.EXE')or
    (fname='F1.EXE')or
    (fname='CANNON.EXE')or
    (fname='CF.EXE')or
    (fname='PINBALL.EXE')or
    (fname='HEXON.EXE')or
    (fname='C&C.EXE')or
    (fname='WAR2.EXE')or
    (fname='CIVIL.EXE')or
    (fname='CIV.EXE')or
    (fname='PREH2.EXE')or
    (fname='POOL.EXE')or
    (fname='PRINCE.EXE')or
    (fname='PRINCE2.EXE')or
    (fname='VIKINGS.EXE')or
    (fname='PACKMAN.EXE')or
    (fname='SHOCK.EXE')or
    (fname='ALIEN.EXE')or
    (fname='ALONE.EXE')or
    (fname='ARKANOID.EXE')or
    (fname='BARB.EXE')or
    (fname='CHESS.EXE')or
    (fname='BLUEX.EXE')or
    (fname='BOB.EXE')or
    (fname='BOX.EXE')or
    (fname='BUBBOB.DAT')or
    (fname='BUMPY.EXE')or
    (fname='SOS.EXE')or
    (fname='COMIC.EXE')or
    (fname='TANDY.COM')or
    (fname='START.EXE')or
    (fname='DR.EXE')or
    (fname='DD2.EXE')or
    (fname='DDMAIN.EXE')or
    (fname='DIE.EXE')or
    (fname='GAME.EXE')
  then
   begin
    for soun:=700 downto 500 do
     begin
      sound(soun);
      delay(1);
     end;
    for soun:=500 to 700 do
     begin
      sound(soun);
      delay(1);
     end;
    nosound;
    delay(50);
    window(5,17,75,22);
    gotoxy(cx,cy);
    textcolor(yellow);
    textbackground(cyan);
    if fname='DOS4GW.EXE'then writeln(way+'\'+fname+' - в этом каталоге возможна игра.')
    else writeln(way+'\'+fname+' - игра.');
    cx:=wherex;
    cy:=wherey;
    window(5,11,75,11);
    textbackground(lightgray);
    textcolor(black);
    if fname='DOS4GW.EXE'then a[s]:=way+'\'+fname+' - в этом каталоге возможна игра.'
    else a[s]:=way+'\'+fname+' - игра.';
    s:=s+1;
   end;
end;

begin
  for n:=3 to 31 do
   begin
    dd:=disksize(n);
    if dd<>-1
     then
      begin
       dis[n]:=1;
       inc(coldisk);
      end;
   end;
  clrscr;
  r.ah:=01;
  r.ch:=32;
  r.cl:=0;
  intr($10,r);
  s:=1;
  nd:=1;
  ndir:=0;
  textbackground(lightgray);
  textcolor(black);
  clrscr;
  winop(25,7,55,14,blue,red);
  k:=1;
  textcolor(yellow);
  writeln('Game Finder v 1.1 13.04.1997.');
  writeln('   Программа Попова Вадима');
  writeln;
  write('     Введите имя диска !');
  textbackground(lightgray);
  winop(40-coldisk-2,17,40+coldisk+2,21,blue,red);
  textcolor(white);
  writeln;
  write(' ');
  for n:=3 to 31 do
   begin
    if dis[n]=1 then write(' ',chr(ord('A')+n-1));
   end;
  n:=2;n1:=n;
  repeat
   gotoxy(n1,1);
   write('   ');
   gotoxy(n1,2);
   write(' ');
   gotoxy(n1+2,2);
   write(' ');
   gotoxy(n1,3);
   write('   ');
   gotoxy(n,1);
   write('┌─┐');
   gotoxy(n,2);
   write('│');
   gotoxy(n+2,2);
   write('│');
   gotoxy(n,3);
   write('└─┘');
   rk:=readkey;
   n1:=n;
   if rk=#77 then n:=n+2;
   if n>coldisk*2 then n:=2;
   if rk=#75 then n:=n-2;
   if n<1 then n:=coldisk*2;
  until rk=#13;
  window(1,1,80,25);
  textbackground(lightgray);
  c:=3;b:=0;
  repeat
   if dis[c]=1 then b:=b+1;
   c:=c+1;
  until b=n div 2;
  named:=chr(ord('C')+c-4);
  if ((named>='a') and (named<='z')) or ((named>='A') and (named<='Z'))
   then
    begin
     way:=named+':';
     clrscr;
     b:=3;c:=7;d:=77;e:=13;
     winop(b,c,d,e,blue,yellow);
     writeln;
     writeln('                    Произвожу поиск игр на диске :',upcase(named));
     delay(2000);
     b:=3;c:=16;d:=77;e:=23;
     winop(b,c,d,e,cyan,white);
     cx:=1;cy:=1;
     window(5,11,75,11);
     textbackground(lightgray);
     textcolor(black);
     repeat
       case k of
        1:findfirst(way+'\'+'*.*',anyfile,dirinfo);
        2:findnext(dirinfo);
       end;
       ds:=doserror;
       if ds=0
        then
         begin
          gotoxy(1,24);
          clreol;
          ndir:=ndir+1;
          if dirinfo.attr=$10
           then
            begin
             if(dirinfo.name<>'.') and (dirinfo.name<>'..')
              then
               begin
                mas[nd]:=ndir;
                nd:=nd+1;
                ndir:=0;
                k:=1;
                way:=way+'\'+dirinfo.name;
               end
              else k:=2;
             gotoxy(1,1);
             if dirinfo.name='.'then write(way+'\.');
             if dirinfo.name='..' then write(way+'\..');
             if (dirinfo.name<>'..')and(dirinfo.name<>'.')then write(way);
            end;
          if dirinfo.attr<>$10
           then
            begin
             k:=2;
             gotoxy(1,1);
             write(way+'\'+dirinfo.name);
             seefile(dirinfo.name);
            end;
         end
        else
         begin
          nd:=nd-1;
          if nd>=1
           then
            begin
             repeat
              len:=length(way);
              delete(way,len,1);
             until way[len-1]='\';
             delete(way,len-1,1);
             ndir:=mas[nd];
             findfirst(way+'\'+'*.*',anyfile,dirinfo);
             for n:=1 to ndir-1 do findnext(dirinfo);
             k:=2;
            end;
         end;
     until nd=0;
     window(1,1,80,14);
     clrscr;
     b:=25;c:=7;d:=55;e:=13;
     winop(b,c,d,e,cyan,yellow);
     textcolor(lightcyan);
     writeln;
     writeln('   Записать отчет в файл ?');
     writeln;
     textcolor(black);
     textbackground(cyan);
     write('                НЕТ');
     textcolor(white);
     gotoxy(12,4);
     write('ДА');
     zan:=1;
     repeat
      zup:=readkey;
      if zup=#75
       then
        begin
         zan:=1;
         textcolor(white);
         textbackground(cyan);
         gotoxy(12,4);
         write('ДА');
         textcolor(black);
         textbackground(cyan);
         gotoxy(17,4);
         write('НЕТ');
        end;
      if zup=#77
       then
        begin
         zan:=0;
         textcolor(white);
         textbackground(cyan);
         gotoxy(17,4);
         write('НЕТ');
         textcolor(black);
         textbackground(cyan);
         gotoxy(12,4);
         write('ДА');
        end;
      if zup=#27
       then
        begin
         zup:=#13;
         zan:=0;
        end;
     until zup=#13;
     if zan=1
      then
       begin
        textbackground(lightgray);
        window(1,1,80,14);
        clrscr;
        winop(25,7,55,11,lightblue,yellow);
        textcolor(white);
        writeln;
        write('Записываю информацию в файл !');
        delay(50);
        textbackground(lightgray);
        assign(file01,'NFINDER.INF');
        rewrite(file01);
        if s=1 then writeln(file01,'Игры не найдены на диске.')
         else
          begin
           writeln(file01,'                    Программа нашла следующие игры :');
           writeln(file01,'');
           for sp:=1 to s do writeln(file01,a[sp]);
           writeln(file01,'');
           writeln(file01,'Fantomas 13.04.1997.');
          end;
        delay(50);
        close(file01);
        window(1,1,80,14);
        clrscr;
        b:=25;c:=9;d:=55;e:=13;
        winop(b,c,d,e,blue,yellow);
        writeln;
        writeln(' Отчет в файле NFINDER.INF !');
        readkey;
       end;
    end
   else
    begin
     textbackground(lightgray);
     window(1,1,80,25);
     clrscr;
     b:=25;c:=9;d:=55;e:=13;
     winop(b,c,d,e,red,yellow);
     writeln;
     textcolor(lightcyan);
     writeln('     Неверное имя диска !');
     readkey;
    end;
  window(1,1,80,25);
  textbackground(black);
  textcolor(white);
  clrscr;
end.