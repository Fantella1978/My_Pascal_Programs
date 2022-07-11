         {     Программа "RUNGE"
         Решение системы дифференциальных уравнений
         Метод Рунге-Кутта 4-го порядка }
Uses Crt;
Type  vector=Array[1..10] of real;
Var
      y,a,k,f,w        :Vector;
      h,u,x,xk      :Real;
      n,j    :Integer;

Procedure FUNKT(x:Real; y:Vector; Var F:Vector);
{ Ввод системы уравнений в виде
  F[i]:=F(x,y[1],y[2]...y[n]); }
  Begin
    F[1]:=y[2];
    F[2]:=(y[1]/x-y[2])/x-y[1];
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
      k[j]:=u;
      y[j]:=w[j]+u/2;
    End;
    x:=x+h/2;
    FUNKT(x,y,F);
    For j:=1 To n Do
    Begin
      u:=h*F[j];
      k[j]:=k[j]+2*u;
      y[j]:=w[j]+u/2
    End;
    FUNKT(x,y,F);
    For j:=1 To n Do
    Begin
      u:=h*F[j];
      k[j]:=k[j]+2*u;
      y[j]:=w[j]+u;
    End;
    x:=x+h/2;
    FUNKT(x,y,F);
    For j:=1 To n Do
    Begin
      y[j]:=w[j]+(k[j]+h*F[J])/6;
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
