{Апроксимация функции,метод наименьших квадратов}
Program toe2;
uses crt;
var min,max,A1,A2,A3,A4,A5,A6,b0,b1,x,y,f1,f0:REAL;
    n,i:integer;
    e:array[1..100] of real;
const
   masy:array[1..18]of real=(85,90,95,100,104,108,110,112,118,121,125,127,130,131,131,132,133,133);
   masx:array[1..18]of real=(0,15,30,45,60,75,90,105,120,135,150,165,180,195,210,225,240,255);

BEGIN
 write('Введите N : ');readln(n);
 a1:=0;a2:=0;a3:=0;a4:=0;a5:=0;a6:=0;
 for i:=1 to n do
  begin
   writeln;
{   write('X = ');readln(x);
 }  x:=masx[i];
{   write('Y = ');readln(y);
 }  y:=masy[i];
   f0:=1;
   f1:=x;
   a1:=a1+y*f0/n;a2:=a2+f1*f1/n;a3:=a3+y*f1/n;
   a4:=a4+f0*f1/n;a5:=a5+f0*f0/n;a6:=a6+f1*f1/n;
  end;
 y:=a5*a6-a4*a4;
 b0:=(a1*a2-a3*a4)/y;
 b1:=(a5*a3-a4*a1)/y;
 writeln('******************************************');
 writeln('B0 = ',b0:10:4);
 writeln('B1 = ',b1:10:4);
 write('F(x) = ',b0:10:4);
 if b1<0 then writeln(b0:10:4,' X')
         else writeln('+',b1:10:4,' X');
 min:=1000000;
 max:=-1000000;
 for i:=1 to n do
  begin
   e[i]:=masy[i]-b0-b1*masx[i];
   if e[i]<min then min:=e[i];
   if e[i]>max then max:=e[i];
  end;
 writeln(' E min = ',min:10:4);
 writeln(' E max = ',max:10:4);
 repeat until readkey<>'';
END.