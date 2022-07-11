{$IFDEF Ver70}
{ Compiler directives for Turbo Pascal 7.0 }
{$A+,B-,D+,E-,F-,I+,L+,N-,O-,P+,Q-,R-,S-,T-,V-,X+}
{$IFDEF DPMI}
'Will not compile in DPMI version.'
{$ENDIF}
{$M 16384,0,655360}
{$ENDIF}

{$IFDEF Ver60}
{ Compiler directives for Turbo Pascal 6.0 }
{$A+,B-,D+,E-,F-,G-,I+,L+,N-,O-,R-,S-,V-,X+}
{$M 16384,0,655360}
{$ENDIF}

program VOCPlay;

{ FastVGA v1.0, (C)1993 by Tal Cohen }

uses VOCUnit,SoundGlobals;

function Hex (n:Word):String; { Limited to three hex digits }
 const HexDigit:String[16] = '0123456789ABCDEF';

 var S:String[3];

 begin
  S:=HexDigit[(n div 256)+1];
  n:=n mod 256;
  S:=S+HexDigit[(n div 16)+1];
  n:=n mod 16;
  Hex:=S+HexDigit[n+1];
 end;

var Er:Byte;

begin
 if TestSound=0 then
  begin
   WriteLn ('Sound Blaster not found or BLASTER variable not set.');
   Halt;
  end;
 if ParamCount<>1 then
  begin
   WriteLn;
   WriteLn ('VOCPlay demo. Syntax: VOCPLAY <VOC filename>');
   WriteLn ('              No extension is assumed.');
   WriteLn;
   Exit;
  end;
 WriteLn ('Sound card settings:');
 Write ('          Type: ');
 case TestSound of
  2:WriteLn ('Sound Blaster 1.x');
  3:WriteLn ('Sound Blaster 2.0 or later');
  4:WriteLn ('Sound Blaster Pro');
 end;
 WriteLn ('          DMA Channel: ',SBDMA);
 WriteLn ('          Base Port: ',Hex(SBPort),' (hex)');
 WriteLn ('          IRQ Number: ',SBIRQ);
 PlayVOC (ParamStr(1),AnyKeyExits,Once,Er);
 if Er=0 then Er:=LastVOCError;
 case Er of
  0: ;
  1:WriteLn ('File not found.');
  2,3:WriteLn ('I/O error.');
  4:WriteLn ('Bad VOC file or unknown block type.');
  5:WriteLn ('Sound board does not support this VOC file.');
  6:WriteLn ('Out of memory.');
  7:WriteLn ('VOC file is packed.');
  99:WriteLn ('VOC breaked!.');
 else
  WriteLn ('Internal error ',Er,'. Please report to Tal Cohen at once.');
 end;
end.
