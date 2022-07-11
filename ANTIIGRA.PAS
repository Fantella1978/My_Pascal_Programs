{$D-,B-}
{$M 1024, 0, 0}

program AntiGame;

uses
  Dos,Crt;

var
  Int21h, P: pointer;
  A: pointer absolute 0:$84;
  B: pointer absolute 0:$184;
  R: Registers;
  ProgramName: String[80];
  I, J: Byte;

const
  NamesNum = 13;
  NeedingNames: array [1 .. NamesNum] of string[8] =
 ('BALLS', 'MK2', 'NETWARS', 'GPU', 'ALADDIN', 'DESERT', 'TYCOON', 'Q',
  'FIFA', 'WOLF3D', 'X', 'GDI', 'NOD');

{$F+}
procedure My21h(Flags, CS, IP, AX, BX, CX, DX, SI, DI, DS, ES, BP: Word); interrupt;
begin
  if AX = $4B00 then
  begin
    Move(Ptr(DS, DX)^, ProgramName[1], 80);
    ProgramName[0] := #$FF;
    ProgramName[0] := Char(Pos(#0, ProgramName) - 1);
    I := Byte(ProgramName[0]);
    while (I > 0) and (ProgramName[I] <> ':') and (ProgramName[I] <> '\') do Dec(I);
    J := Byte(ProgramName[0]) - I;
    Inc(I);
    Move(ProgramName[I], ProgramName[1], J);
    ProgramName[0] := Char(J);
    ProgramName[0] := Char(Pos('.', ProgramName) - 1);
    For I := 1 to Byte(ProgramName[0]) do
      ProgramName[I] := UpCase(ProgramName[I]);
    For I := 1 to NamesNum do
      if ProgramName = NeedingNames[I] then
      begin
        clrscr;
        WriteLn('ษอออออออออออออออออออออออออออออออออป ');
        WriteLn('บ                                 บ ');
        WriteLn('บ                                 บ ');
        WriteLn('บ         €—…… …          บ ');
        WriteLn('บ                                 บ ');
        WriteLn('บ   “ €’€’, € … €’   บ ');
        WriteLn('บ                                 บ ');
        WriteLn('บ                                 บ ');
        WriteLn('บ ',ProgramName,' ญจชใค  ญฅ ใกฅฆจโ| ');
        WriteLn('บ                                 บ ');
        WriteLn('ศอออออออออออออออออออออออออออออออออผ ');
        Exit;
      end;
  end;
  R.Flags := Flags; R.AX := AX;
  R.BX := BX; R.CX := CX; R.DX := DX; R.SI := SI;
  R.DI := DI; R.DS := DS; R.ES := ES; R.BP := BP;
  inline($FA); P := B; B := Int21h; inline($FB);
  Intr($61, R);
  inline($FA); B := P; inline($FB);
  Flags := R.Flags; AX := R.AX;
  BX := R.BX; CX := R.CX; DX := R.DX; SI := R.SI;
  DI := R.DI; DS := R.DS; ES := R.ES; BP := R.BP;
end;
{$F-}

begin
  SwapVectors;
  inline($FA);
  Int21h := A;
  A := @My21h;
  inline($FB);
  WriteLn('เฎฃเ ฌฌ  ง ฃเใฆฅญ .');
  Keep(0);
end.