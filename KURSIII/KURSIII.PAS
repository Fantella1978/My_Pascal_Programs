Program kursIII;
uses crt;

const
ar:array[1..18,0..11]of real=
((112.1,112.5,122.9,114.6,115.5,120.5,116.1,114.1,116.8,117.5,113.1,119.1),
 (118.1,113.0,122.7,112.9,115.8,123.6,116.7,121.8,116.2,120.9,122.7,112.7),
 (121.1,116.0,114.1,116.2,118.0,115.2,122.5,115.6,118.2,114.0,123.1,119.1),
 (115.7,121.8,124.4,118.3,123.3,122.5,112.4,113.9,113.9,118.4,112.4,120.4),
 (119.6,112.2,121.8,120.3,121.8,121.0,119.1,114.7,120.7,119.6,124.1,123.1),
 (120.2,124.7,115.2,120.6,115.8,113.2,121.8,118.3,123.2,118.5,119.3,119.8),
 (124.1,120.7,116.4,112.2,121.0,124.5,121.8,121.5,114.6,113.9,123.6,128.1),
 (122.0,119.5,123.0,120.8,115.7,113.3,120.0,115.6,123.1,114.1,115.5,112.8),
 (118.9,124.2,114.3,114.1,115.5,114.3,119.4,118.4,115.7,114.1,119.8,120.1),
 (121.4,121.5,113.1,113.3,122.9,113.4,122.1,122.2,116.9,119.8,117.6,115.1),
 (121.4,118.3,116.4,122.4,122.4,113.9,113.3,112.9,112.9,114.5,120.6,116.1),
 (115.0,119.3,115.3,116.7,122.6,116.1,116.1,120.4,120.8,123.5,116.1,113.2),
 (118.1,115.8,121.7,121.4,119.0,121.2,117.3,118.9,119.6,123.2,120.5,121.4),
 (113.5,118.0,117.2,113.5,112.8,119.0,120.6,113.1,123.7,122.7,120.7,112.8),
 (123.8,115.6,120.9,122.3,118.4,120.5,114.1,115.0,124.0,116.7,113.7,117.6),
 (124.5,116.0,112.8,113.4,123.0,119.1,120.9,113.4,120.5,112.3,116.0,121.1),
 (123.5,118.8,116.2,117.7,123.4,116.5,116.6,118.2,113.0,122.8,121.7,112.7),
 (114.4,123.7,118.3,113.7,123.3,117.2,114.7,122.3,119.5,113.5,119.9,121.8));
var x,y,i,j,n:integer;
    sum,w,dy,me:real;
    sy:array[0..20,1..2]of real;
    kx,m,d:array[0..11]of real;
    k:array[0..11,0..11]of real;
BEGIN
  clrscr;
  {Вычисление математического ожидания}
  for n:=0 to 11 do
   begin
    sum:=0;
    for i:=1 to 18 do sum:=sum+ar[i,n];
    m[n]:=sum/18;
   end;
   {Вывод на экран математического ожидания}
   writeln;
   write('t,c ');
   for n:=0 to 5 do
    begin
     write('   ',n*10,'   ');
    end;
   writeln;
   write('M(t)');
   for n:=0 to 5 do
    begin
     write(m[n]:8:3);
    end;
   writeln;
   write('t,c ');
   for n:=6 to 11 do
    begin
     write('   ',n*10,'   ');
    end;
   writeln;
   write('M(t)');
   for n:=6 to 11 do
    begin
     write(m[n]:8:3);
    end;
  {Вычисление дисперсии}
  for n:=0 to 11 do
   begin
    sum:=0;
    for i:=1 to 18 do sum:=sum+sqr(ar[i,n]-m[n]);
    d[n]:=sum/17;
   end;
   {Вывод на экран дисперсии}
   writeln;writeln;
   write('t,c ');
   for n:=0 to 5 do
    begin
     write('   ',n*10,'   ');
    end;
   writeln;
   write('D(t)');
   for n:=0 to 5 do
    begin
     write(d[n]:8:3);
    end;
   writeln;
   write('t,c ');
   for n:=6 to 11 do
    begin
     write('   ',n*10,'   ');
    end;
   writeln;
   write('D(t)');
   for n:=6 to 11 do
    begin
     write(d[n]:8:3);
    end;
  readkey; clrscr;
  {Вычисление матрицы корреляционной функции}
  for x:=0 to 11 do
   for y:=x to 11 do
    begin
     sum:=0;
     for i:=1 to 18 do sum:=sum+abs(ar[i,x]-m[x])*abs(ar[i,y]-m[y]);
     k[x,y]:=sum/17;
    end;
   {Вывод на экран матрици корреляционной функции}
   writeln;writeln;
   write('   K(t)    ');
   for n:=0 to 5 do
    begin
     write('   ',n*10,'   ');
    end;
   for x:=0 to 5 do
    begin
     writeln;
     write(x*10:4,'   ');
     for y:=0 to 5 do
      begin
       if k[x,y]<>0 then write(k[x,y]:8:3)
         else write('        ');
      end;
    end;
   writeln;writeln;
   write('   K(t)    ');
   for n:=6 to 11 do
    begin
     write('  ',n*10,'   ');
    end;
   for x:=0 to 11 do
    begin
     writeln;
     write(x*10:4,'   ');
     for y:=6 to 11 do
      begin
       if k[x,y]<>0 then write(k[x,y]:8:3)
         else write('        ');
      end;
    end;
  readln; clrscr;
   {Вычисляем значения корреляционной функции}
  for n:=0 to 11 do
   begin
    sum:=0;
    for x:=0 to 11-n do sum:=sum+k[x,x+n];
      kx[n]:=sum/(12-n);
   end;
   {Вывод на экран корреляционной функции}
   writeln;
   write('t,c ');
   for n:=0 to 5 do
    begin
     write('   ',n*10,'   ');
    end;
   writeln;
   write('Kx(t)');
   for n:=0 to 5 do
    begin
     write(kx[n]:8:3);
    end;
   writeln;
   write('t,c ');
   for n:=6 to 11 do
    begin
     write('   ',n*10,'   ');
    end;
   writeln;
   write('Kx(t)');
   for n:=6 to 11 do
    begin
     write(kx[n]:8:3);
    end;
  readkey; clrscr;
 {Вычисление спектpальной плотности на выходе системы}
  for n:=0 to 20 do
   begin
    w:=n*1e-3;sy[n,2]:=w;
    sy[n,1]:=(1.926e-3)/((36e-10+w*w)*(w*w*w*w-12*w*w+25*w+36));
    writeln(sy[n,2],'    ',sy[n,1]);
   end;
  readkey; clrscr;
 {Вычисление диспеpсии на выходе системы}
  w:=0; dy:=0;
  repeat
    dy:=dy+2*(1.926e-3)/((36e-10+w*w)*(w*w*w*w-12*w*w+25*w+36))*0.00001;
    w:=w+0.00001
  until w>0.01;
  writeln('Dy = ',dy:10:7);
  readkey; clrscr;
  writeln(' Эpгодическая функция ');
  {Вычисление математического ожидания эpгодической функции}
  sum:=0;
  for n:=0 to 11 do for i:=1 to 18 do sum:=sum+ar[i,n];
  me:=sum/(12*18);
  writeln('Mx = ',me:10:7);
   {Вычисляем значения корреляционной функции эpгодической функции}
  for n:=0 to 11 do
   begin
    dy:=0;
    for x:=0 to 11-n do
     begin
      sum:=0;
      for y:=1 to 18 do sum:=sum+abs(ar[y,x+n]-me)*abs(ar[y,x]-me);
      dy:=dy+sum/18;
     end;
      kx[n]:=dy/(12-n);
   end;
   {Вывод на экран корреляционной функции эpгодической функции}
   writeln;
   write('t,c ');
   for n:=0 to 5 do
    begin
     write('   ',n*10,'   ');
    end;
   writeln;
   write('Kx(t)');
   for n:=0 to 5 do
    begin
     write(kx[n]:8:3);
    end;
   writeln;
   write('t,c ');
   for n:=6 to 11 do
    begin
     write('   ',n*10,'   ');
    end;
   writeln;
   write('Kx(t)');
   for n:=6 to 11 do
    begin
     write(kx[n]:8:3);
    end;
 writeln;
 {Вычисление диспеpсии на выходе системы}
  w:=0; dy:=0;
  repeat
    dy:=dy+2*(1.884e-3)/((36e-10+w*w)*(w*w*w*w-12*w*w+25*w+36))*0.00001;
    w:=w+0.00001
  until w>0.01;
  writeln('Dy = ',dy:10:7);
  readkey; clrscr;

END.