Program Nraph;
 uses
   graph,crt,vadim;
 var
    grDriver,grMode,errCode,y:integer;
    k,n,y1,x1,x2,y2,a,b,c,d:integer;
    x:real;
    rk:char;
    gra:array[1..6] of string[30];
 const
    maxx=2*pi;
    minx=0;
 function fy(t:real):real;
  begin
   case k of
    1:fy:=sin(t);
    2:fy:=cos(t);
    3:fy:=5*cos(t);
    4:fy:=1-cos(t);
    5:fy:=sin(t)*sin(t)*sin(t);
    6:fy:=t*cos(t);
   end;
  end;
 function fx(t:real):real;
  begin
   case k of
    1:fx:=t;
    2:fx:=t;
    3:fx:=5*sin(t);
    4:fx:=t-sin(t);
    5:fx:=cos(t)*cos(t)*cos(t);
    6:fx:=t*sin(t);
   end;
  end;
begin
 k:=1;
 repeat
  clrscr;
  gra[1]:='         Синусоида.          ';
  gra[2]:='        Косинусоида.         ';
  gra[3]:='    Окружность радиуса 5.    ';
  gra[4]:='         Циклоида.           ';
  gra[5]:='         Астроида.           ';
  gra[6]:='     Архимедова спираль.     ';
  repeat
   a:=1;b:=1;c:=31;d:=12;
   winop(a,b,c,d,blue,yellow);
   textbackground(blue);
   textcolor(green);
   writeln('Демонстрационная  графическаяпрограмма Попова В.С. 1996 г.');
   textcolor(red);
   for n:=1 to 6 do
    begin
     gotoxy(1,3+n);
     write(gra[n]);
    end;
   gotoxy(1,k+3);
   textcolor(white);
   textbackground(black);
   write(gra[k]);
   gotoxy(1,k+3);
   delay(40);
   rk:=readkey;
   if rk=#27
    then
     begin
      window(1,1,80,25);
      textbackground(black);
      textcolor(white);
      clrscr;
      exit;
     end;
   if rk=#80 then if k<6 then k:=k+1
                         else k:=1;
   if rk=#72 then if k>1 then k:=k-1
                         else k:=6;
  until rk=#13;
  grDriver:=detect;
  InitGraph(grDriver,grMode,'c:\tp7\bgi');
  errCode:=GraphResult;
  if errCode=0
   then
    begin
{******************* ИЗМЕНЯЕМАЯ ОБЛАСТЬ *************************************}
     setcolor(white);
     line(0,0,getmaxx,0);
     line(getmaxx,0,getmaxx,getmaxy);
     line(getmaxx,getmaxy,0,getmaxy);
     line(0,getmaxy,0,0);
     line(5,getmaxy div 2,getmaxx-5,getmaxy div 2);
     line(getmaxx div 2,5,getmaxx div 2,getmaxy-25);
     setcolor(green);
     outtextxy(20,244,'-9  -8  -7  -6  -5  -4  -3  -2  -1  0');
     outtextxy(getmaxx div 2+30,244,'1   2   3   4   5   6   7   8   9');
     for n:=1 to 9 do
      begin
       setcolor(green);
       outtextxy(getmaxx div 2-20,getmaxy div 2-3+27*n,'-'+chr(48+n));
       outtextxy(getmaxx div 2-11,-33+27*n,chr(58-n));
       setcolor(white);
       outtextxy(20,20,'[0;2*pi]');
       line(getmaxx div 2-n*32,getmaxy div 2-3,getmaxx div 2-n*32,getmaxy div 2+3);
       line(getmaxx div 2-3,getmaxy div 2-n*27,getmaxx div 2+3,getmaxy div 2-n*27);
       line(getmaxx div 2-3,getmaxy div 2+n*27,getmaxx div 2+3,getmaxy div 2+n*27);
       line(getmaxx div 2+n*32,getmaxy div 2-3,getmaxx div 2+n*32,getmaxy div 2+3);
      end;
     line(getmaxx div 2,5,getmaxx div 2+4,20);
     line(getmaxx div 2,15,getmaxx div 2-4,20);
     line(getmaxx div 2,15,getmaxx div 2+4,20);
     line(getmaxx div 2,5,getmaxx div 2-4,20);
     line(getmaxx -5,getmaxy div 2,getmaxx -20,getmaxy div 2+4);
     line(getmaxx -15,getmaxy div 2,getmaxx -20,getmaxy div 2+4);
     line(getmaxx -5,getmaxy div 2,getmaxx -20,getmaxy div 2-4);
     line(getmaxx -15,getmaxy div 2,getmaxx -20,getmaxy div 2-4);
     outtextxy(getmaxx div 2-20,10,'Y');
     outtextxy(getmaxx-15,getmaxy div 2-15,'X');
{****************************************************************************}
     x:=minx;
     y2:=getmaxy div 2-round(fy(x)*27);
     x2:=getmaxx div 2+round(fx(x)*32);
     setcolor(lightmagenta);
     while x<maxx-pi/30 do
      begin
       y1:=getmaxy div 2-round(fy(x)*27);
       x1:=getmaxx div 2+round(fx(x)*32);
       x:=x+pi/30;
       y2:=getmaxy div 2-round(fy(x)*27);
       x2:=getmaxx div 2+round(fx(x)*32);
       line(x1,y1,x2,y2);
      end;
     repeat until readkey<>'';
{****************************************************************************}
     CloseGraph;
    end
  else Writeln('ERROR GRAPH :',grapherrormsg(errcode));
 until rk=#27;
 window(1,1,80,25);
 textbackground(black);
 textcolor(white);
 clrscr;
end.






