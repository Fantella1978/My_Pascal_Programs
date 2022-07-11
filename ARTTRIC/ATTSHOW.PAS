Program ATTSHOW;
uses dos,graph,crt;
type
     coord=record
      x,y:integer;
     end;
var gd,gm,i,j:integer;
    dirinfo:searchrec;
    nf:string[13];
    c:word;
    a:coord;
    f1:file of coord;

Procedure showhelp;
begin
 writeln;
 writeln('ATTSHOW filename [/W]');
 writeln;
 writeln(' filename   -  Name of ATT file (********.ATT).');
 writeln('      /W    -  Black & White view.');
 writeln;
end;

begin
 if ParamCount=0
  then
   begin
    showhelp;
    exit;
   end;
 if ParamCount>2 then exit;
 if (ParamCount<=2)and(ParamCount>=1)
  then
   begin
    nf:=ParamStr(1);
    for i:=1 to 13 do
     begin
      if (nf[i]='*')or(nf[i]='?')
       then
        begin
         writeln('ERROR in filename.');
         exit;
        end;
     end;
    findfirst(nf,anyfile,dirinfo);
    if doserror<>0
     then
      begin
       writeln('ERROR in filename.');
       exit;
      end;
    if (dirinfo.name[length(dirinfo.name)]<>'T')and
       (dirinfo.name[length(dirinfo.name)-1]<>'T')and
       (dirinfo.name[length(dirinfo.name)-2]<>'A')
     then
      begin
       writeln('ERROR in filename.');
       exit;
      end;
    if ParamCount=2 then if (ParamStr(2)='/W')or(ParamStr(2)='/w')then c:=1
     else c:=0;
   end;
 gd:=0;
 gm:=0;
 initgraph(gd,gm,'');
 if graphresult=0
  then
   begin
    assign(f1,nf);
    reset(f1);
    for i:=1 to filesize(f1) do
     begin
      read(f1,a);
      if c=0 then putpixel(a.x div 16,a.y,a.x-(a.x div 16)*16)
       else putpixel(a.x div 16,a.y,white);
     end;
    close(f1);
    repeat until readkey<>'';
    closegraph;
   end;
end.
