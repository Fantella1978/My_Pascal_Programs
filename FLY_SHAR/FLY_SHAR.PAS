Program fly_shark;

uses graph,crt,dos,fly;

type
   hs=record
     name:string[20];
     sc:integer;
   end;
var
   i,j,gd,gm:integer;
   road,road1:array[0..11,0..21]of byte;
   HIScore:array[1..10]of HS;
   weapon:array[1..3]of integer;
   rk:char;
   k,k1:integer;
   life:0..5;
   level:1..8;
   Fuel:0..1000;
   score:word;
   dirinfo:SearchRec;
   t:hs;
   f:file of hs;
   o1,o2,o3:option;
   gun_on,Misl_on,Bomb_on:boolean;

Procedure MislFire;
begin
 if (road[i,j]=4)
  then
   begin
    if (road1[i,j]=2)or(road1[i,j]=4)
     then
      begin
       showFire(i*20,10+j*20,white);
       road1[i,j]:=1;
       road[i,j]:=1;
       score:=score+5;
      end;
    if (road1[i,j-1]=2)or(road1[i,j-1]=4)
     then
      begin
       showFire(i*20,10+j*20,white);
       road1[i,j-1]:=1;
       road[i,j]:=1;
       score:=score+5;
      end;
   end;
end;

Procedure GunFire;
begin
 if (road[i,j]=3)
  then
   begin
    if (road1[i,j]=2)or(road1[i,j]=4)
     then
      begin
       showFire(i*20,10+j*20,white);
       road1[i,j]:=1;
       road[i,j]:=1;
       score:=score+5;
      end;
    if (road1[i,j-1]=2)or(road1[i,j-1]=4)
     then
      begin
       showFire(i*20,10+j*20,white);
       road1[i,j-1]:=1;
       road[i,j]:=1;
       score:=score+5;
      end;
   end;
end;

Procedure BombFire;
begin
 if (road[i,j]=5)
  then
   begin
    if (road1[i,j]=2)or(road1[i,j]=4)
     then
      begin
       showFire(i*20,10+j*20,white);
       road1[i,j]:=1;
       score:=score+5;
      end;
    if (road1[i,j-1]=2)or(road1[i,j-1]=4)
     then
      begin
       showFire(i*20,10+j*20,white);
       road1[i,j-1]:=1;
       score:=score+5;
      end;
   end;
end;

Procedure GetSuperBomb;
var i,j:byte;
begin
 for i:=1 to 10 do if (road1[i,20]=4)and(i=k)
  then
   begin
    weapon[3]:=weapon[3]+10;
    ShowWeapon(weapon[1],weapon[2],weapon[3]);
    for j:=1 to 20 do
     begin
      sound(100*j);
      delay(4);
      nosound;
     end;
   end;
end;

Procedure ShowHiScores;
var st:string[4];
    i:byte;
begin
 findfirst('Fly_Shar.hig',anyfile,dirinfo);
 if DosError=0
  then
   begin
    assign(f,'Fly_Shar.hig');
    reset(f);
    for i:=1 to 10 do
     begin
      read(f,t);
      HiScore[i]:=t;
     end;
    close(f);
   end
  else
   begin
    HiScore[1].name:='F A N T O M A S';
    HiScore[1].sc:=6500;
    HiScore[2].name:='I G O R';
    HiScore[2].sc:=5500;
    HiScore[3].name:='O L E G';
    HiScore[3].sc:=4500;
    HiScore[4].name:='S E B';
    HiScore[4].sc:=3500;
    HiScore[5].name:='S A M';
    HiScore[5].sc:=2500;
    HiScore[6].name:='R O L I C H';
    HiScore[6].sc:=1500;
    HiScore[7].name:='S E M E N';
    HiScore[7].sc:=1000;
    HiScore[8].name:='A N D R U S H A';
    HiScore[8].sc:=800;
    HiScore[9].name:='M O N S T E R';
    HiScore[9].sc:=500;
    HiScore[10].name:='MR. STUPID';
    HiScore[10].sc:=300;
    assign(f,'Fly_Shar.hig');
    rewrite(f);
    for i:=1 to 10 do
     begin
      t:=HiScore[i];
      write(f,t);
     end;
    close(f);
   end;
 setcolor(white);
 setviewport(280,50,620,164,true);
 clearviewport;
 setviewport(0,0,639,479,true);
 for i:=1 to 10 do
  begin
   str(HiScore[i].sc,st);
   outtextxy(290,50+i*10,HiScore[i].Name);
   outtextxy(450,50+i*10,'................ '+st);
  end;
end;

Procedure BeginNewGame;
begin
 ShowHiScores;
 ShowBeginGame;
 Weapon[1]:=500;
 Weapon[2]:=100;
 Weapon[3]:=0;
 gun_on:=true;
 Misl_on:=false;
 Bomb_on:=false;
 o1.activate;
 o2.noactivate;
 o3.noactivate;
 road[5,20]:=2;
 k:=5;
 k1:=5;
 Life:=5;
 Fuel:=1000;
 level:=1;
 Score:=0;
 ShowLevel(level);
 ShowLife(life);
 ShowAllFuel;
end;

Procedure gameover;
var i,j:byte;
begin
 ShowGameOver;
 for i:=1 to 10 do
  if score>HiScore[i].sc
   then
    begin
     if i<>10 then for j:=9 downto i do HiScore[j+1]:=HiScore[j];
     HiScore[i].Name:=EnterName;
     HiScore[i].sc:=score;
     break;
    end;
 assign(f,'Fly_Shar.hig');
 rewrite(f);
 for i:=1 to 10 do
  begin
   t:=HiScore[i];
   write(f,t);
  end;
 close(f);
 BeginNewGame;
end;

Procedure CrashShark;
var i,j:byte;
begin
 for i:=0 to 5 do
  begin
   ShowShark(k*20,390-i*20,white);
   showFree (k*20,410-i*20,white);
   ShowFire (k*20,410-i*20,white);
   delay(20);
  end;
 ShowFree (k*20,290,white);
 ShowFire (k*20,290,white);
 if k<10 then ShowFire ((k+1)*20,290,white);
 if k>1 then ShowFire ((k-1)*20,290,white);
 ShowFire (k*20,270,white);
 dec(life);
 fuel:=1000;
 ShowLife(life);
 for i:=1 to 10 do
  for j:=1 to 20 do
   begin
    road[i,j]:=0;
    road1[i,j]:=0;
    ShowFree(i*20,10+j*20,white);
   end;
 if life=0
  then gameover
  else
   begin
    k:=5;
    k1:=5;
    road[5,20]:=2;
    ShowLevel(level);
   end;
 ShowAllFuel;
end;

Procedure Crash;
begin
 if (road1[k,20]=2)or(road1[k,19]=2) then CrashShark;
end;

Procedure TMislFire(i:byte);
begin
 ShowFree(i*20,410,White);
 ShowFire(i*20,410,White);
 if road[i,20]=2
  then
   begin
    CrashShark;
   end;
end;

Procedure EndofFuel;
begin
 fuel:=1000;
 CrashShark;
end;

Procedure ShowField;
begin
  for j:=1 to 20 do
   for i:=1 to 10 do
    begin
     case road[i,j] of
      2:ShowShark(i*20,10+j*20,white);
      5:ShowBomb (i*20,10+j*20,white);
      4:ShowMisl (i*20,10+j*20,white);
      3:ShowGun  (i*20,10+j*20,white);
      1:ShowFree (i*20,10+j*20,white);
     end;
     MislFire;
     GunFire;
     BombFire;
    end;
  Crash;
  ShowFuelDec(fuel);
  GetSuperBomb;
  for j:=20 downto 1 do
   for i:=1 to 10 do
    begin
     case road1[i,j] of
      4:ShowSuperBomb(i*20,10+j*20,white);
      3:ShowTMisl(i*20,10+j*20,white);
      2:ShowTarget(i*20,10+j*20,white);
      1:ShowFree(i*20,10+j*20,white);
     end;
    end;
 for i:=1 to 10 do if road1[i,20]=3 then TMislFire(i);
end;

Procedure MoveField;
begin
 for i:=1 to 10 do
  for j:=1 to 19 do
   begin
    road[i,j-1]:=road[i,j];
   end;
 for i:=1 to 10 do
  for j:=20 downto 0 do
   begin
    road1[i,j+1]:=road1[i,j];
   end;
 for i:=1 to 10 do road[i,19]:=0;
 for i:=1 to 10 do road1[i,0]:=0;
 road[k,19]:=1;
end;

Procedure NewTMisl;
var t:byte;
begin
 t:=1+random(10);
 if road1[t,1]=0
  then
   begin
    road1[t,1]:=3;
    road1[t,0]:=1;
   end;
end;

Procedure NewSuperBomb;
var t:byte;
begin
 t:=1+random(10);
 if road1[t,1]=0
  then
   begin
    road1[t,1]:=4;
    road1[t,0]:=1;
   end;
end;

Procedure NewTarget;
var t:byte;
begin
 t:=1+random(10);
 if road1[t,1]=0
  then
   begin
    road1[t,1]:=2;
    road1[t,0]:=1;
   end;
end;

Procedure NextLevel;
var i,j:byte;
begin
 for i:=1 to 10 do
  for j:=1 to 20 do ShowFree(i*20,10+j*20,white);
 LevelComplite(level);
 delay(200);
 for i:=0 to 11 do
  for j:=0 to 21 do
   begin
    road[i,j]:=0;
    road1[i,j]:=0;
   end;
 inc(level);
 road[5,20]:=2;
 k:=5;
 k1:=5;
 Fuel:=1000;
 weapon[1]:=500;
 weapon[2]:=100;
 ShowLevel(level);
 ShowLife(life);
 ShowAllFuel;
end;

Procedure flyer;
begin
 randomize;
 repeat
  if keypressed then rk:=upcase(readkey)
                else rk:=#1;
  case rk of
   'P':pause;
   #77:begin
        if k<10
         then
          begin
           inc(k);
           road[k1,20]:=1;
           road[k,20]:=2;
           k1:=k;
          end;
       end;
   #75:begin
        if k>1
         then
          begin
           dec(k);
           road[k1,20]:=1;
           road[k,20]:=2;
           k1:=k;
          end;
       end;
   #13:begin
        if Bomb_on
         then
          begin
           o3.noactivate;
           Bomb_on:=false;
           Gun_on:=true;
           o1.activate;
          end
         else
        if Misl_on
         then
          begin
           o2.noactivate;
           Misl_on:=false;
           Bomb_on:=true;
           o3.activate;
          end
         else
        if Gun_on
         then
          begin
           o1.noactivate;
           gun_on:=false;
           misl_on:=true;
           o2.activate;
          end;
       end;
   #32:begin
        if Gun_on
         then
          if weapon[1]<>0
           then
            begin
             sound(900);
             delay(15);
             road[k,19]:=3;
             nosound;
             dec(weapon[1]);
            end;
        if Misl_on
         then
          if weapon[2]<>0
           then
            begin
             sound(300);
             delay(5);
             nosound;
             road[k,18]:=4;
             road[k-1,18]:=4;
             road[k+1,18]:=4;
             road[k+1,19]:=1;
             road[k-1,19]:=1;
             dec(weapon[2]);
             sound(600);
             delay(5);
             nosound;
            end;
        if Bomb_on
         then
          if weapon[3]<>0
           then
            begin
             sound(200);
             delay(6);
             nosound;
             for i:=1 to 10 do
              begin
               road[i,18]:=5;
               road[i,19]:=1;
              end;
             dec(weapon[3]);
             sound(400);
             delay(6);
             nosound;
            end;
       end;
  end;
 ShowField;
 MoveField;
 ShowScore(score);
 ShowWeapon(weapon[1],weapon[2],weapon[3]);
 if score>=sqr(level)*100+100 then NextLevel;
 if fuel=1 then EndofFuel;
 if fuel=300 then FuelAtention;
 if random(50)<level*2 then NewTarget;
 if random(50)<level then NewTMisl;
 if (random(50)<level)and(random(50)<level*2) then NewSuperBomb;
 delay((test8086-1)*70);
 dec(fuel);
 until rk=#27;
end;

BEGIN
 initgraph(gd,gm,'');
 if graphresult=0
  then
   begin
    fon;
    o1.init(405,243,'  1.   M A C H  G U N      ');
    o1.show;
    o2.init(405,283,'  2.   M I S S I L E       ');
    o2.show;
    o3.init(405,323,'  3.   S U P E R  B O M B  ');
    o3.show;
    BeginNewGame;
    flyer;
    o1.done;
    o2.done;
    o3.done;
    closegraph;
   end
  else writeln('Error in Graphics !');
END.