unit MMPlay;
interface
uses getput,crt;
  var p1:pointer;
      size:word;
implementation

begin
 Size:=TextImageSize(1,1,80,25);
 GetMem(p1,size);
 Get_Text(p1^,1,1,80,25);
 window(39,13,42,16);
end.
