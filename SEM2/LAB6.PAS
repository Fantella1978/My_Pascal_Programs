  program lab6;
   uses crt;
   function z(x,p,y:extended):extended;
    Begin
     z:=2*exp(-x)*cos(x)-2*p-2*y;
    End;
     function f(x,y:extended):extended;
  begin
  f:=x*sqr(y)+1;
  end;
    var
     h,k1,p,p1,k2,k11,x2,k33,k44,k22,k3,k4,x,x1,y0,y,y1,y2,l,l1,l2:extended;
     j,n:longint;i:integer;
     begin
    clrscr;
    textcolor(10);
    for i:=1 to 10 do
    writeln;
    writeln('                   ��᫥���� ����७�஢���� ��������');
    writeln('                    ����७樠���� �ࠢ����� ��⮤���');
    writeln('                           ����� � �㭣�-����        ');
    readln;
    clrscr;
    for i:=1 to 10 do
    writeln;
    writeln('                    �ணࠬ�� ��⠢�� ��㤥�� ��㯯�  ');
    writeln('                               ��-96-1                 ');
    writeln('                       ������ ����ᥩ ����ᠭ�஢��    ');
    readln;
    clrscr;
    {------��⮤ �㭣�-����(1)---------------------------------------}
    x:=1;y:=-1;h:=0.1; x1:=1;y1:=-1;h:=0.1;
    for i:=1 to 7 do
     writeln;
    writeln('           X          ��⮤ ����p� 1         ��⮤ �㭣�-���� 1');
    repeat
    k1:=h*f(x,y);
    k2:=h*f(x+h/2,y+k1/2);
    k3:=h*f(x+h/2,y+k2/2);
    k4:=h*f(x+h,y+k3);
    y0:=y+(k1+2*k2+2*k3+k4)/6;
    x:=x+h;
    {------��⮤ �����(1)---------------------------------------}
    y:=y1+h*f(x,y1);
    y1:=y;
    writeln('        ',x1:6:2,'          ',y1:8:5,'                 ',y0:8:5);
    x1:=x1+h;
    until round(x1*10)>20;
    readln;
    clrscr;
          {------��⮤ �㭣�-����(2)---------------------------------------}
     k1:=0;k2:=0;k3:=0;k4:=0;
     x1:=0;x2:=0.5;y1:=1;p1:=0;h:=0.05;
     x:=x1;y:=y1;p:=p1;
     for i:=1 to 7 do
     writeln;
     writeln('           X      �p���p��      ��⮤ ����p� 2       ��⮤ �㭣�-���� 2');
      repeat
       k1:=h*p;
       k11:=h*z(p,x,y);
       k2:=h*(p+k11/2);
       k22:=h*z(p+k11/2,x+h/2,y+h/2*(p+k11/4));
       k3:=h*(p+k22/2);
       k33:=h*z(p+k22/2,x+h/2,y+h/2*(p+k11/4));
       k4:=h*(p+k33/2);
       k44:=h*z(p+k33/2,x+h/2,y+h*p+h/2*k3);
       y:=y+1/6*(k1+2*k2+2*k3+k4);
       p:=p+1/6*(k11+2*k22+2*k33+k44);

         {------�ࢥઠ---------------------------------------}
       y2:=exp(-x)*(cos(x)+sin(x)+x*sin(x));

         {------��⮤ �����(2)---------------------------------------}
         y0:=y1+h*p1;
         p:=p1+h*z(x,p1,y1);
         y1:=y0;
         p1:=p;
         writeln('        ',x:6:2,'     ',y2:6:5,'          ',y0:6:5,'               ',y:6:5);
         x:=x+h;
        until round(x*100)>x2*100;
        readln;
     End.




















