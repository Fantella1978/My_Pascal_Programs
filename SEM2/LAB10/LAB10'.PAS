  program lab10;
    uses crt,graph;
    const otsx=60;otsy=60;
     var
      i,k,l,j,m,grdr,grmode,nulx,nuly:integer;
      p,lotsx,lotsy,ismx,ismy:longint;
      x,y1,y2,y3,xn,xk,max,min,hx,hy,n,u,e,crdx,crdy,hx2,hy2:real;
      a: array [1..640] of real;
      t:array [1..100] of string;
      z:array [1..100] of string;
      s0,funct,mx,my,Ox,Oy,v,b:string;
  function y(x:real):real;
   Begin
    y:=x*sin(x);
   End;
  Begin
    funct:='y=sin(x)*x';clrscr;
    write('������ ��砫쭮� ���祭�� X    ');
    readln(xn);
    write('������ ����筮� ���祭�� X     ');
    readln(xk);
    grdr:=detect;
    initgraph(grdr,grmode,'d:\tp7\bgi');
    if graphresult<>0 then halt;
     setfillstyle(SolidFill,7);
     lotsx:=640-otsx;lotsy:=480-otsy;ismx:=lotsx-otsx;ismy:=lotsy-otsy;
      bar(otsx,otsy,lotsx,lotsy);
    if ((xk-xn)>=100) then
     repeat
      xk:=xk/10;xn:=xn/10;n:=n+1;
      until xk<100;
    if (xk-xn)<=1 then
     repeat
      xn:=xn*10;xk:=xk*10;n:=n-1;
     until (xk-xn)<10;str(n:2:0,mx);u:=0;
    if (xk-xn)>10 then
     Repeat
      xk:=xk/2;xn:=xn/2;u:=u+2;
     until (xk-xn)<10;str(u:1:0,v);
     hx:=(xk-xn)/ismx;
     x:=xn;
     max:=a[1];
     min:=a[1];
    while x<xk+0.000001 do
     Begin
      a[i]:=y(x);
      if a[i]>max then
        max:=a[i];
       if a[i]<min then
        min:=a[i];
        x:=x+hx;
        i:=i+1;
     End;

        hy:=(max-min)/ismy;
   {-------------------------- ��� Y ----------------------------------}
          if (xn<0) and (xk<0) then nulx:=ismx else
          if (xn>0) and (xk>0) then nulx:=0 else
          nulx:=round(-xn/hx);
   {-------------------------- ��� X ----------------------------------}
          nuly:=round(max/hy);
         if (xk-xn)<=10 then
          Begin
           k:=round(ismx/(xk-xn));l:=round(ismx/k);
          End
         else
          Begin
           l:=10;
           k:=round(ismx/l);
          End;
         if (max-min)<=8 then
         Begin
          m:=round(ismy/(max-min));j:=round(ismy/m);
         end
         else
          Begin
           j:=8;
           m:=round(ismy/j);
         End;
         k:=round(ismx/(xk-xn))*round((trunc(xk-xn)/(xk-xn)));
         l:=round(ismx/k);
         m:=round(ismy/(max-min))*round((trunc(max-min)/(max-min)));
         j:=round(ismy/m);
         setlinestyle(1,0,1);
   {-------------------------- ��⪠ ----------------------------------}
         i:=0;
         repeat
           line(otsx+nulx+i*k,otsy,otsx+nulx+i*k,lotsy);
           i:=i+1;crdx:=otsx+nulx+i*k;
         until crdx>lotsx;i:=0;
         repeat
           line(otsx+nulx-i*k,otsy,otsx+nulx-i*k,lotsy);
           i:=i+1;crdx:=otsx+nulx-i*k;
         until crdx<otsx;i:=0;
         repeat
           line(otsx,otsy+nuly+m*i,lotsx,otsy+nuly+m*i);
           i:=i+1;crdy:=otsy+nuly+m*i;
         until crdy>lotsy;i:=0;
         repeat
           line(otsx,otsy+nuly-m*i,lotsx,otsy+nuly-m*i);
           i:=i+1;crdy:=otsy+nuly-m*i;
         until crdy<otsy;
           setlinestyle(0,0,3);
           line(otsx+nulx,lotsy,otsx+nulx,otsy-20);
           if u=0 then
           Begin
           outtextxy(lotsx+10,otsy-15+nuly,'X*10');
           outtextxy(lotsx+35,otsy-20+nuly,mx);
           end
           else
           begin
           outtextxy(lotsx+10,otsy-15+nuly,'X,');
           moveto(lotsx+23,otsy-15+nuly);
           outtext(v);outtext('*10');
           outtextxy(lotsx+42,otsy-23+nuly,mx);
           end;
           line(otsx,otsy+nuly,lotsx+10,otsy+nuly);
           hx2:=1;e:=n;
   {---------------------- �����⮢�� �뢮�� ᨬ����� -------------}
          if max>100 then
           repeat
            max:=max/10;min:=min/10;e:=e+1;
           until max<100;str(e:2:0,my);
          if xn<-3 then
          x:=round(xn)+1
          else
          x:=round(xn);
          i:=0;
         while x<xk+0.00001 do
          Begin
           i:=i+1;
           str(x:3:1,t[i]);
           x:=x+hx2;
          End;
           hy2:=1;
           y1:=round(min);i:=0;
         while  y1<max+0.000001 do
          Begin
           i:=i+1;
           str(y1:3:1,z[i]);
           y1:=y1+hy2;
          End;
          line(otsx,otsy+nuly,lotsx+10,otsy+nuly);
          outtextxy(otsx+10+nulx,otsy-20,'Y,10');
          outtextxy(otsx+34+nulx,otsy-28,my);
          setcolor(lightred);
   {------------------- �뢮� ᨬ����� ---------------------------}
          for i:=1 to j+1 do
           Begin
            setcolor(lightred);
            crdy:=5+otsy+nuly+trunc((lotsy-nuly)/m)*m+m-m*i;if crdy<otsy then break;
            if crdy>lotsy then setcolor(0);
            outtextxy(nulx+otsx-12,5+otsy+nuly+trunc((lotsy-nuly)/m)*m+m-m*i,z[i]);
           End;
          for i:=1 to l+1 do
           Begin
            crdx:=nulx+otsx-15-trunc((nulx-otsx)/k)*k+i*k-3*k;
            if crdx>lotsx then break;
            if xn<=-10 then
            outtextxy(nulx+otsx-15-trunc((nulx-otsx)/k)*k+i*k-3*k,otsy+5+nuly,t[i])
            else
            if xn<0 then
            outtextxy(nulx+otsx-15-trunc((nulx-otsx)/k)*k+i*k-2*k,otsy+5+nuly,t[i])
            else
            outtextxy(nulx+otsx-15-trunc((nulx-otsx)/k)*k+i*k-k,otsy+5+nuly,t[i]);
           End;
           if (xn<0) and (xk>0) then
           begin
           y2:=0;
           str(y2:3:1,s0);setfillstyle(SolidFill,7);
           bar(nulx+otsx-25,nuly+otsy+5,nulx+otsx+25,nuly+otsy+15);
           moveto(nulx+otsx-10,nuly+otsy+5);outtext(s0);
           end;
           moveto(otsx,nuly+otsy-round(a[1]/hy));setcolor(1);
   {----------------- �뢮� �p�䨪� -----------------------------}
           for i:=1 to ismx do
            Begin
             lineto(otsx+i,nuly+otsy-round(a[i]/hy));
            End;
            setcolor(lightgreen);settextstyle(2,0,7);
   {------------------- �뢮� �㭪樨 --------------------------}
           moveto(100,450);outtext(funct);
           readln;closegraph;
  End.