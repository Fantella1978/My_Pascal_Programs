Program B_11; {��. ���. ��-�� ��⮤��� ������ � ��������}

const
	n = 2; {������⢮ �p�������}
	e = 1e-5; {�筮���}
	  
var
	a, a1: array [1..n, 1..n + 1] of real;
	xg, xi, xt: array[1..n] of real;
	i, j, k: integer;
	y: real; {y-���祭�� ����饣� �������}
	sg, si, w: real;
	Error, EndSearch: boolean;
	
BEGIN
	Randomize;
	for i := 1 to n do
		for j := 1 to n + 1 do
		begin
			a[i, j] := 10 * random; {��砩�� ��ࠧ�� ������ �����.}
			a1[i, j] := a[i, j];
		end;
		
	{--------------- ��⮤ ������ -----------------}
	for i := 1 to n do {���祭�� ����. ����. �� x[i]}
	begin
		k := i;
		y := a[i, i]; {���. �������� := a[i, i]- ����. ������� ����.}
		for j := i + 1 to n do
		begin
			w:=a[j,i];
			if abs(w) < abs(y)
				then {����. �� ������� ����. ������}
				begin {���� ����� ��᫥���饣� �������}
					k := j; {���� �ந�室�� ᬥ�� ����饣� �������}
					y := w
				end;
		end;
		if abs(y) < e
			then {����騩 ������� ����� �筮��}
			begin {����� ��஦���� � �� ����� �襭��}
				Writeln('��⮤�� ������ ���� ����������.');
				exit;
			end;
		for j := i to n + 1 do {横� ����⠭���� ����. � �ࠢ�.}
		begin {������� ��᫥����� �� Y }
			w := a[k, j];
			a[k, j] := a[i, j];
			a[i, j] := w / y;
		end;
		for k := i + 1 to n do {��।������ �������. ������⮢}
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
	
	{--------------- ��⮤ �������� -----------------}
	for i := 1 to n do
	for j := 1 to n + 1 do
		a[i, j] := a1[i, j]; {����⠭���� ����.}
	for i := 1 to n do
	begin
		for j := i + 1 to n do
			if a[i, j] >= a[i, i] then error := true;
		for j := i - 1 downto 1 do
			if a[i, j] >= a[i, i] then error := true;
	end; {�� ������� ��������� ������ ����}
	if error
	then {���ᨬ���� �����樥���}
		begin
			Writeln('��⮤�� �������� ���� ����������.');
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
	Writeln('��୨:_������_��������_�஢�ઠ:_������_��������_');
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