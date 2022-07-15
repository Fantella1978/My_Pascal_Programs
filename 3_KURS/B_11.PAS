Program B_11; {реш. сист. ур-ий методами ГАУССА и ИТЕРАЦИЙ}

const
	n = 2; {количество уpавнений}
	e = 1e-5; {точность}
	  
var
	a, a1: array [1..n, 1..n + 1] of real;
	xg, xi, xt: array[1..n] of real;
	i, j, k: integer;
	y: real; {y-значение ведущего элемента}
	sg, si, w: real;
	Error, EndSearch: boolean;
	
BEGIN
	Randomize;
	for i := 1 to n do
		for j := 1 to n + 1 do
		begin
			a[i, j] := 10 * random; {случайным образом задаем коэфф.}
			a1[i, j] := a[i, j];
		end;
		
	{--------------- Метод ГАУССА -----------------}
	for i := 1 to n do {изучение макс. кооф. при x[i]}
	begin
		k := i;
		y := a[i, i]; {вед. элементу := a[i, i]- кооф. главной диаг.}
		for j := i + 1 to n do
		begin
			w:=a[j,i];
			if abs(w) < abs(y)
				then {кооф. на главной диаг. должен}
				begin {быть больше последующего элемента}
					k := j; {иначе происходит смена ведущего элемента}
					y := w
				end;
		end;
		if abs(y) < e
			then {ведущий элемент меньше точности}
			begin {матрица вырождена и не имеет решений}
				Writeln('Методом ГАУССА решить невозможно.');
				exit;
			end;
		for j := i to n + 1 do {цикл перестановки кооф. и уравн.}
		begin {деление последнего на Y }
			w := a[k, j];
			a[k, j] := a[i, j];
			a[i, j] := w / y;
		end;
		for k := i + 1 to n do {определение наддиаг. элементов}
			for j := n + 1 downto i + 1 do
				a[k, j] := a[k, j] - a[i, j] * a[k, i];
	end;
	for i := n downto 1 do
	begin
		w := 0;
		for j := i + 1 to n do
			w := w + a[i, j] * xg[j];
		xg[i] := a[i, n + 1] - w;
	end;
	
	{--------------- Метод ИТЕРАЦИЙ -----------------}
	for i := 1 to n do
	for j := 1 to n + 1 do
		a[i, j] := a1[i, j]; {восстановка коэф.}
	for i := 1 to n do
	begin
		for j := i + 1 to n do
			if a[i, j] >= a[i, i] then error := true;
		for j := i - 1 downto 1 do
			if a[i, j] >= a[i, i] then error := true;
	end; {на главной диагонали должны быть}
	if error
	then {максимальные коэффициенты}
		begin
			Writeln('Методом ИТЕРАЦИЙ решить невозможно.');
			exit;
		end;
	repeat
		for j := 1 to n do xi[j] := xt[j];
		for j := 1 to n do xt[j] := a[j, n + 1];
		for j := 1 to n do
		begin
			for i := 1 to n do
				if j <> i then xt[j] := xt[j] - a[j, i] * xi[i];
			xt[j] := xt[j] / a[j, j];
		end;
		EndSearch := True;
		for j := 1 to n do
			if abs(xt[j] - xi[j]) > e then EndSearch := False;
	until EndSearch;
	Writeln('Корни:_ГАУССА_ИТЕРАЦИЙ_Проверка:_ГАУССА_ИТЕРАЦИЙ_');
	For i := 1 to n do
	begin
		Write('X(', i:2, ')=', xg[i]:7:2, ' ', xi[i]:7:2, '|       ');
		sg := 0;
		si := 0;
		For j := 1 to n do
		begin
			sg := sg + a1[i, j] * xg[j];
			si := si + a1[i, j] * xi[j];
		end;
		Writeln(sg:5:3, '=', a1[i, n + 1]:5:3, '  ', si:5:3, '=', a1[i,n + 1]:5:3);
	end;
END.