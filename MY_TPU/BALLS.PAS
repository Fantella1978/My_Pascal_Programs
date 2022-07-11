unit BALLS;
interface
uses Graph,crt;
type pozition=object
       x,y:integer;
       procedure init(coordx,coordy:integer);
       function getx:integer;
       function gety:integer;
     end;
     ballptr=^ball;
     ball=object(pozition)
	 size,col1:word;
	 mix,miy,max,may,h,dx,rad,da:integer;
         alpha:real;
	 p1:pointer;
	 constructor init(color:word;radius,minx,miny,maxx,maxy:integer);
	 destructor done;virtual;
	 procedure show;virtual;
	 procedure blind;virtual;
	 procedure jump;virtual;
     end;
implementation
{************** pozition ********************}
procedure pozition.init(coordx,coordy:integer);
begin
  x:=coordx;
  y:=coordy;
end;
function pozition.getx:integer;
begin
  getx:=x;
end;
function pozition.gety:integer;
begin
  gety:=y;
end;
{**************** ball ******************}
constructor ball.init(color:word;radius,minx,miny,maxx,maxy:integer);
begin
  pozition.init(minx+radius,maxy-radius);
  randomize;
  dx:=6; da:=90;
  rad:=radius; mix:=minx+radius+1;
  miy:=miny+radius+1; max:=maxx-radius-1;
  may:=maxy-radius-1; alpha:=0;
  h:=may-miy; col1:=color;
  size:=imagesize(x-rad-1,y-rad-1,x+rad+1,y+rad+1);
  getmem(p1,size);
end;
destructor ball.done;
begin
  blind;
  freemem(p1,size);
end;
procedure ball.show;
begin
  getimage(x-rad-1,y-rad-1,x+rad+1,y+rad+1,p1^);
  setcolor(col1);
  ellipse(x,y,0,360,rad,rad);
end;
procedure ball.blind;
begin
  putimage(x-rad-1,y-rad-1,p1^,0);
end;
procedure ball.jump;
begin
  blind;
  x:=x+dx;
  alpha:=alpha+pi/da;
  if alpha>=pi then
   begin
    alpha:=0;
    da:=60+random(90);
    h:=round((may-miy)/4+(may-miy)*random*0.75);
   end;
  y:=may-round(h*sin(alpha));
  if y>=may then y:=may;
  if y<=miy then y:=miy;
  if (x>=max) then
   begin
    dx:=-round(6*random);
    x:=max;
   end;
  if (x<=mix) then
   begin
    dx:=round(6*random);
    x:=mix;
   end;
  show;
  delay(2);
end;

end.