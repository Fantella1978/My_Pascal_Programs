program lab7;
uses crt,zast;
var
 gtext: Text;
 d:string;
 b,i,f,g,h,e,k,j,l,m,n,o:integer;
 a:char;p:boolean;
const
 c:array[1..10] of char=('�','�','�','�','�','�','�','�','�','�');
BEGIN
 titl;
 clrscr;
 writeln('                       ������ ᨬ��� ��� ���᪠:');
 gotoxy(40,2);
 readln(a);
 writeln('                          ������ ����� ��p���:');
 gotoxy(39,4);
 readln(b);
 clrscr;
 writeln('                         ������� � 1');
 writeln('          �뢮� ������⢠ ����祭�� ��p���������� ᨬ���� � ⥪��.');
 writeln('          �뢮� ������⢠ ��p��, ������ ����� �� ����� ���p�訢��-');
 writeln('          ��� � ��砫� �p��p����, � ����� ��p���  � �������訬 ����-');
 writeln('          ��⢮� ᨬ�����.');
 window(1,7,80,21);
 assign(gtext,'a:\pasprogr\lab\sem2\atext.pas');
 reset(gtext);
 clrscr;
 k:=80;
 while not EOF(gtext) do
  Begin
   readln(gtext,d);
   i:=length(d);f:=0;
   for g:=1 to i do
    Begin
     if d[g]=a then
      f:=f+1;
    End;
      h:=h+f;
      if length(d)<=b then
       e:=e+1;
      if i<k then
       k:=i;
      writeln('        ',d);
   End;
    writeln;writeln;
    window(7,22,75,25);
    writeln('             ������⢮ ����祭�� ᨬ���� \',a,'\ � ⥪��');
    writeln('                               ',h);
    readln;
    clrscr;
    writeln('          ������⢮ ��p��, ������ ����� �� ����� ��������');
    writeln('                               ',e);
    readln;
    clrscr;
    writeln('             ����� ��p��� � �������訬 ������⢮� ᨬ�����');
    writeln('                              ',k);
    readln;
    window(1,1,80,25);
    clrscr;
    writeln('                         ������� � 2');
    writeln('          � ��室��� ⥪�⮢�� 䠩�� � ���� ������ �⭮� ��p���');
    writeln('          ��⠢��� ������⢮ ������ �㪢 (⥪�� �� p��᪮� ��-');
    writeln('          ��).');
    window(1,7,80,21);
    assign(gtext,'a:\pasprogr\lab\sem2\atext.pas');
    reset(gtext);
    while not EOF(gtext) do
     Begin
      readln(gtext,d);
      i:=length(d);n:=0;
      for g:=1 to i do
       for m:=1 to 10 do
       Begin
        if d[g]=c[m] then
         n:=n+1;
       End;
         o:=o+1;
         p:=odd(o);
        if p=false then
        Begin
         write('        ',d);
         writeln(' ',n);
        End
        else
         writeln('        ',d);
       End;
       readln;
       con;
END.