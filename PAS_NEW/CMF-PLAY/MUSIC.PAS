unit Music;

{
|                   ////  The Servants of Technology
|                   oo/   Reality Engineering
|                   \/    We Think, Therefore You Are
|
|
|                     The Music Programmer's Toolkit
|                An Easy Turbo Pascal Interface to the Ear.
|
|                          BETA VERSION 0.90B
|
|
| MUSIC.PAS : A freeware, object oriented soundcard/music handling system.
| This code is Copyright 1993, The Servants of Technology.
| THIS CODE IS NOT PUBLIC DOMAIN. It is FREEWARE. You are free to use this
| code in any application, as long as you inform me you are doing so (I
| just want to see what people are doing with my code!)
|
| SOT is not responsible for any damage caused by using this code. I doubt
| your computer will spark or meltdown from using this code, but if it does,
| blame yourself.
|
| These routines have the following features built in:
|
|   - The ability to use the Soundblaster's FM chips.
|   - The ability to play type-0 SMF Standard MIDI files.
|   - The ability to load and play a CMF file in the background.
|
| By nature of OOP, you can:
|
|   - easily add support for other cards in native mode (ie. the GUS, the PAS,
|     etc.) Simply create a decendant of the SoundDevice object, and alter the
|     methods NoteOn, NoteOff, SetVoice, and Volume. You should then be able
|     to load and play a MIDI file using a MIDSong object.
|
|   - easily add other music formats, ie. MODs, SMF-1/2 MIDIs, etc.
|
| Speaking of which, if anyone creates any decendant objects (ie for GUS or
| PAS or whatever), I'd love to see them! One of the reasons I released this
| code is so that everyone can learn and benifit from using music cards.
| Please help support this effort.
|
| I will be releasing a set of routines and data structures that will allow
| you to manipulate CMF and SMF-0 files sometime in the future. These will
| just add on to these routines, and will give you the ability to create music
| editors that save CMF files.
|
| Feel free to write to me at tsullivan@trentu.ca, or by snail-mail to:
|
|                           Tim Sullivan
|                           14 Fordham Place
|                           Toronto, Ont, CANADA
|                           M3B 1K2
|
| Any donations would be accepted graciously!
|
| Credits: - jlee@smylex, (whoever he really is!) for his almost-clear
|            description of programming the FM chips;
|          - Josh Jensen (Cyberstrike) for being really cool and giving me a
|            copy of his routines to study...;
|          - Sean Brennan, for his notes on the timer routines;
|          - Everyone who provided feedback on the code, who helped me
|            understand that which I didn't understand (or only thought I did).
}

{.$DEFINE TEST} { Remove the . before the $ to not install the int proc, and }
                { use TestHandler instead.                                   }

interface

uses DOS, Crt;

const
 NoteTable				 : ARRAY[0..11] of word = (343,363,385,408,432,458,
                                             485,514,544,577,611,647);


type
 { arrays }
 ChannelTableType   = ARRAY[0..15] of boolean;        { channel on/off table }
 InstrumentArray = ARRAY[0..127] of pointer;          { Instrument table     }

 { records }
 Instrument    = record
                  SoundChar,                          { Sound Characteristic }
                  Level,                              { Level                }
                  AttDec,                             { Attack/Decay         }
                  SusRel,                             { Sustain/Release      }
                  WaveSelect   : ARRAY[0..1] of byte; { Wave Select          }
                  Feedback     : byte;                { FeedBack             }
                  Filler       : ARRAY[0..4] of byte; { Reserved for future  }
                 end;

 CMFHeader     = record
                  CTMF         : ARRAY[0..3] of char; { "CTMF"                }
                  Version      : word;                { Version Number        }
                  InsOffset    : word;                { Offset to Ins Data    }
                  MusicOffset  : word;                { Offset to Music Data  }
                  Ticks        : word;                { Ticks per Quarter     }
                  TicksPerSec  : word;                { Clock Ticks/Second    }
                  CMFTitle     : word;                { Offset to title       }
                  Author       : word;                { Offset to author      }
                  Remarks      : word;                { Offset to remarks     }
                  ChannelTable : ChannelTableType;    { Channels used (1=used)}
                  NumIns       : word;                { Number of Instruments }
                  Tempo        : word;                { Tempo                 }
                 END;


 { Objects }

 { Abstract SoundDevice Object }
 pSoundDevice  = ^SoundDevice;
 SoundDevice   = object
									channels : ChannelTableType; {this may have to change.. }
									present  : boolean;
                  constructor Init;
                  procedure NoteOn(chan, freq, octave : integer); virtual;
                  procedure NoteOff(chan : integer); virtual;
                  procedure Volume(chan, vol : integer); virtual;
                  procedure SetVoice(chan : integer; Voice : pointer); virtual;
                  procedure SetOpMode(mode : byte); virtual;
                  procedure ResetSD; virtual;
                  destructor Done;
                 end;

 { Adlib Sound Object }
 pAdlib        = ^Adlib;
 Adlib         = object(SoundDevice)
                  FMPort      : word;
                  RhythmMode  : boolean;
                  constructor Init(pt : word);
                  procedure NoteOn(chan, freq, octave : integer); virtual;
                  procedure NoteOff(chan : integer); virtual;
                  procedure Volume(chan, vol : integer); virtual;
                  procedure SetVoice(chan : integer; Voice : pointer); virtual;
                  procedure SetOpMode(mode : byte); virtual;
                  procedure ResetSD; virtual;
                  procedure WriteFM(chip, reg : integer; data : byte);
                  procedure SetRhythmMode;
                  procedure SetMelodicMode;
                  destructor Done;
                 end;

 { Soundblaster SoundDevice Object }
 pSoundblaster = ^Soundblaster;
 Soundblaster  = object(Adlib)
                 end;

 { Abstract Songfile Object }
 pAbstractSong = ^AbstractSong;
 AbstractSong  = object
                  CurrentPtr,
                  MusicData    : pointer;
                  MusicStatus  : byte;
                  MusicSize    : longint;
                  DeltaTime    : longint;
                  Device       : pSoundDevice;
                  constructor Init(pSc : pSoundDevice);
                  procedure Play;
                  procedure Stop;
                  procedure Pause;
                  procedure ProcessEvent; virtual;
                  function IsPlaying : boolean;
                  function IsPaused : boolean;
                  destructor Done;
                 end;

 { MIDI-SMF-0 Songfile Object }
 pMIDI0Song    = ^CMFSong;
 MIDI0Song     = object(AbstractSong)
                  Instruments : InstrumentArray;
                  constructor Init(fn : pathStr; pSc : pSoundDevice);
                  procedure ProcessEvent; virtual;
                  destructor Done;
                 end;


 { CMF Songfile Object }
 pCMFSong      = ^CMFSong;
 CMFSong       = object(MIDI0Song)
                  Header      : CMFHeader;
                  constructor Init(fn : pathStr; pSc : pSoundDevice);
                  destructor Done;
                 end;

 { more records }
 pSoundList = ^SoundList;
 SoundList  = record
               sd   : pAbstractSong;
               next : pSoundList;
              end;

{ Other procedures }
procedure IncPtr(VAR Marker : Pointer; IncBy : longint);
procedure DecPtr(VAR Marker : Pointer; DecBy : longint);
procedure SetTimer(t : word);
function ReadMidi(var marker : pointer) : longint;
procedure AddSongToList(VAR plt : pSoundList; Song : pAbstractSong);
procedure CleanSongList(plt : pSoundList);
procedure TestHandler;

var
 PlayListTop : pSoundList;

implementation

{ SoundDevice methods. These must be overridden. }

constructor SoundDevice.Init;
begin
end;

procedure SoundDevice.NoteOn(chan, freq, octave : integer);
begin
end;

procedure SoundDevice.NoteOff(chan : integer);
begin
end;

procedure SoundDevice.Volume(chan, vol : integer);
begin
end;

procedure SoundDevice.SetVoice(chan : integer; Voice : pointer);
begin
end;

procedure SoundDevice.SetOpMode(mode : byte);
begin
end;

procedure SoundDevice.ResetSD;
begin
end;

destructor SoundDevice.Done;
begin
end;


{ Adlib methods }

constructor Adlib.Init(pt : word);
var
 i,
 temp2,
 temp   : byte;
begin
 rhythmmode := true;
 FMPort := pt;
 WriteFM(0,4,$60);
 WriteFM(0,4,$80);
 temp := Port[FMPort];
 WriteFM(0,2,$FF);
 WriteFM(0,4,$21);
 Delay(90);
 Temp2 := Port[FMPort];
 WriteFM(0,4,$60);
 WriteFM(0,4,$80);
 if ((temp and $E0) = $00) and ((temp2 and $E0) = $C0) then
  present := true
 else
  present := false;
 if present then
 begin
  for i := $01 to $F5 do
   WriteFM(0,i,0);
  WriteFM(0,$01,$20);  { enable waveform manipulation }
  WriteFM(0,$bd,$20);  { enable percussion }
  WriteFM(0,$00,$40);
 end;
end;

procedure Adlib.NoteOn(chan, freq, octave : integer);
VAR
 regnum   : byte;
 tmp      : byte;
BEGIN
 IF (NOT RhythmMode) OR (Chan < 6) THEN   { if it is not a percussion ins }
 BEGIN
  regnum := $a0 + (chan mod 11);
  WriteFM(0,regnum,Freq AND $ff);
  regnum := $b0 + (chan  mod 11);
  tmp := (freq shr 8) OR (octave shl 2) OR $20;
  WriteFM(0,regnum,tmp);
 END
 ELSE
 BEGIN                                    { ..if it IS a percussion ins }
  tmp := 0;
  if channels[6] then tmp := tmp OR $01;  { If there are other pvoices playing}
  if channels[7] then tmp := tmp OR $02;  { make sure the byte includes them  }
  if channels[8] then tmp := tmp OR $04;
  if channels[9] then tmp := tmp OR $08;
  if channels[10] then tmp := tmp OR $10;
  case chan of
   6  : WriteFM(0,$BD,tmp or $01);
   7  : WriteFM(0,$BD,tmp or $02);
   8  : WriteFM(0,$BD,tmp or $04);
   9  : WriteFM(0,$BD,tmp or $08);
   10 : WriteFM(0,$BD,tmp or $10);
  end;
 end;
end;

procedure Adlib.NoteOff(chan : integer);
var
 regnum : byte;
begin
 regnum := $B0 + (chan mod 11);
 WriteFM(0,regnum,0);
end;

procedure Adlib.Volume(chan, vol : integer);
var
 regnum : byte;
begin
 regnum := $40 + (chan mod 11);
 WriteFM(0,regnum,vol);
end;

{ Assigns an FM instrument to a voice }
procedure Adlib.SetVoice(chan : integer; Voice : Pointer);
var
 OpCellNum  : byte;
 chip,
 i,
 cellOffset : word;
 ofst       : byte;
 Ins        : Instrument;
begin
 Move(Voice^,Ins,SizeOf(Ins));
 i := chan div 11;
 chip := integer(boolean(chan div 11));

 chan := chan mod 11;

 { check on voice_num range }
  CellOffset := chan mod 3  + chan div 3 shl 3;

 { set sound characteristic }
 OpCellNum := $20 + celloffset;    {byte}

 WriteFM(chip,opcellnum,Ins.SoundChar[0]);  {Sound Characteristic I}
 opcellnum := opcellnum + 3;
 WriteFM(chip,opcellnum,Ins.SoundChar[1]); {SoundCharacteristic II}

 { set level/output }
 opcellnum := $40 + CellOffset;  {byte}
 WriteFM(chip,opcellnum,Ins.Level[0]);  {ModVol}
 opcellnum := opcellnum + 3;
 WriteFM(chip,opcellnum,Ins.Level[1]); {CarrierVol}

 { set Attack/Decay }
 opcellnum := $60 + celloffset; {byte}
 WriteFM(chip,opcellnum,Ins.AttDec[0]); {AttackDecay I}
 opcellnum := opcellnum + 3;
 WriteFM(chip,opcellnum,Ins.AttDec[1]); {AttackDecay II}

 { set Sustain/Release }
 opcellnum := $80 + celloffset;   {byte}
 WriteFM(chip,opcellnum,Ins.SusRel[0]);  {SustainRelease I}
 opcellnum := opcellnum + 3;
 WriteFM(chip,opcellnum,Ins.SusRel[1]);  {SustainRelease II}

 { set Wave Select }
 opcellnum := $E0 + celloffset;  {byte}
 WriteFM(chip,opcellnum,Ins.WaveSelect[0]); {WaveSelect I}
 opcellnum := opcellnum + 3;
 WriteFM(chip,opcellnum,Ins.WaveSelect[1]); {WaveSelect ii}

 { set Feedback/Selectivity }
 opcellnum := $C0 + chan;  {byte}
 WriteFM(chip,opcellnum,Ins.FeedBack); {Feedback}
end;

procedure Adlib.SetOpMode(mode : byte);
begin
 case Mode OF
	0 : SetMelodicMode;
	1 : SetRhythmMode;
 end;
end;

procedure Adlib.ResetSD;
var
 i : byte;
begin
 WriteFM(0,$01,$20);  { enable waveform manipulation }
 for i := $01 to $1F do
  WriteFM(0,i,0);
 for i := $21 to $1F do
  WriteFM(0,i,0);
 WriteFM(0,$bd,$20);  { enable percussion }
 WriteFM(0,$00,$40);
end;

{****
procedure Adlib.WriteFM(chip, reg : integer; data : byte);
var
 i,bla,
 ChipAddr : integer;
begin
 Port[FMPort] := Reg;
 for i := 1 to 6 do
  bla := Port[FMPort];
 Port[FMPort+1] := Data;
 for i := 1 to 35 do
  bla := Port[FMPort];
end;
****}

procedure Adlib.WriteFM(chip, reg : integer; data : byte);
label
 thing,
 thing2;
begin
 asm
  mov     dx,es:FMPort
  mov     al,byte ptr reg
  out     dx,al
  mov     cx,6
thing:
  in      al,dx
  loop    thing
  inc     dx
  mov     al,data
  out     dx,al
  dec     dx
  mov     cx,35
thing2:
  in      al,dx
  loop    thing2
 end;
end;


procedure Adlib.SetRhythmMode;
begin
 WriteFM(0,$0b6,0);
 WriteFM(0,$0b7,0);
 WriteFM(0,$0b8,0);
 WriteFM(0,$bd,$20);
 RhythmMode := true;
end;

procedure Adlib.SetMelodicMode;
begin
 WriteFM(0,$bd,$00);
 RhythmMode := false;
end;


destructor Adlib.Done;
begin
end;


{ AbstractSong Methods }

constructor AbstractSong.Init(pSc : pSoundDevice);
begin
 Device := pSc;
end;

procedure AbstractSong.Play;
begin
 MusicStatus := 1;
end;

procedure AbstractSong.Stop;
begin
 MusicStatus := 0;
 CurrentPtr := MusicData;
end;

procedure AbstractSong.Pause;
begin
 MusicStatus := 2;
end;

procedure AbstractSong.ProcessEvent;
begin
 RunError(255);  { MUST BE OVERRIDDEN }
end;

function AbstractSong.IsPlaying : boolean;
begin
 IsPlaying := (MusicStatus = 1);
end;

function AbstractSong.IsPaused : boolean;
begin
 IsPaused := (MusicStatus = 2);
end;

destructor AbstractSong.Done;
begin
end;


{ MIDI0Song Methods }

constructor MIDI0Song.Init(fn : pathstr; pSc : pSoundDevice);
var
 x			 : byte;
 channel : file;
begin
 Device := pSc;
end;

procedure MIDI0Song.ProcessEvent;
const
 Status : integer = -1;
var
 Rc,
 chan     : word;
 TmpByte  : byte;
begin
 TmpByte := byte(CurrentPtr^); IncPtr(CurrentPtr,1); { get status byte }
 if boolean(tmpbyte AND $80) then
  status := integer(tmpbyte)   { unsigned or no? I can only guess! }
 else
 begin
  if (status = -1) then    { running status, so back up one }
  begin { error in cmf file }
	 Device^.ResetSD;
   Halt(1);
  end;
  DecPtr(CurrentPtr,1); { back up one byte }
 end;

 { switch different events }
 case (status AND $F0) of
  $80 : begin                           { Turn note off }
         chan := status AND $0F;
				 Device^.NoteOff(chan);
				 Device^.Channels[chan] := false; 	 {?? NoteOn }
         IncPtr(CurrentPtr,2);                          { waste two bytes }
        end;
  $90 : begin
         tmpByte := byte(CurrentPtr^); IncPtr(CurrentPtr,1); { get note }
            { determine note }
            { turn note on }
         chan := status AND $0F;   { select channel }
				 if Device^.Channels[chan] then
					Device^.NoteOff(chan);
				 Device^.Channels[chan] := true;
				 Device^.NoteOn(chan,NoteTable[(TmpByte mod 12)],((TmpByte div 12)-1) and 7);
         { waste a byte }
         IncPtr(CurrentPtr,1);
        end;
  $A0 : IncPtr(CurrentPtr,2);
  $B0 : begin                         { Control change (rhythm mode) }
         rc := byte(CurrentPtr^);
         chan := rc and $0f;
         IncPtr(CurrentPtr,1);
         TmpByte := byte(CurrentPtr^);
         if rc = $67 then
					Device^.SetOpMode(tmpbyte);
         IncPtr(CurrentPtr,1);
        end;
  $C0 : begin
         tmpbyte := byte(CurrentPtr^); IncPtr(CurrentPtr,1);
            { change the instrument on a channel }
				 Device^.SetVoice(status AND $0F,Instruments[tmpbyte]);
        end;
  $D0 : IncPtr(CurrentPtr,1);
  $E0 : IncPtr(CurrentPtr,2);
  $F0 : IncPtr(CurrentPtr,2);
 else    { Error in CMF? }
  IncPtr(CurrentPtr,2);
 end; {case}
 DeltaTime := ReadMidi(CurrentPtr);
end;

destructor MIDI0Song.Done;
begin
end;



{ CMFSong Methods }

constructor CMFSong.Init(fn : pathstr; pSc : pSoundDevice);
var
 x			 : byte;
 channel : file;
begin
 Device := pSc;
 assign(channel,fn);
 reset(channel,1);
 blockread(Channel,Header,SizeOf(Header));
 seek(channel,Header.InsOffset);
 for x := 0 to Header.NumIns-1 do
 begin
	getmem(Instruments[x],SizeOf(Instrument));
  blockread(channel,Instruments[x]^,sizeOf(Instrument));
 end;
 seek(channel,Header.MusicOffset);
 MusicSize := FileSize(channel) - Filepos(channel);
 GetMem(MusicData,MusicSize);
 Blockread(channel,MusicData^,MusicSize);
 CurrentPtr := MusicData;
 close(channel);
 DeltaTime := readMidi(CurrentPtr);
 SetTimer(Header.TicksPerSec);
end;


destructor CMFSong.Done;
var
 x : integer;
begin
 for x := 0 to Header.NumIns-1 do
  FreeMem(Instruments[x],SizeOf(Instrument));
 FreeMem(MusicData,MusicSize);
end;


(*****************************************************************************)
{ Non-OOP procs and funcs, as isolated as possible... }
var
 ExitSave,
 SaveInt1C : pointer;

procedure JumpToOldISR(OldIsr: pointer);
  { Chain on to previous ISR (doesn't return) }
  inline($5B/$58/$87/$5E/$0E/$87/$46/$10/$89/
         $EC/$5D/$07/$1F/$5F/$5E/$5A/$59/$CB);

{$F+,S-}
procedure IntHandler; interrupt;   { Process timer interrupt }
var
 thing : pSoundList;
begin
 thing := PlayListTop;
 while thing <> nil do
 begin
  if thing^.sd^.IsPlaying and not thing^.sd^.IsPaused then  { Quit if not playing }
  begin
   if (longint(thing^.sd^.CurrentPtr) >= (longint(thing^.sd^.MusicData)+
       longint(thing^.sd^.MusicSize))) then
   begin
    Thing^.sd^.Stop;
    Exit;
   end;
   if thing^.sd^.DeltaTime = 0 then          { if it's time to change notes }
    Thing^.sd^.ProcessEvent
   else
    dec(thing^.sd^.DeltaTime);                      { Wait for note to finish }
  end;
  thing := thing^.next;
 end;
 JumpToOldISR(SaveInt1C);            { Call other interrupt handlers }
end;
{$F-,S+}


procedure TestHandler;    { Process timer interrupt }
var
 thing : pSoundList;
begin
 thing := PlayListTop;
 while thing <> nil do
 begin
	if (thing^.sd^.MusicStatus = 1) and not (thing^.sd^.MusicStatus = 2) then
  begin
   if thing^.sd^.DeltaTime = 0 then          { if it's time to change notes }
    Thing^.sd^.ProcessEvent
   else
    dec(thing^.sd^.DeltaTime);                      { Wait for note to finish }
  end;
  thing := thing^.next;
 end;
end;


{ This increments a pointer by one }
PROCEDURE IncPtr(VAR Marker : Pointer; IncBy : longint);
VAR
 Segment,
 Offset,
 OffNew   : Word;
 SegCount : Longint;
begin
 Segment := Seg(Marker^);
 Offset := Ofs(Marker^);
 SegCount := (IncBy div $10000);
 Offnew := Offset+IncBy;
 if ((OffNew <= Offset) AND (SegCount = 0) AND (IncBy > 0)) THEN
  SegCount := 1;
 Inc(Segment,Segcount*$1000);
 Marker := Ptr(Segment,Offnew);
end;

{ This decrements a pointer by one }
procedure DecPtr(VAR Marker : Pointer; DecBy : longint);
var
 Segment,
 Offset,
 OffNew   : Word;
 SegCount : Longint;
begin
 Segment := Seg(Marker^);
 Offset := Ofs(Marker^);
 SegCount := (DecBy div $10000);
 Offnew := Offset-DecBy;
 if ((OffNew >= Offset) AND (SegCount = 0) AND (DecBy > 0)) then
  SegCount := 1;
 Dec(Segment,Segcount*$1000);
 Marker := Ptr(Segment,Offnew);
end;


procedure SetTimer(t : word);
begin
{ asm
  mov ax,$36
  out $43,al
  mov dx,t
  out dx,al
  mov al,ah
  out dx,al
 end; }
 asm
    mov t,ax
    mov al,$36
    out $43,al
    mov al,Byte Ptr t
    out $40,al
    mov	al,ah
    out $40,al
 end;
end;

function ReadMidi(var marker : pointer) : longint;
VAR
 value   : integer;
 count,
 tmpbyte : byte;
begin
 tmpbyte := byte(marker^); IncPtr(Marker,1);
 value := tmpbyte;
 if (tmpbyte AND $80) = $80 THEN
 begin
  value := value AND $7F;
  repeat
   tmpbyte := byte(marker^); IncPtr(Marker,1);
   value := (value shl 7) + (tmpbyte AND $F7);
  until not ((tmpbyte and $80) <> 0);
 end;
{ readmidi := value * 170; }
 readmidi := value;
end;

procedure AddSongToList(VAR plt : pSoundList; Song : pAbstractSong);
var
 tmp : pSoundList;
begin
 tmp := plt;
 if pLt = nil then
 begin
  new(tmp);
  tmp^.sd := Song;
  tmp^.next := nil;
  plt := tmp;
 end
 else
 begin
  while tmp <> nil do
   tmp := tmp^.next;
  new(tmp);
  tmp^.sd := Song;
  tmp^.next := nil;
 end;
end;

procedure CleanSongList(plt : pSoundList);
var
 old,
 tmp : pSoundList;
begin
 tmp := plt;
 while tmp <> nil do
 begin
  old := tmp^.next;
  dispose(tmp);
  tmp := old;
 end;
end;


{$F+}
procedure ExitHandler;
{$F-}
  { Restore the timer interrupt and make sure sound is off }
begin
 ExitProc := ExitSave;											{ Chain to other exit procedures }
 SetIntVec($1C,SaveInt1C);									{ Remove interrupt handler }
 { turn off notes, free mem, etc. }
end;

begin
 PlayListTop := nil;
 ExitSave := ExitProc;
 ExitProc := @ExitHandler;											 { Install our exit procedure }
 GetIntVec($1C,SaveInt1C);
 SetIntVec($1C,@IntHandler);						 { Install our timer interrupt handler }
end.
