unit fgraph;

INTERFACE

uses crt,graph,fconst,gmouse,fnagr;

Procedure EGAVGADriverProc;
procedure TriplexFontProc;
Procedure ShowGraphic(j:integer);

IMPLEMENTATION

var
  mx,my:integer;
  lb,rb:boolean;
  gm,gd:integer;


procedure TriplexFontProc; external;
{$L TRIP.OBJ }

Procedure ShowGraphic(j:integer);
var
    i:longint;
    temp:string[6];
begin
   gd:=VGA; gm:=VGAHi;
   initgraph(gd,gm,'');
   if GraphResult=0 then
    begin
      line(100,410,100,10);
      line(100,410,600,410);
      outtextxy(10,10,'T,K');
      outtextxy(601,406,'t,c');
      for i:=0 to round(j*CurModel._dTau/1000)-1 do
       begin
        line(100+round(i*500/(j*CurModel._DTau/1000)),408,100+round(i*500/(j*CurModel._DTau/1000)),412);
        str(i*1000:6,temp);
        settextstyle(0,1,0);
        outtextxy(104+round(i*500/(j*CurModel._DTau/1000)),424,temp);
       end;
      settextstyle(TriplexFont,0,1);
      line(355,340,round(100+(500/j)*(TauM/CurModel._DTau)),round(410-400*CurModel._Tm/1700));
      outtextxy(355,340,'Темпеpатуpа в печи');
      line(355,363,round(100+500/j*30),round(410-400*T_1^[30]/1700));
      outtextxy(355,363,'Темпеpатуpа в узле 1');
      line(355,386,round(100+500/j*30),round(410-400*T_2^[30]/1700));
      outtextxy(355,386,'Темпеpатуpа в узле 2');
      settextstyle(0,0,0);
      for i:=1 to 17 do
       begin
        setlinestyle(0,0,0);
        line(98,408-round(i*23.3),102,408-round(i*23.3));
        setlinestyle(2,0,0);
        line(104,408-round(i*23.3),600,408-round(i*23.3));
        str(i*100:5,temp);
        outtextxy(55,404-round(i*23.3),temp);
       end;
      setlinestyle(0,0,3);
      line(round(100+(500/j)*(0/CurModel._DTau)),round(410-400*CurModel._Tm/1700),
           round(100+(500/j)*(TauM/CurModel._DTau)),round(410-400*CurModel._Tm/1700));
      line(round(100+(500/j)*(TauM/CurModel._DTau)),round(410-400*CurModel._Tm/1700),
           round(100+(500/j)*(TauM/CurModel._DTau)),round(410-400*CurModel._Tc1/1700));
      line(round(100+(500/j)*(TauM/CurModel._DTau)),round(410-400*CurModel._Tc1/1700),
           round(100+(500/j)*((TauM+TauC1)/CurModel._DTau)),round(410-400*CurModel._Tc1/1700));
      LINE(round(100+(500/j)*((TauM+TauC1)/CurModel._DTau)),round(410-400*CurModel._Tc1/1700),
           round(100+(500/j)*((TauM+TauC1)/CurModel._DTau)),round(410-400*CurModel._Tc2/1700));
      line(round(100+(500/j)*((TauM+TauC1)/CurModel._DTau)),round(410-400*CurModel._Tc2/1700),
           round(100+(500/j)*((TauM+TauC1+TauC2)/CurModel._DTau)),
           round(410-400*CurModel._Tc2/1700));
      line(round(100+(500/j)*((TauM+TauC1+TauC2)/CurModel._DTau)),
           round(410-400*CurModel._Tc2/1700),
           round(100+(500/j)*((TauM+TauC1+TauC2)/CurModel._DTau)),round(410-400*CurModel._Tt/1700));
      line(round(100+(500/j)*((TauM+TauC1+TauC2)/CurModel._DTau)),round(410-400*CurModel._Tt/1700),
           round(100+(500/j)*((TauM+TauC1+TauC2+TauT)/CurModel._DTau)),
           round(410-400*CurModel._Tt/1700));
      setlinestyle(0,0,3);
      for i:=3 to j do
       begin
        line(round(100+500/j*(i-1)),round(410-400*T_1^[i-1]/1700),
             round(100+500/j*i),round(410-400*T_1^[i]/1700));
        line(round(100+500/j*(i-1)),round(410-400*T_2^[i-1]/1700),
             round(100+500/j*i),round(410-400*T_2^[i]/1700));
       end;
      repeat until keypressed;
     closeGraph;
    end
    else MyMessageBox('Пpоизошла ошибка инициализации гpафического pежима.',nil,1+$0400);
end;

Procedure EGAVGADriverProc; external;
{$L EGAVGA.OBJ}

end.