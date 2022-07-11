unit vision3d;
interface
uses Graph;
type pozition=object
       x,y:integer;
       procedure init(coordx,coordy:integer);
       function getx:integer;
       function gety:integer;
     end;
     v3dptr=^v3d;
     v3d=object(pozition)
       size,col1:word;
       m,i,h,l,l2,n,k1,k2:integer;
       dsr,ps,l1,k,alpha:real;
       p1:pointer;
       constructor init(xp,yp,hi,le:integer;color:word);
       destructor done;virtual;
       procedure show;virtual;
       procedure blind;virtual;
       procedure jump;virtual;
     end;
     b3dptr=^b3d;
     b3d=object(pozition)
       size,col1:word;
       radius,l2,h2,n,i,kx1,kx2,dr1,dr2,dr:integer;
       p1:pointer;
       constructor init(xp,yp,hi,le:integer;color:word);
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
{**************** b3d ******************}
constructor b3d.init(xp,yp,hi,le:integer;color:word);
begin
  pozition.init(xp,yp);
  n:=50;
  col1:=color;
  x:=xp;
  y:=yp;
  i:=1;
  l2:=le div 2;
  h2:=hi div 2;
  radius:=0;
  dr:=h2 div 4;
  size:=imagesize(x-l2-1,y-h2-1-dr,x+l2+1,y+h2+1+dr);
  getmem(p1,size);
end;
destructor b3d.done;
begin
  blind;
  freemem(p1,size);
end;
procedure b3d.show;
begin
  getimage(x-l2-1,y-h2-1-dr,x+l2+1,y+h2+1+dr,p1^);
  setcolor(col1);
  kx1:=x-round(l2*sin(pi*i/n));
  kx2:=x+round(l2*sin(pi*i/n));
  radius:=round(h2*(1-cos(pi*i/n-pi/2)));
  dr1:=round(radius/4*sin(pi/2*i/n));
  dr2:=round(radius/4*(1-sin(pi/2*i/n)));
  line(kx1,y+h2+dr2,kx2,y+h2+dr1);
  line(kx1,y-h2-dr2,kx2,y-h2-dr1);
  ellipse(kx1,y,0,360,radius+dr2,h2+dr2);
  ellipse(kx2,y,0,360,radius+dr1,h2+dr1);
  {line(x,y,k2,m);line(k1,m,k2,m);line(x,y,round(x+l1-i*dsr),m);
  line(x,y+2*h,k1,m);line(x,y+2*h,k2,m);line(x,y+2*h,round(x+l1-i*dsr),m);
  setlinestyle(3,1,1);
  line(x,y,round(x-l1+i*dsr),m);
  line(x,y+2*h,round(x-l1+i*dsr),m);setlinestyle(0,0,0);
}end;
procedure b3d.blind;
begin
  putimage(x-l2-1,y-h2-1-dr,p1^,0);
end;
procedure b3d.jump;
begin
  blind;
  inc(i);
  if i>n then i:=1;
  show;
end;

{**************** v3d ******************}
constructor v3d.init(xp,yp,hi,le:integer;color:word);
begin
  pozition.init(xp,yp);
  n:=30;
  col1:=color;h:=hi;x:=xp;y:=yp;i:=1;l:=le;
  dsr:=l/n;ps:=l/2*(sqrt(2)-1);l1:=l/2;
  m:=y+h;
  l2:=l div 2+round(ps);
  size:=imagesize(x-l2-1,y-1,x+l2+1,y+h*2+1);
  getmem(p1,size);
end;
destructor v3d.done;
begin
  blind;
  freemem(p1,size);
end;
procedure v3d.show;
begin
  getimage(x-l2-1,y-1,x+l2+1,y+h*2+1,p1^);
  setcolor(col1);
  k:=ps*sin(i*pi/n);k1:=round(x-l1-k);k2:=round(x+l1+k);
  line(x,y,k1,m);
  line(x,y,k2,m);line(k1,m,k2,m);line(x,y,round(x+l1-i*dsr),m);
  line(x,y+2*h,k1,m);line(x,y+2*h,k2,m);line(x,y+2*h,round(x+l1-i*dsr),m);
  setlinestyle(3,1,1);
  line(x,y,round(x-l1+i*dsr),m);
  line(x,y+2*h,round(x-l1+i*dsr),m);setlinestyle(0,0,0);
end;
procedure v3d.blind;
begin
  putimage(x-l2-1,y-1,p1^,0);
end;
procedure v3d.jump;
begin
  blind;
  inc(i);
  if i>n then i:=1;
  show;
end;

end.