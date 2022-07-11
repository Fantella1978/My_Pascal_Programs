
{DEMO - demo program for BGI256 driver }
{as of 10 June 1992}
{Usage:  "DEMO256 [ModeNumber]" }

PROGRAM DEMO256;
USES crt,dos,GRAPH;

{-- $DEFINE INTERNAL}  {make this definition valid to load driver into code}

CONST Mode200    = 0;  {320x200x256}
      Mode400    = 1;  {640x400x256}
      Mode480    = 2;  {640x480x256}
      Mode600    = 3;  {800x600x256}
      Mode768    = 4;  {1024x768x256}
      Mode1024   = 5;  {2048x1024x256}
      AutoMode   = 127;{AutoDetect mode}
      LineMode   = $00;
      FillMode   = $40;
      TextMode   = $80;
      ImageMode  = $C0;
      BackColor  = 24;
      GetCurMode = 25;
      MoveWrite  = 0;
      ForeWrite  = 8;

CONST drv : INTEGER = DETECT;
      mode : INTEGER = 0;
      result : INTEGER = 0;
      ERROR : INTEGER = 0;

VAR   Temp,I,X,Y:INTEGER;
      f:text;
      s:string;
      P:pointer;
      Size:word;
      Multi:word;
      SPix,SPiy:word;
      C : word;
      Pal:PaletteType;
      regs : registers;
      Max,xx,l,h : integer;
      SelectMode : integer;
      WhichDriver : integer;

function fstr(I:integer):string;
var s:string;
begin
  str(i,s);
  fstr := s;
end;


{$F+}
function AutoDet:integer;
begin
  AutoDet := SelectMode;  {Autodetect the mode}
end;
{$F-}

{$IFDEF INTERNAL}
  procedure Bgi256Proc; external;
  {$L BGI256.OBJ}
{$ENDIF}


BEGIN
  SelectMode := 0;
  S := 'x';
  if paramcount > 0 then
  begin
    s := ParamStr(1);
    case s[1] of
      '0': SelectMode := 0;
      '1': SelectMode := 1;
      '2': SelectMode := 2;
      '3': SelectMode := 3;
      '4': SelectMode := 4;
      '5': SelectMode := 5;
     else
       SelectMode := 127;
    end; {case}
  end;
  WhichDriver := 0;
  if paramcount > 1 then
  begin
    s := Paramstr(2);
    case s[1] of
      '0': WhichDriver := 0;
      '1': WhichDriver := 1;
      '2': WhichDriver := 2;
      '3': WhichDriver := 3;
      '4': WhichDriver := 4;
      '5': WhichDriver := 5;
    end; {case}
  end;
  temp := Paramcount;
  DRV := 0;
  Result := 0;
(*
  regs.ax := 0;
  intr($33,regs);  {code to hide mouse cursor if needed}
  regs.ax := 1;
  intr($33,regs);
*)
  WRITELN( 'BGI Driver Demo  Copyright (c) 1992,1993 Knight Software');

  case WhichDriver of
    0: result := installuserdriver( 'BGI256', @AutoDet);
    1: result := installuserdriver( 'V7BGI256', @AutoDet);
    2: result := installuserdriver( 'TRI256', @AutoDet);
    3: result := installuserdriver( 'egavga', @AutoDet);
    4: result := installuserdriver( 'VESA16', @AutoDet);
  end; {case}
  ERROR := graphresult;
  WRITELN( 'INSTALLresult = ', result,' ',drv,'  ',mode);

{$IFDEF INTERNAL}
  xx := RegisterBGIdriver(@Bgi256Proc);
{$ENDIF}

{  detectgraph(drv,mode); }

  if drv > 0 then
    drv := result
  else
    drv := 0;
  mode := 0;
  initgraph( drv, mode, '' );
  result := Graphresult;
  Mode := GetGraphMode;
  Max := GetMaxMode;
  if SelectMode = 127 then SelectMode := 0;
  SetGraphMode(SelectMode);    {<-- set the desired mode here}
  result := graphresult;
  Max := GetMaxMode;
  SetWriteMode(GetCurMode);
  Max := GetMaxMode;
  cleardevice;
  C := GetColor;
   outtextxy(20,40,'Result:'+fstr(result)+' Drv:'+fstr(drv)+' Mode:'+fstr(mode)+' Max:'+fstr(Max)+' C:'+Fstr(C));

  C := 7;
  GetModeRange(drv,l,h);
  Max := GetMaxMode;

  mode := GetGraphMode;
  s := GetDriverName;
  outtextxy((GetMaxX div 2)-4,10,s);
  s := GetModeName(mode);
  outtextxy((GetMaxX div 2)-4,20,s);

  SetWriteMode($100);
  C := GetMaxColor;

  GetDefaultPalette(Pal);

{  SetBkColor(2); }



  SETCOLOR(5);
  C := GetColor;

  MOVETO(0,0);
  FOR Y := 0 TO 10 DO
    FOR X := 0 TO 10 DO
      PUTPIXEL(X,Y,3);

  if GetMaxX > 320 then Multi := 2 else Multi := 1;
  multi := 1;
  SPix := 10;
  SPiy := 155;
  MOVETO(SPix,SPiy);
  FOR X := 0 TO 255+1 DO
  begin
    PutPixel(SPix+(X*Multi)-1,pred(SPiy),15*(X and 1));
    PutPixel(SPix+(X*Multi)-1,succ(SPiy+10),15*(X and 1));
  end;

  FOR Y := SPiy TO SPiy+10 DO
  begin
    PutPixel(pred(SPix),Y,15*(Y and 1));
    PutPixel((255*Multi)+SPix+1,Y,15*(Y and 1));

    FOR X := 0 TO 255 DO
    BEGIN
      for I := 0 to pred(Multi) do
        PUTPIXEL(SPix+I+(X*Multi),Y,X);
    END;
  end;

  SETFILLSTYLE(XHatchFill,2);
  bar( 20, 20, 35, 35 );

  SETFILLSTYLE(XHatchFill,4);
  bar( 21, 21, 36, 36 );

  SETFILLSTYLE(1,6);
  bar( 50, 50, 85, 100 );

  SETFILLSTYLE(2,2);
  BAR3D(30,60,60,95,10,true);


  setFILLSTYLE(3, 3 );
  bar( GetMaxX-40, GetMaxY-80, GetMaxX-8, GetMaxY-8 );

  SETFILLSTYLE(4,4);
  bar( 70, 120, 90, 140 );

  setcolor(15);
  moveto(100,350);
  fillellipse(100,300,50,50);


  FOR I := 0 TO 15 DO
  BEGIN
    SetColor(i xor $f);    {set text background color}
    SetWriteMode(TextMode+BackColor);
    SetColor(i);           {set text foreground color}
    SetWriteMode(TextMode+MoveWrite);
    if i <= 9 then C := i+$30 else C := i+$37;
    outtextxy(Spix+(i*8),170,char(c));
  END;
  SetWriteMode(TextMode+ForeWrite);

  setcolor(14);
  moveto(0,0);
  line( 0, 0, GetMaxX, GetMaxY);

  setcolor(14);
  SetLineStyle(3,0,3);
  line( GetMaxX, 0, 0, GetMaxY);

  setcolor( 4 );
  circle( 112, 98, 20 );

  setcolor(1);
  rectangle(0,0,GetMaxX,GetMaxY);

  setcolor(2);
  rectangle(4,4,GetMaxX-4,GetMaxY-4);


  for i := 0 to 7 do
  begin
    setcolor(1+i);
    line( GetMaxX-299-(i*3), 70+(i*3), GetMaxX-299+20+(i*7), 70+(i*3) );
  end;

  setcolor(12);
  moveto(0,0);
  line( 0, 0, 0, 0 );

  putpixel(1,0,0);
  putpixel(1,1,0);
  putpixel(0,1,0);
  putpixel(2,0,0);
  putpixel(2,1,0);
  putpixel(0,2,0);
  putpixel(1,2,0);
  putpixel(2,2,0);


  SetTextStyle(0,0,1);
  setcolor( 5 );
  moveto( 100, GetMaxY-80);
  outtextXY(100,GetMaxY-80,'OutText 1');

  SetTextStyle(0,0,2);
  setcolor( 6 );
  outtextxy( (GetMaxX div 2)-60, GetMaxY-20, 'OutText 2' );

  if GetMaxY > 400 then
    Y := 199
  else
    Y := GetMaxY div 4;
  X := Y;
  Size := ImageSize(0,0,X,Y);
  GetMem(P,Size);
{  GetImage(0,0,199,199,P^);
  PutImage(250,200,P^,OrPut); }

  GetImage(0,0,X,Y,P^);
  PutImage(succ(GetMaxX) div 2,succ(GetMaxY) div 2,P^,NormalPut);

  setcolor(white);
  SetLineStyle(0,0,0);
  rectangle(pred(succ(GetMaxX) div 2),pred(succ(GetMaxY) div 2),
            (succ(GetMaxX) div 2)+X,(succ(GetMaxY) div 2)+Y);

  setcolor(6);
  CIRCLE(GETMAXX DIV 2,GETMAXY DIV 2,100);

  SetTextStyle(0,0,1);
  outtextxy(0,0,'Hello');

  C := 10;
  PutPixel(0,0,C);
  C := GetPixel(0,0);
  PutPixel(0,0,C);
  C := 12;
  PutPixel(GetMaxX,0,C);
  C := GetPixel(GetMaxX,0);
  PutPixel(GetMaxX,0,C);
  C := 11;
  PutPixel(0,GetMaxY,C);
  C := GetPixel(0,GetMaxY);
  PutPixel(0,GetMaxY,C);
  C := 15;
  PutPixel(GetMaxX,GetMaxY,C);
  C := GetPixel(GetMaxX,GetMaxY);
  PutPixel(GetMaxX,GetMaxY,C);

  setLineStyle(UserBitLn,$ffff,1);
  setcolor(yellow);
  moveto(20,9);
  lineto(GetMaxX-20,9);
  setLineStyle(UserBitLn,$5555,1);
  setcolor(yellow);
  moveto(24,11);
  lineto(GetMaxX-24,11);
  setLineStyle(UserBitLn,$1111,1);
  setcolor(yellow);
  moveto(28,13);
  lineto(GetMaxX-28,13);

  readln;


  for i := 0 to 3 do
  begin
    cleardevice;
    SETFILLSTYLE(1,4);
    setcolor(4);
    bar(0,0,GetMaxX,GetMaxY);
    SetTextStyle(0,0,4);
    setcolor( 7 );
    moveto(1,1);
    outtextxy(10,100,'OutText '+fstr(i));
  end;

{  outtextxy( 10, 100, 'OutText 3'+#191+#192+#193+#194); }

  outtextxy(0,0,'Hello');


  READLN;
  closegraph;

  WRITELN('Finished');

END.

