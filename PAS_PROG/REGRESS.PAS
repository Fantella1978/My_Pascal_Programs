 {  Программа REGRESS
    Аппроксимация табличной модели
    методом наименьших квадратов.
      Линейная регрессия }
 USES crt;
 Type Vector=Array[1..100] of Real;
 Var
      x,y              :Vector;
      i,k,n,t          :Integer;
      a,b,r,xx,yy      :Real;

 Procedure VVOD {(Var x:Vector; z:Vector; t:Integer);};
  Var i:Integer;
 Begin
     Writeln('  Введите:');
     For i:=1 To t Do
     Begin
        gotoxy(2,4+i);
        Write('x[',i,']=');
        Read(x[i]);
        gotoxy(16,4+i);
        Write('y[',i,']=');
         Read(y[i]);
     End;
 End;

  Procedure  VYBOR1;
     Begin
        Case k of
           0:      Halt;
           1:      Exit;
           2,12:   yy:=1/yy;
           3:      xx:=1/xx;
           4:      yy:=xx/yy;
           5,7:    yy:=ln(yy)/ln(10);
           6:      yy:=ln(yy);
           8:      Begin  xx:=exp(-xx); yy:=1/yy; End;
           9:      Begin
                     xx:=ln(xx)/ln(10);
                     yy:=ln(yy)/ln(10);
                   End;
           10:     xx:=ln(xx)/ln(10);
           11:     xx:=ln(xx);
           13:     Begin  xx:=1/xx; yy:=1/yy; End;
           14:     Begin  xx:=1/xx; yy:=ln(yy); End;
           15:     Begin
                      xx:=1/xx; yy:=ln(yy)/ln(10);
                   End;
           16:     xx:=exp(n*ln(xx));
           Else    Begin
                     Writeln ('Ошибка ввода!');
                     Repeat Until KeyPressed;
                     Halt;
                   End;
        End;
     End;

 Procedure  VYBOR2;
     Var a1       :Real;
     Begin
        Case k of
           5:      Begin
                     a:=exp(a*ln(10));
                     b:=exp(b*ln(10));
                   End;
           6,14:   a:=exp(a);
           7,9,15: a:=exp(a*ln(10));
           12:     Begin  a1:=a; a:=1/b; b:=a1/b; End;
           13:     Begin  a:=1/a; b:=b*a; End;
           Else    Begin  End;
        End;
     End;

  Procedure REGRESS;
  Var    x1,x2,y1,y2,p    :Real;
         i                :Integer;
  Begin
       {'Формирования системы уравнений'}
  x1:=0;
  x2:=0;
  y1:=0;
  y2:=0;
  p:=0;
  For i:=1 to t Do
      Begin
        xx:=x[i];
        yy:=y[i];
        VYBOR1;
        x1:=x1+xx;
        y1:=y1+yy;
        x2:=x2+xx*xx;
        y2:=y2+yy*yy;
        p:=p+xx*yy;
      End;
  b:=(x1*y1-t*p)/(x1*x1-t*x2);
  a:=(y1-b*x1)/t;
  { 'Коэффициент парной корреляции'}
  r:=(p-x1*y1/t)/sqrt((x2-x1*x1/t)*(y2-y1*y1/t));

End;

Procedure TABL;
 Begin
  Writeln;
  Writeln(' I       X[i]         Y[i]           Y         %откл.');
  Writeln;
  {'  Вывод таблицы результатов'}
  For i:=1 To t Do
     Begin
       xx:=x[i];
       yy:=y[i];
       Case k of
         1:  yy:=a+b*xx;
         2:  yy:=1/(a+b*xx);
         3:  yy:=a+b/xx;
         4:  yy:=xx/(a+b*xx);
         5:  yy:=a*exp(xx*ln(b));
         6:  yy:=a*exp(b*xx);
         7:  yy:=a*exp(b*xx*ln(10));
         8:  yy:=1/(a+b*exp(-xx));
         9:  yy:=a*exp(b*ln(xx));
         10: yy:=a+b*ln(xx)/ln(10);
         11: yy:=a+b*ln(xx);
         12: yy:=a/(b+xx);
         13: yy:=a*xx/(b+xx);
         14: yy:=a*exp(b/xx);
         15: yy:=a*exp(b/xx*ln(10));
         16: yy:=a+b*exp(n*ln(xx));
       End;
     Writeln(i,xx:13:4,y[i]:13:4,yy:13:4,100*(y[i]-yy)/y[i]:12:3);
   End;
 End;
 Procedure SHOWTABL;
    Begin
      Writeln('Таблица кодов и эмпирических функций Y=f(x)');
      Writeln('1. Y=A+B*X           2. Y=1/(A+B*X)');
      Writeln('3. Y=A+B/X           4. Y=X/(A+B*X)');
      Writeln('5. Y=A*B^X           6. Y=A*EXP(B*X)');
      Writeln('7. Y=A*10^(B*X)      8. Y=1/(A+B*EXP(-X)))');
      Writeln('9. Y=A*X^B          10. Y=A+B*LOG10(X)');
      Writeln('11.Y=A+B*LOG(X)     12. Y=A/(B+X)');
      Writeln('13.Y=A*X/(B+X)      14. Y=A*EXP(B/X)');
      Writeln('15.Y=A*10^(B/X)     16. Y=A+B*X^N  ');
    End;
 Procedure VYVOD;
  Begin
    Write(' Введите номер вида регрессии ( 0 - выход)  ');
    Readln (k);
    If k=16 Then
        Begin
          Write('   Введите N=');
          Read(n);
        End;
    Writeln;
    REGRESS;
    VYBOR2;
    Writeln('     A=',a:8:4,'  B=',b:8:4,'  R=',r:8:5);
    TABL;
  End;


BEGIN
  ClrScr;
  Writeln('      Введите:');
  Write('Число точек табличной модели T= ');
  Read (t);
  VVOD;
  Repeat
    SHOWTABL;
    VYVOD;
  Until k=0;
END.