unit gmouse;

interface

type Rect = record
                   x1,y1,x2,y2:integer;
             end;

procedure ResetMouse;
procedure ShowMouse;
procedure HideMouse;
procedure GetMouseStatus(var x, y:integer; var lb, rb : boolean);
procedure SetMousePos(x,y:integer);
procedure SetMinMaxX ( min, max : integer );
procedure SetMinMaxY ( min, max : integer );

implementation

uses
 dos;
var r : registers;

procedure Inter;
begin
     intr($33, r);
end;

procedure ResetMouse;
begin
     r.ax := 0;
     Inter;
end;

procedure ShowMouse;
begin
     r.ax := 1;
     Inter;
end;

procedure HideMouse;
begin
     r.ax := 2;
     Inter;
end;

procedure  GetMouseStatus(var x, y:integer; var lb, rb : boolean);
begin
     r.ax := 3;
     Inter;
     x := r.cx + 1;
     y := r.dx + 1;
     lb := False; rb := false;
     if r.bx = 1 then lb := True
     else if r.bx = 2 then rb := True
     else if r.bx = 3 then begin lb := true; rb := true; end;
end;

procedure SetMousePos(x,y:integer);
begin
     r.ax := 4;
     r.cx:=x;
     r.dx:=y;
     Inter;
end;

procedure SetMinMaxX ( min, max : integer );
begin
     r.ax := 7;
     r.cx:=min;
     r.dx:=max;
     Inter;
end;

procedure SetMinMaxY ( min, max : integer );
begin
     r.ax := 8;
     r.cx:=min;
     r.dx:=max;
     Inter;
end;
end.