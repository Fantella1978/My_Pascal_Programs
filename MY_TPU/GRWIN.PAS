unit grwin;
interface
uses Graph,crt;
type
    option=object
      visible:boolean;
      x,y,le:integer;
      size:word;
      str1:string;
      p1:pointer;
      constructor init(coordx,coordy:integer;strop:string);
      destructor done;
      procedure show;
      function mousein(mx,my:integer):boolean;
      procedure noactivate;
      procedure activate;
      procedure blind;
    end;
    windop=object
      x1,x2,y1,y2:integer;
      size1:word;
      p:pointer;
      constructor init(x_1,y_1,x_2,y_2:integer);
      destructor done;
      procedure show;
      procedure blind;
    end;
IMPLEMENTATION
{**************** option ******************}
constructor option.init(coordx,coordy:integer;strop:string);
begin
  visible:=false;
  str1:=strop;
  x:=coordx;y:=coordy;
  le:=length(str1);
  if x-le*4-7<0 then x:=le*4+7;
  if y-10<0 then y:=10;
  size:=imagesize(x-le*4-7,y-10,x+le*4+7,y+10);
  getmem(p1,size);
end;
destructor option.done;
begin
  blind;
  freemem(p1,size);
end;
function option.mousein(mx,my:integer):boolean;
begin
  if (mx>=x-le*4-4)and(mx<=x+le*4+4)and(my>=y-5)and(my<=y+5)
   then mousein:=true
   else mousein:=false;
end;
procedure option.show;
begin
  visible:=true;
  getimage(x-le*4-7,y-10,x+le*4+7,y+10,p1^);
  setviewport(x-le*4-7,y-10,x+le*4+7,y+10,false);
  clearviewport;
  setviewport(0,0,getmaxx,getmaxy,false);
  setcolor(darkgray);
  rectangle(x-le*4-7,y-10,x+le*4+7,y+10);
  rectangle(x-le*4-6,y-9,x+le*4+6,y+9);
  setfillstyle(1,lightgray);
  floodfill(x,y,darkgray);
  setcolor(white);
  line(x-le*4-7,y-10,x+le*4+7,y-10);
  line(x-le*4-7,y-10,x-le*4-7,y+10);
  line(x-le*4-6,y-9,x+le*4+6,y-9);
  line(x-le*4-6,y-9,x-le*4-6,y+9);
  outtextxy(x-le*4+1,y-3,str1);
end;
procedure option.noactivate;
begin
  setcolor(darkgray);
  line(x-le*4-7,y+10,x+le*4+7,y+10);
  line(x+le*4+7,y-10,x+le*4+7,y+10);
  line(x-le*4-6,y+9,x+le*4+6,y+9);
  line(x+le*4+6,y-9,x+le*4+6,y+9);
  setcolor(white);
  line(x-le*4-7,y-10,x+le*4+7,y-10);
  line(x-le*4-7,y-10,x-le*4-7,y+10);
  line(x-le*4-6,y-9,x+le*4+6,y-9);
  line(x-le*4-6,y-9,x-le*4-6,y+9);
  outtextxy(x-le*4+1,y-3,str1);
end;
procedure option.activate;
begin
  setcolor(white);
  line(x-le*4-7,y+10,x+le*4+7,y+10);
  line(x+le*4+7,y-10,x+le*4+7,y+10);
  line(x-le*4-6,y+9,x+le*4+6,y+9);
  line(x+le*4+6,y-9,x+le*4+6,y+9);
  setcolor(darkgray);
  line(x-le*4-7,y-10,x+le*4+7,y-10);
  line(x-le*4-7,y-10,x-le*4-7,y+10);
  line(x-le*4-6,y-9,x+le*4+6,y-9);
  line(x-le*4-6,y-9,x-le*4-6,y+9);
  outtextxy(x-le*4+1,y-3,str1);
  delay(200);
end;
procedure option.blind;
begin
  visible:=false;
  putimage(x-le*4-7,y-10,p1^,normalput);
end;
{**************** windop ********************}
constructor windop.init(x_1,y_1,x_2,y_2:integer);
begin
  x1:=x_1;x2:=x_2;y1:=y_1;y2:=y_2;
  size1:=imagesize(x1-1,y1-1,x2+1,y2+1);
  getmem(p,size1);
end;
destructor windop.done;
begin
  blind;
  freemem(p,size1);
end;
procedure windop.show;
begin
 getimage(x1-1,y1-1,x2+1,y2+1,p^);
 setviewport(x1,y1,x2,y2,false);
 clearviewport;
 setviewport(0,0,639,479,false);
 setcolor(darkgray);
 rectangle(x1,y1,x2,y2);
 rectangle(x1+1,y1+1,x2-1,y2-1);
 setfillstyle(1,lightgray);
 floodfill(x1+2,y1+2,darkgray);
 setcolor(white);
 line(x1,y1,x2,y1);
 line(x1+1,y1+1,x2-1,y1+1);
 line(x1,y1,x1,y2);
 line(x1+1,y1+1,x1+1,y2-1);
end;
procedure windop.blind;
begin
  putimage(x1-1,y1-1,p^,normalput);
end;

end.