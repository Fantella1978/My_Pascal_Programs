uses crt,graph;

var x,y,dx,dy,len    :integer;
    BmpPal           :array[0..15,1..4] of byte;
    Pal              :PaletteType;
    from             :longint;
    d,m,i            :integer;
    bpp,c            :byte;
    f                :file;
    buf              :array[0..1000] of byte;


procedure ShowBmp(s:string);
 begin
   assign(f,s);
   reset(f,1);
   if ioresult=0 then
    begin
      seek(f,$0A); blockread(f,from,4);
      seek(f,$12); blockread(f,dx,2);
      seek(f,$16); blockread(f,dy,2);
      seek(f,$1c); blockread(f,bpp,1);
      if bpp<>4 then exit;
      len:=((dx+1) div 2+3) and $FFFC;
      seek(f,from-64);
      blockread(f,BmpPal,64);

      DetectGraph(d,m);
      InitGraph(d,m,'');

      GetPalette(pal);
      for i:=0 to 15 do
      SetRGBPalette(Pal.colors[i],BmpPal[i,3] div 4,BmpPal[i,2] div 4,
                    BmpPal[i,1] div 4 );

      seek(f,from);
      for y:=1 to dy do
       begin
         blockread(f,buf,len);
         for x:=0 to dx-1 do
          putpixel(x,dy-y,(buf[x shr 1] shr ((1-  x and 1) shl 2)) and $0F);
       end;
      while keypressed do readkey;
      readkey;
      while keypressed do readkey;
      closegraph;
      close(f);
    end;
 end;

BEGIN
{$i-}
  if paramcount>0 then ShowBmp(paramstr(1));
END.