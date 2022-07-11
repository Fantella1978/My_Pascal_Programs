Uses Crt;
Const
     e = 0.00001;     {погрешность вычислений}
Var
     s,t, x, en, h:real;
     n:integer;
function fack(x:integer):longint;
begin
     if (x = 0) then fack := 1
     else fack:=x*fack(x-1)
end;

{ Функция возвевения в степень }
function pow(x, p:real):real;
begin
    pow:= abs(x)/x*exp(p*ln(abs(x)))
end;

Begin
     ClrScr;
     x:=-1; en:=1; h:=0.2;

while (x < en) do  { цикл изменения x}
begin
     s:=0; n:=0;
     repeat
           t:=pow(x,n)/fack(n);
           s:=s+t;
           inc(n)
     until(abs(t) < e);
     Writeln('x  ', x:4:1, ',      Сумма ряда  ', s:10:8,';   Проверка:  ', exp(x):10:8);
     x:=x+h;

end;

END.

