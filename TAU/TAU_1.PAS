uses crt;
const
  m=0;
  f=100/27;
var
  x,a,c,y,b,e,s:real;
  t:text;
begin
 assign(t,'tau_2.txt');
 rewrite(t);
 clrscr;
 x:=0;
 Writeln(t,' �p�  m = 0.272');
 writeln(t,'�����������������������������������������������������������ͻ');
 writeln(t,'�     X     �     A     �     Y     �     E     �     S     �');
 writeln(t,'�����������������������������������������������������������͹');
 repeat
  x:=x+0.05;
  A:=-pi/2+x-arctan((1-m*F*x)/(F*x));
  c:=sin(a)/cos(a);
  y:=(m*c-1)/(c*(1+sqr(m)));
  b:=1/(y*(1+sqr(m)));
  e:=sqrt(sqr(1-m*f*x)+sqr(f*x))/(sqrt(sqr(1-m*b)+sqr(b)))*exp(-m*x);
  s:=e*x/y;
  writeln(t,'�',x:10:4,' �',a:10:6,' �',y:10:4,' �',E:10:4,' �',s:10:6,' �');
 until a>0;
 writeln(t,'�����������������������������������������������������������ͼ');
 close(t);
end.


