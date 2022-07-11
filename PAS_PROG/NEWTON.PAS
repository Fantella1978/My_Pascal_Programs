
{    Программа NEWTON
    Решение систем нелинейных уравнений
    модифицированным методом Ньютона}

USES Crt;
Type  matrix=Array[1..10,1..10] of Real;
      vector=Array[1..10] of real;
Var
      a            :Matrix;
      b,x,f        :Vector;
      s,h,e,r      :Real;
      n,m,i,j,k    :Integer;

Procedure FUNKT(x:Vector; Var F:Vector);
{ Ввод системы уравнений в виде
  F[i]:=F(x[1],x[2]...x[n]); }
  Begin
    F[1]:=x[1]*x[1]+x[2]*x[2]-25;
    F[2]:=2*x[1]-x[2]-5;
  End;

Procedure INPNEWTON;
  Begin
    Write(' Введите число уравнений системы      N=');
    Read (n);
    Write(' Максимальное число итераций          M=');
    Read (m);
    Write(' Относительную точность вычислений    E=');
    Read (e);
    Writeln('         Исходные приближения корней: ');
    s:=0;
    For i:=1 To n Do
      Begin
        Write('x[',i,']=');
        Read(x[i]);
      End;
  End;

Procedure ALTERN( n:Integer;Var a:matrix;Var b,x:vector);
    { Подпрограмма выбора главного элемента }
  Var
    l      :Integer;
    v      :Real;
    Begin
      l:=i;
      For j:=i+1 To n Do
        If abs(a[j,i])>abs(a[l,i]) then l:=j;
      If l=i then exit;
      For k:=1 To n Do
        Begin
          v:=a[i,k];
          a[i,k]:=a[l,k];
          a[l,k]:=v;
        End;
        v:=b[i];
        b[i]:=b[l];
        b[l]:=v;
     End;

Procedure GAUS( n:Integer;Var a:matrix;Var b,x:vector);
Begin
  For i:=1 To n-1 Do
    Begin
      ALTERN(n,a,b,x);
      For j:=i+1 To n Do
        Begin
          a[j,i]:=-a[j,i]/a[i,i];
          For k:=i+1 To n Do
            a[j,k]:=a[j,k]+a[j,i]*a[i,k];
          b[j]:=b[j]+a[j,i]*b[i];
        End;
    End;
  F[n]:=b[n]/a[n,n];
  For i:=n-1 DownTo 1 Do
   Begin
     h:=b[i];
     For j:=i+1 To n Do h:=h-F[j]*a[i,j];
     F[i]:=h/a[i,i];
   End;
  r:=0;
  For i:=1 To n Do
    Begin
      x[i]:=x[i]+F[i];
      If Abs(F[i]/x[i])>e Then r:=1;
    End;
End;

Procedure OUTVECT(n:Integer; x:vector);
   { Подпрограмма вывода корней системы }
  Begin
     Writeln;
     Writeln('Решение системы: ');
     For i:=1 To n Do
       Write (x[i]:12:4);
     Writeln;
     Write('Число итераций  ',s:3:0);
  End;

 Procedure FORM;
   {Подпрограмма формирования матрицы Якоби}
   Var
     xx     :Real;
   Begin
     FUNKT(x,F);
     For i:= 1 To n Do  b[i]:=-F[i];
     For j:= 1 To n Do
       Begin
         xx:=x[j];
         h:=e*Abs(xx);
         If h=0 Then h:=e;
         x[j]:=xx+h;
         FUNKT(x,F);
         For i:=1 To n Do
         a[i,j]:=(F[i]+b[i])/h;
         x[j]:=xx;
       End;
     s:=s+1;
     If s=m Then
       Begin
         Writeln('Число итераций = ',s:3:0);
         Halt;
       End;
   End;

 BEGIN
     ClrScr;
     INPNEWTON;
     Repeat
       FORM;
       GAUS(n,a,b,x);
     Until r=0;
     OUTVECT(n,x);
  END.
