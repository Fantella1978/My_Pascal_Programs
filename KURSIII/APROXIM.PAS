{Аппpоксимация в экспоненту}
program as;

uses
	crt;

type
	mas = array[1..12] of real;

const
	n = 12;
	x : mas = (0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110);
	y : mas = (13.707, 10.225, 10.534, 10.564, 10.594, 9.97, 10.543,
             10.642, 11.096, 11.067, 10.723, 12.584);
var
	a, b, y1, s1, s2, s3, s4 : real;
    i : integer;
	
begin
	clrscr;
	s1 := 0;
	s2 := 0;
	s3 := 0;
	s4 := 0;
	for i := 1 to n do
	begin
		s1 := s1 + x[i] * ln(y[i]);
		s3 := s3 + ln(y[i]);
		s2 := s2 + x[i];
		s4 := s4 + x[i] * x[i];
	end;
	b := (s1 - s2 * s3 / n) / (s4 - s2 * s2 / n);
	a := exp((s3 - b * s2) / n);
	writeln('a=', a:7:5, '  b:=', b:10:8);
	y1 := 0;
	for i := 1 to n do
	begin
		for i := 1 to n do
			y1:= y1 + abs(y[i] - (a * exp(b * x[i]))) / y[i] * 100;
		y1 := y1 / 12;
	end;
	writeln('e=', y1:10:8);
	readln;
end.