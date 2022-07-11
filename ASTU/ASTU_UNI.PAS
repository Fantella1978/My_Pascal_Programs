unit ASTU_UNI;

INTERFACE

 uses msgbox,app,menus,objects,drivers,views,dialogs,validate;

 type
     pMyRangeValidator=^tMyRangeValidator;
     tMyRangeValidator=object(tRangeValidator)
        procedure Error;virtual;
     end;
     jnum=record
       x,y:real;
     end;

 const
  cmGetDet     =101;
  cmClrDet     =102;
  cmViewDet    =103;
  cmGetUr      =104;
  cmClrAUr     =105;
  cmClrBUr     =106;
  cmViewUr     =107;
  cmSizeDet    =1001;
  cmDataDet    =1002;
  cmSizeUr     =1003;
  cmDataAUr    =1004;
  cmDataBUr    =1005;
  cmSum        =1006;
  cmRazn       =1007;
  cmMult       =1008;
  cmOtnoh      =1009;
  cmAbout      =1999;
  cmPuzzle     =1010;
  cmCalc       =1011;
  cmCalend     =1012;

 var
     SizeDet:byte;
     SizeUr:byte;
     code:integer;
     a,b:array[1..6,1..6]of real;
     c,d:array[1..4,1..5]of real;
     x:array[1..4]of real;
     j1,j2,j3:jnum;

 procedure EnterSizeDet;
 procedure MyAbout;
 function MyMessageBox(const Msg:string;Params:Pointer;AOptions:word):word;
 procedure ViewDet;
 procedure ClearDet;
 procedure EnterDataDet;
 procedure GetDet;
 procedure EnterSizeUr;
 procedure EnterDataAUr;
 procedure EnterDataBUr;
 function ClearAUr:boolean;
 function ClearBUr:boolean;
 procedure ViewUr;
 Procedure GetUr;
 procedure ShowRes(j3:jnum);
 function jData(i:byte):integer;
 procedure jSum;
 procedure jRazn;
 procedure jMult;
 procedure jOtnoh;


IMPLEMENTATION

Function opred:real;
var k,l,i,j,f,z:byte;
    m1,t,d:real;
begin
  for i:=1 to SizeDet do for j:=1 to SizeDet do b[i,j]:=a[i,j];
  d:=1;
  for k:=1 to SizeDet do
   begin
    m1:=0;i:=k;
    while i<=SizeDet do
     begin
      t:=a[i,k];
      if abs(t)>abs(m1)
       then
        begin
         m1:=t;j:=i;
        end;
      i:=i+1;
     end;
    if m1=0
     then
      begin
       opred:=0;
       exit;
      end;
    if j<>k
     then
      begin
       d:=-d;l:=k;
       while l<=SizeDet do
        begin
         t:=a[j,l];
         a[j,l]:=a[k,l];
         a[k,l]:=t;
         l:=l+1;
        end;
      end;
    f:=k+1;
    while f<=SizeDet do
     begin
      t:=a[f,k]/m1;
      z:=k+1;
      while z<=SizeDet do
       begin
        a[f,z]:=a[f,z]-t*a[k,z];
        z:=z+1;
       end;
      f:=f+1;
     end;
    d:=d*a[k,k];
   end;
  opred:=d;
  for i:=1 to SizeDet do for j:=1 to SizeDet do a[i,j]:=b[i,j];
 end;

procedure GetDet;
var st:string[10];
begin
 if MyMessageBox(' Показать элементы определителя ?',nil,3+$0100+$0200)
   = cmYes then ViewDet;
 str(opred:10:10,st);
 MyMessageBox('    Определитель = '+st,nil,2+$0400);
end;

function MyMessageBoxRect(var R:tRect;const Msg:string;
                          Params:Pointer;AOptions:word):word;
const
  ButtonName:array[0..3]of string[6]=('Да','Нет','Ввод','Отмена');
  Commands:array[0..3]of word=(cmYes,cmNo,cmOk,cmCancel);
  Titles:array[0..3]of string[11]=
         ('Предупрежд.','Ошибка','Информация','Подтвержд.');
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

procedure tMyRangeValidator.Error;
var params:pointer;
    Rec:record
     low,hig:longint;
    end;
begin
 Rec.low:=pMyRangeValidator(@Self)^.Min;
 Rec.hig:=pMyRangeValidator(@Self)^.Max;
 params:=@Rec;
 MyMessageBox('Вводимое значение должно быть в интервале от %d до %d .',
            params,mfError+mfOkButton);
end;

function EnterDataDet1(i,j:byte):integer;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data:string[10];
  end;
  st1,st2:string[1];
begin
  str(i,st1);
  str(j,st2);
  R.Assign(21,7,57,14);
  Dialog := New(PDialog,Init(R,'Ввод данных'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(21,2,33,3);
     Control := New(PInputLine,Init(R,10));
     Insert(Control);
     R.Assign(2,2,18,3);
     Insert(New(PLabel,Init(R,'Элемент A('+st1+','+st2+'):',Control)));
     R.Assign(5,4,17,6);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(20,4,32,6);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(a[i,j]:10:10,Rec.data);
  pInputLine(control)^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     pInputLine(control)^.GetData(Rec);
     val(Rec.data,a[i,j],code);
     if code<>0
      then MyMessageBox('Неверный ввод числового значения .',nil,1+$0400);
    end;
  Dispose(Dialog,Done);
 EnterDataDet1:=code;
end;

procedure EnterDataDet;
var
  i,j:byte;
begin
 for i:=1 to SizeDet do
  for j:=1 to SizeDet do
   repeat until EnterDataDet1(i,j)=0;
end;

procedure ClearDet;
var i,j:byte;
begin
 if MyMessageBox('Вы уверены, что хотите удалить все данные ?',nil,0+
   +$0100+$0200) = cmYes
     then
       for i:=1 to SizeDet do
         for j:=1 to SizeDet do a[i,j]:=0;
end;

procedure ViewDet;
var
     Control: PView;
     R : TRect;
     Dialog : PDialog;
     st :string[10];
     st1:string[1];
     i,j:byte;
begin
   R.Assign(40-4-SizeDet*6,7-SizeDet,40+3+SizeDet*6,16+SizeDet);
   Dialog := New(PDialog,Init(R,'Просмотр данных'));
   with Dialog^ do
    begin
       R.Assign(5+(SizeDet-1)*6,6+SizeDet*2,15+(SizeDet-1)*6,8+SizeDet*2);
       Control := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
       Insert(Control);
       R.Assign(2,2,4,3);
       Control := New(PStaticText,Init(R,'╔═'));
       Insert(Control);
       R.Assign(2,3,4,4);
       Control := New(PStaticText,Init(R,'║A'));
       Insert(Control);
       R.Assign(2,4+SizeDet*2,4,5+SizeDet*2);
       Control := New(PStaticText,Init(R,'╚═'));
       Insert(Control);
       R.Assign(4+SizeDet*12,4+SizeDet*2,5+SizeDet*12,5+SizeDet*2);
       Control := New(PStaticText,Init(R,'╝'));
       Insert(Control);
       R.Assign(4+SizeDet*12,2,5+SizeDet*12,3);
       Control := New(PStaticText,Init(R,'╗'));
       Insert(Control);
       R.Assign(4+SizeDet*12,3,5+SizeDet*12,4);
       Control := New(PStaticText,Init(R,'║'));
       Insert(Control);
       for j:=1 to SizeDet do
        begin
         R.Assign(4+(j-1)*12,2,16+(j-1)*12,3);
         Control := New(PStaticText,Init(R,'╤═══════════'));
         Insert(Control);
        end;
       for j:=1 to SizeDet do
        begin
         str(j,st1);
         R.Assign(4+(j-1)*12,3,16+(j-1)*12,4);
         Control := New(PStaticText,Init(R,'│     '+st1));
         Insert(Control);
        end;
       for j:=1 to SizeDet do
        begin
         R.Assign(4+(j-1)*12,4+SizeDet*2,16+(j-1)*12,5+SizeDet*2);
         Control := New(PStaticText,Init(R,'╧═══════════'));
         Insert(Control);
        end;
       for i:=1 to SizeDet do
        begin
         R.Assign(2,2+i*2,4,3+i*2);
         Control := New(PStaticText,Init(R,'╟─'));
         Insert(Control);
         for j:=1 to SizeDet do
          begin
           R.Assign(4+(j-1)*12,2+i*2,16+(j-1)*12,3+i*2);
           Control := New(PStaticText,Init(R,'┼───────────'));
           Insert(Control);
          end;
        end;
       for i:=1 to SizeDet do
        begin
         R.Assign(4+SizeDet*12,2+i*2,5+SizeDet*12,3+i*2);
         Control := New(PStaticText,Init(R,'╢'));
         Insert(Control);
         R.Assign(4+SizeDet*12,3+i*2,5+SizeDet*12,4+i*2);
         Control := New(PStaticText,Init(R,'║'));
         Insert(Control);
         for J:=1 to SizeDet do
          begin
           str(a[i,j]:10:10,st);
           R.Assign(6+(j-1)*12,3+i*2,16+(j-1)*12,4+i*2);
           Control := New(PStaticText,Init(R,st));
           Insert(Control);
          end;
        end;
       for i:=1 to SizeDet do
        for J:=1 to SizeDet-1 do
         begin
          R.Assign(4+j*12,3+i*2,5+j*12,4+i*2);
          Control := New(PStaticText,Init(R,'│'));
          Insert(Control);
         end;
       for i:=1 to SizeDet do
         begin
          str(i,st1);
          R.Assign(2,3+i*2,5,4+i*2);
          Control := New(PStaticText,Init(R,'║'+st1+'│'));
          Insert(Control);
         end;
       SelectNext(False);
    end;
   DeskTop^.ExecView(Dialog);
   Dispose(Dialog,Done)
end;

procedure ShowRes(j3:jnum);
var
  Cont: PView;
  R : TRect;
  Dialog : PDialog;
  data,data1:string[10];
begin
  R.Assign(26,6,53,16);
  Dialog := New(PDialog,Init(R,'Результат'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     str(j3.x:10:10,data);
     str(j3.y:10:10,data1);
     R.Assign(2,2,12,3);
     Cont := New(PStaticText,Init(R,data));
     Insert(Cont);
     if j3.y>=0
      then
       begin
        R.Assign(12,2,13,3);
        Cont := New(PStaticText,Init(R,'+'));
        Insert(Cont);
        R.Assign(13,2,25,3);
        Cont := New(PStaticText,Init(R,data1+' i'));
        Insert(Cont);
       end
      else
       begin
        R.Assign(12,2,25,3);
        Cont := New(PStaticText,Init(R,data1+' i'));
        Insert(Cont);
       end;
     str(sqrt(sqr(j3.x)+sqr(j3.y)):10:10,data);
     if (j3.y>=0) then str(90-arctan(j3.x/j3.y)/pi*180:10:10,data1);
     if (j3.y< 0) then str(270+arctan(j3.x/abs(j3.y))/pi*180:10:10,data1);
     R.Assign(2,5,14,6);
     Cont := New(PStaticText,Init(R,data+' e'));
     Insert(Cont);
     R.Assign(15,4,25,5);
     Cont := New(PStaticText,Init(R,data1));
     Insert(Cont);
     R.Assign(8,7,20,9);
     Cont := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Cont);
     SelectNext(False);
   end;
  DeskTop^.ExecView(Dialog);
  Dispose(Dialog,Done);
end;



procedure MyAbout;
var
     Control: PView;
     R : TRect;
     Dialog : PDialog;
begin
   R.Assign(22,4,56,19);
   Dialog := New(PDialog,Init(R,'Информация'));
   with Dialog^ do
    begin
       R.Assign(12,12,22,14);
       Control := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
       Insert(Control);
       R.Assign(3,2,31,3);
       Control := New(PStaticText,Init(R,'Приазовский  Государственный'));
       Insert(Control);
       R.Assign(5,4,29,5);
       Control := New(PStaticText,Init(R,'Технический  Университет'));
       Insert(Control);
       R.Assign(12,6,22,7);
       Control := New(PStaticText,Init(R,'Версия 1.0'));
       Insert(Control);
       R.Assign(2,8,32,9);
       Control := New(PStaticText,Init(R,'Создал: Попов Вадим   гр.МА-95'));
       Insert(Control);
       R.Assign(8,10,26,11);
       Control := New(PStaticText,Init(R,'Мариуполь MCMXCVII'));
       Insert(Control);
       SelectNext(False);
    end;
   DeskTop^.ExecView(Dialog);
   Dispose(Dialog,Done)
end;

procedure EnterSizeDet;
var
     Control,Control1: PView;
     R : TRect;
     Dialog : PDialog;
     Rec:record
      size:string[2];
     end;
     i,j:byte;
begin
   R.Assign(24,6,54,16);
   Dialog := New(PDialog,Init(R,'Размер Определителя'));
   with Dialog^ do
    begin
       Flags:=wfClose;
       R.Assign(3,3,14,8);
       Control := New(PRadioButtons,Init(R,
       NewSItem('2 x 2',
       NewSItem('3 x 3',
       NewSItem('4 x 4',
       NewSItem('5 x 5',
       NewSItem('6 x 6',
       nil)))))));
       Insert(Control);
       R.Assign(2,2,11,3);
       Insert(New(PLabel,Init(R,'Размер:',Control)));
       R.Assign(15,4,27,6);
       Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
       Insert(Control1);
       R.Assign(15,6,27,8);
       Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
       Insert(Control1);
       SelectNext(False);
    end;
   pRadioButtons(control)^.sel:=SizeDet-2;
   pRadioButtons(control)^.movedTo(SizeDet-2);
   if DeskTop^.ExecView(Dialog) <> cmCancel
     then
      begin
       SizeDet:=pRadioButtons(control)^.value+2;
       MyMessageBox('При установке нового размера определителя все данные обнуляются.',nil,2+$0400);
       for i:=1 to SizeDet do
        for j:=1 to SizeDet do a[i,j]:=0;
      end;
   Dispose(Dialog,Done);
end;

{**************************************************************************}

procedure jSum;
begin
 if jData(1)=0
  then
   begin
    j3.X:=j1.x+j2.x;
    j3.y:=j1.y+j2.y;
    ShowRes(j3);
   end;
end;

procedure jRazn;
begin
 if jData(2)=0
  then
   begin
    j3.X:=j1.x-j2.x;
    j3.y:=j1.y-j2.y;
    ShowRes(j3);
   end;
end;

procedure jMult;
begin
 if jData(3)=0
  then
   begin
    j3.x:=j1.x*j2.x-j1.y*j2.y;
    j3.y:=j1.x*j2.y+j1.y*j2.x;
    ShowRes(j3);
   end;
end;

procedure jOtnoh;
begin
 if jData(4)=0
  then
   begin
    if (j2.x<>0)or(j2.y<>0)
     then
      begin
       j3.x:=(j1.x*j2.x+j1.y*j2.y)/(j2.x*j2.x+j2.y*j2.y);
       j3.y:=(j1.y*j2.x-j2.y*j1.x)/(j2.x*j2.x+j2.y*j2.y);
       ShowRes(j3);
      end
     else MyMessageBox('Деление на ноль.',nil,1+$0400);
   end;
end;



Procedure GetUr;
var
 Control: PView;
 R : TRect;
 Dialog : PDialog;
 st :string[10];
 st1:string[1];
 u,k,i,j,m:integer;
 t:real;
begin
 for i:=1 to SizeUr do
  for j:=1 to SizeUr+1 do d[i,j]:=c[i,j];
 if MyMessageBox('Показать данные системы уравнений ?',nil,3+$0100+$0200)
   = cmYes then ViewUr;
 u:=0;
 repeat
  inc(u);
  k:=u;
  while c[k,u]=0 do
   begin
    inc(k);
    if k>SizeUr
     then
      begin
        MyMessageBox('Систему решить невозможно.',nil,1+$0400);
        for i:=1 to SizeUr do
         for j:=1 to SizeUr+1 do c[i,j]:=d[i,j];
        exit;
      end;
   end;
  if k<>u then for m:=u to SizeUr+1 do
   begin
    t:=c[u,m];
    c[u,m]:=c[k,m];
    c[k,m]:=t;
   end;
  for j:=SizeUr+1 downto u do c[u,j]:=c[u,j]/c[u,u];
  m:=SizeUr+1;
  if k+1<=SizeUr then
   for i:=k+1 to SizeUr do
    for j:=u+1 to m do c[i,j]:=c[i,j]-c[i,u]*c[u,j];
 until u=SizeUr;
 for i:=SizeUr downto 1 do
  begin
   x[i]:=c[i,m];
   if i<>1 then for k:=i-1 downto 1 do c[k,m]:=c[k,m]-c[k,i]*x[i];
  end;
  R.Assign(25,7,54,13+SizeUr);
  Dialog := New(PDialog,Init(R,'Корни'));
  with Dialog^ do
   begin
      R.Assign(9,3+SizeUr,19,5+SizeUr);
      Control := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
      Insert(Control);
      for i:=1 to SizeUr do
       begin
        str(i,st1);
        str(x[i]:10:10,st);
        R.Assign(6,1+i,23,2+i);
        Control := New(PStaticText,Init(R,'X('+st1+') = '+st));
        Insert(Control);
       end;
      SelectNext(False);
   end;
  DeskTop^.ExecView(Dialog);
  Dispose(Dialog,Done);
 for i:=1 to SizeUr do
  for j:=1 to SizeUr+1 do c[i,j]:=d[i,j];
end;

procedure ViewUr;
var
     Control: PView;
     R : TRect;
     Dialog : PDialog;
     st :string[10];
     st1:string[1];
     i,j:byte;
begin
   R.Assign(40-10-SizeUr*6,7-SizeUr,40+9+SizeUr*6,16+SizeUr);
   Dialog := New(PDialog,Init(R,'Просмотр данных'));
   with Dialog^ do
    begin
       R.Assign(10+(SizeUr-1)*6,6+SizeUr*2,20+(SizeUr-1)*6,8+SizeUr*2);
       Control := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
       Insert(Control);
       R.Assign(2,2,4,3);
       Control := New(PStaticText,Init(R,'╔═'));
       Insert(Control);
       R.Assign(2,3,4,4);
       Control := New(PStaticText,Init(R,'║A'));
       Insert(Control);
       R.Assign(2,4+SizeUr*2,4,5+SizeUr*2);
       Control := New(PStaticText,Init(R,'╚═'));
       Insert(Control);
       R.Assign(4+SizeUr*12,4+SizeUr*2,5+SizeUr*12,5+SizeUr*2);
       Control := New(PStaticText,Init(R,'╩'));
       Insert(Control);
       R.Assign(4+SizeUr*12,2,5+SizeUr*12,3);
       Control := New(PStaticText,Init(R,'╦'));
       Insert(Control);
       R.Assign(10+SizeUr*12,3,11+SizeUr*12,4);
       Control := New(PStaticText,Init(R,'B'));
       Insert(Control);
       R.Assign(4+SizeUr*12,3,5+SizeUr*12,4);
       Control := New(PStaticText,Init(R,'║'));
       Insert(Control);
       R.Assign(5+SizeUr*12,2,17+SizeUr*12,3);
       Control := New(PStaticText,Init(R,'═══════════╗'));
       Insert(Control);
       R.Assign(5+SizeUr*12,4+SizeUr*2,17+SizeUr*12,5+SizeUr*2);
       Control := New(PStaticText,Init(R,'═══════════╝'));
       Insert(Control);
       for j:=0 to SizeUr do
        begin
         R.Assign(16+SizeUr*12,3+j*2,17+SizeUr*12,4+j*2);
         Control := New(PStaticText,Init(R,'║'));
         Insert(Control);
        end;
       for j:=1 to SizeUr do
        begin
         str(c[j,SizeUr+1]:10:10,st);
         R.Assign(6+SizeUr*12,3+j*2,16+SizeUr*12,4+j*2);
         Control := New(PStaticText,Init(R,st));
         Insert(Control);
         R.Assign(5+SizeUr*12,2+j*2,17+SizeUr*12,3+j*2);
         Control := New(PStaticText,Init(R,'───────────'));
         Insert(Control);
         R.Assign(16+SizeUr*12,2+j*2,17+SizeUr*12,3+j*2);
         Control := New(PStaticText,Init(R,'╢'));
         Insert(Control);
         R.Assign(4+(j-1)*12,2,16+(j-1)*12,3);
         Control := New(PStaticText,Init(R,'╤═══════════'));
         Insert(Control);
         str(j,st1);
         R.Assign(4+(j-1)*12,3,16+(j-1)*12,4);
         Control := New(PStaticText,Init(R,'│     '+st1));
         Insert(Control);
         R.Assign(4+(j-1)*12,4+SizeUr*2,16+(j-1)*12,5+SizeUr*2);
         Control := New(PStaticText,Init(R,'╧═══════════'));
         Insert(Control);
        end;
       for i:=1 to SizeUr do
        begin
         R.Assign(2,2+i*2,4,3+i*2);
         Control := New(PStaticText,Init(R,'╟─'));
         Insert(Control);
         R.Assign(4+SizeUr*12,2+i*2,5+SizeUr*12,3+i*2);
         Control := New(PStaticText,Init(R,'╫'));
         Insert(Control);
         R.Assign(4+SizeUr*12,3+i*2,5+SizeUr*12,4+i*2);
         Control := New(PStaticText,Init(R,'║'));
         Insert(Control);
         str(i,st1);
         R.Assign(2,3+i*2,5,4+i*2);
         Control := New(PStaticText,Init(R,'║'+st1+'│'));
         Insert(Control);
         for J:=1 to SizeUr-1 do
          begin
           R.Assign(4+j*12,3+i*2,5+j*12,4+i*2);
           Control := New(PStaticText,Init(R,'│'));
           Insert(Control);
          end;
         for J:=1 to SizeUr do
          begin
           R.Assign(4+(j-1)*12,2+i*2,16+(j-1)*12,3+i*2);
           Control := New(PStaticText,Init(R,'┼───────────'));
           Insert(Control);
           str(c[i,j]:10:10,st);
           R.Assign(6+(j-1)*12,3+i*2,16+(j-1)*12,4+i*2);
           Control := New(PStaticText,Init(R,st));
           Insert(Control);
          end;
        end;
       SelectNext(False);
    end;
   DeskTop^.ExecView(Dialog);
   Dispose(Dialog,Done)
end;


function ClearAUr:boolean;
var i,j:byte;
begin
 if MyMessageBox('Вы уверены, что хотите удалить все коэффициенты ?',nil,0+
   +$0100+$0200) = cmYes
     then
       begin
         for i:=1 to SizeUr do
           for j:=1 to SizeUr do c[i,j]:=0;
         ClearAUr:=true;
       end
     else ClearAur:=false;
end;

function ClearBUr:boolean;
var i:byte;
begin
 if MyMessageBox('Вы уверены, что хотите удалить все свободные члены ?',nil,0+
   +$0100+$0200) = cmYes
     then
       begin
         for i:=1 to SizeUr do c[i,SizeUr+1]:=0;
         ClearBUr:=true;
       end
     else ClearBur:=false;
end;

function jData(i:byte):integer;
var
  Control1,Control2,Control3,Control4,Cont: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data:string[10];
  end;
const
  d:array[1..4] of string[12]=
   ('Сумма','Разность','Произведение','Отношение');
begin
  R.Assign(13,6,65,15);
  Dialog := New(PDialog,Init(R,d[i]+' комплексных чисел'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(21,2,33,3);
     Control1 := New(PInputLine,Init(R,10));
     Insert(Control1);
     R.Assign(2,2,18,3);
     Insert(New(PLabel,Init(R,'Первое число :',Control1)));
     R.Assign(37,2,49,3);
     Control2 := New(PInputLine,Init(R,10));
     Insert(Control2);
     R.Assign(34,2,36,3);
     Insert(New(PLabel,Init(R,'i',Control2)));
     R.Assign(21,4,33,5);
     Control3 := New(PInputLine,Init(R,10));
     Insert(Control3);
     R.Assign(2,4,18,5);
     Insert(New(PLabel,Init(R,'Второе число :',Control3)));
     R.Assign(37,4,49,5);
     Control4 := New(PInputLine,Init(R,10));
     Insert(Control4);
     R.Assign(34,4,36,5);
     Insert(New(PLabel,Init(R,'i',Control4)));
     R.Assign(12,6,24,8);
     Cont := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Cont);
     R.Assign(27,6,39,8);
     Cont := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Cont);
     SelectNext(False);
   end;
  str(j1.x:10:10,Rec.data);
  pInputLine(control1)^.SetData(Rec);
  str(j1.y:10:10,Rec.data);
  pInputLine(control2)^.SetData(Rec);
  str(j2.x:10:10,Rec.data);
  pInputLine(control3)^.SetData(Rec);
  str(j2.y:10:10,Rec.data);
  pInputLine(control4)^.SetData(Rec);
  jData:=1;
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     jData:=0;
     pInputLine(control1)^.GetData(Rec);
     val(Rec.data,j1.x,code);
     if code<>0
      then
       begin
        MyMessageBox('Неверный ввод действительной части первого комплексного числа .',nil,1+$0400);
        jData:=code;
       end;
     pInputLine(control2)^.GetData(Rec);
     val(Rec.data,j1.y,code);
     if code<>0
      then
       begin
        MyMessageBox('Неверный ввод комплексной части первого комплексного числа .',nil,1+$0400);
        jData:=code;
       end;
     pInputLine(control3)^.GetData(Rec);
     val(Rec.data,j2.x,code);
     if code<>0
      then
       begin
        MyMessageBox('Неверный ввод действительной части второго комплексного числа .',nil,1+$0400);
        jData:=code;
       end;
     pInputLine(control4)^.GetData(Rec);
     val(Rec.data,j2.y,code);
     if code<>0
      then
       begin
        MyMessageBox('Неверный ввод комплексной части второго комплексного числа .',nil,1+$0400);
        jData:=code;
       end;
    end;
  Dispose(Dialog,Done);
end;



procedure EnterSizeUr;
var
     Control,Control1: PView;
     R : TRect;
     Dialog : PDialog;
     Rec:record
      size:string[2];
     end;
     i,j:byte;
begin
   R.Assign(24,7,55,15);
   Dialog := New(PDialog,Init(R,'Количество уравнений'));
   with Dialog^ do
    begin
       Flags:=wfClose;
       R.Assign(3,3,15,6);
       Control := New(PRadioButtons,Init(R,
       NewSItem('Два',
       NewSItem('Три',
       NewSItem('Четыри',
       nil)))));
       Insert(Control);
       R.Assign(2,2,14,3);
       Insert(New(PLabel,Init(R,'Количество:',Control)));
       R.Assign(16,3,28,5);
       Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
       Insert(Control1);
       R.Assign(16,5,28,7);
       Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
       Insert(Control1);
       SelectNext(False);
    end;
   pRadioButtons(control)^.sel:=SizeUr-2;
   pRadioButtons(control)^.movedTo(SizeUr-2);
   if DeskTop^.ExecView(Dialog) <> cmCancel
     then
      begin
       SizeUr:=pRadioButtons(control)^.value+2;
       MyMessageBox('При установке нового количества уравнений все данные обнуляются.',nil,2+$0400);
       for i:=1 to SizeUr do
        for j:=1 to SizeUr+1 do c[i,j]:=0;
      end;
   Dispose(Dialog,Done);
end;

function EnterDataAUr1(i,j:byte):integer;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data:string[10];
  end;
  st1,st2:string[1];
begin
  str(i,st1);
  str(j,st2);
  R.Assign(14,7,64,14);
  Dialog := New(PDialog,Init(R,'Ввод данных'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(35,2,47,3);
     Control := New(PInputLine,Init(R,10));
     Insert(Control);
     R.Assign(2,2,34,3);
     Insert(New(PLabel,Init(R,'Уравн.: '+st1+' Коэффициент при Х('+st2+'):',Control)));
     R.Assign(11,4,23,6);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(26,4,38,6);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(c[i,j]:10:10,Rec.data);
  pInputLine(control)^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     pInputLine(control)^.GetData(Rec);
     val(Rec.data,c[i,j],code);
     if code<>0
      then MyMessageBox('Неверный ввод числового значения .',nil,1+$0400);
    end;
  Dispose(Dialog,Done);
 EnterDataAUr1:=code;
end;

function EnterDataBUr1(i:byte):integer;
var
  Control,Control1: PView;
  R : TRect;
  Dialog : PDialog;
  Rec:record
   data:string[10];
  end;
  st1:string[1];
begin
  str(i,st1);
  R.Assign(16,7,63,14);
  Dialog := New(PDialog,Init(R,'Ввод данных'));
  with Dialog^ do
   begin
     Flags:=wfClose;
     R.Assign(33,2,45,3);
     Control := New(PInputLine,Init(R,10));
     Insert(Control);
     R.Assign(2,2,34,3);
     Insert(New(PLabel,Init(R,'Свободный член уравнения: '+st1+' .',Control)));
     R.Assign(10,4,22,6);
     Control1 := New(PButton,Init(R,'Ввод',cmOk,bfDefault));
     Insert(Control1);
     R.Assign(25,4,37,6);
     Control1 := New(PButton,Init(R,'Выход',cmCancel,bfNormal));
     Insert(Control1);
     SelectNext(False);
   end;
  str(c[i,SizeUr+1]:10:10,Rec.data);
  pInputLine(control)^.SetData(Rec);
  if DeskTop^.ExecView(Dialog) <> cmCancel
   then
    begin
     pInputLine(control)^.GetData(Rec);
     val(Rec.data,c[i,SizeUr+1],code);
     if code<>0
      then MyMessageBox('Неверный ввод числового значения .',nil,1+$0400);
    end;
  Dispose(Dialog,Done);
 EnterDataBUr1:=code;
end;

procedure EnterDataAUr;
var
  i,j:byte;
begin
 for i:=1 to SizeUr do
  for j:=1 to SizeUr do
   repeat until EnterDataAUr1(i,j)=0;
end;

procedure EnterDataBUr;
var
  i,j:byte;
begin
 for i:=1 to SizeUr do
   repeat until EnterDataBUr1(i)=0;
end;


END.
