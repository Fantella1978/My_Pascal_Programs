Program GRAB;

uses crt,dos;

type Pointer=^FlName;
     FlName=record
       name:string[12];
       size:Longint;
       attr:byte;
       PPoint:Pointer;
       NPoint:Pointer;
     end;

var
    disks:array[3..26]of boolean;
    f1,f2:file of byte;
    i,nach,col:longint;
    x,y,b:byte;
    name:string[12];
    Dirinfo:SearchRec;
    DError:integer;
    MyFile,P1,P2,FFile,LFile:Pointer;
    ColFiles:integer;
    SizeOfDir:Longint;
    rk:char;

Procedure ShowDosError;
begin
 case DError of
   2:Write('” ฉซ ญฅ ญ ฉคฅญ.');
   3:Write('ใโ์ ญฅ ญ ฉคฅญ.');
   5:Write('ฎแโใฏ ง ฏpฅ้ฅญ.');
   6:Write('Invalid handle.');
   8:Write('ฅคฎแโ โฎ็ญฎ ฏ ฌ๏โจ.');
  10:Write('ฅขฅขญ๋ฅ ฏฅpฅฌฅญญ๋ฅ ฎชpใฆฅญจ๏.');
  11:Write('ฅขฅpญ๋ฉ ไฎpฌ โ.');
  18:Write('ฅโ กฎซ์่ฅ ไ ฉซฎข.');
 end;
end;

Procedure ShowFileBox;
begin
 clrscr;
 gotoxy(1,1);
 write('ษออออออออออออัอออออออออหอออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
 for i:=1 to 18 do write('บ            ณ         บ                                                       บ');
 write('ฬออออออออออออฯอออออออออน                                                       บ');
 write('บ                      บ                                                       บ');
 write('ศออออออออออออออออออออออสอออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
end;

Procedure GetDirFiles(Dir:DirStr);
begin
 P1:=nil;
 FindFirst(Dir+'\*.*',AnyFile,Dirinfo);
 DError:=DosError;
 if (DError<>0)and(DError<>18) then ShowDosError
  else
   begin
    New(P2);
    P2^.name:=Dirinfo.Name;
    P2^.size:=Dirinfo.Size;
    P2^.attr:=Dirinfo.attr;
    P2^.PPoint:=P1;
    P2^.NPoint:=nil;
    P1:=P2;
    repeat
     FindNext(Dirinfo);
     DError:=DosError;
     if (DError<>0)and(DError<>18) then ShowDosError
      else
       begin
        New(P2);
        P1^.NPoint:=P2;
        P2^.name:=Dirinfo.Name;
        P2^.size:=Dirinfo.Size;
        P2^.attr:=Dirinfo.attr;
        P2^.PPoint:=P1;
        P2^.NPoint:=nil;
        P1:=P2;
       end;
    until DError=18;
   end;
 LFile:=P1;
 ColFiles:=0;
 SizeOfDir:=0;
 While P1^.PPoint<>nil do
  begin
   p1:=P1^.PPoint;
   SizeOfDir:=SizeOfDir+P1^.size;
   inc(ColFiles);
  end;
 dec(ColFiles);
 FFile:=P1;
end;

Procedure ShowFiles(FF:pointer;N:byte);
var i:byte;
begin
 P2:=FF^.NPoint;
 for i:=1 to 18 do
 begin
  if i<>N
   then textbackground(black)
   else textbackground(green);
  gotoxy(2,i+1);
  write('            ณ         ');
  if P2^.NPoint<>nil then
   begin
    if P2^.attr=$10 then
      begin
       if (pos('.',P2^.name)=0)or(P2^.name='.')or(P2^.name='..') then
        begin
         if P2^.name<>'.'then
          begin
           gotoxy(2,i+1);
           Write(P2^.name);
           gotoxy(16,i+1);
           write('< DIR >');
          end;
        end
       else
        begin
         gotoxy(2,i+1);
         Write(copy(P2^.name,1,pos('.',P2^.name)-1));
         gotoxy(11,i+1);
         Write(copy(P2^.name,pos('.',P2^.name)+1,5));
         gotoxy(16,i+1);
         write('< DIR >');
        end;
      end
     else
      begin
       if (pos('.',P2^.name)=0) then
        begin
         gotoxy(2,i+1);
         Write(P2^.name);
         gotoxy(15,i+1);
         write(P2^.size:9);
        end
       else
        begin
         gotoxy(2,i+1);
         Write(copy(P2^.name,1,pos('.',P2^.name)-1));
         gotoxy(11,i+1);
         Write(copy(P2^.name,pos('.',P2^.name)+1,3));
         gotoxy(15,i+1);
         write(P2^.size:9);
        end;
      end;
     P2:=P2^.NPoint;
  end;
 end;
 textbackground(black);
 gotoxy(2,21);
 write(ColFiles:5,' F & D');
 gotoxy(13,21);
 write(round(SizeOfDir/1024):7,' Kb');
 delay(10);
end;

Procedure ExProgram;
begin
 window(0,0,80,24);
 TextBackGround(black);
 TextColor(white);
 clrscr;
 halt(1);
end;

Procedure showdisks;
var n:byte;
begin
 n:=0;
 for i:=3 to 26 do
  begin
   if disks[i]=true
    then
     begin
      gotoxy(34+n*3,2);
      write(chr(i+64));
      inc(n)
     end;
  end;
end;

Function ChooseFile:Pointer;
var
  NCurFile:integer;
  CurFile:byte;
  PFile:Pointer;
begin
 GetDirFiles('.');
 CurFile:=1;
 NCurFile:=1;
 ShowFiles(FFile,1);
 PFile:=FFile;
 repeat
  rk:=readkey;
   if rk=#60
   then
    begin
     showdisks;
    end;
   if (rk=#80)and(ColFiles>NCurFile)
   then
    begin
     inc(CurFile);
     inc(NCurFile);
     if CurFile>18 then
      begin
       PFile:=PFile^.NPoint;
       CurFile:=18;
      end;
     ShowFiles(PFile,Curfile);
    end;
  if (rk=#72)and(NCurFile>1)
   then
    begin
     dec(CurFile);
     dec(NCurFile);
     if CurFile<1 then
      begin
       PFile:=PFile^.PPoint;
       CurFile:=1;
      end;
     ShowFiles(PFile,Curfile);
    end;
  if rk=#27 then ExProgram;
 until (rk=#13)or(rk=#27);
 for i:=1 to CurFile do PFile:=PFile^.NPoint;
 ChooseFile:=PFile;
end;

Procedure GetDisks;
var i:byte;
begin
 for i:=3 to 26 do
  begin
   if DiskSize(i)<>-1 then disks[i]:=true
    else disks[i]:=false;
  end;
end;

BEGIN
Window(0,0,80,24);
TextBackGround(Black);
TextColor(White);
clrscr;
GetDisks;
Window(0,0,80,24);
TextBackGround(Black);
TextColor(White);
clrscr;
ShowFileBox;
Gotoxy(37,4);
write('• เ ชโฅเจแโจชจ ข๋กเ ญญฎฃฎ ไ ฉซ ');
Gotoxy(24,5);
write('วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ');
Gotoxy(26,6);
write('ฌ๏    :');
Gotoxy(26,2);
write('จแช :');
Gotoxy(24,3);
write('ฬอออออออออออออออออออออออออออออออออออออออออออออออออออออออน');
Gotoxy(26,7);
write(' งฌฅเ :           ฉโ.');
Gotoxy(24,8);
write('ฬอออออออออออออออออออออออออออออออออออออออออออออออออออออออน');
Gotoxy(43,9);
write('‘ฎงค ข ฅฌ๋ฉ ไ ฉซ');
Gotoxy(24,10);
write('วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ');
Gotoxy(1,23);
write('F2:‘ฌฅญจโ์ คจแช  Enter:๋กฎเ ไ ฉซ   Esc:๋ๅฎค ');

repeat
 MyFile:=ChooseFile;
 if MyFile^.Attr=$10 then chdir(MyFile^.name);
 P1:=LFile^.PPoint;
 for i:=1 to ColFiles do
  begin
   Dispose(P1^.NPoint);
   P1:=P1^.PPoint;
  end;
  dispose(FFile);
until MyFile^.Attr<>$10;
{ write('ขฅคจโฅ จฌ๏ จแๅฎคญฎฃฎ ไ ฉซ  :');
 readln(name);
 assign(f1,name);
 reset(f1);
 assign(f2,'grab.wav');
 rewrite(f2);
 write('งขซฅช ฅฌ จง ไ ฉซ  ญ ็จญ ๏ แ ฏฎงจๆจจ :');
 readln(nach);
 seek(f1,nach);
 write('ฎซซจ็ฅแโขฎ ก ฉโ :');
 readln(col);
 x:=wherex;y:=wherey;
 for i:=1 to col do
  begin
   read(f1,b);
   write(f2,b);
   gotoxy(x,y);
   write(round(i/col*100):3,'%');
  end;
 close(f1);
 close(f2);
}END.