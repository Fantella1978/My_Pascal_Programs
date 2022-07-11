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
    str(7-i,st);
    OutTextXY(0,20+i*40,st);
  end;
For i:=1 to 10 do
  begin
    str(6-i,st);
    OutTextXY(416-i*40,440,st);
  end;
SetColor(Red);
OutTextXY(200,325,'y=x*x - Red');
SetColor(Green);
OutTextXY(200,345,'y=1/(x+2) - Green');
SetColor(Blue);
OutTextXY(200,365,'y=1/sqrt(sqrt((x+2)) - Blue');
SetColor(3);
Line(20,420,20,20);
Line(20,420,620,420);
Line(20,20,23,28);
Line(20,20,17,28);
Line(620,420,612,417);
Line(620,420,612,423);
x_end:=180;
y_end:=300;
 for j:=1 to 10 do
   begin
     for i:=1 to 100 do
       begin
         Delay(50);
         if j=4 then SetColor(14) else SetColor(15);
         Line(18+i*6,460-40*j,18+i*6,460-40*j);
         SetColor(Black);
         if j=3 then SetColor(14) else SetColor(15);
         Line(20+40*j,20+i*4,20+40*j,20+i*4);
         SetColor(3);
       end;
   end;

SetColor(Green);
For x:=-3 to 3 do
  begin
    if (x<-2)and(x>-4) then
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
        Delay(2000);
        SetColor(0);
        OuttextXY(10,10,st);
        OuttextXY(100,10,st2);
      end;
    end;
Delay(10000);

SetColor(Blue);
    if (x>-2)and(x<=0) then
    begin
    for i:=1 to 499 do
      begin
        SetColor(Blue);
        y:=1/(sqrt(sqrt((x+i/500)+2)));
        Putpixel(x_end+round((x+i/500)*40),y_end-round(y*40),Blue);
        Line(x_end+round(round(x*i)/25),y_end-round(round(y*i)/25),x_end+round(round(x*i)/25),y_end-round(round(y*i)/25));
        str(y*i/1000:2:2,st);
        st:='Y= '+st;
        st2:='X= '+st2;
        str(x*i/1000:2:2,st2);
        OuttextXY(10,10,st);
        OuttextXY(100,10,st2);
        Delay(2000);
        SetColor(0);
        OuttextXY(10,10,st);
        OuttextXY(100,10,st2);
      end;
    end;

SetColor(Red);
    if X>0 then
    begin
    for i:=1 to 1000 do
      begin
        Delay(50);
        y:=round((x*x))*i/1000;
        Line(x_end+round(round(x*i)/25),y_end-round(round(y*i)/25),x_end+round(round(x*i)/25),y_end-round(round(y*i)/25));
      end;
    end;

  end;
Readln;
CloseGraph;
end.