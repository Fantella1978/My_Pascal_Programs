Program B_19;{�ணࠬ�� ������᪮� ��ࠡ�⪨}
const n=20;  {���ᨢ��}
var x,y:array[1..n]of real;
    i:integer;
    Mx,My,Dx,Dy,Qx,Qy,K:real;
BEGIN
 Randomize;
 For i:=1 to n do
  begin
   x[i]:=random-0.5;
   y[i]:=12*x[i]+21
  end;
 Mx:=0; My:=0;
 For i:=1 to n do
  begin
   Mx:=Mx+x[i]/n; {�।�ee ���祭�� �㭪樨 �}
   My:=My+y[i]/n; {�।�ee ���祭�� �㭪樨 Y}
  end;
 Dx:=0; Dy:=0;
 For i:=1 to n do
  begin
   Dx:=Dx+sqr(x[i]-Mx)/(n-1); {��ᯥ��� �㭪樨 �}
   Dy:=Dy+sqr(y[i]-My)/(n-1); {��ᯥ��� �㭪樨 Y}
   K:=K+(x[i]-Mx)*(y[i]-My)/(n-1); {����. ���५.}
  end;
 Qx:=sqrt(Dx); {�।��������筮� �⪫������ �}
 Qy:=sqrt(Dy); {�।��������筮� �⪫������ Y}
 Writeln('C।�ee ���祭�� �㭪樨 � : ',Mx:10:4);
 Writeln('C।�ee ���祭�� �㭪樨 Y : ',My:10:4);
 Writeln('��ᯥ��� �㭪樨 � : ',Dx:10:4);
 Writeln('��ᯥ��� �㭪樨 Y : ',Dy:10:4);
 Writeln('C।��������筮� �⪫������ X : ',Qx:10:4);
 Writeln('C।��������筮� �⪫������ Y : ',Qy:10:4);
 Writeln('�����樥�� ���५�樨 : ',K:10:4);
END.
