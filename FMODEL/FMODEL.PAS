Program FModel;

uses Graph,fgraph,fnagr,fconst,FMOD,MsgBox,Menus,Objects,App,Dialogs,
     Views,Drivers,StdDlg;

var
  MyModel:TFModel;

BEGIN
 new(T_1); new(T_2);
 MyModel.init;
 if RegisterBGIfont(@TriplexFontProc) >= 0 then
  if RegisterBGIdriver(@EGAVGADriverProc) >= 0 then MyModel.run
   else MyMessageBox('�訡�� p�����p�樨 �p����p� EGAVGA �����p�.',nil,1+$0400);
 MyModel.done;
 dispose(T_1); dispose(T_2);
END.