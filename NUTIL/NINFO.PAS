Program ninfo;
uses
  crt,dos,vadim;
var
 mon,num,year,dat:word;
 ver:word;
 x,y,pr,proc:byte;
 br,vr:boolean;
const
 a:integer=2;
 b:integer=3;
 c:integer=35;
 d:integer=10;
begin
 x:=wherex;
 y:=wherey;
 getdate(year,mon,num,dat);
 ver:=dosversion;
 pr:=test8086;
 proc:=test8087;
 getcbreak(br);
 getverify(vr);
 winop(a,b,c,d,blue,yellow);
 textcolor(white);
 write('����: ');
 case dat of
  1:write('�������쭨�');
  2:write('��୨�');
  3:write('�।�');
  4:write('�⢥�');
  5:write('��⭨�');
  6:write('�㡡��');
  7:write('����ᥭ�');
 end;
 writeln(' ',num,'.',mon,'.',year,' �.');
 writeln('����� DOS :',ver-int(ver/256)*256:1:0,'.',int(ver/256):2:0);
 write('Ctrl+Break ');
 case br of
  false:writeln('�몫.');
  true:writeln('���.');
 end;
 write('Verify  ');
 case vr of
  false:writeln('�몫.');
  true:writeln('���.');
 end;
 write('������: ');
 case pr of
  0:writeln('8086');
  1:writeln('80286');
  2:writeln('80386');
  3:writeln('80486');
  4:writeln('Pentium');
 end;
 write('��������: ');
 case proc of
  0:write('���.');
  1:write('8087');
  2:write('80287');
  3:write('80387');
  4:write('80487');
 end;
 window(1,1,80,25);
 gotoxy(x,y);
 textbackground(black);
end.
