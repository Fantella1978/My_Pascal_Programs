Program B_18; {Метод последовательного перебора}

Uses
	crt;

Var
	Xn, Xk, dx, y, x : real;
	f, f1, i : boolean;

Begin
	clrscr;
	write('Введите нижнюю границу интервала:');
	readln(Xn);
	write('Введите верхнюю границу интервала:');
	readln(Xk);
	write('Введите шаг расчета dx =');
	readln(dx);
	writeln;
	x := Xn;
	y := x * x - sin(x) - 0.25; {Hач. значение функции}
	i := False; {флаг наличия хоть одного корня}
	if y < 0 {Установка флага начального знака ф-ции Y}
		then f := True
		else f := False;
	f1 := f;
	x := Xn + dx;
	while x < Xk do
	begin
		y := x * x - sin(x) - 0.25; {Расчет ф-ции y}
		if y < 0 {Установка флага текущего знака ф-ции Y}
			then f1 := True
			else f1 := False;
		if f <> f1 {Проверка смены ф-цией Y знака}
			then
			begin  {найден корень}
				writeln('Корень уравнения X=', x - dx / 2:6:4);
				F := F1;
				i := True;
			end;
		x := x + dx;
	end;
	if not i
		then writeln('В данном интервале корни не найдены.');
End.