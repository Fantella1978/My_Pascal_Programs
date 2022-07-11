program graph4;
uses graph,crt;
var
 grDriver,grMode,errCode:integer;
begin
 grDriver:=Detect;
 Initgraph(grDriver,grMode,'');
 errCode:=Graphresult;
 if errCode=grOk then
  begin
   {***************************************************}

   {***************************************************}
   closegraph;
  end
  else writeln('Error :',Grapherrormsg(errCode));
end.
