unit fly;

interface

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

Procedure ShowShark(x,y:integer;c:word);
Procedure ShowFree(x,y:integer;c:word);
Procedure ShowGun(x,y:integer;c:word);
Procedure ShowMisl(x,y:integer;c:word);
Procedure ShowTarget(x,y:integer;c:word);
Procedure ShowFire(x,y:integer;c:word);
Procedure ShowLife(life:byte);
Procedure ShowFuelDec(fuel:integer);
Procedure ShowScore(score:word);
Procedure ShowAllFuel;
Procedure ShowGameOver;
Procedure FuelAtention;
Procedure fon;
Procedure ShowLevel(level:byte);
Procedure LevelComplite(level:byte);
Procedure ShowTMisl(x,y:integer;c:word);
function EnterName:string;
Procedure ShowWeapon(a,b,c:integer);
Procedure ShowBomb(x,y:integer;c:word);
Procedure ShowBeginGame;
Procedure Pause;
Procedure ShowSuperBomb(x,y:integer;c:word);

implementation

uses
 crt,graph;

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

{***************************************************************}

Procedure Pause;
var w1:windop;
    rk:char;
begin
 w1.init(20,220,200,260);
 w1.show;
 setcolor(white);
 outtextxy(60,237,'P  A  U  S  E');
 repeat
  if keypressed
   then rk:=upcase(readkey)
   else rk:=#1;
 until rk=#13;
 w1.done;
end;

Procedure ShowBeginGame;
var w1:windop;
    rk:char;
begin
 w1.init(170,220,470,260);
 w1.show;
 setcolor(white);
 outtextxy(185,237,'P R E S S  <ENTER>  T O  S T A R T');
 repeat
  if keypressed
   then rk:=upcase(readkey)
   else rk:=#1;
 until rk=#13;
 w1.done;
end;

function EnterName:string;
var w1:windop;
    st:string[20];
    n,c:byte;
    si,rk:char;
    x,y:integer;
begin
 x:=232;
 y:=240;
 w1.init(220,200,420,280);
 w1.show;
 setcolor(black);
 outtextxy(252,215,'Enter your name :');
 setcolor(lightgray);
 for n:=1 to 161 do line (x+n,y,x+n,y+15);
 si:='-';
 st:='';
 repeat
  case si of
   '|':si:='/';
   '/':si:='-';
   '-':si:='\';
   '\':si:='|';
  end;
  setcolor(lightgray);
  for n:=1 to 8 do line (x+length(st)*8+n,y,x+length(st)*8+n,y+15);
  setcolor(black);
  outtextxy(x+1,y+4,st);
  outtextxy(x-7+(length(st)+1)*8,y+4,si);
  delay(60);
  if keypressed
   then rk:=upcase(readkey)
   else rk:=#1;
  if (rk in['A'..'Z',' ','_','0'..'9'])and(length(st)<20)
   then
    begin
     st:=st+rk;
     setcolor(lightgray);
     for n:=1 to 8 do line (x-8+length(st)*8+n,y,x-8+length(st)*8+n,y+15);
     setcolor(black);
     outtextxy(x-7+length(st)*8,y+4,rk);
    end;
  if (rk=#8)and(length(st)>0)
   then
    begin
     delete(st,length(st),1);
     setcolor(lightgray);
     for n:=1 to 17 do line (x+length(st)*8+n,y,x+length(st)*8+n,y+15);
    end;
 until (rk=#13)and(length(st)>0);
 EnterName:=st;
 w1.done;
end;

Procedure ShowSuperBomb(x,y:integer;c:word);
begin
 setcolor(c);
 rectangle(x-7,y-9,x+7,y+9);
 outtextxy(x-3,y-3,'B');
end;

Procedure ShowTMisl(x,y:integer;c:word);
begin
 setcolor(c);
 line(x-2,y-3,x+2,y-3);
 line(x-2,y-3,x-2,y+3);
 line(x+2,y-3,x+2,y+3);
 line(x-2,y+3,x,y+5);
 line(x+2,y+3,x,y+5);
end;

Procedure LevelComplite(level:byte);
var st:string[1];
    i:byte;
begin
 setcolor(cyan);
 str(level,st);
 outtextxy(601,450,st);
 setcolor(yellow);
 setRGBPalette(62,0,0,0);
 outtextxy(50,290,'C O M P L I T E');
 settextstyle(0,0,5);
 outtextxy(12,150,'LEVEL');
 outtextxy(90,220,st);
 for i:=0 to 20 do
  begin
   setRGBPalette(62,round(i/20*63),round(i/20*63),round(i/20*18));
   delay(50);
  end;
 readkey;
 for i:=20 downto 0 do
  begin
   setRGBPalette(62,round(i/20*63),round(i/20*63),round(i/20*18));
   delay(50);
  end;
 setcolor(black);
 outtextxy(12,150,'LEVEL');
 outtextxy(90,220,st);
 setRGBPalette(62,63,63,18);
 settextstyle(0,0,0);
 outtextxy(50,290,'C O M P L I T E');
end;

Procedure ShowLevel(level:byte);
var st:string[1];
    i:byte;
begin
 ShowFree(600,454,white);
 setcolor(cyan);
 str(level,st);
 outtextxy(601,450,st);
 settextstyle(0,0,5);
 setcolor(yellow);
 setRGBPalette(62,0,0,0);
 outtextxy(12,150,'LEVEL');
 outtextxy(90,220,st);
 for i:=0 to 20 do
  begin
   setRGBPalette(62,round(i/20*63),round(i/20*63),round(i/20*18));
   delay(50);
  end;
 readkey;
 for i:=20 downto 0 do
  begin
   setRGBPalette(62,round(i/20*63),round(i/20*63),round(i/20*18));
   delay(50);
  end;
 setcolor(black);
 outtextxy(12,150,'LEVEL');
 outtextxy(90,220,st);
 setRGBPalette(62,63,63,18);
 settextstyle(0,0,0);
end;

Procedure fon;
begin
 setcolor(white);
 rectangle(9,19,211,421);{внутренний бордюр}
 rectangle(8,18,212,422);
 rectangle(0,0,639,479); {внешний бордюр}
 rectangle(1,1,638,478);
 rectangle(98,442,202,466); {окно жизней 2}
 rectangle(99,443,201,465);
 rectangle(368,442,452,466); {окно очков 2}
 rectangle(369,443,451,465);
 rectangle(588,442,622,466); {окно уровня 2}
 rectangle(589,443,621,465);
 rectangle(278,28,622,166); {окно HISCORES 2}
 rectangle(279,29,621,165);
 rectangle(558,228,622,256); {окно Weapon 2.1}
 rectangle(559,229,621,255);
 rectangle(558,268,622,296); {окно Weapon 2.2}
 rectangle(559,269,621,295);
 rectangle(558,308,622,336); {окно Weapon 2.3}
 rectangle(559,309,621,335);
 rectangle(229,19,251,421); {окно топлива}
 rectangle(228,18,252,422);
 setfillstyle(1,lightGray);
 floodfill(3,3,white);
 rectangle(268,188,632,376); {окно Weapon }
 rectangle(269,189,631,375);
 rectangle(268,388,632,422); {окно ABOUT }
 rectangle(269,389,631,421);
 rectangle(268,18,632,176); {окно HISCORES 1}
 rectangle(269,19,631,175);
 rectangle(8,433,212,474); {окно жизней 1}
 rectangle(9,434,211,473);
 rectangle(268,433,462,474); {окно очков 1}
 rectangle(269,434,461,473);
 rectangle(478,433,632,474); {окно уровней 1}
 rectangle(479,434,631,473);
 setcolor(darkGray);
 line(1,479,639,479); {внешний бордюр}
 line(2,478,638,478);
 line(639,1,639,479);
 line(638,2,638,478);
 line(9,19,211,19);   {внутренний бордюр}
 line(8,18,212,18);
 line(8,18,8,422);
 line(9,19,9,421);
 line(9,473,211,473);   {окно жизней 1}
 line(8,474,212,474);
 line(211,473,211,434);
 line(212,473,212,433);
 line(269,473,461,473);   {окно очков 1}
 line(268,474,462,474);
 line(461,473,461,434);
 line(462,473,462,433);
 line(479,473,631,473);   {окно уровней 1}
 line(478,474,632,474);
 line(631,473,631,434);
 line(632,473,632,433);
 line(229,19,251,19);   {окно топлива}
 line(228,18,252,18);
 line(229,19,229,421);
 line(228,18,228,422);
 line(98,442,202,442);   {окно жизней 2}
 line(99,443,201,443);
 line(98,442,98,466);
 line(99,443,99,465);
 line(368,442,452,442);   {окно очков 2}
 line(369,443,451,443);
 line(368,442,368,466);
 line(369,443,369,465);
 line(588,442,622,442);   {окно уровней 2}
 line(589,443,621,443);
 line(588,442,588,466);
 line(589,443,589,465);
 line(268,176,632,176);   {окно HISCORES 1}
 line(269,175,631,175);
 line(632,18,632,176);
 line(631,19,631,175);
 line(278,28,622,28);   {окно HISCORES 2}
 line(279,29,621,29);
 line(278,28,278,166);
 line(279,29,279,165);
 line(268,422,632,422);   {окно About}
 line(269,421,631,421);
 line(632,422,632,388);
 line(631,421,631,389);
 line(268,376,632,376);   {окно Weapon}
 line(269,375,631,375);
 line(632,376,632,188);
 line(631,375,631,189);
 line(558,228,558,256);   {окно Weapon 1.1}
 line(559,229,559,255);
 line(558,228,622,228);
 line(559,229,621,229);
 line(558,268,558,296);   {окно Weapon 1.2}
 line(559,269,559,295);
 line(558,268,622,268);
 line(559,269,621,269);
 line(558,308,558,336);   {окно Weapon 1.3}
 line(559,309,559,335);
 line(558,308,622,308);
 line(559,309,621,309);
 setcolor(green);
 outtextxy(400,205,'W E A P O N :');
 outtextxy(310,355,'Press  <ENTER>  to  select  weapon.');
 outtextxy(277,401,'W R I T E N  by  V A D I M  P O P O V  1997.');
 setcolor(black);
 outtextxy(290,450,'SCORE :');
 outtextxy(510,450,'LEVEL :');
 outtextxy(237,430,'F');
 outtextxy(237,440,'U');
 outtextxy(237,450,'E');
 outtextxy(237,460,'L');
 Outtextxy(30,450,'LIFE :');
 setcolor(white);
 outtextxy(390,40,'H I S C O R E S');
end;

Procedure FuelAtention;
begin
 setcolor(LightMagenta);
 outtextxy(237,330,'A');
 outtextxy(237,340,'T');
 outtextxy(237,350,'T');
 outtextxy(237,360,'E');
 outtextxy(237,370,'N');
 outtextxy(237,380,'T');
 outtextxy(237,390,'I');
 outtextxy(237,400,'O');
 outtextxy(237,410,'N');
end;

Procedure ShowGameOver;
var i:byte;
begin
 settextstyle(0,0,5);
 setcolor(yellow);
 setRGBPalette(62,0,0,0);
 outtextxy(30,130,'Game');
 outtextxy(30,230,'Over');
 for i:=0 to 20 do
  begin
   setRGBPalette(62,round(i/20*63),round(i/20*63),round(i/20*18));
   delay(50);
  end;
 readkey;
 for i:=20 downto 0 do
  begin
   setRGBPalette(62,round(i/20*63),round(i/20*63),round(i/20*18));
   delay(50);
  end;
 setcolor(black);
 outtextxy(30,130,'Game');
 outtextxy(30,230,'Over');
 setRGBPalette(62,63,63,18);
 settextstyle(0,0,0);
end;

Procedure ShowAllFuel;
var i:integer;
begin
 setcolor(cyan);
 for i:=0 to 400 do line(230,i+20,250,i+20);
end;

Procedure ShowWeapon(a,b,c:integer);
var st:string[8];
begin
 setcolor(Cyan);
 str(a,st);
 setviewport(560,230,620,255,true);
 clearviewport;
 setviewport(0,0,639,479,true);
 outtextxy(570,240,st);
 str(b,st);
 setviewport(560,270,620,295,true);
 clearviewport;
 setviewport(0,0,639,479,true);
 outtextxy(570,280,st);
 str(c,st);
 setviewport(560,310,620,335,true);
 clearviewport;
 setviewport(0,0,639,479,true);
 outtextxy(570,320,st);
end;

Procedure ShowScore(score:word);
var st:string[8];
begin
 str(score,st);
 setviewport(370,444,450,464,true);
 clearviewport;
 setviewport(0,0,639,479,true);
 setcolor(Cyan);
 outtextxy(378,450,st);
end;

Procedure ShowFuelDec(fuel:integer);
var y:integer;
begin
 setcolor(black);
  y:=20+4*(1000-fuel)div 10;
 line(230,y,250,y);
end;

Procedure ShowLife(life:byte);
var i:byte;
begin
 for i:=1 to 5 do
  if i<=life
   then ShowShark(90+i*20,454,white)
   else ShowFree (90+i*20,454,white);
end;

Procedure ShowFire(x,y:integer;c:word);
var i:byte;
begin
 setcolor(c);
 for i:=1 to 20 do
  begin
   sound(200+random(400));
   putpixel(x-10+random(20),y-10+random(20),c);
   delay(2);
   nosound;
  end;
 delay(10);
end;

Procedure ShowTarget(x,y:integer;c:word);
begin
 setcolor(c);
 line(x-2,y-8,x+2,y-8);
 line(x-2,y-8,x-2,y+5);
 line(x+2,y-8,x+2,y+5);
 line(x-2,y+5,x,y+9);
 line(x+2,y+5,x,y+9);
 line(x-2,y-5,x-9,y-5);
 line(x+2,y-5,x+9,y-5);
 line(x-2,y-2,x-9,y-5);
 line(x+2,y-2,x+9,y-5);
 circle(x,y,1);
 line(x,y-6,x,y-9);
end;

Procedure ShowBomb(x,y:integer;c:word);
begin
 setcolor(c);
 line(x-10,y,x+10,y);
end;

Procedure ShowMisl(x,y:integer;c:word);
begin
 setcolor(c);
 line(x,y-2,x,y+2);
 line(x-1,y-1,x-1,y+2);
 line(x+1,y-1,x+1,y+2);
end;

Procedure ShowGun(x,y:integer;c:word);
begin
 setcolor(c);
 line(x,y-2,x,y+2);
end;

Procedure ShowFree(x,y:integer;c:word);
begin
 setcolor(c);
 setviewport(x-10,y-10,x+10,y+10,true);
 clearviewport;
 setviewport(0,0,639,479,true);
end;

Procedure ShowShark(x,y:integer;c:word);
begin
 setcolor(c);
 circle(x,y,1);
 line(x,y,x,y-8);
 line(x,y-10,x-3,y);
 line(x,y-10,x+3,y);
 line(x-8,y+4,x-3,y);
 line(x+8,y+4,x+3,y);
 line(x-8,y+4,x-3,y+4);
 line(x+8,y+4,x+3,y+4);
 line(x-2,y+2,x-2,y+7);
 line(x+2,y+2,x+2,y+7);
 line(x-2,y+5,x+2,y+5);
 line(x-6,y,x-6,y+2);
 line(x+6,y,x+6,y+2);
end;


end.