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
   2:Write('���� �� ������.');
   3:Write('���� �� ������.');
   5:Write('����� ���p�饭.');
   6:Write('Invalid handle.');
   8:Write('�������筮 �����.');
  10:Write('������� ��p������ ��p㦥���.');
  11:Write('����p�� �p���.');
  18:Write('��� ����� 䠩���.');
 end;
end;

Procedure ShowFileBox;
begin
 clrscr;
 gotoxy(1,1);
 write('������������������������������������������������������������������������������ͻ');
 for i:=1 to 18 do write('�            �         �                                                       �');
 write('����������������������͹                                                       �');
 write('�                      �                                                       �');
 write('������������������������������������������������������������������������������ͼ');
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
  write('            �         ');
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
write('��ࠪ���⨪� ��࠭���� 䠩��');
Gotoxy(24,5);
write('�������������������������������������������������������Ķ');
Gotoxy(26,6);
write('���    :');
Gotoxy(26,2);
write('��� :');
Gotoxy(24,3);
write('�������������������������������������������������������͹');
Gotoxy(26,7);
write('������ :          ����.');
Gotoxy(24,8);
write('�������������������������������������������������������͹');
Gotoxy(43,9);
write('���������� 䠩�');
Gotoxy(24,10);
write('�������������������������������������������������������Ķ');
Gotoxy(1,23);
write('F2:������� ���  Enter:�롮� 䠩��  Esc:��室 ');

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
{ write('������ ��� ��室���� 䠩�� :');
 readln(name);
 assign(f1,name);
 reset(f1);
 assign(f2,'grab.wav');
 rewrite(f2);
 write('��������� �� 䠩�� ��稭�� � ����樨 :');
 readln(nach);
 seek(f1,nach);
 write('�������⢮ ���� :');
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