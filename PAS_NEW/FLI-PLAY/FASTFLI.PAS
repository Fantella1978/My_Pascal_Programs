{$IFDEF Ver70}
{ Compiler directives for Turbo Pascal 7.0 }
{$A+,B-,D+,E-,F-,I+,L+,N-,O-,P+,Q-,R-,S-,T-,V-,X+}
{$IFDEF DPMI} {$G+} {$ELSE} {$G-} {$ENDIF}
{$M 16384,0,655360}
{$ENDIF}

{$IFDEF Ver60}
{ Compiler directives for Turbo Pascal 6.0 }
{$A+,B-,D+,E-,F-,G-,I+,L+,N-,O-,R-,S-,V-,X+}
{$M 16384,0,655360}
{$ENDIF}

program FastFLI; { Play an FLI animation from the DOS command line }

{ FastVGA v1.0, (C)1993 by Tal Cohen }

uses FastVGA,FLIUnit,Crt;

procedure ShowSyntax;
 begin
  WriteLn ('FastFLI version 2.0');
  WriteLn;
  WriteLn ('Created using FastVGA 1.0, (C)1993 by Tal Cohen');
  WriteLn;
  WriteLn ('Syntax: FASTFLI <filename> [delay-rate]');
  WriteLn;
  WriteLn ('Supports both FLI and FLC flic files.');
  WriteLn;
  WriteLn ('No file extension is assumed. If delay-rate is not specified, the');
  WriteLn ('flic file''s normal timing is used. The delay rate is measured in');
  WriteLn ('milliseconds. To play the flic file at maximal speed, set delay-rate');
  WriteLn ('to zero.');
  WriteLn;
  Halt;
 end;

var DelayRate:Word;
    FlicType:Byte;
    w1,w2:Word;
    FineRes:Boolean;
    ErByte:Byte;
    ErInt:Integer;

begin
 if (ParamCount>2) or (ParamCount<1) then ShowSyntax;
 if ParamCount=2 then
  begin
   Val (ParamStr(2),DelayRate,ErInt);
   if ErInt<>0 then ShowSyntax;
  end
 else
  DelayRate:=NormalDelay;

 GetFlicData (ParamStr(1),FlicType,w1,w2,FineRes);
 if FlicType=0 then
  begin
   WriteLn ('Not a flic file or file not found.');
   Exit;
  end;

 if not FineRes then
  begin
   WriteLn ('Flic file not in 320x200x256 mode.');
   Exit;
  end;

 { THIS IS THE ACTUAL PLAYING LOOP: }
 GoVGA256;
 PlayFlic (ParamStr(1),DelayRate,AnyKeyExits,Loop,ErByte);

 TextMode (Co80);

 case ErByte of
  1:WriteLn ('File not found.');
  2:WriteLn ('File close error.');
  3:WriteLn ('I/O read error or file corrupted.');
  4:WriteLn ('Not an flic file.');
  5:WriteLn ('Flic file not in 320x200x256 mode.');
  6:WriteLn ('Out of memory.');
  7,100,101:begin
             WriteLn ('Internal error. Error code: ',ErByte);
             WriteLn ('Please report to Tal Cohen at once.');
            end;
  99: { Key pressed, no error } ;
 else
  begin
   WriteLn ('Unknown error. Error code: ',ErByte);
   WriteLn ('Please report to Tal Cohen at once.');
  end;
 end;
end.
