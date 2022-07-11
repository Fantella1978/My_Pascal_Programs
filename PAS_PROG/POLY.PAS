   {         Программа   "POLYNOM" }
   { Аппроксимация табличной модели полиномом степени M
     вида y=D[1]+D[2]*x+D[3]*x^2+...+D[M+1]*x^M }
   {        Метод наименьших квадратов }
USES Crt,Graph;
Type  matrix=Array[1..10,1..10] of Real;
      vector=Array[1..20] of real;
      vec=Array[1..20] of Integer;

Var
      a                             :matrix;
      c,b,z,v,w                     :vector;
      vv,ww                         :vec;
      Gd,Gm,i,j,k,n,h,n2,m                :Integer;
      x,y,f,ymax,ymin,scalx,scaly   :Real;

  Procedure FORMIR(Var n:Integer;Var a:matrix;Var b,v,w:vector);
    {Подпрограмма формирования системы нормальных уравнений}
    Begin
      n:=m+1;
      n2:=2*n;
        For j:=1 To n2 Do
          Begin
            b[j]:=0;
            c[j]:=0;
          End;
      Write('Введите число пар X,Y    ');
      Read (h);
      For i:=1 To h Do
        Begin
          Write('Введите X[',i,']  Y[',i,']     ');
          Read(x,y);
          v[i]:=x; w[i]:=y;
          f:=1;
          For j:=1 To 2*n-1 Do
            Begin
              If j<=n Then
                  Begin
                    b[j]:=b[j]+y;
                    y:=y*x;
                  End;
              c[j]:=c[j]+f;
              f:=f*x;
            End;
        End;
        For i:=1 To n Do
          Begin
            k:=i;
            For j:=1 To n Do
              Begin
                a[i,j]:=c[k];
                k:=k+1;
              End;
          End;

End;


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

Procedure GAUS( n:Integer;Var a:matrix;Var b,x:vector);
  { Подпрограмма GAUSS без ввода-вывода }
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
  Begin
     Writeln('Коэффициенты полинома ');
     For i:=1 To n Do
       Write (x[i]:10:3);
  End;

Procedure Opengraph;
  begin
    Gd := Detect; InitGraph(Gd, Gm, ''); SetWriteMode(XORPut);
  end;

Procedure TOOLGRAPH;
Begin
  ymax:=w[1];
  ymin:=w[1];
  For i:=2 To h Do
    Begin
      If w[i]>ymax Then ymax:=w[i];
      If w[i]<ymin Then ymin:=w[i];
    End;
  scalx:=500/(v[h]-v[1]);
  scaly:=400/(ymax-ymin);
  For i:=1 To h Do
    Begin
      vv[i]:=round(scalx*v[i]);
      ww[i]:=round(scaly*w[i]);
      circle(vv[i],ww[i],4);
    End;
End;
Begin
  ClrScr;
  Write('Порядок степенного полинома    ');
  Read(m);
  FORMIR(n,a,b,v,w);
  GAUS(n,a,b,z);
  OUTVECT(n,z);
  OPENGRAPH;
  TOOLGRAPH;
  Repeat until KeyPressed
End.