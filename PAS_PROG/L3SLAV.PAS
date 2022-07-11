 program lab3;
 uses crt;
 var  s,c,x,d,h,l,a,b,e:real;
     f1,f2,x1:real;
     x2,k:real;
    i,n:integer;
 function y(x:real):real;
    begin
    y:=0.25*x*x*x+x-1.2502
    end;
 function z(x:real):real;
    begin
    z:=(0.6*exp(x*ln(3))-3)/2.3
    end;
 begin
  clrscr;
  writeln('        Программа Филатова Вячеслава');
  writeln;
  a:=-1;b:=7;e:=0.00001;n:=4;
  x:=a;d:=y(x);l:=d;
  x:=b;d:=y(x);h:=d;
     while abs(a-b)>e do
       begin
        x:=(a+b)/2;
        d:=y(x);
         if d*h>0 then
          begin
           b:=x;h:=d
          end
         else
         begin
          a:=x;l:=b
         end;
       end;
  writeln('метод половинного деления x=',x:6:4);
  writeln('-------------------------------------');
    d:=0;x:=a;
    f1:=y(x);x:=b;f2:=y(x);
      repeat
      x1:=x;
      x:=a-f1*(a-b)/(f1-f2);
      d:=y(x);
       if (f1>0) and (d>0) then
        begin
         a:=x;f1:=d
        end
       else
        begin
         b:=x;f2:=d
        end;
       until abs(x-x1)<e;
   writeln('метод хорд  x=',x1:6:4);
   writeln('-----------------------------------');
 x2:=a;
  repeat
   s:=x2;
   c:=z(s);
   x2:=c;
  until x2-s<e ;
writeln('метод итераций  x=',x2:6:4);
 readkey
 end.
