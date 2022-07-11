USES CRT;     var
      x,g,x1,a,b,e:real;
      i,n:longint;
     function y(x:real):real;
      Begin
       y:=0.25*x*x*x+x-1.2502;
      End;
     function v(x:real):real;
      Begin
       v:=0.75*x*x+1
      End;
    BEGIN
     clrscr;
     e:=0.01;
       g:=1;
       while abs(g)>e do
        Begin
         g:=v(x1);
         g:=y(x1)/g;
         x1:=x1-g;
        End;
         g:=y(x);
         writeln('       Значение коpня тpансцендентного уpавнения');
         writeln('       вычисленного методом касательных pавно');
         writeln('                     ',x1:10:9);
         readln;
    END.
