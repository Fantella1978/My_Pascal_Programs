
   { Решение систем линейных уравнений методом Гаусса 
     c  выбором главного элемента }
USES Crt;
Type  matrix=Array[1..10,1..10] of Real;
      vector=Array[1..10] of real;
Var
      c          :matrix;
      y,f,w      :vector;
      i,j,k,n    :Integer;

Procedure ALTERN( n:Integer;Var a:matrix;Var b,x:vector);
  { Подпрограмма выбора главного элемента }
Var
  l  :Integer;
  v  :Real;
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

Procedure INPMATR( n:Integer;Var a:matrix;Var b,x:vector);
   { Подпрограмма ввода расширенной матрицы }
  Var i,j :Integer;
  Begin
    Writeln('Введите:');
    For i:=1 To n Do
    Begin
     For j:=1 To n Do
        Begin
          Write('a[',i,',',j,']=');
          Read (a[i,j]);
        End;
      Write('b[',i,']=');
      Read (b[i]);
    End;
  End;

Procedure GAUS( n:Integer;Var a:matrix;Var b,x:vector);
  { Метод Гаусса без ввода-вывода }
Var
  h   :Real;
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
  x[n]:=b[n]/a[n,n];
  For i:=n-1 DownTo 1 Do
   Begin
     h:=b[i];
      For j:=i+1 To n Do h:=h-x[j]*a[i,j];
      x[i]:=h/a[i,i];
    End;

End;

Procedure OUTVECT(n:Integer; x:vector);
   { Подпрограмма вывода корней системы }
  Begin
     Writeln('Корни ');
     For i:=1 To n Do
       Write (x[i]:10:3);
  End;

Procedure GAUSS( n:Integer;Var a:matrix;Var b,x:vector);
Begin
  INPMATR( n,a,b,x);
  GAUS(n,a,b,x);
  OUTVECT(n,x);
End;


Begin
  ClrScr;
  Write('Введите порядок системы уравнений n=');
  Read (n);
  GAUSS(n,c,f,y);
  Repeat Until Keypressed;
End.