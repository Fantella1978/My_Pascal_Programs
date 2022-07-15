Program B_16; {сортировка массива комплексных чисел}
type
	inum = record
		i, j : real;
	end;
var
	mas : array[1..1000] of inum;
	n, k, position : integer;
	temp : inum;
	value, min : real;
begin
	randomize;
	for n := 1 to 1000 do
	begin
		mas[n].i := -10.5 + (10.5 + 30.75) * random;
		mas[n].j := -10.5 + (10.5 + 30.75) * random;
	end;
	write('Hеотсортированый массив:');
	for n := 1 to 1000 do writeln(mas[n].i:8:3, 'i', mas[n].j:8:3, 'j');
	for n := 1 to 1000 do
	begin
		min := sqrt(sqr(mas[n].i) + sqr(mas[n].j));
		position := n;
		for k := n + 1 to 1000 do
			if sqrt(sqr(mas[k].i) + sqr(mas[k].j)) < min
			then
				begin
					min := sqrt(sqr(mas[k].i) + sqr(mas[k].j));
					position := k;
				end;
		temp := mas[n];
		mas[n] := mas[position];
		mas[position] := temp;
	end;
	write('Отсортированый массив:');
	for n := 1 to 1000 do
		writeln(mas[n].i:8:3, 'i', mas[n].j:8:3, 'j');
end.