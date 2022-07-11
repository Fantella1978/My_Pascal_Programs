Uses LZHSTM,SongIO,Crt,Dos;

var s,q : String[80];
    fs  : LongInt;
    bb  : Word;
    sr  : SearchRec;

Procedure NextLine;
var i : Byte;
begin
 ClrEOL;i:=TextAttr;TextAttr:=7;Writeln;TextAttr:=i;
end;

Procedure CheckError;
begin
 if Error>0 then
    begin
     TextAttr:=$4F;
     case Error of
      1 : Write('File not found');
      2 : Write('Bad file format');
      3 : Write('Not enough memory');
      4 : Write('I/O error');
      5 : Write('Can''t write file');
     end;
     NextLine;
     Halt(1);
    end;
end;

procedure LoadSTM(FName : PathStr);
label LocExit;
var p      : Pointer;
    Tmp    : STMInstrDescr;
    InsSeg : array[0..30] of Word;
    i,j    : Word;
    STMH   : STMHeaderType;
    SNum   : Byte;
    ch     : Char;
begin
 FreeAll;
 Error:=0;InOutRes:=0;
 Assign(WorkFile,FName);Reset(WorkFile,1);
 if IOResult<>0 then begin Error:=1;GoTo LocExit;end;
 BlockRead(WorkFile,STMH,SizeOf(STMHeaderType));
 if IOResult>0 then Writeln('Bad header');
 if STMH.FileType<>2 then Writeln('Bad file type');
 Move(STMH.SongName,SongName[1],20);
 i:=1;While (SongName[i]<>#0) and (i<21) do Inc(i);
 SongName[0]:=Char(i-1);
 RealTemp:=STMH.Temp;
 Temp:=RealTemp*TempMultiply div TempDivider;
 GVolume:=STMH.GlobalVolume;
 NumPatt:=STMH.NumPatterns;SNum:=255;
 for i:=0 to 30 do
     begin
      BlockRead(WorkFile,Tmp,SizeOf(STMInstrDescr));
      if IOResult<>0 then Writeln('Bad sample description');
      Sizes[i]:=Tmp.Length;
      if Sizes[i]>1 then
         begin
          InitInstr[i]:=True;
          Move(Tmp.Name,InstrNm[i][1],12);
          j:=0;While (InstrNm[i][j+1]<>#0) and (j<12) do Inc(j);
          InstrNm[i][0]:=Char(j);
          LoopStart[i]:=Tmp.LoopStart;
          LoopEnd[i]:=Tmp.LoopEnd;
          if (LoopEnd[i]<>$FFFF) and (LoopEnd[i]>Sizes[i])
             then LoopEnd[i]:=Sizes[i];
          DefVolm[i]:=Tmp.DefVolume;
          SpeedOfC[i]:=Tmp.SpeedOfC;
          InsSeg[i]:=Tmp.SampleSeg;
          Inc(SNum);
         end;
     end;
 BlockRead(WorkFile,Order,128);
 if IOResult<>0 then Writeln('Can''t read order');
 for i:=1 to NumPatt do
     begin
      if @DisplayResults<>NIL then DisplayResults(i,255);
      New(Patt[i-1]);
      if Patt[i-1]=NIL then begin Error:=3;GoTo LocExit;end;
      BlockRead(WorkFile,Patt[i-1]^,1024);
      if IOResult<>0 then Writeln('Error reading pattern ',i);
     end;
 For i:=0 to 30 do
     if InitInstr[i] then
        begin
         if @DisplayResults<>NIL then DisplayResults(i,SNum);
         GetMem(InsOrg[i],Sizes[i]+16);
         p:=InsOrg[i];if p=NIL then begin FreeAll;Error:=3;GoTo LocExit; end;
         if Word(p)>0 then asm  inc word ptr [p+2]; mov word ptr p,0 end;
         Instr[i]:=p;Seek(WorkFile,Longint(InsSeg[i]) shl 4);
         BlockRead(WorkFile,Instr[i]^,Sizes[i],j);
         if j<>Sizes[i] then
            begin
             Writeln('Error reading sample ',InstrNm[i]);
             ch:='C';
             if j>0 then
                begin
                 Writeln('Loaded ',j,' bytes instead of ',Sizes[i]);
                 TextAttr:=$0C;
                 Write  ('[C]lear sample  [T]ry to store  [A]bort?');
                 repeat ch:=UpCase(ReadKey); until ch in ['C','T','A'];
                 Writeln;
                 case ch of
                  'A' : Halt;
                  'T' : Sizes[i]:=j;
                 end;
                end;
             if ch='C' then
                begin
                 FreeMem(InsOrg[i],Sizes[i]+16);
                 Sizes[i]:=0;
                 if InstrNm[i]='' then InitInstr[i]:=False;
                end;
            end;
        end;
LocExit:
 Close(WorkFile);InOutRes:=0;
end;

begin
 TextAttr:=$0A;
 Write('Scream Tracker''s module fixer');NextLine;
 Write('Version 1.1  (C)opyright 1992 by FRIENDS software');NextLine;
 s:=ParamStr(1);
 if (Pos('.',s)=0) then s:=s+'.STM';
 if (ParamCount<>1) then
    begin
     TextAttr:=$04;
     Write('Usage -> STMFIX .STMfile');NextLine;
     Write('      or STMFIX [Mask]');NextLine;
     Halt(1);
    end;
 FindFirst(s,AnyFile,sr);
 repeat
  s:=sr.Name;s:=FExpand(s);
  TextAttr:=$0B;Write('Loading ',s,'...');NextLine;
  TextAttr:=$04;
  LoadSTM(s);CheckError;
  SetFAttr(WorkFile,0);
  TextAttr:=$0E;Write('Writing temp file...');NextLine;
  SaveSTM('/¶ndy.tmp');CheckError;
  TextAttr:=$03;Write('Renaming temp file to ',s,'...');NextLine;
  Assign(WorkFile,s);Erase(WorkFile);
  Assign(WorkFile,'/¶ndy.tmp');Rename(WorkFile,s);
  FindNext(sr);
 until DosError>0;
 TextAttr:=$02;Writeln('Well done.');
end.
