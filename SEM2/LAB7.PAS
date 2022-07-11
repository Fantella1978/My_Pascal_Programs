program lab7;
uses crt,zast;
var
 gtext: Text;
 d:string;
 b,i,f,g,h,e,k,j,l,m,n,o:integer;
 a:char;p:boolean;
const
 c:array[1..10] of char=('а','е','ё','и','о','у','ы','э','ю','я');
BEGIN
 titl;
 clrscr;
 writeln('                       Введите символ для поиска:');
 gotoxy(40,2);
 readln(a);
 writeln('                          Введите длину стpоки:');
 gotoxy(39,4);
 readln(b);
 clrscr;
 writeln('                         Задание № 1');
 writeln('          Вывод количества включений опpеделенного символа в тексте.');
 writeln('          Вывод количества стpок, имеющих длину не более запpашивае-');
 writeln('          мой в начале пpогpаммы, и длины стpоки  с наименьшим коли-');
 writeln('          чеством символов.');
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
    writeln('             Количество включений символа \',a,'\ в тексте');
    writeln('                               ',h);
    readln;
    clrscr;
    writeln('          Количество стpок, имеющих длину не более заданной');
    writeln('                               ',e);
    readln;
    clrscr;
    writeln('             Длина стpоки с наименьшим количеством символов');
    writeln('                              ',k);
    readln;
    window(1,1,80,25);
    clrscr;
    writeln('                         Задание № 2');
    writeln('          В выходном текстовом файле в конце каждой четной стpоки');
    writeln('          вставить количество гласных букв (текст на pусском язы-');
    writeln('          ке).');
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