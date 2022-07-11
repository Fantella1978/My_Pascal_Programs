 program lab3;
 uses crt;
 var b,c,h,Xn,Xk,y,x:real;
    BEGIN
      clrscr;
      writeln('‚‚…„’… Xn,Xk,h');
      readln(Xn,Xk,h);
      x:=xn;
      while x<=xk do
        begin
       if (x=0) or (x=-0.5) then
         writeln ('p¨ x=',x:4:1,'            y ­¥ αγι¥αβΆγ¥β')
       else
        begin
         if  x<-0.5 then
           y:=1/x
         else
          if  (x<0) and (x>-0.5) then
              y:=1/(x+0.5)
          else
             if x>0 then
                 y:=x+exp(ln(x)/3);
                 writeln('p¨ x=',x:4:1,'            ¥§γ«μβ β=',y:4:1);
       end;
            x:=x+h;
        end;
    END.























