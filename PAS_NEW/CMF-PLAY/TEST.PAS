program test;

{ This is a simple test program to play the CMF file ZARDOZ.CMF... }
{ Copyright 1993 The Servants of Technology and Tim Sullivan       }
{ Freeware, not Public Domain. Go crazy.                           }

uses Music, Crt;

var
 x         : integer;
 ch        : char;
 Soundcard : pSoundblaster;
 Zardoz    : pCMFSong;
 Tmp,
 Temp      : SoundList;

begin
 New(Soundcard,Init($388));                        { create the soundcard }
 If not soundcard^.present then                    { see if it's there }
 begin
  writeln('No Adlib or compatible found.');
  exit;
 end;
 New(Zardoz,Init('zardoz.cmf',Soundcard));
 Tmp.sd := Zardoz;                                 { Force the linked list }
 Tmp.Next := nil;
 PlayListTop := @Tmp;                       { Assign the play list to Zardoz }
 Zardoz^.Play;
 ch := #0;
 repeat
 until keypressed or not Zardoz^.IsPlaying;
 Zardoz^.Stop;
 for x := 0 to 9 do
  Zardoz^.Device^.NoteOff(x);
 Dispose(Zardoz,done);
 dispose(soundcard,done);                          { get rid of the soundcard }
end.

