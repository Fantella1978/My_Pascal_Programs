{$N+}
USES CRT,DOS;
CONST KL=10;
VAR CH:CHAR;
    X,I,J,M,FLAG,N:INTEGER;
    A:ARRAY[1..10,1..10] OF REAL;
    B:ARRAY[1..10]  OF REAL;
  PROCEDURE okno;
  begin clrscr;
     gotoxy(5,5);writeln('”®ΰ¬¨ΰ®Ά ­¨¥ δ ©« ..1');
     gotoxy(5,10);writeln('‡ ―ΰ®α..............2');
     gotoxy(5,15);writeln('‚λε®¤...............3');
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
     write('‚‚…„’… ‹‹—…‘’‚ ‹……’‚ €‘‘‚€ n=');
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
     then writeln('……… ‚… ')
     else writeln('……… … ‚… ');
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
