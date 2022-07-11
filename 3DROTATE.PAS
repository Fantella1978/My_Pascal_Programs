 uses graph,crt;

const fant:array[1..116]of integer=(-80,-40,-80,40,
                                   -80,0,-70,0,
                                   -80,40,-65,40,
                                   -60,40,-45,40,
                                   -60,-20,-45,-20,
                                   -60,40,-60,-40,
                                   -45,40,-45,-40,
                                   -40,40,-40,-40,
                                   -40,0,-25,-40,
                                   -25,40,-25,-40,
                                   -20,40,0,40,
                                   -10,40,-10,-40,
                                   5,40,20,40,
                                   5,-40,20,-40,
                                   5,40,5,-40,
                                   20,40,20,-40,
                                   25,40,25,-40,
                                   25,0,32,-30,
                                   40,0,33,-30,
                                   40,40,40,-40,
                                   45,40,45,-40,
                                   45,40,60,40,
                                   45,-20,60,-20,
                                   60,40,60,-40,
                                   65,40,80,40,
                                   65,40,65,0,
                                   65,-40,80,-40,
                                   65,0,80,0,
                                   80,0,80,-40);


type coord=record
     x,y,z:real;
     end;
     coordxy=record
     x,y:integer;
     end;

var gd,gm,i,k,n,x1,y1,z1,xx,yy:integer;
    q,w,e,Xan,Yan,Zan,Xt,Yt,Zt,x,y,z:real;
    ar:array[1..58]of coord;
    ar1:array[1..58] of coordxy;

Procedure pix3d(var x,y,z:real);
begin

    Yt := Y*COS(Xan) - Z*SIN(Xan);
    Zt := Y*SIN(Xan) + Z*COS(Xan);
    Y := Yt;
    Z := Zt;

    Xt  := X*COS(Yan) - Z*SIN(Yan);
    Zt  := X*SIN(Yan) + Z*COS(Yan);
    X   := Xt;
    Z   := Zt;

    Xt  := X*COS(Zan) - Y*SIN(Zan);
    Yt  := X*SIN(Zan) + Y*COS(Zan);
    X   := Xt;
    Y   := Yt;

    ar1[n].x:=round(2*(x+x*z/640)+320);
    ar1[n].y:=round(240-2*(y+y*z/480));

end;


BEGIN
 gd:=detect;
 initgraph(gd,gm,'');
 x1:=30;y1:=50;z1:=40;
 x:=x1;y:=y1;z:=z1;

 randomize;
 for i:=1 to 50 do
  begin
   ar[i].x:=random(180);
   ar[i].y:=random(180);
   ar[i].z:=random(180);
  end;
 for i:=1 to 50 do
  begin
   ar[i].x:=ar[i].x-90;
   ar[i].y:=ar[i].y-90;
   ar[i].z:=ar[i].z-90;
  end;

 for i:=1 to 58 do
  begin
   ar[i].x:=0;
   ar[i].y:=0;
   ar[i].z:=50;
  end;
 for i:=1 to 58 do
  begin
   ar[i].x:=fant[i*2-1];
   ar[i].y:=fant[i*2];
  end;

    Xan:=2*3.14/180;
    yan:=0*3.14/180;
    zan:=0*3.14/180;

 setlinestyle(0,0,3);
 for i:=1 to 1000 do
  begin
    for n:=1 to 58 do pix3d(ar[n].x,ar[n].y,ar[n].z);
    setcolor(white);
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
    for n:=1 to 29 do line(ar1[n*2-1].x,ar1[n*2-1].y,ar1[n*2].x,ar1[n*2].y);
    setcolor(black);
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
    for n:=1 to 29 do line(ar1[n*2-1].x,ar1[n*2-1].y,ar1[n*2].x,ar1[n*2].y);
    if keypressed then if readkey=#27 then exit;
 end;
 closegraph;

END.
