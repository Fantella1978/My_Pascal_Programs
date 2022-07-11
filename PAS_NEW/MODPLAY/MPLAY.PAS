 Program MPlay;

 Uses Dos,Crt,MMPlay,Detect,Modules,GetPut;

 Var
  AnyModule: MODDataRec;
  r:registers;
  i:integer;
  modinf:modinforec;

Procedure winop(cox,coy,cox1,coy1:integer;cl,cl1:byte);
var
   nk:integer;
begin
   window(cox,coy,cox1,coy1);
   textbackground(cl);
   textcolor(cl1);
   clrscr;
   write('É');
   for nk:=0 to (cox1-cox-2) do write('Í');
   write('»');
   for nk:=1 to (coy1-coy-1) do
    begin
     gotoxy(1,1+nk);
     write('º');
     gotoxy(cox1-cox+1,1+nk);
     write('º');
    end;
   gotoxy(1,coy1-coy+1);
   write('È');
   for nk:=0 to (cox1-cox-2) do write('Í');
   window(cox,coy,cox1+1,coy1+1);
   gotoxy(cox1-cox+1,coy1-coy+1);
   write('¼');
   window(cox,coy,cox1+3,coy1+2);
   gotoxy(3,coy1-coy+2);
   textbackground(black);
   for nk:=0 to (cox1-cox) do write(' ');
   for nk:=0 to (coy1-coy) do
    begin
     gotoxy(cox1-cox+2,2+nk);
     write('  ');
    end;
   window(1,1,79,23);
   gotoxy(25,7);
   textbackground(cl);
   write(' MOD-Player from Fantomas 1998 ');
   gotoxy(32,18);
   write(' Mariupol City ');
   window(cox+1,coy+1,cox1-1,coy1-1);
   textcolor(white);
   textbackground(black);
end;


 Begin
  r.ah:=01;
  r.ch:=32;
  r.cl:=0;
  intr($10,r);
  Put_Text(p1^,1,1);
  If ParamCount < 1 Then
  Begin
   Writeln;
   WriteLn('MOD-Player from Fantomas.');
   WriteLn('Usage: MPLAY [module filename]');
   WriteLn;
   Halt(1);
  End;
  LoadMOD(ParamStr(1), 0, AnyModule);
  If ErrorInfo = 1 Then
  Begin
   WriteLn('Error loading module.');
   WriteLn;
   Halt(1);
  End;
  winop(22,7,58,18,white,black);
  textcolor(black);
  textbackground(white);
  writeln;
  writeln(' Playing MOD   : ',Paramstr(1));
  write  (' Device        : ');
  case SbData.CardType of
    1:writeln('Sound Blaster');
    2:writeln('Sound Blaster PRO');
    3:writeln('Sound Blaster 16');
   end;
  write(' Address       : ');
  write (round(SbData.SbAddr/16/16));
  write (round((SbData.SbAddr-round(SbData.SbAddr/16/16)*16*16)/16));
  writeln (SbData.SbAddr-
         round((SbData.SbAddr-round(SbData.SbAddr/16/16)*16*16)/16)*16-
         round(SbData.SbAddr/16/16)*16*16,'h');
  writeln(' Irq           : ',SbData.Sbirq);
  writeln(' DMA-1         : ',SbData.DSPnum-768);
  writeln(' DMA-2         : ',round(SbData.DSPnum/256));
  writeln(' Order         : ');
  writeln(' Row           : ');
  PlayMOD(AnyModule);
  Repeat
   gotoxy(18,8);
   write(OrderPos,' of ',AnyModule^.OrderLen,' ');
   gotoxy(18,9);
   write(Row,' of 64 ');
  Until (KeyPressed) OR ((AnyModule^.OrderLen = OrderPos) AND (Row = 64));
  StopMOD;
  Put_Text(p1^,1,1);
  Freemem(p1,size);
  FreeMOD(AnyModule);
  r.ah:=01;
  r.ch:=64;
  r.cl:=0;
  intr($10,r);
  textcolor(white);
  textbackground(black);
  readkey;
 End.