Program B_3;{�襭�� �ࠢ����� ��⮤ �����������}
            {�������}
Var x,a,b,e,y1,y2,y3:real;

Function  f(x:real):real;
begin
 f:=sqr(x)+exp(-x)-2;              {�㭪�� F(x)}
end;

BEGIN
 a:=1;                  {������ ��砫� ���ࢠ��}
 b:=2;                   {������ ����� ���ࢠ��}
 e:=0.0001;                  {������ ����譮���}
 y1:=f(a); y2:=f(b);
 if y1*y2>0 then exit;   {�� ���ࢠ�� ���� ���}
 Repeat
  x:=(a+b)/2;     {��।������ �।��� ���ࢠ��}
  y3:=f(x);
  if y1*y3<0
   then b:=x      {��।������ ��� � � ��� �}
   else
    begin
     a:=x;y1:=y3; {��।������ ��� � � ��� �}
    end
 Until abs(f(x))<=e;
writeln('K�७� �ࠢ����� ࠢ�� : ',x:10:4);
END.