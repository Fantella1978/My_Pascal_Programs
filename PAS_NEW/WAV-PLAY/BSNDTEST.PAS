{$M 2048,0,655360}
{$S-,R-,I-}
uses
   BSound, Objects, CRT, DOS, Memory;

var
   FS    :TDosStream;
   MS    :TEmsStream;
begin
   InitMemory;

   SoundRepeat:=True;

   FS.Init('THANKYOU.WAV', stOpenRead);
   MS.Init(FS.GetSize, FS.GetSize);
   MS.CopyFrom(FS, FS.GetSize);
   FS.Done;
   MS.Seek(0);
   if InitSound(@MS)<>bsOk then Halt;
{  Write('Volume (64)   : '); ReadLn(SoundVolume);
   Write('Buffer (1024) : '); ReadLn(SoundBufSize); }
   StartSound;
   while PlayingSound and not KeyPressed do
      WriteLn('Position ', SoundPos-SoundRead+SoundBufPos);

   DoneDosMem;
   SwapVectors;
   Exec(GetEnv('COMSPEC'), '');
   SwapVectors;
   InitDosMem;

   MS.Done;

   DoneMemory;
end.
