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
 Writeln('������ m :');
 readln(m);
 Writeln(t,'�������������������������������������������������ͻ');
 Writeln(t,'�    W    � Fp,�p�  �Fp��,�p� �   �p    �   �p��  �');
 Writeln(t,'�������������������������������������������������͹');
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
  Writeln(t,'�',W:9:4,'�',Fp/pi*180:9:4,'�',Fpaz/pi*180:9:4,'�',Ap:9:4,'�',Apaz:9:4,'�');
 until W>=0.05;
 Writeln(t,'�������������������������������������������������ͼ');
 Close(t);
end.