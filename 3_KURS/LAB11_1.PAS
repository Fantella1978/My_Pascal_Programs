Program LAB11;
Uses Crt;
Var x_pred,a,b,h,x,fx_pred,fx,n,m,l,k,c,fc,fa,oo,t,x_p,i,d:Real;
    sim:Char;

Procedure PROVERKA(Var i:Real);
Var q:Real;
Begin
   q:=i-Exp(1/3*Ln(5))+i/2;
   Writeln(q:10:5);
End;

Function FUNCT(Var d:Real):Real;
Begin
   FUNCT:=d-Exp(1/3*Ln(5))+d/2;
End;

BEGIN
TextColor(4);
TextBackGround(7);
While sim<>#27 do
Begin
ClrScr;
Writeln('Введите точность вычислений...');
Readln(t);
Writeln('Введите верхнюю/нижнюю границу поиска корня...');
Readln(a,b);
Writeln('Введите шаг поиска отрезка изоляции корня...');
Readln(h);

x:=a;
Repeat
fx_pred:=fx;
x_pred:=x;
fx:=FUNCT(x);
x:=x+h;
Until ((fx*fx_pred)<0) or (x>b);
Writeln('Отрезок изоляции корня:',x_pred:7:7,'...',x:7:7);

n:=x_pred;  l:=x_pred;
m:=x;       k:=x;

Writeln('***********МЕТОД 1/2 ДЕЛЕНИЯ**********');
Repeat
c:=(x_pred+x)/2;
fc:=FUNCT(c);
fa:=FUNCT(x_pred);
If c=0 Then
      Begin
        Writeln('Корень!:',c:7:7);
        Readln;
        Break;
      End
Else If (fa*fc)<0 Then x:=c
Else If (fa*fc)>0 Then x_pred:=c;
Until (Abs(x-x_pred)>t) and (Abs(fc)>0.1*t);
Writeln('Корень:',c:7:7);
Writeln('Проверка:');
PROVERKA(c);

Writeln('***************МЕТОД ХОРД*****************');
If FUNCT(n)>FUNCT(m) Then
Begin
oo:=n;
n:=m;
m:=oo;
End;
While Abs(m-n)<t do
Begin
   n:=x;
   x:=n-(FUNCT(n)*(m-n))/(FUNCT(m)-FUNCT(n));
End;
Writeln('Корень:',x:7:7);
Writeln('Проверка:');
PROVERKA(x);

Writeln('**********МЕТОД ИТЕРАЦИЙ************');
x:=(l+k)/2;
While Abs(x-x_p)<t do
Begin
   x_p:=x;
   x:=Exp(1/3*Ln(5))-d/2;
End;
Writeln('Корень:',x:7:7);
Writeln('Проверка:');
PROVERKA(x);
Writeln('Exit? (Esc/Any Key)');
sim:=Readkey;
End;
End.