uses crt;
const
  TauOb=27; TOb=100; KOb=7.1;
  Kp=0.43;  Ti=50.5; D=15;
var
  T,A,h,y1,y2,y5:real;
  i,k:integer;
  X:array[1..42]of real;
  t1:Text;
begin
 Assign(t1,'Tau_x.txt');
 Rewrite(t1);
 h:=TauOb/40;
 A:=TauOb*20;
 T:=0; y2:=0;
 y1:=Kp*D; y5:=y1;
 For i:=1 to 42 do X[i]:=0;
 Writeln(t1,'浜様様様様冤様様様様冤様様様様冤様様様様冤様様様様�');
 Writeln(t1,'�    T    �    X    �    Y1   �    Y2   �    Y5   �');
 Writeln(t1,'麺様様様様慷様様様様慷様様様様慷様様様様慷様様様様�');
 repeat
  Writeln(t1,'�',T:9:4,'�',X[1]:9:4,'�',Y1:9:4,'�',Y2:9:4,'�',Y5:9:4,'�');
  for k:=1 to 10 do
   begin
    X[42]:=X[41]+h*(KOb*Y5-X[41])/TOb;
    Y1:=Kp*(D-X[2]);
    Y2:=Y2+Kp*h*(D-X[1])/Ti;
    Y5:=Y1+Y2;
    For i:=1 to 41 do X[i]:=X[i+1];
   end;
  T:=T+10*h;
 until T>A;
 Writeln(t1,'藩様様様様詫様様様様詫様様様様詫様様様様詫様様様様�');
 Close(t1);
end.