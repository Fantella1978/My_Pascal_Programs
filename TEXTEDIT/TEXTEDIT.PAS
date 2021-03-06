Program texteditor;
uses
    Dos,Objects,Drivers,Memory,
    Views,Menus,Dialogs,StdDlg,
    MsgBox,App,Editors,asciitab;
const
    HeapSize=4096;
    cmShowClip=1012;
    cmAbout=1013;
    cmAsciiTabl=1014;
type
    pMyEditWindow=^tMyEditWindow;
    tMyEditWindow=object(tEditWindow)
      function GetTitle(MaxSize:integer):TTitleStr;virtual;
    end;
    pMyFileDialog=^tMyFileDialog;
    tMyFileDialog=object(tFileDialog)
      constructor Init(AWildCard:tWildStr;const ATitle,
                       InputName:string;AOptions:Word;HistoryId:byte);
    end;
    pMyChDirDialog=^tMyChDirDialog;
    tMyChDirDialog=object(tChDirDialog)
      constructor Init(AOptions:Word;HistoryId:Word);
      procedure SetUpDialog;
      function Valid(Command:word):boolean;virtual;
    end;
    pMyEditor=^tMyEditor;
    tMyEditor=object(tApplication)
      SetOfWindows:set of Byte;
      constructor Init;
      procedure FileOpen(WildCard:PathStr);
      function OpenEditor(FileName:FNameStr;Clip:boolean;
                          Visible:boolean):pMyEditWindow;
      procedure HandleEvent(var Event:tEvent);virtual;
      procedure Idle;virtual;
      procedure InitMenuBar;virtual;
      procedure InitStatusLine;virtual;
      procedure OutOfMemory;virtual;
    end;
var
    ClipWindow:pMyEditWindow;
{----------------------------------------------------------}
procedure MyAbout;
var
     Control: PView;
     R : TRect;
     Dialog : PDialog;
begin
   R.Assign(22,5,56,18);
   Dialog := New(PDialog,Init(R,'���ଠ��'));
   with Dialog^ do
    begin
       R.Assign(12,10,22,12);
       Control := New(PButton,Init(R,'����',cmOk,bfDefault));
       Insert(Control);
       R.Assign(6,2,31,3);
       Control := New(PStaticText,Init(R,'T E X T   E D I T O R'));
       Insert(Control);
       R.Assign(12,4,22,5);
       Control := New(PStaticText,Init(R,'����� 1.0'));
       Insert(Control);
       R.Assign(2,6,32,7);
       Control := New(PStaticText,Init(R,'������: ����� �����   ��.��-95'));
       Insert(Control);
       R.Assign(8,8,26,9);
       Control := New(PStaticText,Init(R,'���㯮�� MCMXCVII'));
       Insert(Control);
       SelectNext(False);
    end;
   DeskTop^.ExecView(Dialog);
   Dispose(Dialog,Done)
end;

function CreateFindDialog:pDialog;
var
    D:pDialog;
    InputLine:pInputLine;
    R:tRect;
begin
  R.Assign(0,0,40,12);
  D:=new(pDialog,init(R,'����'));
  with D^ do
   begin
    Options:=Options or ofCentered;
    R.Assign(3,3,34,4);
    InputLine:=new(pInputLine,Init(R,80));
    Insert(InputLine);
    R.Assign(2,2,25,3);
    Insert(new(pLabel,Init(R,'����� ��� ���᪠',InputLine)));
    R.Assign(34,3,37,4);
    Insert(new(pHistory,init(R,InputLine,10)));
    R.Assign(3,5,37,7);
    Insert(new(pCheckBoxes,init(R,
      NewSItem('�����稥 �����. � ���. �㪢',
      NewSItem('���쪮 楫�� ᫮��',nil)))));
    R.Assign(9,9,19,11);
    Insert(new(pButton,Init(R,'����',cmOk,bfDefault)));
    Inc(R.A.X,12);Inc(R.B.X,12);
    Insert(new(pButton,Init(R,'�⬥��',cmCancel,bfNormal)));
    SelectNext(False);
   end;
  CreateFindDialog:=D;
end;

function CreateReplaceDialog:pDialog;
var
    D:pDialog;
    InputLine:pInputLine;
    R:tRect;
begin
  R.Assign(0,0,40,16);
  D:=new(pDialog,init(R,'������'));
  with D^ do
   begin
    Options:=Options or ofCentered;
    R.Assign(3,3,34,4);
    InputLine:=new(pInputLine,Init(R,80));
    Insert(InputLine);
    R.Assign(2,2,25,3);
    Insert(new(pLabel,Init(R,'����� ��� ���᪠',InputLine)));
    R.Assign(34,3,37,4);
    Insert(new(pHistory,init(R,InputLine,10)));
    R.Assign(3,6,34,7);
    inputLine:=new(pInputLine,init(r,80));
    insert(InputLine);
    r.assign(2,5,22,6);
    Insert(new(pLabel,init(R,'���� ⥪��',InputLine)));
    R.Assign(34,6,37,7);
    Insert(new(pHistory,init(R,inputLine,11)));
    R.Assign(3,8,37,12);
    Insert(new(pCheckBoxes,init(R,
      NewSItem('�����稥 �����. � ���. �㪢',
      NewSItem('���쪮 楫�� ᫮��',
      NewSItem('���⢥ত���� �� ������',
      NewSItem('�������� �� �宦�����',nil)))))));
    R.Assign(9,13,19,15);
    Insert(new(pButton,Init(R,'����',cmOk,bfDefault)));
    Inc(R.A.X,12);Inc(R.B.X,12);
    Insert(new(pButton,Init(R,'�⬥��',cmCancel,bfNormal)));
    SelectNext(False);
   end;
  CreateReplaceDialog:=D;
end;

function MyMessageBoxRect(var R:tRect;const Msg:string;
                          Params:Pointer;AOptions:word):word;
const
  ButtonName:array[0..3]of string[6]=('��','���','����','�⬥��');
  Commands:array[0..3]of word=(cmYes,cmNo,cmOk,cmCancel);
  Titles:array[0..3]of string[11]=
         ('�।�०�.','�訡��','���ଠ��','���⢥ত.');
var
    I,X:Integer;
    Dialog:pDialog;
    Control:pView;
    S:string;
begin
  Dialog:=new(pDialog,Init(R,Titles[AOptions and $3]));
  with Dialog^ do
   begin
    Options:=Options or ofCentered;
    R.Assign(3,2,Size.X-2,Size.y-3);
    FormatStr(S,Msg,Params^);
    Insert(new(pStaticText,Init(R,S)));
    X:=-2;
    R.Assign(0,0,10,2);
    for i:=0 to 3 do
     if AOptions and ($0100 shl i)<>0 then inc(x,R.B.X-R.A.X+2);
    X:=(Size.x-x)shr 1;
    for i:=0 to 3 do
     if AOptions and ($0100 shl i)<>0 then
      begin
       Control:=New(pButton,init(R,ButtonName[i],Commands[i],bfNormal));
       Insert(Control);
       Control^.MoveTo(x,Size.y-3);
       inc(x,Control^.Size.x+2);
      end;
    SelectNext(False);
  end;
  if AOptions and mfInsertInApp=0 
   then MyMessageBoxRect:=DeskTop^.ExecView(Dialog)
   else MyMessageboxRect:=Application^.ExecView(Dialog);
  Dispose(Dialog,Done);
end;

function MyMessageBox(const Msg:string;Params:Pointer;AOptions:word):word;
var
  R:tRect;
begin
  R.Assign(0,0,40,9);
  MyMessageBox:=MyMessageBoxRect(R,Msg,Params,AOptions);
end;

function MyStdEditorDialog(Dialog:integer;Info:Pointer):word; far;
var
  R:tRect;
  T:tPoint;
begin
  case Dialog of
    edOutOfMemory:
      MyStdEditorDialog:=MyMessageBox(
        '�������筮 ����� ��� �⮩ ����樨.',
        nil,mfError+mfOkButton);
    edReadError:
      MyStdEditorDialog:=MyMessageBox(
        '�訡�� � �⥭�� 䠩�� %s.',
        @Info,mfError+mfOkButton);
    edWriteError:
      MyStdEditorDialog:=MyMessageBox(
        '�訡�� � ����� 䠩�� %s.',
        @Info,mfError+mfOkButton);
    edCreateError:
      MyStdEditorDialog:=MyMessageBox(
        '�訡�� � ᮧ����� 䠩�� %s.',
        @Info,mfError+mfOkButton);
    edSaveModify:
      MyStdEditorDialog:=MyMessageBox(
        '%s �� �������. ���࠭���?',
        @Info,mfInformation+mfYesNoCancel);
    edSaveUntitled:
      MyStdEditorDialog:=MyMessageBox(
        '���࠭��� 䠩� ��� ����� ?',
        nil,mfInformation+mfYesNoCancel);
    edSaveAs:
      MyStdEditorDialog:=Application^.ExecuteDialog(
      new(pMyFileDialog,init('*.*',
      '���࠭��� 䠩� � ������','���',
      fdOkButton,101)),info);
    edFind:
      MyStdEditorDialog:=Application^.ExecuteDialog(
        CreateFindDialog,Info);
    edSearchFailed:
      MyStdEditorDialog:=MyMessageBox(
        '�᪮��� ���ଠ樨 �� �������.',
        nil,mfError+mfOkButton);
    edReplace:
      MyStdEditorDialog:=Application^.ExecuteDialog(
        CreateReplaceDialog,Info);
    edReplacePrompt:
      begin
        R.Assign(0,1,40,8);
        R.Move((Desktop^.Size.X-R.B.X)div 2,0);
        Desktop^.MakeGlobal(R.B,T);
        inc(T.Y);
        if tPoint(Info).Y<=T.Y then
          R.Move(0,Desktop^.Size.Y-R.B.Y-2);
        MyStdEditorDialog:=MyMessageBoxRect(
         R,'�������� �� �宦����� ?',
         nil,mfYesNoCancel+mfInformation);
      end;
  end;    
end;           

function GetCurDir:DirStr;
var
  CurDir:DirStr;
begin
  GetDir(0,CurDir);
  if Length(CurDir)>3 then
   begin
    inc(CurDir[0]);
    CurDir[Length(CurDir)]:='\';
   end;
  GetCurDir:=CurDir;
end;

function MyStdFileMenuItems(Next:pMenuItem):pMenuItem;
begin
 MyStdFileMenuItems:=
   NewItem('����','',kbNoKey,cmNew,hcNew,
   NewItem('������','F3',kbF3,cmOpen,hcOpen,
   NewItem('���࠭���','F2',kbF2,cmSave,hcSave,
   NewItem('���࠭��� � ������...','',kbNoKey,cmSaveAs,hcSaveAs,
   NewItem('���࠭��� ��','',kbNoKey,cmSaveAll,hcSaveAll,
   NewLine(
   NewItem('������� ��⠫��...','',kbNoKey,cmChangeDir,hcChangeDir,
   NewItem('��室 � ���','',kbNoKey,cmDosShell,hcDosShell,
   NewItem('�����襭��','Alt-X',kbAltX,cmQuit,hcExit,
   Next)))))))));
end; 

function MyStdEditMenuItems(Next:pMenuItem):pMenuItem;
begin
 MyStdEditMenuItems:=
   NewItem('�⬥����','',kbAltBack,cmUndo,hcUndo,
   NewLine(
   NewItem('�����஢��� � 㤠�.','Shift+Del',kbShiftDel,cmCut,hcCut,
   NewItem('�����஢���','Ctrl+Ins',kbCtrlIns,cmCopy,hcCopy,
   NewItem('���������','Shift+Ins',kbShiftIns,cmPaste,hcPaste,
   NewItem('�������','Ctrl+Del',kbCtrlDel,cmClear,hcClear,
   Next))))));
end;


function MyStdWindowMenuItems(Next:pMenuItem):pMenuItem;
begin
 MyStdWindowMenuItems:=
   NewItem('�����饭�� ����','',kbNoKey,cmTile,hcTile,
   NewItem('��᪠���� ࠧ��饭��','',kbNoKey,cmCascade,hcCascade,
   NewItem('������� �� ����','',kbNoKey,cmCloseAll,hcCloseAll,
   NewLine(
   NewItem('�������/��६�饭��','Ctrl+F5',kbCtrlF5,cmResize,hcResize,
   NewItem('��ᯠ����','F5',kbF5,cmZoom,hcZoom,
   NewItem('������饥','F6',kbF6,cmNext,hcNext,
   NewItem('�।��饥','Shift+F6',kbShiftF6,cmPrev,hcPrev,
   NewItem('�������','Alt-F3',kbAltF3,cmClose,hcClose,
   NewLine(
   NewItem('ASCII-⠡���','F4',kbF4,cmAsciitabl,hcClose,
   Next)))))))))));
end;

function tMyEditWindow.GetTitle(MaxSize:integer):tTitleStr;
begin
 if Clipboard=pEditor(Editor) then GetTitle:='����'
  else if Editor^.FileName='' then GetTitle:='��� �����'
  else GetTitle:=Editor^.FileName;
end;

constructor tMyFileDialog.init(aWildCard:tWildStr;const ATitle,InputName:string;
                               AOptions:Word;HistoryId:byte);
var
  ScrollBar:pScrollBar;
  R:tRect;
begin
  R.Assign(15,1,64,20);
  tDialog.init(R,ATitle);
  Options:=Options or ofCentered;
  WildCard:=AWildCard;
  R.Assign(3,3,31,4);
  FileName:=New(pFileInputLine,Init(r,79));
  FileName^.Data^:=WildCard;
  insert(FileName);
  r.Assign(2,2,6,3);
  Insert(New(pLabel,init(r,inputname,filename)));
  r.assign(31,3,34,4);
  insert(New(pHistory,init(r,FileName,HistoryId)));
  r.assign(3,14,34,15);
  ScrollBar:=new(pScrollbar,init(r));
  insert(Scrollbar);
  r.assign(3,6,34,14);
  filelist:=new(pfilelist,init(r,scrollbar));
  insert(filelist);
  r.assign(2,5,8,6);
  insert(new(plabel,init(r,'�����',filelist)));
  r.assign(35,3,46,5);
  if AOptions and fdOpenButton<>0 then
   begin
    insert(New(pButton,Init(r,'������',cmFileOpen,bfDefault)));
    inc(r.a.y,3);inc(r.b.y,3);
   end;
  if AOptions and fdOkButton<>0 then
   begin
    insert(New(pButton,init(r,'����',cmFileOpen,bfNormal)));
    inc(r.a.y,3);inc(r.b.y,3);
   end;
  if AOptions and fdReplaceButton<>0 then
   begin
    insert(New(pButton,init(r,'������',cmFileReplace,bfNormal)));
    inc(r.a.y,3);inc(r.b.y,3);
   end;
  if AOptions and fdClearButton<>0 then
   begin
    insert(New(pButton,init(r,'����.',cmFileClear,bfNormal)));
    inc(r.a.y,3);inc(r.b.y,3);
   end;
  insert(new(pButton,init(r,'�⬥��',cmCancel,bfNormal)));
    if AOptions and fdhelpButton<>0 then
   begin
    insert(New(pButton,init(r,'������',cmhelp,bfNormal)));
    inc(r.a.y,3);inc(r.b.y,3);
   end;
  r.assign(1,16,48,18);
  insert(new(pfileinfopane,init(r)));
  selectnext(false);
  if AOptions and fdNoLoadDir = 0 then
   begin
    FileList^.ReadDirectory(WildCard);
    Directory:=NewStr(GetCurDir);
   end;
end;

constructor tMyChDirDialog.init(AOptions:word;HistoryId:word);
var r:tRect;
    ScrollBar:pScrollBar;
    CurDir:DirStr;
begin
  r.assign(16,3,64,19);
  tDialog.init(r,'�������� ��⠫��');
  Options:=Options or ofCentered;
  r.assign(3,3,30,4);
  DirInput:=new(pInputLine,init(r,68));
  insert(DirInput);
  r.assign(2,2,17,3);
  insert(new(pLabel,init(r,'��� ��⠫���',DirInput)));
  r.assign(30,3,33,4);
  insert(new(pHistory,init(r,DirInput,HistoryId)));
  r.assign(32,6,33,13);
  ScrollBar:=new(pScrollBar,init(r));
  insert(ScrollBar);
  r.assign(3,6,32,13);
  DirList:=New(pDirListBox,init(r,ScrollBar));
  insert(DirList);
  r.assign(2,5,19,6);
  insert(New(pLabel,init(r,'��ॢ� ��⠫����',DirList)));
  r.assign(35,6,45,8);
  OkButton:=new(pButton,init(r,'����',cmOk,bfDefault));
  insert(okButton);
  inc(r.a.y,3);inc(r.b.y,3);
  chDirButton:=new(pButton,init(r,'�����',cmChangeDir,bfNormal));
  insert(ChDirButton);
  inc(r.a.y,3);inc(r.b.y,3);
  insert(new(pButton,init(r,'������',cmRevert,bfNormal)));
  {if AOptions and cdHelpButton <> 0 then
    begin
      inc(r.a.y,3);inc(r.b.y,3);
      insert(new(pButton,init(r,'������',cmHelp,bfNormal)));
    end; }
  if AOptions and cdNoLoadDir = 0 then SetUpDialog;
  selectNext(False);
end;

procedure tMyChDirDialog.SetUpDialog;
var CurDir:DirStr;
begin
  if DirList<>nil then
    begin
      CurDir:=GetCurDir;
      DirList^.NewDirectory(CurDir);
      if (Length(CurDir)>3)and(CurDir[Length(CurDir)]='\')then
        CurDir:=copy(curdir,1,length(curdir)-1);
      if dirinput <> nil then
        begin
          dirinput^.data^:=curdir;
          dirinput^.drawview;
        end;
    end;
end;

Function tMyChDirDialog.Valid(Command:word):boolean;
var p:PathStr;
begin
  Valid:=true;
  if command = cmOk then
    begin
      p:=FExpand(dirinput^.data^);
      if (length(p)>3)and(p[length(p)]='\') then dec(p[0]);
      {$I-}
      chdir(p);
      if ioresult<>0 then
        begin
          MyMessageBox('���ࠢ���� ��⠫��.',nil,mfError+mfOkButton);
          valid:=false;
        end;
      {$I+}
    end;
end;

constructor tMyEditor.Init;
var r:trect;
    i:Integer;
    FileName:PathStr;
begin
  MaxHeapSize:=HeapSize;
  inherited init;
  DisableCommands([cmsave,cmSaveAs,cmCut,cmCopy,cmPaste,cmClear,
                   cmUndo,cmFind,cmReplace,cmSearchAgain,cmCloseAll]);
  EditorDialog:=MyStdEditorDialog;
  ClipWindow:=OpenEditor('',true,false);
  if ClipWindow <> nil then
   begin
    Clipboard:=clipWindow^.Editor;
    Clipboard^.CanUndo:=false;
   end;
  for i:=1 to ParamCount do
   begin
    FileName:=ParamStr(i);
    if FileName[length(filename)]='\' then filename:=filename+'*.*';
    if (pos('?',filename)=0)and(pos('*',filename)=0)then
      OpenEditor(fexpand(filename),true,true)
      else fileOpen(filename);
   end;
  setOfWindows:=[];
end;

function tMyEditor.OpenEditor(filename:FnameStr;Clip:boolean;
                              visible:boolean):pMyEditWindow;
var p:pView;
    r:trect;
    Number:byte;
begin
 if DeskTop^.Current = nil then DeskTop^.GetExtent(r)
  else
   begin
    r.a.x:=DeskTop^.Current^.Origin.x;
    r.b.x:=r.a.x+DeskTop^.Current^.Size.x;
    if DeskTop^.Current^.Size.x > 16 then inc(r.a.x);
    r.a.y:=DeskTop^.Current^.Origin.y;
    r.b.y:=r.a.y+DeskTop^.Current^.Size.y;
    if DeskTop^.Current^.Size.y > 6 then inc(r.a.y);
   end;
 if Clip then number:=wnNoNumber
  else for Number:=1 to 254 do
        if not(Number in SetOfWindows) then Break;
 p:=Application^.ValidView(new(pMyEditWindow,init(r,fileName,Number)));
 setOfWindows:=SetOfWindows + [Number];
 if not Visible then p^.Hide
   else EnableCommands([cmCloseAll]);
 DeskTop^.Insert(p);
 OpenEditor:=pMyEditWindow(p);
end;

procedure tMyEditor.FileOpen(WildCard:PathStr);
var filename:fnamestr;
begin
  filename:='*.*';
  if ExecuteDialog(new(pMyFileDialog,init(
                   WildCard,'������ 䠩�','���',
                   fdOpenButton,100)),
                   @filename)<>cmCancel then OpenEditor(filename,false,true);
end;

procedure tMyEditor.HandleEvent(var Event:tEvent);

 procedure ATABl;
 var
   P: Pasciichart;
 begin
   P := New(Pasciichart, Init);
   P^.HelpCtx := hcNoContext;
   InsertWindow(P);
 end;

  procedure ChangeDir;
  var d:pMyChDirDialog;
  begin
    d:=new(pMyChDirDialog,init(cdNormal+cdHelpButton,101));
    executeDialog(d,nil);
  end;
  procedure filenew;
  begin
    Openeditor('',false,true);
  end;
  procedure showClip;
  begin
    ClipWindow^.select;
    ClipWindow^.show;
  end;
  procedure CloseAll;
  begin
    while DeskTop^.Current <> nil do pEditWindow(DeskTop^.Current)^.Close;
    disableCommands([cmCloseAll]);
  end;
begin
if (Event.What = evCommand)and(Event.Command=cmClose)
  then SetOfWindows:=setOfWindows-[pWindow(DeskTop^.Current)^.Number];
inherited HandleEvent(event);
case Event.What of
 evCommand:
  begin
   case Event.Command of
    cmOpen:FileOpen('*.*');
    cmNew :fileNew;
    cmShowClip:ShowClip;
    cmChangeDir:ChangeDir;
    cmCloseAll:CloseAll;
    cmAbout:MyAbout;
    cmAsciiTabl:Atabl;
   else exit;
   end;
   clearEvent(event);
  end;
 end;
end;

procedure tMyEditor.Idle;
 function IsTileable(p:pView):boolean;far;
 begin
   isTileable:=(p^.Options and ofTileable <> 0)
       and(p^.State and sfVisible <> 0);
 end;
begin
 inherited idle;
 if DeskTop^.FirstThat(@isTileable)<> nil
   then enableCommands([cmTile,cmCascade])
  else DisableCommands([cmTile,cmCascade]);
end;

procedure tMyEditor.initMenuBar;
var r:trect;
begin
  getExtent(r);
  r.b.y:=r.a.y+1;
  menubar:=new(pMenuBar,init(r,newMenu(
   newSubMenu('����',hcNoContext,NewMenu(
    myStdFileMenuItems(nil)),
   newSubMenu('�������',hcNoContext,newMenu(
    MyStdEditMenuItems(
    NewLine(
    newItem('����','',kbNoKey,cmShowClip,hcNoContext,nil)))),
   newSubMenu('����',hcNoContext,NewMenu(
    newItem('����...','F7',kbF7,cmFind,
      hcNoContext,NewItem('��������...','Alt-F7',
      kbAltF7,cmReplace,hcNoContext,
    newItem('���� ᫥���騩','Shift-F7',
      kbShiftF7,cmSearchAgain,hcNoContext,
      nil)))),
   newSubMenu('����',hcNoContext,newMenu(MyStdWindowMenuItems(nil)),
   newItem('���','',kbNoKey,cmAbout,hcNoContext,
   newItem('��室','',kbNoKey,cmQuit,hcNoContext,nil)))))))));
end;

procedure tMyEditor.initStatusLine;
var r:trect;
begin
  getExtent(r);
  r.a.y:=r.b.y-1;
  statusline:=new(pStatusLine,init(r,
    newStatusDef(0,$FFFF,
     newStatusKey('~F1~ ���',kbF1,cmAbout,
     newStatusKey('~F2~ ���࠭���',kbF2,cmSave,
     newStatusKey('~F3~ ������',kbF3,cmOpen,
     newStatusKey('~F4~ ASCII',kbF4,cmAsciiTabl,
     newStatusKey('~Alt-F3~ �������',kbAltF3,cmClose,
     newStatusKey('~Alt-X~ ��室',kbAltX,cmQuit,
     newStatusKey('',kbF10,cmMenu,
     newStatusKey('',kbCtrlF5,cmResize,
     nil)))))))),
    nil)));
end;


procedure tMyEditor.OutOfMemory;
begin
  MyMessageBox('��� �����筮� ����� ��� �����襭�� ����樨',nil,
    mfError+mfOkButton);
end;
var Editor:tMyEditor;
begin
 editor.init;
 editor.run;
 editor.done;
end.
