PROGRAM FadeDemo;

USES CRT,     { <----- We need this for keypressed and colors. }
     Fade2;

VAR
   loop : integer;
   ch : char;
BEGIN
   FOR loop := 1 to 50 DO
      BEGIN
         TextColor(loop MOD 16);
         write ('...Writing junk to screen...')
      END;
   writeln;
   TextColor(15);
   writeln ('Press any key to stop fading, then press');
   writeln ('<Enter> to call ResetTextMode;');
   GrabPal;                          { Save palette to return to later. }
   REPEAT
      FadeOut;
      FadeIn;
   UNTIL KeyPressed;
   BlackOut;
   ClrScr;
   TextColor(7);
   writeln ('This screen was set up when the palette was black, so there');
   writeln ('was no way to see it being set up.  GrabPal would usually be');
   writeln ('called right before this, but in this case we already had the');
   writeln ('palette stored from earlier.  Press Enter again to ResetTextMode.');
   readln;   { <--- The above text doesn't show until after this readln }
   FadeIn;
   readln;
   ResetTextMode;
   write ('That was cool!');
   readln
END.