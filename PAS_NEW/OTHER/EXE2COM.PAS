{$A-,B-,D+,E-,F-,I-,L+,N-,O-,R-,S-,V-}
{$M 2024,0,$1FFFF}
uses    Dos;

type    EXEHeader=record
	 MZ,	 { .EXE file signature ('MZ')                            }
         PartPag,{ length of partial page at end (generally ignored)     }
         PageCnt,{ length of image in 512-byte pages, including the header}
         ReloCnt,{ number of items in relocation table                   }
         HdrSize,{ size of header in 16-byte paragraphs                  }
         MinMem ,{ minimum memory needed above end of program (paragraphs}
         MaxMem ,{ maximum memory needed above end of program (paragraphs}
         ReloSS ,{ segment offset of stack segment (for setting SS)      }
         ExeSP  ,{ value for SP register (stack pointer) when started    }
         ChkSum ,{ file checksum (negative sum of all words in file)     }
         ExeIP  ,{ value for IP register (instruction pointer) when started}
         ReloCS ,{ segment offset of code segment (for setting CS)       }
         TablOff,{ file-offset of first relocation item (often 001cH)    }
         Overlay:{ overlay number (0 for base module)}Word;
        end;
        ReloItemType=record
                  I_Ofs, I_Seg : Word
                end;
        ReloTableType=array[1..$FFF] of ReloItemType;

const
         StartSeg=$10;          {смещение PSP}
         Converter0:array[0..53] of byte=(
                     {00FA StarterPos:                                       ;}
                     {0100 Start:                                            ;}
 $BF,$FA,$00,        {0100            mov     di, Offset StarterPos          ;}
 $BE,$30,$01,        {0103            mov     si, Offset Starter             ;}
 $B9,$06,$00,        {0106            mov     cx, STARTEREND-STARTER         ;}
 $FC,                {0109            cld                                    ;}
 $F3,$A4,            {010A            rep movsb                              ;}
 $8C,$CB,            {010C            mov     bx, cs                         ;}
 $01,$1E,$23,$01,    {010E            add     EXECS,bx                       ;}
 $01,$1E,$27,$01,    {0112            add     EXESS,bx                       ;}
 $BF,$00,$01,        {0116            mov     di, 100h                       ;}
 $BE,$36,$01,        {0119            mov     si, Offset Image               ;}
 $B9,$FF,$FF,        {011C            mov     cx,0FFFFh                      ;}
 $BB,$34,$12,        {011F            mov     bx,01234h       ; EXEIP        ;}
 $BD,                {0122         db 0BDh    ; mov   bp, EXECS              ;}
 $00,$00,            {0123 EXECS   dw 0                                      ;}
 $FA,                {0125            cli                                    ;}
 $BA,                {0126         db 0BAh    ; mov   dx, EXESS              ;}
 $00,$00,            {0127 EXESS   dw 0                                      ;}
 $52,                {0129            push    dx                             ;}
 $17,                {012A            pop     ss                             ;}
 $BC,$34,$12,        {012B            mov     sp,1234h        ; EXESP        ;}
 $EB,$CA,            {012E            jmp     short StarterPos               ;}
 $F3,$A4,            {0130 STARTER:   rep movsw                              ;}
 $55,                {0132            push    bp                             ;}
 $53,                {0133            push    bx                             ;}
 $FB,                {0134            sti                                    ;}
 $CB                 {0135            retf                                   ;}
);                   {0136 STARTEREND:                                       ;}

const   Converter1:array[0..84] of byte=(
                     {00FA StarterPos:                                       ;}
                     {0100 Start:                                            ;}
 $BF,$FA,$00,        {0100              mov     di, Offset StarterPos        ;}
 $BE,$4F,$01,        {0103              mov     si, Offset Starter           ;}
 $B9,$06,$00,        {0106              mov     cx, STARTEREND-STARTER       ;}
 $FC,                {0109              cld                                  ;}
 $F3,$A4,            {010A              rep movsb                            ;}
                     {010C ReloChk:;    si==Offset ReloTable                 ;}
 $06,                {010C              push    es                           ;}
 $8C,$CB,            {010D              mov     bx, cs                       ;}
 $83,$C3,$10,        {010F              add     bx, 10h                      ;}
 $01,$1E,$42,$01,    {0112              add     EXECS,bx                     ;}
 $01,$1E,$45,$01,    {0116              add     EXESS,bx                     ;}
 $B9,$34,$12,        {011A              mov     cx, 1234h  ; ReloCnt         ;}
                     {011D ReloAdj:                                          ;}
 $8B,$54,$02,        {011D              mov     dx, [si+2]                   ;}
 $03,$D3,            {0120              add     dx, bx                       ;}
 $81,$C2,$10,$10,    {0122              add     dx, 1010h  ; сегмент элемента (ReloTableSize div 10h+10h)}
 $8E,$C2,            {0126              mov     es, dx                       ;}
 $8B,$3C,            {0128              mov     di, [si]                     ;}
 $26,$01,$9D,$50,$10,{012A              add     word ptr es:[di+1050h], bx ; смещение элемента}
 $83,$C6,$04,        {012F              add     si, 4                        ;}
 $E2,$E9,            {0132              loop    ReloAdj                      ;}
 $07,                {0134              pop     es                           ;}
 $BF,$00,$01,        {0135              mov     di, 100h                     ;}
 $BE,$FF,$FF,        {0138              mov     si, 0FFFFh                   ;}
 $B9,$FF,$FF,        {013B              mov     cx, 0FFFFh                   ;}
 $BB,$34,$12,        {013E              mov     bx,01234h  ; EXEIP           ;}
 $BD,                {0141         db   0BDh                                 ;}
 $00,$00,            {0142 EXECS   dw   0                                    ;}
 $BA,                {0144         db   0BAh                                 ;}
 $00,$00,            {0145 EXESS   dw   0                                    ;}
 $52,                {0147              push    dx                           ;}
 $FA,                {0148              cli                                  ;}
 $17,                {0149              pop     ss                           ;}
 $BC,$34,$12,        {014A              mov     sp,1234h        ; EXESP      ;}
 $EB,$AB,            {014D              jmp     short StarterPos             ;}
 $F3,$A4,            {014F STARTER:     rep movsw                            ;}
 $55,                {0151              push    bp                           ;}
 $53,                {0152              push    bx                           ;}
 $FB,                {0153              sti                                  ;}
 $CB                 {0154              retf                                 ;}
);                   {0155 STARTEREND:                                       ;}

var     EXEHDR          : EXEHeader;
        ReloTable       : ^ReloTableType;
        F,O             : File;
        LoadModuleSize  : word;
        LoadModuleOffs  : word;
        EXEArea         : Pointer;
	P		: PathStr;
	D		: DirStr;
	N		: NameStr;
	E		: ExtStr;
        i,j,
        NumRead,
        NumWritten,
        Res             : word;

procedure Abort(S:string);
begin
 Writeln(S);
 halt;
end;

procedure UpCaseStr(var S:string);
var i:byte;
begin
 for i:=1 to Length(S) do S[i]:=UpCase(S[i]);
end;

begin
 writeln('E2C - EXE to COM converter. Version 1.0 (C), 1993');
 writeln('Written by Milkov V.E.');
 if ParamCount < 1 then Abort('USAGE: E2C <FileName>[.EXE]');
 GetMem(EXEArea,$FFFF);
 GetMem(ReloTable,SizeOf(ReloTableType));

 FillChar(ReloTable^, SizeOf(ReloTableType), #0);

 FSplit(ParamStr(1), D, N, E);
 if N = '' then Abort('No file name');
 if E = '' then E:='.EXE';
 UpCaseStr(E);
 if E <> '.EXE' then Abort('Wrong extention');
 Assign(F,D + N + E);
 Reset(F,1);
 if IOResult <> 0 then Abort('Read error');
 Assign(O, N + '.COM');
 ReWrite(O,1);
 if IOResult <> 0 then Abort('Write error');
 BlockRead(F, EXEHDR, SizeOf(EXEHeader), Res);
 InOutRes:=0;

 With EXEHDR do
  begin
   LoadModuleOffs:=(HdrSize*16);
          {начало загpузочного модуля}
   LoadModuleSize:=(PageCnt-1)*512-HdrSize*16+PartPag;
          {pазмеp загpузочного модуля}
  end;

 Seek(F,EXEHDR.TablOff);                        {чтение Relo Table}
 BlockRead(F, ReloTable^, EXEHDR.ReloCnt*SizeOf(ReloItemType), Res);

 Seek(F,LoadModuleOffs);
 BlockRead(F, EXEArea^, LoadModuleSize, Res);   {чтение кода в файле}

 {подготовка .COM файла}
 if EXEHDR.ReloCnt=0
  then
   begin
    Move(LoadModuleSize,Converter0[$1D], 2);
    Move(EXEHDR.ExeIP,  Converter0[$20], 2);
    i:=EXEHDR.ReloCS+StartSeg;
    Move(i,             Converter0[$23], 2);
    i:=EXEHDR.ReloSS+StartSeg;
    Move(i,             Converter0[$27], 2);
    Move(EXEHDR.ExeSP,  Converter0[$2C], 2);
    BlockWrite(O,       Converter0,      SizeOf(Converter0));
   end
  else
   begin
    Move(EXEHDR.ReloCnt,Converter1[$1B], 2);

    j:=EXEHDR.ReloCnt*SizeOf(ReloItemType)+SizeOf(Converter1);
    {Image Offset}

    i:=(j div $10);
    Move(i,             Converter1[$24], 2);
    i:=(j mod $10);
    Move(i,             Converter1[$2D], 2);

    i:=EXEHDR.ReloCnt*SizeOf(ReloItemType)+SizeOf(Converter1)+$100;
    Move(i,             Converter1[$39], 2);
    Move(LoadModuleSize,Converter1[$3C], 2);
    Move(EXEHDR.ExeIP,  Converter1[$3F], 2);
    i:=EXEHDR.ReloCS;
    Move(i,             Converter1[$42], 2);
    i:=EXEHDR.ReloSS;
    Move(i,             Converter1[$45], 2);
    Move(EXEHDR.ExeSP,  Converter1[$4B], 2);
    BlockWrite(O,       Converter1,      SizeOf(Converter1));
    BlockWrite(O, ReloTable^, EXEHDR.ReloCnt*SizeOf(ReloItemType));
   end;
 BlockWrite(O, EXEArea^, LoadModuleSize, Res);

 InOutRes:=0;
 Close(F);
 Close(O);
end.
