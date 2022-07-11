uses graph,crt;

type coord=record
       x,y,z:word;
     end;
var
   ar1,ar2,ar3,ar4:array[1..100]of coord;
   gd,gm:integer;
   i,x,y,z,ScrX,ScrY:word;
   addy,addx:word;

Begin

gd:=detect;

initgraph(gd,gm,'');

for i:=1 to 50 do
 begin
  ar1[i].x:=160+random(50);
  ar1[i].y:=random(100);
  ar1[i].z:=random(50);
  ar2[i].x:=160+random(50);
  ar2[i].y:=random(100);
  ar2[i].z:=random(50);
  ar3[i].x:=160+random(50);
  ar3[i].y:=random(100);
  ar3[i].z:=random(50);
  ar4[i].x:=160+random(50);
  ar4[i].y:=random(100);
  ar4[i].z:=random(50);
 end;

for i:=51 to 100 do
 begin
  ar1[i].x:=random(210);
  ar1[i].y:=100+random(50);
  ar1[i].z:=random(50);
  ar2[i].x:=random(210);
  ar2[i].y:=100+random(50);
  ar2[i].z:=random(50);
  ar3[i].x:=random(210);
  ar3[i].y:=100+random(50);
  ar3[i].z:=random(50);
  ar4[i].x:=random(210);
  ar4[i].y:=100+random(50);
  ar4[i].z:=random(50);
 end;

repeat
 for i:=1 to 100 do
  begin
   x:=round(ar1[i].x-ar1[i].x*ar1[i].z/51);
   y:=round(ar1[i].y-ar1[i].y*ar1[i].z/51);
   if (x<160)and(y<100)then
    begin
     ScrX:=160+x;
     ScrY:=100+y;
     putpixel(ScrX,ScrY,white);
    end;
   x:=round(ar2[i].x-ar2[i].x*ar2[i].z/51);
   y:=round(ar2[i].y-ar2[i].y*ar2[i].z/51);
   if (x<160)and(y<100)then
    begin
     ScrX:=160-x;
     ScrY:=100+y;
     putpixel(ScrX,ScrY,white);
    end;
   x:=round(ar3[i].x-ar3[i].x*ar3[i].z/51);
   y:=round(ar3[i].y-ar3[i].y*ar3[i].z/51);
   if (x<160)and(y<100)then
    begin
     ScrX:=160-x;
     ScrY:=100-y;
     putpixel(ScrX,ScrY,white);
    end;
   x:=round(ar4[i].x-ar4[i].x*ar4[i].z/51);
   y:=round(ar4[i].y-ar4[i].y*ar4[i].z/51);
   if (x<160)and(y<100)then
    begin
     ScrX:=160+x;
     ScrY:=100-y;
     putpixel(ScrX,ScrY,white);
    end;
  end;
delay(3);
    asm
    mov     dx,3dah
@VRT:
    in      al,dx
    test    al,8
    jnz     @VRT
@NoVRT:
    in      al,dx
    test    al,8
    jz      @NoVRT
    end;
 for i:=1 to 100 do
  begin
   x:=round(ar1[i].x-ar1[i].x*ar1[i].z/51);
   y:=round(ar1[i].y-ar1[i].y*ar1[i].z/51);
   if (x<160)and(y<100)then
    begin
     ScrX:=160+x;
     ScrY:=100+y;
     putpixel(ScrX,ScrY,black);
    end;
   x:=round(ar2[i].x-ar2[i].x*ar2[i].z/51);
   y:=round(ar2[i].y-ar2[i].y*ar2[i].z/51);
   if (x<160)and(y<100)then
    begin
     ScrX:=160-x;
     ScrY:=100+y;
     putpixel(ScrX,ScrY,black);
    end;
   x:=round(ar3[i].x-ar3[i].x*ar3[i].z/51);
   y:=round(ar3[i].y-ar3[i].y*ar3[i].z/51);
   if (x<160)and(y<100)then
    begin
     ScrX:=160-x;
     ScrY:=100-y;
     putpixel(ScrX,ScrY,black);
    end;
   x:=round(ar4[i].x-ar4[i].x*ar4[i].z/51);
   y:=round(ar4[i].y-ar4[i].y*ar4[i].z/51);
   if (x<160)and(y<100)then
    begin
     ScrX:=160+x;
     ScrY:=100-y;
     putpixel(ScrX,ScrY,black);
    end;
  end;

 for i:=1 to 100 do
  begin
   if ar1[i].z=0 then ar1[i].z:=50 else dec(ar1[i].z);
   if ar2[i].z=0 then ar2[i].z:=50 else dec(ar2[i].z);
   if ar3[i].z=0 then ar3[i].z:=50 else dec(ar3[i].z);
   if ar4[i].z=0 then ar4[i].z:=50 else dec(ar4[i].z);
  end;

until keypressed;

closegraph;

End.