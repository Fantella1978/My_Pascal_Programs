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
 Writeln(t,' pจ  m = 0.272');
 writeln(t,'ษอออออออออออัอออออออออออัอออออออออออัอออออออออออัอออออออออออป');
 writeln(t,'บ     X     ณ     A     ณ     Y     ณ     E     ณ     S     บ');
 writeln(t,'ฬอออออออออออุอออออออออออุอออออออออออุอออออออออออุอออออออออออน');
 repeat
  x:=x+0.05;
  A:=-pi/2+x-arctan((1-m*F*x)/(F*x));
  c:=sin(a)/cos(a);
  y:=(m*c-1)/(c*(1+sqr(m)));
  b:=1/(y*(1+sqr(m)));
  e:=sqrt(sqr(1-m*f*x)+sqr(f*x))/(sqrt(sqr(1-m*b)+sqr(b)))*exp(-m*x);
  s:=e*x/y;
  writeln(t,'บ',x:10:4,' ณ',a:10:6,' ณ',y:10:4,' ณ',E:10:4,' ณ',s:10:6,' บ');
 until a>0;
 writeln(t,'ศอออออออออออฯอออออออออออฯอออออออออออฯอออออออออออฯอออออออออออผ');
 close(t);
end.


