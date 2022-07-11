Program iso;
   var h,l,r,alpha: Real;
       i: Integer;
begin
   r:=3.2;
   alpha:=30;
   h:=r*sin(Pi/180*alpha);
   l:=r*cos(Pi/180*alpha);
   Writeln('h=',h:2:2,' l=',l:2:2);
end.