program kurs;
uses crt,dos;
Type  matrix=Array[1..50,1..50] of Real;
      vector=Array[1..50] of real;

var
 matrgauss,c:matrix;
 matrgausscv,y,f,w,kor:vector;
 i,por,j,k,n:integer;
 menunom:char;da:boolean;
 filer,filer1:text;
 korp,korx,kork:real;
procedure zastavca;
begin
window(1,1,80,25);
textbackground(3);
clrscr;
window(4,2,77,24);
textbackground(lightblue);
clrscr;
TEXTCOLOR(7);
gotoxy(29,5);
writeln('КУРСОВАЯ РАБОТА');
gotoxy(8,7);
writeln('на тему "МАТЕМАТИЧЕСКОЕ МОДЕЛИРОВАНИЕ НА ЭВМ BORLAND PASCAL"');
gotoxy(10,10);
writeln('выполнил студент группы МА-96: Иванов Иван Иванович');
gotoxy(10,12);
writeln('принял преподаватель : Симкин Александр Исаакович  ');
gotoxy(29,20);
write('Мариуполь 1998 г.');
TEXTCOLOR(lightblue);
readkey;
end;
procedure menu;
begin
 window(1,1,80,25);
 textbackground(7);
 clrscr;
 window(15,4,68,16);
 textbackground(0);
 clrscr;
 window(13,3,66,15);
 textbackground(3);
 textcolor(1);
 clrscr;
 write(' ╔══════════════════════════════════════════════════╗ ');
 write(' ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ╚══════════════════════════════════════════════════╝');
 window(16,4,64,6);
 textbackground(3);
 textcolor(1);
 clrscr;
 write('╔══════════════════════════════════════════════╗ ');
 WRITE('║                     МЕНЮ                     ║ ');
 write('╚══════════════════════════════════════════════╝');
 window(15,8,62,14);
 textbackground(3);
 textcolor(1);
 writeln('   1. Выход из программы ');
 writeln('   2. Расчет корней уравнения ');
 writeln('   3. Расчет дифференциального уравнения ');
 writeln('   4. Вычисление определенного интеграла');
 writeln('   5. Расчет системы линейных уравнений');
 writeln('');
 write('     Нажмите номер соответствующей опции   ');
 repeat
 menunom:=readkey;
 until (menunom='1') or (menunom='2') or (menunom='3') or (menunom='4') or (menunom='5');
end;
procedure vvodgauss;
begin
 window(1,1,80,25);
 textbackground(7);
 clrscr;
 window(15,4,68,16);
 textbackground(0);
 clrscr;
 window(13,3,66,15);
 textbackground(3);
 textcolor(1);
 clrscr;
 write(' ╔══════════════════════════════════════════════════╗ ');
 write(' ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ╚══════════════════════════════════════════════════╝');
 window(16,4,64,6);
 textbackground(3);
 textcolor(1);
 clrscr;
 write('╔══════════════════════════════════════════════╗ ');
 WRITE('║   ВВОД ДАННЫХ ДЛЯ РЕШЕНИЯ СИСТЕМЫ УРАВНЕНИЙ  ║ ');
 write('╚══════════════════════════════════════════════╝');
 window(15,8,62,14);
 textbackground(3);
 textcolor(1);
 WRITE('Введите порядок системы уравнений  ');
 read(por);
 for i:=1 to por do
 begin
 for j:=1 to por do
 begin
   clrscr;
  gotoxy(1,1);
  writeln('Ввод коэффициентов уравнения');
  write('Введите А[',i,',',j,']','=   ');
  readln(matrgauss[i,j]);
 end;
 end;
 for j:=1 to por do
 begin
 clrscr;
  gotoxy(1,1);
  writeln('Ввод свободных членов');
  write('Введите B[',j,']','=   ');
  readln(matrgausscv[j]);
 end;
end;
procedure zapfilegauss;
begin
writeln(filer,''); writeln(filer,'');
writeln(filer,'Решение системы уравнений Методом Гаусса с выбором главного элемента');
 writeln(filer,'');
writeln(filer,'================Исходные данные================');
 writeln(filer,'');
writeln(filer,'Матрица коэффициентов');
 writeln(filer,'');
 for i:=1 to por do
 begin
 for j:=1 to por do
 begin
  write(filer,matrgauss[i,j]:10:3);
 end;
 writeln(filer,'');
 end;
writeln(filer,'Матрица свободных членов');
 writeln(filer,'');
 for j:=1 to por do
 begin
  writeln(filer,matrgausscv[j]:14:3);
 end;
writeln(filer,'');
writeln(filer,'Решение системы уравнений');
 for j:=1 to por do
 begin
    Writeln (filer,'   ',j,'   корень равен ',kor[j]:10:3);
 end;
writeln(filer,'');

end;
procedure okno;
begin
 window(1,1,80,25);
 textbackground(7);
 clrscr;
 window(15,4,68,19);
 textbackground(0);
 clrscr;
 window(13,3,66,18);
 textbackground(3);
 textcolor(1);
 clrscr;
 write(' ╔══════════════════════════════════════════════════╗ ');
 write(' ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ║                                                  ║');
 write('  ╚══════════════════════════════════════════════════╝');
 window(16,4,64,17);
 textbackground(3);
 textcolor(1);
 clrscr;
end;
{=========Решение системы уравнений методом Гаусса=========}
procedure mgauss;
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
    For i:=1 To n Do
    Begin
     For j:=1 To n Do
        Begin
          a[i,j]:=matrgauss[i,j];
        End;
        b[i]:=matrgausscv[i];
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
     gotoxy(1,1);
     Writeln( ' Корни системы уравнения ');
     For i:=1 To n Do
     begin
       Writeln ('   ',i,'   корень равен ',x[i]:10:3);
       kor[i]:=x[i];
       end;
  End;

Procedure GAUSS( n:Integer;Var a:matrix;Var b,x:vector);
Begin
  INPMATR( n,a,b,x);
  GAUS(n,a,b,x);
  OUTVECT(n,x);
End;
Begin
  n:=por;
  GAUSS(n,c,f,y);
  Repeat Until Keypressed;
End;
{==============Вычисление интеграла=================}
procedure integral;
     var s1,int21,int11,int31,e,s2,y4,y5,y3,y2,h,s,a,b,n,x,z,int,int1,int2,int3,n1,n2,n3:real;
   function fun(x:real):real;
         var z :real;
      begin
       z:=2*SQRT(EXP(X)-1)-2*ARCTAN(SQRT(EXP(X)-1));
        fun:=z
        end;
   function y(x:real):real;
         var  y1:real;
       begin
       y1:=SQRT(EXP(X)-1);
       y:=y1
       end;

         begin
         okno;
 writeln('          РЕШЕНИЕ ИНТЕГРАЛА        ');
WRITE('ВВЕДИТЕ НИЖНИЙ ПРЕДЕЛ ИНТЕГРИРОВАНИЯ  ');
READ(A);
WRITE('ВВЕДИТЕ ВЕРХНИЙ ПРЕДЕЛ ИНТЕГРИРОВАНИЯ  ');
READ(b);
WRITE('ВВЕДИТЕ ТОЧНОСТЬ РАСЧЕТА  ');
READ(E);
clrscr;
writeln('          РЕШЕНИЕ ИНТЕГРАЛА        ');
GOTOXY(1,2);
     z:=fun(b)-fun(a);
     n:=50;
     int1:=0;
     repeat
      h:=(b-a)/n;
         int11:=int1;
      n:=n*2;
      x:=a; s:=0;
   while x<b do
   begin
      x:=x+h;
      y2:=y(x);
      s:=s+y2;
   end;
      int1:=s*h;

    until abs(int11-int1)<e;
    writeln('ПО ПРОВЕРОЧНОЙ ФУНКЦИИ',z:10:6);
    writeLN('МЕТОДОМ ПРЯМОУГОЛЬНИКОВ',int1:10:6);
    WRITELN('ЧИСЛО РАЗБИЕНИЙ  ',N:3:2);n1:=n;
      {-----------------------------------------}
     n:=50;
     int2:=0;
     repeat
      h:=(b-a)/n;
      s:=(y(a)+y(b))/2;
         int21:=int2;
      n:=n*2;
     x:=a;
      while x<b-h do
   begin
      x:=x+h;
      y3:=y(x);
      s:=s+y3;
   end;
      int2:=s*h;
       until abs(int21-int2)<e;
    writeLN('МЕТОДОМ ТРАПЕЦИЙ ',int2:10:6);
    WRITELN('ЧИСЛО РАЗБИЕНИЙ  ',N:3:2); n2:=n;
      {-----------------------------------------}
          n:=50;
      repeat
      h:=(b-a)/n;
      int31:=int3;
      x:=a+h;
      s1:=0;
      n:=n*2;
    while x<b-h do
   begin
      x:=x+2*h;
      y4:=y(x);
      s1:=s1+y4;
   end;
      x:=a+2*h;
      s2:=0;
      while x<b-2*h do
   begin
      x:=x+2*h;
      y5:=y(x);
      s2:=s2+y5;
   end;
      int3:=(h/3)*(y(a)+y(b)+4*s1+2*s2);
      until abs(int31-int3)<e;
    writeLN('МЕТОДОМ СИМПСОНА ',int3:10:6);
        WRITELN('ЧИСЛО РАЗБИЕНИЙ  ',N:3:2);n3:=n;
      {-----------------------------------------}
        readkey;
 writeln(filer,'');
WRITELN(FILER,'Вычисление определенного интеграла');
writeln(filer,'================Исходные данные================');
 writeln(filer,'НИЖНИЙ ПРЕДЕЛ ИНТЕГРИРОВАНИЯ  ',a:10:5);
 writeln(filer,'ВЕРХНИЙ ПРЕДЕЛ ИНТЕГРИРОВАНИЯ  ',b:10:5);
 writeln(filer,'ТОЧНОСТЬ РАСЧЕТА  ',e:10:5);
 writeln(filer,'');
    writeln(FILER,'РАСЧЕТ ПО ПРОВЕРОЧНОЙ ФУНКЦИИ',z:10:6);
        writeln(filer,'');
    writeLN(FILER,'РАСЧЕТ МЕТОДОМ ПРЯМОУГОЛЬНИКОВ',int1:10:6);
      writeln(filer,'Данная точность достигнута при числе разбиений  ',n1:5:2);
        writeln(filer,'');

    writeLN(FILER,'РАСЧЕТ МЕТОДОМ ТРАПЕЦИЙ ',int2:10:6);
      writeln(filer,'Данная точность достигнута при числе разбений  ',n2:5:2);
        writeln(filer,'');

    writeLN(FILER,'РАСЧЕТ МЕТОДОМ СИМПСОНА ',int3:10:6);
      writeln(filer,'Данная точность достигнута при числе разбиений  ',n3:5:2);
        writeln(filer,'');
end;
procedure diffur;
  function f(x,y:extended):extended;
   begin
    f:=x*y*y-2;
   end;
    var
     x,x1,y,y1,h,k1,k2,k11,k33,k44,k22,k3,k4,y0:extended;
     j,n:longint;i:integer;
  begin
     x:=0.2;x1:=0.2;y:=0.1;y1:=0.1;h:=0.1;
     okno;
     writeln(filer,'                 ОПРЕДЕЛЕНИЕ КОРНЕЙ ');
     writeln(filer,'            ДИФФЕРЕНЦИАЛЬНОГО УРАВНЕНИЯ ');
     writeln('                 ОПРЕДЕЛЕНИЕ КОРНЕЙ ');
     writeln('            ДИФФЕРЕНЦИАЛЬНОГО УРАВНЕНИЯ ');
     writeln;
     writeln(filer);
     writeln('   X      Метод Эйлеpа     Метод Рунге-Кутта');
     writeln(filer,'   X      Метод Эйлеpа     Метод Рунге-Кутта');
     repeat
      k1:=h*f(x,y);
      k2:=h*f(x+h/2,y+k1/2);
      k3:=h*f(x+h/2,y+k2/2);
      k4:=h*f(x+h,y+k3);
      y0:=y+(k1+2*k2+2*k3+k4)/6;
      x:=x+h;
    {------метод Эйлера(1)---------------------------------------}
      y:=y1+h*f(x,y1);
      y1:=y;
      writeln('  ',x1:4:2,'      ',y1:8:5,'           ',y0:8:5);
      writeln(filer,'  ',x1:4:2,'      ',y1:8:5,'           ',y0:8:5);
      x1:=x1+h;
    until round(x1*10)>10;
    readkey;
 End;

procedure uravn;
procedure poslpoisk;
 {  Программа POISK решения уравнения вида
   F(x)=0  методом равномерного последовательного поиска }
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
          da:=false;
          x:=x0;
          y:=F(x);
       Repeat
           if abs(h)<eps then
             Begin
             clrscr;
             writeln('         ОТДЕЛЕНИЕ КОРНЕЙ МЕТОДОМ');
             writeln('        ПОСЛЕДОВАТЕЛЬНОГО ПЕРЕБОРА');
             writeln;
             korp:=x;
             writeln('Полученный корень   ',korp:10:6);
             readkey;
             da:=true;
                break;
             End;
          x:=x+h;
          z:=F(x);
          if y*z<0 then
               Begin
                 h:=-h/2;
                 y:=z;
               End;
      Until x>xk;
         if da<>true then
         begin
             clrscr;
             writeln('         ОТДЕЛЕНИЕ КОРНЕЙ МЕТОДОМ');
             writeln('        ПОСЛЕДОВАТЕЛЬНОГО ПЕРЕБОРА');
             writeln;
            Writeln('На интервале корней нет');
            readkey;
         end;
  End;
  var fx:fun;
  Begin
  writeln('               РЕШЕНИЕ УРАВНЕНИЯ');
  writeln;
  writeln('           ОТДЕЛЕНИЕ КОРНЕЙ МЕТОДОМ');
  writeln('          ПОСЛЕДОВАТЕЛЬНОГО ПЕРЕБОРА');
  writeln;
     Write('Введите начальное значение интервала ');
     Read (x0);
     Write('Введите конечное значение интервала  ');
     Read (xk);
     Write('Введите шаг поиска                   ');
     Read (h);
     POISK(x,Fx);
  End;
PROCEDURE XORD;
 var  s,c,x,d,h,l,a,b,e:real;
     f1,f2,x1:real;
     x2,k:real;
    i,n:integer;
 function y(x:real):real;
    begin
    y:=0.25*x*x*x+x-1.2502
    end;
 begin
 writeln('               РЕШЕНИЕ УРАВНЕНИЯ');
 writeln;
 writeln('         РЕШЕНИЕ УРАВНЕНИЯ МЕТОДОМ ХОРД ');
 writeln;
      Write('Введите начальное значение интервала ');
      Read (A);
      Write('Введите конечное значение интервала  ');
      Read (B);
    e:=0.00001;n:=4;
    d:=0;x:=a;
    f1:=y(x);x:=b;f2:=y(x);
    IF F1=F2 THEN  Writeln('На интервале корней нет')
    ELSE BEGIN
      repeat
      x1:=x;
      x:=a-f1*(a-b)/(f1-f2);
      d:=y(x);
       if (f1>0) and (d>0) then
        begin
         a:=x;f1:=d
        end
       else
        begin
         b:=x;f2:=d
        end;
       until abs(x-x1)<e;
   KORX:=X1;
   CLRSCR;
   writeln('     РЕШЕНИЕ УРАВНЕНИЯ МЕТОДОМ ХОРД ');
   writeln;
             writeln('Полученный корень   ',korx:10:6);
             END;
             readkey;
 end;
procedure kasat;
     var
      x,g,x1,a,b,e:EXTENDED;
      i,n:longint;
     function SyX(x:real):EXTENDED;
      Begin
       SyX:=0.25*x*x*x+x-1.2502;
      End;
     function v(x:real):real;
      Begin
       v:=0.75*x*x+1
      End;
    BEGIN
      writeln('               РЕШЕНИЕ УРАВНЕНИЯ');
      writeln;
      writeln('   РЕШЕНИЕ УРАВНЕНИЯ МЕТОДОМ КАСАТЕЛЬНЫХ ');
      writeln;
      Write('Введите начальное значение интервала ');
     Read (A);
      Write('Введите конечное значение интервала  ');
     Read (B);
       e:=0.00001;
       g:=1;X1:=1;
       while abs(g)>e do
        Begin
         g:=v(x1);
         g:=SyX(x1)/g;
         x1:=x1-g;
        End;
         g:=SyX(x);
        kork:=x1;
        CLRSCR;
        writeln('     РЕШЕНИЕ УРАВНЕНИЯ МЕТОДОМ КАСАТЕЛЬНЫХ ');
        writeln;
        writeln('Полученный корень   ',korK:10:6);
        readkey;
    END;

begin
okno;
poslpoisk;
clrscr;
xord;
clrscr;
kasat;
WRITELN(filer,'            РЕШЕНИЕ УРАВНЕНИЯ');
WRITELN(filer,'');
WRITELN(filer,'         ОТДЕЛЕНИЕ КОРНЕЙ МЕТОДОМ');
WRITELN(filer,'        ПОСЛЕДОВАТЕЛЬНОГО ПЕРЕБОРА');
IF DA<>TRUE THEN Writeln(FILER,'На интервале корней нет') ELSE
WRITELN(filer,'Полученный корень   ',korp:10:6);
WRITELN(filer,'');
WRITELN(filer,'    РЕШЕНИЕ УРАВНЕНИЯ МЕТОДОМ ХОРД ');
WRITELN(filer,'Полученный корень   ',korx:10:6);
WRITELN(filer,'');
WRITELN(filer,'   РЕШЕНИЕ УРАВНЕНИЯ МЕТОДОМ КАСАТЕЛЬНЫХ ');
WRITELN(filer,'Полученный корень   ',korK:10:6);


end;
procedure opcmenu;
begin
case  menunom of
'1':begin zastavca;close(filer); exit; end;
'2':begin uravn;MENU;opcmenu;end;
'3':begin diffur;MENU;opcmenu;end;
'4':begin integral;MENU;opcmenu;end;
'5':begin VVODGAUSS;mgauss;zapfilegauss;MENU;opcmenu; end;
end;
end;

{======Главная программа======}
begin
assign(filer,'kURS.REZ');
rewrite(filer);
zastavca;
menu;
opcmenu;
end.