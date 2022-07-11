Program lines;
uses graph,crt;
type coord=record
      x,y,x1,y1:integer;
     end;
const n=500;
var
   a:array[1..n] of coord;
   i,j,gd,gm,dx,dy,dx1,dy1:integer;
BEGIN
 initgraph(gd,gm,'');
 if graphresult=0
  then
   begin
    dx:=4;
    dy:=3;
    dx1:=3;
    dy1:=5;
    a[1].x:=320;
    a[1].x1:=200;
    a[1].y:=240;
    a[1].y1:=290;
    repeat
     for i:=n-1 downto 1 do a[i+1]:=a[i];
     a[1].x:=a[2].x+dx;
     a[1].y:=a[2].y+dy;
     a[1].x1:=a[2].x1+dx1;
     a[1].y1:=a[2].y1+dy1;
     if (a[1].x>639)or(a[1].x<1) then dx:=-dx;
     if (a[1].x1>639)or(a[1].x1<1) then dx1:=-dx1;
     if (a[1].y>479)or(a[1].y<1) then dy:=-dy;
     if (a[1].y1>479)or(a[1].y1<1) then dy1:=-dy1;
     setcolor(white);
     line(a[1].x,a[1].y,a[1].x1,a[1].y1);
     setcolor(black);
     line(a[n].x,a[n].y,a[n].x1,a[n].y1);
    until keypressed;
    closegraph;
   end
  else writeln('Error in Graphics !');
END.