program l2;
uses crt;
var
 a,x,b,d,h,x1,x2,s,p,e:real;
 i,n,f:byte;k:integer;
BEGIN
 clrscr;
 writeln('������ x1=');
 readln(x1);
 writeln('������ x2=');
 readln(x2);
 writeln('������ 蠣 h=');
 readln(h);
 writeln('������ �筮��� e=');
 readln(e);
 x:=x1;
while x<=x2 do
 Begin
  n:=0;
  s:=0;
  k:=1;
  p:=1;
 if x<>0 then
 Begin
  REPEAT
   a:=(2*n+1);
    for i:=1 to (2*n) do
     a:=a*i;
   d:=k*x/abs(x)*(exp((2*n+1)*ln(abs(x))))/a;
   if n<=10 then
    p:=p*d;
   s:=s+d;
   n:=n+1;
   k:=-k;
 UNTIL abs(d)<e;
  b:=sin(x);
  writeln('�㬬� ������⮢ p鸞 p���� ',s);
  writeln('���祭�� �p���p�筮� �㭪樨 p���� ',b);
  writeln('�p���������� ����� ��p��� ������⮢ p鸞 p���� ',p);
 End
  else
  Begin
   writeln('�㬬� ������⮢ p鸞 p���� 0');
   writeln('���祭�� �p���p�筮� �㭪樨 p���� 0');
   writeln('�p���������� ����� ��p��� ������⮢ p鸞 p���� 0');
  End;
  readln;
  x:=x+h;
 End;
END.
