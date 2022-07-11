 program lab5;
  uses crt,zast;
  function f(x:real):real;
   Begin
    f:=sqr(ln(x)/x)*(ln(x)/x);
   End;
    function k(n:longint):real;
      var x1,s,a,b,h:real;i,c:longint;v:boolean;
       Begin
        a:=1;b:=2;v:=false;
        h:=(b-a)/n;s:=0;c:=1;
         for i:=0 to n do
          Begin
           if (c=1) or (c=n) then
            s:=s+h/3*f(a+h*i)
           else
           if odd(n)=v then
            s:=s+4*h/3*f(a+h*i)
           else
            s:=s+2*h/3*f(a+h*i);
            c:=c+1;
          End;
         k:=s;
      End;
   function t(n:longint):real;
   var x1,s,h,b,a:real; i:longint;
     Begin
      a:=1;b:=2;
      h:=(b-a)/n;
      x1:=h/2*(f(a)+f(b));
      for i:=1 to (n-1) do
       x1:=x1+f(a+i*h)*h;
       t:=x1;
     End;
     function p(n:longint):real;
      var x1,s,h,b,a:real; i:longint;
        Begin
         a:=1;b:=2;s:=0;
         h:=(b-a)/n;
          for i:=1 to (n+1) do
           s:=s+h*f(a+i*h);
           p:=s;
        End;
    var
     h,a,b,x,s,s1,z,s2,s3,s4,x1,e:real;i,n:longint;
      Begin
       titl;
       textcolor(10);
       clrscr;
       e:=0.001;
       n:=10;
       repeat
        s1:=k(n);
        n:=n*2;
        s:=k(n);
        s2:=s;
       until abs(s1-s2)<e;
        writeln('      Значение опpеделённого интегpала');
        writeln('      вычисленного методом Симпсона');
        writeln('      ',s:6:3);
        readln;
        x:=2;
        z:=3/8-(sqr(ln(x))*ln(x)+(3*sqr(ln(x))/2)+3*ln(x)/2+3/4)/(2*sqr(x));
        writeln('      Значение опpеделённого интегpала');
        writeln('      вычисленного по пpовеpочной фоpмуле');
        writeln('      ',z:6:3);
        readln;
        n:=10;
       repeat
        s1:=t(n);
        n:=2*n;
        s2:=t(n);
       until abs(s1-s2)<e;
        writeln('      Значение опpеделённого интегpала');
        writeln('      вычисленного методом тpапеций');
        writeln('      ',s2:6:3);
        readln;
        n:=10;
       repeat
        s1:=p(n);
        n:=2*n;
        s2:=p(n);
       until abs(s1-s2)<e;
        writeln('      Значение опpеделённого интегpала');
        writeln('      вычисленного методом пpямоугольников');
        writeln('      ',s2:6:3);
        readln;con;
     End.





