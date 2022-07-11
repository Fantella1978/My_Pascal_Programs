(*************************************************************************)
(*                Character Generator Programming Unit                   *)
(*                            Version 1.1                                *)
(*                    (C) Konoplev B.W. 1992,93                          *)
(*                                                                       *)
(*  This stuff contains some parts grabbed from TRIDENT VGA VIDEO BIOS   *)
(*************************************************************************)
unit CharGen;

interface

type TChar      = Array[0..$F] of Byte;
     TCharTable = Array[0..$FF] of TChar;

procedure ReadTable(var TablePtr);
procedure WriteTable(var TablePtr);
procedure GetChar(CharNum: Integer; var CharSet);
procedure SetChar(CharNum: Integer; var CharSet);

implementation

procedure ReadTable(var TablePtr);
 begin
              asm;
                push bp
                push ds

                les di,TablePtr

                mov dx,3C4h
               	mov ax,402h
                out dx,ax		(* set map mask 4 : only plane 2; *)
                mov ax,704h
                out dx,ax		(* set memory model (text, >64k,seg.) *)
                mov dx,3CEh
                mov ax,204h
                out dx,ax               (* read map select: plane 2       *)
                mov ax,5
                out dx,ax		(* write mode 0                   *)
                mov ax,406h
        	out dx,ax		(* memory mapping for CPU : a000h, 64k. *)

                cld                     (* Clear Direction for Moving String *)
                mov ax,0A000h
                mov ds,ax               (* DS = Video Segment *)
                xor si,si               (* SI = 0             *)
                mov cx,256              (* 256 Chars to copy  *)
                mov bx,10h              (* Font ..x16         *)
                mov dx,20h              (* Next Char offset   *)
                sub dx,bx
@@Loop_Copy:
	        push cx
                mov cx,bx
                rep movsb               (* Rep when cx >0 Mov [si] to es:[di] *)
                add si,dx               (* Next Char to copy       *)
                pop cx
                loop @@Loop_Copy

                mov dx,3C4h
                mov ax,302h
                out dx,ax
                mov ax,304h
                out dx,ax
                mov dx,3CEh
                mov ax,4
                out dx,ax
                mov ax,1005h
                out dx,ax

                mov ax,0E06h
                out dx,ax

                pop ds
                pop bp
              end;
 end;

procedure WriteTable(var TablePtr);
 begin
              asm;
                push bp
                push ds

                lds si,TablePtr

                mov dx,3C4h
               	mov ax,402h
                out dx,ax		(* set map mask 4 : only plane 2; *)
                mov ax,704h
                out dx,ax		(* set memory model (text, >64k,seg.) *)
                mov dx,3CEh
                mov ax,204h
                out dx,ax               (* read map select: plane 2       *)
                mov ax,5
                out dx,ax		(* write mode 0                   *)
                mov ax,406h
        	out dx,ax		(* memory mapping for CPU : a000h, 64k. *)

                cld                     (* Clear Direction for Moving String *)
                mov ax,0A000h
                mov es,ax               (* ES = Video Segment *)
                xor di,di               (* DI = 0             *)
                mov cx,256              (* 256 Chars to copy  *)
                mov bx,10h              (* Font ..x16         *)
                mov dx,20h              (* Next Char offset   *)
                sub dx,bx
@@Loop_Copy:
	        push cx
                mov cx,bx
                rep movsb               (* Rep when cx >0 Mov [si] to es:[di] *)
                add di,dx               (* Next Char to copy       *)
                pop cx
                loop @@Loop_Copy

                mov dx,3C4h
                mov ax,302h
                out dx,ax
                mov ax,304h
                out dx,ax
                mov dx,3CEh
                mov ax,4
                out dx,ax
                mov ax,1005h
                out dx,ax

                mov ax,0E06h
                out dx,ax

                pop ds
                pop bp
              end;
 end;

procedure GetChar(CharNum: Integer; var CharSet);
 begin
              asm;
                push bp
                push ds

                mov dx,3C4h
               	mov ax,402h
                out dx,ax		(* set map mask 4 : only plane 2; *)
                mov ax,704h
                out dx,ax		(* set memory model (text, >64k,seg.) *)
                mov dx,3CEh
                mov ax,204h
                out dx,ax               (* read map select: plane 2       *)
                mov ax,5
                out dx,ax		(* write mode 0                   *)
                mov ax,406h
        	out dx,ax		(* memory mapping for CPU : a000h, 64k. *)

                cld                     (* Clear Direction for Moving String *)
                mov si,CharNum
                les di,CharSet
                mov ax,0A000h
                mov ds,ax               (* DS = Video Segment *)
                mov ax,20h
                mul si
                mov si,ax
                mov cx,10h              (* Font: ..x16 *)
                rep movsb

                mov dx,3C4h
                mov ax,302h
                out dx,ax
                mov ax,304h
                out dx,ax
                mov dx,3CEh
                mov ax,4
                out dx,ax
                mov ax,1005h
                out dx,ax
                mov ax,0E06h
                out dx,ax

                pop ds
                pop bp
              end;

 end;

procedure SetChar(CharNum: Integer; var CharSet);
 begin
              asm;
                push bp
                push ds

                mov dx,3C4h
               	mov ax,402h
                out dx,ax		(* set map mask 4 : only plane 2; *)
                mov ax,704h
                out dx,ax		(* set memory model (text, >64k,seg.) *)
                mov dx,3CEh
                mov ax,204h
                out dx,ax               (* read map select: plane 2       *)
                mov ax,5
                out dx,ax		(* write mode 0                   *)
                mov ax,406h
        	out dx,ax		(* memory mapping for CPU : a000h, 64k. *)

                cld                     (* Clear Direction for Moving String *)
                mov di,CharNum
                lds si,CharSet
                mov ax,0A000h
                mov es,ax               (* ES = Video Segment *)
                mov ax,20h
                mul di
                mov di,ax
                mov cx,10h              (* Font: ..x16 *)
                rep movsb

                mov dx,3C4h
                mov ax,302h
                out dx,ax
                mov ax,304h
                out dx,ax
                mov dx,3CEh
                mov ax,4
                out dx,ax
                mov ax,1005h
                out dx,ax
                mov ax,0E06h
                out dx,ax

                pop ds
                pop bp
              end;

 end;

Begin
End.
