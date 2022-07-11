PROGRAM Text_Mode_Player;
{$M $1000,0,0}      {* Set heap size to zero !!! *}

USES    ModPlay,Crt;

VAR     Key:          CHAR;
        Main_Volume:  BYTE;
        Cursor_Shape: WORD;


PROCEDURE Init_Cursor; ASSEMBLER;
ASM
  mov     ah,3
  xor     bh,bh
  int     10h
  mov     [Cursor_Shape],cx
  mov     ah,1
  mov     cx,2020h
  int     10h
end;

PROCEDURE Restore_Cursor; ASSEMBLER;
ASM
  mov     ah,1
  mov     cx,[Cursor_Shape]
  int     10h
END;

PROCEDURE Update_Screen;
VAR     i,j:     INTEGER;
        Bar:     STRING[32];
        SongPos: WORD;

BEGIN
  GotoXY(1,7);
  Mod_Peak;
  FOR i:=1 TO Channels DO
  BEGIN
    Bar:='같같같같같같같같같같같같같같같같';
    IF Peak[i]>1 THEN FOR j:=1 TO (Peak[i] SHR 1) DO Bar[j]:='�';
    GotoXY(2,3+i); Write(Bar);
  END;
  SongPos:=Mod_Position;
  GotoXY(3,6+Channels); Write('Playing pattern #',SongPos SHR 8,', line #',SongPos AND $FF,' ');
  GotoXY(62,WhereY); Write('Main volume: ',Main_Volume*100 div 64:3,'%');
END;


BEGIN
  Mod_Init(Detection,0,0,0);
  IF Soundcard<>0 THEN
  BEGIN
    Mod_Load('atomic2.mod');
    IF (Channels<>0) THEN
    BEGIN
      Init_Cursor;
      Main_Volume:=58;
      Mod_Volume(Main_Volume);
      Mod_Play(0);
      TextColor(WHITE); TextBackground(BLACK);
      ClrScr;
      TextBackground(BLUE); GotoXY(1,1); ClrEol;
      GotoXY(20,1); Write('SOUND WIZARDS MODULE PLAYER PASCAL DEMO');
      GotoXY(1,6+Channels); ClrEol;
      TextBackground(BLACK);
      GotoXY(36,1+Channels); Write('Press       up,down:     to adjust volume  ');
      GotoXY(36,2+Channels); Write('            left,right:  to change position');
      GotoXY(36,3+Channels); Write('or escape to quit this little program......');
      TextBackground(BLUE);
      REPEAT
	Update_Screen;
	Key:=' ';
	IF KeyPressed THEN Key:=ReadKey;
	IF Key=chr(0) THEN
	BEGIN
	  Key:=ReadKey;
	  CASE Key OF
	    chr($48):  IF Main_Volume < 64 THEN
		       BEGIN
			 Main_Volume:=Main_Volume+2;
			 Mod_Volume(Main_Volume);
                       END;
            chr($50):  IF Main_Volume > 0 THEN
                       BEGIN
                         Main_Volume:=Main_Volume-2;
                         Mod_Volume(Main_Volume);
                       END;
            chr($4D):  Mod_Forward;
            chr($4B):  Mod_Rewind;
          END;
        END;
      UNTIL((Mod_Status=0) OR (Key=Chr(27)));
      GotoXY(1,9+Channels);
      Restore_Cursor;
    END ELSE WriteLn('Could not load song ATOMIC2.MOD...');
  END ELSE WriteLn('Could not initialize hardware...');
END.
