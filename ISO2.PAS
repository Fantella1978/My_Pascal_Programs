Program iso;
   uses Graph;
   var h,l: Real;
       ekv,
       povtor,povtor_1,r,alpha,x,y,int_h,int_l,errST: Integer;
       st_h,st_l: String;
       grDriver,grMode,errCode: Integer;
       grPath: String;

begin
grDriver:=VGA;
grMode:=VGAhi;
grPath:='c:\tp-7\bgi';
InitGraph(grDriver,grMode,grPath);
ErrCode:=GraphResult;
     r:=25;
     povtor_1:=9;
     ekv:=5;
   Line(0,480,r*2+20,480-r);
For povtor:=0 to povtor_1 do
begin
   For alpha:=1 to 360 do
   begin
   l:=r*cos(Pi/180*alpha);
   h:=r*sin(Pi/180*alpha);
   Str(h:2:2,st_h);
   Str(l:2:2,st_l);
   Line(r*2+20,480-r,r*2,480-r);
   if (l<10)and(l>0) then
      begin
       Delete(st_l,2,8);
      end;
   if l<=-100 then
      begin
       Delete(st_l,5,8);
      end;
   if ((l>-100)and(l<-10))or(l>99) then
      begin
       Delete(st_l,4,8);
      end;
   if (l>-10)or((l>=10)and(l<100)) then
      begin
       Delete(st_l,3,8);
      end;
   if (h<10)and(h>0) then
      begin
       Delete(st_h,2,8);
      end;
   if h<=-100 then
      begin
       Delete(st_h,5,8);
      end;
   if ((h>-100)and(h<-10))or(h>99) then
      begin
       Delete(st_h,4,8);
      end;
   if (h>-10)or((h>=10)and(h<100)) then
      begin
       Delete(st_h,3,8);
      end;
   val(st_h,int_h,errST);
   val(st_l,int_l,errST);
   Line(r+int_l,480-r-int_h-(r*2*povtor+ekv*povtor),r+int_l,480-r-int_h-(r*2*povtor+ekv*povtor));
   end;
   Line(r*2,480-r-r*2*povtor-ekv*povtor,r*2+20,460-r-r*2*povtor-ekv*povtor);
   Line(r*2+20,460-r-r*2*povtor-ekv*povtor,r*2+20,480-r-2*r*(povtor+1)-ekv*povtor-ekv);
   if povtor>0 then
      begin
       Line(r*2+20,480-r-povtor*2*r-ekv*povtor,r*2,480-r-povtor*2*r-ekv*povtor);
      end;
end;
end.