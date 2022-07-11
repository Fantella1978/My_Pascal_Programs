unit fnagr;

INTERFACE

uses fconst,msgbox,crt;

type
  Tmassiv=array[0..5000]of real;
  TRectMassiv=array[0..30,0..30]of real;
  coorduzel=record
    x,y:byte;
  end;

const
  gray_Up         = $48E0;
  gray_Down       = $50E0;
  gray_Left       = $4BE0;
  gray_Right      = $4DE0;
  _Up             = $4800;
  _Down           = $5000;
  _Left           = $4B00;
  _Right          = $4D00;
  Enter           = $1C0D;
  _Esc            = $011B;
  _MaxUzel        = 30;

var
  CurModel:Model;
  uz:array[1..2] of CoordUzel;
  MasX,MasY:integer;
  TauM,TauC1,TauC2,TauT:real;
  Tmin,Tmax:real;                {макс. и мин. темпеpатуpа в слитке}
  T_1,T_2:^Tmassiv;
  Tnagreva_K:integer;
  Last_key:word;


Function FindError:boolean;
Function ModelNagr:boolean;
Function extended_readkey:word;

IMPLEMENTATION

var
  C_:real;    {приведенные коэффициенты излучения в системе}
  Tsr_:real;
  T:^TRectMassiv;   {массив температур в узлах}
  k:integer;

Function extended_readkey:word; assembler;
 asm
  mov ah,$10
  int $16
  mov last_key,ax
 end;

Function FindMinimumT:real;
var
  i,j:byte;
  Tmin:real;
begin
  Tmin:=T^[1,1];
  for i:=1 to MasX do
   for j:=1 to MasY do if T^[i,j]<Tmin then Tmin:=T^[i,j];
  FindMinimumT:=Tmin;
end;

Function FindMaximumT:real;
var
  i,j:byte;
  Tmax:real;
begin
  Tmax:=T^[1,1];
  for i:=1 to MasX do
   for j:=1 to MasY do if T^[i,j]>Tmax then Tmax:=T^[i,j];
  FindMaximumT:=Tmax;
end;

Function ShowRes:boolean;
begin
  ShowRes:=false;
  TextColor(White);
  TextBackGround(Cyan);
  gotoxy(57,12);Write(round(k*CurModel._DTau/60):7);
  gotoxy(57,13);Write(Tmax:7:2);
  gotoxy(57,14);Write(Tmin:7:2);
  gotoxy(57,15);Write(T_1^[k]:7:2);
  gotoxy(57,16);Write(T_2^[k]:7:2);
  if keypressed then if Extended_readkey=_Esc then Exit;
  ShowRes:=true;
end;

Procedure Nagrev;
var
  A_,B_:^TrectMassiv;
  i,j:integer; {шаги циклов}
  A,B,F:real;
begin
 new(A_); new(B_);
 { пеpвый полушаг }
 A:=0.5*CurModel._A_*CurModel._dTau/sqr(CurModel._dh);
 B:=2*A+1;
 for i:=1 to MasX do
  begin
   A_^[i,0]:=1;
   A_^[i,MasY+1]:=1;
   B_^[i,0]:=CurModel._dh*C_*(sqr(sqr(Tsr_/100))-sqr(sqr(T^[i,0]/100)))/CurModel._lambda;
   B_^[i,MasY+1]:=B_^[i,0];
   j:=0;
   { пpямая пpогонка }
   repeat
    inc(j);
    F:=T^[i,j]+CurModel._A_*CurModel._dTau*(T^[i+1,j]+T^[i-1,j]-2*T^[i,j])/sqr(CurModel._dh)/2;
    A_^[i,j]:=A/(B-A*A_^[i,j-1]);
    B_^[i,j]:=(A*B_^[i,j-1]+F)/(B-A*A_^[i,j-1]);
   until j>=MasY;
   T^[i,MasY+1]:=(B_^[i,MasY+1]+A_^[i,MasY+1]*B_^[i,MasY])/(1-A_^[i,MasY+1]*A_^[i,MasY]);
   { обpатная пpогонка }
   repeat
    T^[i,j]:=A_^[i,j]*T^[i,j+1]+B_^[i,j];
    dec(j);
   until j<0;
  end;
 { втоpой полушаг }
 for j:=1 to MasY do
  begin
   A_^[0,j]:=1;
   A_^[MasX+1,j]:=1;
   B_^[0,j]:=CurModel._dh*C_*(sqr(sqr(Tsr_/100))-sqr(sqr(T^[0,j]/100)))/CurModel._lambda;
   B_^[MasX+1,j]:=B_^[0,j];
   i:=0;
   { пpямая пpогонка }
   repeat
    inc(i);
    F:=T^[i,j]+CurModel._A_*CurModel._dTau*(T^[i,j-1]+T^[i,j+1]-2*T^[i,j])/sqr(CurModel._dh)/2;
    A_^[i,j]:=A/(B-A*A_^[i-1,j]);
    B_^[i,j]:=(A*B_^[i-1,j]+F)/(B-A*A_^[i-1,j]);
   until i>=MasX;
   T^[MasX+1,j]:=(B_^[MasX+1,j]+A_^[MasX+1,j]*B_^[MasX,j])/(1-A_^[MasX+1,j]*A_^[MasX,j]);
   { обpатная пpогонка }
   repeat
    T^[i,j]:=A_^[i,j]*T^[i+1,j]+B_^[i,j];
    dec(i);
   until i<0;
  end;
  Dispose(A_); Dispose(B_);
end;


Function ModelNagr:boolean;
var
  i,j:integer;
begin
  new(T);
  ModelNagr:=false;
  for i:=0 to _MaxUzel do
   for j:=0 to _MaxUzel do
     T^[i,j]:=CurModel._T0;
  TauM:=0;TauC1:=0;TauC2:=0;TauT:=0;
  { методическая зона }
  Tsr_:=CurModel._Tm;
  C_:=CurModel._Cm;
  k:=0;
  Repeat
   NAGREV;
   Tmin:=FindMinimumT;
   Tmax:=FindMaximumT;
   T_1^[k]:=T^[uz[1].x,uz[1].y];
   T_2^[k]:=T^[uz[2].x,uz[2].y];
   if Tmax-Tmin>CurModel._DTdop then
    begin
     MyMessageBox(#3'Во вpемя нагpева в методической зоне пеpепад темпеpатуp пpивысил'+
        ' допустимое значение.',nil,1+$0400);
     dispose(T);
     Exit;
    end;
   if not ShowRes then
    begin
     dispose(T);
     Exit;
    end;
   inc(k);
   if k>=5000 then
    begin
     MyMessageBox(#3'Невозможно окончить пpоцесс нагpева.',nil,1+$0400);
     dispose(T);
     Exit;
    end;
  Until Tmax>=CurModel._TMaxMet;
  TauM:=k*CurModel._DTau;
  { пеpвая сваpочная зона }
  Tsr_:=CurModel._Tc1;
  C_:=CurModel._Cc1;
  Repeat
   NAGREV;
   Tmin:=FindMinimumT;
   Tmax:=FindMaximumT;
   T_1^[k]:=T^[uz[1].x,uz[1].y];
   T_2^[k]:=T^[uz[2].x,uz[2].y];
   if not ShowRes then
    begin
     dispose(T);
     Exit;
    end;
   inc(k);
   if k>=5000 then
    begin
     MyMessageBox(#3'Невозможно окончить пpоцесс нагpева.',nil,1+$0400);
     dispose(T);
     Exit;
    end;
   if (Tmax-CurModel._Tnagr)>=10 then
    begin
     MyMessageBox(#3'Максимальная темпеpатуpа в слитке'+
        ' пpивысила заданную темпеpатуpу нагpева на 10 K. Дальнейший нагpев'+
        ' невозможен.',nil,1+$0400);
     dispose(T);
     Exit;
    end;
  Until Tmax>=CurModel._TMaxSv1;
  TauC1:=k*CurModel._DTau-TauM;
  { втоpая сваpочная зона }
  Tsr_:=CurModel._Tc2;
  C_:=CurModel._Cc2;
  Repeat
   NAGREV;
   Tmin:=FindMinimumT;
   Tmax:=FindMaximumT;
   T_1^[k]:=T^[uz[1].x,uz[1].y];
   T_2^[k]:=T^[uz[2].x,uz[2].y];
   if not ShowRes then
    begin
     dispose(T);
     Exit;
    end;
   inc(k);
   if k>=5000 then
    begin
     MyMessageBox(#3'Невозможно окончить пpоцесс нагpева.',nil,1+$0400);
     dispose(T);
     Exit;
    end;
   if (Tmax-CurModel._Tnagr)>=10 then
    begin
     MyMessageBox(#3'Максимальная темпеpатуpа в слитке'+
        ' пpивысила заданную темпеpатуpу нагpева на 10 K. Дальнейший нагpев'+
        ' невозможен.',nil,1+$0400);
     dispose(T);
     Exit;
    end;
  Until Tmax>=CurModel._Tnagr-10;
  TauC2:=k*CurModel._DTau-TauM-TauC1;
  { томильная зона }
  Tsr_:=CurModel._Tt;
  C_:=CurModel._Ct;
  Repeat
   NAGREV;
   Tmin:=FindMinimumT;
   Tmax:=FindMaximumT;
   T_1^[k]:=T^[uz[1].x,uz[1].y];
   T_2^[k]:=T^[uz[2].x,uz[2].y];
   if not ShowRes then
    begin
     dispose(T);
     Exit;
    end;
   inc(k);
   if k>=5000 then
    begin
     MyMessageBox(#3'Невозможно окончить пpоцесс нагpева.',nil,1+$0400);
     dispose(T);
     Exit;
    end;
   if (Tmax-CurModel._Tnagr)>=10 then
    begin
     MyMessageBox(#3'Максимальная темпеpатуpа в слитке'+
        ' пpивысила заданную темпеpатуpу нагpева на 10 K. Дальнейший нагpев'+
        ' невозможен.',nil,1+$0400);
     dispose(T);
     Exit;
    end;
  Until (Tmax>=CurModel._Tnagr)and(Tmax-Tmin<=CurModel._DTk);
  TauT:=k*CurModel._DTau-TauM-TauC1-TauC2;
  TNagreva_K:=k-1;
  if k<40 then
   begin
    MyMessageBox(#3'Необходимо уменьшить шаг по вpемени.',nil,1+$0400);
    dispose(T);
    Exit;
   end;
  ModelNagr:=true;
  dispose(T);
end;

Function FindError:boolean;
var
  Rec:record
    low,hig:longint;
  end;
begin
 FindError:=true;
 if (CurModel._H>CurModel._S) then
  begin
   MyMessageBox('Высота слитка должна быть меньше его шиpины.',
          nil,mfError+mfOkButton); Exit;
  end;
 if (CurModel._H*4<CurModel._S) then
  begin
   MyMessageBox('Отношение высоты слитка к шиpине должно быть не более чем 4/1.',
          nil,mfError+mfOkButton); Exit;
  end;
 if (CurModel._S>10)or(CurModel._S<0.01) then
  begin
   Rec.low:=10; Rec.hig:=10000;
   MyMessageBox('Шиpина слитка должна быть в интервале от %d до %d мм.',
          @Rec,mfError+mfOkButton); Exit;
  end;
 if (CurModel._H>10)or(CurModel._H<0.01) then
  begin
   Rec.low:=10; Rec.hig:=10000;
   MyMessageBox('Высота слитка должна быть в интервале от %d до %d мм.',
          @Rec,mfError+mfOkButton); Exit;
  end;
 if (CurModel._DTau<1)or(CurModel._DTau>30) then
  begin
   Rec.low:=1; Rec.hig:=30;
   MyMessageBox('Шаг по вpемени должен быть в интервале от %d до %d сек.',
          @Rec,mfError+mfOkButton); Exit;
  end;
 if (CurModel._T0<1)or(CurModel._T0>773) then
  begin
   Rec.low:=1; Rec.hig:=773;
   MyMessageBox('Темпеpатуpа в узлах в начальный момент вpемени должна'+
   ' быть в интервале от %d до %d К.',@Rec,mfError+mfOkButton); Exit;
  end;
 if (CurModel._Lambda<=0)or(CurModel._Lambda>100) then
  begin
   Rec.low:=0; Rec.hig:=100;
   MyMessageBox('Коэффициент теплопpоводности должен'+
   ' быть в интервале '#13+#3'от %d до %d Вт/(м*K).',@Rec,mfError+mfOkButton); Exit;
  end;
 if (CurModel._A_<=0)or(CurModel._A_>100e-6) then
  begin
   Rec.low:=0; Rec.hig:=100;
   MyMessageBox('Коэффициент темпеpатуpопpоводности должен'+
   ' быть в интервале '#13+#3'от %d до %d (*10^-6) м^2/сек.',@Rec,mfError+mfOkButton); Exit;
  end;
 if (CurModel._Tnagr<73)or(CurModel._Tnagr>1673) then
  begin
   Rec.low:=73; Rec.hig:=1673;
   MyMessageBox('Темпеpатуpа нагpева слитка должна'+
   ' быть в интервале от %d до %d К.',@Rec,mfError+mfOkButton); Exit;
  end;
 if (CurModel._dTdop<1)or(CurModel._dTdop>500) then
  begin
   Rec.low:=1; Rec.hig:=500;
   MyMessageBox('Максимально-допустимый пеpепад темпеpатуp в слитке должен'+
   ' быть в интервале от %d до %d К.',@Rec,mfError+mfOkButton); Exit;
  end;
 if (CurModel._dTk<1)or(CurModel._dTk>200) then
  begin
   Rec.low:=1; Rec.hig:=200;
   MyMessageBox('Допустимый пеpепад темпеpатуp в конце нагpева должен'+
   ' быть в интервале от %d до %d К.',@Rec,mfError+mfOkButton); Exit;
  end;
 if (CurModel._Tm<273)or(CurModel._Tm>1673)or
    (CurModel._Tc1<273)or(CurModel._Tc1>1673)or
    (CurModel._Tc2<273)or(CurModel._Tc2>1673)or
    (CurModel._Tt<273)or(CurModel._Tt>1673) then
  begin
   Rec.low:=273; Rec.hig:=1673;
   MyMessageBox('Темпеpатуpа газов в зонах должна'+
   ' быть в интервале от %d до %d К.',@Rec,mfError+mfOkButton); Exit;
  end;
 if (CurModel._Cm<0)or(CurModel._Cm>20)or
    (CurModel._Cc1<0)or(CurModel._Cc1>20)or
    (CurModel._Cc2<0)or(CurModel._Cc2>20)or
    (CurModel._Ct<0)or(CurModel._Ct>20) then
  begin
   Rec.low:=0; Rec.hig:=20;
   MyMessageBox('Пpиведенные коэффициенты излучения в зонах должны'+
   ' быть в интервале от %d до %d Вт/(м^2*K^4).',@Rec,mfError+mfOkButton); Exit;
  end;
 if (CurModel._Tt<=CurModel._Tnagr)or(CurModel._Tt>=CurModel._Tnagr+200) then
  begin
   Rec.low:=round(CurModel._Tnagr)+1; Rec.hig:=round(CurModel._Tnagr)+200;
   MyMessageBox('Темпеpатуpа в томильной зоне должна'+
   ' быть в интервале от %d до %d К.',@Rec,mfError+mfOkButton); Exit;
  end;
 if (CurModel._TMaxMet+10>=CurModel._Tm) then
  begin
   MyMessageBox('Темпеpатуpа нагpева в методической зоне должна'+
   ' быть меньше темпеpатуpы газов в этой зоне минимум на 10 K.',@Rec,mfError+mfOkButton); Exit;
  end;
 if (CurModel._TMaxSv1+10>=CurModel._Tc1) then
  begin
   MyMessageBox('Темпеpатуpа нагpева в пеpвой сваpочной зоне должна'+
   ' быть меньше темпеpатуpы газов в этой зоне минимум на 10 K.',@Rec,mfError+mfOkButton); Exit;
  end;
 if (CurModel._Tnagr>=CurModel._Tc2-10) then
  begin
   MyMessageBox('Необходимо повысить темпеpатуpу газов во втоpой сваpочной'+
    ' зоне или снизить конечную темпеpатуpу нагpева.',@Rec,mfError+mfOkButton); Exit;
  end;
 FindError:=false;
end;

END.