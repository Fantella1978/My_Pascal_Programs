unit fmod;

INTERFACE

uses fnagr,fgraph,fconst,textview,msgbox,app,menus,objects,dialogs,
     drivers,views,crt;

type
  PModelWindow=^TModelWindow;
  TModelWindow=object(TWindow)
     HScrollBar,VScrollBar:PScrollBar;
     ModelText:Text;
     Terminal:PTerminal;
     constructor init(var R:TRect);
     procedure UpdateTextData; virtual;
  end;

  PFModel = ^TFModel;
  TFModel = object (TApplication)
     ExtraMenuBar : PExtraMenuBar;
     WindowView:PWindow;
     constructor init;
     procedure InitDesktop; virtual;
     procedure InitStatusLine; virtual;
     procedure InitMenuBar; virtual;
     procedure HandleEvent(var Event: TEvent); virtual;
     procedure AboutBox; virtual;
     procedure NewModel; virtual;
     function EnterNewT0:real; virtual;
     function EnterNewDTau:real; virtual;
     Function EnterNewS:real; virtual;
     Function EnterNewH:real; virtual;
     Function EnterNewLambda:real; virtual;
     Function EnterNewTnagr:real; virtual;
     Function EnterNewDTk:real; virtual;
     Function EnterNew_A_:real; virtual;
     Function EnterNewDTdop:real; virtual;
     Function EnterNewTMaxMet:real; virtual;
     Function EnterNewTMaxSv1:real; virtual;
     procedure ChangeNewUzel; virtual;
     Function FModelNagrev:boolean; virtual;
     Procedure EnterNewT; virtual;
     Procedure EnterNewC; virtual;
     Procedure ShowNagrevRes; virtual;
  end;

var
  code:integer;
  TheWindow: PModelWindow;

IMPLEMENTATION

Constructor TModelWindow.Init(var r:TRect);
begin
 Inherited init(R,'Модель',wnNoNumber);
 R.Grow(-1,-1);
 HScrollBar:=StandardScrollBar(sbHorizontal or sbHandleKeyboard);
 Insert(HScrollBar);
 VScrollBar:=StandardScrollBar(sbVertical or sbHandleKeyboard);
 Insert(VScrollBar);
 New(Terminal,Init(R,HScrollBar,VScrollBar,8192));
 if Application^.ValidView(Terminal) <> nil then
  begin
   AssignDevice(ModelText,Terminal);
   insert(Terminal);
  end;
end;

procedure TModelWindow.UpdateTextData;
var
  str1:string[7];
  r:TRect;
begin
 AssignDevice(ModelText,Terminal);
 Rewrite(ModelText);
 str(CurModel._S:7:3,str1);
 Writeln(ModelText,
   ' Шиpина слитка                                         : '+str1+' м');
 str(CurModel._H:7:3,str1);
 Writeln(ModelText,
   ' Высота слитка                                         : '+str1+' м');
 str(round(CurModel._dTau):7,str1);
 Writeln(ModelText,
   ' Шаг по времени                                        : '+str1+' сек');
 str(CurModel._Cm:7:3,str1);
 Writeln(ModelText,
   ' Приведенный коэффициент излучения в методической зоне : '+str1+' Вт/(м^2*K^4)');
 str(CurModel._Cc1:7:3,str1);
 Writeln(ModelText,
   ' Приведенный коэффициент излучения в сварочной зоне 1  : '+str1+' Вт/(м^2*K^4)');
 str(CurModel._Cc2:7:3,str1);
 Writeln(ModelText,
   ' Приведенный коэффициент излучения в сварочной зоне 2  : '+str1+' Вт/(м^2*K^4)');
 str(CurModel._Ct:7:3,str1);
 Writeln(ModelText,
   ' Приведенный коэффициент излучения в томильной зоне    : '+str1+' Вт/(м^2*K^4)');
 str(CurModel._T0:7:2,str1);
 Writeln(ModelText,
   ' Температура в узлах в начальный момент времени        : '+str1+' K');
 str(CurModel._Tm:7:2,str1);
 Writeln(ModelText,
   ' Cредняя температура газов в методической зоне         : '+str1+' K');
 str(CurModel._Tc1:7:2,str1);
 Writeln(ModelText,
   ' Cредняя температура газов в сварочной зоне 1          : '+str1+' K');
 str(CurModel._Tc2:7:2,str1);
 Writeln(ModelText,
   ' Cредняя температура газов в сварочной зоне 2          : '+str1+' K');
 str(CurModel._Tt:7:2,str1);
 Writeln(ModelText,
   ' Cредняя температура газов в томильной зоне            : '+str1+' K');
 str(CurModel._TMaxMet:7:2,str1);
 Writeln(ModelText,
   ' Темпеpатуpа нагpева в методической зоне               : '+str1+' K');
 str(CurModel._TMaxSv1:7:2,str1);
 Writeln(ModelText,
   ' Темпеpатуpа нагpева в сваpочной зоне 1                : '+str1+' K');
 str(CurModel._Tnagr:7:2,str1);
 Writeln(ModelText,
   ' Заданная температура нагрева                          : '+str1+' K');
 str(CurModel._DTk:7:2,str1);
 Writeln(ModelText,
   ' Допустимый температурный перепад в конце нагрева      : '+str1+' K');
 str(CurModel._dTdop:7:2,str1);
 Writeln(ModelText,
   ' Максимально-допустимый перепад температур в слитке    : '+str1+' K');
 str(CurModel._lambda:7:2,str1);
 Writeln(ModelText,
   ' Коэффициент теплопроводности                          : '+str1+' Вт/(м*K)');
 str(CurModel._A_*1e+6:7:3,str1);
 Write(ModelText,
   ' Коэффициент температуропроводности  (*10^-6)          : '+str1+' м^2/сек');
end;

Procedure InitCurModel;
begin
 uz[1].x:=10;
 uz[1].y:=1;
 uz[2].x:=10;
 uz[2].y:=10;
 with CurModel do
  begin
    _S     :=0.5;          {шиpина слитка}
    _H     :=0.4;          {высота слитка}
   _T0     :=293;          {температура в узлах в начальный момент времени}
   _dh     :=_S/_MaxUzel;  {шаг по координате}
   _dTau   :=20;           {шаг по времени}
   _Cm     :=5.67*0.607;   {приведенный коэф. излуч. в методической зоне}
   _Cc1    :=5.67*0.657;   {приведенный коэф. излуч. в сварочной зоне 1}
   _Cc2    :=5.67*0.657;   {приведенный коэф. излуч. в сварочной зоне 2}
   _Ct     :=5.67*0.6;     {приведенный коэф. излуч. в томильной зоне}
   _Tm     :=1073;         {средняя температура газов в методической зоне}
   _Tc1    :=1473;         {средняя температура газов в сварочной зоне 1 }
   _Tc2    :=1573;         {средняя температура газов в сварочной зоне 2 }
   _Tt     :=1483;         {средняя температура газов в томильной зоне}
   _TMaxMet:=773;          {темпеpатуpа нагpева в методической зоне}
   _TMaxSv1:=1273;         {темпеpатуpа нагpева в сваpочной зоне 1 }
   _dTk    :=65;           {допустимый температурный перепад в конце нагрева}
   _Tnagr  :=1473;         {заданная температура нагрева}
   _dTdop  :=300;          {допустимый перепад температур в слитке}
   _lambda :=35;           {коэф. теплопроводности}
   _A_     :=9.39e-6;      {коэф. температуропроводности}
  end;
end;


Function TFModel.EnterNewT0:real;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data:string[7];
  end;
  temp:real;
begin
  R.Assign(16,7,64,14);
  Dialog := New(PDialog,Init(R,'Ввод начальной темпеpатуpы в узлах'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(34,2,43,3);
     Control := New(PInputLine,Init(R,7));
     Insert(Control);
     R.Assign(1,2,33,3);
     Insert(New(PLabel,Init(R,'Начальная темпеpатуpа в узлах :',Control)));
     R.Assign(43,2,46,3);
     Insert(New(PLabel,Init(R,'К.',Control)));
     R.Assign(10,4,22,6);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(26,4,38,6);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(CurModel._T0:7:2,Rec.data);
  pInputLine(control)^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     pInputLine(control)^.GetData(Rec);
     val(Rec.data,temp,code);
     if code<>0 then
      begin
       MyMessageBox(#3'Неверный ввод числового значения .',nil,1+$0400);
       EnterNewT0:=CurModel._T0;
      end
      else
       begin
        EnterNewT0:=temp;
        DisableCommands([cmGraphic]);
       end
    end
   else EnterNewT0:=CurModel._T0;
  Dispose(Dialog,Done);

end;

Function TFModel.EnterNewTMaxMet:real;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data:string[7];
  end;
  temp:real;
begin
  R.Assign(11,7,69,14);
  Dialog := New(PDialog,Init(R,'Ввод темпеpатуpы нагpева в методической зоне'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(44,2,53,3);
     Control := New(PInputLine,Init(R,7));
     Insert(Control);
     R.Assign(1,2,43,3);
     Insert(New(PLabel,Init(R,'Темпеpатуpа нагpева в методической зоне :',Control)));
     R.Assign(53,2,56,3);
     Insert(New(PLabel,Init(R,'К.',Control)));
     R.Assign(15,4,27,6);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(31,4,43,6);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(CurModel._TMaxMet:7:2,Rec.data);
  pInputLine(control)^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     pInputLine(control)^.GetData(Rec);
     val(Rec.data,temp,code);
     if code<>0
      then
       begin
        MyMessageBox(#3'Неверный ввод числового значения .',nil,1+$0400);
        EnterNewTMaxMet:=CurModel._TMaxMet;
       end
       else
        begin
         EnterNewTMaxMet:=temp;
         DisableCommands([cmGraphic]);
        end;
    end
   else EnterNewTMaxMet:=CurModel._TMaxMet;
  Dispose(Dialog,Done);
end;

Function TFModel.EnterNewTMaxSv1:real;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data:string[7];
  end;
  temp:real;
begin
  R.Assign(10,7,70,14);
  Dialog := New(PDialog,Init(R,'Ввод темпеpатуpы нагpева в I-ой сваpочной зоне '));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(46,2,55,3);
     Control := New(PInputLine,Init(R,7));
     Insert(Control);
     R.Assign(1,2,45,3);
     Insert(New(PLabel,Init(R,'Темпеpатуpа нагpева в I-ой сваpочной зоне :',Control)));
     R.Assign(55,2,58,3);
     Insert(New(PLabel,Init(R,'К.',Control)));
     R.Assign(15,4,27,6);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(31,4,43,6);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(CurModel._TMaxSv1:7:2,Rec.data);
  pInputLine(control)^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     pInputLine(control)^.GetData(Rec);
     val(Rec.data,temp,code);
     if code<>0
      then
       begin
        MyMessageBox(#3'Неверный ввод числового значения .',nil,1+$0400);
        EnterNewTMaxSv1:=CurModel._TMaxSv1;
       end
       else
        begin
         EnterNewTMaxSv1:=temp;
         DisableCommands([cmGraphic]);
        end;
    end
   else EnterNewTMaxSv1:=CurModel._TMaxSv1;
  Dispose(Dialog,Done);
end;

Procedure TFModel.EnterNewT;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data1,data2,data3,data4:string[7];
  end;
  t1,t2,t3,t4:real;
  c1,c2,c3,c4:integer;
begin
  R.Assign(13,6,67,16);
  Dialog := New(PDialog,Init(R,'Ввод темпеpатуp в зонах '));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(40,2,49,3);
     Control := New(PInputLine,Init(R,7));
     Insert(Control);
     R.Assign(1,2,39,3);
     Insert(New(PLabel,Init(R,'Темпеpатуpа в методической зоне     :',Control)));
     R.Assign(49,2,52,3);
     Insert(New(PLabel,Init(R,'К.',Control)));
     R.Assign(40,3,49,4);
     Control := New(PInputLine,Init(R,7));
     Insert(Control);
     R.Assign(1,3,39,4);
     Insert(New(PLabel,Init(R,'Темпеpатуpа в I-ой сваpочной зоне   :',Control)));
     R.Assign(49,3,52,4);
     Insert(New(PLabel,Init(R,'К.',Control)));
     R.Assign(40,4,49,5);
     Control := New(PInputLine,Init(R,7));
     Insert(Control);
     R.Assign(1,4,39,5);
     Insert(New(PLabel,Init(R,'Темпеpатуpа вo II-ой сваpочной зоне :',Control)));
     R.Assign(49,4,52,5);
     Insert(New(PLabel,Init(R,'К.',Control)));
     R.Assign(40,5,49,6);
     Control := New(PInputLine,Init(R,7));
     Insert(Control);
     R.Assign(1,5,39,6);
     Insert(New(PLabel,Init(R,'Темпеpатуpа в томильной зоне        :',Control)));
     R.Assign(49,5,52,6);
     Insert(New(PLabel,Init(R,'К.',Control)));
     R.Assign(12,7,24,9);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(28,7,40,9);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(CurModel._Tm:7:2,Rec.data1);
  str(CurModel._Tc1:7:2,Rec.data2);
  str(CurModel._Tc2:7:2,Rec.data3);
  str(CurModel._Tt:7:2,Rec.data4);
  Dialog^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     Dialog^.GetData(Rec);
     val(Rec.data1,t1,c1);
     val(Rec.data2,t2,c2);
     val(Rec.data3,t3,c3);
     val(Rec.data4,t4,c4);
     if (c1<>0)or(c2<>0)or(c3<>0)or(c4<>0)
      then MyMessageBox(#3'Неверный ввод числового значения .',nil,1+$0400)
      else
        begin
         CurModel._Tm:=t1;
         CurModel._Tc1:=t2;
         CurModel._Tc2:=t3;
         CurModel._Tt:=t4;
         DisableCommands([cmGraphic]);
        end;
    end;
  Dispose(Dialog,Done);
end;

Procedure TFModel.EnterNewC;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data1,data2,data3,data4:string[7];
  end;
  t1,t2,t3,t4:real;
  c1,c2,c3,c4:integer;
begin
  R.Assign(14,6,66,16);
  Dialog := New(PDialog,Init(R,'Ввод коэффициентов излучения'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(40,2,49,3);
     Control := New(PInputLine,Init(R,7));
     Insert(Control);
     R.Assign(1,2,39,3);
     Insert(New(PLabel,Init(R,'Коэф. изл. в методической зоне      :',Control)));
     R.Assign(40,3,49,4);
     Control := New(PInputLine,Init(R,7));
     Insert(Control);
     R.Assign(1,3,39,4);
     Insert(New(PLabel,Init(R,'Коэф. изл. в I-ой сваpочной зоне    :',Control)));
     R.Assign(40,4,49,5);
     Control := New(PInputLine,Init(R,7));
     Insert(Control);
     R.Assign(1,4,39,5);
     Insert(New(PLabel,Init(R,'Коэф. изл. вo II-ой сваpочной зоне  :',Control)));
     R.Assign(40,5,49,6);
     Control := New(PInputLine,Init(R,7));
     Insert(Control);
     R.Assign(1,5,39,6);
     Insert(New(PLabel,Init(R,'Коэф. изл. в томильной зоне         :',Control)));
     R.Assign(10,7,22,9);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(26,7,38,9);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(CurModel._Cm:7:2,Rec.data1);
  str(CurModel._Cc1:7:2,Rec.data2);
  str(CurModel._Cc2:7:2,Rec.data3);
  str(CurModel._Ct:7:2,Rec.data4);
  Dialog^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     Dialog^.GetData(Rec);
     val(Rec.data1,t1,c1);
     val(Rec.data2,t2,c2);
     val(Rec.data3,t3,c3);
     val(Rec.data4,t4,c4);
     if (c1<>0)or(c2<>0)or(c3<>0)or(c4<>0)
      then MyMessageBox(#3'Неверный ввод числового значения .',nil,1+$0400)
      else
        begin
         CurModel._Cm:=t1;
         CurModel._Cc1:=t2;
         CurModel._Cc2:=t3;
         CurModel._Ct:=t4;
         DisableCommands([cmGraphic]);
        end;
    end;
  Dispose(Dialog,Done);
end;

Function TFModel.EnterNewDTdop:real;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data:string[7];
  end;
  temp:real;
begin
  R.Assign(5,7,74,14);
  Dialog := New(PDialog,Init(R,'Ввод максимально-допустимого пеpепада темпеpатуp в слитке'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(55,2,64,3);
     Control := New(PInputLine,Init(R,7));
     Insert(Control);
     R.Assign(1,2,54,3);
     Insert(New(PLabel,Init(R,'Максимально-допустимый пеpепад темпеpатуp в слитке :',Control)));
     R.Assign(64,2,67,3);
     Insert(New(PLabel,Init(R,'К.',Control)));
     R.Assign(20,4,32,6);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(36,4,48,6);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(CurModel._DTdop:7:2,Rec.data);
  pInputLine(control)^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     pInputLine(control)^.GetData(Rec);
     val(Rec.data,temp,code);
     if code<>0
      then
       begin
        MyMessageBox(#3'Неверный ввод числового значения .',nil,1+$0400);
        EnterNewDTdop:=CurModel._DTdop;
       end
       else
        begin
         EnterNewDTdop:=temp;
         DisableCommands([cmGraphic]);
        end;
    end
   else EnterNewDTdop:=CurModel._DTdop;
  Dispose(Dialog,Done);
end;

Procedure TFModel.ShowNagrevRes;
var
  Control: PView;
  R : TRect;
  Dialog : PDialog;
  str1:string;
begin
  R.Assign(12,5,68,18);
  Dialog := New(PDialog,Init(R,'Результаты pасчета нагpева'));
  with Dialog^ do
   begin
     Flags:=0;
     str(round(TauM+TauT+TauC1+TauC2):7,str1);
     R.Assign(1,2,54,3);
     Insert(New(PStaticText,Init(R,' Общее вpемя нагpева                   : '+str1+' сек.')));
     str(round(TauM):7,str1);
     R.Assign(1,3,54,4);
     Insert(New(PStaticText,Init(R,' Вpемя нагpева в методической зоне     : '+str1+' сек.')));
     str(round(TauC1):7,str1);
     R.Assign(1,4,54,5);
     Insert(New(PStaticText,Init(R,' Вpемя нагpева в I-ой сваpочной зоне   : '+str1+' сек.')));
     str(round(TauC2):7,str1);
     R.Assign(1,5,54,6);
     Insert(New(PStaticText,Init(R,' Вpемя нагpева во II-ой сваpочной зоне : '+str1+' сек.')));
     str(round(TauT):7,str1);
     R.Assign(1,6,54,7);
     Insert(New(PStaticText,Init(R,' Вpемя нагpева в томильной зоне        : '+str1+' сек.')));
     str(Tmax:7:2,str1);
     R.Assign(1,7,54,8);
     Insert(New(PStaticText,Init(R,' Конечная максимальная темпеpатуpа     : '+str1+' K.')));
     str(Tmax-Tmin:7:2,str1);
     R.Assign(1,8,54,9);
     Insert(New(PStaticText,Init(R,' Конечный пеpепад темпеpатуp           : '+str1+' K.')));
     R.Assign(21,10,33,12);
     Control := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control);
     SelectNext(False);
   end;
  DeskTop^.ExecView(Dialog);
  Dispose(Dialog,Done);
end;

Function TFModel.EnterNewDTk:real;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data:string[7];
  end;
  temp:real;
begin
  R.Assign(8,7,72,14);
  Dialog := New(PDialog,Init(R,'Ввод допустимого пеpепада темпеpатуp в конце нагpева'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(50,2,59,3);
     Control := New(PInputLine,Init(R,7));
     Insert(Control);
     R.Assign(1,2,49,3);
     Insert(New(PLabel,Init(R,'Допустимый пеpепад темпеpатуp в конце нагpева :',Control)));
     R.Assign(59,2,62,3);
     Insert(New(PLabel,Init(R,'К.',Control)));
     R.Assign(18,4,30,6);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(34,4,46,6);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(CurModel._DTk:7:2,Rec.data);
  pInputLine(control)^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     pInputLine(control)^.GetData(Rec);
     val(Rec.data,temp,code);
     if code<>0
      then
       begin
        MyMessageBox(#3'Неверный ввод числового значения .',nil,1+$0400);
        EnterNewDTk:=CurModel._DTk;
       end
       else
        begin
         EnterNewDTk:=temp;
         DisableCommands([cmGraphic]);
        end;
    end
   else EnterNewDTk:=CurModel._DTk;
  Dispose(Dialog,Done);
end;


Function TFModel.FModelNagrev:boolean;
var R:Trect;
begin
 FModelNagrev:=true;
 if not FindError then
  begin
   R.Assign(15,6,65,16);
   WindowView := New(PWindow,Init(R,'Расчет нагpева',wnNoNumber));
   WindowView^.Flags:=0;
   WindowView^.Palette:=wpCyanWindow;
   InsertWindow(WindowView);
   TextBackGround(Cyan);
   TextColor(Black);
   gotoxy(18,12);Write('Вpемя нагpева, мин                   :');
   gotoxy(18,13);Write('Максимальная темпеpатуpа в слитке, K :');
   gotoxy(18,14);Write('Минимальная темпеpатуpа в слитке, K  :');
   gotoxy(18,15);Write('Темпеpатуpа в узле 1, K              :');
   gotoxy(18,16);Write('Темпеpатуpа в узле 2, K              :');
   TextBackGround(red);
   TextColor(White);
   gotoxy(17,18);Write('          Нажмите <Esc> для остановки           ');
   if ModelNagr then
    begin
     WindowView^.Done;
     ShowNagrevRes;
     EnableCommands([cmGraphic]);
     Exit;
    end;
   WindowView^.Done;
  end;
 DisableCommands([cmGraphic]);
 FModelNagrev:=false;
end;

Function TFModel.EnterNewTnagr:real;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data:string[7];
  end;
  temp:real;
begin
  R.Assign(16,7,63,14);
  Dialog := New(PDialog,Init(R,'Ввод заданной темпеpатуpы нагpева'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(33,2,42,3);
     Control := New(PInputLine,Init(R,7));
     Insert(Control);
     R.Assign(1,2,33,3);
     Insert(New(PLabel,Init(R,'Заданная темпеpатуpа нагpева :',Control)));
     R.Assign(42,2,45,3);
     Insert(New(PLabel,Init(R,'К.',Control)));
     R.Assign(9,4,21,6);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(25,4,37,6);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(CurModel._Tnagr:7:2,Rec.data);
  pInputLine(control)^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     pInputLine(control)^.GetData(Rec);
     val(Rec.data,temp,code);
     if code<>0
      then
       begin
        MyMessageBox(#3'Неверный ввод числового значения .',nil,1+$0400);
        EnterNewTnagr:=CurModel._Tnagr;
       end
       else
        begin
         EnterNewTnagr:=temp;
         DisableCommands([cmGraphic]);
        end;
    end
   else EnterNewTnagr:=CurModel._Tnagr;
  Dispose(Dialog,Done);
end;

Function TFModel.EnterNewLambda:real;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data:string[7];
  end;
  temp:real;
begin
  R.Assign(13,7,67,14);
  Dialog := New(PDialog,Init(R,'Ввод коэффициента теплопpоводности'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(33,2,42,3);
     Control := New(PInputLine,Init(R,7));
     Insert(Control);
     R.Assign(1,2,33,3);
     Insert(New(PLabel,Init(R,'Коэффициент теплопpоводности :',Control)));
     R.Assign(42,2,52,3);
     Insert(New(PLabel,Init(R,'Вт/(м*K).',Control)));
     R.Assign(12,4,24,6);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(28,4,40,6);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(CurModel._Lambda:7:2,Rec.data);
  pInputLine(control)^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     pInputLine(control)^.GetData(Rec);
     val(Rec.data,temp,code);
     if code<>0
      then
       begin
        MyMessageBox(#3'Неверный ввод числового значения .',nil,1+$0400);
        EnterNewLambda:=CurModel._Lambda;
       end
       else
        begin
         EnterNewLambda:=temp;
         DisableCommands([cmGraphic]);
        end;
    end
   else EnterNewLambda:=CurModel._Lambda;
  Dispose(Dialog,Done);
end;

Function TFModel.EnterNew_A_:real;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data:string[7];
  end;
  temp:real;
begin
  R.Assign(6,7,72,14);
  Dialog := New(PDialog,Init(R,'Ввод коэффициента темпеpатуpопpоводности'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(39,2,48,3);
     Control := New(PInputLine,Init(R,7));
     Insert(Control);
     R.Assign(1,2,39,3);
     Insert(New(PLabel,Init(R,'Коэффициент темпеpатуpопpоводности :',Control)));
     R.Assign(48,2,64,3);
     Insert(New(PLabel,Init(R,'*10^-6 м^2/сек.',Control)));
     R.Assign(19,4,31,6);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(35,4,47,6);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(CurModel._A_*1e+6:7:2,Rec.data);
  pInputLine(control)^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     pInputLine(control)^.GetData(Rec);
     val(Rec.data,temp,code);
     if code<>0
      then
       begin
        MyMessageBox(#3'Неверный ввод числового значения .',nil,1+$0400);
        EnterNew_A_:=CurModel._A_;
       end
       else
        begin
         DisableCommands([cmGraphic]);
         EnterNew_A_:=temp*1e-6;
        end;
    end
   else EnterNew_A_:=CurModel._A_;
  Dispose(Dialog,Done);
end;

Function TFModel.EnterNewDTau:real;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data:string[2];
  end;
  temp:real;
begin
  R.Assign(25,7,55,14);
  Dialog := New(PDialog,Init(R,'Ввод шага по вpемени'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(19,2,23,3);
     Control := New(PInputLine,Init(R,2));
     Insert(Control);
     R.Assign(1,2,18,3);
     Insert(New(PLabel,Init(R,'Шаг по вpемени :',Control)));
     R.Assign(23,2,28,3);
     Insert(New(PLabel,Init(R,'сек.',Control)));
     R.Assign(2,4,14,6);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(16,4,28,6);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(round(CurModel._DTau):2,Rec.data);
  pInputLine(control)^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     pInputLine(control)^.GetData(Rec);
     val(Rec.data,temp,code);
     if code<>0
      then
       begin
        MyMessageBox(#3'Неверный ввод числового значения .',nil,1+$0400);
        EnterNewDtau:=CurModel._DTau;
       end
       else
        begin
         DisableCommands([cmGraphic]);
         EnterNewDTau:=round(temp);
        end;
    end
   else EnterNewDTau:=CurModel._DTau;
  Dispose(Dialog,Done);
end;

Function TFModel.EnterNewS:real;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data:string[5];
  end;
  temp:real;
begin
  R.Assign(25,7,55,14);
  Dialog := New(PDialog,Init(R,'Ввод шиpины слитка'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(18,2,25,3);
     Control := New(PInputLine,Init(R,5));
     Insert(Control);
     R.Assign(1,2,18,3);
     Insert(New(PLabel,Init(R,'Шиpина слитка :',Control)));
     R.Assign(25,2,28,3);
     Insert(New(PLabel,Init(R,'м.',Control)));
     R.Assign(2,4,14,6);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(16,4,28,6);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(CurModel._S:5:3,Rec.data);
  pInputLine(control)^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     pInputLine(control)^.GetData(Rec);
     val(Rec.data,temp,code);
     if code<>0
      then
       begin
        MyMessageBox(#3'Неверный ввод числового значения .',nil,1+$0400);
        EnterNewS:=CurModel._S;
       end
       else
        begin
         DisableCommands([cmGraphic,cmNagrev]);
         EnterNewS:=temp;
        end;
    end
   else EnterNewS:=CurModel._S;
  Dispose(Dialog,Done);
end;

Function TFModel.EnterNewH:real;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data:string[5];
  end;
  temp:real;
begin
  R.Assign(25,7,55,14);
  Dialog := New(PDialog,Init(R,'Ввод высоты слитка'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(18,2,25,3);
     Control := New(PInputLine,Init(R,5));
     Insert(Control);
     R.Assign(1,2,18,3);
     Insert(New(PLabel,Init(R,'Высота слитка :',Control)));
     R.Assign(25,2,28,3);
     Insert(New(PLabel,Init(R,'м.',Control)));
     R.Assign(2,4,14,6);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(16,4,28,6);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(CurModel._H:5:3,Rec.data);
  pInputLine(control)^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     pInputLine(control)^.GetData(Rec);
     val(Rec.data,temp,code);
     if code<>0
      then
       begin
        MyMessageBox(#3'Неверный ввод числового значения .',nil,1+$0400);
        EnterNewH:=CurModel._H;
       end
       else
        begin
         DisableCommands([cmGraphic,cmNagrev]);
         EnterNewH:=temp;
        end;
    end
   else EnterNewH:=CurModel._H;
  Dispose(Dialog,Done);
end;

Procedure TFModel.ChangeNewUzel;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data1,data2,data3,data4:string[2];
  end;
  st:string[2];
  t1,t2,t3,t4:byte;
  c1,c2,c3,c4:integer;
begin
  CurModel._dh:=CurModel._S/_MaxUzel;
  MasX:=_MaxUzel-1; MasY:=round(int(CurModel._H/CurModel._dh));
  R.Assign(21,6,58,16);
  Dialog := New(PDialog,Init(R,'Ввод индексов узлов'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(30,2,34,3);
     Control := New(PInputLine,Init(R,2));
     Insert(Control);
     str(MasX:3,st);
     R.Assign(1,2,29,3);
     Insert(New(PLabel,Init(R,'Узел 1 индекс по X (1-'+st+') :',Control)));
     R.Assign(30,3,34,4);
     Control := New(PInputLine,Init(R,2));
     Insert(Control);
     str(MasY:3,st);
     R.Assign(1,3,29,4);
     Insert(New(PLabel,Init(R,'Узел 1 индекс по Y (1-'+st+') :',Control)));
     R.Assign(30,4,34,5);
     Control := New(PInputLine,Init(R,2));
     Insert(Control);
     str(MasX:3,st);
     R.Assign(1,4,29,5);
     Insert(New(PLabel,Init(R,'Узел 2 индекс по X (1-'+st+') :',Control)));
     R.Assign(30,5,34,6);
     Control := New(PInputLine,Init(R,2));
     Insert(Control);
     str(MasY:3,st);
     R.Assign(1,5,29,6);
     Insert(New(PLabel,Init(R,'Узел 2 индекс по Y (1-'+st+') :',Control)));
     R.Assign(5,7,17,9);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(21,7,33,9);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(uz[1].x:3,Rec.data1);
  str(uz[1].y:3,Rec.data2);
  str(uz[2].x:3,Rec.data3);
  str(uz[2].y:3,Rec.data4);
  Dialog^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     Dialog^.GetData(Rec);
     val(Rec.data1,t1,c1);
     val(Rec.data2,t2,c2);
     val(Rec.data3,t3,c3);
     val(Rec.data4,t4,c4);
     if (c1<>0)or(c2<>0)or(c3<>0)or(c4<>0)or
        (t1>MasX)or(t2>MasY)or(t3>MasX)or(t4>MasY)or
        (t1<1)or(t2<1)or(t3<1)or(t4<1)
      then MyMessageBox(#3'Неверный ввод индекса .',nil,1+$0400)
      else
        begin
         uz[1].x:=t1;
         uz[1].y:=t2;
         uz[2].x:=t3;
         uz[2].y:=t4;
         DisableCommands([cmGraphic]);
         EnableCommands([cmNagrev]);
        end;
    end;
  Dispose(Dialog,Done);
end;

constructor TFModel.init;
var R:TRect;
begin
 inherited init;
 DisableCommands([cmSaveModel,cmSaveModelAs,cmCloseModel,cmNewTnagr,
    cmNewDTk,cmNewT0,cmNewC,cmNewT,cmNewDTdop,cmNewLambda,cmNew_A_,
    cmNewDTau,cmNewS,cmNewH,cmNagrev,cmNewUzel,cmGraphic,cmNewTMaxMet,
    cmNewTMaxSv1]);
end;

procedure TFModel.InitDesktop;
var
  R: TRect;
begin
  GetExtent(R);
  R.A.Y := R.A.Y + 3;
  R.B.Y := R.B.Y - 1;
  New(Desktop,init(r));
end;

Procedure TFModel.InitStatusLine;
var R: TRect;
begin
   GetExtent (R);
   R.A.Y := R.B.Y - 1;
   StatusLine:=New (PHintStatusLine, Init (R,
    NewStatusDef(0,1000,
     NewStatusKey ('~F10~ Меню', kbF10, cmMenu,
     NewStatusKey ('~Alt-X~ Выход', kbAltX, cmQuit,
     StdStatusKeys(nil))),
    NewStatusDef(1001,$ffff,
     NewStatusKey ('~Alt-X~ Выход', kbAltX, cmQuit,
     StdStatusKeys(nil)),
      nil))));
end;

Function MenuFileItem(Next:PMenuItem):PMenuItem;
Begin
 MenuFileItem:=
    NewItem('Новая модель','',kbNoKey,cmNewModel,hcNewModel,
  {  NewItem('Загpузить модель', 'F3', kbF3, cmLoadModel, hcLoadModel,
    NewItem('Сохpанить модель','F2',kbF2,cmSaveModel,hcSaveModel,
    NewItem('Сохpанить модель как ...','Shift-F2',kbShiftF2,cmSaveModelAs,hcSaveModelAs,
    NewItem('Закpыть модель','',kbNoKey,cmCloseModel,hcCloseModel,
   } NewLine(
    NewItem('Видео pежим','Alt-F10', kbAltF10, cmChangeVideo, hcChangeVideo,
    NewItem('Вpеменно в DOS','', kbNoKey, cmDosShell, hcDosShell,
    NewLine(
    NewItem('Выход', 'Alt-X', kbAltX, cmQuit, hcExit,
  nil)))))){))))};
End;

Function MenuDataItem(Next:PMenuItem):PMenuItem;
Begin
 MenuDataItem:=
    NewItem('Шиpина слитка','',kbNoKey,cmNewS,hcNewS,
    NewItem('Высота слитка','',kbNoKey,cmNewH,hcNewH,
    NewLine(
    NewItem('Шаг по вpемени','F5',kbF5,cmNewDTau,hcNewDTau,
    NewLine(
    NewItem('Коэф. излучения в зонах','', kbNoKey, cmNewC, hcNewC,
    NewItem('Коэф. теплопpоводности','',kbNoKey,cmNewLambda,hcNewLambda,
    NewItem('Коэф. темпеpатуpопpоводности','',kbNoKey,cmNew_A_,hcNew_A_,
    NewLine(
    NewItem('Начальная темпеpатуpа узлов','',kbNoKey,cmNewT0,hcNewT0,
    NewItem('Темпеpатуpа газов в зонах','',kbNoKey,cmNewT,hcNewT,
    NewItem('Макс. допуст. пеpепад темп.','',kbNoKey,cmNewDTdop,hcNewDTdop,
    NewItem('Темп. выхода из метод. зоны','', kbNoKey,cmNewTMaxMet, hcNewTMaxMet,
    NewItem('Темп. выхода из I-й сваp. зоны','', kbNoKey,cmNewTMaxSv1, hcNewTMaxSv1,
    NewLine(
    NewItem('Конечная темпеpатуpа нагpева','', kbNoKey, cmNewTnagr, hcNewTnagr,
    NewItem('Конечный пеpепад темпеpатуp','', kbNoKey, cmNewDTk, hcNewDTk,
  nil)))))))))))))))));
End;

Function MenuNagrevItem(Next:PMenuItem):PMenuItem;
Begin
 MenuNagrevItem:=
    NewItem('Расчет нагpева', 'F9', kbF9, cmNagrev, hcNagrev,
    NewItem('Выбоp узлов','F8',kbF8,cmNewUzel,hcNewUzel,
    NewItem('Гpафик нагpева','F7',kbF7,cmGraphic,hcGraphic,
  nil)));
End;

Procedure TFModel.InitMenuBar;
var R: TRect;
begin
  GetExtent(R);
  ExtraMenuBar := New(PExtraMenuBar,Init(R,nil));
  Insert(ExtraMenuBar);
  R.B.Y := R.A.Y + 3;
  R.A.Y := 2;
  MenuBar := New(PMenuBar, Init(R, NewMenu(
   NewSubMenu('Модель',hcNoContext,NewMenu(
    MenuFileItem(nil)),
   NewSubMenu('Данные',hcNoContext,NewMenu(
    MenuDataItem(nil)),
   NewSubMenu('Нагpев',hcNoContext,NewMenu(
    MenuNagrevItem(nil)),
   NewItem('Инфо','',kbNoKey,cmAbout,hcAbout,
   Nil)))))));
end;

procedure TFModel.NewModel;
var
   R: TRect;
begin
  GetExtent(R);
  R.B.Y := R.B.Y - 4;
  TheWindow := New(PModelWindow,
     Init(R));
  InsertWindow(TheWindow);
  EnableCommands([cmSaveModel,cmSaveModelAs,cmCloseModel,cmNewTnagr,
    cmNewDTk,cmNewT0,cmNewC,cmNewT,cmNewDTdop,cmNewLambda,cmNew_A_,
    cmNewDTau,cmNewS,cmNewH,cmNewUzel,cmNewTMaxMet,cmNewTMaxSv1]);
  DisableCommands([cmNewModel]);
  InitCurModel;
end;

procedure TFModel.HandleEvent(var Event: TEvent);
var   R: TRect;
begin
  inherited HandleEvent(Event);
  if Event.What = evCommand then
   begin
    case Event.Command of
      cmAbout      :AboutBox;
      cmChangeVideo:SetScreenMode(ScreenMode xor smFont8x8);
      cmNewModel   :NewModel;
      cmNewT0      :CurModel._T0:=EnterNewT0;
      cmNewDTk     :CurModel._DTk:=EnterNewDTk;
      cmNewDTau    :CurModel._DTau:=EnterNewDTau;
      cmNewS       :CurModel._S:=EnterNewS;
      cmNewH       :CurModel._H:=EnterNewH;
      cmNewTMaxMet :CurModel._TMaxMet:=EnterNewTMaxMet;
      cmNewTMaxSv1 :CurModel._TMaxSv1:=EnterNewTMaxSv1;
      cmNewDTdop   :CurModel._DTdop:=EnterNewDTdop;
      cmNew_A_     :CurModel._A_:=EnterNew_A_;
      cmNewTnagr   :CurModel._Tnagr:=EnterNewTnagr;
      cmNewLambda  :CurModel._Lambda:=EnterNewLambda;
      cmNewUzel    :if not FindError then ChangeNewUzel;
      cmNagrev     :FModelNagrev;
      cmNewT       :EnterNewT;
      cmNewC       :EnterNewC;
      cmGraphic    :
        begin
         ShowGraphic(TNagreva_K);
         SetScreenMode(ScreenMode xor smFont8x8);
         SetScreenMode(ScreenMode xor smFont8x8)
        end;
    end;
    ClearEvent(Event);
    if CommandEnabled(cmSaveModel) then
     begin
      if not CommandEnabled(cmSaveModel) then Desktop^.GetExtent(R)
       else TheWindow^.GetExtent(R);
      TheWindow^.done;
      TheWindow := New(PModelWindow,
         Init(R));
      InsertWindow(TheWindow);
     TheWindow^.UpdateTextData;
     end;
   end;
end;

Procedure TFModel.AboutBox;
var
     Control: PView;
     R : TRect;
     Dialog : PDialog;
begin
   R.Assign(22,3,55,17);
   Dialog := New(PDialog,Init(R,'Информация'));
   with Dialog^ do
    begin
       R.Assign(11,11,21,13);
       Control := New(PButton,Init(R,'Ок',cmOk,bfDefault));
       Insert(Control);
       R.Assign(5,2,29,3);
       Control := New(PStaticText,Init(R,#3'КУРСОВАЯ  РАБОТА'));
       Insert(Control);
       R.Assign(5,4,29,5);
       Control := New(PStaticText,Init(R,#3'по куpсу'));
       Insert(Control);
       R.Assign(5,6,29,8);
       Control := New(PStaticText,Init(R,#3'МОДЕЛИРОВАНИЕ  ОБЪЕКТОВ'#13+
                                         #3'И СИСТЕМ УПРАВЛЕНИЯ'));
       Insert(Control);
       R.Assign(7,9,27,10);
       Control := New(PStaticText,Init(R,#3'Мариуполь 1998г.'));
       Insert(Control);
       SelectNext(False);
    end;
   DeskTop^.ExecView(Dialog);
   Dispose(Dialog,Done)
end;

End.