Program util;
uses
  crt,dos;
{$M $600,0,0}
type Rect = record
                   x1,y1,x2,y2:integer;
             end;
var
 a,b,c,d,x,s,s1,j:integer;
 dirinfo:searchrec;
 com:string;
 nigh:array[1..60,1..2] of byte;
 rk:char;
 r:registers;
 scor:array[1..6] of string[29];
 metal:array[1..8] of string[29];
 depech:array[1..5] of string[29];
 depech1:array[1..5] of array[1..40] of string[77];
 scorp1:array[1..6] of array[1..40] of string[77];
 as:array[1..10] of integer;
 ar:array[1..5] of string[16];
 lb,rb:boolean;
 mx,my,mox,moy:integer;
function InRect (x,y:integer;r:Rect):boolean;
begin
     with r do
       if (x>=x1) and (x<=x2) and (y>=y1) and (y<=y2) then InRect := True
       else InRect:=False;
end;
procedure Inter;
begin
     intr($33, r);
end;
procedure ResetMouse;
begin
     r.ax := 0;
     Inter;
end;
procedure ShowMouse;
begin
     r.ax := 1;
     Inter;
end;
procedure HideMouse;
begin
     r.ax := 2;
     Inter;
end;
procedure  GetMouseStatus(var x, y:integer; var lb, rb : boolean);
begin
     r.ax := 3;
     Inter;
     x := r.cx div 8 + 1;
     y := r.dx div 8 + 1;
     lb := False; rb := false;
     if r.bx = 1 then lb := True
     else if r.bx = 2 then rb := True
     else if r.bx = 3 then begin lb := true; rb := true; end;
end;
procedure SetMousePos(x,y:integer);
begin
     r.ax := 4;
     r.cx:=x;
     r.dx:=y;
     Inter;
end;
procedure SetMinMaxX ( min, max : integer );
begin
     r.ax := 7;
     r.cx:=min;
     r.dx:=max;
     Inter;
end;
procedure SetMinMaxY ( min, max : integer );
begin
     r.ax := 8;
     r.cx:=min;
     r.dx:=max;
     Inter;
end;
procedure mine;
begin
  window(1,1,80,24);
  textbackground(black);
  clrscr;
  window(1,3,80,24);
  textbackground(lightgray);
  clrscr;
  textbackground(black);
  window(1,1,80,25);
  textcolor(white);
  writeln('                              -= S O N G S =-' );
  textbackground(lightgray);
  gotoxy(1,3);
  textcolor(yellow);
  write('╔');
  for x:=1 to 78 do write('═');
  write('╗');
  for x:=4 to 23 do
   begin
    gotoxy(1,x);
    write('╩');
    gotoxy(80,x);
    write('║');
   end;
  write('╣');
  for x:=1 to 78 do write('╬');
  write('╝');
  gotoxy(1,2);
  textbackground(white);
  textcolor(black);
  for x:=1 to 5 do write(ar[x]);
  textbackground(black);
  textcolor(white);
  gotoxy(1,25);
  write('F');
  textcolor(red);
  write('1');
  textcolor(white);
  write('-ABOUT');
  write('  F');
  textcolor(red);
  write('10');
  textcolor(white);
  write('-MENU');
  textcolor(red);
  write('  Esc');
  textcolor(white);
  write('-EXIT');
  window(1,1,80,25);
  gotoxy(1,2);
end;
Procedure winop(cox,coy,cox1,coy1:integer;cl,cl1:byte;exi:boolean);
var
   nk:integer;
begin
   window(cox,coy,cox1,coy1);
   textbackground(cl);
   clrscr;
   textcolor(cl1);
   if exi=true
    then
     begin
      write('░▒');
      for nk:=1 to (cox1-cox-2) do write('═');
     end
    else
     begin
      write('╔');
      for nk:=0 to (cox1-cox-2) do write('═');
     end;
   write('╗');
   for nk:=1 to (coy1-coy-1) do
    begin
     gotoxy(1,1+nk);
     write('╩');
     gotoxy(cox1-cox+1,1+nk);
     write('║');
    end;
   gotoxy(1,coy1-coy+1);
   write('╣');
   for nk:=0 to (cox1-cox-2) do write('╬');
   window(cox,coy,cox1+1,coy1+1);
   gotoxy(cox1-cox+1,coy1-coy+1);
   write('╝');
   window(cox,coy,cox1+3,coy1+2);
   gotoxy(3,coy1-coy+2);
   textbackground(black);
   for nk:=0 to (cox1-cox) do write(' ');
   for nk:=0 to (coy1-coy) do
    begin
     gotoxy(cox1-cox+2,2+nk);
     write('  ');
    end;
   window(cox+1,coy+1,cox1-1,coy1-1);
   textcolor(cl1);
   textbackground(cl);
end;
Procedure Nightmare;
var n,x,y:byte;
begin
   hidemouse;
   randomize;
   window(1,1,80,25);
   textcolor(white);
   textbackground(black);
   clrscr;
   repeat
    getmousestatus(mx,my,lb,rb);
    delay(50);
    n:=n+1;
    if n>=60 then n:=1;
    x:=1+random(79);
    y:=1+random(24);
    gotoxy(x,y);
    nigh[n,1]:=x;
    nigh[n,2]:=y;
    write('.');
    gotoxy(nigh[61-n,1],nigh[61-n,2]);
    write(' ');
   until keypressed or (mx<>80) or(my<>1);
   showmouse;
end;

Procedure about;
begin
  a:=25;
  b:=7;
  c:=55;
  d:=20;
  winop(a,b,c,d,red,yellow,true);
  writeln('           ABOUT');
  window(1,1,80,25);
  gotoxy(1,2);
  repeat
   getmousestatus(mx,my,lb,rb);
   if keypressed then rk:=readkey;
  until (rk=#27)or(lb and (mx>=a)and(mx<=a+1)and(my=b));
  window(20,6,60,22);
  textbackground(lightgray);
  textcolor(white);
  clrscr;
  window(1,1,80,25);
  gotoxy(1,2);
end;
Procedure scorpion;
var
  rk:char;
  nik,nik1:byte;
begin
  hidemouse;
  nik:=1;
  window(as[j],4,as[j]+32,7+as[5+j]);
  textbackground(lightgray);
  textcolor(black);
  clrscr;
  window(20,4,78,23);
  rk:=#1;
  repeat
   clrscr;
   for nik1:=nik to nik+18 do writeln(scorp1[s,nik1]);
   rk:=readkey;
   if rk=#80
    then
     begin
      nik:=nik+1;
      if nik>=40-18 then nik:=40-18;
     end;
   if rk=#72
    then
     begin
      nik:=nik-1;
      if nik<=1 then nik:=1;
     end;
  until rk=#27;
  showmouse;
end;

Procedure depeche;
var
  rk:char;
  nik,nik1:byte;
begin
  hidemouse;
  nik:=1;
  window(as[j],4,as[j]+32,7+as[5+j]);
  textbackground(lightgray);
  textcolor(black);
  clrscr;
  window(20,4,78,23);
  rk:=#1;
  repeat
   clrscr;
   for nik1:=nik to nik+18 do writeln(depech1[s,nik1]);
   rk:=readkey;
   if rk=#80
    then
     begin
      nik:=nik+1;
      if nik>=40-18 then nik:=40-18;
     end;
   if rk=#72
    then
     begin
      nik:=nik-1;
      if nik<=1 then nik:=1;
     end;
  until rk=#27;
  showmouse;
end;

Procedure menu;
var
  rk:char;
  n,j1:integer;
begin
  as[1]:=2;
  as[2]:=10;
  as[3]:=25;
  as[4]:=40;
  as[5]:=47;
  as[6]:=8;
  as[7]:=6;
  as[8]:=0;
  as[9]:=5;
  as[10]:=0;
  j:=1;
  j1:=2;
  s:=1;
  a:=as[j];
  b:=4;
  c:=as[j]+30;
  d:=6+as[5+j];
  repeat
  if j1<>j
   then
    begin
     hidemouse;
     s1:=100;
     window(a,b,c+2,d+1);
     textbackground(lightgray);
     textcolor(white);
     clrscr;
     a:=as[j];
     b:=4;
     c:=as[j]+30;
     d:=6+as[5+j];
     winop(a,b,c,d,blue,yellow,false);
     window(1,1,80,25);
     gotoxy(1,2);
     for n:=1 to 5 do
      begin
       if j=n
        then
         begin
          textbackground(black);
          textcolor(white);
         end
        else
         begin
          textbackground(white);
          textcolor(black);
         end;
       write(ar[n]);
      end;
     showmouse;
    end;
  window(a+1,b+1,c-1,d-1);
  if s<>s1
   then
    begin
     hidemouse;
     case j of
      2:
      for n:=1 to as[7] do
      begin
       if s=n
        then
         begin
          textbackground(white);
          textcolor(blue);
         end
        else
         begin
          textbackground(blue);
          textcolor(white);
         end;
      write(scor[n]);
      end;
      4:
      for n:=1 to as[9] do
      begin
       if s=n
        then
         begin
          textbackground(white);
          textcolor(blue);
         end
        else
         begin
          textbackground(blue);
          textcolor(white);
         end;
       write(depech[n]);
      end;
      1:
      for n:=1 to as[6] do
      begin
       if s=n
        then
         begin
          textbackground(white);
          textcolor(blue);
         end
        else
         begin
          textbackground(blue);
          textcolor(white);
         end;
       write(metal[n]);
      end;
     end;
    showmouse;
   end;
  j1:=j;
  window(1,1,80,25);
  gotoxy(1,2);
  rk:=#1;
  if keypressed then rk:=readkey;
  getmousestatus(mx,my,lb,rb);
   if lb and (my=2)
    then
     begin
      j:=1+(mx-1) div 16;
      s:=1;
     end;
   s1:=s;
   if lb and (my>4)and(my<=as[5+j]+4)and(mx>as[j])and(mx<as[j]+30)
    then s:=my-4;
   if rk=#77
    then
     begin
      j:=j+1;
      if j>5 then j:=1;
     end;
   if rk=#80
    then
     begin
      s:=s+1;
      if s>as[5+j] then s:=1;
     end;
   if rk=#72
    then
     begin
      s:=s-1;
      if s<1 then s:=as[j+5];
     end;
   if rk=#75
    then
     begin
      j:=j-1;
      if j<1 then j:=5;
     end;
   if rk=#27
    then
     begin
      rk:=#13;
      textbackground(lightgray);
      window(a,b,c+2,d+1);
      clrscr;
      window(1,1,80,25);
      textbackground(white);
      textcolor(black);
      gotoxy(1,2);
      for n:=1 to 5 do write(ar[n]);
      j:=0;
     end;
   until (rk=#13)or((my=s+4)and(mx>as[j])and(mx<as[j]+30)and rb);
   if j=2 then scorpion;
   if j=4 then depeche;
   window(20,4,78,23);
   textbackground(lightgray);
   clrscr;
   window(1,1,80,25);
   gotoxy(1,2);
   textbackground(white);
   textcolor(black);
   for x:=1 to 5 do write(ar[x]);
end;
begin
  resetmouse;
  showmouse;
  r.ah:=01;
  r.ch:=32;
  r.cl:=0;
  intr($10,r);

  depech1[2,1]:='  PERSONAL JESUS';
  depech1[2,2]:=' ';
  depech1[2,3]:='Our own personal jesus';
  depech1[2,4]:='Someone to hear your proyers';
  depech1[2,5]:='Someone who cares';
  depech1[2,6]:='Your own personal jesus';
  depech1[2,7]:='Someone to hear your proyers';
  depech1[2,8]:='Someone who is there';
  depech1[2,9]:='Feeling unknown';
  depech1[2,10]:='And you are all alone';
  depech1[2,11]:='Flesh and bone';
  depech1[2,12]:='By the telephone';
  depech1[2,13]:='Lift up the receiver';
  depech1[2,14]:='I will make you a beliver';
  depech1[2,15]:='Take second best';
  depech1[2,16]:='Put me to the test';
  depech1[2,17]:='Things on your chest';
  depech1[2,18]:='You need to confess';
  depech1[2,19]:='I will deliver';
  depech1[2,20]:='You know i am a forgiver';
  depech1[2,21]:='Reach out and touch faith';
  depech1[2,22]:='Reach out and touch faith';
  depech1[2,23]:='Your own personal jesus';
  depech1[2,24]:='Feeling unknown';
  depech1[2,25]:='And you are all alone';
  depech1[2,26]:='Flesh and bone';
  depech1[2,27]:='By the telephone';
  depech1[2,28]:='Lift up the receiver';
  depech1[2,29]:='I will make you a beliver';
  depech1[2,30]:='I will deliver';
  depech1[2,31]:='You know i am a forgiver';
  depech1[2,32]:='Reach out and touch faith';
  depech1[2,33]:='Your own personal jesus';
  depech1[2,34]:='Reach out and touch faith';

  depech1[1,1]:=' ENJOY THE SILENCE';
  depech1[1,2]:=' ';
  depech1[1,3]:='Word like violence';
  depech1[1,4]:='Break the silence';
  depech1[1,5]:='Come crashing in';
  depech1[1,6]:='Into my little world';
  depech1[1,7]:='Painful to me';
  depech1[1,8]:='Pierce right through me';
  depech1[1,9]:='Can not you understand';
  depech1[1,10]:='Oh my little girl';
  depech1[1,11]:='All i ever wanted';
  depech1[1,12]:='All i ever needed';
  depech1[1,13]:='Is here in my arms';
  depech1[1,14]:='Words are very unnecessary';
  depech1[1,15]:='They can only do harm';
  depech1[1,16]:='Vows are spoken';
  depech1[1,17]:='To be broken';
  depech1[1,18]:='Feelings are intense';
  depech1[1,19]:='Words are trivial';
  depech1[1,20]:='Pleasure remain';
  depech1[1,21]:='So does the pain';
  depech1[1,22]:='Words are Meaningless';
  depech1[1,23]:='And Forgettable';
  depech1[1,24]:='All ever wanted ...';
  depech1[1,25]:='Enjoy the silence.';

  ar[1]:='   Metallica    ';
  ar[2]:='   Scorpions    ';
  ar[3]:='    Nirvana     ';
  ar[4]:='  Depeche Mode  ';
  ar[5]:='     Queen      ';
  scor[1]:='Woman                        ';
  scor[2]:='Passion Rules The Game       ';
  scor[3]:='Rock You Like A Hurricane    ';
  scor[4]:='Rhythm Of Love               ';
  scor[5]:='Walking On The Edge          ';
  scor[6]:='Send Me An Angel             ';
  metal[1]:='The Unforgiven               ';
  metal[2]:='Enter Sandman                ';
  metal[3]:='Nothing Else Matters         ';
  metal[4]:='Sad But True                 ';
  metal[5]:='Wherever I May Roam          ';
  metal[6]:='The Struggle Within          ';
  metal[7]:='My Friend Of Misery          ';
  metal[8]:='Through The Never            ';
  depech[1]:='Enjoy The Silence            ';
  depech[2]:='Personal Jesus               ';
  depech[3]:='World In My Eyes             ';
  depech[4]:='Halo                         ';
  depech[5]:='The Policy Of Truth          ';
  textbackground(black);
  clrscr;
  findfirst('fontload.com',anyfile,dirinfo);
  if doserror<>0
   then
    begin
     writeln('Файл FONTLOAD.COM не найден !');
     exit;
    end;
  findfirst('font1.fnt',anyfile,dirinfo);
  if doserror<>0
   then
    begin
     writeln('Файл FONT1.FNT не найден !');
     exit;
    end;
  Com:='fontload.com font1.fnt';
  SwapVectors;
  Exec(GetEnv('COMSPEC'), '/C ' + Com);
  SwapVectors;
  if DosError <> 0
   then
    begin
     WriteLn('Не могу выполнить COMMAND.COM');
     delay(1000);
     exit;
    end;
  findfirst('normal.fnt',anyfile,dirinfo);
  if doserror<>0
   then
    begin
     writeln('Файл NORMAL.FNT не найден !');
     exit;
    end;
  mine;
  repeat
   rk:=#1;
   if keypressed then rk:=readkey;
   getmousestatus(mx,my,lb,rb);
   if (rk=#59)or( lb and (my=25)and(mx>=1)and(mx<=8)) then about;
   if (rk=#68) or( lb and (my=25)and(mx>=11)and(mx<=18))then menu;
   if (mx=80)and(my=1)
    then
     begin
      nightmare;
      mine;
     end;
  until (rk=#27)or( lb and (my=25)and(mx>=21)and(mx<=28));
  textcolor(white);
  textbackground(black);
  window(1,1,80,25);
  clrscr;
  Com:='fontload.com normal.fnt';
  SwapVectors;
  Exec(GetEnv('COMSPEC'), '/C ' + Com);
  SwapVectors;
  if DosError <> 0
   then
    begin
     WriteLn('Не могу выполнить COMMAND.COM');
     delay(1000);
     exit;
    end;
end.