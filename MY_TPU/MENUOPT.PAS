unit menuopt;
interface
uses Graph,crt,dos;
type pozition=object
       x,y:integer;
       procedure init(coordx,coordy:integer);
       function getx:integer;
       function gety:integer;
     end;
	  optionptr=^option;
	  option=object(pozition)
		 visible:boolean;
		 le:integer;
		 size:word;
		 str1:string;
		 p1:pointer;
		 constructor init(coordx,coordy:integer;strop:string);
		 destructor done;virtual;
		 procedure show;virtual;
		 function mousein(mx,my:integer):boolean;virtual;
		 procedure blind;virtual;
                 procedure kursorin;
                 procedure kursorout;
	  end;
	  windopptr=^windop;
	  windop=object
                 x1,x2,y1,y2:integer;
		 size1:word;
		 p:pointer;
		 constructor init(x_1,y_1,x_2,y_2:integer);
		 destructor done;virtual;
		 procedure show;virtual;
		 procedure blind;virtual;
	  end;
implementation
{***************************** pozition *************************************}
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
{******************* option ************************************************}
constructor option.init(coordx,coordy:integer;strop:string);
begin
  pozition.init(coordx,coordy);
  visible:=false;
  str1:=strop;
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
  setcolor(8);
  rectangle(x-le*4-7,y-10,x+le*4+7,y+10);
  setfillstyle(1,lightgray);
  floodfill(x,y,8);
  setcolor(8);
  line(x-le*4-7,y-10,x-le*4-1,y-5);
  line(x-le*4-7,y+10,x-le*4-1,y+5);
  line(x+le*4+7,y-10,x+le*4+1,y-5);
  line(x+le*4+7,y+10,x+le*4+1,y+5);
  rectangle(x-le*4-1,y-5,x+le*4+1,y+5);
  setfillstyle(1,darkgray);
  floodfill(x+le*4+5,y,8);
  floodfill(x,y+6,8);
  setcolor(white);
  outtextxy(x-le*4+1,y-3,str1);
end;
procedure option.blind;
begin
  visible:=false;
  putimage(x-le*4-7,y-10,p1^,normalput);
end;
Procedure option.kursorin;
begin
  setcolor(white);
  rectangle(x-le*4-7,y-10,x+le*4+7,y+10);
end;
Procedure option.kursorout;
begin
  setcolor(darkgray);
  rectangle(x-le*4-7,y-10,x+le*4+7,y+10);
end;

{****************** windop ************************}
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
 setfillstyle(1,lightgray);
 floodfill(x1+2,y1+2,darkgray);
 rectangle(x1+5,y1+5,x2-5,y2-5);
 line(x1,y1,x1+5,y1+5);
 line(x1,y2,x1+5,y2-5);
 line(x2,y1,x2-5,y1+5);
 setfillstyle(1,darkgray);
 floodfill(x2-2,y2-2,darkgray);
end;
procedure windop.blind;
begin
  putimage(x1-1,y1-1,p^,normalput);
end;

end.