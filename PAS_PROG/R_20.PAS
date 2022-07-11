         {     Программа "RUNGE"
         Решение системы дифференциальных уравнений
         Метод Рунге-Кутта 4-го порядка }
   USES Crt;

Type  vector=Array[1..10] of real;

Var
      y,a,k,f,w        :Vector;
      h,u,x,xk,hh,ii,e,l,b,q,m      :Real;
      n,j    :Integer;

Procedure FUNKT(x:Real; y:Vector; Var F:Vector);
{ Ввод системы уравнений в виде
  F[i]:=F(x,y[1],y[2]...y[n]); }
  Begin
    e:=2e5;
    l:=200;
    hh:=2;
    b:=20;
    ii:=b*hh*hh*hh/12;
    q:=0.05;
    if x<l/2 Then
      M:=q*l*(0.75*l-x)/2
             Else
      M:=q*sqr(l-x)/2;
    F[1]:=y[2];
    F[2]:=m/e/ii;
  End;

Procedure INPRUNGE;
  Begin
    Write(' Введите число уравнений системы      N=');
    Read (n);
    Write(' Шаг интегрирования                   H=');
    Read (h);
    Write(' Начальные условия:              при X0=');
    Read (x);
    For j:=1 To n Do
      Begin
        Write('Y[',j,']=');
        Read(w[j]);
        y[j]:=w[j];
      End;
    Write('Правая граница интервала интегрирования XК =');
    Read(xk);
  End;

Procedure RK4;
  Begin
    Write(x:10:4);
    For j:=1 To n Do
    Write(y[j]:12:4);
    FUNKT(x,y,F);
    For j:=1 To n Do
    Begin
      u:=h*F[j];
      k[j]:=u;  {k1}
      y[j]:=w[j]+u/2;
    End;
    x:=x+h/2;
    FUNKT(x,y,F);
    For j:=1 To n Do
    Begin
      u:=h*F[j];
      k[j]:=k[j]+2*u;{k1+2*k2}
      y[j]:=w[j]+u/2
    End;
    FUNKT(x,y,F);
    For j:=1 To n Do
    Begin
      u:=h*F[j];
      k[j]:=k[j]+2*u; {k1+2*k2+2*k3}
      y[j]:=w[j]+u;
    End;
    x:=x+h/2;

    FUNKT(x,y,F);
    For j:=1 To n Do
    Begin
      y[j]:=w[j]+(k[j]+h*F[J])/6;
     { Write(y[j]:10:4);}
      w[j]:=y[j];
    End;
    Writeln;
  End;
 BEGIN
   ClrScr;
   INPRUNGE;
   Writeln;
   Writeln('       Результаты расчета');
   Write('       X   ');
   For j:=1 To n Do
   Begin
     Write('      Y[',j,']  ');
   End;
   Writeln;
   While x<=xk Do
     RK4;
 END.
