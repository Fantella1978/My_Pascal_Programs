
uses crt,dos;
var
    f:file of byte;
    t:text;
    a,b:byte;
    c:char;
    d:string[80];
    i,k:1..30000;
    mas:array[0..30000]of char;
begin
 writeln;
 writeln('Use PIC.BMP file (80x*x256color) to converte.');
 writeln;
 assign(f,'pic.bmp');
 assign(t,'pic.txt');
 reset(f);
 rewrite(t);
 seek(f,1080);
 k:=1;
 while not eof(f) do
  begin
   read(f,a);
   case a of
      0..15 :c:=' ';
     16..31 :c:=' ';
     32..47 :c:=' ';
     48..63 :c:='.';
     64..79 :c:=',';
     80..95 :c:=':';
     96..111:c:=';';
    112..127:c:='L';
    128..143:c:='W';
    144..159:c:='H';
    160..175:c:='R';
    176..191:c:='@';
    192..207:c:='M';
    208..223:c:='M';
    224..239:c:='&';
    240..255:c:='$';
   end;
   mas[k]:=c;
   inc(k);
  end;
b:=2;
i:=1;
d:='                USE HIGH-RESOLUTION TEXT MODE TO VIEW THE PICTURE';
writeln(t,d);
d:='ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป';
writeln(t,d);
c:='บ';
write(t,c);
while i<k do
 begin
   write(t,mas[k-i]);
   inc(b);inc(i);
   if b=78 then
    begin
     c:='บ';
     writeln(t,c);
     if (i+4)<k then write(t,c);
     b:=2;
     i:=i+4;
    end;
 end;
d:='ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ';
writeln(t,d);
 close(f);
 close(t);
end.