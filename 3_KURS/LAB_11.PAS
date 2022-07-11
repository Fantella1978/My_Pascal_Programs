Program Lab_11;
 Uses Crt;
 Const e=0.00000001;
 Var a,y,c,b,x,q,p,f:Real;
     esc:Char;
     i:Integer;
FUNCTION Horda(a1,b1:Real):Real;
 Var x1,f1:Real;
     i1:Integer;
 Begin
    ClrScr;
    TextColor(4);
    Writeln('             *************МЕТОД ХОРД*************');
    TextColor(1);
    x1:=b1;
    i1:=0;
   While Abs(Sqrt(1-0.4*x1)-Arctan(x1)) > e do
    Begin
     i1:=i1+1;
     x1:=x1-(((Sqrt(1-0.4*x1)-Arctan(x1))*(a-x1))/(Sqrt(1-0.4*a1)-Arctan(a1))-(Sqrt(1-0.4*x1)-Arctan(x1)));
    End;
    Writeln('Корень приблизительно равен ',x1:12:11,' после ',i1:3,'  итераций');
     f1:=Sqrt(1-0.4*x1)-Arctan(x1);
    Writeln('       ПРОВЕРКА: ');
    Writeln('F(x)=',f1:12:11);
 End;
FUNCTION Iter(a2,b2:Real):Real;
 Var x2,s,c,f2:Real;
     i2:Integer;
 Begin
    TextColor(4);
    Writeln('             ***********МЕТОД ИТЕРАЦИЙ*************');
    TextColor(1);
    x2:=(a+b)/2;
    i2:=0;
    While (Abs(Sqrt(1-0.4*x2)-Arctan(x2)) > e) do
     Begin
      i2:=i2+1;
      S:=Sin(sqrt(1-0.4*x2));
      C:=Cos(sqrt(1-0.4*x2));
      x2:=s/c;
     End;
     Writeln('Корень приблизительно равен ',x2:12:11,' после ',i2:3,'  итераций');
      f2:=Sqrt(1-0.4*x2)-Arctan(x2);
     Writeln('       ПРОВЕРКА: ');
     Writeln('F(x)=',f2:12:11);
 End;
  BEGIN
  TextBackGround(15);
    TextColor(0);
     ClrScr;
    Gotoxy(27,10);
     Writeln('ЛАБОРАТОРНАЯ РАБОТА № 11');
    Gotoxy(25,11);
     Writeln('Выполнил студент группы МА-99');
    Gotoxy(27,12);
     Writeln('Черняк С.Е.');
     Readln;
     ClrScr;
   Repeat
     ClrScr;
     i:=0;
      TextColor(0);
      Writeln('Введите отрезок изоляции корня...');
      Readln(a,b);
      ClrScr;
      HORDA(a,b);
      Writeln;
      ITER(a,b);
      Writeln;
      TextColor(4);
      Writeln('       ************ МЕТОД ПОЛОВИННОГО ДЕЛЕНИЯ ************');
      TextColor(1);
      While Abs(b-a) > e do
       Begin
        c:=(a+b)/2;
        x:=c;
        y:=Sqrt(1-0.4*x)-Arctan(x);
        p:=Sqrt(1-0.4*a)-Arctan(a);
        q:=Sqrt(1-0.4*b)-Arctan(b);
          If (p>0) and (y>0) Then
           Begin
            a:=x;
            b:=b
           End;
          If (p<0) and (y<0) Then
           Begin
            a:=x;
            b:=q
           End;
          If (p>0) and (y<0) Then
           Begin
            a:=a;
            b:=x;
           End;
          If (p<0) and (y>0) Then
           Begin
            a:=a;
            b:=x;
           End;
           i:=i+1
       End;
        Writeln('Корень приблизительно равен ',x:12:11,' после ',i:3,'  итераций');
         f:=Sqrt(1-0.4*x)-Arctan(x);
        Writeln('       ПРОВЕРКА: ');
        Writeln('F(x)=',f:12:11);
        Readln;
   ClrScr;
    TextColor(4);
    GoToXY(15,21);
     Write('PRESS "ESC" TO EXIT... OR ANYKEY FOR NEW-TAB');
    GoToXY(15,22);
    TextColor(11);
     Writeln('════════════════════════════════════════════');
       Esc:=ReadKey;
   Until Esc = #27;
  END.