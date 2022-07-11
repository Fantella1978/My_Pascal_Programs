
     program lab6_slav ;
    uses crt;
     var y3, p1,x2,y2,x1,y1,m,q, p0,p,x0,y0,x,y,h,xk,k1,k2,k3,k4:real;
         k11,k12,k21,k22,k31,k32,k41,k42:real;
     i:integer;
     procedure nahc;
   begin
     clrscr;
     gotoxy(12,10);
     writeln('     Žƒ€ŒŒ€ ”ˆ‹€’Ž‚€ ‘…ƒ…Ÿ           ');
     writeln('                 £àã¯¯  Œ€-96/2          ');
     readkey;
    end;
     procedure konec;
   begin
    clrscr;
     gotoxy(12,10);
     writeln('   ****   Žƒ€ŒŒ€     ‡€‚…˜…€   ****        ');
     readkey;
   end;
     {---------------------------------------------------}
   function f(x,y:real):real;
         var z :real;
      begin
       z:=(x+cos(y))*y;
        f:=z
        end;

          function z(x2,y2:real):real;
         var z1 :real;
      begin
       z1:=exp(3*x2)*(13*x2-7)-4*y2;
       z:=z1;
        end;

       {------------------- telo ------------------------------}

         begin
      nahc;
     clrscr;
     writeln('   ¢¢¥¤¨â¥ x0,y0,xk,h');
     read(x0,y0,xk,h);
      x:=x0; y:=y0;
     x1:=x0; y1:=y0;q:=200;h:=h/q;
   repeat
   begin
      y:=y+h*f(x,y);    {--Œ…’Ž„ ‰‹…€ 1--}
      k1:=h*f(x1,y1);
      k2:=h*f(x1+h/2,y1+k1/2);    {--Œ…’Ž„ “ƒ…-Š“’’€ 1--}
      k3:=h*f(x1+h/2,y1+k2/2);
      k4:=h*f(x1+h,y1+k3);
      y1:=y1+1/6*(k1+2*k2+2*k3+k4);
      if q=m then
       begin
       m:=0;
        write('x=',x:10:6,'  y=',y:10:6);
      write(' y1=',y1:10:6);
      writeln;
      end;
       x1:=x1+h;
       x:=x+h;
       m:=m+1;
    end;
   until x>xk+0.000001;
   readkey;
   clrscr;
   {----------------------------}
   writeln('   ¢¢¥¤¨â¥ x0,y0,xk,h');
     read(x0,y0,xk,h);
    p0:=-4;
    x:=x0; y:=y0;p1:=p0;p:=p0;
    x1:=x0; y1:=y0 ;
    x2:=x0; y2:=y0 ;
   q:=200;h:=h/q;m:=0;
   repeat
   begin
      y1:=y1+h*p1;              {--Œ…’Ž„ ‰‹…€ 2--}
      p1:=p1+h*z(x1,y1);
      y3:=cos(2*x)-sin(2*x)+exp(3*x)*(x-1);    {--Ž‚. ”ŽŒ“‹€--}
     k11:=h*p;                  {--Œ…’Ž„ “ƒ…-Š“’’€ 2--}
     k12:=h*z(x2,y2);
     k21:=h*(p+k12/2);
     k22:=h*z(x2+h/2,y2+k11/2);
     k31:=h*(p+k22/2);
     k32:=h*z(x2+h/2,y2+k21/2);
     k41:=h*(p+k32);
     k42:=h*z(x2+h/2,y2+k31);
     y2:=y2+1/6*(k11+2*k21+2*k31+k41);
     p:=p+1/6*(k12+2*k22+2*k32+k42);
      if q=m then
       begin
       m:=0;
     write( 'x=',x:6:4,'  y1=',y1:10:6,'  y2=',y2:10:6,'  y3=',y3:10:6);
     writeln;
     end;
     x2:=x2+h;
     x:=x+h;
     m:=m+1;
   end;
   until x>xk+0.000001;
        readkey;
   { konec }
 end.

