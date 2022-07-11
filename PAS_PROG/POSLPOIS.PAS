 {  Программа POISK решения уравнения вида
   F(x)=0  методом равномерного последовательного поиска }
 USES crt;
 Type fun=Function(x:Real):Real;
  Const  eps=0.0001;
  Var x,y,u,z,h,x0,xk  :Real;

 Function F(x:Real):Real;
  { Функция F(x) }
  Begin
    F:=0.25*x*x*x+x-1.2502
  End;

          Procedure POISK( Var x:Real; Fx:fun);
     {x - аргумент функции
      F - функция }
   Begin
          x:=x0;
          y:=F(x);
       Repeat
           if abs(h)<eps then
             Begin
                Writeln;
                Write ('Корень уравнения   ');
                Write (x:10:4);
                Repeat Until KeyPressed;
                Halt;
             End;
          x:=x+h;
          z:=F(x);
          if y*z<0 then
               Begin
                 h:=-h/2;
                 y:=z;
               End;
       Until x>xk;
          Writeln('На интервале корней нет');
          Repeat Until KeyPressed;
  End;
  var fx:fun;
  Begin
     ClrScr;
     Writeln('     Введите:');
     Write('Интервал  корня уравнения  x0 xk   ');
     Read (x0,xk);
     Write('Шаг поиска (первоначальный)  ');
     Read (h);
     POISK(x,Fx);
  End.