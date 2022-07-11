Program ADVHSC_Equalizer_Demo;

{ Little Example To Show The Use Of The Equalizer in the Antares HSC Player }
{ Coded By Access/ADV - 06/94 }
{ Modification By aCceSs/aNTaReS - 11/94 }

Uses Crt,ADVHSC;

Var i,j:Byte;

PROCEDURE VerticalRetrace;Assembler;  { Simply Wait The VGA Video Retrace }
     ASM
        mov dx,$3da
@1:     in al,dx
        test al,8
        jz @1
@2:     in al,dx
        test al,8
        jnz @2
END;

Begin
ClrScr;

if LOADSONG('MUSIC.HSC') then   { Loading the Song Into Memory }
Begin
PLAYSONG; { Play The Song }

Writeln('ADV HSC Player Version '+Version+' - Example 1');
Writeln;
Writeln('Press A Key...');

Repeat
GetPlayerState;
VerticalRetrace;

GOTOXY(1,8); Write('Pattern : ',PlayerState.Pattern,'  Position : ',PlayerState.Position,' ');

For i:=1 to 9 do
Begin
GotoXY(1,i+10);

if PlayerState.Equalizer[i]<>255 then
   Begin
   For j:=1 to Playerstate.Equalizer[i] do Write('þ');
   For j:=Playerstate.Equalizer[i] to 15 do Write(' ');
   End;

End;

Until KeyPressed;

FADESONG; { Fade Out The Volume }
Delay(2000); { Wait For 2 Seconds }
STOPSONG; { Stop The Player }
CLEARMEM; { Free Memory }
End;
End.