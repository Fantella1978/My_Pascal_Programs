program CrossWord;

uses Dos,App,Drivers,Objects,Menus,Views,Dialogs;

const
  cmAddWord  = 100;
  cmDelWord  = 101;
  cmAbout    = 102;
  cmFindWord = 103;

  hcNoHelp   = 100;

  WordHistoryID = 1;

  strin1:string[30]='Стpока номеp 1 из 30 символов.';
  strin2:string[30]='Стpока номеp 2 из 30 символов.';
  strin3:string[30]='Стpока номеp 3 из 30 символов.';

type
  PWordCol=^WordCol;
  WordCol=record
           Word:string[30];
           Vopros:string[60];
           next:PWordCol;
          end;

  PCrossWordApp = ^TCrossWordApp;
  TCrossWordApp = object(TApplication)
    constructor Init;
    procedure HandleEvent(var Event: TEvent); virtual;
    procedure InitMenuBar; virtual;
    procedure InitStatusLine; virtual;
  end;

var
  CrossWordApp: TCrossWordApp;
  FindStr,StrFound,StrVopros:String[30];
  size:integer;
  FoundCol,FirstCol,ThisCol:PWordCol;
  p1,p2,p3:pointer;


constructor TCrossWordApp.Init;
begin
  inherited Init;
end;

Procedure ShowThisWord(str1,str2:string);
type
  tRec=record
       par:pointer;
      end;
var
  Rec:tRec;
  i:integer;
  string1:string[30];
  R : TRect;
  Dialog : PDialog;
  Control: PView;
  WordText,VoprosText:PParamText;
begin
  R.Assign(11,7,68,14);
  Dialog := New(PDialog,Init(R,'Cлово'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(21,4,34,6);
     Control := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control);
     R.Assign(11,2,44,4);
     WordText := New(PParamText,Init(R,'Слово : %s',1));
     Insert(WordText);
     Rec.Par:=@Str1;
     WordText^.SetData(Rec);
   end;
  DeskTop^.ExecView(Dialog);
  Dispose(Dialog,Done);
end;


Function ShowWord:string;
type
  tRec=record
         List:pCollection;
         Sel:word;
       end;
var
  i:integer;
  string1:string[30];
  Rec:tRec;
  R : TRect;
  Dialog : PDialog;
  Control,Control1: PView;
  Collect:PCollection;
  ListofString:PListBox;
  Scroll:PScrollBar;
begin
  Collect:=New(PCollection,init(3,1));
  Collect^.Insert(p1);
  Collect^.Insert(p2);
  Collect^.Insert(p3);
  Rec.List:=Collect;
  Rec.Sel:=0;
  R.Assign(11,4,68,17);
  Dialog := New(PDialog,Init(R,'Найденные слова'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(44,2,45,7);
     Scroll:=New(PScrollBar,Init(r));
     Insert(Scroll);
     R.Assign(21,10,34,12);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(12,2,44,7);
     ListofString:=New(PListBox,init(R,1,Scroll));
     ListofString^.SetData(Rec);
     ListofString^.Options:=ListofString^.Options or ofFramed;
     insert(ListofString);
   end;
  if DeskTop^.ExecView(Dialog) <> cmCancel
    then
     begin
      ListofString^.GetData(Rec);
      FoundCol:=FirstCol;
      for i:=1 to Rec.Sel do FoundCol:=FoundCol^.Next;
      StrFound:=FoundCol^.Word;
      StrVopros:=FoundCol^.Vopros;
      ShowThisWord(StrFound,StrVopros);
     end;
  Dispose(Dialog,Done);
end;

Function FindWord(PredString:string):string;
var
  Rec:record
   data:string[30];
  end;
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
begin
  Rec.Data:=PredString;
  R.Assign(16,5,63,15);
  Dialog := New(PDialog,Init(R,'Поиск слова по обpазцу'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(10,2,42,3);
     Control := New(PInputLine,Init(R,30));
     Insert(Control);
     R.Assign(42,2,45,3);
     Control1 := New(PHistory,Init(R,pInputLine(control),WordHistoryID));
     Insert(Control1);
     R.Assign(15,4,34,6);
     Control1 := New(PRadioButtons,Init(R,
              NewSItem('Все слова',
              NewSItem('Только пеpвое',nil))));
     Insert(Control1);
     R.Assign(1,2,9,3);
     Insert(New(PLabel,Init(R,'Найти :',Control)));
     R.Assign(10,7,23,9);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(25,7,37,9);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  pInputLine(control)^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
    then
     begin
       pInputLine(control)^.GetData(Rec);
       FindWord:=Rec.Data;
       ShowWord;
     end
    else FindWord:=PredString;
  Dispose(Dialog,Done);
end;



procedure MyAbout;
var
     Control: PView;
     R : TRect;
     Dialog : PDialog;
begin
   R.Assign(23,5,56,18);
   Dialog := New(PDialog,Init(R,'Информация'));
   with Dialog^ do
    begin
       R.Assign(12,10,22,12);
       Control := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
       Insert(Control);
       R.Assign(4,2,30,3);
       Control := New(PStaticText,Init(R,'К  Р  О  С  С  В  О  Р  Д'));
       Insert(Control);
       R.Assign(12,4,24,5);
       Control := New(PStaticText,Init(R,'Версия 1.0'));
       Insert(Control);
       R.Assign(2,6,32,7);
       Control := New(PStaticText,Init(R,'Создал: Попов Вадим  гр.МА-95'));
       Insert(Control);
       R.Assign(8,8,27,9);
       Control := New(PStaticText,Init(R,'Мариуполь MCMXCVIII'));
       Insert(Control);
       SelectNext(False);
    end;
   DeskTop^.ExecView(Dialog);
   Dispose(Dialog,Done)
end;


procedure TCrossWordApp.HandleEvent(var Event: TEvent);
begin
 inherited HandleEvent(Event);
 case Event.What of
  evCommand:
    begin
      case Event.Command of
        cmAbout    :MyAbout;
        cmFindWord :FindStr:=FindWord(FindStr);
      end;
      ClearEvent(Event);
    end;
 end;
end;

procedure TCrossWordApp.InitMenuBar;
var
  R: TRect;
begin
  GetExtent(R);
  R.B.Y := R.A.Y + 1;
  MenuBar := New(PMenuBar, Init(R, NewMenu(
    NewSubMenu('Слова', hcNoHelp, NewMenu(
      NewItem('Найти слово', '', kbNoKey, cmFindWord, hcNoHelp,
      NewItem('Добавить слово в словаpь', '', kbNoKey, cmAddWord, hcNoHelp,
      NewItem('Удалить слово из словаpя', '', kbNoKey, cmDelWord, hcNoHelp,
      nil)))),
    NewItem('Информация','',kbNoKey,cmAbout,hcNoHelp,
    NewItem('Выход','',kbAltX,cmQuit,hcNoHelp,
    nil))))));
end;

procedure TCrossWordApp.InitStatusLine;
var
     R : TRect;
begin
    GetExtent(R);
    R.A.Y:=R.B.Y-1;
     StatusLine := New(PStatusLine,Init(R,
      NewStatusDef(0,$FFFF,
       NewStatusKey('~F10~ Меню',kbF10,cmMenu,
       NewStatusKey('~Alt-X~ Выход',kbAltX,cmQuit,
      nil)),nil)));
end;

begin
  new(FirstCol);
  FirstCol^.Word:=strin1;
  new(FoundCol);
  FirstCol^.Next:=FoundCol;
  FoundCol^.Word:=strin2;
  new(ThisCol);
  FoundCol^.Next:=ThisCol;
  ThisCol^.Word:=strin3;
  ThisCol^.Next:=nil;
  new(p1);new(p2);new(p3);

  p1:=@strin1;
  p2:=@strin2;
  p3:=@strin3;

  CrossWordApp.Init;
  CrossWordApp.Run;
  CrossWordApp.Done;

  Dispose(FirstCol);
  Dispose(FoundCol);
  Dispose(ThisCol);
  Dispose(p1);
  Dispose(p2);
  Dispose(p3);

end.
