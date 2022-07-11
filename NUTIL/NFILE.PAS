Program nfile;
 uses
  dos,crt;
 var
  dirinfo:Searchrec;
  nn,nf,a,b,c,d:integer;
  ns:longint;
procedure sce(var nn:integer);
 begin
   writeln;
   writeln('       PRESS ANY KEY');
   repeat until readkey<>'';
   nn:=1;
   writeln;
 end;
Procedure winop(var x,y,x1,y1:integer;cl:byte);
var
   nk:integer;
begin
   window(x,y,x1,y1);
   textbackground(cl);
   textcolor(lightred);
   clrscr;
   write('╔');
   for nk:=0 to (x1-x-2) do write('═');
   write('╗');
   for nk:=1 to (y1-y-1) do
    begin
     gotoxy(1,1+nk);
     write('║');
     gotoxy(x1-x+1,1+nk);
     write('║');
    end;
    gotoxy(1,y1-y+1);
    write('╚');
    for nk:=0 to (x1-x-2) do write('═');
    window(x,y,x1+1,y1+1);
    gotoxy(x1-x+1,y1-y+1);
    write('╝');
    window(x,y,x1+2,y1+2);
    textbackground(black);
    textcolor(8);
    gotoxy(2,y1-y+2);
    for nk:=0 to (x1-x) do write('░');
    for nk:=0 to (y1-y) do
    begin
     gotoxy(x1-x+2,2+nk);
     write('░');
    end;
    textbackground(blue);
end;
 begin
  clrscr;
  gotoxy(1,1);
  writeln ('Программа Попова В.С. 1996 Год.');
  a:=1;
  b:=3;
  c:=29;
  d:=23;
  winop(a,b,c,d,blue);
  window(2,4,28,22);
  textcolor(yellow);
  gotoxy(1,1);
  findfirst('*.*',anyfile,dirinfo);
  if doserror=0
  then
   begin
    nf:=0;
    if dirinfo.size<>0 then nf:=1;
    nn:=1;
    ns:=dirinfo.size;
    write(dirinfo.name:13);
    if dirinfo.size=0 then writeln('     <DIR>')
                      else writeln(dirinfo.size:8,' байт');
    repeat
     findnext(dirinfo);
     delay(20);
     if doserror=0
     then
      begin
       if dirinfo.size<>0 then inc(nf);
       nn:=nn+1;
       delay(40);
       if nn=16 then sce(nn);
       ns:=ns+dirinfo.size;
       write(dirinfo.name:13);
       if dirinfo.size=0 then writeln('     <DIR>')
                         else writeln(dirinfo.size:8,' байт');
       end
      else writeln;
     until doserror<>0;
     if nn>13 then sce(nn);
     writeln;
     writeln('ВСЕГО :',NF,' Файлов');
     writeln('Обьем файлов :',ns,' байт');
     sce(nn);
     delay(200);
     window(1,1,80,24);
     textbackground(black);
     clrscr;
     end
    else writeln ('Нет файлов.');
 end.
