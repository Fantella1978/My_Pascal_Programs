{ Copyright Illegal Function '93 }
{ Call our WHQ, The Message Center, the number is (914) 446 895 }

Program Lines;

uses Crt;


Procedure line(x1,y1,x2,y2:word;col:byte); assembler;
var ddx,ddy : word;
    sx,sy : word;
asm
        mov     ax,0a000h
        mov     es,ax
        mov     ax,[y1]
        mov     bx,320
        imul    bx
        mov     di,[x1]
        add     di,ax
        mov     ax,[x2]
        clc
        mov     bx,1
        sub     ax,[x1]
        jnc     @@1
        neg     ax
        mov     bx,0ffffh
@@1:    mov     [ddx],ax
        mov     [sx],bx
        mov     ax,[y2]
        clc
        mov     bx,320
        sub     ax,[y1]
        jnc     @@2
        neg     ax
        mov     bx,-320
@@2:    mov     [ddy],ax
        mov     [sy],bx

        cmp     ax,[ddx]
        ja      @@yGrtr
        mov     cx,[ddx]
        inc     cx
        mov     bx,[ddx]
        shr     bx,1
        mov     al,[col]
@@x1:   mov     byte ptr [es:di],al
        add     di,[sx]
        clc
        sub     bx,[ddy]
        jnc     @@xg
        add     di,[sy]
        add     bx,[ddx]
@@xg:   loop    @@x1
        jmp     @@ret
@@yGrtr:mov     cx,[ddy]
        inc     cx
        mov     bx,[ddy]
        shr     bx,1
        mov     al,[col]
@@y1:   mov     byte ptr [es:di],al
        add     di,[sy]
        clc
        sub     bx,[ddx]
        jnc     @@yg
        add     di,[sx]
        add     bx,[ddy]
@@yg:   loop    @@y1
@@ret:
end;


Begin
  Inline($B8/$13/0/$CD/$10); { Select video mode 13h (320x200 with 256 colors) }
  Line(100,50,150,50,15);    { Line (x1, y1, x2, y2 and color }
  repeat
  until keypressed;
  Inline($B8/$3/0/$CD/$10);  { Select video mode 3h (NORMAL TEXT MODE) }

end.










repeat
until keypressed;

end.

