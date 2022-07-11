unit DigiPlay;
interface
procedure Speaker(Speed,HowMany:word;Buffer:pointer);
procedure Covox  (Speed,HowMany:word;Buffer:pointer;Port:word);
procedure StopPlay;
function  CalculateSpeed:real;
implementation
procedure Speaker(Speed,HowMany:word;Buffer:pointer);assembler;
    asm
	push es
        mov al,0FEh
        out 21h,al
        mov al,3
        out 61H,al
        mov al,90h
        out 43H,al
        mov dx,1
        les si,Buffer
	cli
    @1:	mov cx,Speed
@loopl: loop @LoopL
	mov al,es:[si]
        shr al,1
    	out 42H,al
        inc DX
        inc si
	cmp dx,HowMany
	jne @1
        xor al,al
        out 21h,al
	sti
	pop es
end;
procedure Covox(Speed,HowMany:word;Buffer:pointer;Port:word);assembler;
    asm
        cli
	push es
        mov al,0FEh
        out 21h,al
        mov dx,Port
        mov di,1
        les si,Buffer
    @1:	mov cx,Speed
@loopl: loop @LoopL
	mov al,es:[si]
    	out dx,al
        inc di
        inc si
	cmp di,HowMany
	jne @1
        xor al,al
        out 21h,al
	pop es
	sti
end;

function CalculateSpeed:real;
var
    t11,T21,t12,t22:word;
begin
     t11:=0;t21:=0;t12:=0;t22:=0;
     asm
        cli
        push    es
        mov     ax,0
        mov     es,ax
        mov     AX,es:[46CH]
        mov     T11,AX
        mov     AX,es:[46EH]
        mov     T12,AX
        push    cx
        mov     ah,0
        int     1aH
        push    cx
        pop     cx
        mov     ah,1
        int     1aH
        sti
        mov     cx,40
     @1:push    cx
        mov     cx,07FFFH
     @2:loop    @2
        pop     cx
        loop    @1
        cli
        pop     cx
        mov     AX,es:[46CH]
        mov     t21,AX
        mov     AX,es:[46EH]
        mov     T22,AX
        pop     es
        sti
     END;
     CalculateSpeed:=209/((t21-t11)+(t22-t12)*$FFFF);
end;
procedure StopPlay;assembler;
asm
   xor  al,al
   out  61h,al
end;

begin
end.