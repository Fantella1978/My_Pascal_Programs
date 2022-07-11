(*************************************************)
(*     Simple Demo program uses stmpas unit      *)
(*       Copyright (C) Leha Suslov 1993          *)
(*  Other copyrights see in Copyright variable.  *)
(*************************************************)
uses
  Crt,
{$ifndef VER60}
  Strings,
{$endif}
  StmPas;
var
  Speed, Device :  Word;
  Err,X,Y       :  Integer;
{$ifdef VER60}
  buf: String[100];
{$else}
  buf: array[0..100] of Char;
{$endif}
begin
  ClrScr;
  TextColor(LIGHTRED);
  writeln('!!! Scream Tracker Player Demo Program !!!'#13#10);
  TextColor(CYAN);
  if ParamCount < 1 then
  begin
    writeln('Usage: stmdemo <modulename.stm> [speed] [device]');
    writeln('speed = 0: 8  MHz AT'+
      #13#10'        1: 10 MHz AT'+
      #13#10'        2: 12 MHz AT & faster cars');
    writeln('device= 0: PC-Speaker'+
      #13#10'        1: Covox LPT1'+
      #13#10'        2: Covox LPT2');
    exit;
  end;
{$ifdef VER60}
  buf:=ParamStr(1);
{$else}
  StrPCopy(buf, ParamStr(1));
{$endif}
  Val(ParamStr(2), Speed,  Err);
  Val(ParamStr(3), Device, Err);
  Case Speed of
  0: write(' 8 MHz AT');
  1: write('10 MHz AT');
  2: write('12 MHz AT')
  else begin writeln('Invalid speed !'); exit end;
  end;
  write(', device is ');
  Case Device of
  0: writeln('PC-speaker');
  1: writeln('Covox on LPT1');
  2: writeln('Covox on LPT2')
  else begin writeln('Invalid device !'); exit end;
  end;

  writeln('Max. Available Block is ',MaxAvail,' bytes.');
  writeln('Loading...');

  if _load_music(buf, Speed, Device) = 0 then
  begin
    writeln('Error loading ST module !'); exit;
  end;

  write('Name.......... ');
  X:=0;while (X <= 19) and (Head.Name[X]<>#0) do
  begin write(Head.Name[X]); inc(X) end; writeln;
  write('Zagol......... ');
  X:=0;while (X <= 7) and (Head.Name[X]<>#0) do
  begin write(Head.Zagol[X]);inc(X) end; writeln;
  writeln('Module Type... ',Head.ModType);
  writeln('Version....... ',Head.Vers_hi,'.',Head.Vers_hi);
  writeln('Global tempo.. ',Head.GLTempo);
  writeln('N of patterns. ',Head.NPatterns);
  writeln('Global volume. ',Head.GLVolume);
  writeln('Max. Available Block is ',MaxAvail,' bytes.');
  writeln('Play now...');
  TextColor(LIGHTCYAN);
  writeln('<Gray Minus>,<Gray Plus> - Change Volume');

  _start_music;

  X:=50; Y:=WhereY;
  while _ready_char=0 do
  begin
    { User code... }
    Window(X, 1, 80, Y-1);
    GotoXY(Random(31), Random(16));
    TextColor(Random(16));
    Write('*');
    Window(1, Y, 80, 25);
    GotoXY(Random(80), Random(11));
    TextColor(Random(16));
    Write('*');
  end;

  for Device:=64 downto 1 do
  begin
    for Err:=0 to 16384 do;
    Head.GLVolume:=Device;
  end;

  _stop_music;

  _unload_music;

  Window(1,13,80,25);
  TextColor(LIGHTGRAY);
  writeln('Max. Available Block is ',MaxAvail,' bytes.');
  writeln('Good bye...');
end.