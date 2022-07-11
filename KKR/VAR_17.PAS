{17вариант}
USES
   CRT;
VAR
   A,B:REAL;
   CH:CHAR;
  PROCEDURE RASCHET1;
  var
     x:array[1..8] of shortint;
     b:shortint;
     a:byte;
     z,z1,z2,y,y1,y2,h:real;
  begin
     randomize;
     for a:=1 to 8 do
       begin
          b:=-20+random(65);
          x[a]:=b;
       end;
     writeln('Введите y начальное');
     readln(y1);
     writeln('Введите y конечное');
     readln(y2);
     writeln('Введите Hy ');
     readln(h);
     for a:=1 to 8 do
       begin
          y:=y1;
          while y<=y2 do
            begin
               z2:=exp(y*ln(abs(x[a])))-arctan(sqrt(1-sqr(2*y/x[a]))/(2*y/x[a]));
               if (z2=0) or (sin(x[a])=0) or (x[a]=0)
               then
                 begin
                    writeln('При x=',x[a],' и y=',y:4:2,'функция не существует');
                    y:=y+h;
                    continue
                 end;
               z1:=cos(x[a])/sin(x[a])-3*exp(exp(1)*ln(pi))*(x[a]*x[a]*x[a]-sqr(y));
               z:=z1/z2;
               writeln('При x=',x[a],' и y=',y:4:2,' значение функции :  z=',z:4:2);
               y:=y+h
            end;
       end;
  end;
  PROCEDURE RASCHET2;
  var
     x,y,x1,x2:real;
  begin
     x1:=-0.2;
     repeat
        if sin(x1*x1)+cos(x1*x1)<10*x1
        then
          begin
             x2:=x1;
             x1:=x1-0.001;
             writeln('Корень уравнения находится в промежутке от ',x1:4:8, ' до ',x2:4:8);
             exit
          end;
        x1:=x1+0.001
     until x2>=0.2;
  end;
BEGIN
   CLRSCR;
   WRITELN('1-табуляция');
   WRITELN('2-уточнение корня');
   WRITELN('3-выход');
   WHILE TRUE DO
     BEGIN
        CH:=READKEY;
        CASE CH OF
           '1': RASCHET1;
           '2': RASCHET2;
           '3':EXIT;
           #27:EXIT;
        END
     END;
   READKEY
END.



























{$N+}10 var
USES CRT,DOS;
CONST KL=10;
VAR CH:CHAR;
    X,I,J,M,FLAG,N:INTEGER;
    A:ARRAY[1..10,1..10] OF REAL;
    B:ARRAY[1..10]  OF REAL;
  PROCEDURE okno;
  begin clrscr;
     gotoxy(5,5);writeln('Формирование файла..1');
     gotoxy(5,10);writeln('Запрос..............2');
     gotoxy(5,15);writeln('Выход...............3');
  end;
  PROCEDURE VVOD;
  begin clrscr;
     write('n='); readln(m) ;
     for i:=1 to m  do
       begin
          for j:=1 to m do
            begin gotoxy(j*10-9,i+1);
            write ('  a',i,j,'=');read(a[i,j]);
            end;
          gotoxy((j+1)*10-9,i+1);
          write('  b',i,'='); readln(b[i]);
       end;
  end;
  PROCEDURE GENMAS;
  begin
     write('ВВЕДИТЕ КОЛЛИЧЕСТВО ЭЛЕМЕНТОВ МАССИВА n=');
     readln(m);randomize;
     for i:=1 to m do
       begin
          for j:=1 to m do
            begin
               a[i,j]:= random; write(' ',a[i,j]:5:2);
            end;
          b[i]:= random; writeln(' ',b[i]:5:2); writeln;
       end;
  end;
  PROCEDURE GAUS;
  var k,p:integer; c,s,r:real;
      x,bgg: array [1..kl] of extended;
      ag: array [1..kl,1..kl] of extended;
    procedure per;
    var i,l,m1:integer;
    begin i:=k+1;l:=k;
       for m1:=k+1 to m do
         if ag[m1,k]>ag[l,k]
       then l:=m1;
       if l=k then
         begin
            for j:=k to m do
              begin r:=ag[k,j];
              ag[k,j]:=ag[i,j];ag[i,j]:=r;
              end;
            r:=bgg[k];bgg[k]:=bgg[l];bgg[l]:=r;
         end;
    end;
  begin
     for i:=1 to m do
       begin
          for j:=1 to m do
            ag[i,j]:=a[i,j];
          bgg[i]:=b[i];
       end;
     for k:=1 to m-1 do
       begin
          if ag[k,k]=0 then per;
          for i:=k+1 to m do
            begin c:=ag[i,k]/ag[k,k];
               ag[i,k]:=0;
               for j:=k+1 to m do
                 ag[i,j]:=ag[i,j]-c*ag[k,j];
               bgg[i]:=bgg[i]-c*bgg[k];
            end;
       end;x[m]:=bgg[m]/ag[m,m];
     for i:=m-1 downto 1 do
       begin s:=0;
          for j:=i+1 to m do
            s:=s+ag[i,j]*x[j];
          x[i]:=(bgg[i]-s)/ag[i,i];
       end;
     for i:=1 to m do
       writeln ('  x',i,'=',x[i]:10:6);p:=0;
     for i:=1 to m do
       begin s:=0;
          for j:=1 to m do
            s:=s+a[i,j]*x[j];
          if abs(s-b[i])>0.001 then p:=1;
       end;
     if p=0
     then writeln('РЕШЕНИЕ ВЕРНО ')
     else writeln('РЕШЕНИЕ НЕ ВЕРНО ');
     repeat until keypressed;
  end;
  PROCEDURE MENU;
  begin okno;
     repeat ch:=readkey;
        if ch='1'then genmas;
        if ch='2'then vvod;
        if (ch='3') or (ch=#27)then halt
        else writeln('no2 !!!');gaus;
     until false;
  end;
BEGIN
   OKNO;
   WHILE NOT((CH=#51)OR(CH=#27)) DO
      MENU;
END.
