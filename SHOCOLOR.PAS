Procedure showcolor;
const
  a:array[0..MaxColors]of integer=
   (0,1,2,3,4,5,20,7,56,57,58,59,60,61,62,63);
  c: array[0..MaxColors,1..3] of real =
 ((0,0,0),            {'Black';ColorNum: 0}
  (0,0,40/64),        {'Blue';ColorNum: 1}
  (0,40/64,0),        {'Green';ColorNum: 2}
  (0,40/64,40/64),    {'Cyan';ColorNum: 3}
  (40/64,7/64,7/64),  {'Red';ColorNum: 4}
  (40/64,0/64,40/64), {'Magenta';ColorNum: 5}
  (40/64,30/64,0),    {'Brown';ColorNum: 20}
  (49/64,49/64,49/64),{'Light Gray';ColorNum: 7}
  (26/64,26/64,26/64),{'Dark Gray';ColorNum: 56}
  (0,0,63/64),        {'Light Blue';ColorNum: 57}
  (9/64,63/64,9/64),  {'Light Green';ColorNum: 58}
  (0,63/64,63/64),    {'Light Cyan';ColorNum: 59}
  (63/64,10/64,10/64),{'Light Red';ColorNum: 60}
  (44/64,0,63/64),    {'Light Magenta';ColorNum: 61}
  (63/64,63/64,18/64),{'Yellow';ColorNum: 62}
  (63/64,63/64,63/64) {'White'; ColorNum: 63}
);
var j:integer;
    i:real;
begin
  i:=0;
  while i<63 do
  begin
   for j:=0 to 15 do
   SetRGBpalette(a[j],round(c[j,1]*i),round(c[j,2]*i),round(c[j,3]*i));
   i:=i+2;
  end;
end;
