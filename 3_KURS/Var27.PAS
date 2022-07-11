Program var4;
{Программа приводит к результату в случае, если начальное значение
 выбрано следующим образом
   |F(x0)*F''(x0)|<|F'(x0)|^2
  в данном случае за начальную точку принимаем х0=2} 
uses crt;
const x0=2;
      e=1e-5;
var x,g:real;
    s:boolean;

function ff(x:real):real; {значение функции}
begin
  ff:=2-0.5*x - 1e-5*(exp(2*x)-1);
end;

function ff1(x:real):real; {производная заданной функции}
begin
  ff1:=-0.5-2*1e-5*exp(2*x);
end;

begin
  clrscr;
  s:=true;g:=1;x:=x0;
  while abs(g)>e do
    begin
      g:=ff1(x);
      if g=0 then begin  s:=false;break end;
      g:=ff(x)/g;x:=x-g;
    end;
  if s then writeln('Корень уравнения X=',x:10:5)
       else writeln('Выберите другое начальное значение');
  readln;
end.