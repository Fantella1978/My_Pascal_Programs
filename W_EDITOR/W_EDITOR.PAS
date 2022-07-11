Program war1941;
uses Graph,crt,dos,grwin,gmouse;
const
   col:array[0..15]of string[8]=
   ('Black','Blue','Green','Cyan',
    'Red','Magenta','Brown','LGray',
    'DGray','LBlue','LGreen','LCyan',
    'LRed','LMagenta','Yellow','White');
var
   i,j,gmode,gdriver,mx,my:integer;
   lb,rb,firstpic:boolean;
   color:word;
   pic,pic1:array[1..40,1..40]of byte;
   dirinfo:searchrec;

Procedure fon;
 begin
  setcolor(white);
  rectangle(0,0,639,479);
  setfillstyle(1,lightgray);
  floodfill(320,240,white);
 end;

function quit:boolean;
 var w1:windop;
     o1,o2:option;
     ex:boolean;
 begin
  hidemouse;
  w1.init(220,200,420,280);
  w1.show;
  o1.init(285,260,' Ok ');
  o1.show;
  o2.init(355,260,' No ');
  o2.show;
  setcolor(black);
  outtextxy(270,220,'Quit to DOS ?');
  showmouse;
  repeat
   getmousestatus(mx,my,lb,rb);
   if o1.mousein(mx,my)and lb then ex:=true;
   if o2.mousein(mx,my)and lb then ex:=false;
  until (o1.mousein(mx,my)and lb)or(o2.mousein(mx,my)and lb);
  hidemouse;
  o1.done;
  o2.done;
  w1.done;
  showmouse;
  quit:=ex;
 end;

Procedure showcolor;
begin
 hidemouse;
 setlinestyle(2,1,1);
 setcolor(black);
 if color<8
  then rectangle(10,10+color*30,40,40+color*30)
  else rectangle(40,10+(color-8)*30,70,40+(color-8)*30);
 setlinestyle(0,0,0);
 setcolor(lightgray);
 for i:=1 to 64 do line(9+i,251,9+i,274);
 setcolor(black);
 outtextxy(10+round(4*(8-length(col[color]))),260,col[color]);
 showmouse;
 delay(50);
end;

Procedure changecolor;
begin
 if (mx>10)and(mx<70)and(my>10)and(my<250)and lb
  then
   begin
    hidemouse;
    setcolor(white);
    if color<8
     then rectangle(10,10+color*30,40,40+color*30)
     else rectangle(40,10+(color-8)*30,70,40+(color-8)*30);
    if mx<40
     then color:=(my-10) div 30
     else color:=8+(my-10) div 30;
    showcolor;
    showmouse;
   end;
end;

Procedure showlitpic;
begin
 for i:=1 to 40 do
  for j:=1 to 40 do
   putpixel(20+i,290+j,pic[i,j]);
end;

Procedure getpic;
begin
 if (mx>90)and(mx<490)and(my>10)and(my<410)and lb
  then
   begin
    hidemouse;
    pic[1+(mx-90) div 10,1+(my-10) div 10]:=color;
    setcolor(color);
    for i:=1 to 9 do
     line((mx div 10)*10+i,(my div 10)*10+1,
          (mx div 10)*10+i,(my div 10)*10+9);
    showlitpic;
    showmouse;
    delay(20);
   end;
end;

Procedure landview;
begin
 setviewport(90,10,490,410,false);
 clearviewport;
 setviewport(0,0,639,479,false);
 setcolor(darkgray);
 line(496,4,496,416);
 line(495,5,495,415);
 line(84,416,496,416);
 line(85,415,495,415);
 setcolor(white);
 line(84,4,496,4);
 line(85,5,495,5);
 line(84,4,84,416);
 line(85,5,85,415);
 rectangle(90,10,490,410);
 setfillstyle(1,black);
 floodfill(91,11,white);
 for i:=1 to 41 do
  begin
    line(90,10+(i-1)*10,490,10+(i-1)*10);
    line(90+(i-1)*10,10,90+(i-1)*10,410);
   end;
end;

Procedure clear;
 var w1:windop;
     o1,o2:option;
     ex:boolean;
 begin
  w1.init(220,200,420,280);
  w1.show;
  o1.init(285,260,' Ok ');
  o1.show;
  o2.init(355,260,' No ');
  o2.show;
  setcolor(black);
  outtextxy(261,220,'Clear picture ?');
  showmouse;
  repeat
   getmousestatus(mx,my,lb,rb);
   if o1.mousein(mx,my)and lb then ex:=true;
   if o2.mousein(mx,my)and lb then ex:=false;
  until (o1.mousein(mx,my)and lb)or(o2.mousein(mx,my)and lb);
  hidemouse;
  o1.done;
  o2.done;
  w1.done;
  if ex=true
   then
    begin
     for i:=1 to 40 do
      for j:=1 to 40 do
       pic[i,j]:=0;
     landview;
     showlitpic;
    end;
 end;

Procedure showbigpic;
var k:byte;
begin
 for i:=1 to 40 do
  for j:=1 to 40 do
   begin
    setcolor(pic[i,j]);
    for k:=1 to 9 do
     line(80+i*10+k,j*10+1,
          80+i*10+k,j*10+9);
   end;
end;

Procedure fliphoriz;
var temp:word;
 begin
  for i:=1 to 20 do
   for j:=1 to 40 do
    begin
     temp:=pic[i,j];
     pic[i,j]:=pic[41-i,j];
     pic[41-i,j]:=temp;
    end;
  showbigpic;
  showlitpic;
 end;

Procedure flipvert;
var temp:word;
 begin
  for i:=1 to 40 do
   for j:=1 to 20 do
    begin
     temp:=pic[i,j];
     pic[i,j]:=pic[i,41-j];
     pic[i,41-j]:=temp;
    end;
  showbigpic;
  showlitpic;
 end;

Procedure coordinats;
var s1,s2:string[3];
    mx1,my1:integer;
begin
 getmousestatus(mx1,my1,lb,rb);
 if (mx>90)and(mx<490)and(my>10)and(my<410)and((mx<>mx1)or(my<>my1))
  then
   begin
    hidemouse;
    setcolor(lightgray);
    for i:=1 to 30 do line (27+i,351,27+i,368);
    str(1+(mx-90) div 10,s1);
    str(1+(my-10) div 10,s2);
    setcolor(black);
    outtextxy(28,352,s1);
    outtextxy(28,362,s2);
    showmouse;
   end
  else
   if (mx<>mx1)or(my<>my1)
    then
     begin
      hidemouse;
      setcolor(lightgray);
      for i:=1 to 30 do line (27+i,351,27+i,368);
      showmouse;
     end;
end;

Procedure save;
var w1:windop;
    o1:option;
    st:string[8];
    n,c:byte;
    f1:file of byte;
    si,rk:char;
    x,y:integer;
begin
    x:=270;
    y:=230;
    hidemouse;
    w1.init(220,200,420,280);
    w1.show;
    setcolor(black);
    outtextxy(252,210,'Enter file name :');
    outtextxy(x+78,y+4,'.WAR');
    o1.init(320,260,'  Ok  ');
    o1.show;
    setcolor(lightgray);
    for n:=1 to 73 do line (x+n,y,x+n,y+15);
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
     if (rk in['0'..'9','A'..'Z'])and(length(st)<8)
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
    o1.done;
    assign(f1,st+'.war');
    rewrite(f1);
    c:=255;
    write(f1,c);
    for i:=1 to 40 do
     for j:=1 to 40 do
      begin
       c:=pic[i,j];
       write(f1,c);
       for n:=1 to 5 do line(240+((i-1)*40+j-1)div 10,260+n,
                             240+((i-1)*40+j-1)div 10,260+n);
      end;
    close(f1);
    w1.done;
    showmouse;
end;

Procedure load;
var w1:windop;
    o1:option;
    st:string[8];
    n,c:byte;
    f1:file of byte;
    si,rk:char;
    x,y:integer;
begin
    x:=270;
    y:=230;
    hidemouse;
    w1.init(220,200,420,280);
    w1.show;
    setcolor(black);
    outtextxy(278,210,'Load file :');
    outtextxy(x+78,y+4,'.WAR');
    o1.init(320,260,'  Ok  ');
    o1.show;
    setcolor(lightgray);
    for n:=1 to 73 do line (x+n,y,x+n,y+15);
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
     if (rk in['0'..'9','A'..'Z'])and(length(st)<8)
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
    setcolor(lightgray);
    for n:=1 to 8 do line (x+length(st)*8+n,y,x+length(st)*8+n,y+15);
    o1.done;
    findfirst(st+'.war',anyfile,dirinfo);
    if doserror=0
     then
      begin
       assign(f1,st+'.war');
       reset(f1);
       read(f1,c);
       if c=255
        then
         begin
          setcolor(green);
          for i:=1 to 40 do
           for j:=1 to 40 do
            begin
             read(f1,c);
             pic[i,j]:=c;
             for n:=1 to 5 do line(240+((i-1)*40+j-1)div 10,260+n,
                                   240+((i-1)*40+j-1)div 10,260+n);
            end;
          w1.done;
          showlitpic;
          showbigpic;
         end
       else
        begin
         setcolor(black);
         outtextxy(265,260,'Graph Error ...');
         delay(800);
         w1.done;
        end;
       close(f1);
      end
     else
      begin
       setcolor(black);
       outtextxy(250,260,'File not found ...');
       delay(800);
       w1.done;
      end;
  showmouse;
end;

Procedure chPictures;
var temp:word;
 begin
  for i:=1 to 40 do
   for j:=1 to 40 do
    begin
     temp:=pic[i,j];
     pic[i,j]:=pic1[i,j];
     pic1[i,j]:=temp;
    end;
  showbigpic;
  showlitpic;
 end;


Procedure menu1;
var
   o1,o2,o3,o4,o5,o6,o7,o8:option;
begin
  hidemouse;
  o1.init(570,150,'     Quit     ');
  o1.show;
  o2.init(570,125,'     Save     ');
  o2.show;
  o3.init(570, 25,'     Clear    ');
  o3.show;
  o4.init(570, 50,'  Flip Horiz  ');
  o4.show;
  o5.init(570, 75,'  Flip  Vert  ');
  o5.show;
  o6.init(570,100,'     Load     ');
  o6.show;
  o7.init(40,408,' 1 ');
  o7.show;
  o8.init(40,432,' 2 ');
  o8.show;
  o7.activate;
  showmouse;
  repeat
   getmousestatus(mx,my,lb,rb);
   changecolor;
   getpic;
   coordinats;
   if o2.mousein(mx,my)and lb
    then
     begin
      hidemouse;
      o2.activate;
      save;
      o2.noactivate;
      showmouse;
     end;
   if o7.mousein(mx,my)and lb and not firstpic
    then
     begin
      hidemouse;
      o7.activate;
      o8.noactivate;
      firstpic:=true;
      chPictures;
      showmouse;
     end;
   if o8.mousein(mx,my)and lb and firstpic
    then
     begin
      hidemouse;
      o8.activate;
      o7.noactivate;
      firstpic:=false;
      chPictures;
      showmouse;
     end;
   if o6.mousein(mx,my)and lb
    then
     begin
      hidemouse;
      o6.activate;
      load;
      o6.noactivate;
      showmouse;
     end;
   if o3.mousein(mx,my)and lb
    then
     begin
      hidemouse;
      o3.activate;
      clear;
      o3.noactivate;
      showmouse;
     end;
   if o4.mousein(mx,my)and lb
    then
     begin
      hidemouse;
      o4.activate;
      fliphoriz;
      o4.noactivate;
      showmouse;
     end;
   if o5.mousein(mx,my)and lb
    then
     begin
      hidemouse;
      o5.activate;
      flipvert;
      o5.noactivate;
      showmouse;
     end;
  until o1.mousein(mx,my)and lb;
  hidemouse;
  o1.done;
  o2.done;
  o3.done;
  o4.done;
  o5.done;
  o6.done;
  o7.done;
  o8.done;
  showmouse;
end;

Procedure colorsview;
begin
 setcolor(darkgray);
 line(76,4,76,276);
 line(75,5,75,275);
 line(4,276,76,276);
 line(5,275,75,275);
 setcolor(white);
 line(4,4,76,4);
 line(5,5,75,5);
 line(4,4,4,276);
 line(5,5,5,275);
 for i:=1 to 2 do
  for j:=1 to 8 do
   begin
    rectangle(10+(i-1)*30,10+(j-1)*30,40+(i-1)*30,40+(j-1)*30);
    setviewport(11+(i-1)*30,11+(j-1)*30,39+(i-1)*30,39+(j-1)*30,true);
    setfillstyle(1,(i-1)*8+j-1);
    floodfill(1,1,white);
    setviewport(0,0,639,479,true);
   end;
end;

Procedure showlitpicwin;
begin
 setcolor(darkgray);
 line(4,336,76,336);
 line(5,335,75,335);
 line(76,284,76,336);
 line(75,285,75,335);
 setcolor(white);
 line(4,284,76,284);
 line(5,285,75,285);
 line(4,284,4,336);
 line(5,285,5,335);
 setcolor(darkgray);
 line(4,376,76,376);
 line(5,375,75,375);
 line(76,344,76,376);
 line(75,345,75,375);
 setcolor(white);
 line(4,344,76,344);
 line(5,345,75,345);
 line(4,344,4,376);
 line(5,345,5,375);
 setcolor(darkgray);
 line(4,446,76,446);
 line(5,445,75,445);
 line(76,384,76,446);
 line(75,385,75,445);
 setcolor(white);
 line(4,384,76,384);
 line(5,385,75,385);
 line(4,384,4,446);
 line(5,385,5,445);
 setcolor(darkgray);
 line(4,476,636,476);
 line(5,475,635,475);
 line(636,454,636,476);
 line(635,455,635,475);
 setcolor(white);
 line(4,454,636,454);
 line(5,455,635,455);
 line(4,454,4,476);
 line(5,455,5,475);
 outtextxy(18,388,'Window');
 outtextxy(10,352,'X:');
 outtextxy(10,362,'Y:');
 outtextxy(130,462,'WAR-Editor by Vadim Popov.  1996 Mariupol City.');
end;

BEGIN
 GMode:=0;
 Gdriver:=0;
 InitGraph(GDriver,GMode,'');
 if GraphResult=0
  then
   begin
    fon;
    firstpic:=true;
    resetmouse;
    colorsview;
    landview;
    showlitpic;
    showlitpicwin;
    showmouse;
    color:=5;
    showcolor;
    repeat
     menu1;
    until quit;
    hidemouse;
    CloseGraph;
   end
  else Writeln('Graph Error !');
END.