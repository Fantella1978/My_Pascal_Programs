    program lab3;
     uses crt;
     var
      x,d,g,f,k,h,l,x1,x2,a,b,e:real;
      i,n:longint;
     function y(x:real):real;
      Begin
       y:=x+sqrt(x)+exp(ln(abs(x))/3)-2.5;
      End;
     function z(x:real):real;
      Begin
       z:=-sqrt(x)-exp(ln(abs(x))/3)+2.5;
      End;
     function v(x:real):real;
      Begin
       v:=1+1/(2*sqrt(x))+1/(3*sqr(exp(ln(abs(x))/3)));
      End;
    BEGIN
     textcolor(10);
     clrscr;
     a:=0.4;b:=1;e:=0.0001;n:=1;
     x:=a;d:=y(x);l:=d;
     x:=b;d:=y(x);h:=d;
     while abs(a-b)>e do
      Begin
       x:=(a+b)/2;
       d:=y(x);
        if d*h>0 then
          Begin
           b:=x;
           h:=d;
          End
        else
          Begin
           a:=x;
           l:=d;
          End;
       End;
       writeln('       ���祭�� ��p�� �p���業���⭮�� �p�������');
       writeln('       ���᫥����� ��⮤�� ����������� ������� ');
       writeln('       p����         ',x:6:4);
       readln;
       g:=1;x1:=0.8;
       while abs(g)>e do
        Begin
         g:=v(x1);
         g:=y(x1)/g;
         x1:=x1-g;
        End;
         g:=y(x);
         writeln('       ���祭�� ��p�� �p���業���⭮�� �p�������');
         writeln('       ���᫥����� ��⮤�� ���⥫��� p����');
         writeln('                     ',x1:6:4);
         readln;
         writeln('       ������ �ந��������� ���祭�� ����');
         readln(x2);
         x2:=z(x);
         b:=x2-x;
         k:=b;
         l:=b;
          for i:=1 to n do
           Begin
            l:=z(x2)-x2;
            if abs(l)<abs(d)*e then
             Begin
              writeln('       ����讥 �᫮ ���権');readln;
              exit;
             End;
             h:=b/l;b:=l;
              if h=1 then
               Begin
                writeln('      ������� �� ����');
                exit;
               End;
              k:=k/(h-1);
              x2:=x2+k;
           End;
            writeln('       ���祭�� ��p�� �p���業���⭮�� �p�������');
            writeln('          ���᫥����� ��⮤�� ��p�権 p����');
            writeln('                     ',x2:6:4);
            readln;
            textcolor(7);clrscr;
    END.
