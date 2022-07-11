Program iso;
   uses Graph,Crt;
   var h,l,y_gr: Real;
       y:Extended;
       i,j,y_gi,x,ii,x_end,y_end,errST: Integer;
       st2,st: String;
       grDriver,grMode,errCode: Integer;
       grPath: String;

begin
grDriver:=VGA;
grMode:=VGAhi;
grPath:='c:\tp-7\bgi';
InitGraph(grDriver,grMode,grPath);
ErrCode:=GraphResult;
{setka}
For i:=1 to 10 do
  begin
    str(5-i,st);
    OutTextXY(0,20+i*40,st);
  end;
For i:=1 to 20 do
  begin
    str(11-i,st);
    OutTextXY(656-i*40,428,st);
  end;
SetColor(Red);
OutTextXY(200,325,'y=x*x - Red X(0;4)');
SetColor(Green);
OutTextXY(200,345,'y=1/(x+2) - Green X(-4;-2)');
SetColor(Blue);
OutTextXY(200,365,'y=1/sqrt(sqrt((x+2)) - Blue X(-2;0]');
SetColor(3);
Line(20,420,20,20);
Line(20,420,620,420);
Line(20,20,23,28);
Line(20,20,17,28);
Line(620,420,612,417);
Line(620,420,612,423);
x_end:=220;
y_end:=220;
 for j:=1 to 15 do
   begin
     for i:=1 to 100 do
       begin
         Delay(50);
         if j=6 then SetColor(14) else SetColor(15);
         Line(18+i*6,460-40*j,18+i*6,460-40*j);
         SetColor(Black);
         if j=5 then SetColor(14) else SetColor(15);
         Line(20+40*j,20+i*4,20+40*j,20+i*4);
         SetColor(3);
       end;
   end;

For x:=-4 to 4 do
  begin
    if (x>=-4)and(x<-2) then
    begin
    for i:=1 to 499 do
      begin
        Setcolor(Green);
        y:=1/((x+i/500)+2);
        Putpixel(x_end+round((x+i/500)*40),y_end-round(y*40),Green);
        str(y:2:2,st);
        st:='Y= '+st;
        str(x+i/500:2:2,st2);
        st2:='X= '+st2;
        OuttextXY(10,10,st);
        OuttextXY(100,10,st2);
        Delay(500);
        SetColor(0);
        OuttextXY(10,10,st);
        OuttextXY(100,10,st2);
      end;
    end;
Delay(10000);
SetColor(Blue);
    if (x>=-2)and(x<0) then
    begin
    for i:=1 to 499 do
      begin
        y:=1/sqrt(sqrt(x+i/500+2));
        Putpixel(x_end+round((x+i/500)*40),y_end-round(y*40),Blue);
        str(y:2:2,st);
        st:='Y= '+st;
        str(x+i/500:2:2,st2);
        st2:='X= '+st2;
        SetColor(Blue);
        OuttextXY(10,10,st);
        OuttextXY(100,10,st2);
        Delay(500);
        SetColor(0);
        OuttextXY(10,10,st);
        OuttextXY(100,10,st2);
      end;
    end;
Delay(10000);

    if (X>=0)and(x<4) then
    begin
    for i:=1 to 499 do
      begin
        y:=(x+i/500)*(x+i/500);
        Putpixel(x_end+round((x+i/500)*40),y_end-round(y*40),Red);
        str(y:2:2,st);
        st:='Y= '+st;
        str(x+i/500:2:2,st2);
        st2:='X= '+st2;
        SetColor(Red);
        OuttextXY(10,10,st);
        OuttextXY(100,10,st2);
        Delay(500);
        SetColor(0);
        OuttextXY(10,10,st);
        OuttextXY(100,10,st2);
      end;
    end;
  end;
Readln;
CloseGraph;
end.