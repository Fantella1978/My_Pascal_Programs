Program laba26;
uses crt;
const
  r=0.02;
  a=35.27e-8;
  bi=1.7697;
  Tsr=953;
  T0=295;
var qp,qv,tv,tp:real;
    t:integer;
    f0:real;
begin
 repeat
  Write('������ t (c) : ');readln(t);
  F0:=a*t/sqr(r);
  writeln('������ 0p �� F0=',f0:6:4,' � Bi=',bi:6:4);readln(qp);
  Tp:=Tsr-Qp*(Tsr-T0);
  writeln('������ 0v �� F0=',f0:6:4,' � Bi=',bi:6:4);readln(qv);
  Tv:=Tsr-Qv*(Tsr-T0);
  writeln(' Tp (t=',t,') = ',Tp:6:2);
  writeln(' Tv (t=',t,') = ',Tv:6:2);
 until 2=1;
end.