{$R-,I-,S-,G+}
program anti;
uses dos;
var fn,ps:pathstr;
    dr:dirstr;
    name:namestr;
    ext:extstr;
    f:file;
    h,l,d,dn:byte;
    wr,fl,v,sg:word;
    ch:char;
    cle:boolean;
    as:array[0..2] of byte;
procedure dln; assembler;
asm
	mov	al,13
	int	29H
	mov     ax,0A20H
	mov	cx,80
	mov	bh,0
	int	10H
end;
function inkey:char; assembler;
asm
	mov	ah,7
	int	21H
end;
function quest(vr:string):boolean;
begin
 write(' á†‡†¶•≠ ['+vr+']. ã•Á®‚Ï (y/n)? '); ch:=inkey;
 if upcase(ch)='N' then begin writeln('N'); quest:=false end
 else begin write('Y'); quest:=true end
end;
procedure dgt(ori,len:integer;n:char);
begin
 if ext='.COM' then begin
  reset(f,1); blockread(f,l,1);
  if l=$E9 then begin
   blockread(f,l,1); blockread(f,h,1); inc(l,3);
   if l<3 then inc(h,(ord(n)-48)and 1); wr:=h shl 8+l+len;
   if wr=filesize(f) then begin
    seek(f,wr-ori); blockread(f,as,3);
    seek(f,wr-len); blockread(f,l,1); blockread(f,h,1); seek(f,wr-len);
    if (l=96) and (h=139) then begin
     d:=1;
     if quest('GLUK'+n) then begin
      cle:=false; truncate(f); seek(f,0);
      blockwrite(f,as,3); writeln(' Ok')
     end
    end
   end
  end; close(f)
 end
end;
procedure mes(s:string);
begin
 writeln('Ç Ø†¨Ô‚® ≠†©§•≠ ¢®‡„· ['+s+'] ... Æ°•ß¢‡•¶•≠.')
end;
procedure rem(o,b:word;n:char);
begin
 if memw[0:o]=$1E60 then begin
  mes('GLUK'+n); memw[0:o]:=b
 end
end;
procedure rsv;
function present:boolean; assembler;
asm
	mov	ah,84H
	int	21H
	cmp	dx,1990H
	jnz	@@0
	cmp	bh,50H
	jnz	@@0
	xchg	al,ah
	not	ax
	mov	sg,ax
	mov	al,0FFH
	jmp	@@1
@@0:	xor	ax,ax
@@1:
end;
begin
 if present then begin
  mes('SVC50'); memw[sg:$07A2]:=$35EB; meml[sg:$0142]:=$000762E9;
  mem[sg:$082C]:=$CF; mem[sg:$0814]:=$CF
 end
end;
procedure svc;
var old:array[0..23]of byte;
    ah,dh,i:byte;
    che:word;
    size:longint;
begin
 reset(f,1);
 size:=filesize(f);
 if size>4000 then begin
  seek(f,size-148); blockread(f,che,2); seek(f,size-1); blockread(f,i,1);
  if (che=$5653)and(i=$50)then begin
   d:=1;
   if quest('SVC50') then begin
    cle:=false; seek(f,size-117); blockread(f,old,24); seek(f,size-5);
    blockread(f,ah,1); blockread(f,dh,1);
    for i:=0 to 23 do begin old[i]:=old[i] xor ah; inc(ah,dh) end;
    seek(f,0); blockwrite(f,old,24); seek(f,size-3103); truncate(f);
    writeln(' Ok')
   end
  end
 end; close(f)
end;
procedure searchdir(dir:pathstr);
var srec:searchrec;
begin
 if dir[length(dir)]<>'\' then dir:=dir+'\'; findfirst(dir+'*.*',$3F,srec);
 while doserror=0 do begin
  fn:=dir+srec.name; fsplit(fn,dr,name,ext);
  if (ext='.COM')or(ext='.EXE')then begin
   dln; write(fn);
   if srec.size>132 then begin
    inc(fl); assign(f,fn); setfattr(f,srec.attr and $FE); d:=0;
    repeat cle:=true; dgt(89,144,'0'); if cle then dgt(90,140,'1');
     if cle then dgt(86,132,'2'); if cle then svc until cle;
    inc(v,d); setfattr(f,srec.attr)
   end
  end; findnext(srec)
 end;
 findfirst(dir+'*.*',$10,srec);
 while doserror=0 do begin
  with srec do if(name[1]<>'.')and(attr and $10<>0)then searchdir(dir+name);
  findnext(srec)
 end
end;
begin
 v:=0; fl:=0;
 writeln('…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª'#13#10+
         '∫      Ä≠‚®¢®‡„· V 1.3      ∫'#13#10+
	 '∫ §´Ô ÆÁ•≠Ï £≠„·≠ÎÂ ¢®‡„·Æ¢ ∫'#13#10+
	 '∫ Copyright 1991 by Rusakov ∫'#13#10+
	 '»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº');
 rem($27A,$53EB,'0'); rem($385,$54EB,'1'); rem($341,$50EB,'2'); rsv;
 ps:=paramstr(1); for l:=1 to length(ps) do ps[l]:=upcase(ps[l]);
 if ps='*' then begin
  ps:='C:'; dn:=3;
  while disksize(dn)>0 do begin searchdir(ps); inc(ps[1]); inc(dn) end
 end else searchdir(ps);
 dln; writeln('è‡Æ¢•‡•≠Æ: ',fl,#13#10'á†‡†¶•≠Æ: ',v)
end.
