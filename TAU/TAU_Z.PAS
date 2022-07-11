uses crt;
const
  TauOb=27; TOb=100; KOb=7.1;
  Kp=0.43;  Ti=50.5; Z=19;
var
  T,A,h,y1,y2,y5,s:real;
  i,k:integer;
  X,E:array[1..42]of real;
  t1:Text;
begin
 Assign(t1,'Tau_z.txt');
 Rewrite(t1);
 h:=TauOb/40;
 A:=TauOb*20;
 T:=0; y1:=0; y2:=0; y5:=0; S:=z;
 For i:=1 to 42 do
  begin
   X[i]:=0;
   E[i]:=0;
  end;
 Writeln(t1,'ษอออออออออัอออออออออัอออออออออัอออออออออัอออออออออัอออออออออัอออออออออป');
 Writeln(t1,'บ    T    ณ    X    ณ    E    ณ    Y1   ณ    Y2   ณ    Y5   ณ    S    บ');
 Writeln(t1,'ฬอออออออออุอออออออออุอออออออออุอออออออออุอออออออออุอออออออออุอออออออออน');
 repeat
  Writeln(t1,'บ',T:9:4,'ณ',X[1]:9:4,'ณ',E[1]:9:4,'ณ',Y1:9:4,'ณ',Y2:9:4,'ณ',Y5:9:4,'ณ',S:9:4,'บ');
  for k:=1 to 10 do
   begin
    X[42]:=X[41]+h*(KOb*(Z+Y5)-X[41])/TOb;
    E[42]:=E[41]+h*(KOb*Z-E[41])/TOb;
    Y1:=-Kp*X[2];
    Y2:=Y2-Kp*h*X[1]/Ti;
    Y5:=Y1+Y2;
    S:=Y5+Z;
    For i:=1 to 41 do
     begin
      X[i]:=X[i+1];
      E[i]:=E[i+1];
     end;
   end;
  T:=T+10*h;
 until T>A;
 Writeln(t1,'ศอออออออออฯอออออออออฯอออออออออฯอออออออออฯอออออออออฯอออออออออฯอออออออออผ');
 Close(t1);
end.