uses crt;
var
y1,y2,a,b,c,e:real;
x,k:real;
 FUNCTION f(x:real):real;
   begin
   f:=1-x+sin(x)-ln(1+x)
   end;
BEGIN
clrscr;
writeln('������ � ��砫쭮�');
readln(a);
writeln('������ � ����筮�');
readln(b);
writeln('�筮��� �');
readln(e);
writeln('-----------------��⮤ ����������� �������---------------------------');
y1:=a;
y2:=b;
repeat
 c:=(a+b)/2;
 if (f(c)*f(a))>0 then a:=c
                  else b:=c;
until abs(b-a)<e;
writeln('��७� ࠢ�� ',c:15:10);
writeln('-----------------��⮤ ���⥫���(�������)----------------------------');
x:=y1;
b:=y2;    f:=1-x+sin(x)-ln(1+x)
if ((1/sqr(1+x)-sin(x))*f(x))<=0 then x:=b;
repeat
 if (cos(x)-1-1/(1+x))<0.0000000001 then break;
 c:=x-f(x)/(cos(x)-1-1/(1+x));
 b:=c-x;
 x:=c;
until abs(b)<sqrt(e);
writeln('��७� ࠢ�� ',c:15:10);
writeln('------------------��⮤ ���樨----------------------------------------');
a:=y1;
repeat
c:=a;
a:=1+sin(c)-ln(1+c);
until abs(c-a)<e;
writeln('��७� ࠢ�� ',c:15:10);
end.