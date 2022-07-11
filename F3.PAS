Program graphik;
 uses
   graph,crt;
 const
    a=0;
    amax=4.61;
    a1=4.61;
    a2=0.52;
    a3=0.148;
    wmin=502;
    w1=502;
    w2=1506;
    w3=2506;
    f1=12;
    f2=4;
    f3=183;
    col=3;
 var
    grDriver,grMode,errCode:integer;
    i,j:integer;
    b,kx,ky,dx:real;
    st:string[9];
    ar:array[1..5,1..1000]of real;

Function f(n:byte;t:real):real;
begin
  case n of
   1:f:=a1*sin(w1*t+f1*pi/180);
   2:f:=a2*sin(w2*t+f2*pi/180);
   3:f:=a3*sin(w3*t+f3*pi/180);
  end;
end;

 BEGIN
  b:=2*pi/wmin;
  grDriver:=detect;
  InitGraph(grDriver,grMode,'d:\tp-7\bgi');
  errCode:=GraphResult;
  if errCode=0
   then
    begin
{********************************************************}
     setcolor(white);
     outtextxy(80,44,'i(t)');
     outtextxy(639-68,224,'t');
     outtextxy(105,236,'0');
     line(120,240,getmaxx-50,240);
     line(120,40,120,getmaxy-50);
     line(getmaxx-50,240,getmaxx-70,245);
     line(getmaxx-70,245,getmaxx-65,240);
     line(getmaxx-65,240,getmaxx-70,235);
     line(getmaxx-70,235,getmaxx-50,240);
     line(120,40,115,60);
     line(115,60,120,55);
     line(120,55,125,60);
     line(125,60,120,40);
     setlinestyle(0,1,NORMWidth);
     kx:=100/(b-a)*4;
     ky:=100/amax;
     for i:=1 to 4 do line (round(120+i*kx*(b-a)/4),235,round(120+i*kx*(b-a)/4),245);
     line(117,round(240-a1*ky),123,round(240-a1*ky));
     line(117,round(240+a1*ky),123,round(240+a1*ky));
     line(117,round(240-a2*ky),123,round(240-a2*ky));
     line(117,round(240+a2*ky),123,round(240+a2*ky));
     line(117,round(240-a3*ky),123,round(240-a3*ky));
     line(117,round(240+a3*ky),123,round(240+a3*ky));
     setcolor(cyan);
     setlinestyle(2,0,0);
     line(127,round(240-a1*ky),523,round(240-a1*ky));
     line(127,round(240+a1*ky),523,round(240+a1*ky));
     line(127,round(240-a2*ky),523,round(240-a2*ky));
     line(127,round(240+a2*ky),523,round(240+a2*ky));
     line(127,round(240-a3*ky),523,round(240-a3*ky));
     line(127,round(240+a3*ky),523,round(240+a3*ky));
{***************************************************************************}
     setlinestyle(0,0,0);
     setcolor(cyan);
     dx:=(b-a)/1000;
     for i:=1 to col do
      for j:=1 to 1000 do ar[i,j]:=f(i,a+dx*j);
     for i:=1 to col do
      for j:=2 to 1000 do
       begin
        delay(1);
        line(round(120+kx*dx*j),
             round(240-ar[i,j-1]*ky),
             round(120+kx*dx*(j+1)),
             round(240-ar[i,j]*ky));
       end;
     setlinestyle(0,0,3);
     setcolor(white);
     for j:=2 to 1000 do
      for i:=1 to col do
       begin
        delay(1);
        line(round(120+kx*dx*j),
             round(240-(ar[1,j-1]+ar[2,j-1]+ar[3,j-1])*ky),
             round(120+kx*dx*(j+1)),
             round(240-(ar[1,j]+ar[2,j]+ar[3,j])*ky));
        end;
     repeat until readkey=#27;
{***************************************************************************}
     CloseGraph;
    end
  else Writeln('ERROR GRAPH :',grapherrormsg(errcode));
 end.
