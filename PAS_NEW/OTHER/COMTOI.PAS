program ComToInL;
 
{ Program ComToInL by Michael Quinlan   12/17/84 } 
 
{ Problem: 
    Turbo Pascal is great BUT it still has some problem areas. One of these
    is a bug having to do with EXTERNAL procedures -- if youcompile to disk, 
    EXTERNAL procedures longer than 128 bytes don't work. You can get around 
    this bug by compiling to memory first; unfortunately when you use 
    overlays you cannot compile to memory so you are stuck. }
 
{ The fix: 
    Borland doesn't seem to be forthcoming with a patch or new release to fix 
    this bug, so I have written this program to convert .COM files to INLINE 
    code that you can include in your source program. This will greatly 
    increase the compile time of your programs, but at least you won't have
    completly wasted all that time writing and debugging your assembler 
    program. } 
 
{ The environment: 
    I have used this on an IBM PC with Version 2.00B of Turbo Pascal for the
    IBM PC I assume it will work on other MSDOS machines. I know nothing 
    about CPM-80 or CPM-86 so I don't know what problems will be encountered
    in those environments. 
    This program has NOT been completely tested. I rarely need EXTERNAL 
    routines when using Turbo Pascal and have only used this conversion 
    program a couple of times. }
 
{ Usage: 
    First, create and debug your assembler language program. The assembler 
      language program must be converted to a .COM file using EXE2BIN. 
    Second, run ComToInL to convert the .COM file to a .PAS file.
    Third, include the .PAS file created above into the source code of your
      Turbo Pascal program. Example: 
 
        Overlay Procedure A; 
       begin 
        (*$IA.PAS*)  (* Include INLINE code generated from .COM file *) 
        end; 
        Overlay Procedure B; 
        begin 
        (*$IB.PAS*)  (* Include INLINE code generated from .COM file *) 
        end; 
} 

const 
  MaxLineLength = 126; 
 
type 
  Lstr = String[255]; 
 
var 
  InFile      : File of Byte;
  OutFile     : Text;
  CharsOnLine : Integer; 
  InFileName  : Lstr; 
  OutFileName : Lstr; 
  B           : Byte; 
  C           : Char; 
  D1, D2      : Integer; 
 
const 
  HexTable : Array[0..15] of Char = '0123456789ABCDEF';
 
procedure StrToUpper(var S : Lstr); 
var 
  i : integer;
begin 
  for i := 1 to length(S) do 
    S[i] := UpCase(S[i]) 
end; 
 
procedure GetFileName(var FileName : Lstr; Ext : Lstr); 
begin 
  Readln(FileName); 
  StrToUpper(FileName);
  if pos('.', FileName) = 0 then FileName := FileName + Ext 
end; 
 
procedure WriteLnOut; 
  { used to end line on screen and file } 
begin 
  WriteLn(OutFile);
  WriteLn; 
  CharsOnLine := 0 
end; 
 
procedure WriteOut(S : Lstr); 
  { used to write data to screen and file at the same time }
begin 
  if (CharsOnLine + Length(S)) >= MaxLineLength then 
    WriteLnOut; 
  Write(OutFile, S); 
  Write(S); 
  CharsOnLine := CharsOnLine + Length(S) 
end; 
 
begin
  Write('Input file name: '); 
  GetFileName(InFileName, '.COM'); 
 
  Write('Output file name: '); 
  GetFileName(OutFileName, '.PAS'); 
 
  Assign(InFile, InFileName); 
  Reset(InFile); 
 
  Assign(OutFile, OutFileName); 
  Rewrite(OutFile); 
 
  CharsOnLine := 0;
 
  WriteOut('{ INLINE Code Generated from ' + OutFileName + ' }'); 
  WriteLnOut; 
  WriteOut('INLINE('); 
 
  While not EOF(InFile) do
    begin 
      Read(InFile, B); 
      D1 := B div 16;
      D2 := B mod 16; 
      if EOF(InFile) then C := ')' else C := '/';
      WriteOut('$' + HexTable[D1] + HexTable[D2] + C) 
    end; 
 
  WriteOut(';');
  WriteLnOut;

  Close(OutFile);
  Close(InFile)
end.
+ HexTable[D1] + HexTable[D2] + C) 
    end; 
 
  WriteOut(';');
  WriteLnO