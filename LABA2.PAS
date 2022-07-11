Program Primer_2;
  var
     a,x: Real;
begin
a:=0.99;
  If (cos(9*Pi*2-2*a)+2*cos(Pi/6+2*a))=0 then Writeln('Delenie na 0 !!!')
     else
       begin
         x:=(2*cos(Pi/6-2*a)-sqrt(3)*sin(5*Pi/2-2*a))/(cos(9*Pi*2-2*a)+2*cos(Pi/6+2*a));
         Writeln('X = ',x:2:4);
       end;
end.