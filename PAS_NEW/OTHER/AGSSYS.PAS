{$I-,V-,L+,X+,G+}

{**********************************}
{*                                *}
{*    Action Game Story System    *}
{*  Copyright (C) 1992 Stars Ltd  *}
{*                                *}
{**********************************}

unit
  AGSSys;

interface

const
  DeluxePaintPalette : Array[1..768] of Byte = (
        $00,$00,$00,$00,$00,$2A,$00,$2A,$00,$00,$2A,$2A,$2A,$00,
        $00,$2A,$00,$2A,$2A,$15,$00,$2A,$2A,$2A,$15,$15,$15,$15,
        $15,$3F,$15,$3F,$15,$15,$3F,$3F,$3F,$15,$15,$3F,$15,$3F,
        $3F,$3F,$15,$3F,$3F,$3F,$3B,$3B,$3B,$37,$37,$37,$34,$34,
        $34,$30,$30,$30,$2D,$2D,$2D,$2A,$2A,$2A,$26,$26,$26,$23,
        $23,$23,$1F,$1F,$1F,$1C,$1C,$1C,$19,$19,$19,$15,$15,$15,
        $12,$12,$12,$0E,$0E,$0E,$0B,$0B,$0B,$08,$08,$08,$3F,$00,
        $00,$3B,$00,$00,$38,$00,$00,$35,$00,$00,$32,$00,$00,$2F,
        $00,$00,$2C,$00,$00,$29,$00,$00,$26,$00,$00,$22,$00,$00,
        $1F,$00,$00,$1C,$00,$00,$19,$00,$00,$16,$00,$00,$13,$00,
        $00,$10,$00,$00,$3F,$36,$36,$3F,$2E,$2E,$3F,$27,$27,$3F,
        $1F,$1F,$3F,$17,$17,$3F,$10,$10,$3F,$08,$08,$3F,$00,$00,
        $3F,$2A,$17,$3F,$26,$10,$3F,$22,$08,$3F,$1E,$00,$39,$1B,
        $00,$33,$18,$00,$2D,$15,$00,$27,$13,$00,$3F,$3F,$36,$3F,
        $3F,$2E,$3F,$3F,$27,$3F,$3F,$1F,$3F,$3E,$17,$3F,$3D,$10,
        $3F,$3D,$08,$3F,$3D,$00,$39,$36,$00,$33,$31,$00,$2D,$2B,
        $00,$27,$27,$00,$21,$21,$00,$1C,$1B,$00,$16,$15,$00,$10,
        $10,$00,$34,$3F,$17,$31,$3F,$10,$2D,$3F,$08,$28,$3F,$00,
        $24,$39,$00,$20,$33,$00,$1D,$2D,$00,$18,$27,$00,$36,$3F,
        $36,$2F,$3F,$2E,$27,$3F,$27,$20,$3F,$1F,$18,$3F,$17,$10,
        $3F,$10,$08,$3F,$08,$00,$3F,$00,$00,$3F,$00,$00,$3B,$00,
        $00,$38,$00,$00,$35,$00,$01,$32,$00,$01,$2F,$00,$01,$2C,
        $00,$01,$29,$00,$01,$26,$00,$01,$22,$00,$01,$1F,$00,$01,
        $1C,$00,$01,$19,$00,$01,$16,$00,$01,$13,$00,$01,$10,$00,
        $36,$3F,$3F,$2E,$3F,$3F,$27,$3F,$3F,$1F,$3F,$3E,$17,$3F,
        $3F,$10,$3F,$3F,$08,$3F,$3F,$00,$3F,$3F,$00,$39,$39,$00,
        $33,$33,$00,$2D,$2D,$00,$27,$27,$00,$21,$21,$00,$1C,$1C,
        $00,$16,$16,$00,$10,$10,$17,$2F,$3F,$10,$2C,$3F,$08,$2A,
        $3F,$00,$27,$3F,$00,$23,$39,$00,$1F,$33,$00,$1B,$2D,$00,
        $17,$27,$36,$36,$3F,$2E,$2F,$3F,$27,$27,$3F,$1F,$20,$3F,
        $17,$18,$3F,$10,$10,$3F,$08,$09,$3F,$00,$01,$3F,$00,$00,
        $3F,$00,$00,$3B,$00,$00,$38,$00,$00,$35,$00,$00,$32,$00,
        $00,$2F,$00,$00,$2C,$00,$00,$29,$00,$00,$26,$00,$00,$22,
        $00,$00,$1F,$00,$00,$1C,$00,$00,$19,$00,$00,$16,$00,$00,
        $13,$00,$00,$10,$3C,$36,$3F,$39,$2E,$3F,$36,$27,$3F,$34,
        $1F,$3F,$32,$17,$3F,$2F,$10,$3F,$2D,$08,$3F,$2A,$00,$3F,
        $26,$00,$39,$20,$00,$33,$1D,$00,$2D,$18,$00,$27,$14,$00,
        $21,$11,$00,$1C,$0D,$00,$16,$0A,$00,$10,$3F,$36,$3F,$3F,
        $2E,$3F,$3F,$27,$3F,$3F,$1F,$3F,$3F,$17,$3F,$3F,$10,$3F,
        $3F,$08,$3F,$3F,$00,$3F,$38,$00,$39,$32,$00,$33,$2D,$00,
        $2D,$27,$00,$27,$21,$00,$21,$1B,$00,$1C,$16,$00,$16,$10,
        $00,$10,$3F,$3A,$37,$3F,$38,$34,$3F,$36,$31,$3F,$35,$2F,
        $3F,$33,$2C,$3F,$31,$29,$3F,$2F,$27,$3F,$2E,$24,$3F,$2C,
        $20,$3F,$29,$1C,$3F,$27,$18,$3C,$25,$17,$3A,$23,$16,$37,
        $22,$15,$34,$20,$14,$32,$1F,$13,$2F,$1E,$12,$2D,$1C,$11,
        $2A,$1A,$10,$28,$19,$0F,$27,$18,$0E,$24,$17,$0D,$22,$16,
        $0C,$20,$14,$0B,$1D,$13,$0A,$1B,$12,$09,$17,$10,$08,$15,
        $0F,$07,$12,$0E,$06,$10,$0C,$06,$0E,$0B,$05,$0A,$08,$03,
        $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
        $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$31,$0A,$0A,$31,
        $13,$0A,$31,$1D,$0A,$31,$27,$0A,$31,$31,$0A,$27,$31,$0A,
        $1D,$31,$0A,$13,$31,$0A,$0A,$31,$0C,$0A,$31,$17,$0A,$31,
        $22,$0A,$31,$2D,$0A,$2A,$31,$0A,$1F,$31,$0A,$14,$31,$0B,
        $0A,$31,$16,$0A,$31,$21,$0A,$31,$2C,$0A,$31,$31,$0A,$2B,
        $31,$0A,$20,$31,$0A,$15,$31,$0A,$0A,$3F,$3F,$3F);

type
  RGBColor   = record
                 Red,
                 Green,
                 Blue   : Byte
               end;
  VGAPalette = Array [0..255] of RGBColor;

const
  TextWhite   : RGBColor = (Red:$FF;Green:$FF;Blue:$FF);
  TextMagenta : RGBColor = (Red:$FF;Green:$00;Blue:$FF);
  TextGreen   : RGBColor = (Red:$00;Green:$B0;Blue:$00);
  TextYellow  : RGBColor = (Red:$FF;Green:$FF;Blue:$00);

var
  VirtScr : Pointer;              { Указатель на виртуальный экран }

procedure WaitScreenRetrace;
procedure SetVGA256Mode;
procedure SetTextMode;
procedure OpenVirtualScreen;
procedure CloseVirtualScreen;
procedure ShowVirtualScreen;
procedure VPutPixel(X,Y:Word;Color:Byte);
procedure VPutBlock(X,Y,SizeX,SizeY:Word;VAR Sprite);
procedure VFlashBlock(X,Y,SizeX,SizeY:Word;VAR Sprite);
procedure VGetBlock(X,Y,SizeX,SizeY:Word;VAR Sprite);
procedure LoadVBackground(FileName:String;FilePosition:LongInt);
procedure SetAllPalette(VAR Pal);
procedure GetAllPalette(VAR Pal:VGAPalette);
procedure AllPaletteOn(Pal:VGAPalette;OnDelay:Word);
procedure AllPaletteOff(OffDelay:Word);
procedure RotateCurPalette(StCol,EndCol:Byte);
procedure RotatePalette(VAR Pal:VGAPalette;StCol,EndCol:Byte);
procedure SetDPPalette;
procedure LoadAllPalette(VAR Pal:VGAPalette;FileName:String;FilePosition:LongInt);
procedure GetRGBColor(NColor:Byte;VAR RGBCol:RGBColor);
procedure SetRGBColor(NColor:Byte;VAR RGBCol);
procedure SetTextColor(Col:RGBColor);
procedure UpFlowBlock(X,Y,SX,SY:Word;Block:Pointer);
procedure DownFlowBlock(X,Y,SX,SY:Word;Block:Pointer);

implementation

var
  OldPort21 : Byte;
  OneMS     : Word;

procedure DelayMS; assembler;
  asm
  @delayms:
    mov      bx,04h
  @dmsdec:
    dec      bx
    jnz      @dmsdec
    cmp      al,es:[di]
    loope    @delayms
  end;

procedure Delay(MS:Word); assembler;
  asm
    mov      dx,MS
    or       dx,dx
    jz       @delayexit
    xor      di,di
    mov      es,di
    mov      al,es:[di]
  @delayloop:
    mov      cx,OneMS
    call     DelayMS
    dec      dx
    jnz      @delayloop
  @delayexit:
  end;

procedure WaitScreenRetrace; assembler;
  asm
    push     dx                   { Сохраняем регистры, которые }
    push     ax                   { можем изменить }
    mov      dx,03DAh             { Порт статуса видеотерминала }
    cli                           { Запрещаем прерываться }
  @waitnoh:
    in       al,dx                { Проверяем на условие: }
    test     al,08h               { Луч находится на конце экрана }
    jnz      @go
    shr      al,1                 { Он уже почти там }
    jc       @waitnoh
  @waith:                         { Проверка обратного хода луча }
    in       al,dx
    shr      al,1
    jnc      @waith               { В случае обратного хода }
  @go:
    pop      ax                   { Восстанавливаем измененные }
    pop      dx                   { регистры }
  end;

procedure SetVGA256Mode; assembler;
  asm
    mov   ax,0013h                { Установка режима 013h }
    int   10h                     { VGA 256x320x200 }
  end;

procedure SetTextMode; assembler;
  asm
    mov   ax,0003h                { Установка текстового цветного }
    int   10h                     { режима 80х25 }
  end;

procedure OpenVirtualScreen;
  begin
    repeat
      GetMem(VirtScr,64000);      { Выделяем 64K для виртуального экрана }
      FillChar(VirtScr^,64000,0); { Чистим возможный мусор }
      if Ofs(VirtScr^)<>0 then    { Необходимо попасть на начало }
        FreeMem(VirtScr,64000);   { выделенного сегмента }
    until Ofs(VirtScr^)=0;
  end;

procedure CloseVirtualScreen;
  begin
    FreeMem(VirtScr,64000);       { Возвращаем выделенные 64K памяти }
  end;

procedure ShowVirtualScreen; assembler;
  asm
    cli                           { Запрещаем прерывания }
    push     ds                   { Сохраняем изменяемые }
    push     es                   { сегментные регистры }
    lds      si,VirtScr           { Загружаем в источник }
    mov      ax,0A000h            { адрес виртуального экрана, и }
    mov      es,ax                { в приемник - адрес физического }
    xor      di,di                { экрана (видеопамяти) }
    mov      cx,32000             { Всего 32000 слов - 64000 байтов }
    rep      movsw                { Вывод в видеопамять }
    pop      es                   { Восстанавливаем оригинальные }
    pop      ds                   { сегментные регистры }
    sti                           { Разрешаем прерывания }
  end;

procedure VPutPixel(X,Y:Word;Color:Byte); assembler;
  asm
    push     es
    les      di,VirtScr
    mov      di,Y
    mov      di,320
    mul      di
    mov      di,ax
    add      di,X
    mov      al,Color
    stosb
    pop      es
  end;

procedure VPutBlock(X,Y,SizeX,SizeY:Word;VAR Sprite); assembler;
  asm
    push     ds
    push     es
    les      ax,VirtScr
    mov      bx,Y
    mov      ax,320
    mul      bx
    mov      bx,ax
    add      bx,X
    mov      di,bx 
    mov      dx,bx
    mov      bx,SizeX
    mov	     cx,SizeY
    lds      si,Sprite
  @01:
    push     cx
    mov      cx,bx
    rep      movsb
    add      dx,0140h
    mov      di,dx
    pop	     cx
    loop     @01
    pop      es
    pop      ds
  end;

procedure VFlashBlock(X,Y,SizeX,SizeY:Word;VAR Sprite); assembler;
  asm
    push     bp
    push     ds
    push     es
    lds      ax,VirtScr
    mov      bx,Y
    mov      ax,320
    mul      bx
    mov      bx,ax
    add      bx,X
    mov      dx,bx
    mov      di,SizeX
    mov      si,SizeY
    les      bp,Sprite
    mov      cx,si
  @01:
    push     cx
    mov      cx,di
  @02:
    mov      al,es:[bp]
    inc	     bp
    cmp	     al,00h
    je	     @03
    mov      ds:[bx],al
  @03:
    inc      bx
    loop     @02
    add      dx,0140h
    mov      bx,dx
    pop	     cx
    loop     @01
    pop      es
    pop      ds
    pop      bp
  end;

procedure VGetBlock(X,Y,SizeX,SizeY:Word;VAR Sprite); assembler;
  asm
    push     ds
    mov      bx,Y
    mov      ax,320
    mul      bx
    mov      bx,ax
    add      bx,X
    lds      si,VirtScr
    mov      si,bx
    les      di,Sprite
    mov      cx,SizeY
    cld
  @01:
    push     cx
    mov      cx,SizeX
    mov      ax,si
    rep      movsb
    mov      si,ax
    add      si,0140h
    pop      cx
    loop     @01
    pop      ds
  end;

procedure LoadVBackground(FileName:String;FilePosition:LongInt);
  var
    F : File;
  begin
    Assign(F,FileName);
    Reset(F,1);
    Seek(F,FilePosition);
    BlockRead(F,VirtScr^,64000);
    Close(F);
  end;

procedure SetAllPalette(VAR Pal); assembler;
  asm
    push     ds
    mov      dx,3DAh
  @retr1:
    in       al,dx        
    and      al,8
    jnz      @retr1       
  @retr2:
    in       al,dx        
    and      al,8
    jz       @retr2
    lds      si,Pal
    mov      cx,300h
    mov      dx,3C8h
    xor      al,al
    out      dx,al
    in       al,dx
    mov      dx,3C9h
    rep      outsb
    pop      ds
  end;

procedure GetAllPalette(VAR Pal:VGAPalette); assembler;
  asm
    push     es
    mov      dx,3DAh
  @retr1:
    in       al,dx        
    and      al,8
    jnz      @retr1       
  @retr2:
    in       al,dx        
    and      al,8
    jz       @retr2
    les      di,Pal
    mov      cx,300h
    mov      dx,3C7h
    xor      al,al
    out      dx,al
    in       al,dx
    mov      dx,3C9h
    rep      insb
    pop      es
  end;

procedure GetRGBColor(NColor:Byte;VAR RGBCol:RGBColor); assembler;
  asm
    push     es
    mov      dx,3DAh
  @retr1:
    in       al,dx        
    and      al,8
    jnz      @retr1       
  @retr2:
    in       al,dx        
    and      al,8
    jz       @retr2
    les      di,RGBCol
    mov      cx,3
    mov      dx,3C7h
    mov      al,NColor
    out      dx,al
    in       al,dx
    mov      dx,3C9h
    rep      insb
    pop      es
  end;

procedure SetRGBColor(NColor:Byte;VAR RGBCol); assembler;
  asm
    push     ds
    mov      dx,3DAh
  @retr1:
    in       al,dx        
    and      al,8
    jnz      @retr1       
  @retr2:
    in       al,dx        
    and      al,8
    jz       @retr2
    lds      si,RGBCol
    mov      cx,3
    mov      dx,3C8h
    mov      al,NColor
    out      dx,al
    in       al,dx
    mov      dx,3C9h
    rep      outsb
    pop      ds
  end;

procedure AllPaletteOn(Pal:VGAPalette;OnDelay:Word);
  var
    MVal, I, J : Byte;
    New, Old   : VGAPalette;
    S, O : Word;
  begin
    FillChar(New,768,0);
    Move(Pal,Old,768);
    MVal:=0;
    S:=Seg(Pal);
    O:=Ofs(Pal);
    asm
      push     es
      mov      cx,0300h
      mov      ax,S
      mov      es,ax
      mov      di,O
      mov      bx,cx
      mov      al,es:[di+bx]
      dec      cx
    @cikl:
      mov      bx,cx
      cmp      al,es:[di+bx]
      jnl      @next
      mov      al,es:[di+bx]
    @next:
      loop     @cikl
      pop      es
      mov      MVal,al
    end;
    for I:=MVal downto 0 do
      begin
        for J:=0 to 255 do
          begin
            if Old[J].Red>=I then
              New[J].Red:=Old[J].Red-I;
            if Old[J].Green>=I then
              New[J].Green:=Old[J].Green-I;
            if Old[J].Blue>=I then
              New[J].Blue:=Old[J].Blue-I;
          end;
        SetAllPalette(New);
        Delay(OnDelay);
      end;
    SetAllPalette(Pal);
  end;

procedure AllPaletteOff(OffDelay:Word);
  var
    I, J         : Byte;
    Pal, ZeroPal : VGAPalette;
  begin
    GetAllPalette(Pal);
    FillChar(ZeroPal,768,$00);
    for I:=0 to 33 do
      begin
        for J:=0 to 255 do
          begin
            if Pal[J].Red>1 then
              Dec(Pal[J].Red,2);
            if Pal[J].Green>1 then
              Dec(Pal[J].Green,2);
            if Pal[J].Blue>1 then
              Dec(Pal[J].Blue,2);
          end;
        Delay(OffDelay);
        SetAllPalette(Pal);
      end;
    SetAllPalette(ZeroPal);
  end;

procedure RotateCurPalette(StCol,EndCol:Byte);
  var
    Tmp  : RGBColor;
    Pal0 : VGAPalette;
    K    : Byte;
  begin
    GetAllPalette(Pal0);
    Tmp:=Pal0[StCol];
    for K:=StCol to EndCol-1 do
      Pal0[K]:=Pal0[K+1];
    Pal0[EndCol]:=Tmp;
    SetAllPalette(Pal0);
  end;

procedure RotatePalette(VAR Pal:VGAPalette;StCol,EndCol:Byte);
  var
    K   : Byte;
    Tmp : RGBColor;
  begin
    Tmp:=Pal[StCol];
    for K:=StCol to EndCol-1 do
      Pal[K]:=Pal[K+1];
    Pal[EndCol]:=Tmp;
  end;

procedure SetDPPalette;
  begin
    SetAllPalette(DeluxePaintPalette);
  end;

procedure LoadAllPalette(VAR Pal:VGAPalette;FileName:String;FilePosition:LongInt);
  var
    F : File;
  begin
    Assign(F,FileName);
    Reset(F,1);
    Seek(F,FilePosition);
    BlockRead(F,Pal,768);
    Close(F);
  end;

procedure SetTextColor(Col:RGBColor);
  const
    C0 : LongInt = $00;
  begin
    SetRGBColor($FF,Col);
    SetRGBColor($FE,C0)
  end;

procedure UpFlowBlock(X,Y,SX,SY:Word;Block:Pointer);
  var
    I, J : Byte;
    P    : Pointer;
  begin
    for I:=SY downto 0 do
      begin
        for J:=I downto 1 do
          begin
            P:=Ptr(Seg(Block^),Ofs(Block^)+I*SX);
            VPutBlock(X,Y+J,SX,1,P^);
          end;
        ShowVirtualScreen;
      end;
  end;

procedure DownFlowBlock(X,Y,SX,SY:Word;Block:Pointer);
  var
    I, J : Byte;
    P    : Pointer;
  begin
    for I:=0 to SY do
      begin
        for J:=I to SY-1 do
          begin
            P:=Ptr(Seg(Block^),Ofs(Block^)+I*SX);
            VPutBlock(X,Y+J,SX,1,P^);
          end;
        ShowVirtualScreen;
      end;
  end;

begin
  Port[$43]:=$36;
  Port[$40]:=$00;
  Port[$40]:=$00;
  OldPort21:=Port[$21];
  Port[$21]:=OldPort21 AND $FE;
  asm
    push     es
    mov      ax,40h
    mov      es,ax
    mov      di,006Ch
    mov      al,es:[di]
    sti
  @notchanged:
    cmp      al,es:[di]
    jz       @notchanged
    mov      al,es:[di]
    mov      cx,0FFFFh
    call     DelayMS
    mov      ax,55
    xchg     cx,ax
    not      ax
    xor      dx,dx
    div      cx
    mov      OneMS,ax
    pop      es
  end;
  Port[$21]:=OldPort21;
end.