 {  Программа NEWTON1 решения уравнения вида
          F(x)=0  методом Ньютона }
 USES crt;
 Type fun=Function(x:Real):Real;
 Var u,z  :Real;

Function F(x:Real):Real;
  { Функция F(x) }
  Begin
    F:=((x-6)*x+11)*x-2
  End;

Function F1(x:Real):Real;
  { Производная функции F(x) }
  Begin
    F1:=(3*x-12)*x+11;
  End;

Procedure NEWTON( Var y:Real;x:Real; F:fun);
     {x - аргумент функции
      F - функция
      y - корень уравнения}
  Const  eps=0.0001;
  Var     i:Integer;
          u:Real;
  Begin
          i:=1;
        Repeat
          y:=x-F(x)/F1(x);
          u:=x;
          x:=y;
          i:=i+1;
          If i-200>0 then
            Begin
              Writeln('Процесс не сходится');
              Repeat Until KeyPressed;
              Halt;
            End;
        Until abs(y-u)<=eps;
    Writeln
  End;


BEGIN
  ClrScr;
  Writeln('Введите:');
  write('Исходное приближение корня уравнения  ');
  Read (u);
  NEWTON(z,u,F);
  Write ('Корень уравнения   ');
  write (z:10:4);
  Repeat Until KeyPressed;
END.