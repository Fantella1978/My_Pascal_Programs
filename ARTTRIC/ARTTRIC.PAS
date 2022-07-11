Program Kurs2;
uses graph,crt,dos,k_tpu;
{$M 65000,0,655360}
const
  colors:array[1..3,1..4]of word=
   ((yellow,lightblue,green,lightred),
    (green,yellow,cyan,white),
    (lightmagenta,lightblue,white,cyan));
var
   gdriver,gmode:integer;
   dirinfo:searchrec;
   op8,exi,op1,op2,op3,op4,op5,op6,op7:option;
   ball_1:ball;
   w1:windop;
   n,cod,acur,m_x,m_y,colnum:integer;
   lb,rb,viewon:boolean;
   rk,si:char;
   a,b:real;
   str_funct:string[40];

Procedure graphic(a,b:real);
var
    i,j:integer;
    kx,ky,dy,dx,y,x,miny,maxy,minx,maxx:real;
    st:string[8];
    mas:array[0..1510]of real;
begin
 hidemouse;
 w1.init(265,200,510,300);
 w1.show;
 setcolor(black);
 outtextxy(325,225,'Data processing !');
 for i:=1 to 150 do line(315+i,245,315+i,260);
 setcolor(white);
 outtextxy(280,249,'0%');
 outtextxy(470,249,'100%');
 n:=40+30*(acur-50);
 minx:=a; maxx:=b;
 if abs(maxx-minx)<0.001
  then
   begin
    maxx:=maxx+0.001;
    minx:=minx-0.001;
   end;
 x:=minx;dx:=abs(maxx-minx)/n;
 cod:=0;
 initfunct(str_funct,a,miny,cod);
 if cod=0 then
  begin
   maxy:=miny;
   setcolor(green);
   i:=1;
   repeat
    for j:=0 to round(i/n*150) do line(315+j,245,315+j,260);
    x:=x+dx;
    cod:=0;
    initfunct(str_funct,x,mas[i],cod);
    if cod<>0 then break;
    if mas[i]>maxy then maxy:=mas[i];
    if mas[i]<miny then miny:=mas[i];
    inc(i);
   until i>n;
   if cod=0
    then
     begin
      w1.done;
      showmouse;
      if maxy=miny
       then
        begin
         maxy:=maxy+1;
         miny:=miny-1;
        end;
      if abs(maxy-miny)<0.001
       then
        begin
         maxy:=maxy+0.001;
         miny:=miny-0.001;
        end;
      dy:=abs(maxy-miny)/n;
      setcolor(lightblue);
      for i:=0 to 10 do
       begin
        settextstyle(0,0,0);
        str(miny+dy*i/10*n:8:8,st);
        outtextxy(220,350-30*i,st);
        settextstyle(0,1,0);
        str(minx+dx*i*n/10:8:8,st);
        outtextxy(304+i*30,360,st);
       end;
      settextstyle(0,0,0);
      kx:=300/(n*dx); ky:=300/(n*dy);
      setcolor(colors[colnum,4]);
      for i:=1 to n-1 do
       begin
        x:=a+dx*i; y:=mas[i];
        if (mas[i]>mas[i-1])and(mas[i]>mas[i+1])and(i<>1)
         then
          begin
           setcolor(colors[colnum,2]);
           circle(round(300+kx*dx*i),round(350-ky*(y-miny)),3);
           setcolor(colors[colnum,4]);
          end;
        if (mas[i]<mas[i-1])and(mas[i]<mas[i+1])and(i<>1)
         then
          begin
           setcolor(colors[colnum,1]);
           circle(round(300+kx*dx*i),round(350-ky*(y-miny)),3);
           setcolor(colors[colnum,4]);
          end;
        line(round(300+kx*dx*i),round(350-ky*(y-miny)),
             round(300+kx*dx*(i+1)),round(350-ky*(mas[i+1]-miny)));
       end;
     end
    else
     begin
      errors(cod);
      w1.done;
      exit;
     end;
   end
  else
   begin
    errors(cod);
    w1.done;
    exit;
   end;
end;

Procedure acur_1;
begin
 setcolor(black);
 for n:=round(134/49*(acur-50)) to 134 do line(320+n,226,320+n,244);
 setcolor(lightblue);
 for n:=1 to round(134/49*(acur-50)) do line(320+n,226,320+n,244);
end;

Procedure accuracy;
var ac1,ac2:option;
begin
  hidemouse;
  op5.blind;
  w1.init(265,200,510,300);
  w1.show;
  setcolor(black);
  ac1.init(480,235,' > ');
  ac1.show;
  ac2.init(295,235,' < ');
  ac2.show;
  setcolor(darkgray);
  setfillstyle(1,black);
  rectangle(320,225,455,245);
  floodfill(325,235,darkgray);
  setcolor(black);
  outtextxy(285,255,'50%');
  outtextxy(470,255,'99%');
  exi.init(395,280,' Ok ');
  exi.show;
  acur_1;
  setmousepos(360,250);
  showmouse;
  repeat
   if keypressed
    then rk:=upcase(readkey)
     else rk:=#1;
   getmousestatus(m_x,m_y,lb,rb);
   hidemouse;
   ball_1.jump;
   showmouse;
   delay(20);
   if ac1.mousein(m_x,m_y,lb)or (rk=#77) then
    begin
     acur:=acur+1;
     if acur>=99 then acur:=99;
     acur_1;
    end;
   if ac2.mousein(m_x,m_y,lb)or (rk=#75) then
    begin
     acur:=acur-1;
     if acur<=50 then acur:=50;
     acur_1;
    end;
  until exi.mousein(m_x,m_y,lb) or(rk=#13);
  exi.done;
  ac1.done;
  ac2.done;
  hidemouse;
  w1.done;
  op5.show;
  showmouse;
end;

Procedure view;
begin
  hidemouse;
  op1.blind;
  if a>=b
   then
    begin
     w1.init(265,200,510,300);
     w1.show;
     setcolor(red);
     outtextxy(370,221,'ERROR:');
     setcolor(black);
     outtextxy(287,243,'Minimum -X- >= Maximum -X-');
     showmouse;
     winexit;
     hidemouse;
     w1.done;
    end
   else
    begin
     osi_coordinat(colors[colnum,1],colors[colnum,2],
                   colors[colnum,3],colors[colnum,3],
                   a,b,viewon,str_funct);
     graphic(a,b);
     viewon:=true;
    end;
 op1.show;
 showmouse;
end;

Procedure setcolors;
var c1,c2,c3:option;
begin
  hidemouse;
  op4.blind;
  w1.init(265,200,510,300);
  w1.show;
  exi.init(395,280,' Ok ');
  exi.show;
  c1.init(320,250,' 1 ');
  c1.show;
  c2.init(392,250,' 2 ');
  c2.show;
  c3.init(460,250,' 3 ');
  c3.show;
  setcolor(black);
  outtextxy(295,221,'Enter number of colors !');
  showmouse;
  setcolor(red);
  case colnum of
   1:rectangle(298,238,342,262);
   2:rectangle(371,238,413,262);
   3:rectangle(438,238,482,262);
  end;
  repeat
   if keypressed
    then rk:=upcase(readkey)
     else rk:=#1;
   hidemouse;
   ball_1.jump;
   showmouse;
   getmousestatus(m_x,m_y,lb,rb);
   if (rk='1') or c1.mousein(m_x,m_y,lb)
    then
     begin
      colnum:=1;
      hidemouse;
      setcolor(red);
      rectangle(298,238,342,262);
      setcolor(lightgray);
      rectangle(371,238,413,262);
      rectangle(438,238,482,262);
      showmouse;
     end;
   if (rk='2') or c2.mousein(m_x,m_y,lb)
    then
     begin
      colnum:=2;
      hidemouse;
      setcolor(red);
      rectangle(371,238,413,262);
      setcolor(lightgray);
      rectangle(298,238,342,262);
      rectangle(438,238,482,262);
      showmouse;
     end;
   if (rk='3') or c3.mousein(m_x,m_y,lb)
    then
     begin
      colnum:=3;
      hidemouse;
      setcolor(red);
      rectangle(438,238,482,262);
      setcolor(lightgray);
      rectangle(298,238,342,262);
      rectangle(371,238,413,262);
      showmouse;
     end;
   delay(20);
  until exi.mousein(m_x,m_y,lb) or(rk=#13);
  hidemouse;
  c1.done;
  c2.done;
  c3.done;
  exi.done;
  w1.done;
  op4.show;
  showmouse;
  osi_coordinat(colors[colnum,1],colors[colnum,2],
                colors[colnum,3],colors[colnum,3],
                a,b,viewon,str_funct);
  viewon:=false;
end;

function x_in:string;
var st:string[8];
    plot:boolean;
    i:integer;
begin
  exi.init(395,280,' Ok ');
  exi.show;
  st:='        ';
  n:=1;
  setcolor(white);
  plot:=false;
  si:='-';
  repeat
   case si of
    '|':si:='/';
    '/':si:='-';
    '-':si:='\';
    '\':si:='|';
   end;
   setcolor(black);
   for i:=0 to 7 do line(362+(n-1)*8+i,242,362+(n-1)*8+i,250);
   setcolor(yellow);
   outtextxy(362+(n-1)*8,242,si);
   if keypressed
    then rk:=upcase(readkey)
    else rk:=#1;
   if (n=1)and(rk='-')
    then
     begin
      setcolor(black);
      for i:=0 to 7 do line(362+(n-1)*8+i,242,362+(n-1)*8+i,250);
      setcolor(white);
      st[1]:='-';
      outtextxy(362,242,'-');
      n:=2;
     end;
    if (n>1)and(n<=8)and(rk=#8)
     then
      begin
       setcolor(black);
       for i:=0 to 15 do line(362+(n-2)*8+i,242,362+(n-2)*8+i,250);
       setcolor(white);
       if st[n-1]='.' then plot:=false;
       st[n-1]:=' ';
       n:=n-1;
      end;
    if (n>1)and(n<7)and(rk='.')and(st[n-1]>='0')and(st[n-1]<='9')
       and(plot=false)
     then
      begin
       setcolor(black);
       for i:=0 to 7 do line(362+(n-1)*8+i,242,362+(n-1)*8+i,250);
       setcolor(white);
       plot:=true;
       st[n]:='.';
       outtextxy(362+(n-1)*8,242,rk);
       n:=n+1;
      end;
    if (n>=1)and(n<=7)and(rk in['0'..'9'])
     then
      begin
       setcolor(black);
       for i:=0 to 7 do line(362+(n-1)*8+i,242,362+(n-1)*8+i,250);
       setcolor(white);
       st[n]:=rk;
       outtextxy(362+(n-1)*8,242,rk);
       n:=n+1;
      end;
    hidemouse;
    ball_1.jump;
    showmouse;
    delay(50);
  until (n<>1)and(st[n-1]<>'-')and(st[n-1]<>'.')and(rk=#13);
  x_in:=copy(st,1,n-1);
  exi.done;
end;

Procedure setx;
var x_nach,x_konech:string[8];
    code:integer;
    ss,dd:string[8];
begin
  hidemouse;
  op3.blind;
  w1.init(265,200,510,300);
  w1.show;
  setcolor(black);
  outtextxy(342,218,'Minimum -X- :');
  setcolor(black);
  for n:=1 to 65 do line(360+n,240,360+n,250);
  setcolor(white);
  x_nach:=x_in;
  delay(50);
  w1.blind;
  w1.show;
  setcolor(black);
  outtextxy(342,218,'Maximum -X- :');
  setcolor(black);
  for n:=1 to 64 do line(360+n,240,360+n,250);
  setcolor(white);
  x_konech:=x_in;
  w1.done;
  op3.show;
  showmouse;
  val(x_nach,a,code);
  val(x_konech,b,code);
  osi_coordinat(colors[colnum,1],colors[colnum,2],
                colors[colnum,3],colors[colnum,3],
                a,b,viewon,str_funct);
end;

Procedure mustview;
begin
 hidemouse;
 w1.init(265,200,510,300);
 w1.show;
 setcolor(red);
 outtextxy(372,218,'Error:');
 setcolor(black);
 outtextxy(292,240,'Graphic must be viewing !');
 showmouse;
 winexit;
 hidemouse;
 setcolor(black);
 w1.done;
 showmouse;
end;

Procedure increate;
var i,i1:integer;
    a1:real;
begin
 i:=0;i1:=1;
 if viewon then
  begin
   hidemouse;
   op6.blind;
   repeat
    if keypressed
     then rk:=upcase(readkey)
     else rk:=#1;
    if (rk=#77)and(i<200)then i:=i+5;
    if (rk=#75)and(i>0)then i:=i-5;
    if i<>i1 then
     begin
      setcolor(black);
      line(300+i1,355,300+i1,359);
      line(300+i1,357,400+i1,357);
      line(300+i1+100,355,300+i1+100,359);
      line(300+i1,40,300+i1,45);
      line(300+i1,42,400+i1,42);
      line(300+i1+100,40,300+i1+100,45);
      setcolor(green);
      line(300+i,355,300+i,359);
      line(300+i,357,400+i,357);
      line(300+i+100,355,300+i+100,359);
      line(300+i,40,300+i,45);
      line(300+i,42,400+i,42);
      line(300+i+100,40,300+i+100,45);
      i1:=i;
     end;
    delay(20);
    hidemouse;
    ball_1.jump;
    showmouse;
   until rk=#13;
   a1:=a;
   a:=a+abs(a-b)/300*i;
   b:=a1+abs(a1-b)/300*(i+100);
   view;
   op6.show;
   showmouse;
  end
 else
  begin
   hidemouse;
   op6.blind;
   showmouse;
   mustview;
   hidemouse;
   op6.show;
   showmouse;
  end;
end;

function funct(st:string):string;
var
  exi:option;
begin
  hidemouse;
  op2.blind;
  w1.init(140,190,500,310);
  w1.show;
  exi.init(320,290,' Ok ');
  exi.show;
  setcolor(black);
  outtextxy(257,210,'Enter function :');
  for n:=1 to 321 do line (160+n,255,160+n,270);
  si:='-';
  repeat
   case si of
    '|':si:='/';
    '/':si:='-';
    '-':si:='\';
    '\':si:='|';
   end;
   setcolor(black);
   for n:=1 to 8 do line (160+length(st)*8+n,255,160+length(st)*8+n,270);
   setcolor(white);
   outtextxy(161,259,st);
   setcolor(yellow);
   outtextxy(153+(length(st)+1)*8,259,si);
   delay(60);
   if keypressed
    then rk:=upcase(readkey)
    else rk:=#1;
   if (rk in['0'..'9','-','+','*','/',
       '.','A','B','C','E','I','L','N'..'T','X','(',')'])
      and(length(st)<39)
    then
     begin
      st:=st+rk;
      setcolor(black);
      for n:=1 to 8 do line (152+length(st)*8+n,255,152+length(st)*8+n,270);
      setcolor(white);
      outtextxy(153+length(st)*8,259,rk);
     end;
   if (rk=#8)and(length(st)>0)
    then
     begin
      delete(st,length(st),1);
      setcolor(black);
      for n:=1 to 17 do line (160+length(st)*8+n,255,160+length(st)*8+n,270);
     end;
  until (rk=#13)and(length(st)>0);
  exi.done;
  w1.done;
  op2.show;
  showmouse;
  funct:=st;
end;

Procedure save;
var st:string[8];
    i,j:integer;
    c:word;
    f1:file of integer;
begin
 if viewon
  then
   begin
    hidemouse;
    op8.blind;
    w1.init(265,200,510,300);
    w1.show;
    setcolor(black);
    outtextxy(322,218,'Enter file name :');
    outtextxy(409,244,'.ATT');
    exi.init(390,280,' Ok ');
    exi.show;
    setcolor(black);
    for n:=1 to 73 do line (330+n,240,330+n,255);
    si:='-';
    st:='';
    repeat
     case si of
      '|':si:='/';
      '/':si:='-';
      '-':si:='\';
      '\':si:='|';
     end;
     setcolor(black);
     for n:=1 to 8 do line (330+length(st)*8+n,240,330+length(st)*8+n,255);
     setcolor(white);
     outtextxy(331,244,st);
     setcolor(yellow);
     outtextxy(323+(length(st)+1)*8,244,si);
     delay(50);
     if keypressed
      then rk:=upcase(readkey)
      else rk:=#1;
     if (rk in['0'..'9','A'..'Z'])and(length(st)<8)
      then
       begin
        st:=st+rk;
        setcolor(black);
        for n:=1 to 8 do line (322+length(st)*8+n,240,322+length(st)*8+n,255);
        setcolor(white);
        outtextxy(323+length(st)*8,244,rk);
       end;
     if (rk=#8)and(length(st)>0)
      then
       begin
        delete(st,length(st),1);
        setcolor(black);
        for n:=1 to 17 do line (330+length(st)*8+n,240,330+length(st)*8+n,255);
       end;
    until (rk=#13)and(length(st)>0);
    exi.done;
    w1.done;
    w1.init(17,326,132,452);
    w1.show;
    setcolor(black);
    outtextxy(49,370,'PICTURE');
    outtextxy(53,400,'SAVING');
    assign(f1,st+'.att');
    rewrite(f1);
    for i:=6 to 520 do
     for j:=455 to 475 do
      begin
       c:=getpixel(i,j);
       if c=red
        then
	 begin
	  n:=(i+50)*16+c;
          write(f1,n,j);
	 end;
      end;
    for i:=151 to 620 do
     for j:=20 to 450 do
      begin
       c:=getpixel(i,j);
       if c<>0
        then
	 begin
	  n:=(i-70)*16+c;
          write(f1,n,j);
	 end;
      end;
    close(f1);
    w1.done;
    op8.show;
    showmouse;
   end
  else
   begin
    hidemouse;
    op8.blind;
    showmouse;
    mustview;
    hidemouse;
    op8.show;
    showmouse;
   end;
end;

Procedure menu;
begin
  op1.init(75,30,'     VIEW     ');
  op2.init(75,55,'   FUNCTION   ');
  op3.init(75,80,'   SET  -X-   ');
  op4.init(75,105,'    COLORS    ');
  op7.init(75,205,'     QUIT     ');
  op6.init(75,155,'   INCREASE   ');
  op5.init(75,130,'   ACCURACY   ');
  op8.init(75,180,' PICTURE SAVE ');
  op1.show;
  op2.show;
  op3.show;
  op4.show;
  op7.show;
  op6.show;
  op5.show;
  op8.show;
  ball_1.show;
  resetmouse;
  showmouse;
  repeat
   if keypressed
    then rk:=upcase(readkey)
   else rk:=#1;
   getmousestatus(m_x,m_y,lb,rb);
   if op1.mousein(m_x,m_y,lb) or(rk='V') then view;
   if op5.mousein(m_x,m_y,lb) or(rk='A') then accuracy;
   if op3.mousein(m_x,m_y,lb) or(rk='S') then setx;
   if op4.mousein(m_x,m_y,lb) or(rk='C') then setcolors;
   if op6.mousein(m_x,m_y,lb) or(rk='I') then increate;
   if op8.mousein(m_x,m_y,lb) or(rk='P') then save;
   if op2.mousein(m_x,m_y,lb) or(rk='F')
    then
     begin
      str_funct:=funct(str_funct);
      osi_coordinat(colors[colnum,1],colors[colnum,2],
                    colors[colnum,3],colors[colnum,3],
                    a,b,viewon,str_funct);
     end;
   hidemouse;
   ball_1.jump;
   showmouse;
   delay(30);
  until op7.mousein(m_x,m_y,lb) or (rk='Q');
  hidemouse;
  op1.done;
  op2.done;
  op3.done;
  op4.done;
  op5.done;
  op6.done;
  op7.done;
  op8.done;
end;

BEGIN
  findfirst('trip.chr',anyfile,dirinfo);
  if doserror<>0 then exit;
  findfirst('attshow.exe',anyfile,dirinfo);
  if doserror<>0 then exit;
  findfirst('egavga.bgi',anyfile,dirinfo);
  if doserror<>0 then exit;
  colnum:=3; a:=1; b:=10;
  viewon:=false; acur:=55;
  str_funct:='COS(X)*X';
  gmode:=0; gdriver:=0;
  initgraph(gdriver,gmode,'');
  zastavka;
  ramka_1;
  osi_coordinat(colors[colnum,1],colors[colnum,2],
                colors[colnum,3],colors[colnum,3],
                a,b,viewon,str_funct);
  ball_1.init(yellow,20,17,327,133,451);
  menu;
  ball_1.done;
  closegraph;
END.
