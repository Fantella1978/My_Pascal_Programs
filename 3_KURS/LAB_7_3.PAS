Program Electrotechnika;
 Uses Crt,Graph;
 Const n=11;
       Name:Array [1..n] of String=('Формирование матрицы коэффициентов',
       'Формирование массива свободных членов','Индикация содержимого матрицы и массива',
       'Решение системы уравнений первым способом','Решение системы уравнений вторым способом',
       'Сложение комплексных чисел','Вычитание комплексных чисел',
       'Умножение комплексных чисел','Деление комплексных чисел',
       'Проверка решения (баланс мощностей)','Графическая интерпритация действий с комплексными числами');
Type
 CPLX=record
 re: Real;
 im: Real;
      End;
Var c1,c2,c3:CPLX;
    punct,i,j,x,y,l:Integer;
    ch:Char;
    p:Pointer;
    p1,p2,p3,x1,x2:^CPLX;
    Memory_A,Memory_B,Memory_R:Pointer;
    Deistv:String;

 Procedure NewScr;
  Var i:Integer;
  Begin
   TextBackGround(1);
   TextColor(7);
   ClrScr;
   y:=7;
    For i:=1 to n do
     Begin
      GoToXY(20,y);
      Writeln(name[i]);
      y:=y+1;
     End;
  End;


 Procedure Meny(i:Integer);
  Begin
  TextColor(14);
  GoToXY(20,6+i);
  Writeln(name[i]);
  End;

 Procedure Sum;
  Begin
   ClrScr;
   Writeln(' Введите комплексные числа');
   Writeln;
    TextColor(15);
   Writeln('C1: ');
    TextColor(14);
   GoToXY(5,4);
    Write('Re=');
    ReadLn(c1.re);
   GoToXY(5,5);
    Write('Im=');
    ReadLn(c1.im);
    TextColor(15);
   Writeln('C2: ');
    TextColor(14);
   GoToXY(5,7);
    Write('Re=');
    ReadLn(c2.re);
   GoToXY(5,8);
    Write('Im=');
    ReadLn(c2.im);
   c3.re:=c1.re+c2.re;
   c3.im:=c1.im+c2.im;
    Textcolor(15);
    Writeln;
    Writeln('Сумма чисел: Re= ',c3.re:5:3,' Im= ',c3.im:5:3);
   ReadKey;
   Deistv:='Sum';
  End;

 Procedure Raz;
  Begin
   ClrScr;
   Writeln(' Введите комплексные числа');
   Writeln;
    TextColor(15);
   Writeln('C1: ');
    TextColor(14);
   GoToXY(5,4);
    Write('Re=');
    ReadLn(c1.re);
   GoToXY(5,5);
    Write('Im=');
    ReadLn(c1.im);
    TextColor(15);
   Writeln('C2: ');
    TextColor(14);
   GoToXY(5,7);
    Write('Re=');
    ReadLn(c2.re);
   GoToXY(5,8);
    Write('Im=');
    ReadLn(c2.im);
   c3.re:=c1.re-c2.re;
   c3.im:=c1.im-c2.im;
    Textcolor(15);
    Writeln;
    Writeln('Разность чисел: Re= ',c3.re:5:3,' Im= ',c3.im:5:3);
   ReadKey;
   Deistv:='Raz';
  End;

 Procedure Pro;
  Begin
   ClrScr;
   Writeln(' Введите комплексные числа');
   Writeln;
    TextColor(15);
   Writeln('C1: ');
    TextColor(14);
   GoToXY(5,4);
    Write('Re=');
    ReadLn(c1.re);
   GoToXY(5,5);
    Write('Im=');
    ReadLn(c1.im);
    TextColor(15);
   Writeln('C2: ');
    TextColor(14);
   GoToXY(5,7);
    Write('Re=');
    ReadLn(c2.re);
   GoToXY(5,8);
    Write('Im=');
    ReadLn(c2.im);
   c3.re:=c1.re*c2.re-c1.im*c2.im;
   c3.im:=c1.re*c2.im+c2.re*c1.im;
    Textcolor(15);
    Writeln;
    Writeln('Произведение чисел: Re= ',c3.re:5:3,' Im= ',c3.im:5:3);
   ReadKey;
   Deistv:='Pro';
  End;

 Procedure Del;
  Begin
   ClrScr;
   Writeln(' Введите комплексные числа');
   Writeln;
    TextColor(15);
   Writeln('C1: ');
    TextColor(14);
   GoToXY(5,4);
    Write('Re=');
    ReadLn(c1.re);
   GoToXY(5,5);
    Write('Im=');
    ReadLn(c1.im);
    TextColor(15);
   Writeln('C2: ');
    TextColor(14);
   GoToXY(5,7);
    Write('Re=');
    ReadLn(c2.re);
   GoToXY(5,8);
    Write('Im=');
    ReadLn(c2.im);
   If (c2.re=0) and (c2.im=0) Then Writeln('Деление на ноль!') Else
    Begin
     c3.re:=(c1.re*c2.re+c1.im*c2.im)/(sqr(c2.re)+sqr(c2.im));
     c3.im:=(c2.re*c1.im-c1.re*c2.im)/(sqr(c2.re)+sqr(c2.im));
      Textcolor(15);
       Writeln;
       Writeln('Часное чисел: Re= ',c3.re:5:3,' Im= ',c3.im:5:3);
    End;
   ReadKey;
   Deistv:='Del';
  End;

 Procedure FormMat;
  Begin
   ClrScr;
    Writeln('Размерность матрицы коэффициентов:');
    Write(' N= ');
    Readln(l);
    GetMem(Memory_A,l*l*SizeOf(CPLX));
    p1:=Memory_A;
    x:=3;
    y:=5;
     For i:=1 to l do
      Begin
      For j:=1 to l do
       Begin
         GoToXY(x,y);
         TextColor(15);
        Write('A[',i:2,'][',j:2,']');
         TextColor(14);
        y:=y+1;
         GoToXY(x,y);
        Write('Re= ');
        Readln(p1^.re);
        x:=x+8;
         GoToXY(x,y);
        Write('Im= ');
        Readln(p1^.im);
        x:=x+13;
        y:=y-1;
        Inc(p1);
       End;
       y:=y+3;
       x:=3;
      End;
     Writeln('**************************************************************');
    ReadKey;
  End;

 Procedure Indicat;
  Begin
    ClrScr;
   If l=0 Then Writeln('Матрица и массив не заполнены') Else
    Begin
     Writeln('Были введены:'  );
    x:=3;
    y:=3;
      p1:=Memory_A;
     For i:=1 to l do
      Begin
      For j:=1 to l do
       Begin
         GoToXY(x,y);
         TextColor(15);
        Write('A[',i:2,'][',j:2,']');
         TextColor(14);
        y:=y+1;
         GoToXY(x,y);
        Write('Re= ',p1^.re:5:2);
        x:=x+10;
         GoToXY(x,y);
        Write('Im= ',p1^.im:5:2);
        x:=x+15;
        y:=y-1;
        Inc(p1);
       End;
       y:=y+3;
       x:=3;
      End;
     Writeln;
     Writeln('**************************************************************');
     p2:=Memory_B;
    x:=3;
    y:=WhereY+1;
     For i:=1 to l do
       Begin
         GoToXY(x,y);
         TextColor(15);
        Write('B[',i:2,']');
         TextColor(14);
        y:=y+1;
         GoToXY(x,y);
        Write('Re= ',p2^.re:5:2);
        x:=x+10;
         GoToXY(x,y);
        Write('Im= ',p2^.im:5:2);
        y:=y+2;
        x:=3;
        Inc(p2);
       End;
     Writeln;
     Writeln('**************************************************************');
    End;
   ReadKey;
  End;

 Procedure FreeM;
   Begin
    If l=0 Then Begin
                 ClrScr;
                 Writeln('Заполните сначала матрицу коэффициентов')
                End
    Else
  Begin
   ClrScr;
    GetMem(Memory_B,l*SizeOf(CPLX));
    p2:=Memory_B;
    x:=3;
    y:=3;
    Writeln('Введите свободные члены:');
     For i:=1 to l do
       Begin
         GoToXY(x,y);
         TextColor(15);
        Write('B[',i:2,']');
         TextColor(14);
        y:=y+1;
         GoToXY(x,y);
        Write('Re= ');
        Readln(p2^.re);
        x:=x+8;
         GoToXY(x,y);
        Write('Im= ');
        Readln(p2^.im);
        y:=y+2;
        x:=3;
        Inc(p2);
       End;
     Writeln('**************************************************************');
  End;
    ReadKey;
   End;

 Procedure Graf;
  Var Driver,Mode,Shag:Integer;
      St:String;
      zoom:Real;
  Begin
   ClrScr;
    If deistv='' Then Begin
                       Writeln('Сначала нужно выполнить действие с комплексными числами');
                       ReadKey;
                      End
    Else
  Begin
   Driver:=Detect;
    InitGraph(Driver,Mode,'');
    SetColor(14);
    SetBkColor(1);
    zoom:=1;
   Repeat
    SetColor(14);
    ClearDevice;
    SetTextStyle(8,0,2);
     If deistv='Sum' Then OutTextXY(30,10,'Addition');
     If deistv='Raz' Then OutTextXY(30,10,'Difference');
     If deistv='Pro' Then OutTextXY(30,10,'Multiplication');
     If deistv='Del' Then OutTextXY(30,10,'Division');
    SetLineStyle(0,0,3);
    SetTextStyle(2,0,5);
    SetColor(15);
     Line(250,10,300,10);
    SetColor(7);
     Line(250,25,300,25);
    SetColor(4);
     Line(250,40,300,40);
    SetColor(14);
     OutTextXY(320,2,'First complex number');
     OutTextXY(320,17,'Second complex number');
     OutTextXY(320,32,'Result complex number');
     OutTextXY(550,5,'+ MORE');
     OutTextXY(550,20,'- LESS');
    SetLineStyle(1,0,0);
     x:=50;
     shag:=50;
    For i:=1 to 11 do
     Begin
      Line(x,50,x,450);
      x:=x+shag;
     End;
     y:=50;
    For i:=1 to 9 do
     Begin
      Line(50,y,550,y);
      y:=y+shag;
     End;
    SetLineStyle(0,0,3);
     Line(50,250,550,250);
     x:=50;
    SetTextStyle(2,0,4);
    For i:=-5 to 5 do
     Begin
      Str(i*zoom:3:2,st);
      OutTextXY(x+3,253,st);
      x:=x+shag;
     End;
     Line(300,50,300,450);
     y:=50;
    For i:=4 downto -4 do
     Begin
      Str(i*zoom:3:2,st);
      OutTextXY(303,y+3,st);
      y:=y+shag;
     End;
    SetColor(15);{***C1***}
     Line(300,250,300+Round(c1.re*shag/zoom),250-Round(c1.im*shag/zoom));
    SetColor(7);{***C2***}
     Line(300,250,300+Round(c2.re*shag/zoom),250-Round(c2.im*shag/zoom));
    SetColor(4);{***C3***}
     Line(300,250,300+Round(c3.re*shag/zoom),250-Round(c3.im*shag/zoom));
    ch:=ReadKey;
    If ch=#43 Then zoom:=zoom/2;{+++++}
    If ch=#45 Then zoom:=zoom*2;{-----}
   Until ch=#27;
   CloseGraph;
   ch:=' ';
  End;
  End;

procedure Press;
begin
Writeln;
TextColor(7);
Writeln('                       Нажмите любую клавишу ');
ReadKey;
end;

procedure Win(x:Integer;y:Integer;xd:Integer;yd:Integer;tc:Integer;bc: Integer);
Begin
ClrScr;
Window(x,y,xd,yd);
TextColor(tc);
TextBackGround(bc);
ClrScr;
end;

procedure PreOper;
begin
Writeln;
Write('   Complex число 1: ░░░░░░░░░░░░░░ i ░░░░░░░░░░░░░░░░   ');
Gotoxy(21,Wherey);
TextColor(15);
Read(c1.re);
Gotoxy(38,Wherey-1);
Readln(c1.im);

TextColor(14);
Write('   Complex число 2: ░░░░░░░░░░░░░░ i ░░░░░░░░░░░░░░░░   ');
Gotoxy(21,Wherey);
TextColor(15);
Read(c2.re);
Gotoxy(38,Wherey-1);
Readln(c2.im);
end;

procedure Add(Var CheckWork: Boolean;otype : Integer);
begin
Win(2,2,78,20,14,1);
Writeln;
Writeln('   Операция = сложение.');
If otype=0 then PreOper;
c3.re:=c1.re + c2.re;
c3.im:=c1.im + c2.im;
Writeln;
Writeln('   Результат: ',c3.re:5:3,' i ',c3.im:5:3);
if otype=0 then Press;
CheckWork:=TRUE;
end;

procedure Sub(Var CheckWork: Boolean;otype : Integer);
begin
Win(2,2,78,20,14,1);
Writeln;
Writeln('   Операция = вычитание.');
If otype=0 then PreOper;
c3.re:=c1.re - c2.re;
c3.im:=c1.im - c2.im;
Writeln;
Writeln('   Результат: ',c3.re:5:3,' i ',c3.im:5:3);
if otype=0 then Press;
CheckWork:=TRUE;
end;

procedure Mult(Var CheckWork: Boolean;otype : Integer);
begin
Win(2,2,78,20,14,1);
Writeln;
Writeln('   Операция = умножение.');
If otype=0 then PreOper;
c3.re:=c1.re*c2.re - c1.im*c2.im;
c3.im:=c1.re*c2.im + c2.re*c1.im;
Writeln;
Writeln('   Результат: ',c3.re:5:3,' i ',c3.im:5:3);
if otype=0 then Press;
CheckWork:=TRUE;
end;

procedure Divd(Var CheckWork: Boolean;otype : Integer);
begin
Win(2,2,78,20,14,1);
Writeln;
Writeln('   Операция = деление.');
If otype=0 then PreOper;
if (c2.re = 0) and (c2.im = 0) then
begin
TextColor(14);
Writeln;
Writeln('   Деление на 0. ');
Press;
Exit;
end;
c3.re:=(c1.re*c2.re + c1.im*c2.im ) / (c2.re*c2.re + c2.im*c2.im);
c3.im:=(c1.im*c2.re - c1.re*c2.im ) / (c2.re*c2.re + c2.im*c2.im);
Writeln;
TextColor(15);
Writeln('   Результат: ',c3.re:5:3,' i ',c3.im:5:3);
if otype=0 then Press;
CheckWork:=TRUE;
end;

procedure GAUSS(size: Integer;big: Pointer;x1: Pointer;nz: Pointer;
                CheckInput: Boolean);
Var z,k,m,j,i    : Integer;
    ti,tr        : Real;
    bigP,nzP,x1P : Pointer;
    zagl         : Boolean;
        function OCR(BegMass : Pointer;i :Integer;j: Integer):Real;
        Var S : Integer;
            P :^CPLX;
        begin
        P:=BegMass;
        if BegMass=x1  then S:=1;
        if BegMass=big then S:=Size+1;
        if BegMass=nz  then S:=Size+1;
        Inc(P,(i-1)*S+j-1);
        OCR:=P^.re;
        end;

        function OCI(BegMass : Pointer;i :Integer; j: Integer):Real;
        Var S : Integer;
            P :^CPLX;
        begin
        P:=BegMass;
        if BegMass=x1  then S:=1;
        if BegMass=big then S:=Size+1;
        if BegMass=nz  then S:=Size+1;
        Inc(P,(i-1)*S+j-1);
        OCI:=P^.im;
        end;

        procedure ICR(BegMass : Pointer;i :Integer;j: Integer; r: Real);
        Var S : Integer;
            P :^CPLX;
        begin
        P:=BegMass;
        if BegMass=x1  then S:=1;
        if BegMass=big then S:=Size+1;
        if BegMass=nz  then S:=Size+1;
        Inc(P,(i-1)*S+j-1);
        P^.re:=r;
        end;

        procedure ICI(BegMass : Pointer;i :Integer; j: Integer; im: Real);
        Var S : Integer;
            P :^CPLX;
        begin
        P:=BegMass;
        if BegMass=x1  then S:=1;
        if BegMass=big then S:=Size+1;
        if BegMass=nz  then S:=Size+1;
        Inc(P,(i-1)*S+j-1);
        P^.im:=im;
        end;

begin
Win(2,2,78,20,14,1);
If l=0 then
   begin
   Writeln;
   Writeln('   GAUSS: Решение невозможно - заполните матрицы.');
   Press;
   Exit;
   end;

bigP:=big;
x1P:=x1;
nzP:=nz;

z:=0;
Repeat
    inc(z);
    k:=z;
    while (OCR(bigP,k,z) = 0) and (OCI(bigP,k,z) = 0) do
      begin
        inc(k);
        if k>Size then
          Begin
            Win(2,2,78,20,14,1);
            Writeln;
            Writeln('               ╔═════════════════════════════════════════╗');
            Writeln('               ║  При введённых коэффициентах            ║');
            Writeln('               ║  в ходе выполнения программы возникнет  ║');
            Writeln('               ║  ошибка "Деление на 0". Следовательно,  ║');
            Writeln('               ║  метод Гаусса непременим.               ║');
            Writeln('               ╚═════════════════════════════════════════╝');
            TextColor(15);
            ReadKey;
            Press;
            Exit;
          End;
      end;

if k<>z then
for m:=z to Size+1 do
begin
tr:=OCR(bigP,z,m);
ti:=OCI(bigP,z,m);
   ICR(bigP,z,m,OCR(bigP,k,m));
   ICI(bigP,z,m,OCI(bigP,k,m));
ICR(bigP,k,m,tr);
ICI(bigP,k,m,ti);
end;

for j:=Size+1 downto z do
begin
c1.re:=OCR(bigP,z,j);
c1.im:=OCI(bigP,z,j);
c2.re:=OCR(bigP,z,z);
c2.im:=OCI(bigP,z,z);    DIVD(zagl,1);
ICR(bigP,z,j,c3.re);
ICI(bigP,z,j,c3.im);
end;

m:=Size+1;
if k+1<=Size then
for i:=k+1 to Size do
for j:=z+1 to m do
begin
c1.re:=OCR(bigP,i,z);
c1.im:=OCI(bigP,i,z);
c2.re:=OCR(bigP,z,j);
c2.im:=OCI(bigP,z,j);  MULT(zagl,1);
c2.re:=c3.re;
c2.im:=c3.im;
c1.re:=OCR(bigP,i,j);
c1.im:=OCI(bigP,i,j);  SUB(zagl,1);

ICR(bigP,i,j,c3.re);
ICI(bigP,i,j,c3.im);
end;
Until z=Size;

for i:=Size downto 1 do
begin
ICR(x1P,i,1,OCR(bigP,i,m));
ICI(x1P,i,1,OCI(bigP,i,m));
   if i<>1 then
   for k:=i-1 downto 1 do
   begin
   c1.re:=OCR(bigP,k,i);
   c1.im:=OCI(bigP,k,i);
   c2.re:=OCR(x1P,i,1);
   c2.im:=OCI(x1P,i,1);  MULT(zagl,1);
   c2.re:=c3.re;
   c2.im:=c3.im;
   c1.re:=OCR(bigP,k,m);
   c1.im:=OCI(bigP,k,m);   SUB(zagl,1);

   ICR(bigP,k,m,c3.re);
   ICI(bigP,k,m,c3.im);
   end;
end;

for i:=1 to Size do
   for j:=1 to Size+1 do
   begin
   ICR(bigP,i,j,OCR(nzP,i,j));
   ICI(bigP,i,j,OCI(nzP,i,j));
   end;

For i:=1 to Size do   { Перевод в действующее значение }
begin
c1.re:=OCR(x1P,i,1);
c1.im:=OCI(x1P,i,1);
c2.re:=Sqrt(2);
c2.im:=0;
DIVD(zagl,1);
ICR(x1P,i,1,c3.re);
ICI(x1P,i,1,c3.im);
end;

Win(2,2,78,20,14,1);
Writeln;
Writeln('   Решение по методу Гаусса:');
TextColor(15);
For i:=1 to Size do
Writeln('   Действующее значение контурного тока (',i,') ',OCR(x1P,i,1):10:5,'  i ',OCI(x1P,i,1):10:5);
Readkey;
Press;
end;

Procedure Sozd_Ras;
 Begin
   GetMem(Memory_R,(Sqr(l)+l)*Sizeof(CPLX));
   p1:=Memory_A;
   p2:=Memory_B;
   p3:=Memory_R;
  For i:=1 to l*l+l do
   Begin
If i mod (l+1) = 0  then
  begin
  P3^.re:=P2^.re;
  P3^.im:=P2^.im;
  Inc(P3);
  Inc(P2);
  end
else
begin
P3^.re:=P1^.re;
P3^.im:=P1^.im;
Inc(P1);
Inc(P3);
end;
   End;
{ClrScr;
p3:=Memory_R;
  For i:=1 to l*l+l do
   Begin
    Writeln('Re=',p3^.re,' Im=',p3^.im);
    Inc(p3);
   End;
  ReadKey;}
 End;

procedure Balance;
Var SI,I,E : CPLX;
   SP,R,II : CPLX;
       z,j : Integer;
      zagl : Boolean;
        ch : Char;
begin
Win(2,2,78,20,14,1);
Writeln;


Win(2,2,78,20,15,1);
Writeln;
Writeln('   Расчёт мощности на ЭДС.');
Writeln('   Вводить комплексы ЭДС и комплексы действующих значений тока.');
Writeln('   Окончание ввода: E: Re=0 Im=0. ');
Press;

j:=1;
SI.re:=0;
SI.im:=0;

While TRUE do
begin
Win(2,2,78,20,15,1);
Writeln;
Write('            E [',j,']: Re=               Im=                   ');
Gotoxy(23,Wherey);
Read(E.re);
Gotoxy(41,Wherey-1);
Read(E.im);
If (E.im = 0) and (E.re = 0) then Break;
Write('            I [',j,']: Re=               Im=                   ');
Gotoxy(23,Wherey);
Read(I.re);
Gotoxy(41,Wherey-1);
Read(I.im);

   c1:=E;   { Перевод в действ. з-ние ЭДС }
   c2.re:=Sqrt(2);
   c2.im:=0;   DIVD(zagl,1);
   E:=c3;

   c1.re:=E.re;
   c1.im:=E.im;
   c2.re:=I.re;
   c2.im:=-(I.im);{ приведение комплекса} MULT(zagl,1);
   c1:=c3;
   c2:=SI; ADD(zagl,1);
   SI:=c3;
Inc(j);
end;

j:=1;
Win(2,2,78,20,15,1);
Writeln;
Writeln('   Расчёт мощности на сопротивлениях.');
Writeln('   Вводить комплексы сопротивлений и комплексы действующих значений тока.');
Writeln('   Окончание ввода: R: Re=0 Im=0.');
Press;
SP.re:=0;
SP.im:=0;
While TRUE do
begin
Win(2,2,78,20,15,1);
Writeln;
Write('            R [',j,']: Re=               Im=                   ');
Gotoxy(23,Wherey);
Read(R.re);
Gotoxy(41,Wherey-1);
Read(R.im);
If (R.im = 0) and (R.re = 0) then Break;
Write('            I [',j,']: Re=               Im=                  ');
Gotoxy(23,Wherey);
Read(II.re);
Gotoxy(41,Wherey-1);
Read(II.im);


   c1:=II;
   c2:=R;  MULT(zagl,1);
      c1:=c3;
      c2.re:=II.re;
      c2.im:=-(II.im);{ приведение комплекса} MULT(zagl,1);
   c1:=c3;
   c2:=SP; ADD(zagl,1);
   SP:=c3;
Inc(j);
end;

c1:=SI;
c2:=SP;
SUB(zagl,1);
Win(2,2,78,20,14,1);
Writeln;
Writeln('   Мощность, отдаваемая ЭДС : ',SI.re:10:5,'  i ',SI.im:10:5);
Writeln('   Мощность, потребляемая   : ',SP.re:10:5,'  i ',SP.im:10:5);
Writeln('   -------------------------| ');
Writeln('   Несхождение баланса      : ',Abs(c3.re):10:5,'  i ',Abs(c3.im):10:5);
Press;
end;


procedure ITERATIONS(size: Integer; a: Pointer;b: Pointer;
                     big: Pointer;x1: Pointer;x2: Pointer;nz: Pointer;
                     CheckInput: Boolean);
Const e=1e-5;
Var i,j : Integer;
    bigP,nzP,x2P,x1P : Pointer;
    zagl             : Boolean;
    sum              : CPLX;

        function OCR(BegMass : Pointer;i :Integer;j: Integer):Real;
        Var S : Integer;
            P :^CPLX;
        begin
        P:=BegMass;
        if BegMass=x1  then S:=1;
        if BegMass=x2  then S:=1;
        if BegMass=big then S:=Size+1;
        Inc(P,(i-1)*S+j-1);
        OCR:=P^.re;
        end;

        function OCI(BegMass : Pointer;i :Integer; j: Integer):Real;
        Var S : Integer;
            P :^CPLX;
        begin
        P:=BegMass;
        if BegMass=x1  then S:=1;
        if BegMass=x2  then S:=1;
        if BegMass=big then S:=Size+1;
        Inc(P,(i-1)*S+j-1);
        OCI:=P^.im;
        end;

        procedure ICR(BegMass : Pointer;i :Integer;j: Integer; r: Real);
        Var S : Integer;
            P :^CPLX;
        begin
        P:=BegMass;
        if BegMass=x1  then S:=1;
        if BegMass=x2  then S:=1;
        if BegMass=big then S:=Size+1;
        Inc(P,(i-1)*S+j-1);
        P^.re:=r;
        end;

        procedure ICI(BegMass : Pointer;i :Integer; j: Integer; im: Real);
        Var S : Integer;
            P :^CPLX;
        begin
        P:=BegMass;
        if BegMass=x1  then S:=1;
        if BegMass=x2  then S:=1;
        if BegMass=big then S:=Size+1;
        Inc(P,(i-1)*S+j-1);
        P^.im:=im;
        end;

        function CheckEnd:Boolean;
        Var   summa : CPLX;
                z,k : Integer;

        begin
        CheckEnd:=TRUE;
        For z:=1 to Size do
        Begin
        summa.re:=0;
        summa.im:=0;
                 For k:=1 to Size do
                 begin
                 c1.re:=OCR(bigP,z,k);
                 c1.im:=OCI(bigP,z,k);
                 c2.re:=OCR(x2P,k,1);
                 c2.im:=OCI(x2P,k,1);   MULT(zagl,1);

                 c1.re:=summa.re;
                 c1.im:=summa.im;
                 c2.re:=c3.re;
                 c2.im:=c3.im;        ADD(zagl,1);

                 summa.re:=c3.re;
                 summa.im:=c3.im;
                 end;

                 c1.re:=summa.re;
                 c1.im:=summa.im;
                 c2.re:=OCR(bigP,z,Size+1);
                 c2.im:=OCI(bigP,z,Size+1);  SUB(zagl,1);
                  If Sqrt(Sqr(c3.re)+Sqr(c3.im)) > e then CheckEnd:=FALSE;
        end;
        end;

begin
Win(2,2,78,20,14,1);
If l=0 then
   begin
   Writeln;
   Writeln('   ITERATIONS: Решение невозможно - заполните матрицы.');
   Press;
   Exit;
   end;

bigP:=big;
x1P:=x1;
x2P:=x2;

(* ...............Массив х1 использyется как beta *)
For i:=1 to Size do
begin
c1.re:=OCR(bigP,i,Size+1);
c1.im:=OCI(bigP,i,Size+1);
c2.re:=OCR(bigP,i,i);
c2.im:=OCI(bigP,i,i);       DIVD(zagl,1);
ICR(x1P,i,1,c3.re);
ICI(x1P,i,1,c3.im);
end;

For i:=1 to Size do
begin
ICR(x2P,i,1,OCR(bigP,i,Size+1));
ICI(x2P,i,1,OCI(bigP,i,Size+1));
end;

Repeat
For i:=1 to Size do
begin
     sum.re:=0;
     sum.im:=0;

     For j:=1 to Size do
     if j <> i then
     begin
     c1.re:=OCR(bigP,i,j);
     c1.im:=OCI(bigP,i,j);
     c2.re:=OCR(x2P,j,1);
     c2.im:=OCI(x2P,j,1);   MULT(zagl,1);

     c1.re:=c3.re;
     c1.im:=c3.im;
     c2.re:=OCR(bigP,i,i);
     c2.im:=OCI(bigP,i,i);  DIVD(zagl,1);

     c1.re:=c3.re;
     c1.im:=c3.im;
     c2.re:=sum.re;
     c2.im:=sum.im;   ADD(zagl,1);

     sum.re:=c3.re;
     sum.im:=c3.im;
     end;

c1.re:=OCR(x1P,i,1);
c1.im:=OCI(x1P,i,1);
c2.re:=sum.re;
c2.im:=sum.im;  SUB(zagl,1);
ICR(x2P,i,1,c3.re);
ICI(x2P,i,1,c3.im);
end;
Until CheckEnd=TRUE;

For i:=1 to Size do   { Перевод в действующее значение }
begin
c1.re:=OCR(x2P,i,1);
c1.im:=OCI(x2P,i,1);
c2.re:=Sqrt(2);
c2.im:=0;   DIVD(zagl,1);
ICR(x2P,i,1,c3.re);
ICI(x2P,i,1,c3.im);
end;

Win(2,2,78,20,14,1);
Writeln;
Writeln('   Решение по методу итераций (точность = 0.00001):');
TextColor(15);
For i:=1 to Size do
Writeln('   Действующее значение контурного тока (',i,') ',OCR(x2P,i,1):10:5,'  i ',OCI(x2P,i,1):10:5);
Press;
end;


 Begin
  l:=0;
  punct:=1;
  Deistv:='';
  NewScr;
  Meny(punct);
  Repeat
   ch:=ReadKey;
    Case ch of
     #72: Begin
           If punct=1 Then Begin
                        punct:=n;
                        NewScr;
                        Meny(punct);
                       End
           Else Begin
                 punct:=punct-1;
                 NewScr;
                 Meny(punct);
                End;
          End;
     #80: Begin
           If punct=n Then Begin
                        punct:=1;
                        NewScr;
                        Meny(punct);
                       End
           Else Begin
                 punct:=punct+1;
                 NewScr;
                 Meny(punct);
                End;
          End;
     #13: Begin
           Case punct of
            1: Begin
                FormMat;
                NewScr;
                Meny(punct);
               End;
            2: Begin
                FreeM;
                NewScr;
                Meny(punct);
               End;
            3: Begin
                Indicat;
                NewScr;
                Meny(punct);
               End;
            4: Begin
                Sozd_Ras;
   GetMem(x1,l*Sizeof(CPLX));
                p3:=Memory_R;
                Gauss(l,p3,x1,Memory_R,True);
                NewScr;
                Meny(punct);
               End;
            5: Begin
   GetMem(x1,l*Sizeof(CPLX));
   GetMem(x2,l*Sizeof(CPLX));
               p1:=Memory_A;
               p2:=Memory_B;
               p3:=Memory_R;
               Iterations(l,p1,p2,p3,x1,x2,Memory_R,True);
               NewScr;
               Meny(punct);
               End;
            6: Begin
                Sum;
                NewScr;
                Meny(punct);
               End;
            7: Begin
                Raz;
                NewScr;
                Meny(punct);
               End;
            8: Begin
                Pro;
                NewScr;
                Meny(punct);
               End;
            9: Begin
                Del;
                NewScr;
                Meny(punct);
               End;
           10: Begin
                Balance;
                NewScr;
                Meny(punct);
               End;
           11: Begin
                Graf;
                NewScr;
                Meny(punct);
               End;
           End;
          End;
    End;
  Until ch=#27;
{   FreeMem(Memory_A,l*l*SizeOf(CPLX));}
{   FreeMem(Memory_B,l*SizeOf(CPLX));}
 End.