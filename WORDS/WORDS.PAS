Program words;

uses crt,dos;

var
  file1:text;
  st:string;
  LenSt,i,LenWord:byte;
  PoiskString:string;
  PoiskYes:boolean;

procedure PoiskSlov;
begin
  assign(file1,'words.dat');
  reset(file1);
  while not Eof(file1) do
   begin
    ReadLn(file1,st);
    FOR I:=1 TO Length(st) DO
     IF st[i]='-' then
      begin
       LenWord:=i-1;
       break;
      end;
    if LenWord=LenSt then
     begin
      PoiskYes:=True;
      for i:=1 to LenSt do
        if PoiskString[i]<>'?' then
          if st[i]<>PoiskString[i] then PoiskYes:=False;
      if PoiskYes=True then writeln(st);
     end;
   end;
  close(file1);
end;

BEGIN
 if ParamCount<>1
  then
   begin
    Writeln('Пpимеp : Для поиска слова пpимеp набpать WORDS.EXE П??М?Р');
    exit;
   end;
 if ParamCount=1 then
  Begin
   PoiskString:=ParamStr(1);
   LenSt:=length(PoiskString);
   writeln('Поиск : ',PoiskString);
   write('--------');
   for i:=1 to LenSt do write('-');
   writeln;
   PoiskSlov;
  end;
END.
