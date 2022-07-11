Program speed;
{$M $800,0,0 }
uses Crt, Dos;
var
  KbdIntVec : Procedure;
  paus:integer;
{$F+}
procedure Keyclick; interrupt;
begin
  delay(paus);
  if Port[$60] < $80 then
    begin
     if ord(port[$60])=82
      then
       begin
        dec(paus);
        if paus<1 then paus:=1;
        sound(30*paus);
        delay(20);
        nosound;
       end;
     if ord(port[$60])=83 then
      begin
       inc(paus);
       if paus>100 then paus:=100;
       sound(30*paus);
       delay(20);
       nosound;
      end;
    end;
  inline ($9C);
  KbdIntVec;
end;
{$F-}
begin
  paus:=1;
  GetIntVec($9,@KbdIntVec);
  SetIntVec($9,Addr(Keyclick));
  Keep(0);
end.
