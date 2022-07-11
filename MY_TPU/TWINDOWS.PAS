unit TWINDOWs;
interface
uses crt;
type
     MasScreen=array [1..4000] of byte;
     coordinate=object
       x1,y1,x2,y2,x,y:integer;
       procedure init(coordx1,coordy1,coordx2,coordy2:byte);
       function getx1:byte;
       function gety1:byte;
       function getx2:byte;
       function gety2:byte;
     end;
     twindowptr=^twindow;
     twindow=object(coordinate)
         mas:^MasScreen;
	 constructor init(coordx1,coordy1,coordx2,coordy2:byte);
	 destructor done;virtual;
	 procedure show;virtual;
     end;
var
 TScreen:MasScreen absolute $B800:$0000;
 i,j:integer;

implementation

{************** coordinate ********************}
procedure coordinate.init(coordx1,coordy1,coordx2,coordy2:byte);
begin
  x1:=coordx1;
  y1:=coordy1;
  x2:=coordx2;
  y2:=coordy2;
  x:=x2-x1;
  y:=y2-y1;
end;
function coordinate.getx1:byte;
begin
  getx1:=x1;
end;
function coordinate.gety1:byte;
begin
  gety1:=y1;
end;
function coordinate.getx2:byte;
begin
  getx2:=x2;
end;
function coordinate.gety2:byte;
begin
  gety2:=y2;
end;

{**************** ball ******************}
constructor twindow.init(coordx1,coordy1,coordx2,coordy2:byte);
begin
  coordinate.init(coordx1,coordy1,coordx2,coordy2);
  new(mas);
  for j:=0 to y-1 do
   for i:=1 to x*2 do mas^[i+j*x*2]:=TScreen[y1*160+x1*2+j*160+i];
end;

destructor twindow.done;
begin
 Dispose(mas);
end;

procedure twindow.show;
begin
  for j:=0 to y-1 do
   for i:=1 to x*2 do TScreen[y1*160+x1*2+j*160+i]:=mas^[i+j*x*2];
end;

end.