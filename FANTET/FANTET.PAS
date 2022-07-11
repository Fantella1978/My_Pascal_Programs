Program FanTetris;

uses WinTypes,WinProcs,bwcc,WinCrt;

{$R fantet.res}

const
 AppName='WinMin';
 idm_About=101;
 idm_Quit =102;
 idm_ChKey=24345;
 idm_ChLev=24341;
 idm_ViewP=24342;
 idm_NewG =24340;
 idm_HiSc =24343;

 BMPName:Array[1..12]of pChar=('Level_1_BMP','Level_2_BMP','Level_3_BMP',
			       'Level_4_BMP','Level_5_BMP','Level_6_BMP',
			       'Level_7_BMP','Level_8_BMP','Level_9_BMP',
			       'Level_10_BMP','Level_11_BMP','Level_12_BMP');

type
    TBitmapRecord=record
      BMPName:pChar;
      x,y:integer;
      width,height:integer;
     end;
    TCurrentFigurePosition=record
      minx,miny,maxx,maxy:byte;
     end;

VAR
 MyLevelBitmap:tBitmapRecord;
 MyDC,MyMemoryDC:hDC;
 BitM:hBitmap;
 xScreen,yScreen,i,n,NumBMP:integer;
 VideoOk,Keyboard1,Access,NextPic,Game,ShowOk,NewFigure:boolean;
 Pen,MyNullPen,MyBlackPen:hPen;
 Brush,MyGrayBrush,MyLtGrayBrush:hBrush;
 CurrentLevel,CurrentFigure,NextFigure,FirstLevel:byte;
 Data:array[0..9,0..22]of byte;
 MyHiScore:longint;
 MyAccel:tHandle;
 PredPos,CurPos:TCurrentFigurePosition;
 MoveDown,Rotate:boolean;

Procedure PutBox(x,y:byte);
begin
 Pen:=SelectObject(MyDc,MyNullPen);
 Brush:=SelectObject(MyDC,MyGrayBrush);
 Rectangle(MyDc,11+x*20,11+y*20,31+x*20,31+y*20);
end;

Procedure DeleteBox(x,y:byte);
begin
 Pen:=SelectObject(MyDc,MyNullPen);
 Brush:=SelectObject(MyDC,MyLtGrayBrush);
 Rectangle(MyDc,11+x*20,11+y*20,31+x*20,31+y*20);
end;

Procedure NotEnoughMemory(hBMP:hBitmap);
begin
 if hBMP=0 then
  begin
   BWCCMessageBox(0,'Not enough memory to continue the program.',
    'FanTetris',mb_Ok or mb_IconInformation);
   Halt(255);
  end;
end;


Function AboutDlgProc(hDlg:hWnd;Message,wParam:word;lParam:longint):longBool;Export;
var
 MyDC,MyMemoryDC:hDC;
 BitM:hBitmap;
begin
 AboutDlgProc:=True;
 Case Message of
  wm_InitDialog:
   begin
    BitM:=LoadBitmap(HInstance,'Aboutbmp');
    NotEnoughMemory(BitM);
    MyDC:=GetDC(hDlg);
    MyMemoryDC:=CreateCompatibleDC(MyDC);
    SelectObject(MyMemoryDC,BitM);
    Showwindow(hDlg,CmdShow);
    BitBlt(MyDC,8,7,232,332,MyMemoryDC,0,0,SrcCopy);
    DeleteDC(MyMemoryDC);
    ReleaseDC(hDlg,MyDC);
    DeleteObject(BitM);
    Exit;
   end;
  wm_ncPaint:
   begin
    BitM:=LoadBitmap(HInstance,'Aboutbmp');
    NotEnoughMemory(BitM);
    MyDC:=GetDC(hDlg);
    MyMemoryDC:=CreateCompatibleDC(MyDC);
    SelectObject(MyMemoryDC,BitM);
    UpdateWindow(hDlg);
    BitBlt(MyDC,8,7,232,332,MyMemoryDC,0,0,SrcCopy);
    DeleteDC(MyMemoryDC);
    ReleaseDC(hDlg,MyDC);
    DeleteObject(BitM);
   end;
  wm_Command:
   case wParam of
    idOk,idCancel:
     begin
      EndDialog(hDlg,0);
      Exit;
     end;
   end;{case}
 end;{case}
 AboutDlgProc:=False;
End;

Function FirstDlgProc(hDlg:hWnd;Message,wParam:word;lParam:longint):longBool;Export;
begin
 FirstDlgProc:=True;
 Case Message of
  wm_InitDialog:Exit;
  wm_Command:
   case wParam of
    idYes:
     begin
      EndDialog(hDlg,0);
      VideoOk:=True;
      Exit;
     end;
    idNo:
     begin
      EndDialog(hDlg,0);
      VideoOk:=False;
      Exit;
     end;
   end;{case}
 end;{case}
 FirstDlgProc:=False;
End;

Procedure ShowMyComponent;
begin
 Pen:=SelectObject(MyDc,MyBlackPen);
 MoveTo(MyDc,218,48);
 LineTo(MyDc,218,110);
 LineTo(MyDc,300,110);
 LineTo(MyDc,300,48);
 LineTo(MyDc,218,48);
 MoveTo(MyDc,9,9);
 LineTo(MyDc,9,411);
 LineTo(MyDc,211,411);
 LineTo(MyDc,211,9);
 LineTo(MyDc,9,9);
 MoveTo(MyDc,309,9);
 LineTo(MyDc,309,410);
 LineTo(MyDc,570,410);
 LineTo(MyDc,570,9);
 LineTo(MyDc,309,9);
 Brush:=SelectObject(MyDc,GetStockObject(White_Brush));
 Rectangle(MyDc,218,169,301,211);
 MoveTo(MyDc,218,189);
 LineTo(MyDc,300,189);
 TextOut(MyDc,242,172,'Level',5);
 Rectangle(MyDc,218,119,301,161);
 MoveTo(MyDc,218,139);
 LineTo(MyDc,300,139);
 TextOut(MyDc,242,122,'Score',5);
 Rectangle(MyDc,218,9,301,49);
 TextOut(MyDc,222,22,'Next Figure',11);
end;

Procedure Delay(x:longint);
var k:longint;
begin
 for k:=x*10000 downto 0 do
  begin
   inc(k);
   dec(k);
  end;
end;

Function ChKeyDlgProc(hDlg:hWnd;Message,wParam:word;lParam:longint):longBool;Export;
var
 keyboard:integer;
begin
 ChKeyDlgProc:=True;
 Case Message of
  wm_InitDialog:
   begin
    if Keyboard1 then
     begin
      SendDlgItemMessage(hDlg,102,bm_SetCheck,1,0);
      SendDlgItemMessage(hDlg,103,bm_SetCheck,0,0);
     end
     else
     begin
      SendDlgItemMessage(hDlg,102,bm_SetCheck,0,0);
      SendDlgItemMessage(hDlg,103,bm_SetCheck,1,0);
     end;
    Exit;
   end;
  wm_Command:
   case wParam of
    idOk:
     begin
    if SendDlgItemMessage(hDlg,102,bm_GetCheck,0,0)=1 then Keyboard1:=true
     else Keyboard1:=false;
      EndDialog(hDlg,0);
      Exit;
     end;
    idCancel:
     begin
      EndDialog(hDlg,0);
      Exit;
     end;
   end;{case}
 end;{case}
 ChKeyDlgProc:=False;
End;

Function ChLevDlgProc(hDlg:hWnd;Message,wParam:word;lParam:longint):longBool;Export;
var k:byte;
begin
 ChLevDlgProc:=True;
 Case Message of
  wm_InitDialog:
   begin
    for k:=102 to 111 do SendDlgItemMessage(hDlg,k,bm_SetCheck,0,0);
    SendDlgItemMessage(hDlg,101+FirstLevel,bm_SetCheck,1,0);
    Exit;
   end;
  wm_Command:
   case wParam of
    idOk:
     begin
      for k:=102 to 111 do
       if SendDlgItemMessage(hDlg,k,bm_GetCheck,0,0)=1 then FirstLevel:=k-101;
      EndDialog(hDlg,0);
      Exit;
     end;
    idCancel:
     begin
      EndDialog(hDlg,0);
      Exit;
     end;
   end;{case}
 end;{case}
 ChLevDlgProc:=False;
End;

Function HiScDlgProc(hDlg:hWnd;Message,wParam:word;lParam:longint):longBool;Export;
begin
 HiScDlgProc:=True;
 Case Message of
  wm_InitDialog:
   begin
    Exit;
   end;
  wm_Command:
   case wParam of
    idOk:
     begin
      EndDialog(hDlg,0);
      Exit;
     end;
    idCancel:
     begin
      EndDialog(hDlg,0);
      Exit;
     end;
   end;{case}
 end;{case}
 HiScDlgProc:=False;
End;

Function ViewPicDlgProc(hDlg:hWnd;Message,wParam:word;lParam:longint):longBool;Export;
var
 MyDC,MyMemoryDC:hDC;
 BitM:hBitmap;
begin
 ViewPicDlgProc:=True;
 Case Message of
  wm_InitDialog:
   begin
    BitM:=LoadBitmap(HInstance,BMPName[NumBMP]);
    NotEnoughMemory(BitM);
    MyDC:=GetDC(hDlg);
    MyMemoryDC:=CreateCompatibleDC(MyDC);
    SelectObject(MyMemoryDC,BitM);
    Showwindow(hDlg,CmdShow);
    BitBlt(MyDC,10,10,260,400,MyMemoryDC,0,0,SrcCopy);
    DeleteDC(MyMemoryDC);
    ReleaseDC(hDlg,MyDC);
    DeleteObject(BitM);
    Exit;
   end;
  wm_ncPaint:
   begin
    BitM:=LoadBitmap(HInstance,BMPName[NumBMP]);
    NotEnoughMemory(BitM);
    MyDC:=GetDC(hDlg);
    MyMemoryDC:=CreateCompatibleDC(MyDC);
    SelectObject(MyMemoryDC,BitM);
    UpdateWindow(hDlg);
    BitBlt(MyDC,10,10,260,400,MyMemoryDC,0,0,SrcCopy);
    DeleteDC(MyMemoryDC);
    ReleaseDC(hDlg,MyDC);
    DeleteObject(BitM);
   end;
  wm_Command:
   case wParam of
    idOk:
     begin
      EndDialog(hDlg,0);
      NextPic:=True;
      Exit;
     end;
    idCancel:
     begin
      EndDialog(hDlg,0);
      NextPic:=False;
      Exit;
     end;
   end;{case}
 end;{case}
 ViewPicDlgProc:=False;
End;

Function PasswDlgProc(hDlg:hWnd;Message,wParam:word;lParam:longint):longBool;Export;
var lpchPassword,lpchAccess:pChar;
begin
 PasswDlgProc:=True;
 Case Message of
  wm_InitDialog:
   begin
    Exit;
   end;
  wm_Command:
   case wParam of
    idOk:
     begin
      lpchPassword:='       ';
      lpchAccess:='BORLAND';
      if SendDlgItemMessage(hDlg,102,em_lineLength,word(-1),0)=7 then
       begin
        SendDlgItemMessage(hDlg,102,em_GetLine,0,longint(lpchPassword));
        if lpchPassword^=lpchAccess^ then
         begin
          Access:=true;
          EndDialog(hDlg,0);
         end
         else
          begin
           Access:=False;
           EndDialog(hDlg,0);
           BWCCMessageBox(0,'Password incorrect. Access denied.','FanTetris',mb_Ok or mb_IconInformation);
          end;
       end
       else
       begin
        Access:=False;
        EndDialog(hDlg,0);
        BWCCMessageBox(0,'Password incorrect. Access denied.','FanTetris',mb_Ok or mb_IconInformation);
       end;
      Exit;
     end;
    idCancel:
     begin
      Access:=False;
      EndDialog(hDlg,0);
      Exit;
     end;
   end;{case}
 end;{case}
 PasswDlgProc:=False;
End;

Procedure ShowNextFigure(Gray:boolean);
var
 ScoreStr:pChar;
 ScStr:string[6];
begin
 Pen:=SelectObject(MyDc,MyNullPen);
 if gray then Brush:=SelectObject(MyDC,MyGrayBrush)
  else Brush:=SelectObject(MyDC,MyLtGrayBrush);
 str(MyHiScore,ScStr);
 ScoreStr:=@ScStr;
 TextOut(MyDc,232,142,'               ',15);
 TextOut(MyDc,250-length(ScStr)*4,142,ScoreStr+1,length(ScStr));
 str(CurrentLevel,ScStr);
 ScoreStr:=@ScStr;
 TextOut(MyDc,232,193,'               ',15);
 TextOut(MyDc,250-length(ScStr)*4,193,ScoreStr+1,length(ScStr));
 case NextFigure of
  1:
   begin
    Rectangle(MyDc,220,70,240,90);
    Rectangle(MyDc,240,70,260,90);
    Rectangle(MyDc,260,70,280,90);
    Rectangle(MyDc,280,70,300,90);
   end;
  2:
   begin
    Rectangle(MyDc,240,50,260,70);
    Rectangle(MyDc,240,70,260,90);
    Rectangle(MyDc,240,90,260,110);
    Rectangle(MyDc,260,90,280,110);
   end;
  3:
   begin
    Rectangle(MyDc,260,50,280,70);
    Rectangle(MyDc,260,70,280,90);
    Rectangle(MyDc,260,90,280,110);
    Rectangle(MyDc,240,90,260,110);
   end;
  4:
   begin
    Rectangle(MyDc,240,50,260,70);
    Rectangle(MyDc,240,70,260,90);
    Rectangle(MyDc,260,70,280,90);
    Rectangle(MyDc,260,90,280,110);
   end;
  5:
   begin
    Rectangle(MyDc,260,50,280,70);
    Rectangle(MyDc,260,70,280,90);
    Rectangle(MyDc,240,70,260,90);
    Rectangle(MyDc,240,90,260,110);
   end;
  6:
   begin
    Rectangle(MyDc,260,50,280,70);
    Rectangle(MyDc,260,70,280,90);
    Rectangle(MyDc,240,70,260,90);
    Rectangle(MyDc,260,90,280,110);
   end;
  7:
   begin
    Rectangle(MyDc,260,60,280,80);
    Rectangle(MyDc,260,80,280,100);
    Rectangle(MyDc,240,60,260,80);
    Rectangle(MyDc,240,80,260,100);
   end;
 end;{case}
end;

Procedure ShowDataField(First,Last:byte);
begin
 For i:=0 to 9 do
  For n:=First to Last do
   if ((Data[i,n]=1)or(data[i,n]=2))and(n>2) then PutBox(i,n-3);
 ShowNextFigure(true);
 ShowOk:=false;
end;

Procedure DeleteDataField(First,Last:byte);
begin
 For i:=0 to 9 do
  For n:=First to Last do
   if (Data[i,n]=0)and(n>2) then DeleteBox(i,n-3);
 ShowNextFigure(true);
 ShowOk:=false;
end;

Procedure NewLevel;
begin
 Pen:=SelectObject(MyDc,MyBlackPen);
 Brush:=SelectObject(MyDC,MyltGrayBrush);
 Rectangle(MyDc,309,9,571,411);
 DeleteObject(BitM);
 MyLevelBitmap.BMPName:=BMPName[CurrentLevel];
 with MyLevelBitmap do
  begin
   x:=310; y:=10;
   width:=260; height:=0;
  end;
 BitM:=LoadBitmap(HInstance,MyLevelBitmap.BMPName);
 NotEnoughMemory(BitM);
 SelectObject(MyMemoryDC,BitM);
 BitBlt(MyDC,MyLevelBitmap.x,MyLevelBitmap.y,
   MyLevelBitmap.width,MyLevelBitmap.height,MyMemoryDC,0,0,SrcCopy);
 ShowDataField(3,22);
end;

Procedure isGameOver;
begin
 if CurPos.minY<3 then
  begin
   BWCCMessageBox(0,'                                               '+
                    '                                               '+
                    '                                               '+
                    '         GAME   OVER','FanTetris',mb_ok);
   Game:=false;
   for i:=0 to 9 do
    for n:=0 to 22 do data[i,n]:=0;
   DeleteDataField(3,22);
   ShowNextFigure(false);
   DeleteObject(BitM);
   with MyLevelBitmap do
    begin
     BMPName:='MainBMP';
     x:=324; y:=56;
     width:=232; height:=304;
    end;
   BitM:=LoadBitmap(HInstance,MyLevelBitmap.BMPName);
   NotEnoughMemory(BitM);
   Pen:=SelectObject(MyDc,MyBlackPen);
   Brush:=SelectObject(MyDC,MyltGrayBrush);
   TextOut(MyDc,232,142,'               ',15);
   TextOut(MyDc,232,193,'               ',15);
   SelectObject(MyMemoryDC,BitM);
   Rectangle(MyDc,309,9,571,411);
   BitBlt(MyDC,MyLevelBitmap.x,MyLevelBitmap.y,
     MyLevelBitmap.width,MyLevelBitmap.height,MyMemoryDC,0,0,SrcCopy);
  end;
end;

Procedure YouAreWinner;
begin
 BWCCMessageBox(0,'                                               '+
                  '                                               '+
                  '                                               '+
                  '       You are WINNER !                        '+
                  '         password : BORLAND','FanTetris',mb_ok);
 Game:=false;
 for i:=0 to 9 do
  for n:=0 to 22 do data[i,n]:=0;
 DeleteDataField(3,22);
 ShowNextFigure(false);
 DeleteObject(BitM);
 with MyLevelBitmap do
  begin
   BMPName:='MainBMP';
   x:=324; y:=56;
   width:=232; height:=304;
  end;
 BitM:=LoadBitmap(HInstance,MyLevelBitmap.BMPName);
 NotEnoughMemory(BitM);
 Pen:=SelectObject(MyDc,MyBlackPen);
 Brush:=SelectObject(MyDC,MyltGrayBrush);
 TextOut(MyDc,232,142,'               ',15);
 TextOut(MyDc,232,193,'               ',15);
 SelectObject(MyMemoryDC,BitM);
 Rectangle(MyDc,309,9,571,411);
 BitBlt(MyDC,MyLevelBitmap.x,MyLevelBitmap.y,
 MyLevelBitmap.width,MyLevelBitmap.height,MyMemoryDC,0,0,SrcCopy);
end;

Procedure LinesFire;
var
 lines:array[1..4]of byte;
 fire:boolean;
 a,b:byte;
begin
 a:=0;
 for n:=CurPos.maxY downto CurPos.minY do
  begin
   Fire:=true;
   for i:=0 to 9 do if data[i,n]<>1 then Fire:=false;
   if Fire=true then
    begin
     inc(a);
     lines[a]:=n;
    end;
  end;
 if a>0 then
  begin
   for b:=1 to a do
    begin
     For i:=0 to 9 do data[i,lines[b]]:=0;
     DeleteDataField(lines[b],lines[b]);
     Delay(15);
     For i:=0 to 9 do data[i,lines[b]]:=1;
     ShowDataField(lines[b],lines[b]);
     Delay(15);
     For i:=0 to 9 do data[i,lines[b]]:=0;
     DeleteDataField(lines[b],lines[b]);
     Delay(15);
     For i:=0 to 9 do data[i,lines[b]]:=1;
     ShowDataField(lines[b],lines[b]);
     Delay(15);
     For i:=0 to 9 do data[i,lines[b]]:=0;
     DeleteDataField(lines[b],lines[b]);
     Delay(15);
     For i:=0 to 9 do data[i,lines[b]]:=1;
     ShowDataField(lines[b],lines[b]);
     Delay(15);
     For i:=0 to 9 do data[i,lines[b]]:=0;
     DeleteDataField(lines[b],lines[b]);
     for i:=0 to 9 do
      for n:=lines[b]-1 downto 2 do
       begin
        data[i,n+1]:=data[i,n];
        data[i,n]:=0;
       end;
     DeleteDataField(3,CurPos.maxY);
     ShowDataField(3,CurPos.maxY);
     if b<4 then lines[b+1]:=lines[b+1]+b;
    end;
    MyHiScore:=MyHiScore+10*a+(a-1)*5;
    MyLevelBitmap.height:=MyLevelBitmap.height+15*a+(a-1)*10;
    if MyLevelBitmap.height>=400 then
     begin
      MyLevelBitmap.height:=400;
      BitBlt(MyDC,MyLevelBitmap.x,MyLevelBitmap.y,
       MyLevelBitmap.width,MyLevelBitmap.height,MyMemoryDC,0,0,SrcCopy);
      Delay(200);
      inc(CurrentLevel);
      if CurrentLevel=13 then
       begin
        YouAreWinner;
        exit;
       end;
      NewLevel;
     end;
    BitBlt(MyDC,MyLevelBitmap.x,MyLevelBitmap.y,
     MyLevelBitmap.width,MyLevelBitmap.height,MyMemoryDC,0,0,SrcCopy);
  end;
 Delay(10);
end;

Procedure MoveFigureLeftProc;
begin
  MoveDown:=true;
  if CurPos.minX=0 then MoveDown:=false
   else
    for i:=CurPos.minX to CurPos.maxX do
     for n:=CurPos.maxY downto CurPos.minY do
      if (data[i,n]=2)and(data[i-1,n]=1)then MoveDown:=false;
  if MoveDown=true then
   begin
    for i:=CurPos.minX to CurPos.maxX do
     for n:=CurPos.maxY downto CurPos.minY do
      if data[i,n]=2 then
       begin
        data[i-1,n]:=2;
        data[i,n]:=0;
       end;
    PredPos:=CurPos;
    dec(CurPos.minX);dec(CurPos.maxX);
    DeleteDataField(PredPos.minY,PredPos.MaxY);
    ShowDataField(CurPos.minY,CurPos.maxY);
    Delay(15);
   end;
end;

Procedure MoveFigureRightProc;
begin
  MoveDown:=true;
  if CurPos.maxX=9 then MoveDown:=false
   else
    for i:=CurPos.minX to CurPos.maxX do
     for n:=CurPos.maxY downto CurPos.minY do
      if (data[i,n]=2)and(data[i+1,n]=1)then MoveDown:=false;
  if MoveDown=true then
   begin
    for i:=CurPos.maxX downto CurPos.minX do
     for n:=CurPos.maxY downto CurPos.minY do
      if data[i,n]=2 then
       begin
        data[i+1,n]:=2;
        data[i,n]:=0;
       end;
    PredPos:=CurPos;
    inc(CurPos.minX);inc(CurPos.maxX);
    DeleteDataField(PredPos.minY,PredPos.MaxY);
    ShowDataField(CurPos.minY,CurPos.maxY);
    Delay(15);
   end;
end;

Procedure MoveFigureDownProc;
begin
 if CurPos.maxY=22 then MoveDown:=false
  else
   for i:=CurPos.minX to CurPos.maxX do
    for n:=CurPos.maxY downto CurPos.minY do
     if (data[i,n]=2)and(data[i,n+1]=1)then MoveDown:=false;
 if MoveDown=true then
  begin
   for i:=CurPos.minX to CurPos.maxX do
    for n:=CurPos.maxY downto CurPos.minY do
     if data[i,n]=2 then
      begin
       data[i,n+1]:=2;
       data[i,n]:=0;
      end;
   PredPos:=CurPos;
   inc(CurPos.minY);inc(CurPos.maxY);
   DeleteDataField(PredPos.minY,PredPos.MaxY);
   ShowDataField(CurPos.minY,CurPos.maxY);
  end
  else
  begin
   for i:=CurPos.minX to CurPos.maxX do
    for n:=CurPos.maxY downto CurPos.minY do
     if data[i,n]=2 then data[i,n]:=1;
   ShowDataField(CurPos.minY,CurPos.maxY);
   MyHiScore:=MyHiScore+4;
   isGameOver;
   LinesFire;
   NewFigure:=true;
  end;
end;

Procedure Rotate23456;
var mas1:array[1..4,1..4]of byte;
begin
 for i:=1 to 4 do
  for n:=1 to 3 do mas1[i,n]:=0;
 Rotate:=true;
 if (CurPos.maxX-CurPos.minX=1)and(CurPos.MaxX<>9)and(CurPos.MinX>0)then
  begin
   for i:=1 to 4 do
    for n:=1 to 3 do
     if Data[CurPos.minX-2+i,CurPos.MinY-1+n]=2
      then mas1[n+1,5-i]:=2
      else mas1[n+1,5-i]:=0;
   for i:=1 to 4 do
    for n:=1 to 4 do
     if (mas1[i,n]=2)and(data[CurPos.minX-2+i,CurPos.MinY-1+n]=1) then Rotate:=false;
   if Rotate=true then
    begin
     for i:=1 to 4 do
      for n:=1 to 4 do
       begin
        if Data[CurPos.minX-2+i,CurPos.MinY-1+n]=2
         then Data[CurPos.minX-2+i,CurPos.MinY-1+n]:=0;
        if (mas1[i,n]=2)then Data[CurPos.minX-2+i,CurPos.MinY-1+n]:=2;
       end;
     PredPos:=CurPos;
     CurPos.minX:=PredPos.minX;
     CurPos.maxX:=PredPos.maxX+1;
     CurPos.minY:=PredPos.minY+1;
     CurPos.maxY:=PredPos.maxY;
     DeleteDataField(PredPos.minY,PredPos.maxY);
     ShowDataField(CurPos.minY,CurPos.maxY);
     Delay(15);
    end;
  end
 else
 if (CurPos.maxX-CurPos.minX=2)and(CurPos.MaxY<>22)then
  begin
   for i:=1 to 4 do
    for n:=1 to 4 do
     if Data[CurPos.minX-2+i,CurPos.MinY-2+n]=2
      then mas1[n,5-i]:=2
      else mas1[n,5-i]:=0;
   for i:=1 to 4 do
    for n:=1 to 4 do
     if (mas1[i,n]=2)and(data[CurPos.minX-2+i,CurPos.MinY-2+n]=1) then Rotate:=false;
   if Rotate=true then
    begin
     for i:=1 to 4 do
      for n:=1 to 4 do
       begin
        if Data[CurPos.minX-2+i,CurPos.MinY-2+n]=2
         then Data[CurPos.minX-2+i,CurPos.MinY-2+n]:=0;
        if (mas1[i,n]=2)then Data[CurPos.minX-2+i,CurPos.MinY-2+n]:=2;
       end;
     PredPos:=CurPos;
     CurPos.minX:=PredPos.minX;
     CurPos.maxX:=PredPos.maxX-1;
     CurPos.minY:=PredPos.minY-1;
     CurPos.maxY:=PredPos.maxY;
     DeleteDataField(PredPos.minY,PredPos.maxY);
     ShowDataField(CurPos.minY,CurPos.maxY);
     Delay(15);
    end;
  end;
end;

Procedure RotateFigureProc;
begin
 case CurrentFigure of
  1:begin
     if CurPos.minY=CurPos.MaxY then
      begin
       Rotate:=true;
       if CurPos.maxY=22 then Rotate:=false;
       for i:=CurPos.maxY+1 downto CurPos.maxY-2 do if data[CurPos.minX+1,i]=1 then Rotate:=false;
       if Rotate then
        begin
         PredPos:=CurPos;
         for i:=CurPos.minX to CurPos.maxX do data[i,CurPos.minY]:=0;
         for i:=CurPos.maxY+1 downto CurPos.maxY-2 do data[CurPos.minX+1,i]:=2;
         CurPos.minX:=PredPos.minX+1;
         CurPos.maxX:=PredPos.minX+1;
         CurPos.minY:=PredPos.maxY-2;
         CurPos.maxY:=PredPos.maxY+1;
        end;
      end
      else
      begin
       Rotate:=true;
       if (CurPos.maxX>7)or(CurPos.minX<1)then Rotate:=false;
       for i:=CurPos.maxX-1 to CurPos.maxX+2 do if data[i,CurPos.minY+2]=1 then Rotate:=false;
       if Rotate then
        begin
         PredPos:=CurPos;
         for i:=CurPos.minY to CurPos.maxY do data[CurPos.maxX,i]:=0;
         for i:=CurPos.maxX-1 to CurPos.maxX+2 do data[i,CurPos.minY+2]:=2;
         CurPos.minX:=PredPos.minX-1;
         CurPos.maxX:=PredPos.maxX+2;
         CurPos.minY:=PredPos.minY+2;
         CurPos.maxY:=PredPos.maxY-1;
        end;
      end;
     DeleteDataField(PredPos.minY,PredPos.maxY);
     ShowDataField(CurPos.minY,CurPos.maxY);
     Delay(15);
    end;
  2,3,4,5,6:Rotate23456;
 end;{case}
end;

Procedure DropFigureProc;
begin
 MoveDown:=true;
 repeat
  MoveFigureDownProc;
  Delay(1);
 until MoveDown=false;
end;

Function WindowProc(Window:HWnd;Message,WParam:Word;LParam:Longint):Longint;export;
var
 lpfnFirstDlgProc,lpfnAboutDlgProc,
 lpfnChKeyDlgProc,lpfnChLevDlgProc,
 lpfnPasswDlgProc,lpfnViewPicDlgProc,
 lpfnHiScDlgProc:TFarProc;
begin
 WindowProc:=0;
 Case Message of
  wm_create:
   begin
    lpfnFirstDlgProc:=MakeProcInstance(@FirstDlgProc,hInstance);
    DialogBox(hInstance,'FirstDlg',window,lpfnFirstDlgProc);
    FreeProcInstance(@FirstDlgProc);
   end;
  wm_Destroy:
   begin
    PostQuitMessage(0);
    Exit;
   end;
  wm_ncPaint,wm_Move:
   begin
    UpdateWindow(Window);
    ShowMyComponent;
    if game then ShowDataField(3,22);
    BitBlt(MyDC,MyLevelBitmap.x,MyLevelBitmap.y,
     MyLevelBitmap.width,MyLevelBitmap.height,MyMemoryDC,0,0,SrcCopy);
    ShowOk:=true;
   end;
  wm_KeyDown:
   if game then
    if keyboard1
     then
      case wParam of
       vk_Right:MoveFigureRightProc;
       vk_Left:MoveFigureLeftProc;
       vk_Down:DropFigureProc;
       vk_Up:RotateFigureProc;
      end{case}
     else
      case wParam of
       $44:MoveFigureRightProc;
       $41:MoveFigureLeftProc;
       $53:DropFigureProc;
       vk_Tab:RotateFigureProc;
      end;{case}
  wm_Command:
   Case wParam of
    idm_NewG:
     begin
      For i:=0 to 9 do
       For n:=0 to 22 do Data[i,n]:=0;
      Randomize;
      DeleteDataField(3,22);
      CurrentLevel:=FirstLevel;
      ShowNextFigure(false);
      NextFigure:=1+round(random*6);
      NewLevel;
      CurrentFigure:=NextFigure;
      ShowNextFigure(false);
      NextFigure:=1+round(random*6);
      ShowNextFigure(true);
      MyHiScore:=0;
      Game:=true;
      NewFigure:=true;
     end;
    idm_HiSc:
     begin
      lpfnHiScDlgProc:=MakeProcInstance(@HiScDlgProc,hInstance);
      DialogBox(hInstance,'HiScoresDlg',window,lpfnHiScDlgProc);
      FreeProcInstance(@HiScDlgProc);
      Exit;
     end;
    idm_About:
     begin
      lpfnAboutDlgProc:=MakeProcInstance(@AboutDlgProc,hInstance);
      DialogBox(hInstance,'AboutDlg',window,lpfnAboutDlgProc);
      FreeProcInstance(@AboutDlgProc);
      Exit;
     end;
    idm_ChLev:
     begin
      lpfnPasswDlgProc:=MakeProcInstance(@PasswDlgProc,hInstance);
      DialogBox(hInstance,'PasswordDlg',window,lpfnPasswDlgProc);
      FreeProcInstance(@PasswDlgProc);
      if Access then
       begin
        lpfnChLevDlgProc:=MakeProcInstance(@ChLevDlgProc,hInstance);
        DialogBox(hInstance,'ChangeLevelDlg',window,lpfnChLevDlgProc);
        FreeProcInstance(@ChLevDlgProc);
       end;
      Exit;
     end;
    idm_ViewP:
     begin
      lpfnPasswDlgProc:=MakeProcInstance(@PasswDlgProc,hInstance);
      DialogBox(hInstance,'PasswordDlg',window,lpfnPasswDlgProc);
      FreeProcInstance(@PasswDlgProc);
      if Access then
       begin
        lpfnViewPicDlgProc:=MakeProcInstance(@ViewPicDlgProc,hInstance);
        for NumBMP:=1 to 12 do
         begin
	  DialogBox(hInstance,'ViewPicDlg',window,lpfnViewPicDlgProc);
	  if not NextPic then break;
         end;
        FreeProcInstance(@ViewPicDlgProc);
       end;
      Exit;
     end;
    idm_ChKey:
     begin
      lpfnChKeyDlgProc:=MakeProcInstance(@ChKeyDlgProc,hInstance);
      DialogBox(hInstance,'ChKeyDlg',window,lpfnChKeyDlgProc);
      FreeProcInstance(@ChKeyDlgProc);
      Exit;
     end;
    idm_Quit:
     begin
      PostQuitMessage(0);
      Exit;
     end;
   end;{case}
 end;{case}
 WindowProc:=DefWindowProc(Window,Message,WParam,LParam);
end;

Procedure NewFigureProc;
begin
 CurrentFigure:=NextFigure;
 ShowNextFigure(false);
 NextFigure:=1+round(random*6);
 ShowNextFigure(true);
 case CurrentFigure of
 1:begin
    data[3,2]:=2;data[4,2]:=2;data[5,2]:=2;data[6,2]:=2;
    CurPos.minX:=3;CurPos.minY:=2;CurPos.maxX:=6;CurPos.maxY:=2;
   end;
 2:begin
    data[4,0]:=2;data[4,1]:=2;data[4,2]:=2;data[5,2]:=2;
    CurPos.minX:=4;CurPos.minY:=0;CurPos.maxX:=5;CurPos.maxY:=2;
   end;
 3:begin
    data[5,0]:=2;data[5,1]:=2;data[5,2]:=2;data[4,2]:=2;
    CurPos.minX:=4;CurPos.minY:=0;CurPos.maxX:=5;CurPos.maxY:=2;
   end;
 4:begin
    data[4,0]:=2;data[4,1]:=2;data[5,1]:=2;data[5,2]:=2;
    CurPos.minX:=4;CurPos.minY:=0;CurPos.maxX:=5;CurPos.maxY:=2;
   end;
 5:begin
    data[5,0]:=2;data[5,1]:=2;data[4,1]:=2;data[4,2]:=2;
    CurPos.minX:=4;CurPos.minY:=0;CurPos.maxX:=5;CurPos.maxY:=2;
   end;
 6:begin
    data[5,0]:=2;data[5,1]:=2;data[4,1]:=2;data[5,2]:=2;
    CurPos.minX:=4;CurPos.minY:=0;CurPos.maxX:=5;CurPos.maxY:=2;
   end;
 7:begin
    data[4,1]:=2;data[4,2]:=2;data[5,1]:=2;data[5,2]:=2;
    CurPos.minX:=4;CurPos.minY:=1;CurPos.maxX:=5;CurPos.maxY:=2;
   end;
 end;
 NewFigure:=false;
end;

Procedure MoveDownFigureProc;
begin
 MoveDown:=true;
 MoveFigureDownProc;
 Delay(100-CurrentLevel*6);
end;

Procedure WinMain;
var
 Message:TMsg;
 WindowClass:TWndClass;
 Window:HWnd;
 a:integer;
begin
 Keyboard1:=true;
 If HPrevInst=0 then
  begin
   WindowClass.Style:=0;
   WindowClass.lpfnWndProc:=@WindowProc;
   WindowClass.cbClsExtra:=0;
   WindowClass.cbWndExtra:=0;
   WindowClass.hInstance:=HInstance;
   WindowClass.hIcon:=LoadIcon(hInstance,'ICON1');
   WindowClass.hCursor:=LoadCursor(hInstance,idc_Arrow);
   WindowClass.hbrBackground:=HBrush(ltGray_Brush);
   WindowClass.lpszMenuName:='MainMenu';
   WindowClass.lpszClassName:=AppName;
   if not RegisterClass(WindowClass) then Halt(255);
  end
  else
  begin
   BWCCMessageBox(0,'This programm is already execute.','FanTetris',mb_Ok or mb_IconInformation);
   Halt(1);
  end;
 xScreen:=GetSystemMetrics(sm_cxScreen);
 yScreen:=GetSystemMetrics(sm_cyScreen);
 Window:=CreateWindow(AppName,'FanTetris',
  ws_Popup or ws_Caption or ws_SysMenu or ws_MinimizeBox,
  xScreen div 2-291,yScreen div 2-230,582,460,0,0,HInstance,nil);
 with MyLevelBitmap do
  begin
   BMPName:='MainBMP';
   x:=324; y:=56;
   width:=232; height:=304;
  end;
 if VideoOk then
  begin
   MyAccel:=LoadAccelerators(hInstance,'MyAccelerator');
   BitM:=LoadBitmap(HInstance,MyLevelBitmap.BMPName);
   NotEnoughMemory(BitM);
   MyDC:=GetDC(Window);
   MyMemoryDC:=CreateCompatibleDC(MyDC);
   SelectObject(MyMemoryDC,BitM);
   ShowWindow(Window,CmdShow);
   MyNullPen:=GetStockObject(Null_Pen);
   MyBlackPen:=GetStockObject(Black_Pen);
   MyLtGrayBrush:=GetStockObject(ltGray_Brush);
   MyGrayBrush:=GetStockObject(Gray_Brush);
   ShowMyComponent;
   BitBlt(MyDC,MyLevelBitmap.x,MyLevelBitmap.y,
     MyLevelBitmap.width,MyLevelBitmap.height,MyMemoryDC,0,0,SrcCopy);
   repeat
    if Game and (not isIconic(window))then
     begin
      for a:=0 to 16 do
       begin
        PeekMessage(Message,0,0,0,pm_Remove);
        if TranslateAccelerator(Window,MyAccel,Message)=0
         then
          begin
           TranslateMessage(Message);
           DispatchMessage(Message);
          end;
        if Message.Message=wm_Quit then break;
       end;
      if ShowOk then ShowDataField(3,22);
      if NewFigure then NewFigureProc
       else MoveDownFigureProc;
     end
     else
     begin
      GetMessage(Message,0,0,0);
      if TranslateAccelerator(Window,MyAccel,Message)=0
       then
        begin
         TranslateMessage(Message);
         DispatchMessage(Message);
        end;
     end;
   until Message.message=wm_Quit;
   DeleteDC(MyMemoryDC);
   ReleaseDC(Window,MyDC);
   DeleteObject(BitM);
   DeleteObject(Pen);
   DeleteObject(Brush);
   Halt(Message.wParam);
  end;
end;

BEGIN
 Game:=false;
 FirstLevel:=1;
 WinMain;
END.

