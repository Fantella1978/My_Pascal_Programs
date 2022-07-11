program Easy_Font_Changer;

uses Crt;

var s:string;
    f:file;
    Font:array[1..4096] of byte;
    fontoffset,fontsegment:word;
    fontlength:byte;

begin
  clrscr;
  Writeln('    Easy Font Changer                                (C) 1994  þ TWC þ');
  if (paramcount=0) then  begin
                            Writeln;
                            Writeln('    Usage: EFC <fontname>');
                            Writeln('    Enter  EFC * to switch back to normal font');
                            Writeln;
                            Halt(1);
                          end;
  s:=paramstr(1);
  if s='*' then begin
                  Writeln;
                  Writeln('    Press a key to switch back to normal...');
                  repeat until keypressed;
                  asm
                    mov ax,0003h
                    mov bl,0
                    int 10h
                  end;
                  Halt(3);
                end;
  assign(f,s);
  {$I-}
  reset(f,1);
  {$I+}
  if IOResult<>0 then begin
                        writeln;
                        writeln('    File not found');
                        Writeln;
                        Halt(2);
                      end;
  blockread(f,font,filesize(f));
  fontoffset:=ofs(font);
  fontsegment:=seg(font);
  fontlength:=filesize(f) shr 8;
  asm
	push	bp
	push 	es
	mov	ax,fontoffset
	mov	bp,ax
	mov	ax,fontsegment
        mov	es,ax
	mov	ax,1110h
	mov	bh,fontlength
	xor	bl,bl
	mov	cx,100h
	xor	dx,dx
	int	10h
	pop	es
	pop	bp
  end;
  Writeln;
  Writeln('    Font installed');
  Writeln;
  close(f);
end.