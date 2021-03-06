Program astu_program;

{$M 16384,8192,655360}

uses calc,puzzle,calendar,
     ASTU_UNI,app,validate,objects,
     menus,views,drivers,dialogs;

type
  tMyApp=object(tApplication)
     constructor init;
     procedure initStatusLine;virtual;
     procedure initMenuBar;virtual;
     procedure HandleEvent(var Event:tEvent);virtual;
  end;

var
  astu:tMyApp;

procedure tMyApp.initMenuBar;
var
     R : TRect;
begin
    R.Assign(0,0,80,1);
     MenuBar := New(PMenuBar,Init(R,NewMenu(
      NewSubMenu('��।.',100,NewMenu(
       NewItem('��襭��','',kbNoKey,cmGetDet,100,
       NewItem('��ᬮ���� �����','',kbNoKey,cmViewDet,100,
       NewLine(
       NewItem('���� ࠧ���','',kbNoKey,cmSizeDet,100,
       NewItem('���� ������','',kbNoKey,cmDataDet,100,
       NewLine(
       NewItem('���㫨�� �����','',kbNoKey,cmClrDet,100,
       nil)))))))),
      NewSubMenu('�ࠢ�.',100,NewMenu(
       NewItem('��襭��','',kbNoKey,cmGetUr,100,
       NewItem('��ᬮ���� �����','',kbNoKey,cmViewUr,100,
       NewLine(
       NewItem('���� �᫠ �ࠢ�����','',kbNoKey,cmSizeUr,100,
       NewSubMenu('���� ������',100,NewMenu(
        NewItem('�����樥���','',kbNoKey,cmDataAUr,100,
        NewItem('����. 童��','',kbNoKey,cmDataBUr,100,
        nil))),
       NewLine(
       NewSubMenu('���㫨�� �����',100,NewMenu(
        NewItem('�����樥���','',kbNoKey,cmClrAUr,100,
        NewItem('����. 童��','',kbNoKey,cmClrBUr,100,
        nil))),
       nil)))))))),
      NewSubMenu('�����.',100,NewMenu(
       NewItem('�㬬�','',kbNoKey,cmSum,100,
       NewItem('��������','',kbNoKey,cmRazn,100,
       NewItem('�ந��������','',kbNoKey,cmMult,100,
       NewItem('�⭮襭��','',kbNoKey,cmOtnoh,100,
       nil))))),
      NewSubMenu('������.',100,NewMenu(
       NewItem('��������','F9',kbF9,cmCalc,100,
       NewItem('��⭠誨','',kbNoKey,cmPuzzle,100,
       NewItem('���������','',kbNoKey,cmCalend,100,
       nil)))),
     NewItem('����.','',kbNoKey,cmAbout,100,
     NewItem('��室','',kbAltX,cmQuit,1,
     nil)))))))));
end;

procedure tMyApp.initStatusLine;
var
     R : TRect;
begin
    GetExtent(R);
    R.A.Y:=R.B.Y-1;
     StatusLine := New(PStatusLine,Init(R,
      NewStatusDef(0,$FFFF,
       NewStatusKey('~F9~ ��������',kbF9,cmCalc,
       NewStatusKey('~F10~ ����',kbF10,cmMenu,
       NewStatusKey('~Alt-X~ ��室',kbAltX,cmQuit,
      nil))),nil)));
end;

procedure tMyApp.HandleEvent(var Event:tEvent);

procedure Puzzle;
var
  P: PPuzzleWindow;
begin
  P := New(PPuzzleWindow, Init);
  P^.HelpCtx := hcNoContext;
  InsertWindow(P);
end;

procedure Calculator;
var
  P: PCalculator;
begin
  P := New(PCalculator, Init);
  P^.HelpCtx := hcNoContext;
  InsertWindow(P);
end;

procedure Calendar;
var
  P: PCalendarWindow;
begin
  P := New(PCalendarWindow, Init);
  P^.HelpCtx := hcNoContext;
  InsertWindow(P);
end;

begin
 inherited HandleEvent(Event);
 case Event.What of
  evCommand:
    begin
      case Event.Command of
        cmSizeDet:
          begin
            EnterSizeDet;
            DisableCommands([cmClrDet]);
          end;
        cmDataDet:
          begin
            EnterDataDet;
            EnableCommands([cmClrDet]);
          end;
        cmAbout  :MyAbout;
        cmClrDet :ClearDet;
        cmViewDet:ViewDet;
        cmGetDet :GetDet;
        cmSizeUr :
          begin
            EnterSizeUr;
            DisableCommands([cmClrAUr,cmClrBUr]);
          end;
        cmDataAUr:
          begin
            EnterDataAUr;
            EnableCommands([cmClrAUr]);
          end;
        cmDataBUr:
          begin
            EnterDataBUr;
            EnableCommands([cmClrBUr]);
          end;
        cmClrAUr:if ClearAUr=true then DisableCommands([cmClrAUr]);
        cmClrBUr:if ClearBUr=true then DisableCommands([cmClrBUr]);
        cmViewUr:ViewUr;
        cmGetUr :GetUr;
        cmSum   :jSum;
        cmRazn  :jRazn;
        cmMult  :jMult;
        cmOtnoh :jOtnoh;
        cmPuzzle:puzzle;
        cmCalc  :Calculator;
        cmCalend:Calendar;
      end;
      ClearEvent(Event);
    end;
 end;
end;

constructor tMyApp.init;
begin
 inherited init;
 DisableCommands([cmClrAUr,cmClrBUr,cmClrDet]);
end;

BEGIN
 SizeDet:=2;
 SizeUr:=2;
 astu.init;
 astu.run;
 astu.done;
END.