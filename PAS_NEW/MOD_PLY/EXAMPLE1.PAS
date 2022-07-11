PROGRAM DOS_Player;
{$M $1000,0,0}       {* Set heap size to zero !!! *}

USES    ModPlay,Dos;

VAR     Shell: STRING[128];


BEGIN
  IF ParamCount > 0 THEN
  BEGIN
    Mod_Init(Detection,0,0,0);
    Mod_Load(ParamStr(1));
    IF Channels<>0 THEN
    BEGIN
      Mod_Play(1);
      Shell:=GetEnv('COMSPEC');
      IF Shell='' THEN Shell:='C:\COMMAND.COM';
      WriteLn;
      WriteLn('Shelling to DOS... To stop background music enter EXIT !');
      SwapVectors;
      Exec(Shell,'');
      SwapVectors;
      WriteLn('Returned... Music output stopped');
    END ELSE WriteLn('Unable to output soundfile...');
  END ELSE WriteLn('Please specify a modulefile on the commandline !');
END.
