Program opredelitel;
uses crt;
const
 a:array[1..3,1..3]of real=
  ((1,1,0),
   (0,1,1),
   (1,0,1));
 n=3;

Function opred:real;
var k,l,i,j,f,z:byte;
    m1,t,d:real;
begin
  d:=1;
  for k:=1 to n do
   begin
    m1:=0;i:=k;
    while i<=n do
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
       while l<=n do
        begin
         t:=a[j,l];
         a[j,l]:=a[k,l];
         a[k,l]:=t;
         l:=l+1;
        end;
      end;
    f:=k+1;
    while f<=n do
     begin
      t:=a[f,k]/m1;
      z:=k+1;
      while z<=n do
       begin
        a[f,z]:=a[f,z]-t*a[k,z];
        z:=z+1;
       end;
      f:=f+1;
     end;
    d:=d*a[k,k];
   end;
  opred:=d;
 end;

BEGIN
 writeln(opred);
END.