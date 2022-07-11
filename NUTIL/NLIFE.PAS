program Life;
uses crt;
const
 maxx=12;
 maxy=77;
var
   Field:array [1..maxx,1..maxy] of byte;
   i,j,l,k:byte;
   Sosed:integer;
   Key:byte;
begin
  clrscr;
  writeln('###############################################################################');
  for i:=1 to 12 do writeln('#                                                                             #');
  writeln('###############################################################################');
  writeln('#     ПРОГРАММА  СТУДЕНТА  ГРУППЫ  МА - 95  ПОПОВА ВАДИМА    1 9 9 6 год.     #');
  writeln('###############################################################################');
  gotoxy(1,19);
  writeln('Esc - Выход');
  writeln('Space - Поставить организм');
  writeln('Enter - Окончание расстановки организмов и запуск программы');
  i:=1;
  j:=1;
  repeat
    begin
      gotoxy(j+1,i+1);
      k:=ord(ReadKey);
      if k=72 then i:=i-1;
      if k=80 then i:=i+1;
      if k=75 then j:=j-1;
      if k=77 then j:=j+1;
      if k=27 then
       begin
        clrscr;
        exit;
       end;
      if k=32 then
        begin
          write('▓');
          Field[i,j]:=1;
          gotoxy(j+1,i+1);
        end;
      if i<1 then i:=1;
      if i>maxx then i:=maxx;
      if j>maxy then j:=maxy;
      if j<1 then j:=1;
    end;
  until k=13;
window(1,20,79,22);
clrscr;
window(1,1,80,25);
repeat
  for i:=2 to maxx-1 do
    for j:=2 to maxy-1 do
        begin
          Sosed:=0;
          for l:=0 to 2 do
            for k:=0 to 2 do
             Sosed:=Sosed+(Field[i+l-1,j+k-1] mod 2);
          if (Sosed=3) and (Field[i,j]=0) then Field[i,j]:=2;
          if ((Sosed>4) or (Sosed<3)) and (Field[i,j]=1) then Field[i,j]:=3;
        end;
    for i:=1 to maxx do
      for j:=1 to maxy do
        begin
          if Field[i,j]=2 then Field[i,j]:=1;
          if Field[i,j]=3 then Field[i,j]:=0;
          gotoxy(j+1,i+1);
          if field[i,j]=0
            then write(' ')
            else write('▓');
        end;
until (port[$60]=129);
end.