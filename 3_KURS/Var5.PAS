Program var5;
{Для того, чтобы решение сходилось необходимо выполнение следующего
  условия
     |F'(x)<1|<1 при всех Х из рабочего интервала
  разумеется, что рабочий интервал зависит от начального значения.
  В данном случае в качестве начального значения задано
  Х0=1.2}
uses crt;
const x0=1.2;
      e=1e-6;
      n=1000; {Максимальное число итераций}
var x:real;
    s:boolean;
    i:integer;

function ff(x:real):real;
begin
  ff:=cos(x)+0.5;
end;

begin
  clrscr;
  s:=false;
  x:=x0;
  for i:=1 to n do
    begin
      if abs(ff(x)-x)<e*abs(x) then begin s:=true;break end;
      x:=ff(x);
    end;
  if s then writeln('Корень уравнения X=',x:10:5)
       else writeln('Измените начальное значение');
  readln;
end.