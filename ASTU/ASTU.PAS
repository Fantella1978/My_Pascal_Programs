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
      NewSubMenu('Опред.',100,NewMenu(
       NewItem('Решение','',kbNoKey,cmGetDet,100,
       NewItem('Просмотреть данные','',kbNoKey,cmViewDet,100,
       NewLine(
       NewItem('Ввод размера','',kbNoKey,cmSizeDet,100,
       NewItem('Ввод данных','',kbNoKey,cmDataDet,100,
       NewLine(
       NewItem('Обнулить данные','',kbNoKey,cmClrDet,100,
       nil)))))))),
      NewSubMenu('Уравн.',100,NewMenu(
       NewItem('Решение','',kbNoKey,cmGetUr,100,
       NewItem('Просмотреть данные','',kbNoKey,cmViewUr,100,
       NewLine(
       NewItem('Ввод числа уравнений','',kbNoKey,cmSizeUr,100,
       NewSubMenu('Ввод данных',100,NewMenu(
        NewItem('Коэффициенты','',kbNoKey,cmDataAUr,100,
        NewItem('Своб. члены','',kbNoKey,cmDataBUr,100,
        nil))),
       NewLine(
       NewSubMenu('Обнулить данные',100,NewMenu(
        NewItem('Коэффициенты','',kbNoKey,cmClrAUr,100,
        NewItem('Своб. члены','',kbNoKey,cmClrBUr,100,
        nil))),
       nil)))))))),
      NewSubMenu('Компл.',100,NewMenu(
       NewItem('Сумма','',kbNoKey,cmSum,100,
       NewItem('Разность','',kbNoKey,cmRazn,100,
       NewItem('Произведение','',kbNoKey,cmMult,100,
       NewItem('Отношение','',kbNoKey,cmOtnoh,100,
       nil))))),
      NewSubMenu('Дополн.',100,NewMenu(
       NewItem('Калькулятор','F9',kbF9,cmCalc,100,
       NewItem('Пятнашки','',kbNoKey,cmPuzzle,100,
       NewItem('Календарь','',kbNoKey,cmCalend,100,
       nil)))),
     NewItem('Информ.','',kbNoKey,cmAbout,100,
     NewItem('Выход','',kbAltX,cmQuit,1,
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
       NewStatusKey('~F9~ Калькулятор',kbF9,cmCalc,
       NewStatusKey('~F10~ Меню',kbF10,cmMenu,
       NewStatusKey('~Alt-X~ Выход',kbAltX,cmQuit,
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