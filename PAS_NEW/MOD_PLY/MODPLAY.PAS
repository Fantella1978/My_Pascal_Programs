UNIT MODPLAY;

INTERFACE

CONST Detection         = 0;
      SoundBlaster      = 1;
      SoundBlaster_Pro  = 2;
      Gravis_UltraSound = 3;

VAR   Soundcard: WORD;
      Channels:  WORD;
      Peak:      ARRAY [1..8] OF BYTE;

PROCEDURE Mod_Init(Driver,Port: WORD; IRQ,DMA: BYTE);
PROCEDURE Mod_Load(File_Name: STRING);
PROCEDURE Mod_Play(Looping: WORD);
PROCEDURE Mod_Stop;
PROCEDURE Mod_Volume(Volume: BYTE);
FUNCTION  Mod_Status: WORD;
FUNCTION  Mod_Position: WORD;
PROCEDURE Mod_Rewind;
PROCEDURE Mod_Forward;
PROCEDURE Mod_Peak;


IMPLEMENTATION

USES DETECT,SB_DRV,SBP_DRV,GUS_DRV;

VAR Mod_Driver,Old_Exit: POINTER;
    Mod_File:            STRING[128];

PROCEDURE Mod_Close; FAR; ASSEMBLER;    {* do not call this procedure! *}
ASM
  mov     ax,WORD PTR [Old_Exit]
  mov     dx,WORD PTR [Old_Exit+2]
  mov     WORD PTR [ExitProc],ax
  mov     WORD PTR [ExitProc+2],dx
  mov     bx,1
  call    DWORD PTR [Mod_Driver]
END;

PROCEDURE Mod_Init(Driver,Port: WORD; IRQ,DMA: BYTE); ASSEMBLER;
ASM
  mov     ax,[Driver]
  or      ax,ax
  jz      @@1
  cmp     ax,Gravis_UltraSound
  ja      @@Error
  mov     cl,BYTE PTR [IRQ]
  mov     ch,BYTE PTR [DMA]
  mov     dx,[Port]
  jmp     @@2
@@1:
  call    FAR PTR Detect_Hardware
  or      ax,ax
  jz      @@Error
  cmp     ax,Gravis_UltraSound
  ja      @@Error
@@2:
  mov     [Soundcard],ax
  mov     WORD PTR [Mod_Driver],0
  cmp     ax,SoundBlaster
  jnz     @@3
  mov     WORD PTR [Mod_Driver+2],SEG Driver_SB
  jmp     @@Test
@@3:
  cmp     ax,SoundBlaster_Pro
  jnz     @@4
  mov     WORD PTR [Mod_Driver+2],SEG Driver_SBP
  jmp     @@Test
@@4:
  mov     WORD PTR [Mod_Driver+2],SEG Driver_GUS
@@Test:
  xor     bx,bx
  call    DWORD PTR [Mod_Driver]
  or      ax,ax
  jz      @@Error
  mov     ax,WORD PTR [ExitProc]
  mov     dx,WORD PTR [ExitProc+2]
  mov     WORD PTR [Old_Exit],ax
  mov     WORD PTR [Old_Exit+2],dx
  mov     WORD PTR [ExitProc],OFFSET Mod_Close
  mov     WORD PTR [ExitProc+2],SEG Mod_Close
  jmp     @@Out
@@Error:
  mov     [Soundcard],0
@@Out:
END;

PROCEDURE Mod_Load(File_Name: STRING); ASSEMBLER;
ASM
  mov     ax,[Soundcard]
  or      ax,ax
  jz      @@Out
  cld
  mov     ax,ds
  mov     es,ax
  lds     si,DWORD PTR [File_Name]
  lodsb
  mov     cl,al
  and     cx,7Fh
  mov     dx,OFFSET Mod_File
  mov     di,dx
  rep     movsb
  xor     al,al
  stosb
  mov     ax,es
  mov     ds,ax
  mov     bx,2
  call    DWORD PTR [Mod_Driver]
@@Out:
  mov     [Channels],ax
END;

PROCEDURE Mod_Play(Looping: WORD); ASSEMBLER;
ASM
  cmp     [Soundcard],0
  jz      @@Out
  mov     bx,3
  mov     ax,[Looping]
  call    DWORD PTR [Mod_Driver]
@@Out:
END;

PROCEDURE Mod_Stop; ASSEMBLER;
ASM
  cmp     [Soundcard],0
  jz      @@Out
  mov     bx,4
  call    DWORD PTR [Mod_Driver]
@@Out:
END;

PROCEDURE Mod_Volume(Volume: BYTE); ASSEMBLER;
ASM
  cmp     [Soundcard],0
  jz      @@Out
  mov     bx,5
  mov     al,[Volume]
  call    DWORD PTR [Mod_Driver]
@@Out:
END;

FUNCTION  Mod_Status: WORD; ASSEMBLER;
ASM
  mov     ax,[Soundcard]
  or      ax,ax
  jz      @@Out
  mov     bx,6
  call    DWORD PTR [Mod_Driver]
@@Out:
END;

FUNCTION  Mod_Position: WORD; ASSEMBLER;
ASM
  mov     ax,[Soundcard]
  or      ax,ax
  jz      @@Out
  mov     bx,7
  xor     al,al
  call    DWORD PTR [Mod_Driver]
@@Out:
END;

PROCEDURE Mod_Rewind; ASSEMBLER;
ASM
  cmp     [Soundcard],0
  jz      @@Out
  mov     bx,7
  mov     al,-1
  call    DWORD PTR [Mod_Driver]
@@Out:
END;

PROCEDURE Mod_Forward; ASSEMBLER;
ASM
  cmp     [Soundcard],0
  jz      @@Out
  mov     bx,7
  mov     al,1
  call    DWORD PTR [Mod_Driver]
@@Out:
END;

PROCEDURE Mod_Peak; ASSEMBLER;
ASM
  push    es
  mov     ax,ds
  mov     es,ax
  mov     di,OFFSET Peak
  cmp     [Soundcard],0
  jnz     @@Ok
  cld
  mov     cx,4
  xor     ax,ax
  rep     stosw
  jmp     @@Out
@@Ok:
  mov     bx,8
  call    DWORD PTR [Mod_Driver]
@@Out:
  pop     es
END;

END.
