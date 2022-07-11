uses crt;
const
  TauOb=27; TOb=100; KOb=7.1;
  Kp=0.43;  Ti=50.5;
var
 m,B,w,Fp,Fpaz,Ap,Apaz,Aob,Fob:real;
 t:text;
begin
 Assign(t,'Tau_afh.txt');
 rewrite(t);
 Writeln('ขฅคจโฅ m :');
 readln(m);
 Writeln(t,'ษอออออออออัอออออออออัอออออออออัอออออออออัอออออออออป');
 Writeln(t,'บ    W    ณ Fp,ฃpค  ณFp ง,ฃpค ณ   €p    ณ   €p ง  บ');
 Writeln(t,'ฬอออออออออุอออออออออุอออออออออุอออออออออุอออออออออน');
 W:=0.005;
 repeat
  W:=W+0.001;
  B:=1/(Ti*W*(1+m*m));
  Fp:=-pi/2+arctan((1-m*B)/B);
  Ap:=Kp*sqrt(sqr(1-m*B)+sqr(B));
  Fob:=-pi/2-W*TauOb+arctan((1-Tob*W*m)/(Tob*W));
  Aob:=Kob*exp(m*W*TauOb)/sqrt(sqr(Tob*W)+sqr(1-m*Tob*W));
  Fpaz:=Fp+Fob;
  Apaz:=Ap*Aob;
  Writeln(t,'บ',W:9:4,'ณ',Fp/pi*180:9:4,'ณ',Fpaz/pi*180:9:4,'ณ',Ap:9:4,'ณ',Apaz:9:4,'บ');
 until W>=0.05;
 Writeln(t,'ศอออออออออฯอออออออออฯอออออออออฯอออออออออฯอออออออออผ');
 Close(t);
end.