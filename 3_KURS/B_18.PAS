Program B_18; {��⮤ ��᫥����⥫쭮�� ��ॡ��}

Uses
	crt;

Var
	Xn, Xk, dx, y, x : real;
	f, f1, i : boolean;

Begin
	clrscr;
	write('������ ������ �࠭��� ���ࢠ��:');
	readln(Xn);
	write('������ ������ �࠭��� ���ࢠ��:');
	readln(Xk);
	write('������ 蠣 ���� dx =');
	readln(dx);
	writeln;
	x := Xn;
	y := x * x - sin(x) - 0.25; {H��. ���祭�� �㭪樨}
	i := False; {䫠� ������ ��� ������ ����}
	if y < 0 {��⠭���� 䫠�� ��砫쭮�� ����� �-樨 Y}
		then f := True
		else f := False;
	f1 := f;
	x := Xn + dx;
	while x < Xk do
	begin
		y := x * x - sin(x) - 0.25; {����� �-樨 y}
		if y < 0 {��⠭���� 䫠�� ⥪�饣� ����� �-樨 Y}
			then f1 := True
			else f1 := False;
		if f <> f1 {�஢�ઠ ᬥ�� �-樥� Y �����}
			then
			begin  {������ ��७�}
				writeln('��७� �ࠢ����� X=', x - dx / 2:6:4);
				F := F1;
				i := True;
			end;
		x := x + dx;
	end;
	if not i
		then writeln('� ������ ���ࢠ�� ��୨ �� �������.');
End.