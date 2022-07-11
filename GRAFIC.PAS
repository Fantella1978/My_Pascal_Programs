Program gr2;
 uses
   graph,crt;
 var
    grDriver,grMode,errCode:integer;
    i,j:integer;
    kx,ky,a,b,dy,dx,y,x,miny,maxy,minx,maxx:real;
    st:string[9];
Function f(t:real):real;
begin
 f:=(SQRT(SIN(T)*SIN(T)+T*T+4)-T*T+4*T+5)/(COS(T)*COS(T)*COS(T)+SQRT(ABS(T)));
end;
 begin
  clrscr;
  writeln('Введите начало промежутка : ');
  readln(a);
  writeln('Введите конец промежутка : ');
  readln(b);
  grDriver:=detect;
  InitGraph(grDriver,grMode,'c:\bp\bgi');
  errCode:=GraphResult;
  if errCode=0
   then
    begin
{********************************************************}
     setcolor(yellow);
     setlinestyle(0,1,THickWidth);
     linerel(639,0);
     linerel(0,479);
     linerel(-639,0);
     linerel(0,-479);
     setcolor(green);
     line(30,30,639-30,30);
     line(639-30,30,639-30,479-10);
     line(639-30,479-10,30,479-10);
     line(30,479-10,30,30);
     setcolor(lightmagenta);
     outtextxy(5,15,' F:=(SQRT(SIN(T)*SIN(T)+T*T+4)-T*T+4*T+5)/(COS(T)*COS(T)*COS(T)+SQRT(ABS(T)))');
     setcolor(white);
     outtextxy(100,44,'Y');
     outtextxy(639-68,getmaxy-66,'X');
     setcolor(white);
     line(120,getmaxy-50,getmaxx-50,getmaxy-50);
     line(120,40,120,getmaxy-50);
     line(getmaxx-50,getmaxy-50,getmaxx-70,getmaxy-45);
     line(getmaxx-70,getmaxy-45,getmaxx-65,getmaxy-50);
     line(getmaxx-65,getmaxy-50,getmaxx-70,getmaxy-55);
     line(getmaxx-70,getmaxy-55,getmaxx-50,getmaxy-50);
     line(120,40,115,60);
     line(115,60,120,55);
     line(120,55,125,60);
     line(125,60,120,40);
     setlinestyle(1,1,NORMWidth);
     setcolor(lightgray);
     FOR I:=0 TO 9 DO line(120,getmaxy-50-i*40,getmaxx-50,getmaxy-50-i*40);
     for i:=0 to 5 do line(120+i*88,40,120+i*88,getmaxy-50);
     setcolor(magenta);
     outtextxy(85,440,'    ^          ^          ^          ^          ^          ^');
     setlinestyle(0,1,NORMWidth);

{****************************************************************************}
     x:=a;
     minx:=a;
     maxx:=b;
     dx:=abs(b-a)/1000;
     miny:=f(a);
     maxy:=f(a);
     repeat
      x:=x+dx;
      if f(x)>maxy then maxy:=f(x);
      if f(x)<miny then miny:=f(x);
     until x>b;
     dy:=abs(maxy-miny)/1000;
     for i:=1 to 10 do
      begin
       str(miny+dy*(i-1)/9*1000:6:4,st);
       outtextxy(50,getmaxy-15-40*i,st);
      end;
     for i:=0 to 5 do
      begin
       str(a+dx*i*1000/5:6:3,st);
       outtextxy(85+i*88,getmaxy-25,st);
      end;
{***************************************************************************}
     kx:=(getmaxx-200)/(1000*dx);
     ky:=(getmaxy-120)/(1000*dy);
     setcolor(lightred);
     for i:=0 to 1000 do
      begin
       x:=a+dx*i;
       y:=f(x);
       line(round(120+kx*dx*i),round(430-ky*(y-miny)),round(120+kx*dx*(i+1)),round(430-ky*(f(x+dx)-miny)));
      end;
     repeat until readkey=#27;
{***************************************************************************}
     CloseGraph;
     writeln(miny:10:5,'    ',maxy:10:5);
    end
  else Writeln('ERROR GRAPH :',grapherrormsg(errcode));
 end.
