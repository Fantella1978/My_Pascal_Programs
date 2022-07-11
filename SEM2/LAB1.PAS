uses crt;
const
 b:array[1..4] of real=(2,2.3,2.7,3);
var
 a,c,a1,a2,c1,c2,ha,hc,y,k,f,g:real;
 i,w:integer;
BEGIN
 clrscr;
 write('Введите a1=');
 readln(a1);
 write('Введите a2=');
 readln(a2);
 write('Введите c1=');
 readln(c1);
 write('Введите c2=');
 readln(c2);
 write('Введите шаг ha=');
 readln(ha);
 write('Введите шаг hc=');
 readln(hc);
 clrscr;
 a:=a1;
 while a<=a2 do
  Begin
   for i:=1 to 4 do
    Begin
     c:=c1;
     while c<=c2 do
      Begin
       k:=sqr(a)-b[i]*c;
       if k<>0 then
        Begin
         f:=sqr(a)*sin(b[i])+sqr(b[i])*sin(a);
          if f<>0 then
           g:=f/abs(f)*exp(ln(abs(f))/3)
          else
           y:=0;
           y:=g/k;
           textcolor(10);
           writeln('                       При a=',a:5:4);
           writeln('                       При b=',b[i]:5:4);
           writeln('                       При c=',c:5:4);
           writeln('                          y=',y:5:4);
        End
       else
        Begin
        textcolor(26);
        writeln('                       При a=',a:5:4);
        writeln('                       При b=',b[i]:5:4);
        writeln('                       При c=',c:5:4);
        writeln('                       Hет значения !!!');
        writeln;
        End;
      c:=c+hc;
      End;
      readln;
      clrscr;
    End;
 a:=a+ha
 End;
 textcolor(7);clrscr;
END.

